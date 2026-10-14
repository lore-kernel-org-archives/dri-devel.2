Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75624CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6D8710E888;
	Wed, 14 Oct 2026 15:57:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6CF8310EA3C
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:57:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EDC114BF;
 Wed, 14 Oct 2026 08:57:15 -0700 (PDT)
Received: from [10.57.57.120] (unknown [10.57.57.120])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A35993F7B4;
 Wed, 14 Oct 2026 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791993438; bh=tms9HLbn8I7pFVxbnZ7zROcqVKYVzS65ADGUXGMatKk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nWB4pAZM4vTLFwe4u9hyhLMYnRQwZRQlq4tXnFRaR93w3XnobClu7mpqbcL1DLAVP
 5XiU6DqN3r41HLlTc45y+w8SFDwp/iEspmbVApXIU6i1Zax+7yAp2eQ/HXWrrwEoB8
 poN7z76xirucaHUrjD+YCNgArcm5SAgvHDhSyjhg=
Message-ID: <193c0b24-5b75-4a77-9736-4bb5345a2d1e@arm.com>
Date: Wed, 14 Oct 2026 16:57:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: fix immortalis condition
To: Erik Faye-Lund <erik.faye-lund@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261014070902.169273-1-erik.faye-lund@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261014070902.169273-1-erik.faye-lund@arm.com>
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

On 14/10/2026 08:09, Erik Faye-Lund wrote:
> Exactly 10 cores is also valid for an Immortalis configuration,
> according to the public documentation:
> 
> https://support.arm.com/compute-ip/immortalis-g715
> 
> So let's report this G715 with 10 cores as Immortalis as well, as long
> as it supports the ray-intersection feature. This matches what we do for
> more recent GPUs as well.
> 
> Fixes: 3b1dc21d6d80 ("drm/panthor: Add support for Mali-Gx15 family of GPUs")
> Signed-off-by: Erik Faye-Lund <erik.faye-lund@arm.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

I'll push this to drm-misc-fixes.

Thanks,
Steve

> ---
> Changes since v1:
> - Fixed typo in subject.
> - Added missing SoB line.
> - Applied Reviewed-by tags.
> 
>  drivers/gpu/drm/panthor/panthor_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 7e315708ca7c..ea1e222ef121 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -136,7 +136,7 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
>  	case GPU_PROD_ID_MAKE(10, 7):
>  		return "Mali-G610";
>  	case GPU_PROD_ID_MAKE(11, 2):
> -		if (shader_core_count > 10 && ray_intersection)
> +		if (shader_core_count >= 10 && ray_intersection)
>  			return "Mali-G715-Immortalis";
>  		else if (shader_core_count >= 7)
>  			return "Mali-G715";

