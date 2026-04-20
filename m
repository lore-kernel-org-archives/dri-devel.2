Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DC4F55817
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 11:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9DA010E4E4;
	Mon, 20 Apr 2026 11:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="vbeHqt8h";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id DF41110E4E4
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 11:18:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0ED61516;
 Mon, 20 Apr 2026 04:18:15 -0700 (PDT)
Received: from [10.57.32.80] (unknown [10.57.32.80])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CB2D3F641;
 Mon, 20 Apr 2026 04:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776683901; bh=eDjCLpVfQ9c2PFa8mDoqqBedTvS6p99mksjDimWJylo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vbeHqt8hcNjMtrvOPqFVKZ7p1MPb1UOM9FleKPMsBJD+kY/Invg4xoMDqPO9bQ/RN
 RJrU+VLX65fMl4Rp2CzFLlMqg4OAhCNK9eVngfsH9PcFIZHVLZ5oxQTBoCdXggb4UP
 XKSYcRIiKL1R3OrIwU1qBQFRPTgdjEIBOymiw6AU=
Message-ID: <48a13e98-ac6c-42d3-98f6-a8d77b349c3d@arm.com>
Date: Mon, 20 Apr 2026 12:18:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/panfrost: Fix wait_bo ioctl leaking positive
 return from dma_resv_wait_timeout()
To: Gyeyoung Baek <gye976@gmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, =?UTF-8?Q?Adri=C3=A1n_Larumbe?=
 <adrian.larumbe@collabora.com>
Cc: Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <cover.1776581974.git.gye976@gmail.com>
 <fe33f82fded7be1c18e2e0eb2db451d5a738cf39.1776581974.git.gye976@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <fe33f82fded7be1c18e2e0eb2db451d5a738cf39.1776581974.git.gye976@gmail.com>
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

On 19/04/2026 08:17, Gyeyoung Baek wrote:
> dma_resv_wait_timeout() returns a positive 'remaining jiffies' value
> on success, 0 on timeout, and -errno on failure.
> 
> panfrost_ioctl_wait_bo() returns this 'long' result from an int-typed
> ioctl handler, so positive values reach userspace as bogus errors.
> Explicitly set ret to 0 on the success path.
> 
> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 3d0bdba2a..784e36d72 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -390,6 +390,8 @@ panfrost_ioctl_wait_bo(struct drm_device *dev, void *data,
>  				    true, timeout);
>  	if (!ret)
>  		ret = timeout ? -ETIMEDOUT : -EBUSY;
> +	else if (ret > 0)
> +		ret = 0;
>  
>  	drm_gem_object_put(gem_obj);
>  

