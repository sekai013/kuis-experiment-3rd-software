void swap(int *array, int i, int j);
void quicksort(int *array, int left, int right);

int main() {
	int i;
	int data[8];

	data[0] = 4;
	data[1] = 3;
	data[2] = 8;
	data[3] = 1;
	data[4] = 6;
	data[5] = 2;
	data[6] = 7;
	data[7] = 5;

	quicksort(data, 0, 7);

	for (i = 0; i < 8; i = i + 1) {
		print(data[i]);
	}

	return 0;
}

void swap(int *array, int i, int j) {
	int tmp;

	tmp = array[i];
	array[i] = array[j];
	array[j] = tmp;
}

void quicksort(int *array, int left, int right) {
	int pivot, l, r;

	pivot = array[(left + right) / 2];
	l = left;
	r = right;

	while (l < r) {
		while (array[l] < pivot) {
			l = l + 1;
		}
		while (pivot < array[r]) {
			r = r - 1;
		}
		if (l < r) {
			swap(array, l, r);
		}
	}

	if (l - left > 1) {
		quicksort(array, left, l);
	}
	if (right - r > 1) {
		quicksort(array, r, right);
	}
}
