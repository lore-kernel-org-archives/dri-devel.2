Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4164CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED2A10F045;
	Tue, 29 Sep 2026 21:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hEDAHwYa";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1300710F105
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 21:27:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 963A51A1050;
 Tue, 29 Sep 2026 21:27:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 527F9601BD;
 Tue, 29 Sep 2026 21:27:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 42A3E103295D5; 
 Tue, 29 Sep 2026 23:26:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790717218; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=tyCWPKcs7/u/awFV7vdEON0Q6Y8m/fWoaG5L+nCraDc=;
 b=hEDAHwYakn5fRG4BUqIJO2Nc30p4PMlNz2fj/hv9u5oIYxFTNITCpy13PVRNtyY3TfIP4D
 k7jJU1roWG08YKb+1I8DM4KpYXcjGdkvBVVnmNFMn5+EBn9jC6Uh0jXXV5PKV+GhHpJQsT
 S9iWGlmrD0ZOKOKCkpyyRoR7Ao382WBj9MX7dbQoYWZHjooOEl+IQvBYTAOTixSWzsHJc9
 e5d+9lXIl5FrPOnUx1GVztDB5fjD4JBjpieZrAZa/M4aJuOhVPcFY0tDHEAl5pfc5S6c9p
 WxdZmPtYu1kfOZIBzqMvqblrCge95WF2E0SmMoPMsQqDkPM0SRajhSjVeMKaHg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 23:26:43 +0200
Message-Id: <DLS49QCTEANL.D6E2UDEOG4O9@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 2/7] drm: verisilicon: stop using deprecated
 devm_drm_of_get_bridge()
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Doug Anderson"
 <dianders@chromium.org>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray"
 <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
 "kernel test robot" <lkp@intel.com>
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frank Li"
 <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, =?utf-8?q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, "Raspberry Pi Kernel Maintenance"
 <kernel-list@raspberrypi.com>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>
X-Mailer: aerc 0.22.0
References: <20260929-drm-fix-of_get_bridge-build-regression-v2-0-6da431d8f180@bootlin.com>
 <20260929-drm-fix-of_get_bridge-build-regression-v2-2-6da431d8f180@bootlin.com>
 <e044caae8c2160d96a29073bb1e60efff5883513.camel@iscas.ac.cn>
In-Reply-To: <e044caae8c2160d96a29073bb1e60efff5883513.camel@iscas.ac.cn>
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

Hello,

On Tue Sep 29, 2026 at 4:42 PM CEST, Icenowy Zheng wrote:
> =E5=9C=A8 2026-09-29=E4=BA=8C=E7=9A=84 15:39 +0200=EF=BC=8CLuca Ceresoli=
=E5=86=99=E9=81=93=EF=BC=9A
>> devm_drm_of_get_bridge() is deprecated, switch to
>> of_drm_get_bridge_by_endpoint(). As of_drm_get_bridge_by_endpoint()
>> returns
>> a refcounted bridge, ensure it is put by using bridge.next_bridge.
>>
>> Fixes build failure when CONFIG_OF is disabled.
>>
>> Fixes: aa8a8c7e4641 ("drm/bridge: panel: move all code to
>> drm_panel.c")
>> Reported-by: Arnd Bergmann <arnd@kernel.org>
>> Closes:
>> https://lore.kernel.org/r/20260928161605.2271412-1-arnd@kernel.org
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes:
>> https://lore.kernel.org/oe-kbuild-all/202609291109.OIsGTysr-lkp@intel.co=
m/
>> Closes:
>> https://lore.kernel.org/oe-kbuild-all/202609290408.BOs7sk55-lkp@intel.co=
m/
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> Checked the code in drm_bridge.c, and it looks like the lifetime of
> next_bridge should be indirectly managed by devm when
> devm_drm_bridge_alloc() successes and the next_bridge field assigned,
> so the only explicit put needed here should be in the alloc failure
> path.

Exactly.

I think vs_bridge_init() could be simplified a bit by moving the 'next =3D
...;' statement (with error management trailer) to after
devm_drm_bridge_alloc. This would avoid the explicit drm_bridge_put() call
added by this patch.

However for this regression fix I preferred to keep the diff minimal. The
cleanup mentioned above can be done later.

> Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

Thanks for reviewing!

>> Changes in v2:
>> - fix bridge reference leak on attach error path
>
> It should be `bridge alloc error` instead of `attach error`, but I
> don't know how to correct the error in the changelog, and anyway it
> won't be part of the final commit.

Ah, right, that's a copy-paste leftover. It's correct that it won't appear
in the commit, so I won't sent a new iteration for this.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
