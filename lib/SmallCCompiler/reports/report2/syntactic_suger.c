int main() {
	int i, arr[8];

	for (i = 0; i < 8; i = i + 1) {
		arr[i] = i;
	}

	*(&arr[1] + 1) = -1;

	return 0;
}
