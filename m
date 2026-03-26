Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8072F106F30F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 10:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF6B10EA99;
	Thu, 26 Mar 2026 10:00:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="okKCDvJd";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B5810EA99
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 10:00:13 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 15EA11A2FFD;
 Thu, 26 Mar 2026 10:00:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DD6AF5FDEB;
 Thu, 26 Mar 2026 10:00:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8172E10451B55; Thu, 26 Mar 2026 11:00:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774519210; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=jNnblfjF1unXrLJfmC4++Nrku5Ks6F/XKKickwsmIEM=;
 b=okKCDvJdlDSyFcwjKD87s56jjA0SAxnYKvDXOUnE1PARxPgQiEdxZxkr6gPZcYlmaUNGl+
 CJ4zYQ2uZmOgtLbcOLFh4fqanFHLnh+BeUjNxJszIUceGYVSOEQn5Lw0suya5lGpH7Y5jJ
 yiNS5FtdxOitQ7xUc5jiKXwsbqAfHzlV4E+f/HeXIkTr7ZVSlpRzkkWUx9uornE+gGyyQM
 23x3M/OwkK9Hwh2oKt44NDN2+90KChtRjGHckrItetsb3ihJxcn12/L1OJHM+p8c7dPzP5
 GUMjxIVnxQVt8Ziw8JUj3IFB06BEHveNxlmmRMvgm9u65NtcXBqddil4vpP14g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 11:00:03 +0100
Message-Id: <DHCMK408P4K0.23H5IMREOL9GU@bootlin.com>
Cc: "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray"
 <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Liu Ying" <victor.liu@nxp.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH RESEND] drm/bridge: drm_bridge_get/put(): document NULL
 pointer behaviour
X-Mailer: aerc 0.20.1
References: <20260324-drm-bridge-alloc-getput-document-null-check-v1-1-fb0877c49d7e@bootlin.com>
 <6d2e9c83-8652-427f-869a-20f7353f126a@nxp.com>
In-Reply-To: <6d2e9c83-8652-427f-869a-20f7353f126a@nxp.com>
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

Hello Liu,

On Thu Mar 26, 2026 at 10:36 AM CET, Liu Ying wrote:

>> --- a/drivers/gpu/drm/drm_bridge.c
>> +++ b/drivers/gpu/drm/drm_bridge.c
>> @@ -282,7 +282,7 @@ static void __drm_bridge_free(struct kref *kref)
>>
>>  /**
>>   * drm_bridge_get - Acquire a bridge reference
>> - * @bridge: DRM bridge
>> + * @bridge: DRM bridge; if NULL this function does nothing
>>   *
>>   * This function increments the bridge's refcount.
>>   *
>> @@ -300,7 +300,7 @@ EXPORT_SYMBOL(drm_bridge_get);
>>
>>  /**
>>   * drm_bridge_put - Release a bridge reference
>> - * @bridge: DRM bridge
>> + * @bridge: DRM bridge; if NULL this function does nothing
>
> So, we can drop the if(_T) check for cleanup action, right?

We could, but it's supposed to be there to help compiler optimizations:
https://elixir.bootlin.com/linux/v7.0-rc5/source/include/linux/cleanup.h#L1=
92-L207

> DEFINE_FREE(drm_bridge_put, struct drm_bridge *, if (_T) drm_bridge_put(_=
T))
>
> Reviewed-by: Liu Ying <victor.liu@nxp.com>

Thanks!

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
