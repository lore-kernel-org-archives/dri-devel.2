Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEE1C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 697E010E7F7;
	Mon, 17 Aug 2026 14:15:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Kdo45Njn";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 86BDB10E7F7
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:15:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F5AA1655;
 Mon, 17 Aug 2026 07:14:58 -0700 (PDT)
Received: from [10.57.6.69] (unknown [10.57.6.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DAFF3F85F;
 Mon, 17 Aug 2026 07:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1786976102; bh=3FrCSDVH+vnWFUu3cCVJoHMTZPjySWcFqVaZGk22emk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Kdo45Njn0LFjQY0djnis2i1yHjVNPHcOa8NIjK0Pm39bDk9MZlivIaOKYTkf+0j1I
 aeu2VUsceOpxgCuXSuZoZA8PMGf8dWl3lkQ8Ui9TVzjxuUS13kKcMMpW063fpdWNME
 s+itT3D/nqeQTLqjvlgJfkgQAvSZ48R08e2oP+2E=
Message-ID: <486fe609-a649-4750-a424-64fa52346e01@arm.com>
Date: Mon, 17 Aug 2026 15:14:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: add Mali-G68 support
To: markuss.broks@gmail.com, Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, =?UTF-8?Q?Adri=C3=A1n_Larumbe?=
 <adrian.larumbe@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260803-staging-mainline-v1-1-5071dc782149@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260803-staging-mainline-v1-1-5071dc782149@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 03/08/2026 10:35, Markuss Broks via B4 Relay wrote:
> From: Markuss Broks <markuss.broks@gmail.com>
> 
> Add the features, issues, and ID for Mali-G68, a first-generation
> (v9) Valhall GPU.
> Tested on Exynos8835: the GPU reports GPU_ID 0x9204 (G68 r1p1).
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

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
> 
> 

