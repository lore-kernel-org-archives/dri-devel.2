Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9910BC5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F95B10E273;
	Fri, 21 Aug 2026 08:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DrP8GlUd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE6D889BE
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 08:30:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 64CF64115E;
 Fri, 21 Aug 2026 08:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6911F000E9;
 Fri, 21 Aug 2026 08:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787301050;
 bh=bHBzId0p7+/y3i6iv1V/F0eGvcvoT8QbpZpSg6q9v9g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DrP8GlUdE7AdN1Ukc2OqFz7Hf1lku/5VUwIFEeDUEPm+vSG1HJjdXiiUta1GZsEP9
 XegnoycmHTafUPacG4luC/u7Gw3LTtxDt7esa65fI5sQFzF78/QHHtgajzqzhfnorS
 3mxX8lvq8EinQs12km7Dzdkq40LYPGE4MPmlKkSrT6m7G6yCxb5FyNAi0w7ewY1Eqr
 67HkN4tOBDSknCM2ygN2qn7ulPqFGLhCX2sHMuTbGYr1f5uaa7I81xkaa3B/7qSiOj
 4vfN9UYuYlAcOIaXydnCSdQ5o8LcyJI/pG+8LFmq6DtFhHE+c328Z4XiZJ9AxWGlG2
 bin5NXJcMYPzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/adreno: Only check for PAS when a zap shader is
 present
To: "Paul Hollinsky" <phollinsky@holtechnik.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821081325.89088-1-phollinsky@holtechnik.com>
References: <20260821081325.89088-1-phollinsky@holtechnik.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 08:30:49 +0000
Message-Id: <20260821083050.1D6911F000E9@smtp.kernel.org>
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
- [High] The device node 'np' acquired via `of_get_available_child_by_name(=
)` is never released with `of_node_put()`, causing a reference count leak. =
This patch makes the leak repeatedly reachable from userspace.
- [High] Unchecked return value from `kasprintf()` leads to a NULL pointer =
dereference and kernel panic.
--

--- Patch [1]: [PATCH] drm/msm/adreno: Only check for PAS when a zap shader=
 is present ---
commit 84273d207b58c12797426ab6b4931f54563e7fed
Author: Paul Hollinsky <phollinsky@holtechnik.com>

drm/msm/adreno: Only check for PAS when a zap shader is present

This commit moves the qcom_pas_is_available() check from
adreno_zap_shader_load() into zap_shader_load_mdt() after checking for the
presence of a zap-shader node. This prevents a permanent -EPROBE_DEFER on
boards that lack PAS and don't need a zap shader.

Link: https://lore.kernel.org/r/20260808034716.58888-1-phollinsky@holtechni=
k.com

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index 489462065ea95..995161215ad56 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -52,6 +52,12 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, co=
nst char *fwname,
>  		return -ENODEV;
>  	}
> =20
> +	/* We need PAS to be able to load the firmware */
> +	if (!qcom_pas_is_available()) {
> +		DRM_DEV_ERROR(dev, "PAS is not available\n");
> +		return -EPROBE_DEFER;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but does this new error return path leak the
device node reference for np?

of_get_available_child_by_name() increments the reference count of the
returned device node, which needs to be released with of_node_put().

It appears zap_shader_load_mdt() completely lacks any of_node_put() calls
on its exit paths. Because this patch moves the qcom_pas_is_available()
check after the node lookup, a failure here returns -EPROBE_DEFER and leaves
the node refcounted.

As noted in the commit message, since GPU initialization is re-attempted on
every DRM open() syscall, could this allow an unprivileged user to
continuously leak the device node reference count from userspace?

[ ... ]

While reviewing this patch, I also noticed another pre-existing issue in
zap_shader_load_mdt() further down in the file:

[Severity: High]
This is a pre-existing issue, but does this code lead to a NULL pointer
dereference if the memory allocation fails?

drivers/gpu/drm/msm/adreno/adreno_gpu.c:zap_shader_load_mdt() {
...
		char *newname;

		newname =3D kasprintf(GFP_KERNEL, "qcom/%s", fwname);

		ret =3D qcom_mdt_load(dev, fw, newname, pasid,
				mem_region, mem_phys, mem_size, NULL);
		kfree(newname);
...
}

kasprintf() is called with GFP_KERNEL and can return NULL if the memory
allocation fails.

The resulting newname pointer is passed immediately as the fw_name argument
to qcom_mdt_load() without a NULL check.

Since the pointer is passed down the call chain:
qcom_mdt_load() -> qcom_mdt_load_no_init() -> qcom_mdt_read_metadata() ->
mdt_load_split_segment() -> strlen(fw_name)

Will passing NULL to strlen() cause a kernel panic here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821081325.8908=
8-1-phollinsky@holtechnik.com?part=3D1
