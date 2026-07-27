Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F38C53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA5310E64A;
	Mon, 27 Jul 2026 17:06:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eQKAQIYq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C1410E4AA
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:06:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B1A6E60A59;
 Mon, 27 Jul 2026 17:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8A21F00A3A;
 Mon, 27 Jul 2026 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785172014;
 bh=g87WMwuws+VANruMejxcqQAAkoeK94qaInNTk/9P8MM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eQKAQIYqzxRloI9oceYUuvwMrQQnljrJzDOdNP+OkpXVimLYUyuINC0mNOcXsOvHZ
 rxFpNjUphykN/lmBJkJCNFlQjqvS4t//ozsCjcbckpsuAK6RIkVsMkK8zNCdYk8dqx
 PLc1do8DGPY0qAlOfWeJ9M4DSuLO8mcKrziexe7MLhKjBHdtr5Vdn5l8/C/3eaLTJF
 CSXRl+wuurylRUSj/sfOIqa5LUs+P/rDVV8CDgQkOpJ4LOeEsG3dh6Rp6U9cD2ydau
 Wa+TM4RzioY0BbmAsC4jxCdv+Ckbusf/mw7cF9bS/ZshI2jkndw1utJxF+HrcIjzd9
 P4RaKxLtIEKXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/11] xen: use hw_pte_t for PTE range callbacks
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, damon@lists.linux.dev
In-Reply-To: <20260727164715.2866609-12-usama.anjum@arm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-12-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 17:06:53 +0000
Message-Id: <20260727170654.1B8A21F00A3A@smtp.kernel.org>
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
- [Critical] Missing VMA boundary checks in privcmd_ioctl_mmap_resource all=
ows arbitrary page table overwrites.
- [High] User-triggerable BUG_ON in alloc_empty_pages via multiple privcmd =
ioctls on the same VMA.
--

--- Patch [11]: [PATCH RFC 11/11] xen: use hw_pte_t for PTE range callbacks=
 ---
commit f1d3c6242b9edd333d296aa7d48a89b6d4261d91
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

xen: use hw_pte_t for PTE range callbacks

This commit updates generic PTE range and remapping helpers in Xen drivers=
=20
to use hw_pte_t * for PTE table storage pointers, replacing pte_t *. It=20
retains logical PTE access via existing helpers.

[ ... ]
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index 725a49a0eee72..b4a487dcc9ecb 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -1658,7 +1658,7 @@ static int privcmd_mmap(struct file *file, struct v=
m_area_struct *vma)
>   * on a per pfn/pte basis. Mapping calls that fail with ENOENT
>   * can be then retried until success.
>   */
> -static int is_mapped_fn(pte_t *pte, unsigned long addr, void *data)
> +static int is_mapped_fn(hw_pte_t *pte, unsigned long addr, void *data)
>  {
>  	return pte_none(ptep_get(pte)) ? 0 : -EBUSY;
>  }

[Severity: High]
This is a pre-existing issue, but can a user trigger a kernel panic via
multiple ioctls on the same VMA?

Looking at drivers/xen/privcmd.c, privcmd_ioctl_mmap_resource()=20
unconditionally calls alloc_empty_pages() which contains a BUG_ON:

privcmd_ioctl_mmap_resource() {
    ...
		rc =3D alloc_empty_pages(vma, nr);
		if (rc < 0)
			goto out;
    ...
}

alloc_empty_pages() {
    ...
	BUG_ON(vma->vm_private_data !=3D NULL);
	vma->vm_private_data =3D pages;
    ...
}

If a user maps /dev/xen/privcmd and calls IOCTL_PRIVCMD_MMAP_RESOURCE twice
with the same mapped address, will the second call trigger this BUG_ON and
cause a local denial of service?

[Severity: Critical]
This isn't a bug introduced by this patch, but does
privcmd_ioctl_mmap_resource() miss VMA boundary checks that could allow
arbitrary page table overwrites?

Looking at privcmd_ioctl_mmap_resource() in drivers/xen/privcmd.c:

	vma =3D find_vma(mm, kdata.addr);
	if (!vma || vma->vm_ops !=3D &privcmd_vm_ops) {
		rc =3D -EINVAL;
		goto out;
	}

Since find_vma() only verifies that vma->vm_end > kdata.addr, does this
allow a caller to pass a size (num) that extends far beyond the end of the
VMA?=20

If so, could the subsequent calls to xen_remap_domain_mfn_array() or=20
xen_remap_vma_range() (which use apply_to_page_range()) overwrite PTEs of=20
adjacent VMAs with Xen foreign memory mappings?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727164715.2866=
609-1-usama.anjum@arm.com?part=3D11
