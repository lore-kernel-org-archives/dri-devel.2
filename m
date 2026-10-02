Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726A1CA5FE3
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 23:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B213F10E055;
	Fri,  2 Oct 2026 23:20:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="ZYHN0urZ";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49ABF10E055
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 23:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790983203; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dE6JIISAhjlmGvUnCmDL3f0lJw2RGxXk6VMWheaZ3C2aiCp+ebulITgiUlebGe1mcBqEBcpNe2glW+m0TyM408qGFl0pGth3aa/FnLhFkFK8TERNzEe+v6LtFgSJMd45j6lh+wlYm7o0T+FswoPOOablPaCu0tvlY94MwJYwN5w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790983203;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DLkFz/5sZpW9b+wdDVOWJEoQTEsK8SzJC8tjZVqLs14=; 
 b=DzpCOW2LbHUYTiPo1KNZaPaOPrKqbjPgrk3nm1K50g2cKjavQULBEJsfpiqi56jxSBsWhZjEo0sTBE/BKohP0VW6dXtv/9tVOc4hlPWAUqF8HuOeWdbX1N8Lg7uVrHf0d4GN22LFSSuYzgdDciZhmvAWOMYK4bmfOBQL67ioTIM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790983199; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=DLkFz/5sZpW9b+wdDVOWJEoQTEsK8SzJC8tjZVqLs14=;
 b=ZYHN0urZ+bkss5sC+6UQQBewcXijF8TJBB57sM4lTxCxHnhRs6xG5VLv+9OHHmlu
 YV7PoRfYvv9pvw7asqYPN598/2MJzTunNWkxsF6JTDG6sfT1u/IPje9esgPJpK7LxVc
 R2bg7MnfyvYqoHlYXcuTR/3m6A0ON6TwUnqOtq3o=
Received: by smtp.zohomail.com with SMTPS id 1790983199051394.2695663621121;
 Fri, 2 Oct 2026 16:19:59 -0700 (PDT)
Date: Sat, 3 Oct 2026 00:19:55 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: markuss.broks@gmail.com
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: add Mali-G68 support
Message-ID: <asA6VefBKQQD3eSH@sobremesa>
References: <20260803-staging-mainline-v1-1-5071dc782149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260803-staging-mainline-v1-1-5071dc782149@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.975.46
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

Queued to drm-misc-next.

One thing though, I had to adjust the indentation of the GPU_REV() macro before merging.
Not a big deal, but always make sure to run the following in your branch before submission:

./scripts/checkpatch.pl --strict --git first_commit~..HEAD

Also, I suppose you didn't have a chance to test it on a g68_r1p0. That would be of interest
because of HW_ISSUE_TTRX_3485, which seems to mandate the submission of a dummy job before
any real further work. It seems at the moment there's no such a workaround either in the
UM Mesa driver or the Panfrost KMD.

Maybe Steven or Boris could elaborate on this?

On 03.08.2026 12:35, Markuss Broks via B4 Relay wrote:
> From: Markuss Broks <markuss.broks@gmail.com>
> 
> Add the features, issues, and ID for Mali-G68, a first-generation
> (v9) Valhall GPU.
> Tested on Exynos8835: the GPU reports GPU_ID 0x9204 (G68 r1p1).
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_features.h | 2 ++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c      | 3 +++
>  drivers/gpu/drm/panfrost/panfrost_issues.h   | 8 ++++++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_features.h b/drivers/gpu/drm/panfrost/panfrost_features.h
> index 52f9d69f6db9..34c65847192f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_features.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_features.h
> @@ -121,6 +121,8 @@ enum panfrost_hw_feature {
>  	BIT_ULL(HW_FEATURE_IDVS_GROUP_SIZE) | \
>  	BIT_ULL(HW_FEATURE_CLEAN_ONLY_SAFE))
>  
> +#define hw_features_g68 hw_features_g57
> +
>  static inline bool panfrost_has_hw_feature(struct panfrost_device *pfdev,
>  					   enum panfrost_hw_feature feat)
>  {
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index 7d555e63e21a..83223192a544 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -242,6 +242,9 @@ static const struct panfrost_model gpu_models[] = {
>  	/* MediaTek MT8188 Mali-G57 MC3 */
>  	GPU_MODEL(g57, 0x9093,
>  		GPU_REV(g57, 0, 0)),
> +
> +	GPU_MODEL(g68, 0x9004,
> +		GPU_REV(g68, 1, 0), GPU_REV(g68, 1, 1)),
>  	{0},
>  };
>  
> diff --git a/drivers/gpu/drm/panfrost/panfrost_issues.h b/drivers/gpu/drm/panfrost/panfrost_issues.h
> index eb60cb83667a..dd39946bb572 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_issues.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_issues.h
> @@ -265,6 +265,14 @@ enum panfrost_hw_issue {
>  #define hw_issues_g57_r0p0 (\
>  	BIT_ULL(HW_ISSUE_TTRX_3485))
>  
> +#define hw_issues_g68 (\
> +	BIT_ULL(HW_ISSUE_TTRX_2968_TTRX_3162))
> +
> +#define hw_issues_g68_r1p0 (\
> +	BIT_ULL(HW_ISSUE_TTRX_3485))
> +
> +#define hw_issues_g68_r1p1 0
> +
>  static inline bool panfrost_has_hw_issue(const struct panfrost_device *pfdev,
>  					 enum panfrost_hw_issue issue)
>  {
> 
> ---
> base-commit: 415606a7be939835db9b0d6b711887586646346d
> change-id: 20260803-staging-mainline-ebe89543b632
> 
> Best regards,
> --  
> Markuss Broks <markuss.broks@gmail.com>



Adrian Larumbe
