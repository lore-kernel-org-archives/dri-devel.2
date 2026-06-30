Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F0BC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 03:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17EEC10E03D;
	Tue, 30 Jun 2026 03:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P1/zxu9H";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 173FB10E03D
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 03:58:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B89DB43237;
 Tue, 30 Jun 2026 03:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714271F000E9;
 Tue, 30 Jun 2026 03:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782791894;
 bh=j4dg3TMcYPRed2er4g6FG9rlpt5IcjePUEUcwUvB3ic=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P1/zxu9H/Q17Ql17Yjqktj/7o5TVU3Ky10vSJTRxXwh5HzU7IoTfMGB+3RdPwmY/W
 Dhx882PvP4qDRpd1cFsJwwzPteO67vH3tTTtt7lrDCCYaU3gN0a3HD1mjm+F20lAzU
 Vj+sBOdzeGo7B/+TVbBDMD41J6lluo4SmLRxbpFJui3T/HXHCqcsK9UHtfDXKMdOBc
 iTGhsEM93+atVn37L5jSkpJiJL0YtJhRxUUg+tgAYGTUjrBmfwxQcYGXqv3hyYidsK
 5m8apnF7A3ULJJBOQRLBLMPw5xyk8Llo9EMrZzAANiCRlYBYVaEtDzTt7pqz8I+JAS
 Jf613QnaN2XhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/5] drm/gpusvm: move struct drm_gpusvm_pages out of
 struct drm_gpusvm_range
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630033132.361144-5-honghuan@amd.com>
References: <20260629022921.17533-1-honghuan@amd.com>
 <20260630033132.361144-1-honghuan@amd.com>
 <20260630033132.361144-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 03:58:13 +0000
Message-Id: <20260630035814.714271F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Device memory mappings created via `dpagemap->ops->device_map()` a=
re permanently leaked on the error path of `drm_gpusvm_get_pages()`.
--

commit 5200250940d89eac5e1be4b8695f694419586335
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: move struct drm_gpusvm_pages out of struct drm_gpusvm_range

This patch separates physical pages from the MM VA range in the DRM GPU SVM
framework. It moves the drm_gpusvm_pages object out of drm_gpusvm_range,
allowing drivers to directly manage MM and device physical pages. The range
level wrappers are replaced with helpers that operate directly on a driver
owned pages object.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index b0e9a2db10803..e0fd0b2fcc5ee 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c

[ ... ]

> @@ -1638,29 +1695,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  }
>  EXPORT_SYMBOL_GPL(drm_gpusvm_get_pages);

[Severity: High]
This is a pre-existing issue, but does this error path permanently leak
device memory mappings?

If drm_gpusvm_get_pages() maps the first part of a memory range using
device_map(), but then hits a page with a different pagemap (or crosses a
zone device data boundary):

drivers/gpu/drm/drm_gpusvm.c:drm_gpusvm_get_pages() {
    ...
    if (pagemap !=3D page_pgmap(page)) {
        if (pagemap) {
            err =3D -EOPNOTSUPP;
            goto err_unmap;
        }
    ...
}

It jumps to err_unmap before svm_pages->dpagemap is set.

When it calls __drm_gpusvm_unmap_pages() to clean up:

drivers/gpu/drm/drm_gpusvm.c:__drm_gpusvm_unmap_pages() {
    ...
    else if (dpagemap && dpagemap->ops->device_unmap)
        dpagemap->ops->device_unmap(dpagemap, dev, addr);
    ...
}

Because dpagemap evaluates to NULL on this error path, device_unmap() is
skipped, which appears to leak the previously mapped resources.

Could a local user repeatedly trigger this error path to exhaust device or
IOMMU resources?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630033132.3611=
44-1-honghuan@amd.com?part=3D4
