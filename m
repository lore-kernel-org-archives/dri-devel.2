Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206FEC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B4C210E16A;
	Wed, 12 Aug 2026 13:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LuECS6Bb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6449410E16A
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:12:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 32646408D7;
 Wed, 12 Aug 2026 13:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA05C1F000E9;
 Wed, 12 Aug 2026 13:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786540336;
 bh=U15mOgIa3Cpp24usLL44CqlWws2DRMh8JqLmthnoVT4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LuECS6BbYJLPLzSDbPtK1mmCDt9hpxuz+CjqV9BNbX3vJTUAALoAjBPc8gYkUsuA4
 RFQJ0ODcdDv65CE8gPBcW46Z4xsHpVFs2vvLlR69nMEPs7qplgMnIVTLPg1Rit9Nq1
 LWNUg3cIDMuO8vpl3Zn2qjwg32D5A9IpIY4hWPWHX/L3VapjHqjtwcqa+dWZoC1HuN
 6QTtUS5nXSUPwIiysqzkbPxvbwEDdyRTk8xD50vvuGcJQRyEiKvYUeCrhQ79uqB0uj
 r8Xb4Cw1EfRyIjV8vPWhxYhDRyua6mrjihla9C6mVcmlibelV4VE6viB7PCaqhJFpo
 WrwAVFnZcgTcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] drm/panel: Use devm_mipi_dsi_attach in display
 vendor panels
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812130429.16850-5-osama.abdelkader@gmail.com>
References: <20260812130429.16850-1-osama.abdelkader@gmail.com>
 <20260812130429.16850-5-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 13:12:15 +0000
Message-Id: <20260812131215.EA05C1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing `drm_panel_remove()` on DSI attach failure leaves a dangli=
ng pointer in the global panel list.
--

--- Patch [5]: [PATCH v3 5/6] drm/panel: Use devm_mipi_dsi_attach in displa=
y vendor panels ---
commit 861964400906b56ec8ecf322e4a2fb68f45fa468
Author: Osama Abdelkader <osama.abdelkader@gmail.com>

drm/panel: Use devm_mipi_dsi_attach in display vendor panels

This patch converts several MIPI DSI panel drivers to use the managed
devm_mipi_dsi_attach() helper and removes the manual detach calls from
their respective remove functions.

> diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/d=
rm/panel/panel-jdi-fhd-r63452.c
> --- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> +++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> @@ -202,7 +202,7 @@ static int jdi_fhd_r63452_probe(struct mipi_dsi_devic=
e *dsi)
> =20
>  	drm_panel_add(&ctx->panel);
> =20
> -	ret =3D mipi_dsi_attach(dsi);
> +	ret =3D devm_mipi_dsi_attach(&dsi->dev, dsi);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
>  		return ret;

[Severity: High]
This isn't a bug introduced by this patch, but shouldn't we call
drm_panel_remove() before returning here?

Since the panel context is allocated using devm_drm_panel_alloc() earlier in
jdi_fhd_r63452_probe(), returning an error will cause devres to automatical=
ly
free the memory.

Because drm_panel_add() was called right before the attach attempt, will th=
is
leave a dangling pointer in the global panel_list? It looks like this could
result in a use-after-free or list corruption the next time the list is
traversed.

Several of the other panel drivers updated in this patch (such as
ltk050h3146w) correctly call drm_panel_remove() in this error path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812130429.1685=
0-1-osama.abdelkader@gmail.com?part=3D5
