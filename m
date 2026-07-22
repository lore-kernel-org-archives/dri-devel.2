Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9246C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E99B10E474;
	Wed, 22 Jul 2026 15:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="F5XaB3yy";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52EB510E474
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 15:39:51 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7D6F74E40ED4;
 Wed, 22 Jul 2026 15:39:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2B03660388;
 Wed, 22 Jul 2026 15:39:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5779F11BD3A6A; 
 Wed, 22 Jul 2026 17:39:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784734788; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=KbMT1xKJyvVket846AeElH+XsOTyxdJ88sqL2onR9EA=;
 b=F5XaB3yyctgUjCnzQg9FBssZ9VUE7lwKsEfXyXJ5CY8n3cA7OWrO/+S6Pm3La5CNU2g5FF
 Q2hYCD+urm1C3uD44RxMXjlYL61gB2rdQKhKdcIgMN12XutZMfZrsZfI74bADcgn/vLBYG
 4Ft2bck/l57Qsr0SedR6KWEvtA0RX/iE+2C1oJkyQsr0lWQDyV69IxDOlTj7+cwpfCumqh
 c2imvYTcc1AC9GWjZZh6JRi13grkcqqhwxJREEvaRtB47af0yw3h2So96xeY6Aw84Zz0gG
 vkjXTF0Q3B1K1Fb47eyJlv5xEQuHIYwzpCW5ws2dnZeiAjafwEJQTgOBk1AScA==
Message-ID: <d65b4673-007e-41f1-ad8a-b21c018be3e7@bootlin.com>
Date: Wed, 22 Jul 2026 17:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH] drm/vkms: Advertise PREMULTI blend mode
To: Michail Tatas <michail.tatas@gmail.com>, simona@ffwll.ch,
 melissa.srw@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, hamohammed.sa@gmail.com, maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <al1pElMQZsDfpAYI@michalis-linux>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <al1pElMQZsDfpAYI@michalis-linux>
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



On 7/20/26 02:17, Michail Tatas wrote:
> Since we only support pre-multiplied alpha blend mode,
> advertise that, otherwise validate_blend_mode_for_alpha_formats()
> will throw a WARN.
> 
> Reported-by: syzbot+6245cb95ae707991bffa@syzkaller.appspotmail.com
> Signed-off-by: Michail Tatas <michail.tatas@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
> 
> syzbot link: https://syzkaller.appspot.com/bug?extid=6245cb95ae707991bffa
> 
>   drivers/gpu/drm/vkms/vkms_plane.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 68cb2a3335e6..a2e5ebee729a 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -246,6 +246,12 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
>   					  DRM_COLOR_YCBCR_BT601,
>   					  DRM_COLOR_YCBCR_FULL_RANGE);
>   
> +	/* Since our composer only supports pre-multiplied alpha,
> +	 * advertise only the PREMULTI blend mode.
> +	 */
> +	drm_plane_create_blend_mode_property(&plane->base,
> +					BIT(DRM_MODE_BLEND_PREMULTI));
> +
>   	if (vkms_config_plane_get_default_pipeline(plane_cfg))
>   		vkms_initialize_colorops(&plane->base);
>   

