Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA53C54F4D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D57E10E5B8;
	Tue, 28 Jul 2026 16:09:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="QqWo7Gfb";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 37C3210E5B8
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 16:09:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CF4F16F2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:09:37 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 6457C3F763
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785254981; bh=q6mrCLoh7TTNCGFPKiKdXibBGMULCO0YWhvoUknTgb4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QqWo7GfbRpIsWDITDBz6DWZwW6WbO7cC8VpLM/lfG5opzfFTDDcvpIpE9/Th9g55Y
 ygUHt/r5XqWwNEaLNLaWRjxainiC6XnzuUxLtK2FGdC8BQFBz+bkrvv/NbIII5VE96
 yVEjQGId5HdLnNjf0egT08dFOAdKqSEW0yx/ELZ0=
Date: Tue, 28 Jul 2026 17:09:29 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/panthor: skip zero-sized firmware sections
Message-ID: <amjUOezjoGoKSEVA@e142607>
References: <c31aeec2-6336-4dad-93a8-982e3f4c525f@arm.com>
 <20260724172621.63046-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724172621.63046-1-osama.abdelkader@gmail.com>
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

On Fri, Jul 24, 2026 at 07:26:20PM +0200, Osama Abdelkader wrote:
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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

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
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
