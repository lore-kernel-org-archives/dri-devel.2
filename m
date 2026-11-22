Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9AE606A32C
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hg8k0GN8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80DA510E454;
	Sun, 22 Nov 2026 07:56:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E297E10E454
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:56:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 659F060ED9;
 Sun, 22 Nov 2026 07:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13451F000CA;
 Sun, 22 Nov 2026 07:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795334202;
 bh=lBiM1P9Knvc6jWklVxMBQdcihE/i4+UMPCavoo1Yg3U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hg8k0GN8MzLz8Sk/8eUeN69fnVMEBJ3RZVux8KY+HdEuCN7AfSJK/v5sGTLKxrzlQ
 dBtMMHjNQdOlfHoBheZ8dzxLnpOxr0jFN8FarObduwjTfD5HtZrdO9qn2fp4rL0LJ4
 CjyzjTpUZLJrL56BYceOrOEcgse1DeU1humd1RxPZobru6Uv7iULYpSi+DcgkAWLPW
 Fv3JGb+FGKgXmZZkkhR2KovsRoehv1NxvDhBH/Ikp0IrvoWY9ZlcqWHbDNMW8fw0Y2
 7rF1K5fXGdwd7uSZ9zpRhUU/s/CEdz75Djg2YsE4nfi9a4BDvo2lzUH3D7FFzAnSW7
 5S5t2SU+UkVwA==
Message-ID: <sashiko-outbox-227804@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] selftests/udmabuf: test mapping a huge page backed
 udmabuf
To: "Qiliang Yuan" <qiliang.yuan@linux.dev>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261122-feat-udmabuf-huge-pfnmap-v1-3-dcba888940c2@linux.dev>
References: <20261122-feat-udmabuf-huge-pfnmap-v1-0-dcba888940c2@linux.dev>
 <20261122-feat-udmabuf-huge-pfnmap-v1-3-dcba888940c2@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 07:56:41 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] selftests/udmabuf: test_huge_mapping() does not inherit
  mapping across fork()
- [Low] selftests/udmabuf: periodic data pattern in test_huge_mapping()
  repeats per PMD
- [Low] selftests/udmabuf: false failure in test_huge_mapping() on
  32-bit tasks
--

commit c9830236dc0b56e59510003d91e0bc32e9d198ca
Author: Qiliang Yuan <qiliang.yuan@linux.dev>

selftests/udmabuf: test mapping a huge page backed udmabuf

This commit adds a selftest that maps a 64 MiB udmabuf backed by 2 MiB huge
pages and verifies reading it back across whole-buffer, unaligned-offset,
and forked-child cases.

> diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/te=
sting/selftests/drivers/dma-buf/udmabuf.c
> index d78aec662586b..e09330fece6fb 100644
> --- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> +++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> @@ -14,6 +14,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/syscall.h>
>  #include <sys/mman.h>
> +#include <sys/wait.h>
>  #include <linux/memfd.h>
>  #include <linux/udmabuf.h>
>  #include "kselftest.h"
> @@ -130,6 +131,91 @@ static int compare_chunks(void *addr1, void *addr2, =
off64_t memfd_size)
>  	return ret;
>  }
> =20
> +#define HPAGE_SIZE	(2UL << 20)
> +#define HUGE_BUF_SIZE	(32 * HPAGE_SIZE)
> +
> +/* Check that @len bytes of @buf at @off read back what was written to @=
mem */
> +static bool check_huge_range(int buf, char *mem, off_t off, size_t len)
> +{
> +	char *addr;
> +	size_t i;
> +	bool ok =3D true;
> +
> +	addr =3D mmap(NULL, len, PROT_READ, MAP_SHARED, buf, off);
> +	if (addr =3D=3D MAP_FAILED)
> +		return false;
> +
> +	for (i =3D 0; i < len; i +=3D getpagesize()) {
> +		if (addr[i] !=3D mem[off + i]) {
> +			ok =3D false;
> +			break;
> +		}
> +	}
> +
> +	munmap(addr, len);
> +	return ok;
> +}
> +
> +/*
> + * Map a udmabuf backed by 2MB huge pages, which can be mapped with PMDs=
, and
> + * read it back from a PMD-aligned address, a sub-range at an unaligned =
offset
> + * and a forked child.
> + */
> +static void test_huge_mapping(int devfd)
> +{
> +	struct udmabuf_create create =3D {};
> +	int memfd, buf, status;
> +	bool thp, aligned, ok;
> +	char *mem, *addr;
> +	pid_t pid;
> +	size_t i;
> +
> +	memfd =3D create_memfd_with_seals(HUGE_BUF_SIZE, true);
> +	mem =3D mmap_fd(memfd, HUGE_BUF_SIZE);
> +	for (i =3D 0; i < HUGE_BUF_SIZE; i +=3D getpagesize())
> +		mem[i] =3D (char)(i / getpagesize());

[Severity: Low]
Does casting (i / getpagesize()) to char make every 2 MiB huge page contain
identical data?  Because the 8-bit pattern repeats every 256 base pages (1
MiB on 4 KiB page systems), all 32 huge pages have the same contents, so
check_huge_range() cannot detect if udmabuf maps the wrong huge page or
ignores the HPAGE_SIZE offset.

> +
> +	create.memfd =3D memfd;
> +	create.size =3D HUGE_BUF_SIZE;
> +	buf =3D ioctl(devfd, UDMABUF_CREATE, &create);
> +	if (buf < 0) {
> +		ksft_test_result_fail("%s: [FAIL,test-8]\n", TEST_PREFIX);
> +		ksft_test_result_skip("%s: [SKIP,test-9]\n", TEST_PREFIX);
> +		goto out;
> +	}
> +
> +	/* The address is only aligned when THP support is built in */
> +	thp =3D !access("/sys/kernel/mm/transparent_hugepage", F_OK);
> +	addr =3D mmap(NULL, HUGE_BUF_SIZE, PROT_READ, MAP_SHARED, buf, 0);
> +	aligned =3D addr !=3D MAP_FAILED &&
> +		  (!thp || !((unsigned long)addr % HPAGE_SIZE));

[Severity: Low]
Can this alignment check fail when the test is built as a 32-bit binary?

Even when /sys/kernel/mm/transparent_hugepage exists,
__thp_get_unmapped_area() skips PMD alignment for 32-bit and compat tasks:

mm/huge_memory.c:__thp_get_unmapped_area() {
	if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())
		return 0;
    ...
}

Because mmap() falls back to page alignment in that case, test-8 will
falsely fail whenever the returned address is not 2 MiB aligned.

> +	if (addr !=3D MAP_FAILED)
> +		munmap(addr, HUGE_BUF_SIZE);
> +	ok =3D aligned && check_huge_range(buf, mem, 0, HUGE_BUF_SIZE);
> +	if (ok)
> +		ksft_test_result_pass("%s: [PASS,test-8]\n", TEST_PREFIX);
> +	else
> +		ksft_test_result_fail("%s: [FAIL,test-8]\n", TEST_PREFIX);
> +
> +	ok =3D check_huge_range(buf, mem, HPAGE_SIZE + getpagesize(),
> +			      5 * HPAGE_SIZE + 3 * getpagesize());
> +	pid =3D fork();
> +	if (!pid)
> +		_exit(check_huge_range(buf, mem, 0, HUGE_BUF_SIZE) ? 0 : 1);

[Severity: Medium]
Does the forked child ever read an inherited udmabuf mapping across fork()?

Both the initial alignment check and check_huge_range() call munmap() before
returning, so the parent has no active udmabuf VMA when fork() runs.  Calli=
ng
check_huge_range() in the child creates a fresh mmap() after fork() rather
than exercising fork() page-table duplication (such as copy_huge_pmd()) on
an existing PMD-mapped udmabuf VMA.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-feat-udmab=
uf-huge-pfnmap-v1-0-dcba888940c2@linux.dev?part=3D3
