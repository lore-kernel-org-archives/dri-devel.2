Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E42C79F85
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 13:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE1F10E32D;
	Sun,  6 Sep 2026 13:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nUXi7axT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D45DA10E3C6
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 13:29:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A53C1600AA;
 Sun,  6 Sep 2026 13:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452991F00A3A;
 Sun,  6 Sep 2026 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788701390;
 bh=N3dbd9l7oZeqO/0NOWZ6T7sLKtmlK4KKglzYrtZPcXk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nUXi7axT+LCh4C9qrbXvuUP3URBvC0GmiQyU0nwKX3GiFPFuizi6hGWFeOnTEfs7A
 O+9cy44pXlFTbg2C1CXLhGYyOgWSdqI9jfjoYLC8uebKHZuJm9kWkYhRsJ+IxlnmWO
 14jhP+QjFANmjUC2ildIyomtZ6h/L3LYzRVcToiG7RNG5e4mZsQdFC1Voud6eLtrNz
 nSvxGG8RyGwcbacMrWVrCI+Rab9uPTb9T1bhgGyz6UTi4euoKW77n7wii8VAYQG5e3
 8+KkDmXjW1jHkZ1UsKeDRD5iY7hSdEzsBYz4XYm31KtluBRNqz5bM25zZAKGDIIUxo
 SM9NqpCio7unQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/panel: ebbg-ft8719: Split initialization into
 enable/disable fn
To: "David Heidelberg" <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260906-ebbg-ft8719-fixups-v1-3-4e846510cad1@ixit.cz>
References: <20260906-ebbg-ft8719-fixups-v1-0-4e846510cad1@ixit.cz>
 <20260906-ebbg-ft8719-fixups-v1-3-4e846510cad1@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 13:29:49 +0000
Message-Id: <20260906132950.452991F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving DCS initialization commands from `.prepare()` to `.enable()=
` causes them to be sent after the DSI video stream has started, breaking p=
anel initialization on many hosts.
--

commit 894224e238d4b672a8a8f36dbdfc03846d1bec2e
Author: David Heidelberg <david@ixit.cz>

drm/panel: ebbg-ft8719: Split initialization into enable/disable fn

This commit splits the panel initialization by removing the ebbg_ft8719_on()
and ebbg_ft8719_off() calls from the prepare and unprepare callbacks, and
mapping them directly to the enable and disable callbacks.

> diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/=
panel/panel-ebbg-ft8719.c
> index 14982263a94f1..9965f46f1a316 100644
> --- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> +++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> @@ -54,8 +54,9 @@ static void ebbg_ft8719_reset(struct ebbg_ft8719 *ctx)
>  	usleep_range(15000, 16000);
>  }
> =20
> -static int ebbg_ft8719_on(struct ebbg_ft8719 *ctx)
> +static int ebbg_ft8719_enable(struct drm_panel *panel)
>  {
> +	struct ebbg_ft8719 *ctx =3D to_ebbg_ft8719(panel);
>  	struct mipi_dsi_device *dsi =3D ctx->dsi;
>  	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };

[Severity: High]
Does moving the DCS initialization commands into the panel's enable callback
cause them to be sent too late?

The DRM bridge framework calls the panel's enable callback only after calli=
ng
enable on the host controller, which typically starts the video stream.

If ebbg_ft8719_enable() now sends DCS commands like MIPI_DCS_EXIT_SLEEP_MODE
after the high-speed video stream has started, will they fail or be ignored=
 by
the panel, breaking the display initialization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-ebbg-ft871=
9-fixups-v1-0-4e846510cad1@ixit.cz?part=3D3
