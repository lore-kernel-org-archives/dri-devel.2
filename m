Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F889C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D857E10E200;
	Mon, 24 Aug 2026 14:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="NbanBEQx";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDB410E200
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 14:16:09 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 713ED4E41390;
 Mon, 24 Aug 2026 14:16:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 43D295FFC1;
 Mon, 24 Aug 2026 14:16:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0FE8E11C795D8; 
 Mon, 24 Aug 2026 16:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787580966; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Zf0KL8Nd4r8e4Ibe00ifNgF23wtodVjSERnQ8l/c2oM=;
 b=NbanBEQx5A1hemTI21jYL7GzB9fZLK6G7NODgpwIeZsxeqqOMMx9vhX/cxMFJde4PnDGYS
 dk7nkyCLBm5iX4yKRgYvOeHhoCXRp+MviSqqFLz2NhQnX89gLCJV0RUKFEQHjuvfg9yoiW
 WJuLiWDG/epClSmAWfIdnETaDpzvEj9I5NY8yA+9CnDloucQp4AyJ4iCf44HgAqsYBY/N8
 xT8EAh1sxq3mu9bA9KSGs9dwviCVndk2aZOLNFUdyeWymSfMC1VD3TPDYdsohXF5guLgmB
 g0qIZ4ln7tnWg6rlPN6eJq1TGkiNIxG4GilajqXjYynALFyzGVKLy2YJ0inEaA==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 16:16:02 +0200
Message-Id: <DKX8KDDOTPM7.3OS616IO3E4UA@bootlin.com>
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
To: "Maxime Ripard" <mripard@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.22.0
References: <DKR7VTBLRBQW.2LLJMDO74KXNO@bootlin.com>
 <20260824-cuddly-aardwark-of-reward-0d93d4@houat>
In-Reply-To: <20260824-cuddly-aardwark-of-reward-0d93d4@houat>
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

On Mon Aug 24, 2026 at 9:48 AM CEST, Maxime Ripard wrote:
> On Mon, Aug 17, 2026 at 02:27:58PM +0200, Luca Ceresoli wrote:
>> On Mon Aug 17, 2026 at 10:31 AM CEST, Maxime Ripard wrote:
>> > On Fri, Aug 14, 2026 at 04:05:52PM +0200, Luca Ceresoli wrote:
>> >> Work is in progress to make every drm_panel automatically create a
>> >> panel_bridge [0][1].
>> >>
>> >> This requires the panel code to call the drm_panel_bridge APIs. Howev=
er
>> >> this would create a circular dependency loop on modular builds:
>> >>
>> >> __devm_drm_panel_alloc() [drm]
>> >>    -> drm_panel_bridge_add() [drm_kms_helper]
>> >>       -> drm_bridge.c APIs [drm]
>> >>
>> >> Moving just the panel_brige.o file from [drm_kms_helper] to [drm] doe=
s not
>> >> work because the panel bridge code uses the drm_atomic_helper and
>> >> drm_probe_helper which add further dependencies on symbols in the
>> >> [drm_kms_helper] module.
>> >>
>> >> So take a simple approach, and move the entire drm_kms_helper into th=
e
>> >> [drm] module.
>> >>
>> >> Link: https://lore.kernel.org/all/emuj2innmp6zmzd7pyakqzjqpdzhly6qfha=
kya3ydwmd63pl26@5jwxaidpikjw/ [0]
>> >> Link: https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-8-9=
d6f2c9c3058@bootlin.com/ [1]
>> >> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> >
>> > So, that's not an option. However, why do we need drm_panel_bridge_add=
()
>> > after this work is done? If we want to create a bridge for every panel=
,
>> > then the bridge implementation can live in drm_panel.c, which is part =
of
>> > the drm module.
>> >
>> > And we'd essentially move drm_panel_bridge into drm_panel.c, and make =
it
>> > private.
>>
>> Yes in theory, but the panel_bridge code uses other parts of the
>> drm_kms_helper module: drm_atomic_helper and drm_probe_helper, maybe mor=
e,
>> so we'd have to move them into the drm module too.
>
> Ah, right. What would happen if we were doing it the other way around
> then? Move drm_panel out of the main drm module?

Into the drm_kms_helper module?

I had a look and did some experiments and I found at least one user in the =
drm
module calling a drm_panel API, and guess who:

 drm_of_find_panel_or_bridge() (in drm_of.c, drm module)
    -> calls of_drm_find_panel (in drm_panel.c, drm_kms_helper module)

Based on our discussion after patch 3, I'm not sure
drm_of_find_panel_or_bridge() will disappear soon. If it doesn't, I guess
we can try to move drm_of_find_panel_or_bridge() into bridge/panel.c which
is in the drm_kms_helper module (and from drm_of.h info
drm_bridge.h?). That however might trigger build failures for drivers which
currently don't select DRM_KMS_HELPER and which would have to select it.

I'll give it a try, and if I see major drawbacks I will get back to moving
all the drm_kms_helper code into the main drm module.

>> Is it worth trying to identify only the closure of files in drm_kms_help=
ers
>> that are actually used by the panel_bridg, and move only them? That'd me=
an
>> having some *_helper.c files in the drm module and other *_helper.c file=
s
>> in the drm module.
>>
>> There's a licensing aspect too: drm_panel.c is MIT-licensed, bridge/pane=
l.c
>> is GPL-2.0-or-later. However my understanding is that we can merge the t=
wo
>> into a single file and the result would all be GPL-2.0-or-later, so that=
 is
>> an option.
>
> Yeah, that's not a concern.

Good, thanks for the feedback on this.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
