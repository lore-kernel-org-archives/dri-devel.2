Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BD1C79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 03:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9710810E33E;
	Fri, 11 Sep 2026 03:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="IkOmw4I2";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33EDA10E33E
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:38:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789097908; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LH+wdAhGMKHGPnRZ7DulAKxszW/AgAY8hiKmzVPtytdOUib62ri9nmVZWOgnofcisa/xjE2pU1Xucy7b6X+3IGjeh8J800MA9mrWTPKjpr6xiw+Nsx6l9a6A1U8CJF9qZPSnYxR0FUS8K4qqO04xLjCh4Ku/otZGCmDWcDDc51k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789097908;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ofQzn7xCkcrRXLlBde8hqgntbjn4o4+CwN0WRZTmd64=; 
 b=nH7K66XBZYMuq1JV4cJjQj8nEM/p7z++i11+crMjHn0YtPoaS8/QruchhbLfSAWd/hbCKRkRdnBjPAa0dhg3MteETWJk58ZeSWEN7nCWV5t62uWMeEcw49G/8bptHDB89V6zIfyE6PWp4fqgCClVJNyr/QkMcuLBQU+Asyk3olc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789097908; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=ofQzn7xCkcrRXLlBde8hqgntbjn4o4+CwN0WRZTmd64=;
 b=IkOmw4I2j7/2PviPGZiuuF8JHJ5Mv9rYQ/vEB+g0nGaN5//xVRvIRNSTrifi7zJm
 9q9vox/KnnjVlnfQF49KmGh6lcuCIu/GqgxCE9gYgNmw+JnTvztYS/3IPGA5CxeuGrT
 4JMBfQ3hvcvGpwKEFBmnl6DXIQD8iH2lca1GImcE=
Received: by mx.zohomail.com with SMTPS id 1789097907327889.4427999640113;
 Thu, 10 Sep 2026 20:38:27 -0700 (PDT)
Date: Fri, 11 Sep 2026 04:38:23 +0100
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/18] drm/panthor: Check AS state before disabling
Message-ID: <aqMKT6diaogngpdg@sobremesa>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-10-982cc8f4234b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826-panthor-unplug-fixes-v4-10-982cc8f4234b@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.74.40
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

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

On 26.08.2026 16:56, Boris Brezillon wrote:
> Use TRANSTAB == 0 as a way to detect if an AS slot is idle. This
> allows us to make panthor_mmu_as_disable() a NOP when it's called
> after a SOFT_RESET, which will be needed for our unplug rework.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 3d9f9bf29e1d..58f0bd2ac7a2 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -640,6 +640,10 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 slot,
>  
>  	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
>  
> +	/* The AS was disabled already, nothing to do. */
> +	if (!gpu_read64(mmu->iomem, AS_TRANSTAB(slot)))
> +		return 0;
> +
>  	panthor_irq_disable_events(&ptdev->mmu->irq,
>  				   panthor_mmu_as_fault_mask(ptdev, slot));
>  
> @@ -662,11 +666,17 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 slot,
>  	if (recycle_slot)
>  		return 0;
>  
> -	gpu_write64(mmu->iomem, AS_TRANSTAB(slot), 0);
> -	gpu_write64(mmu->iomem, AS_MEMATTR(slot), 0);
>  	gpu_write64(mmu->iomem, AS_TRANSCFG(slot), AS_TRANSCFG_ADRMODE_UNMAPPED);
> +	ret = as_send_cmd_and_wait(ptdev, slot, AS_COMMAND_UPDATE);
> +	if (ret)
> +		return ret;
>  
> -	return as_send_cmd_and_wait(ptdev, slot, AS_COMMAND_UPDATE);
> +	/* We reset the other fields late to ensure that, if something fails,
> +	 * the page table is considered active (TRANSTAB != NULL).
> +	 */
> +	gpu_write64(mmu->iomem, AS_MEMATTR(slot), 0);
> +	gpu_write64(mmu->iomem, AS_TRANSTAB(slot), 0);
> +	return 0;
>  }
>  
>  static u32 panthor_mmu_fault_mask(struct panthor_device *ptdev, u32 value)
> 
> -- 
> 2.55.0

Adrian Larumbe
