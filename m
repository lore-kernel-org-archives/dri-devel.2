Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6598DC79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9434310EF9A;
	Wed,  9 Sep 2026 07:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Lt/+87uH";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2944E10EF9A
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 07:59:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 4AAF34E415A5;
 Wed,  9 Sep 2026 07:59:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1B33460448;
 Wed,  9 Sep 2026 07:59:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E2ED111C7AF4F; 
 Wed,  9 Sep 2026 09:59:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788940791; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=mWenwxJaVXuw7i45r0gHdDBThL3IhF+WJaX/aAejYJc=;
 b=Lt/+87uHxw+W/A2M2bPpW5ISE5iSY306ehRzcs9AG7lhX5jk6aYLAbFKAN5jTHU9JL7eDB
 k2my1Bhl7HuTdbh/R5KMglLjckyWCVCZdzbwTRd9iz8U/nK3cKqNXhEK6puy4h9aq8qwx3
 DopbxIqiQRJfwwC4ZGTkdWF+HMNHYdLG+3gCHNyFn0CMAhVIbHv6jmZ2LYB/vpHmB2tNaU
 k3Ues6IQGW6BXaro7dYnTgwjjYt8lDNftkgn4F/2CgWkLZ3fL5/0Ti85Lmu9TwYjZXF/hw
 PiE97Rs8ZymTDRG/++SuzgbWgxTnO3A42TioXRPuS9oTK5nSLS1u6eEB4BkThw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Sep 2026 09:59:44 +0200
Message-Id: <DLAMKYQBMHHB.Q2Y1S9HH501C@bootlin.com>
Subject: Re: [PATCH RFC v2 05/19] drm/panel: embed a drm_bridge into every
 drm_panel
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Linus Walleij" <linusw@kernel.org>, "Inki Dae"
 <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Albert Esteve"
 <aesteve@redhat.com>, "Anusha Srivatsa" <asrivats@redhat.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Maxime Ripard" <mripard@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-5-2ab8ee24538e@bootlin.com>
 <aplG-skzq-TPfFZQ@houat> <DL5Q0MLS0KT9.24LJK2Q1L89KP@bootlin.com>
 <aqAld6W-JmrKLK_9@houat>
In-Reply-To: <aqAld6W-JmrKLK_9@houat>
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

On Tue Sep 8, 2026 at 5:21 PM CEST, Maxime Ripard wrote:

[...]

>> > So there's a lot to unravel, and I wished you had split it, but I can'=
t
>> > find a good way to split it either.
>>
>> As I see it, this could be maybe split in 2:
>>
>>  - copy all needed symbols from bridge/panel.c (or move or whatever, see
>>    discussion below) without using them
>>  - change _alloc, _get, _put etc to actually embed the bridge and start
>>    using the copied/moved symbols
>>
>> Would you prefer that?
>>
>> Note the second bullet, which is the core change, is pretty small, I thi=
nk
>> a <100 lines diff, but I don't think it can be split further.
>
> Yeah, that's why I'm not sure it's going to make a big difference
> anyway. Sometimes it's just not great and there's nothing to do about
> it, really :/

Indeed.

I think however I'll do the split (two bullets above), as I think it would
help clarifying the actual functional changes introduced by this patch. I
hope the smaller diff will help Jani understand the impact on no-bridge
drivers like i915.

>> >> +int drm_bridge_set_connector_orientation(const struct drm_bridge *br=
idge,
>> >> +					 struct drm_connector *connector)
>> >> +{
>> >> +	struct drm_panel *panel =3D drm_bridge_to_panel(bridge);
>> >> +
>> >> +	return drm_connector_set_orientation_from_panel(connector, panel);
>> >> +}
>> >> +EXPORT_SYMBOL(drm_bridge_set_connector_orientation);
>> >
>> > I don't think we should create new ones. Just move the code from
>> > bridge/panel here and remove it there. The only thing left will be the
>> > panel_bridge_add() variants that become almost trivial now, and you ca=
n
>> > cleanup the drivers in later patches.
>>
>> What do you mean by "move" exactly? Really move all relevant functions f=
rom
>> bridge/panel.c into drm_panel.c, so evey user driver will depend on the =
new
>> drm_panel module instead of the old one for these symbols?
>
> Yes. Basically, I don't want to end up in a situation where we have
> competing implementations of the same function and we have to mess
> around with names to accomodate one or the other.

Makes sense, sure. I'll target that for v4.

>> > This also allows to get rid of all the symbol renaming, which isn't
>> > great in itself, but also the existing names were good so it's hard to
>> > come with better ones.
>>
>> I think the names in bridge/panel.c make sense there, but not in
>> drm_panel.c. Here's my interpretation (using atomic_enable as an example=
):
>>
>>  - panel_bridge_atomic_enable
>>    ^^^^^^^^^^^^ <- this is about the panel_bridge
>>
>>  - drm_panel_bridge_atomic_enable
>>    ^^^^^^^^^        <- this is drm_panel stuff
>>              ^^^^^^ <- and specifically about the bridge embedded in drm=
_panel
>>
>> Does it make sense to you too in this perspective?
>
> It's an internal symbol anyway, right? So it's really doesn't matter
> that much to me.

OK.

Anyway, renaming does not make sense based on the above (moving the
panel_bridge code into drm_panel.c).

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
