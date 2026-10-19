Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6DC607D349
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KriKRCsO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A1F10EDAE;
	Mon, 19 Oct 2026 15:36:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A7410EDAE
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:36:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0D194130C
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C3A1F0283C;
 Mon, 19 Oct 2026 15:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792424171;
 bh=lnMdTb4dTfE2bqPVrYgGnuHj2kv3PdxK6FL2B1Gh+lo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KriKRCsOUwblz00xZN22h3lN5xXRcx+tC8/En8n0wmPe1JS0rr/w/NPG7doVtH5iJ
 eBgwU7U7zgGtf9mof3ojEJEtPpcIUZX+lrKIeuCscIhLnPJ/sGIP5R/PqhqD2v7WgO
 3bMQe/Jn58+CPX14eojIjHd6TUTiFKU0WhrL+fn72hseu+NmDM3h4UYuRYwaW4xgPT
 QTahfDIRDgxZxYgDymwtPhhZVSnlWs8h8oSU8oMcZLD0bUF3XgWYQqzOD1yJs55Hsz
 A58DuyIufPRFmIAQqpyKakKA1cQWFY8YrT6YUHLCRZJY/2lCtGHJDOcI7l40KGIOCD
 Hn7GgvTOwGHlA==
Message-ID: <sashiko-outbox-177766@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] drm/amdkfd: add sanity check in
 svm_range_is_valid
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-503-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-503-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:36:11 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/amdkfd: left-shift overflow of start and size in svm_range_is_=
valid()
--

commit 0feea440041a7f2032b2a5a7f211d24baae6cfb4
Author: Eric Huang <jinhuieric.huang@amd.com>

drm/amdkfd: add sanity check in svm_range_is_valid

This commit adds zero-size and addition-overflow checks in
svm_range_is_valid() to prevent SVM range calculations from overflowing or
underflowing.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index 74a1d3e1d52be..0c81be3cd87e3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3398,7 +3398,13 @@ svm_range_is_valid(struct kfd_process *p, uint64_t=
 start, uint64_t size)
>  	unsigned long start_unchg =3D start;
> =20
>  	start <<=3D PAGE_SHIFT;
> -	end =3D start + (size << PAGE_SHIFT);
> +
> +	if (size =3D=3D 0)
> +		return -EINVAL;
> +
> +	if (check_add_overflow(start, size << PAGE_SHIFT, &end))
> +		return -EOVERFLOW;

[Severity: High]
Can start <<=3D PAGE_SHIFT and size << PAGE_SHIFT still overflow 64-bit
unsigned integers and truncate the upper PAGE_SHIFT bits before
check_add_overflow() runs?

While kfd_ioctl_svm() right-shifts byte-aligned start_addr and size by
PAGE_SHIFT before calling svm_ioctl(), the CRIU restore and resume path
copies raw 64-bit page numbers directly from userspace in
kfd_criu_restore_svm():

drivers/gpu/drm/amd/amdkfd/kfd_svm.c:kfd_criu_restore_svm() {
	...
	ret =3D copy_from_user(&criu_svm_md->data, user_priv_ptr + *priv_data_offs=
et,
			     svm_priv_data_size);
	...
}

and passes them unshifted in kfd_criu_resume_svm() -> svm_range_set_attr()
-> svm_range_is_valid():

drivers/gpu/drm/amd/amdkfd/kfd_svm.c:kfd_criu_resume_svm() {
	...
		ret =3D svm_range_set_attr(p, mm, criu_svm_md->data.start_addr,
					 criu_svm_md->data.size, num_attrs + 1,
					 set_attr);
	...
}

If size has upper PAGE_SHIFT bits set (for example, (1ULL << 52) + 1 on
4KB pages), size << PAGE_SHIFT wraps to PAGE_SIZE, so svm_range_is_valid()
only validates 1 page while svm_range_set_attr() passes the untruncated
64-bit size to svm_range_add().

Similarly, if start has upper PAGE_SHIFT bits set (for example,
(1ULL << 52) + valid_pfn with size =3D 1), start <<=3D PAGE_SHIFT wraps to a
valid VMA address and svm_range_check_vm(p, start_unchg,
(end - 1) >> PAGE_SHIFT, NULL, NULL) sees start_unchg > last so
interval_tree_iter_first() returns NULL. When svm_range_set_attr() then
creates prange with the untruncated prange->start and calls
svm_range_validate_and_map():

drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_validate_and_map() {
	...
		if (!r) {
			offset =3D (addr >> PAGE_SHIFT) - prange->start;
			r =3D svm_range_dma_map(prange, ctx->bitmap, offset, npages,
					      hmm_range->hmm_pfns);
	...
}

offset underflows and causes out-of-bounds array indexing (addr +=3D offset)
in svm_range_dma_map_dev().

Should svm_range_is_valid() also check check_shl_overflow() on start and
size (or reject start and size values with upper PAGE_SHIFT bits set)?

> +
>  	do {
>  		vma =3D vma_lookup(p->mm, start);
>  		if (!vma || (vma->vm_flags & device_vma))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-503-sashal@kernel.org?part=3D1
