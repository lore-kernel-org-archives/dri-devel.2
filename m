Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDE5C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D08A10E792;
	Mon, 17 Aug 2026 12:28:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="r1nF2FtB";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057C310E792
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:28:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 987E01A16D0;
 Mon, 17 Aug 2026 12:28:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4D51760352;
 Mon, 17 Aug 2026 12:28:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 13ABE11C723F4; 
 Mon, 17 Aug 2026 14:27:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786969684; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Zo0FIoAv//5JsQywcLuHcbJ3nZRRce8imVX9S9Mgkg8=;
 b=r1nF2FtBb4lHdJsdpYRIL6M5jE36wrkh9yBYIVU2tccRYGAUWq+VZ2rPXN7yrfTSJHuOcf
 mYSqIKA088RquW9ipsNnJmmSsQ6dB7LpYxcSBMTf11Ek21twydWyleMjWrUhpbWjxqST4O
 uUS1hcMJtkh939lp+f8hkt2q6EGkQdDxAng+flZR3j560tQ8MKDV6cs9f9w4fYQP8/Waa5
 jBv5fK9IKL0QfOP1TmtIoz8Hgo+AC6fYXyuaLUMSaTq2opFarTkvFDalOW7XncCau7I7yt
 mAWtvidecpiAVYeJ0zOXfT73xuBux9Xmpl8JwwVheDnFKS1S92585My1bppOPw==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 14:27:58 +0200
Message-Id: <DKR7VTBLRBQW.2LLJMDO74KXNO@bootlin.com>
To: "Maxime Ripard" <mripard@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 04/11] drm/panel: merge the drm_kms_helper module into
 the drm module
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Linus Walleij" <linusw@kernel.org>, "Inki Dae"
 <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>,
 "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.22.0
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-4-19cd5277cc8d@bootlin.com>
 <20260817-lumpy-wooden-bird-4bdfb4@houat>
In-Reply-To: <20260817-lumpy-wooden-bird-4bdfb4@houat>
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

Hi Maxime,

On Mon Aug 17, 2026 at 10:31 AM CEST, Maxime Ripard wrote:
> On Fri, Aug 14, 2026 at 04:05:52PM +0200, Luca Ceresoli wrote:
>> Work is in progress to make every drm_panel automatically create a
>> panel_bridge [0][1].
>>
>> This requires the panel code to call the drm_panel_bridge APIs. However
>> this would create a circular dependency loop on modular builds:
>>
>> __devm_drm_panel_alloc() [drm]
>>    -> drm_panel_bridge_add() [drm_kms_helper]
>>       -> drm_bridge.c APIs [drm]
>>
>> Moving just the panel_brige.o file from [drm_kms_helper] to [drm] does n=
ot
>> work because the panel bridge code uses the drm_atomic_helper and
>> drm_probe_helper which add further dependencies on symbols in the
>> [drm_kms_helper] module.
>>
>> So take a simple approach, and move the entire drm_kms_helper into the
>> [drm] module.
>>
>> Link: https://lore.kernel.org/all/emuj2innmp6zmzd7pyakqzjqpdzhly6qfhakya=
3ydwmd63pl26@5jwxaidpikjw/ [0]
>> Link: https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-8-9d6f=
2c9c3058@bootlin.com/ [1]
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> So, that's not an option. However, why do we need drm_panel_bridge_add()
> after this work is done? If we want to create a bridge for every panel,
> then the bridge implementation can live in drm_panel.c, which is part of
> the drm module.
>
> And we'd essentially move drm_panel_bridge into drm_panel.c, and make it
> private.

Yes in theory, but the panel_bridge code uses other parts of the
drm_kms_helper module: drm_atomic_helper and drm_probe_helper, maybe more,
so we'd have to move them into the drm module too.

Is it worth trying to identify only the closure of files in drm_kms_helpers
that are actually used by the panel_bridg, and move only them? That'd mean
having some *_helper.c files in the drm module and other *_helper.c files
in the drm module.

There's a licensing aspect too: drm_panel.c is MIT-licensed, bridge/panel.c
is GPL-2.0-or-later. However my understanding is that we can merge the two
into a single file and the result would all be GPL-2.0-or-later, so that is
an option.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
