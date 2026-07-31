Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7F5C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E8510E23C;
	Fri, 31 Jul 2026 17:09:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="G5JjoY6T";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED8810E23C
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 17:09:44 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-698b78c05b0so133a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 10:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785517782; cv=none;
 d=google.com; s=arc-20260327;
 b=IwplehZVk+Fviuz+B+ZnEkSNdvZXc0MRoak9W6rej2QbfJm7J6y62zIxSzfRDhVifg
 r2msSR/RE5rgGTlTNTEln7M/G5mbfDZxetwQNw/CTBAI8zRlWRCE+1jkH9rR7vc6FMtO
 4q3gnES3pI43eHDDGTNWBRBjY5XBKDXcgHWIYavjwyXWd0GJwpRZ/O97Ni6fQq9EsTRB
 CeVee3mWAmWu7jlxuM4d2u+SHswmp9MZI9SsUKmKzxL7AXcdqa6MW55i5V3MqQxtzNhi
 H5shzcjUJZU2le5EwWOM3n3NJV79g/vN30qqxv7xZmVTcjGtCvTdIq5DmB4i1jNwDtVv
 t3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dAd7HPjjkQI/SIGWOZj/gTVuJd8LLOcZPRtgUcY8yWU=;
 fh=DPxuKWfVOI0Cm/jBrw4ETCnTR53d6cM8nM7Einav044=;
 b=ToO7jmwT/0g2REv3pfpvTTWBc9oNWgdbmUqpq176Lh4VnpkNWdGR5NHUiDBC/0DqNw
 qGwFpD0sUSVU/EM1PcMeb66ufIRC+IUxAKggKk4bSj1+o1qsvKhg2NXL6RU+nxqEZReH
 ZeKcHy/deO5ZKPE2jlsjhSmxHzGd/9Aw9omBSuh0Iis5Rzm3c8wHH/3NxL/I6YMXzezg
 9COZ6nIhgyIwdNV4CkddfMDamvET8k94evMxB11BsQFQmQLDDn1Thw02BxJoqBJZ4xI5
 dMgCfvUuZX0TehF9f9AOeTNtShX+Z/UMMHkAK9g4IeLvYGlhDu2pHAA7zAt+zCGJK07l
 xugA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785517782; x=1786122582;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dAd7HPjjkQI/SIGWOZj/gTVuJd8LLOcZPRtgUcY8yWU=;
 b=G5JjoY6TI2dyvIlkpYGo7ZNe0dVana7klXMpf+AjGCJ2c0+zfA/n0xI76i77EctdJ4
 78Y5L/aaAedbVvEpZ6tm9Q9KBCjjgia/QVfCdkVjwbDZGDIsoz3Sto0/UHRDa+KODr2Y
 00hVk8dVG3lBHhSMLIGxqb+GPVNHCmbXuC+d9fd69hEU9BiEi+wOPdkjpUzUXeZkGKP4
 B/il3dPmpLIe3MZFpCHFYwD2uh92ozL/DRd0YDaiaVwrQGYE81zyJrf7FJmxMG/jsIcY
 46Yxoxr71+fVZOzxoL0QpClo0TwdoIjV6fBS83oCQ/SeQDufFJk55U5QYwzT/1BNVQYV
 f/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785517782; x=1786122582;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dAd7HPjjkQI/SIGWOZj/gTVuJd8LLOcZPRtgUcY8yWU=;
 b=X/Ykc84OdzeNkY1r2LF6FQsIa+Sx8AJwebpj4X4+iLsKbcU6x0xrQJ4apgUlXQFXfU
 /aK8UShMOVejKgP2hAqrfnN8aZoUhdMD6PpEdQO7rIPkRXtz67FNxtXN8NNpUMa9Ln2Y
 4HJEdkezppQHmnTAn+pagTk1i96SkZi7RKqLCqmOUYIB4hdAq9r6sO8qZ0R1Imy5XDWW
 LmolU71d3Rli878jJv3mhpfiTAAEh/S1U/jueNGNI4tLPY6HIdkRuod4LsmLhVFuuDJO
 kUdh2gkOfWn6A7DrKNo7eapkBhTRBnmSbsZZ2idJERTBfbw+tOtE0U3wCsXE2gsu0wsI
 V6FA==
X-Forwarded-Encrypted: i=1;
 AHgh+RojKTi6jc0Fun6AYflWNQnLvjHbhgO1xqwUdyuMuy49+GIhPkJpVoVsPBdt2LwMFii6HI2/tcN4hrI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzl2ea0mG3pSz9Ct8imDic5v20eQw5c0QXXYN1NM5uxCCtjAIfo
 lvOAy9afpYOVyM9xlvS7knaGu3Tbfm+hWe/LF3i6BuxUhc+Aq4gSvgqFppYNur+dh9YYjoLQPvJ
 nu5F0udmW6t+xAR8bpjYO+gIxFACO9Lz7tl65uGE7
X-Gm-Gg: AR+sD11iONaAx3+oxBd2FrIKNxRP/O4rQs3hFuk1WCi0IAclfh6ubLHcHo9sT5w5d4E
 2R1J9FvTah2K0W/Ym/zigSDU/Ib3//bGSc2NxPdibf8DOU5CA1Pcpq2jZ1lDsF7OHSXFwo8y/WK
 fKE5LOGj6SqCnc9TxuakMH0kRpwDqP1nGh2QfTVO9ZbvqZQel/IADCsziF9lLlKO995oKVbTJVy
 q0EyloS7UPMI+Z+LGMFj/52hkPz0/fFwZI/iG8bCkyynf34bZVGlIzcOWDGonLj34RoVMBnq0xn
 g2r03174Rdt2xZts+LOHJZ1Y9fEUU/UtwURs9HmPUZ0moymzgz27LDKGzC77AnbEbG9qxiFTzW8
 =
X-Received: by 2002:a05:6402:2026:b0:698:59af:fb08 with SMTP id
 4fb4d7f45d1cf-6a0a84739a5mr1867a12.4.1785517781953; Fri, 31 Jul 2026 10:09:41
 -0700 (PDT)
MIME-Version: 1.0
References: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
 <20260730062645.233148-1-shoubaineng@gmail.com>
 <20260730062645.233148-5-shoubaineng@gmail.com>
In-Reply-To: <20260730062645.233148-5-shoubaineng@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 31 Jul 2026 10:09:29 -0700
X-Gm-Features: AUfX_mx3Qaq7BDuII8fTCRVTL26nO0JrgnBnCyuW4BamF3HcDjaGYhRibygRVek
Message-ID: <CABdmKX1bd4qsTqM5C+a83TmtgBKJ=nOefuhNr-SnyqAZMsh99w@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAULT
 regression test
To: Baineng Shou <shoubaineng@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, Sandeep Patil <sspatil@android.com>, 
 "Andrew F . Davis" <afd@ti.com>, Srinivas Kandagatla <srini@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Jul 29, 2026 at 11:27=E2=80=AFPM Baineng Shou <shoubaineng@gmail.co=
m> wrote:
>
> Add a test case that verifies no file descriptor is leaked when
> DMA_HEAP_IOCTL_ALLOC succeeds internally but copy_to_user() fails
> to deliver the fd number back to userspace.
>
> The failure is triggered by placing the ioctl argument in a private
> anonymous page and flipping it to PROT_READ (via mprotect) between
> the kernel's copy_from_user() and copy_to_user() calls.  With the
> buggy kernel the ioctl returns -EFAULT but leaves an extra open fd
> in the process's fd table; with the fixed kernel the fd count is
> unchanged.
>
> This serves as a regression test for:
>   "dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds"
>
> Suggested-by: Sumit Semwal <sumit.semwal@linaro.org>
> Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
> ---
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 115 +++++++++++++++++-
>  1 file changed, 114 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index fc9694fc4e89..bd58e5b06c8b 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -390,6 +390,118 @@ static void test_alloc_errors(char *heap_name)
>         close(heap_fd);
>  }
>
> +/*
> + * test_alloc_no_fd_leak_on_efault - verify no fd is leaked when
> + * copy_to_user() fails during DMA_HEAP_IOCTL_ALLOC.
> + *
> + * The bug: dma_buf_fd() called fd_install() before copy_to_user().
> + * If copy_to_user() then failed (e.g. via mprotect), the fd was
> + * silently installed in the fd table but never returned to userspace.
> + *
> + * The fix: reserve the fd with get_unused_fd_flags() first, attempt
> + * copy_to_user(), and only call fd_install() on success.
> + *
> + * We trigger the failure by placing the ioctl argument in a page,
> + * flipping it to PROT_READ between copy_from_user and copy_to_user,
> + * and counting open file descriptors before and after.
> + */
> +static void test_alloc_no_fd_leak_on_efault(char *heap_name)
> +{
> +       int heap_fd =3D -1;
> +       int fd_before, fd_after;
> +       int ret;
> +       long page_size;
> +       struct dma_heap_allocation_data *req;
> +
> +       ksft_print_msg("Testing no fd leak when copy_to_user() fails:\n")=
;
> +
> +       heap_fd =3D dmabuf_heap_open(heap_name);
> +
> +       page_size =3D sysconf(_SC_PAGESIZE);
> +
> +       /*
> +        * Place the ioctl argument in its own private anonymous page so
> +        * we can flip its protection independently.
> +        */
> +       req =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> +                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +       if (req =3D=3D MAP_FAILED) {
> +               ksft_test_result_fail("mmap failed: %s\n", strerror(errno=
));
> +               goto out;
> +       }
> +
> +       memset(req, 0, sizeof(*req));
> +       req->len      =3D page_size;
> +       req->fd_flags =3D O_RDWR | O_CLOEXEC;
> +
> +       /* Count open fds before the ioctl */
> +       fd_before =3D 0;
> +       {
> +               DIR *d =3D opendir("/proc/self/fd");
> +               struct dirent *de;
> +
> +               if (!d) {
> +                       ksft_test_result_fail("opendir /proc/self/fd: %s\=
n",
> +                                             strerror(errno));
> +                       munmap(req, page_size);
> +                       goto out;
> +               }
> +               while ((de =3D readdir(d)))
> +                       if (de->d_name[0] !=3D '.')
> +                               fd_before++;
> +               closedir(d);
> +               /* subtract the fd opened by opendir itself */

But no actual subtraction?

> +       }
> +
> +       /*
> +        * Make the page read-only: copy_from_user() in the kernel will
> +        * still succeed (it already ran),

Huh? copy_from_user hasn't run yet. That happens inside the ioctl().

>            but copy_to_user() that writes
> +        * the fd number back will fault.
> +        */
> +       mprotect(req, page_size, PROT_READ);
> +
> +       ret =3D ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, req);
> +
> +       /* Re-allow writes so munmap can clean up */
> +       mprotect(req, page_size, PROT_READ | PROT_WRITE);
> +       munmap(req, page_size);
> +
> +       if (ret !=3D -1 || errno !=3D EFAULT) {

This looks like you meant &&, but I think we should just fail if ret
!=3D -1. Either the mprotect is broken, or dma-heap didn't actually try
to copy_to_user.

> +               /*
> +                * If the ioctl didn't fail with EFAULT, either the kerne=
l
> +                * handled it differently or mprotect raced.

mprotect is synchronous, how could it race with anything here?

>                   Skip rather
> +                * than giving a false pass/fail.
> +                */
> +               ksft_test_result_skip(
> +                       "ioctl did not return EFAULT (ret=3D%d errno=3D%d=
), skipping\n",
> +                       ret, errno);
> +               goto out;
> +       }
> +
> +       /* Count open fds after the failed ioctl */
> +       fd_after =3D 0;
> +       {
> +               DIR *d =3D opendir("/proc/self/fd");
> +               struct dirent *de;
> +
> +               if (!d) {
> +                       ksft_test_result_fail("opendir /proc/self/fd: %s\=
n",
> +                                             strerror(errno));
> +                       goto out;
> +               }
> +               while ((de =3D readdir(d)))
> +                       if (de->d_name[0] !=3D '.')
> +                               fd_after++;
> +               closedir(d);
> +       }
> +
> +       ksft_test_result(fd_before =3D=3D fd_after,
> +                        "no fd leak on EFAULT: before=3D%d after=3D%d\n"=
,

This is for the failure case, so I don't think the "no" should be in the st=
ring.

> +                        fd_before, fd_after);
> +out:
> +       close(heap_fd);
> +}
> +
>  static int numer_of_heaps(void)
>  {
>         DIR *d =3D opendir(DEVPATH);
> @@ -420,7 +532,7 @@ int main(void)
>                 return KSFT_SKIP;
>         }
>
> -       ksft_set_plan(11 * numer_of_heaps());
> +       ksft_set_plan(12 * numer_of_heaps());
>
>         while ((dir =3D readdir(d))) {
>                 if (!strncmp(dir->d_name, ".", 2))
> @@ -435,6 +547,7 @@ int main(void)
>                 test_alloc_zeroed(dir->d_name, ONE_MEG);
>                 test_alloc_compat(dir->d_name);
>                 test_alloc_errors(dir->d_name);
> +               test_alloc_no_fd_leak_on_efault(dir->d_name);
>         }
>         closedir(d);
>
> --
> 2.34.1
>
