Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449AAC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7085710E526;
	Tue, 28 Jul 2026 16:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="X7F1CWr4";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1AE610E26E;
 Tue, 28 Jul 2026 16:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785254414; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VJ/Ys2n2idxa9DeE7Elcm3rdGP4aKbYalwlnTnGnD67wkfKNXNiJaOLc3Z8ACgqos+EqMkyK4zde4+62MMxdJXaG8Z6OSGiQLnATuW4ZnAFgUBHfIInCNFczY0MOI80Uu+/HAvucqCweaqkNYZPgaXkoCwH/5x9qxs4sK0FdvUM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785254414;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=MKSs8V8xEad3wbRJ3mAheDw7Gq/v7n7rYNezjuMA6u0=; 
 b=GzA05aVnuHON6tt/3isHXpxi0poX1uVtvOmCnUov9slklRd2bI+eGPUvPFGZxOEfV3fcq8pVv7ChR4bF1hZTLdy/sriwgZRw2Q8zhQ/7iB/uehvIjCpiZe+D6TI92o/OuByM+u1l+szD+XCA1Nq7t2NZVr7Kci/tV/BnJVCiRT0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785254414; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=MKSs8V8xEad3wbRJ3mAheDw7Gq/v7n7rYNezjuMA6u0=;
 b=X7F1CWr4MS0cGRrL7RKwK6udPNJDR0NVTqlzZ+5OxRQsmz36XeQYED4pOYS+A/ij
 cOQ4DOTnbf5bjB9BHew0vSDD7sAaAwR6abM+LHSpxVr02Zv4Re1xfbkpMfPwjb4TPX7
 5bZjxhwRPNvl17lbz1puT3v5vqQlOrflxCXXq5Z8=
Received: by mx.zohomail.com with SMTPS id 1785254413281562.7239675255581;
 Tue, 28 Jul 2026 09:00:13 -0700 (PDT)
Message-ID: <b8c34576-9bc9-4d56-9408-f47b44b4aac5@collabora.com>
Date: Tue, 28 Jul 2026 18:00:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] drm/amd/display: Add fixed matrix colorop to
 color pipeline
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-7-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260722134607.136293-7-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Harry,

I tested this on my laptop using my Weston branch at [1] with 
color-management being disabled, meaning the new implementation is used 
as a drop-in replacement for the legacy properties - no further 
color-ops being used. The results between offloading to plane and 
GL-renderer where visually indistinguishable. Thus

Tested-by: Robert Mader <robert.mader@collabora.com>

1: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2157

On 22.07.26 15:46, Harry Wentland wrote:
> Insert a fixed matrix colorop as the first operation in the
> amdgpu color pipeline, before the existing DEGAM 1D curve. This
> allows userspace to select YUV-to-RGB conversion via the color
> pipeline for YCbCr framebuffers.
>
> The fixed matrix colorop advertises support for all six YUV-to-RGB
> conversion presets:
>    - YUV601/709/2020 full-range to RGB
>    - YUV601/709/2020 limited-range to RGB
>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 27 ++++++++++++++++++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |  1 +
>   2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> index 056a76b88f43..1ed12cdce317 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> @@ -55,6 +55,14 @@ const u64 amdgpu_dm_supported_blnd_tfs =
>   	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
>   EXPORT_IF_KUNIT(amdgpu_dm_supported_blnd_tfs);
>   
> +const u64 amdgpu_dm_supported_fm =
> +	BIT(DRM_COLOROP_FM_YCBCR601_FULL_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR601_LIMITED_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR709_FULL_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR709_LIMITED_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB);
> +
>   #define MAX_COLOR_PIPELINE_OPS 10
>   
>   #define LUT3D_SIZE		17
> @@ -73,6 +81,23 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
>   
>   	memset(ops, 0, sizeof(ops));
>   
> +	/* Fixed Matrix (YUV to RGB) */
> +	ops[i] = kzalloc_obj(*ops[0]);
> +	if (!ops[i]) {
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	ret = drm_plane_colorop_fixed_matrix_init(dev, ops[i], plane, &dm_colorop_funcs,
> +						  amdgpu_dm_supported_fm,
> +						  DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +	if (ret)
> +		goto cleanup;
> +
> +	list->type = ops[i]->base.id;
> +
> +	i++;
> +
>   	/* 1D curve - DEGAM TF */
>   	ops[i] = kzalloc_obj(*ops[0]);
>   	if (!ops[i]) {
> @@ -86,7 +111,7 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
>   	if (ret)
>   		goto cleanup;
>   
> -	list->type = ops[i]->base.id;
> +	drm_colorop_set_next_property(ops[i - 1], ops[i]);
>   
>   	i++;
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
> index 77364d954d3b..7802efa5312d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
> @@ -30,6 +30,7 @@
>   extern const u64 amdgpu_dm_supported_degam_tfs;
>   extern const u64 amdgpu_dm_supported_shaper_tfs;
>   extern const u64 amdgpu_dm_supported_blnd_tfs;
> +extern const u64 amdgpu_dm_supported_fm;
>   
>   int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list);
>   

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

