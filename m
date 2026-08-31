Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63D4C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F252210E214;
	Mon, 31 Aug 2026 09:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="y8DDw05V";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75A4B10E214
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:01:15 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 049A64E41464;
 Mon, 31 Aug 2026 09:01:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C1D2A60231;
 Mon, 31 Aug 2026 09:01:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6B0C311C78388; 
 Mon, 31 Aug 2026 11:01:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788166868; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=T6oxC/12nbIyG/hWKvWHljzUeneLjy2WW6xRew8IQUw=;
 b=y8DDw05VRpqx6+EBYe8Kh0paGC4OlXEQn85iwNSnK6ozkBH8WL71eThmTB1aYF1yaZQ5az
 kde5NzGrZ9ZbFiP3PUTT40AAJlnEcuK8sX08rnulqazFr3bKAiuy7jUZcCV0/cu8znSHH0
 QUMv0uMuFhMNvWVLttVcDIpkjgRHkC6bF7J6bG7W7melvug4gfcB65hQHgVyQ9ArN498qE
 cCrdK6ofajyojrYumICdfGukAz55XBLYsklNukBtBdrlXbXWAJfX0Kn2pgXmhSzRGFJdQA
 j8Gso1ao1Fos2IGJym5rizTP9Fy6dYdsqyw1BQsuFEXuPOpAgfh5gxVWT5nE5w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 11:01:00 +0200
Message-Id: <DL308Z0JXJ31.2V3H29DTG4MSM@bootlin.com>
Subject: Re: [PATCH v2 08/12] drm/bridge: parade-ps8640: select
 DRM_PANEL_BRIDGE
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, "Jitao Shi" <jitao.shi@mediatek.com>,
 "CK Hu" <ck.hu@mediatek.com>, "Pin-yen Lin" <treapking@chromium.org>,
 "Enric Balletbo i Serra" <eballetbo@kernel.org>
To: "Doug Anderson" <dianders@chromium.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260825-drm-bridge-drm_panel-cleanup-v2-0-c6c88ba7ffd2@bootlin.com>
 <20260825-drm-bridge-drm_panel-cleanup-v2-8-c6c88ba7ffd2@bootlin.com>
 <CAD=FV=Xdj_foBqt9A9EVVoCA2BxAV3UZNz3SuVPu2ZoNXgnS=w@mail.gmail.com>
In-Reply-To: <CAD=FV=Xdj_foBqt9A9EVVoCA2BxAV3UZNz3SuVPu2ZoNXgnS=w@mail.gmail.com>
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

Hi,

On Thu Aug 27, 2026 at 6:23 PM CEST, Doug Anderson wrote:
> Hi,
>
> On Tue, Aug 25, 2026 at 3:11=E2=80=AFAM Luca Ceresoli <luca.ceresoli@boot=
lin.com> wrote:
>>
>> This driver uses the drm_panel_bridge API and not the drm_panel API so i=
t
>> should select DRM_PANEL_BRIDGE and not DRM_PANEL.
>
> Which exact "drm_panel_bridge" API does it use? I don't see any...

It calls devm_drm_of_get_bridge() [0], which is in bridge/panel.c [1],
which is enabled by CONFIG_DRM_PANEL_BRIDGE [2].

[0] https://elixir.bootlin.com/linux/v7.2.2/source/drivers/gpu/drm/bridge/p=
arade-ps8640.c#L636
[1] https://elixir.bootlin.com/linux/v7.2.2/source/drivers/gpu/drm/bridge/p=
anel.c#L483-L515
[2] https://elixir.bootlin.com/linux/v7.2.2/source/drivers/gpu/drm/Makefile=
#L159

> Certainly it's highly likely that the next bridge in the chain is a
> panel, but there are no API calls that I see. Maybe the scripts got
> confused because the variable name didn't get updated in commit

No script, just this humble human got confused X-)

> 5486eac81004 ("drm/bridge: parade-ps8640: switch to
> devm_drm_of_get_bridge") ?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
