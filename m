Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD09CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9183B10EFDE;
	Wed, 17 Jun 2026 13:53:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="cj96wZ+7";
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="uEIE0U+u";
	dkim-atps=neutral
X-Greylist: delayed 447 seconds by postgrey-1.36 at gabe;
 Wed, 17 Jun 2026 13:53:09 UTC
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 391F210EFDE
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 13:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1781703938; bh=HeGNJOmo8KEarrPjWiaHIv5
 MiTqcwKdtANPH9jARSdw=; b=cj96wZ+7ns9kEvMH3BZ5X3mGYyPBVk6eq0nlxXLJIP/TJ0USZH
 ZDtoj7btFB7C1Lae82f7dRJKbHhZEGQZgwAQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1781703938; bh=HeGNJOmo8KEarrPjWiaHIv5
 MiTqcwKdtANPH9jARSdw=; b=uEIE0U+u/WQsHwBycCxA0Q5UEgHSIgca3oJwUh4HwDAYxBTiW5
 zG7obW5zv6z9YX1JjeAh5YYcPUo47tKuzICeL0d4fAls9fhdBom6j9WaFeosc0yhvBjHn6fZWm8
 SlLjRkYvFYGztItGC4/v9WwMJcskBl/YvKGf9vBCkbXxz6/2pf7Jbs39e9nl7R3ntB3XiwXaodN
 BhdBURHROIEdu2I1//xvBYGbaZXjPdC9e+AzZCMuQtRqKJ8GcAJAgVOA1PzSNHNrtJ9hof0oE1H
 /yqXz2hvZcG3+hocEroMH/SAJIfA6F+XWOakvRCmvA20ngej3ZzXzllJmZ5ybNJPJSA==;
Message-ID: <de08e4f5-dad1-441c-9397-48f7991f41ec@damsy.net>
Date: Wed, 17 Jun 2026 15:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/amdgpu: delay ttm buffer func enablement on
 xgmi
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260616125040.9977-1-pierre-eric.pelloux-prayer@amd.com>
 <20260616125040.9977-2-pierre-eric.pelloux-prayer@amd.com>
 <SA0PR12MB7091079B864676A8379E6B7997E52@SA0PR12MB7091.namprd12.prod.outlook.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <SA0PR12MB7091079B864676A8379E6B7997E52@SA0PR12MB7091.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



Le 16/06/2026 à 16:41, Lazar, Lijo a écrit :
> Public
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Pierre-Eric Pelloux-Prayer
> Sent: Tuesday, June 16, 2026 6:21 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v1 2/2] drm/amdgpu: delay ttm buffer func enablement on xgmi
> 
> When amdgpu_init_minimal_xgmi is used, SDMA engines init is delayed so amdgpu_ttm_enable_buffer_funcs must be called later.
> 
> Without this, the check for num_buffer_funcs_scheds will fail and using ttm buffer funcs later will fail.
> 
> Fixes: 3a5da695c8d1 ("drm/amdgpu: only use working sdma schedulers for ttm")
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 57e10afb4714..2e8954fa5c40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2479,7 +2479,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>          if (r)
>                  goto init_failed;
> 
> -       amdgpu_ttm_enable_buffer_funcs(adev);
> +       if (amdgpu_ip_member_of_hwini(adev, AMD_IP_BLOCK_TYPE_SDMA))
> +               amdgpu_ttm_enable_buffer_funcs(adev);
> 
>          /* Don't init kfd if whole hive need to be reset during init */
>          if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) { diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index faac80a8a6eb..c0dca209335e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1663,6 +1663,8 @@ static void amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
>                  if (r && r != -EHWPOISON)
>                          dev_err(tmp_adev->dev,
>                                  "error during bad page data initialization");
> +
> +               amdgpu_ttm_enable_buffer_funcs(tmp_adev);
> 
> <lijo> This gets enabled in the resume path after xgmi reset. It is not needed here.

Good point. I've modified the patch in v2.

Thanks,
Pierre-Eric


> 
> Thanks,
> Lijo
> 
>          }
>   }
> 
> --
> 2.43.0
