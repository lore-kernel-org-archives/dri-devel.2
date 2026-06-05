Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934CCCD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E577510E4BC;
	Fri,  5 Jun 2026 16:02:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ESKRDJAS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BCEA10E4BC
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:02:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB335601DD;
 Fri,  5 Jun 2026 16:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637381F00893;
 Fri,  5 Jun 2026 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780675373;
 bh=zs3gRL2Jxmh2XLWYcX4fEfvoibonHfyoW/I2JwX2inc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ESKRDJAS32F/VW/1vi7P99mCUToSDleWUi+39NWijUbMzNFVA8B7I4glmGzBBm1Ip
 GhUA0NmlVHSkEpshb4VeRbqHXdgSAzk8W27bEfSTcCM//tV3y/+vNTtPnvjz4ya0ao
 s1pjpk1rNm+N8xXE12gfymNk5oydx9VaKGwnPm1m/WLWLuAE3E+xQkeu/xbUvGC7Pb
 JoBf8587LJGB61midPHyIZFyPxL+McA8ALMR9ftuSRlQuLWYYFPTpHoVL40XD0iQYC
 b17olyomuCL5Z6ghxYCEKVEploiMihsEaB80yR5y4GXL8HoBr+T81tJ/VGu826+Kzs
 UTETLSAAygYoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf: udmabuf: validate create-list count before
 copying
To: "Samuel Moelius" <sam.moelius@trailofbits.com>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
In-Reply-To: <20260605154252.2125942-1-sam.moelius@trailofbits.com>
References: <20260605154252.2125942-1-sam.moelius@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 16:02:53 +0000
Message-Id: <20260605160253.637381F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer overflow in `udmabuf_create()` leads to undersized arr=
ay allocation and a subsequent heap buffer overflow when pinning folios on =
32-bit systems.
- [High] Unprotected initialization of `ubuf->sg` in `begin_cpu_udmabuf` le=
ads to memory leaks and data races.
--

commit a036fc929a16b1c94a5ac12cbef23efece456576
Author: Samuel Moelius <sam.moelius@trailofbits.com>

dma-buf: udmabuf: validate create-list count before copying
   =20
UDMABUF_CREATE_LIST copies a variable-length list using a byte count
derived from head.count. The list_limit module parameter is signed and
writable, so setting it negative lets a large unsigned count bypass the
limit check. The u32 byte-count calculation can then wrap, causing only
a small list to be copied while udmabuf_create() still iterates over the
large count.

Reject negative list_limit values and use checked size_t multiplication
before copying the list.

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index bced421c0d658..264718676d485 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c

[ ... ]

> @@ -469,13 +470,14 @@ static long udmabuf_ioctl_create_list(struct file *=
filp, unsigned long arg)
>  	struct udmabuf_create_list head;
>  	struct udmabuf_create_item *list;
>  	int ret =3D -EINVAL;
> -	u32 lsize;
> +	size_t lsize;
> =20
>  	if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
>  		return -EFAULT;
> -	if (head.count > list_limit)
> +	if (list_limit < 0 || head.count > list_limit)
> +		return -EINVAL;
> +	if (check_mul_overflow(sizeof(struct udmabuf_create_item), head.count, =
&lsize))
>  		return -EINVAL;
> -	lsize =3D sizeof(struct udmabuf_create_item) * head.count;
>  	list =3D memdup_user((void __user *)(arg + sizeof(head)), lsize);
>  	if (IS_ERR(list))
>  		return PTR_ERR(list);

[Severity: Critical]
This is a pre-existing issue, but can the 32-bit addition of subpgcnt wrap
pgcnt?

In udmabuf_create(), list[i].size is a user-controlled __u64 value.
On 32-bit architectures, pgoff_t is a 32-bit unsigned integer:

drivers/dma-buf/udmabuf.c:udmabuf_create() {
    ...
		subpgcnt =3D list[i].size >> PAGE_SHIFT;
		pgcnt +=3D subpgcnt;
		if (pgcnt > pglimit)
			goto err_noinit;
    ...
}

If user space provides two items=E2=80=94one small (e.g., 2 pages) and one =
huge
(e.g., size =3D 0xffffffff000ULL)=E2=80=94subpgcnt truncates to 32 bits and=
 pgcnt can
wrap around to a small positive value. This bypasses the pgcnt > pglimit
check.

init_udmabuf() then allocates arrays sized by the wrapped pgcnt:

drivers/dma-buf/udmabuf.c:init_udmabuf() {
    ...
	ubuf->pages =3D kvmalloc_objs(*ubuf->pages, pgcnt);
    ...
}

Later, udmabuf_pin_folios() calculates a local 32-bit pgcnt =3D 0xffffffff =
and
asks memfd_pin_folios() to pin up to that many folios. If memfd_pin_folios()
returns a large number of folios, udmabuf_pin_folios() unconditionally writ=
es
these kernel pointers into the undersized arrays, resulting in an out-of-bo=
unds
write:

drivers/dma-buf/udmabuf.c:udmabuf_pin_folios() {
    ...
		ubuf->pinned_folios[nr_pinned++] =3D folios[cur_folio];
    ...
			ubuf->pages[upgcnt] =3D folio_page(folios[cur_folio],
						subpgoff >> PAGE_SHIFT);
    ...
}

Could we check for overflow when accumulating pgcnt?

[Severity: High]
This isn't a bug introduced by this patch, but does begin_cpu_udmabuf() hav=
e a
race condition when allocating ubuf->sg?

drivers/dma-buf/udmabuf.c:begin_cpu_udmabuf() {
	if (!ubuf->sg) {
		ubuf->sg =3D get_sg_table(dev, buf, direction);
		if (IS_ERR(ubuf->sg)) {
			ret =3D PTR_ERR(ubuf->sg);
			ubuf->sg =3D NULL;
		} else {
			ubuf->sg_dir =3D direction;
		}
	} else {
    ...
}

The DMA_BUF_IOCTL_SYNC ioctl triggers dma_buf_begin_cpu_access(), which cal=
ls
the exporter's .begin_cpu_access hook (begin_cpu_udmabuf()) with the dma-buf
reservation lock intentionally unlocked (as documented in dma-buf.h).

If two user-space threads invoke DMA_BUF_IOCTL_SYNC concurrently on the same
file descriptor, both can observe !ubuf->sg, allocate separate SG tables, a=
nd
establish duplicate DMA mappings.

The second thread will overwrite the ubuf->sg pointer, leaking the first
allocated SG table and its DMA resources. Concurrent readers could also ope=
rate
on partially written pointers.

Is there a lock we can hold while checking and assigning ubuf->sg?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605154252.2125=
942-1-sam.moelius@trailofbits.com?part=3D1
