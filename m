Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B39C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4836110E7E4;
	Mon, 17 Aug 2026 14:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="rv+W1/GM";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E6110E7E4
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:07:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 730C84E41286
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:07:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 47A3F60352;
 Mon, 17 Aug 2026 14:07:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 45CBE11C7255F; 
 Mon, 17 Aug 2026 16:07:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786975631; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=neeTnhFCPrLEULwNE5j34qE8Xbu8lTUqW1ScQVTSx4g=;
 b=rv+W1/GMRT/f/I73Ytc7gNzN9lRI/6+QyGO7P8qXKdY4UrEcV8/m7EvS+smXD3dE117sTV
 fFLEonEUuMhH8cltoGS/kBd8q5xTa1rbL4FyBZiCzGca/Wu6nWaH105rTgO+B1wXd56x7s
 0dXg/88sKgHv/R4neIaqeIKIuLXszuALvmc21X9x8NedFf5IZ9mqzP67UY6++pEv+o9FTi
 Y1pFH8wJzcNOAdMk4cjA6c6M80N4triollKWDXu9tf4LcdZV6mmNhzQn3b9HmoAvHVEMtS
 z88qKWe+nl2vEnSYUOFpSSY2aea2V0+NA2BPC1uV6JeBPq/igkSUETeBSItZHQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 16:07:08 +0200
Message-Id: <DKR9ZQU9NION.356R4T9TWHLU@bootlin.com>
Cc: <dri-devel@lists.freedesktop.org>
To: <sashiko-reviews@lists.linux.dev>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 05/11] drm/bridge: panel: add a panel_bridge to every panel
X-Mailer: aerc 0.22.0
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-5-19cd5277cc8d@bootlin.com>
 <20260814142511.C06CC1F000E9@smtp.kernel.org>
In-Reply-To: <20260814142511.C06CC1F000E9@smtp.kernel.org>
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

On Fri Aug 14, 2026 at 4:25 PM CEST, sashiko-bot wrote:

[...]

>> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
>> index f8f6082e637fd..95fc95d1b4b7a 100644
>> --- a/drivers/gpu/drm/drm_panel.c
>> +++ b/drivers/gpu/drm/drm_panel.c
>> @@ -453,6 +453,9 @@ void *__devm_drm_panel_alloc(struct device *dev, siz=
e_t size, size_t offset,
>>
>>  	drm_panel_init(panel, dev, funcs, connector_type);
>>
>> +	panel->bridge =3D devm_drm_panel_bridge_add(dev, panel);
>> +	WARN_ON(!panel->bridge);
>
> [Severity: Medium]
> Will this check actually catch failures? devm_drm_panel_bridge_add()
> returns an ERR_PTR on failure, rather than NULL.

Indeed, will fix in v2.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
