Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E89FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB29710F2AF;
	Thu, 30 Apr 2026 09:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="UxvRzmOD";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36DD010F2B1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:05:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 68FC01A3488;
 Thu, 30 Apr 2026 09:05:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3BF9660495;
 Thu, 30 Apr 2026 09:05:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 95AA710729FBD; 
 Thu, 30 Apr 2026 11:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777539936; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=PD/RBvG0tika4WQOlK7lbn7RBjWTyLutXnF4l1j9Jzo=;
 b=UxvRzmODfHMo12B0XNI9V/YNYvaJ2APi/IS+VypBrK1o2YYm6ZFeM+ylGBSh9PuYRtwJCZ
 XrTcbdErN1ec2QNmnQ+Ww2PtqdkwpY+aJFeUv5wow8sTV8Y4m2K0S1NWZHHx8JR+YXYrZ9
 UCkKQbdIwmb4s8C5GU5Pg8gG5kaokfPZC55i9wcQ8auyGaOeRnEQJH4TM9k3+DAFwW1tMx
 WnZws7T+iby3lYJW0KytEiR4mntj7K1ykbSZwMRcxOYYbUr4Ii/gTTt2/bI20e1s4X7FMd
 p0Jw/kjLJ5crw829mIECy5orWM+17rThwhC6jOsG2fvG8dRJb/boLa/fvQvKww==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 11:05:30 +0200
Message-Id: <DI6DBEZ98XQD.53GKJABIWR3G@bootlin.com>
To: "Vitor Soares" <ivitro@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v4] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
Cc: "Vitor Soares" <vitor.soares@toradex.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>
X-Mailer: aerc 0.20.1
References: <20260407144142.1420354-2-ivitro@gmail.com>
 <DI6C5A83IG4B.1UV6WJMFQ9AA7@bootlin.com>
 <19d0a0b1d33061a0421edf883acaaa7e366646c2.camel@gmail.com>
In-Reply-To: <19d0a0b1d33061a0421edf883acaaa7e366646c2.camel@gmail.com>
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

Hello Vitor,

On Thu Apr 30, 2026 at 10:52 AM CEST, Vitor Soares wrote:

>> > -static UNIVERSAL_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend,
>> > cdns_dsi_resume,
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 NULL);
>> > +static const struct dev_pm_ops cdns_dsi_pm_ops =3D {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RUNTIME_PM_OPS(cdns_dsi_sus=
pend, cdns_dsi_resume, NULL)
>> > +};
>>
>> Not an expert here, but the docs [0] suggest using
>> DEFINE_RUNTIME_DEV_PM_OPS(). Is there a good reason to not do so?
>>
>> [0]
>> https://elixir.bootlin.com/linux/v7.0.1/source/include/linux/pm.h#L455-L=
456
>>
>> Luca
>>
>
> In an earlier discussion [0], we concluded that bridges/panels should onl=
y deal
> with runtime PM:

Ah, good. Then please mention this in the commit message in v5. It can help
others doing the right thing in future similar cases.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
