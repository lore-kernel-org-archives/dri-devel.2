Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22BBC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A93C110E2CF;
	Mon, 31 Aug 2026 17:11:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lMZfuRAR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA83210E2CF
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:11:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C7FC42A04
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CC41F000E9;
 Mon, 31 Aug 2026 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788196312;
 bh=atsXagGq2H3PHDrmqg2sH5Kc6OO1zapBnI1CB5SSi5A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lMZfuRARSnZSpLjWXXpmf5Piit9BUrhtp9eEi+A9APWlBpzH0WrnQXVklh0ZsW5AN
 80IrmmuDlsJIxQTZlm3Knyr+LRQ06lLOVt7lqDYFHOP9IupNXYLTG2FzBI59HGLx8h
 IDoJ/oQQJidm0+7TEdjJ7uM+Wsz26GCheTTcExKj0EkVW+6r2G7DfQN0bGBPlQdYD8
 BxtVqRwI4pqQG/xj68i8TNLQFGzmLt3DZkvvWdlAgW6kk+rkNqQIXBrilpYN17hlPu
 IwRj1DKpfpYKUYoMp2KgfD2XgAtQV1zlvrRSl7wWL6ZWyKQaqj/vjLgbuWhYCP/gqo
 TaeachOy8uT4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.6] drm/panel: jadard-jd9365da-h3: set
 prepare_prev_first
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-577-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-577-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:11:51 +0000
Message-Id: <20260831171152.41CC41F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Setting `prepare_prev_first` reverses the bridge enable/disable or=
der, causing the DSI host to drive data lanes high (LP-11) before the panel=
 is powered on, which violates hardware power sequences.

Pre-existing issues:
- [High] The panel is published to the system via `drm_panel_add()` before =
critical internal state is initialized.
--

commit a792999b217c12abcec671639b930a3ece58774e
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/panel: jadard-jd9365da-h3: set prepare_prev_first

Sending DSI commands from the prepare() callback requires DSI link to be
up at that point. Set the .prepare_prev_first flag to let these panels work
with the DSI hosts which don't power on the link in their .mode_set callbac=
k.

Link: https://patch.msgid.link/20260413-waveshare-dsi-touch-v3-13-3aeb53022=
c32@oss.qualcomm.com

> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/g=
pu/drm/panel/panel-jadard-jd9365da-h3.c
> index 5c2530598ddb9..9e5287829b952 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -1157,6 +1157,8 @@ static int jadard_dsi_probe(struct mipi_dsi_device =
*dsi)
>  	if (ret)
>  		return ret;
> =20
> +	jadard->panel.prepare_prev_first =3D true;
> +

[Severity: High]
Does setting this flag reverse the expected hardware power sequences?

When the display is enabled, the DRM bridge core will respect this flag by
calling the host's pre_enable before the panel's prepare. This forces the
host PHY to power up and drive the DSI lanes to LP-11. Then jadard_prepare()
enables the vccio and vdd regulators.=20

This sequence is reversed during disable, with jadard_unprepare() disabling
regulators while the host is still driving LP-11.

Could driving I/O pins on unpowered silicon cause hardware latch-up and
potential permanent damage to the panel?

>  	drm_panel_add(&jadard->panel);

[Severity: High]
This is a pre-existing issue, but does calling drm_panel_add() here publish
the panel before critical internal state is initialized?

drm_panel_add() makes the panel visible globally. A concurrent thread (e.g.=
, a
display controller driver probe in another workqueue or returning from
EPROBE_DEFER) can immediately acquire the panel and call its callbacks.

If a callback like jadard_get_modes() is invoked, it unconditionally
dereferences jadard->desc. Since jadard->desc is initialized in the lines
following this drm_panel_add() call, could this lead to a NULL pointer
dereference and kernel panic?

> =20
>  	mipi_dsi_set_drvdata(dsi, jadard);
>  	jadard->dsi =3D dsi;
>  	jadard->desc =3D desc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-577-sashal@kernel.org?part=3D1
