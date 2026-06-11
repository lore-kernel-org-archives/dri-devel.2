Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F361CD8CB2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0275910E230;
	Thu, 11 Jun 2026 06:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZZtcenBJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E88110E230
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 06:03:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 95EE642DEB;
 Thu, 11 Jun 2026 06:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E141F00893;
 Thu, 11 Jun 2026 06:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781157801;
 bh=Wlo/7P2R+LTX4L6bNgQZWSBlw+WYDGGXsbbUIxpLHBQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZZtcenBJfbOVL9hgZerSP7xn3AFGsuEqWZ4K6uFGVBfQ5l6KfVTsByBbR/vDacSo9
 KlzeU5tEdIx0hIHb2q5LzUVy209h3/gCcGH6N7IJA7Ba1F+opegXFJAaqY/6I2Ya18
 pwhxOlOGeCIDM3e3dG8yiubF0N8YyiLBm1JHovK30gBS3H7Fa6nbRShBOVh2kyrNQI
 I39DicWjKnYJXwpv2jRTqOZQPYtZV1/PlQ5cgbHl6lp7g+hfC48Utqu4C4pfR+/1ru
 ucqqcitQQU3R9CpuoOBeRP3soeQngkUhE/AqAcrYlftL7BcK87Bk16RiagNWZMJRU+
 Zbe/mwJ8k5GsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 3/3] accel/amdxdna: Fix iommu domain lifetime race
 during device removal
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611055150.3070216-3-lizhi.hou@amd.com>
References: <20260611055150.3070216-3-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 06:03:20 +0000
Message-Id: <20260611060321.53E141F00893@smtp.kernel.org>
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
- [High] Delaying iommu_detach_group() to the DRM release action prevents d=
river rebind while the DRM device is kept open by userspace.
--

commit 873614c426570f83392d242f0aa4d39f76d04bd7
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix iommu domain lifetime race during device removal

This commit fixes a use-after-free race during device removal by moving
the freeing of the iommu domain to a drm managed release action. This
ensures the domain lifetime is maintained by the DRM subsystem until all
managed resources are released.

> diff --git a/drivers/accel/amdxdna/amdxdna_iommu.c b/drivers/accel/amdxdn=
a/amdxdna_iommu.c
> index eff00131d0f80..4f245b969eef1 100644
> --- a/drivers/accel/amdxdna/amdxdna_iommu.c
> +++ b/drivers/accel/amdxdna/amdxdna_iommu.c

[ ... ]

> @@ -153,10 +154,30 @@ void amdxdna_iommu_free(struct amdxdna_dev *xdna, s=
ize_t size,
>  	free_pages((unsigned long)cpu_addr, get_order(size));
>  }
> =20
> +static void amdxdna_cleanup_force_iova(struct drm_device *dev, void *res)
> +{
> +	struct amdxdna_dev *xdna =3D to_xdna_dev(dev);
> +
> +	if (xdna->domain) {
> +		iommu_detach_group(xdna->domain, xdna->group);

[Severity: High]
Does delaying iommu_detach_group() to the drm managed release action
prevent driver rebind if userspace holds the DRM file descriptor open?

If a user holds the fd open after the device is unbound via sysfs, the
hardware IOMMU group will stay attached to the domain until the file is
finally closed. If the device is subsequently re-bound, or bound to
vfio-pci, iommu_attach_group() in the new probe would return -EBUSY
because the group is already attached.

Should iommu_detach_group() execute synchronously during amdxdna_remove(),
while only deferring iommu_domain_free() and the IOVA state to this release
action?

> +		put_iova_domain(&xdna->iovad);
> +		iova_cache_put();
> +		iommu_domain_free(xdna->domain);
> +	}
> +
> +	iommu_group_put(xdna->group);
> +}
> +
> +void amdxdna_iommu_fini(struct amdxdna_dev *xdna)
> +{
> +	if (xdna->group && !xdna->domain)
> +		iommu_group_put(xdna->group);
> +}

[Severity: High]
Because amdxdna_iommu_fini() now skips putting the IOMMU group when a
domain exists, does this intentionally defer releasing the group until the
drmm release action runs?

This contributes to the same rebind failure mentioned above, as the
resource is locked for the duration of the open userspace file descriptor.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611055150.3070=
216-1-lizhi.hou@amd.com?part=3D3
