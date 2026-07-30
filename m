Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E43C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F8CB10EE67;
	Thu, 30 Jul 2026 09:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Kp2Du9Ev";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1429010EE67
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:49:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 976B8204C;
 Thu, 30 Jul 2026 02:49:15 -0700 (PDT)
Received: from [10.1.25.28] (e122027.cambridge.arm.com [10.1.25.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 934EB3F763;
 Thu, 30 Jul 2026 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785404959; bh=Za1Zi5x4E/3lIcCOwvENgOWOmAWtb4nF2bI7UjF97+0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Kp2Du9Ev6sNCOxPIYC5gX+2xSY61M1TbA9KsNh7A/Fmj4WLLrQh5JNE9gg7+50gz2
 z2/kTsfGhojxrRK2CBrOy1UNRK+jEF0cWdgQ4OFuWOmBwmIO6z002+3IkEXM8rIcmh
 JqKsa874bbLakttlgmpnwxcP5n88J9jSeSpUGP/M=
Message-ID: <0beb3ec9-b197-438f-81ff-00051e1112b2@arm.com>
Date: Thu, 30 Jul 2026 10:49:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: skip zero-sized firmware sections
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <c31aeec2-6336-4dad-93a8-982e3f4c525f@arm.com>
 <20260724172621.63046-1-osama.abdelkader@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260724172621.63046-1-osama.abdelkader@gmail.com>
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

On 24/07/2026 18:26, Osama Abdelkader wrote:
> panthor_fw_load_section_entry() skips BO creation when the firmware section
> VA range is empty. If such a section is added to the firmware section list,
> section->mem is left as NULL.
> 
> Later reload and unplug paths iterate over all firmware sections and
> dereference section->mem, which can lead to a NULL pointer dereference.
> 
> Zero-sized firmware sections are valid, so accept them as no-op entries but
> skip adding them to the section list.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

I'll push this to drm-misc-fixes.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> v2:
> - Accept zero-sized firmware sections as no-op entries instead of rejecting
>   them, as suggested by Steven.
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index a338c4f0a7f5..66d9f5947af0 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -601,8 +601,11 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  	if (data_size > section_size) {
>  		drm_err(&ptdev->base, "Firmware corrupted, section data exceeds section size\n");
>  		return -EINVAL;
>  	}
>  
> +	if (!section_size)
> +		return 0;
> +
>  	name_len = iter->size - iter->offset;
>  
>  	section = drmm_kzalloc(&ptdev->base, sizeof(*section), GFP_KERNEL);

