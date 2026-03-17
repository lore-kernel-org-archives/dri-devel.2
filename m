Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691C1FED9EA
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAE410E6E1;
	Tue, 17 Mar 2026 16:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nTJI506a";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2492C10E6E1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 16:16:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 876534E426D1;
 Tue, 17 Mar 2026 16:16:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3F07A5FC9A;
 Tue, 17 Mar 2026 16:16:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 609F11045063F; Tue, 17 Mar 2026 17:16:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773764181; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=s4qSyYHl1wcr5KNT4MVUGisOp5HFLKoqkr7jcvtKlyU=;
 b=nTJI506afqiFlLXgatgefe0YsP8Hc/2YEM1eHvyL5qUoe7OEtPw0Z3AB1SgLUJHO3HD/0Z
 Uxf6dbXXiz7nzI2Gb1UFgl8YO1KDVY6vddAl8eryJPENTSIQk6gqZVxjthPFbT22exYImF
 pGuhTyH7dpAFEgjzCSX90+icrsBQBFOeIG1NsCTdRGYG6wfuR8h4FI+cWs52mJwrNvRQgf
 cdxgTPJivgW2m4WV0tzvpOyTDI3niSyowPMJGEHNgnv4v0PBXk+C8zdkuRVwHWtyBY5Hp1
 dQam8tn6+OINwIcZbzf9nw+V+UOEBzzjffGO+CH9Cy7E2Fg5gq2X9SyZN1M1fg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 17:16:11 +0100
Message-Id: <DH56X74P9GC9.1O123S92J60RG@bootlin.com>
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi-qp: fix multi-channel audio output
To: "Christian Hewitt" <christianshewitt@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Cristian Ciocaltea"
 <cristian.ciocaltea@collabora.com>, "Detlev Casanova"
 <detlev.casanova@collabora.com>, "Douglas Anderson"
 <dianders@chromium.org>, "Andy Yan" <andy.yan@rock-chips.com>, "Sugar
 Zhang" <sugar.zhang@rock-chips.com>, "Heiko Stuebner" <heiko@sntech.de>,
 <dri-devel@lists.freedesktop.org>, <linux-rockchip@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260228112822.4056354-1-christianshewitt@gmail.com>
In-Reply-To: <20260228112822.4056354-1-christianshewitt@gmail.com>
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

Hello Christian,

On Sat Feb 28, 2026 at 12:28 PM CET, Christian Hewitt wrote:
> From: Jonas Karlman <jonas@kwiboo.se>
>
> Channel Allocation (PB4) and Level Shift Information (PB5) are
> configured with values from PB1 and PB2 due to the wrong offset
> being used. This results in missing audio channels or incorrect
> speaker placement when playing multi-channel audio.
>
> Use the correct offset to fix multi-channel audio output.
>
> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi=
-qp")
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

While applying this patch to drm-mics-fixes, checkpatch complains:

  -:14: WARNING:BAD_REPORTED_BY_LINK: Reported-by: should be immediately fo=
llowed by Closes: with a URL to the report

You can send v3 with the link, or just reply with the link and I'll take
care of adding it to the commit message.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
