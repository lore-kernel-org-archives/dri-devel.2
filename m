Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A876C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D14810ED19;
	Tue,  1 Sep 2026 14:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="NLej3Sc/";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD2710ED19
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 14:30:57 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 262F04E414A3;
 Tue,  1 Sep 2026 14:30:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E35136053C;
 Tue,  1 Sep 2026 14:30:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 62D2C11C79234; 
 Tue,  1 Sep 2026 16:30:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788273049; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=+SEPBPnaaE0LCIqhjI7PwprpKGHWB+21uuj8eFSigLY=;
 b=NLej3Sc/QvZOoqlMcpCbBhdu5MPiAZEiyD32wu0ObWi0RpuObX21Vsd+l4pT/MZyPt+oP2
 Z4G04eoXzCCZPj1TRg0ksHctT86m2HlV6QVDNQJRPqmIfJ3lU/weh8mGvWh63h2aKl0csK
 a26N1WniKpNa9fmjKC2PWCE2o5VtihHZ0dFChrTd089WE3Xta6cU/A8IS+VJm9h3nsqPSQ
 XhYw7jUZjjFKiOJoa95TEPjjSPRUrrPYllTwVq8X5Oe6HGJ7HEILUlMqqefqNCGHAaXDXg
 nyXhnza+eg2J+ut0k6cAW+1JnmnmVNgv/RQdyiGsIDDZ9pxe+e5SoL2aL1Erog==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 16:30:40 +0200
Message-Id: <DL41VXI6IT94.CXUS4CYX1WJO@bootlin.com>
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
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Maxime Ripard"
 <mripard@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <DKR7VTBLRBQW.2LLJMDO74KXNO@bootlin.com>
 <20260824-cuddly-aardwark-of-reward-0d93d4@houat>
 <DKX8KDDOTPM7.3OS616IO3E4UA@bootlin.com> <apBGjqt9GI5egQW6@houat>
 <DL3ZJBN3TALE.XBW7KL51XGBO@bootlin.com>
In-Reply-To: <DL3ZJBN3TALE.XBW7KL51XGBO@bootlin.com>
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

On Tue Sep 1, 2026 at 2:40 PM CEST, Luca Ceresoli wrote:

[...]

>>> >> > And we'd essentially move drm_panel_bridge into drm_panel.c, and m=
ake it
>>> >> > private.
>>> >>
>>> >> Yes in theory, but the panel_bridge code uses other parts of the
>>> >> drm_kms_helper module: drm_atomic_helper and drm_probe_helper, maybe=
 more,
>>> >> so we'd have to move them into the drm module too.
>>> >
>>> > Ah, right. What would happen if we were doing it the other way around
>>> > then? Move drm_panel out of the main drm module?
>>>
>>> Into the drm_kms_helper module?
>>>
>>> I had a look and did some experiments and I found at least one user in =
the drm
>>> module calling a drm_panel API, and guess who:
>>>
>>>  drm_of_find_panel_or_bridge() (in drm_of.c, drm module)
>>>     -> calls of_drm_find_panel (in drm_panel.c, drm_kms_helper module)
>>>
>>> Based on our discussion after patch 3, I'm not sure
>>> drm_of_find_panel_or_bridge() will disappear soon. If it doesn't, I gue=
ss
>>> we can try to move drm_of_find_panel_or_bridge() into bridge/panel.c wh=
ich
>>> is in the drm_kms_helper module (and from drm_of.h info
>>> drm_bridge.h?). That however might trigger build failures for drivers w=
hich
>>> currently don't select DRM_KMS_HELPER and which would have to select it=
.
>>>
>>> I'll give it a try, and if I see major drawbacks I will get back to mov=
ing
>>> all the drm_kms_helper code into the main drm module.
>>
>> No, I meant into its own module.
>
> Looks like a good idea indeed, making the design more modular and
> dependencies cleaner.
>
>> Do we have any dependency from the main
>> drm module into drm_panel?
>
> As far as I can see there is only the one mentioned above:
>
>   drm_of_find_panel_or_bridge() (in drm_of.c, drm module)
>      -> calls of_drm_find_panel (in drm_panel.c, would-be the new drm_pan=
el module)
>
> And while drm_of_find_panel_or_bridge() is possibly going to disappear at
> the end of my series, moving drm_panel.c to its own module would make the
> series non-build-bisectable, which would be very annoying.
>
> However there seem to be no calls from the drm module to
> drm_of_find_panel_or_bridge(), so we could move it out as well. What abou=
t
> a series doing, in this order:
>
>  - move drm_of_find_panel_or_bridge() from the drm module to the
>    drm_kms_helper module
>  - move drm_panel.c to a new drm_panel module
>  - Main change: embed a drm_bridge into every panel
>  - convert drivers to stop using the panel_bridge, hopefully removing all
>    calls to drm_of_find_panel_or_bridge()
>  - remove drm_of_find_panel_or_bridge()

Ah, no, that won't work. There would be a circular module dependency loop
later on when we embed a drm_bridge into evern drm_panel: indeed at that
point drm_panel will use the atomic and probe helpers to implement the
embedded drm_bridge, resulting in:

 * the panel_bridge code in bridge/panel.c [drm_kms_helper module]
   already depends on the drm_panel.c code (it manipulates a drm_panel, OK)
 * additionally, the drm_panel.c code, in order to create a drm_bridge,
   will depend on the helpers in drm_atomic_helper and drm_probe_helper
   code [drm_kms_helper module]

The loop is only between kernel modules (.ko), not in actual code. So I
think this revised plan should work (the 2nd bullet is key):

 - move drm_of_find_panel_or_bridge() from the drm module to
   bridge/panel.c [currently drm_kms_helper module]
 - move bridge/panel.o to a new drm_panel_bridge module (NEW)
 - move drm_panel.c to a new drm_panel module
 - Main change: embed a drm_bridge into every panel
 - convert drivers to stop using the panel_bridge, hopefully removing all
   calls to drm_of_find_panel_or_bridge()
 - remove drm_of_find_panel_or_bridge() and all the drm_panel_bridge module

What do you think about it?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
