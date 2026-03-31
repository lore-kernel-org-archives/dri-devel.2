Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41513109B467
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C72510E99C;
	Tue, 31 Mar 2026 13:33:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hEdSEeDK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E5A10E99C
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 13:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7Iy8Lnyd0AwTsveWfRUVA+4TI8u8R4YvbqTLkryPmtI=; b=hEdSEeDKMrCDMqjLYJ2uM61sSK
 mTfNrh7FX1rLy1csxQMQMzf8lVigi6EVOQpOO2Hc+s2ynFoPJduS4UV1n1Oq1MfMznsmPILoaVmQe
 9ePy1HhtZVJD3Lt0+6FZzhPIqsSEAPjqK6QFLjycjnPfsUnlN9IohAdOtJpxrDM9FW2NnzrLqgPdz
 hqyk3rBzjN4bjvYkuH4AjCN7++Vyaikpb2O+PicxQ5TUUWuunlObu4mGlik3q+UqjrLm8gXq4hiVD
 T6sn8hOns93taOPnJcz6Buvh/OITTN+hPXLnfHpeFKSTG+lBLoTV3f7udNQ9S1I1AQuokZ3LiYzVL
 fdzuXn2Q==;
Received: from [189.89.58.122] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w7ZDA-009TKC-Hi; Tue, 31 Mar 2026 15:32:52 +0200
Message-ID: <168701a9-c219-4eb5-b6fc-fdc13ec006f4@igalia.com>
Date: Tue, 31 Mar 2026 10:32:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/vc4: Fix a memory leak in hang state error path
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
 <20260330-vc4-misc-fixes-v1-3-92defc940a29@igalia.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260330-vc4-misc-fixes-v1-3-92defc940a29@igalia.com>
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



On 30/03/2026 14:51, Maíra Canal wrote:
> When vc4_save_hang_state() encounters an early return condition, it
> returns without freeing the previously allocated `kernel_state`,
> leaking memory.
>
> Add the missing kfree() calls by consolidating the early return paths
> into a single place.
Nice catch!

Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> Fixes: 214613656b51 ("drm/vc4: Add an interface for capturing the GPU state after a hang.")
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/vc4/vc4_gem.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> index 248c47665a193fa639a481f97ac2af634f415384..ab3c6d5d4eb446804877d6b8da01c3a9f65800df 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -171,10 +171,8 @@ vc4_save_hang_state(struct drm_device *dev)
>   	spin_lock_irqsave(&vc4->job_lock, irqflags);
>   	exec[0] = vc4_first_bin_job(vc4);
>   	exec[1] = vc4_first_render_job(vc4);
> -	if (!exec[0] && !exec[1]) {
> -		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
> -		return;
> -	}
> +	if (!exec[0] && !exec[1])
> +		goto err_free_state;
>   
>   	/* Get the bos from both binner and renderer into hang state. */
>   	state->bo_count = 0;
> @@ -191,10 +189,8 @@ vc4_save_hang_state(struct drm_device *dev)
>   	kernel_state->bo = kzalloc_objs(*kernel_state->bo, state->bo_count,
>   					GFP_ATOMIC);
>   
> -	if (!kernel_state->bo) {
> -		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
> -		return;
> -	}
> +	if (!kernel_state->bo)
> +		goto err_free_state;
>   
>   	k = 0;
>   	for (i = 0; i < 2; i++) {
> @@ -286,6 +282,12 @@ vc4_save_hang_state(struct drm_device *dev)
>   		vc4->hang_state = kernel_state;
>   		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
>   	}
> +
> +	return;
> +
> +err_free_state:
> +	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
> +	kfree(kernel_state);
>   }
>   
>   static void
>

