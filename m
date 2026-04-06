Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445D5F46C44
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8156C10E267;
	Mon,  6 Apr 2026 15:15:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="i47j26Fr";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F81110E0BE
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 15:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H2cTTjZBqtu7Q0nGsyrMhDWhfs8Pjm564bdVPfL0o90=; b=i47j26FrOVce/ododphtkJKzCQ
 m+mhHzYzquCdaBT9CsW2/PVTwCX0J0BsFQuHFbo8WaJHM2XkJEqKEzU35oeqXi7bMRIaxn3pVpa4D
 0YvZxWAKa3g5yhE8+D9Wa5MasoEUMcTeCg2lkpMdrwKkWieB16E2L66sxb/Hce8eUM+Kl/ehgDOUL
 S5/bXoOMIQS1Q6V87uEWKnRoD+Z8yUQRFFXi0VekkbUb/2odpM8srqtDSKou2EDr4jTEV3QFBRsU6
 nxqmoumVknzvGypuxp3+fy/BIRz53lB1rSq2cnaGQnBns980oikAWpAQllMNqlvzuyZoM1FvTMgzY
 g4vnCbKw==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w9lfU-00CcJC-6x; Mon, 06 Apr 2026 17:15:12 +0200
Message-ID: <a2c75ec1-0af5-4a78-9944-b35f0db24f40@igalia.com>
Date: Mon, 6 Apr 2026 16:15:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] drm/vc4: Use unique fence timeline names per queue
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260402-vc4-drm-scheduler-v2-0-d84afd35c602@igalia.com>
 <20260402-vc4-drm-scheduler-v2-7-d84afd35c602@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260402-vc4-drm-scheduler-v2-7-d84afd35c602@igalia.com>
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


On 02/04/2026 19:36, Maíra Canal wrote:
> Return distinct timeline names ("vc4-bin" and "vc4-render") from
> vc4_fence_get_timeline_name() based on the fence's queue, instead of
> the generic "vc4-v3d" for all fences. This improves debuggability when
> inspecting fence state.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/vc4/vc4_fence.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_fence.c b/drivers/gpu/drm/vc4/vc4_fence.c
> index 12f1649832388d81f1887ae484df7054e0f6010f..1078598311f4283ad4d2acc7c4dd0742c7a13afe 100644
> --- a/drivers/gpu/drm/vc4/vc4_fence.c
> +++ b/drivers/gpu/drm/vc4/vc4_fence.c
> @@ -48,7 +48,16 @@ static const char *vc4_fence_get_driver_name(struct dma_fence *fence)
>   
>   static const char *vc4_fence_get_timeline_name(struct dma_fence *fence)
>   {
> -	return "vc4-v3d";
> +	struct vc4_fence *f = to_vc4_fence(fence);
> +
> +	switch (f->queue) {
> +	case VC4_BIN:
> +		return "vc4-bin";
> +	case VC4_RENDER:
> +		return "vc4-render";
> +	default:
> +		return "unknown";

"vc4-unknown" ?

Either way:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> +	}
>   }
>   
>   const struct dma_fence_ops vc4_fence_ops = {
> 

