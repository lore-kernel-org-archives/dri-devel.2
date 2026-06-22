Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF54CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D7B310E72A;
	Mon, 22 Jun 2026 14:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="L0W1hwDq";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B2610E72D
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 14:50:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7A3514E405FA;
 Mon, 22 Jun 2026 14:50:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 48C55601BB;
 Mon, 22 Jun 2026 14:50:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 58BA8106C89E2; 
 Mon, 22 Jun 2026 16:50:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782139818; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=n5qMJLNDiGXs4pnTrNastkVamafcDooSErVbTVRma4Y=;
 b=L0W1hwDqBkBibcfhZK58/gtsLQg2QZLrNAi0dY0EjhRIS5bKAdhbgPfrj4xP6PgUZx2PK8
 UUtiIcjFE5lhK6xKchVNuRaYSwFE02Z6kReox6Ev4w/GVHA+xS30yzNlCBJEi4Y2O3RQZe
 PYqGiLX+BYg1WfUW86CoYUj4AbXgRaGt3ERvEB8Ow/DQgXPyeu+UOYyiabfUC85FOS9Psy
 AsNYdlrTfY0ALYEEfJ0p1m5AL/Fn5B7pSHO8DqyiGDJMzQWXqeBigR1OXDU917MsfVWILU
 XykOpDUr2Z+oeUK41UfkUxsGxB4GrnTT9iOT0PD13rY3g09kMD2hU7QxAntJjQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 16:50:06 +0200
Message-Id: <DJFNU4L6YNVS.2OXF28HEUNZO3@bootlin.com>
Subject: Re: [PATCH] drm: Use named initializers for arrays of i2c_device_data
Cc: "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Jagan Teki" <jagan@amarulasolutions.com>, "Liu
 Ying" <victor.liu@nxp.com>, "Adrien Grassein" <adrien.grassein@gmail.com>,
 "Peter Senna Tschudin" <peter.senna@gmail.com>, "Martyn Welch"
 <martyn.welch@collabora.co.uk>, "Russell King" <linux@armlinux.org.uk>,
 "Douglas Anderson" <dianders@chromium.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Biju Das"
 <biju.das.jz@bp.renesas.com>, "Tommaso Merciai"
 <tommaso.merciai.xr@bp.renesas.com>, "Manikandan Muralidharan"
 <manikandan.m@microchip.com>, "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Andy Yan" <andy.yan@rock-chips.com>, "Xin Ji" <xji@analogixsemi.com>,
 "Loic Poulain" <loic.poulain@oss.qualcomm.com>, "Fei Shao"
 <fshao@chromium.org>, "Arnd Bergmann" <arnd@arndb.de>, "Kees Cook"
 <kees@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Lyude Paul" <lyude@redhat.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Marcus Folkesson"
 <marcus.folkesson@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <20260518100401.631351-2-u.kleine-koenig@baylibre.com>
 <aimbWuKkPZdKuO5f@monoceros>
In-Reply-To: <aimbWuKkPZdKuO5f@monoceros>
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

On Wed Jun 10, 2026 at 7:15 PM CEST, Uwe Kleine-K=C3=B6nig (The Capable Hub=
) wrote:
> Hello,
>
> On Mon, May 18, 2026 at 12:04:01PM +0200, Uwe Kleine-K=C3=B6nig (The Capa=
ble Hub) wrote:
>> While being less compact, using named initializers allows to more easily
>> see which members of the structs are assigned which value without having
>> to lookup the declaration of the struct. And it's also more robust
>> against changes to the struct definition.
>>
>> The mentioned robustness is relevant for a planned change to struct
>> i2c_device_id that replaces .driver_data by an anonymous union.
>>
>> While touching all these arrays, unify usage of whitespace in the list
>> terminator and drop trailing commas there.
>>
>> This patch doesn't modify the compiled arrays, only their representation
>> in source form benefits. The former was confirmed with x86 and arm64
>> builds.
>>
>> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@=
baylibre.com>
>
> who feels responsible to pick up this patch?

The affected files are mostly in drm-misc so I could apply it, but I think
we'd need an ack from files belonging lsewhere (should be just nouveau and
sitronix at quick glance).

>> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
>> prerequisite-patch-id: 7779c63f16ef6f7247cdb71c89e66b27e299eb74
>> prerequisite-patch-id: 6f920b6f8c31dc0ad1689200c37680755c20ce8b
...
>> prerequisite-patch-id: 915b7a2276c5a38944107c84bb282271d0bf28f4
>> prerequisite-patch-id: 76d499a624150588f7ef07dc087e70eca6f33419
>
> FTR: These are bogous, there are no dependencies, I just wasn't
> attentive enough to drop these lines.

And 'b4 shazam' messes up because of these lines.

Overall I think it's better if you resend after splitting by tree, and
removing the prerequisite-patch-id lines. You can keep my R-by on all the
patches if you just split them without further changes.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
