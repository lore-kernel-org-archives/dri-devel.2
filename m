Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42098CD3439
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 18:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93EF810EBB4;
	Tue,  5 May 2026 18:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FlNdiboT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8295D10E46E;
 Tue,  5 May 2026 18:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0wouRkC7R6R6za9vKUGUIKSOanWTfI6K8Vjgu6fhaJA=; b=FlNdiboThWj2nJU5anXICAiYK/
 36hxMKS+lEATI1venbZfWbtLPV3XLJ67PTiLl1F7EVQwmzjxBYyrqITl/hxY6wmh5WFbdHjqauFBc
 r7t1JGAPeXhKql9vyI7t+BA5Fi7Wf4qBlR/cbNNvux8Fv2Z/jmS/kcVNRHg0db2wVJWJ0eWS3fA4m
 w6wwPRy/+ZBqzkNDiwvNkY6ZeZGT2byLfHvUBlPXqwR8r6wtn1EzklNl0L4IU/RzpV/pmQZwOrubS
 B7GY3flB3hsh4a63lQQCmyJwgsRehd40KmbAvvjWV5Viv53elLTia7pxNoHBhn0Nl5ib1A3s7E4+b
 +mYc+XPQ==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wKKck-006ZHM-Py; Tue, 05 May 2026 20:36:02 +0200
Message-ID: <8c429335-2516-49a0-b2dc-4a09fd14749e@Igalia.com>
Date: Tue, 5 May 2026 11:35:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] drm/msm/dpu: don't mix devm and drmm functions
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <20260505-wb-drop-encoder-v5-1-42567b7c7af2@oss.qualcomm.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <20260505-wb-drop-encoder-v5-1-42567b7c7af2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/4/26 17:24, Dmitry Baryshkov wrote:
> Mixing devm and drmm functions will result in a use-after-free on msm
> driver teardown if userspace keeps a reference on the drm device:
> The WB connector data will be destroyed because of the use of
> devm_kzalloc()), while the usersoace still can try interacting with the
extra ) on devm_kzalloc())
typo: userspace

Otherwise the description looks good to me and the two typos can be 
fixed when merging, so:
Reviewed-by: John.Harrison@Igalia.com

But should wait for at least an ack from Laurent as the person 
originally requesting an extended description.

John.

> WB connector (which uses drmm_ functions).
>
> Change dpu_writeback_init() to use drmm_.
>
> Fixes: 0b37ac63fc9d ("drm/msm/dpu: use drmm_writeback_connector_init()")
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Closes: https://lore.kernel.org/r/78c764b8-44cf-4db5-88e7-807a85954518@wanadoo.fr
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> index 7545c0293efb..6f2370c9dd98 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> @@ -5,6 +5,7 @@
>   
>   #include <drm/drm_edid.h>
>   #include <drm/drm_framebuffer.h>
> +#include <drm/drm_managed.h>
>   
>   #include "dpu_writeback.h"
>   
> @@ -125,7 +126,7 @@ int dpu_writeback_init(struct drm_device *dev, struct drm_encoder *enc,
>   	struct dpu_wb_connector *dpu_wb_conn;
>   	int rc = 0;
>   
> -	dpu_wb_conn = devm_kzalloc(dev->dev, sizeof(*dpu_wb_conn), GFP_KERNEL);
> +	dpu_wb_conn = drmm_kzalloc(dev, sizeof(*dpu_wb_conn), GFP_KERNEL);
>   	if (!dpu_wb_conn)
>   		return -ENOMEM;
>   
>

