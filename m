Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9953AE9A762
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 11:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0951410E680;
	Tue, 24 Mar 2026 11:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="iWLf6HxE";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1528F10E671
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 11:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=cGWiExyIr/Sacve//+lspGagmILT6Xi0U+hA1nbMGtU=; b=iWLf6HxEdXSXA/cNpmIJZ2QAtA
 DcXnPhmPAvgXXmYUQD3IAO6TLFsb9wz8egHj/H0MuxZZIu+XpYgNz33zNXDEMLPgKTJ/UJC8is0mq
 +xdOuV64RMqGoZ4Z2F1N9z8nsaZt8hEVroM1xghd314+VKC08R8W0KCvTvZzaREXbJscHid0JHeK1
 xiMnUll0gXpQ+5fTTTDRwdycWRpEsGZSrYeV3412EwSWwgsMr6U/iRugI5DoaSY0vf8S7mOBlFOUk
 pSAhRbD1ZG1s7ea7cs5J5ZhbGAuuI6hZT4Q4CfvGlrhieO3uJ3w9SrfI1mDpOUlEBv3m0Nif216Ea
 TgxMHziQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1w4zf3-000KC3-0M; Tue, 24 Mar 2026 12:11:01 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1w4zf2-0004CR-0E; Tue, 24 Mar 2026 12:11:00 +0100
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Marek Vasut <marex@nabladev.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org, dri-devel@lists.freedesktop.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 valentin@compulab.co.il, philippe.schenker@toradex.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, tessolveupstream@gmail.com
Subject: Re: [PATCH v2 0/2] drm: bridge: ti-sn65dsi83: Improve dual-link LVDS
 support
Date: Tue, 24 Mar 2026 12:10:59 +0100
Message-ID: <3019871.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <1ecbcd57-83d9-410c-8e1a-d6a171321ccd@gmail.com>
References: <20260312043743.261475-1-tessolveupstream@gmail.com>
 <DH6T0NTZHP93.2DWN4BWDPP331@bootlin.com>
 <1ecbcd57-83d9-410c-8e1a-d6a171321ccd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/27950/Tue Mar 24 07:24:19 2026)
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

Am Dienstag, 24. M=E4rz 2026, 12:00:43 CET schrieb tessolveupstream@gmail.c=
om:
> [snip]
> > Thanks for the detailed explanation.
> Regarding the panel timings, they are not explicitly defined in the DTS.=
=20
> The panel is currently using the timings provided by the panel driver=20
> (panel-simple.c), specifically:
>=20
> static const struct display_timing auo_g133han01_timings =3D {
>         .pixelclock =3D { 134000000, 141200000, 149000000 },
>         .hactive =3D { 1920, 1920, 1920 },
>         .hfront_porch =3D { 39, 58, 77 },
>         .hback_porch =3D { 59, 88, 117 },
>         .hsync_len =3D { 28, 42, 56 },
>         .vactive =3D { 1080, 1080, 1080 },
>         .vfront_porch =3D { 3, 8, 11 },
>         .vback_porch =3D { 5, 14, 19 },
>         .vsync_len =3D { 4, 14, 19 },
> };
>=20
> The panel I am using is based on AUO G133HAN01, and the datasheet can=20
> be found here:
> https://datasheet4u.com/pdf/1257948/G133HAN01.0.pdf > About CHA_DSI_CLK_R=
ANGE: what is your DSI clock?
> >=20
>=20
> In the current working configuration, the measured clock frequencies=20
> are:
> DSI_CLK: ~422MHz
> LVDS_CLK(both A & B Channels): ~70MHz
> > Finally I don't think the swing values are problematic, so I'd leave th=
em
> > as the last thing to check.

I managed to get this display running with this DSI->LVDS bridge on
TQMa8MxML/TQMa8MxNL (imx8mm or imx8mn) platform.
See [1] for the DT. What platform/ DSI host are you using?

Best regards,
Alexander

[1] https://lore.kernel.org/all/20260316135820.760073-2-alexander.stein@ew.=
tq-group.com/
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


