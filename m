Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CB2C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B5A10EF93;
	Wed,  9 Sep 2026 07:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pT/a3oqC";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 754EB10EF93
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 07:52:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id ADCCB1A1A73;
 Wed,  9 Sep 2026 07:52:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7BD1060448;
 Wed,  9 Sep 2026 07:52:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 603A011C7AF4F; 
 Wed,  9 Sep 2026 09:52:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788940336; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=JAvW8vyFsOHN+djQaHC9viq07f5HEJTSFyQy/FJZP+8=;
 b=pT/a3oqCMaEh+7KfHHiVbinaY1Rk29A+MNmHdwy2pqPEIffvpg02DAa03svSjfNC58rRf7
 ZEfEbKh7HH0j/0AaC8UhaRq3QKAgqRTytK/V7LdyB9uIW8uUqFJisaaO1zWGwIujfaUlDf
 P1sp+QhXS57hjTR9eWOs19rP4cJWDOBq0wucHNMAP01AhXTN1mATAXoGfDzClOxzz/fZRy
 k/7sKMJL3BKVx4De2IjbhKTP4EftHY9LNBM+SjG93kCFzvEbnIReDYmgNCfbvUjp/xsVR8
 w7bvg8zstsxSxGMQd1EXNmtIKSIuwJIE90oFU0gsemmxMRKFJ7nXNIy7AV/sbA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Sep 2026 09:52:05 +0200
Message-Id: <DLAMF47GKNSA.1PJ5V8Z86U1C6@bootlin.com>
To: "Jani Nikula" <jani.nikula@linux.intel.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Linus Walleij" <linusw@kernel.org>, "Inki Dae"
 <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH RFC v2 05/19] drm/panel: embed a drm_bridge into every
 drm_panel
Cc: "Albert Esteve" <aesteve@redhat.com>, "Anusha Srivatsa"
 <asrivats@redhat.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>,
 "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?=
 <ville.syrjala@linux.intel.com>
X-Mailer: aerc 0.22.0
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-5-2ab8ee24538e@bootlin.com>
 <678ddef7e56703d9adffff5c490d4857af515343@intel.com>
In-Reply-To: <678ddef7e56703d9adffff5c490d4857af515343@intel.com>
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

Hello Jani,

On Tue Sep 8, 2026 at 6:18 PM CEST, Jani Nikula wrote:
> On Thu, 03 Sep 2026, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
>> Adding a drm_panel does currently not add a panel_bridge wrapping
>> it. Usually the panel_bridge creation happens later, when some other dri=
ver
>> (e.g. the previous bridge or the encoder) calls *_of_get_bridge() and th=
e
>> following element in the pipeline is a panel.
>>
>> This has some drawbacks:
>>
>>  * the bridge API is currently the best practice to access various
>>    components of the pipeline, especially with complex cards where bridg=
es
>>    can be combined in different ways on different hardware
>>  * the panel_bridge is not created in the context of the driver of the
>>    underlying physical device (the panel driver), but of some other driv=
er
>>  * that other driver is not aware of whether the returned drm_bridge
>>    pointer is a panel_bridge created on the fly, a pre-existing
>>    panel_bridge or a non-panel bridge
>>  * removal of a panel_bridge requires calling drm_panel_bridge_remove(),
>>    but that other driver doesn't know whether this is needed because it
>>    doesn't know whether it has created a panel_bridge or not
>>
>> Other drivers call [a variant of] drm_panel_bridge_add(), which also has
>> some of the above drawbacks.
>>
>> So far the current approach was working mostly because devm and drmm ens=
ure
>> the panel bridge would be dealloacted at some later point. However with =
the
>> upcoming implementation of bridge hotplug and dynamic bridge lifetime th=
is
>> will get more complicated.
>>
>> Switch to the new approach: embed a drm_bridge inside every drm_panel,
>> which behaves just like the current drm_panel_bridge.
>
> What does this mean for drivers like i915 that use drm_panel *only* for
> handling panel followers? We don't need the bridge for anything. It'll
> just be excess midlayer baggage.

i915 does not call drm_bridge_attach() nor drm_bridge_add(), right? So the
newly embedded bridge would not even be observable, it would not even be in
the global bridge_list. The only effect would be some extra allocated
memory.

> I'm also concerned about the embedded struct drm_connector being added,
> since that can't and will not be a drm_connector that we'll use.

The drm_connector is added only if drm_bridge_attach() is called (with the
DRM_BRIDGE_ATTACH_NO_CONNECTOR flag not set). As above, i915 does not call
drm_bridge_attach() at all, so no drm_connector is added.

> All of
> our drm_connector are embedded in intel_connector, and all of our
> codebase expects this, and we init them ourselves. Having additional
> drm_connector (not embedded in intel_connector) added by library code
> *will* oops in our driver.

It would be great if you could test this series (even without reviewing if
you can't). Based on my analysis above there should be no regression, and
having that confirmed runtime would be helpful.

And if you can review, this is the one patch that matters. The following
only affect bridge-based drivers. The previous ones are about moving code
around across modules and will be different in v4.

> I haven't had the time for an in-depth look, but it feels like this
> assumes a certain driver model, instead of providing building blocks for
> drivers to use.

For drivers not using drm_bridge, this patch should be just implementation
details changes and some more allocated memory.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
