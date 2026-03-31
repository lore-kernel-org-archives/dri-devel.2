Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BD0109B469
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 052D010E04F;
	Tue, 31 Mar 2026 13:28:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="X6VoRVF5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00AA110E04F
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kNDuHt97Ck0m2+Z/Zud2HdbfLZ5FJaVRj7KdqwaHIag=; b=X6VoRVF5NoapIPtBmt0HnpN1Rc
 3uOLd/YN6V+o1UmRc47kN05lUJ1hXJ1pRdNyedEphjjfc5ApBHcD8tP1F/8eQecQlfZcZIY4dzJwG
 /s2jHKt475x0IzeMHzaKkgdmlkXVlDF637HO6xrSTJ1OWuR0NmSoBwkLRV4SVA4OvLCpAbpwszgif
 ix+e4z43veXMmj3gwrmGB0HXXnaGl9nBI/BRHksf+4bbT23rdkupIEIneg7563qCgoMMqQKcWtNd2
 70hhupsuihbfvQGDoTCYBHCbYalOrRm82ZVl6+TOApO1/saOf9slvrpU6Hiil4nnN5+niClapqzfW
 Clrd4Aeg==;
Received: from [189.89.58.122] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w7Z8t-009TCD-7h; Tue, 31 Mar 2026 15:28:27 +0200
Message-ID: <a6ef8a30-9177-4ab8-aff8-30497501e95a@igalia.com>
Date: Tue, 31 Mar 2026 10:28:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/vc4: Fix memory leak of BO array in hang state
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
 <20260330-vc4-misc-fixes-v1-2-92defc940a29@igalia.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260330-vc4-misc-fixes-v1-2-92defc940a29@igalia.com>
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
> The hang state's BO array is allocated separately with kzalloc() in
> vc4_save_hang_state() but never freed in vc4_free_hang_state(). Add the
> missing kfree() for the BO array before freeing the hang state struct.
>
> Fixes: 214613656b51 ("drm/vc4: Add an interface for capturing the GPU state after a hang.")
Reviewed-by: Melissa Wen <mwen@igalia.com>
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/vc4/vc4_gem.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> index 2d3df5e621c1a2192656efd6fc8940ebb1ce991f..248c47665a193fa639a481f97ac2af634f415384 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -62,6 +62,7 @@ vc4_free_hang_state(struct drm_device *dev, struct vc4_hang_state *state)
>   	for (i = 0; i < state->user_state.bo_count; i++)
>   		drm_gem_object_put(state->bo[i]);
>   
> +	kfree(state->bo);
>   	kfree(state);
>   }
>   
>

