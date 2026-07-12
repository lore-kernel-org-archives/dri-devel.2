Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A03DC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 19:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA5110E023;
	Sun, 12 Jul 2026 19:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JMDjWTWS";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC2710E023
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 19:07:58 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-475881b9a4bso2403084f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783883276; x=1784488076; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+xZg60sAAA06cSnVFm1g3I8u9K5C+cZsTy9v614jrUA=;
 b=JMDjWTWSs7SVG35S3P/ZggH9PuCnw4rQt+gfSmkn58hfOSIfDRIbdbGamI7YbIPgFC
 y6SncJe88JWo87JjUTpcJ7NzwUnFcMYslj2rEZ9amgflruFZG5lF74jCOB2beGh8zP5f
 UBQzJJAC0xhH5uJPNs1vMNFwbprI0VDwFLtUrM8VvCZHo0jqbRbDeIW71OW7oglcajTp
 ie/VUOxoPpf3dWVluF8RvYEsyK51iscduVoGufEn+pZRTDQF4JhX33zBOhduCTK5tpIp
 dUwnpu0QyA8x5KJyegofYhc5ODVt1IMyBOYClH/li+HJZSxaZHs2MCKYkn8gh3xSZp6h
 9Vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783883276; x=1784488076;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+xZg60sAAA06cSnVFm1g3I8u9K5C+cZsTy9v614jrUA=;
 b=ItAvOIjWELcZUZigWROeoQG6An7dIZKXfc50ySc8fDBV1xlFip/AZF1WlUxlAkaVWt
 yHazNfAEjRz92LMLnWa+18wi7PHPe5tuV5jXWFBsadRS0cwKhuABoGk2hfDIsjhymXZZ
 E+MtV5bkMYWAv7E2T6hNglMnMbYPKFGFQENk1poYxQ4t2CWV32hDOSPR4JmsCbPc9WDf
 tDekhg3Tw1Mj0D/T6yQ/DS+5/HrhSvRFAwjF7a86n99Q+uuwTk6jcmHwkgsuQS+E1N6X
 AZIfKn4j4l76P+SJfjnIIkJakRoN8DedLSfPtP6V+jtECwf9wGoJFpumD3eXSVg6COfn
 ENZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUdbu6CD9j3F+Uw8mQ+JD7AFkoHcIHrvF9u1YKwQ80yPEjDbaOju6JTgCNQdnfOTYV5jgbTH249Fc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJ9kY98osAjtQYiPIN6nBxhOFhgMElqWPwXATsw2eRIphyzeiM
 CRFHOpMVIS3T3IGn1FvLV2v33XUlfLnqYJ+qFQNWnKAJnNn9xPqPASVV
X-Gm-Gg: AfdE7cmY9laT8Y6Uacu78qJDssoYSwt7KSG4e04u/m4Bdg2sIfX91fURjqMeRE/ChBV
 eifYej1NM6mIc1xRacowEPYq+Xn1vYjBHUA4RwTWIjsbJQa26r5vAwOSLj4CxUOXEDqtzSMk5yf
 iG194JAuo90lMGRK45r8IgMe8di3Rf4sQoVfalW47UpQkG7TSmX/lNv9Aew9hUgm3HI6sjq+dxb
 +4sDfwnzFLIVCv1lDZHz5TH6XE+ihGcvxW8NdRnUQQzEo8o/kGCwj2i0TNrKKWihPAU83hJUISg
 yrmx+8iWg1WQSJRR+qle8//dFMWYG0WHP8MjgGwL+iENyULcaV7IEotleXgf5TYuvQ28fxP/dmx
 1NOD9AN+gtf6Ia+BEpQeuKgZRqELD6sCDfNqEuUPitoVbJ4N3Q02ZbGzf1F0UbXmmWfVB7B5mhR
 0B5ZPQs0EJkA1VaW42gIMhi6iq70ZZTl9QJFA=
X-Received: by 2002:a5d:64eb:0:b0:474:8aad:2f8 with SMTP id
 ffacd0b85a97d-47f2dd2bd97mr8223971f8f.41.1783883276216; 
 Sun, 12 Jul 2026 12:07:56 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f213e8sm77422974f8f.34.2026.07.12.12.07.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jul 2026 12:07:55 -0700 (PDT)
Message-ID: <24368e1c-171f-4f6b-80f8-58accab1d3be@gmail.com>
Date: Sun, 12 Jul 2026 22:07:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/omap: dsi: avoid sending bta sync all the time in
 writes
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>,
 Marek Vasut <marex@denx.de>, "H. Nikolaus Schaller" <hns@goldelico.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ti.com>
References: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
 <4cb964d9-524d-40ec-8cd2-d936fff8eb85@gmail.com>
 <20260707122203.0bbc973e@kemnade.info>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20260707122203.0bbc973e@kemnade.info>
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


On 7.07.26 г. 13:22 ч., Andreas Kemnade wrote:
> On Tue, 30 Jun 2026 08:42:57 +0300
> Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:
> 
>> Hi,
>> With this version of the patch I see:
>>
>> [  102.760894] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  303.860321] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  307.071624] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  307.360626] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  307.671142] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  308.660339] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  308.961059] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  313.191314] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  313.700378] DSI: omapdss DSI error: Failed to set dsi_if_enable to 0
>> [  313.980346] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  314.791564] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  315.090362] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  322.850952] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  323.111175] DSI: omapdss DSI error: Framedone not received for 250ms!
>>
>> while scrolling the (hildon)desktop on droid4, so I would say the change
>> broke command mode.
>>
> so let me summarize:
> - sending initialisation commands to video mode panel: no problem visible in
>    any case, theretical problems (not seen with the tested panels if sending too much data, fixed via v4.
> - command mode display: no picture and error messages without any bta sync (patch version 1).
> - working display with send_nop() replaced by simply sending bta_sync() and not
>    waiting for PACKET_SENT irq for short packets (v2).
> - partly working display (with v4), (always waiting for PACKET_SENT)
> 
> so there are some situations when waiting for a packet completition is harmful.
> In your case these were only siutations when short packets were sent.
> Do you have a more complete log of v4 boott?
> In the log for v1 which is not accessible anymore, there were other
> more informative timeouts visible.
> 
> But maybe as a wild guess also based on Sasikhos AI reviews, maybe
> this helps:
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 3f22929c36e2..eb3cd0d23cae 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -3267,7 +3267,7 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
>   	 * updates stop working. This is probably related to DSI spec stating
>   	 * that the DSI host should transition to LP at least once per frame.
>   	 */
> -	r = dsi_vc_send_bta_sync(dssdev, vc);
> +	r = dsi_vc_send_bta_sync(dssdev, VC_CMD);
>   	if (r < 0) {
>   		DSSWARN("failed to send bta sync between frames: %d\n", r);
>   		goto err;
> 
> 
> 
> Then the call is equal to the original one done via send_nnop.
> 

With that change it seems to work properly, will keep that version of 
the driver for the time being.

> Regards,
> Andreas
