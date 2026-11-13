Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DDB606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOkZ9ftV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 279AC10E038;
	Fri, 13 Nov 2026 17:06:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD48010E176
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:06:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0213862943;
 Fri, 13 Nov 2026 17:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BF21F000C5;
 Fri, 13 Nov 2026 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794589608;
 bh=e68CtehYXBHtrTrBg7gkpCQBcjJuI+ZwL++iXdyO/G0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lOkZ9ftVOXpG4YhIthYAyEt+5Dq5i8tDV1/1aAguXlNO2CSIl+qtYMcT+ApNza3gB
 1kuf4pyUugD/J0O9PaB/vM6/58QsfsLMFcRj9QLMdna9PEwo+YOcpXhRi6zwM8OXDl
 JerjZ2V4l8yOMxpLwouj6o/ElGXsW2HuGZV/0VoJdxYh/LHL3zL7gPMlsIjIAuCVSC
 6NDHJIvdJ0CevRV8i5oZFMU/7arryVy+K/U/zh/3rjGf2pEqTnLVP1+AdJlP0wF5Bv
 VsZbsatmsEkkDYuEv1Tzf4L1uNWbbEO0TIQ2pautZJg3rinFv6LgnAPNAoG84r3M62
 SDc4k0t/eW0Sg==
Message-ID: <sashiko-outbox-213271@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/panel: ilitek-ili9881c: Fix Ampire AM8001280G
 support
To: "Philipp Zabel" <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261113-panel-ilitek9881c-lanes-v1-1-9d9320cc1387@pengutronix.de>
References: <20261113-panel-ilitek9881c-lanes-v1-0-9d9320cc1387@pengutronix.de>
 <20261113-panel-ilitek9881c-lanes-v1-1-9d9320cc1387@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:06:48 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/panel: ilitek-ili9881c: missing lanes init in three panel
  descriptors [1]
--

commit 40a8a814e1b52ccce761f231179cd2bd05641a2c
Author: Philipp Zabel <p.zabel@pengutronix.de>

drm/panel: ilitek-ili9881c: Fix Ampire AM8001280G support

This commit sets .lanes =3D 4 in am8001280g_desc to restore the lane count
for Ampire AM8001280G panels.

> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili9881c.c
> index 7bf38e96678ac..cc4cd646b6111 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -2662,6 +2662,7 @@ static const struct ili9881c_desc am8001280g_desc =
=3D {
>  	.mode =3D &am8001280g_default_mode,
>  	.mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
>  		      MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM,
> +	.lanes =3D 4,
>  };

[Severity: High]
This problem wasn't introduced by this patch, but are kd050hdfia020_desc
and tl050hdv35_desc also missing their .lanes initializer from
2f7e4a699736 ("drm/panel: ilitek-ili9881c: Allow configuration of the
number of lanes") [1]?

Without .lanes set, ili9881c_dsi_probe() passes dsi->lanes =3D=3D 0 to
mipi_dsi_attach(), causing DSI host attachment to fail with -EINVAL or
triggering a division by zero in DSI host controller drivers that divide
by dsi->lanes.

[1] https://sashiko.dev/#/bug/linux-62dd6149-f822-4521-aeee-730978e33590

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-panel-ilit=
ek9881c-lanes-v1-0-9d9320cc1387@pengutronix.de?part=3D1
