Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4934606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SdbGPkN+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DF3E10EBF7;
	Wed, 18 Nov 2026 08:44:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D6910EBF7
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:44:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 24A6361F8F;
 Wed, 18 Nov 2026 08:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F6B1F000C5;
 Wed, 18 Nov 2026 08:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794991442;
 bh=zFcd2GZmo28Ue94lMfCwyXqiZG5k5MeVt8meQ8clmgU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SdbGPkN+QZioua221XRDuR1GTuvfVFMPGKULRGZyehFxhbltDy1+x956/HgUdpOo8
 hPZ8zwQUPhnmnQE7dJAUOJJhNvc9XSZ+sOY74jty7Yx8XnHPRZfOkdsu7GV9yjEDQt
 OF36vb8/j/BviyyHqohZ5jJ/qJNm/Oqzhs5exbUb0kP5p2WI4GLaWKV/Kczwgkgn8p
 j1UTC4dr3CZ+XooClFKJZGQwIr6lQq+YVEj+ye8TFVk+NcaLPM0vWOjvu9SZQ70XiM
 bAGefzSQAXpKjTWTakal062vZbtVFQxUkpmoe2KUiUvnkSUPI+XaVjXry6zFRBgW5P
 eR7ACFhrm2Lfg==
Message-ID: <sashiko-outbox-220483@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/panel: ilitek-ili9881c: add Industio Purple Pi
 OH panel
To: pjh456 <147148383@qq.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <tencent_4499382AA896319EAA2244D239B92371C207@qq.com>
References: <20261118080338.523572-1-147148383@qq.com>
 <tencent_4499382AA896319EAA2244D239B92371C207@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:44:02 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/panel: ilitek-ili9881c: undocumented vendor prefix industio
  in of_match
--

commit 84f034765df38c524342d56e58717a5a36f868df
Author: pjh456 <147148383@qq.com>

drm/panel: ilitek-ili9881c: add Industio Purple Pi OH panel

This commit adds an initialization sequence, display mode, and compatible
string for the 7-inch 800x1280 MIPI-DSI panel used on the Industio Purple
Pi OH board.

> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili9881c.c
> index 7bf38e96678ac..5f1270d780827 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c

[ ... ]

> @@ -2708,6 +2929,7 @@ static const struct of_device_id ili9881c_of_match[=
] =3D {
>  	{ .compatible =3D "wanchanglong,w552946aba", .data =3D &w552946aba_desc=
 },
>  	{ .compatible =3D "waveshare,7.0-dsi-touch-a", .data =3D &waveshare_7in=
ch_a_desc },
>  	{ .compatible =3D "ampire,am8001280g", .data =3D &am8001280g_desc },
> +	{ .compatible =3D "industio,purple-pi-oh-panel", .data =3D &ppoh_desc },

[Severity: Low]
Should the "industio" vendor prefix be documented in
Documentation/devicetree/bindings/vendor-prefixes.yaml?  Neither this
patch nor commit "dt-bindings: display: panel: ilitek, ili9881c: add
Industio Purple Pi OH panel" adds an entry for it, which triggers a
checkpatch UNDOCUMENTED_DT_STRING warning and a dt_binding_check failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_74E280A130C=
68EAB42115FE6AE8E6809D109@qq.com?part=3D2
