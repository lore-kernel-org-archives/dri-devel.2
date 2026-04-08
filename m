Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6A910F9958
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 16:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3724E10E6AB;
	Wed,  8 Apr 2026 16:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="BIq1oqTf";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C632810E6AB
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 16:17:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8AC411A3200;
 Wed,  8 Apr 2026 16:17:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 57C3C603CE;
 Wed,  8 Apr 2026 16:17:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3EA6910450154; 
 Wed,  8 Apr 2026 18:17:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775665050; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=sW7PfS/oGOQ7K0BGI9Bt1TIPXOxXhcJbY+thwE8WW+g=;
 b=BIq1oqTfqfW6AV6UWeme3jl+n9hN744rsHzRQCGMeshPn+VoDrOOPblFhtOjxu5WgCDfr6
 PKEGzY8QPUG/LmPsvKpnDPVI97jfnGYLmFrSlogdV3v0Suax/HJIUaoW9BWwQFS6GKAcOX
 0qW8rycPgQGQTZE+6RsCbq2l8Sax/Xi70S7+xyjsorrfNfInSStzLrunwiwgkuBG9QSmob
 1eOsMKn8bplGk20ZTo5+7AutuhBGL+wciUCPWckqeMndhNTmla0rVmjnFoHCHsemUQ0QHq
 1Mz5tcUfE2UiKvD+VK/2qvWbnv660f0uq/VdqVyk+QWArwAmvZOp8CkHJRem7A==
Message-ID: <bd58a56f-f30c-491b-b50e-6cdede803139@bootlin.com>
Date: Wed, 8 Apr 2026 18:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/arcpgu: fix device node leak
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ian Ray <ian.ray@gehealthcare.com>, stable@vger.kernel.org
References: <20260402-drm-arcgpu-fix-device-node-leak-v2-1-d773cf754ae5@bootlin.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260402-drm-arcgpu-fix-device-node-leak-v2-1-d773cf754ae5@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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



On 4/2/26 18:42, Luca Ceresoli wrote:
> This function gets a device_node reference via
> of_graph_get_remote_port_parent() and stores it in encoder_node, but never
> puts that reference. Add it.
> 
> There used to be a of_node_put(encoder_node) but it has been removed by
> mistake during a rework in commit 3ea66a794fdc ("drm/arc: Inline
> arcpgu_drm_hdmi_init").
> 
> Fixes: 3ea66a794fdc ("drm/arc: Inline arcpgu_drm_hdmi_init")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
> Changes in v2:
> - fix typos in commit message
> ---
>   drivers/gpu/drm/tiny/arcpgu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
> index 505888497482..c93d61ac0bb7 100644
> --- a/drivers/gpu/drm/tiny/arcpgu.c
> +++ b/drivers/gpu/drm/tiny/arcpgu.c
> @@ -250,7 +250,8 @@ DEFINE_DRM_GEM_DMA_FOPS(arcpgu_drm_ops);
>   static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
>   {
>   	struct platform_device *pdev = to_platform_device(arcpgu->drm.dev);
> -	struct device_node *encoder_node = NULL, *endpoint_node = NULL;
> +	struct device_node *encoder_node __free(device_node) = NULL;
> +	struct device_node *endpoint_node = NULL;
>   	struct drm_connector *connector = NULL;
>   	struct drm_device *drm = &arcpgu->drm;
>   	int ret;
> 
> ---
> base-commit: 4b9c36c83b34f710da9573291404f6a2246251c1
> change-id: 20251119-drm-arcgpu-fix-device-node-leak-f909bc1f7fbb
> 
> Best regards,
> --
> Luca Ceresoli <luca.ceresoli@bootlin.com>
> 

