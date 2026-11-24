Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13FB606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QGpvSOgF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B5610F0E7;
	Tue, 24 Nov 2026 22:25:29 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C5010E214
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 22:25:22 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb6860f867so202375e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:25:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795559121; cv=none;
 d=google.com; s=arc-20260327;
 b=N5B9eq6c4ZGhNuHfjR7syIllfqQ44NEdAh2aHWcNLPo1m6tScg9HaDos47xiSL8K04
 mNPxFRTSUnjWaEblqVraqswIjG1uK7NTftULuJWIsxdYyADemZKSvFHnOwshF+34xswZ
 IaWtVRNCTvOBqxUm3wFrLAm1Exu/oWTinc8otHOj5Xn6IRlqGZAp9Iuxi1L8gOJQ1ipI
 EFeoF3RZ5q6yZfYodZ1O0WMrbwTHoXVgqL+ihtwhXwaXpEYEiq7MtXiCpSYVsIcImbHv
 z7YUu5SUlOqgsCfh26CbinGctC5zzeQkAFjSIZWWPcdQAijcHxFQ+llgJ1JwwbsNGua8
 hOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EAJKFMsoiiC78zOtAoZbxgMl0cT/7CbdsqUgXu3XoJ8=;
 fh=0G+KAH08QPrF8PGCc66GcALZoe9VSGLh18WCiOT2jdc=;
 b=DtsM+ta8Ta+a/mVHoljs1qCsiqwcwZ0k+7x0k3dc19MDlH5dwPt3wYj4X+am55tXqX
 9KX97RUKWnugrrwOXFAzAEgQWOCgW1LKOdLFthy6oSsHdDqsn4OnTpUTX9hjJiFa5bKk
 T9iq03qJwwCl1zbcRWBNPO1BimFx9yg6wHSk4/GjLyrBsugG7+lV+aXAMx4iRAvq2/nI
 rF3LHRpAGM8QPLjpaC07Onr1AEeFAvLDfoE9uB6trvQu7Xk6EsxfgH2Px4+4xcAjTAs5
 SRe4yOm1EpgHuPt9gegBJKe/TFfEIcRFYSSI4Bmz7r9W4TAiFj4bE+VGl2gErqMrxeo9
 5abA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795559121; x=1796163921;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EAJKFMsoiiC78zOtAoZbxgMl0cT/7CbdsqUgXu3XoJ8=;
 b=QGpvSOgFI4gJc/FhwFXqcyZp6XhNzbJVcT2ra3ogMrz+uvVGl/qvCW80REIYxSHGXU
 2XdLXwmcUXwHL8jSqF4DwgKvk4BFJ2eFfWE+M97qn5P/v76czbcwG49HzuKLWdJ9Ee9o
 KxXfwlFKxkemDIL0nTY5qzYizaCnbjyyew2GmeFg179B8hEOx75s2ap+R2b++nh6+05d
 KIE+mewPlQ58AwTmlPx59JyJJnHqw9V/P2rzEL8sTWvF6hBa5Qa4JH8VWHMib9wjj0au
 IZgdOIrBcb7bSIL3CvjZu1mfRT6a3Gv8o7+jBAHJ/8Wt7QSs4HCUnOjF/2hllrmxavMk
 wy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795559121; x=1796163921;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EAJKFMsoiiC78zOtAoZbxgMl0cT/7CbdsqUgXu3XoJ8=;
 b=ZkXNO2ncChSKe2qr3V8YUVz263TPjgnM6M2ov9ln+7TLmyH4PPGT3tK4gCmnCA9QYR
 ChoFgW/WiJ90RcN9GrcQZvMaL/RG8a1XP/7SN1tK3HHJU1D+49/FbzqSKwp2BNJtUdXJ
 sXCa9cjmsoQf6M6Tn9AMzNc/EnxTdDk5btWNhWRhaKE1RH8DnZYUiDdAySqKCzu/N0Sc
 IvhRV8JWF5humFM4wWG/7nu/XzWQST15Mlna7PYgcnDQL54lVPwfIUpNN9tYD1LNV43X
 6PEWOUvw3XG+6MC/eGXSdDN+k2P+r3QE8DZv367oM5S2QyCIuKutvnjbsbHUByAtFuJs
 0X+A==
X-Forwarded-Encrypted: i=1;
 AL+hErFMMgBQT3KZKL/Wj2XEasfKsLSqHxp+tYuQH/eDUyJFVxoBRKrk8ZDZLRkb1lCFT96Qnl38F0b1Jpk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+2XPV7RzAmLajqn/prW+Uf9CdWSh/2+f+of35w5VK6Ar20ZtIx
 AZfVNNldo2ra5ZBVO7QylnQqWzw2gAHR12HK4n1UGsFdn9e19nsITknfc+XAff18/WLvGt4pZJF
 H1bJC+mzjI9xR21rurM3brY1Gv0F3X+I5RtjFKmAc
X-Gm-Gg: AZFdTZeQ+B75LWA0HCEuHV7F9CuOcftRF0yfuQt84w6evn3XJFAbArWuKhcbXme2TaT
 K1AiBNk4GbPCZNbw6pUws+pJ+4PJoyJ84io8QpYU5YHtHwgYsLim55q7yNDUvjTGmVLhaAjd3zQ
 Vjg6IWYa5D6Q5pxI0zwP3mKbCKzAt7813vztXp+o8iEXvTlOpjmx8Sa/sb6/0a+B2mO3UO/DO3A
 DkHrz1a2KCJz3jJ5uXrQlOLT3KY1F1WqHUknwvipmVOmxbOIIOamb2w8N5zRR8z2Iqv7HTy2orL
 HyV9pbI/SB7qxWIMbgspp4eNXGpIjm7Adih8erFUk6K1lRpKIRW/fzBDhCpTaM6kn2YHjoKXIVx
 HdurycoW/hcugMVXLQc7QRg2vmB5ECZ/MinoWf+hyXZPBARxkMxBbzFxGrI72M1kmgZ6ZXoOJAq
 dEsZzKV1xne1yAsG/iR0nY+Gqv9whilCGgG6s3x/NHy1w=
X-Received: by 2002:a05:600c:2059:b0:4bb:5a90:8ca4 with SMTP id
 5b1f17b1804b1-4bb9163dd1amr2975305e9.12.1795559120990; Tue, 24 Nov 2026
 14:25:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123-feat-udmabuf-huge-pfnmap-v2-0-3254f801fc36@linux.dev>
 <20261123-feat-udmabuf-huge-pfnmap-v2-3-3254f801fc36@linux.dev>
In-Reply-To: <20261123-feat-udmabuf-huge-pfnmap-v2-3-3254f801fc36@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 24 Nov 2026 14:25:09 -0800
X-Gm-Features: Aa3M54pp6bpRCS8AG4iCULQJGiNccxTku4hoCoX4iAQklO5C46N0ugppOSxDFeI
Message-ID: <CABdmKX3EAHhwSWG+kJrNmyMuCF7uY4rdR6=B8hXX=TFaz==4uw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftests/udmabuf: test mapping a huge page backed
 udmabuf
To: Qiliang Yuan <qiliang.yuan@linux.dev>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Shuah Khan <shuah@kernel.org>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Philip Yang <Philip.Yang@amd.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Natalie Vock <nat@pixelcluster.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 6:45=E2=80=AFPM Qiliang Yuan <qiliang.yuan@linux.de=
v> wrote:
>
> udmabuf maps the ranges of a buffer that are backed by huge pages with
> PMDs, provided the mapping covers whole PMDs at an aligned address.
>
> The existing tests of huge page backed buffers only map a few pages, so
> they never get a PMD mapping or check what is read through one.
>
> Map a 64 MiB udmabuf backed by 2 MiB huge pages and read back what was
> written to the memfd, with a different pattern in each huge page: through
> a mapping of the whole buffer, which must be PMD aligned for a 64-bit
> task when THP support is built in, through a mapping at an unaligned
> offset, and from a forked child that inherits the mapping of the whole
> buffer.
>
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
> ---
>  tools/testing/selftests/drivers/dma-buf/udmabuf.c | 97 +++++++++++++++++=
+++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/te=
sting/selftests/drivers/dma-buf/udmabuf.c
> index d78aec662586b..6eaef1b3aee01 100644
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
> @@ -130,6 +131,98 @@ static int compare_chunks(void *addr1, void *addr2, =
off64_t memfd_size)
>         return ret;
>  }
>
> +#define HPAGE_SIZE     (2UL << 20)

This isn't true on 16k or 64k PAGE_SIZE arm64. Can we read
hpage_pmd_size for the PMD alignment and Hugepagesize: from
/proc/meminfo for the MFD_HUGETLB backing size?

> +#define HUGE_BUF_SIZE  (32 * HPAGE_SIZE)

I think we only really need 8 of these for the sub-range test, and
this gets huge for 16k or 64k base pages.

> +/* Check that @len bytes mapped at @addr match @mem at @off */
> +static bool check_huge_mapping(char *addr, char *mem, off_t off, size_t =
len)
> +{
> +       size_t i;
> +
> +       for (i =3D 0; i < len; i +=3D getpagesize()) {
> +               if (addr[i] !=3D mem[off + i])
> +                       return false;
> +       }
> +       return true;
> +}
> +
> +/* Check that @len bytes of @buf at @off read back what was written to @=
mem */
> +static bool check_huge_range(int buf, char *mem, off_t off, size_t len)
> +{
> +       char *addr;
> +       bool ok;
> +
> +       addr =3D mmap(NULL, len, PROT_READ, MAP_SHARED, buf, off);
> +       if (addr =3D=3D MAP_FAILED)
> +               return false;
> +
> +       ok =3D check_huge_mapping(addr, mem, off, len);
> +       munmap(addr, len);
> +       return ok;
> +}
> +
> +/*
> + * Map a udmabuf backed by 2MB huge pages, which can be mapped with PMDs=
, and
> + * read it back from a PMD-aligned address, a sub-range at an unaligned =
offset
> + * and a forked child that inherits the mapping.
> + */
> +static void test_huge_mapping(int devfd)
> +{
> +       struct udmabuf_create create =3D {};
> +       int memfd, buf, status;
> +       bool thp, aligned, ok;
> +       char *mem, *addr;
> +       pid_t pid;
> +       size_t i;
> +
> +       memfd =3D create_memfd_with_seals(HUGE_BUF_SIZE, true);
> +       mem =3D mmap_fd(memfd, HUGE_BUF_SIZE);
> +       /* Give each huge page its own pattern */
> +       for (i =3D 0; i < HUGE_BUF_SIZE; i +=3D getpagesize())
> +               mem[i] =3D (char)(i / getpagesize() + i / HPAGE_SIZE);
> +
> +       create.memfd =3D memfd;
> +       create.size =3D HUGE_BUF_SIZE;
> +       buf =3D ioctl(devfd, UDMABUF_CREATE, &create);
> +       if (buf < 0) {
> +               ksft_test_result_fail("%s: [FAIL,test-8]\n", TEST_PREFIX)=
;
> +               ksft_test_result_skip("%s: [SKIP,test-9]\n", TEST_PREFIX)=
;
> +               goto out;
> +       }
> +
> +       /* The address is only aligned for 64-bit tasks with THP support =
*/
> +       thp =3D sizeof(long) =3D=3D 8 &&
> +             !access("/sys/kernel/mm/transparent_hugepage", F_OK);
> +       addr =3D mmap(NULL, HUGE_BUF_SIZE, PROT_READ, MAP_SHARED, buf, 0)=
;
> +       aligned =3D addr !=3D MAP_FAILED &&
> +                 (!thp || !((unsigned long)addr % HPAGE_SIZE));
> +       ok =3D aligned && check_huge_mapping(addr, mem, 0, HUGE_BUF_SIZE)=
;
> +       if (ok)
> +               ksft_test_result_pass("%s: [PASS,test-8]\n", TEST_PREFIX)=
;
> +       else
> +               ksft_test_result_fail("%s: [FAIL,test-8]\n", TEST_PREFIX)=
;
> +
> +       ok =3D check_huge_range(buf, mem, HPAGE_SIZE + getpagesize(),
> +                             5 * HPAGE_SIZE + 3 * getpagesize());

We should probably also have a test with create.offset =3D getpagesize()
to exercise the misaligned PFN fallback.

Also a test that faults a PMD, then disables THP and then faults
elsewhere to cover the v1 bug.
