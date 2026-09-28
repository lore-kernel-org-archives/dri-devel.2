Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93E0C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A3E10E81E;
	Mon, 28 Sep 2026 08:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="s3R1shks";
	dkim-atps=neutral
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch
 [185.70.43.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 773B210E81D
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1790583640; x=1790842840;
 bh=sWR7+AcckXLzVN8kNNdUbAEI0EtHthjNSFtY23Le07s=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=s3R1shksSUw6ZHzawrEzuYla/HQ3wOCMyXwUgQAjHEluSJ+zRBDxME8kSzMVniN0h
 qFGqpUA6QW6gJIpNMVBZi7BsA8QfKYypT4Dm0kPHiPJ8c7wF53OOIYLmFwpbMMl6c6
 lmpdBl3cJ/HVY28nNf0EzIAO808pbMLe/iE8mTzLPKVy6aY23TgjDDY/OQBw2O9/hB
 nqGZVvHB/+oIAHH3NotFmIMlt79N09mZ8VAyOHAHEx8G4fvvGwPSWL1aU+MAMLW5Gi
 d+Dv0qybqWM/x3F7jvsDvZFCzOVdaszF81ok7zQFIsADZ20S9K+xnut5Cegs1XOvG8
 JQgQnybWCelww==
X-Pm-Submission-Id: 4htZ4h5D8mz1DF4X
From: Esben Haabendal <esben@geanix.com>
To: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,  "Jonas Karlman"
 <jonas@kwiboo.se>,  "Jernej Skrabec" <jernej.skrabec@gmail.com>,  "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>,  Guido =?utf-8?Q?G=C3=BCnther?=
 <agx@sigxcpu.org>, "Fabio Estevam" <festevam@gmail.com>,  "Robert Chiras"
 <robert.chiras@nxp.com>,  "Sam Ravnborg" <sam@ravnborg.org>,
 <dri-devel@lists.freedesktop.org>,  <linux-kernel@vger.kernel.org>,
 "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>,  "Oliver F. Brown"
 <oliver.brown@oss.nxp.com>
Subject: Re: [PATCH v4 0/4] drm/bridge: nwl-dsi: Various fixes
In-Reply-To: <20260831-nwl-dsi-fixes-v4-0-6a2a1cb23910@geanix.com>
References: <vfndbk9zi3OIqSxPrtQEXwhrwIF37_6XjQPApIjAJ1MRPGB62dWkOgynZc0CcQjqCmzn-OzHvMjxzYtTttZXgQ==@protonmail.internalid>
 <20260831-nwl-dsi-fixes-v4-0-6a2a1cb23910@geanix.com>
Date: Mon, 28 Sep 2026 10:20:35 +0200
Message-ID: <87qzidvlbg.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

"Esben Haabendal" <esben@geanix.com> writes:

> This series brings a few patches fixing horizontal sync timing, EOTP pack=
et
> behavior and hsync/vsync polarity selection when using DCSS endpoint, as
> well as a small fix to properly handle if/when nwl_dsi_mode_set() fails.
>
> The 3rd commit ("Correct auto-insert EOTP behavior") is taken directly fr=
om
> NXP vendor tree, so I have kept Author unchanged, although I have modified
> the commit message. Let me know if I should change Author for that.
>
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Is there anything I can or should do to get this patch series merged or
at least some review feedback that I can work on?

/Esben

> ---
> Changes in v4:
> - Change calculation of hfp/hbp/hsa to use the raw clock rates directly to
>   eliminate intermediate rounding errors.
> - Drop patch 4 (will be included in follow-up patch series, together with
>   a patch addressing the unblanced resource teardown and PM runtime
>   underflow problems in the error path).
> - Link to v3: https://patch.msgid.link/20260810-nwl-dsi-fixes-v3-0-256da9=
d672e1@geanix.com
>
> Changes in v3:
> - Added Fixes and Cc: stable tags.
> - Split patch 1 into two, with change of endpoint mux control in a separa=
te
>   patch.
> - Fixed mux_control_try_select() state argument.
> - Link to v2: https://patch.msgid.link/20260803-nwl-dsi-fixes-v2-0-1809a0=
ac453f@geanix.com
>
> Changes in v2:
> - Added safeguard against small horizontal sync timings, protecting again=
st
>   division by zero and integer underflow.
> - Added error handling of nwl_dsi_mode_set() call.
> - Link to v1: https://patch.msgid.link/20260710-nwl-dsi-fixes-v1-0-927d91=
8a86ad@geanix.com
>
> To: Andrzej Hajda <andrzej.hajda@intel.com>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Robert Foss <rfoss@kernel.org>
> To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> To: Jonas Karlman <jonas@kwiboo.se>
> To: Jernej Skrabec <jernej.skrabec@gmail.com>
> To: Luca Ceresoli <luca.ceresoli@bootlin.com>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Guido G=C3=BCnther <agx@sigxcpu.org>
> To: Fabio Estevam <festevam@gmail.com>
> To: Robert Chiras <robert.chiras@nxp.com>
> To: Sam Ravnborg <sam@ravnborg.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
> Esben Haabendal (3):
>       drm/bridge: nwl-dsi: Cleanup endpoint mux control selection
>       drm/bridge: nwl-dsi: Limit LCDIF specific sync override
>       drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing
>
> Robert Chiras (1):
>       drm/bridge: nwl-dsi: Correct auto-insert EOTP behavior
>
>  drivers/gpu/drm/bridge/nwl-dsi.c | 87 ++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 74 insertions(+), 13 deletions(-)
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260710-nwl-dsi-fixes-c148b0adb685
>
> Best regards,
> --
> Esben Haabendal <esben@geanix.com>
