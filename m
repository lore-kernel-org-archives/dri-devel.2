Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A33DC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0B310E29D;
	Mon, 31 Aug 2026 15:26:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Q2MLXKc/";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C0E010E29D
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:26:25 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B01B04E4146B;
 Mon, 31 Aug 2026 15:26:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 78D0260231;
 Mon, 31 Aug 2026 15:26:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9386C11C78AC8; 
 Mon, 31 Aug 2026 17:26:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788189981; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=MOSEqx16yAn5Bafqgfej14UnvGnZ0sZeAYdUubBwfXw=;
 b=Q2MLXKc/oRyrOrt5bUK/hzX58z7rF6JIiqY6ZUOPOSQIGKtaI5fg9Oeb1RV0NWqutDvaPv
 gOJ/0FOFFdpkdIwaF/Cvr45Mys4ZncMbplmBKHbMWqg9ZLspZSv8Ep00y2lumGKCRs4v2H
 6gQdw4/h+YXmx870Cy71EBf+ALZLLpxbk4uMOFlsizSLUt+shIDdx1iVxZi8WokNXjmlMZ
 G2hBOrntCutZ5ipOcFTONtGS0Tt6ujgIiHJf+jpm5CS7Zm1c7iHAuTxUtyIhKj4cmQW98y
 EYJDqIQaptAlVZQypV6Iqv5HNYDXKEDHTFaQ7QQ1NGkRvKNt+nqg4xnkotsgig==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 17:26:12 +0200
Message-Id: <DL38FWMPAVYW.3H964111WXW4T@bootlin.com>
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
Subject: Re: [PATCH v2 08/12] drm/bridge: parade-ps8640: select
 DRM_PANEL_BRIDGE
X-Mailer: aerc 0.22.0
References: <20260825-drm-bridge-drm_panel-cleanup-v2-0-c6c88ba7ffd2@bootlin.com>
 <20260825-drm-bridge-drm_panel-cleanup-v2-8-c6c88ba7ffd2@bootlin.com>
 <CAD=FV=Xdj_foBqt9A9EVVoCA2BxAV3UZNz3SuVPu2ZoNXgnS=w@mail.gmail.com>
 <DL308Z0JXJ31.2V3H29DTG4MSM@bootlin.com>
 <CAD=FV=UOwWdVc8p1js+28C1u7=iRqRpv86PkwWf5g8yL-Uq5kw@mail.gmail.com>
In-Reply-To: <CAD=FV=UOwWdVc8p1js+28C1u7=iRqRpv86PkwWf5g8yL-Uq5kw@mail.gmail.com>
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

On Mon Aug 31, 2026 at 4:58 PM CEST, Doug Anderson wrote:
> Hi,
>
> On Mon, Aug 31, 2026 at 2:01=E2=80=AFAM Luca Ceresoli <luca.ceresoli@boot=
lin.com> wrote:
>>
>> Hi,
>>
>> On Thu Aug 27, 2026 at 6:23 PM CEST, Doug Anderson wrote:
>> > Hi,
>> >
>> > On Tue, Aug 25, 2026 at 3:11=E2=80=AFAM Luca Ceresoli <luca.ceresoli@b=
ootlin.com> wrote:
>> >>
>> >> This driver uses the drm_panel_bridge API and not the drm_panel API s=
o it
>> >> should select DRM_PANEL_BRIDGE and not DRM_PANEL.
>> >
>> > Which exact "drm_panel_bridge" API does it use? I don't see any...
>>
>> It calls devm_drm_of_get_bridge() [0], which is in bridge/panel.c [1],
>> which is enabled by CONFIG_DRM_PANEL_BRIDGE [2].
>>
>> [0] https://elixir.bootlin.com/linux/v7.2.2/source/drivers/gpu/drm/bridg=
e/parade-ps8640.c#L636
>> [1] https://elixir.bootlin.com/linux/v7.2.2/source/drivers/gpu/drm/bridg=
e/panel.c#L483-L515
>> [2] https://elixir.bootlin.com/linux/v7.2.2/source/drivers/gpu/drm/Makef=
ile#L159
>
> Ah, indeed! I missed that since it didn't have "panel" in the name.
> FWIW, then I think for this patch:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ...but, ironically, that means that for the other patch I looked at
> (ti-sn65dsi86.c) we're missing the "select DRM_PANEL_BRIDGE" since it
> uses the same API call, doesn't it?

Ouch, indeed! Thanks for noticing.

I will send v3 with that fixed, can I keep your R-by if there's just that
change to the sn65dsi86 patch?

I am also going to double check all patches for this mistake.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
