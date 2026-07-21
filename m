Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48F8C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E4810E84B;
	Tue, 21 Jul 2026 09:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gb88dHWI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFDA410E84B
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 09:11:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90C1A43AD8;
 Tue, 21 Jul 2026 09:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4A91F000E9;
 Tue, 21 Jul 2026 09:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784625117;
 bh=ZIvB2U9d7DzbT4ED+I9ELBWuWZXBE1KQOuJE1/abgMQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gb88dHWICQ6lPzOP7AD0rrugiqo/uVTPL7AMAV3Y8RsHtKRbh1YYMj41xk4YT3+nl
 o4cKPkz6cSsdoaf28SnF+mPUdLVznrZ1sp5vm831kVVL2IxvosL0fW+57rdfZbaxEm
 Js5wQMB/GfyzEAqSMIR5mturf9tlh+4BtR/G+tFtpA7eWXQ6+SHiUnnjh9nDBL+h9l
 VKGcXi/J3roKiqMChOCdfGczmxDtecUxAelqo2hPQLn+sPwhr2opUPJg2OIifIT4du
 vuDqdX18D4OYOdi2vGNepyZzvL9W9pCg8ngrr1cjTO8YEPToXxFk1g9EIR6M8LiINu
 12x50+qJcP8VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/5] drm/display: hdmi-state-helper: Init SCDC
 debugfs for HDMI
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260721-scdc-link-health-v7-5-92df1b6ad5fc@collabora.com>
References: <20260721-scdc-link-health-v7-0-92df1b6ad5fc@collabora.com>
 <20260721-scdc-link-health-v7-5-92df1b6ad5fc@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 09:11:56 +0000
Message-Id: <20260721091157.4A4A91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Reading the `scdc_status` debugfs file causes a kernel panic if th=
e HDMI connector lacks an I2C DDC adapter (`connector->ddc =3D=3D NULL`).
- [Medium] Concurrent reads of the `scdc_status` debugfs file cause a data =
race on the shared per-connector `priv->state` buffer.
- [Low] SCDC debugfs initialization is incorrectly skipped if the creation =
of the `infoframes` debugfs directory fails.
--

--- Patch [5]: [PATCH v7 5/5] drm/display: hdmi-state-helper: Init SCDC deb=
ugfs for HDMI ---
commit 4d2f5fcf6dba954346bc26d1af8d8e70d0cf5de0
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/display: hdmi-state-helper: Init SCDC debugfs for HDMI

Initialise the SCDC debugfs file for connectors that call the HDMI state
helper's debugfs_init helper. This makes all connectors that use the
helper expose the scdc_status file in their connector debugfs.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 8d5ee10ceb874..709524b40c26f 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
[ ... ]
> @@ -1116,6 +1117,7 @@ void drm_hdmi_connector_debugfs_init(struct drm_con=
nector *connector,
>  		return;

[Severity: Low]
Is it intended that drm_scdc_debugfs_init() is skipped if the infoframes
directory creation fails?

Right above this line, the code checks:

	dir =3D debugfs_create_dir("infoframes", root);
	if (IS_ERR(dir))
		return;

If debugfs_create_dir() fails, the early return skips the independent
drm_scdc_debugfs_init() call entirely.

> =20
>  	create_hdmi_infoframe_files(connector, dir);
> +	drm_scdc_debugfs_init(connector, root);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does exposing this to all HDMI connectors cause a regression with a NULL
pointer dereference?

If an HDMI connector lacks an I2C adapter (connector->ddc is NULL) but
indicates SCDC support, reading the newly exposed scdc_status debugfs
file leads to a panic:

drivers/gpu/drm/display/drm_scdc_helper.c:scdc_status_show() {
	if (scdc->supported) {
		ret =3D drm_scdc_read_state(connector, st);
...
}

drivers/gpu/drm/display/drm_scdc_helper.c:drm_scdc_read_state() {
	ddc =3D connector->ddc;
	if (!scdc->supported)
		return -EOPNOTSUPP;
	/* Read in 128-byte chunks, to work around DP<->HDMI converters with issue=
s. */
	ret =3D drm_scdc_read(ddc, 0, buf, 128);
...
}

drm_scdc_read() unconditionally passes the NULL pointer to i2c_transfer(),
causing a panic.

[Severity: Medium]
Could concurrent reads of the scdc_status debugfs file cause a regression
due to a data race?

drm_scdc_debugfs_init() allocates a single, shared struct scdc_debugfs_priv
per connector:

drivers/gpu/drm/display/drm_scdc_helper.c:drm_scdc_debugfs_init() {
	priv =3D drmm_kzalloc(connector->dev, sizeof(*priv), GFP_KERNEL);
...
}

When multiple processes concurrently read the debugfs file, they extract th=
is
shared pointer:

drivers/gpu/drm/display/drm_scdc_helper.c:scdc_status_show() {
	struct scdc_debugfs_priv *priv =3D m->private;
	struct drm_scdc_state *st =3D &priv->state;
...
}

Since there is no locking across the sequential I2C reads and data parsing
in drm_scdc_read_state(), concurrent threads could overwrite priv->state
simultaneously.

>  }
>  EXPORT_SYMBOL(drm_hdmi_connector_debugfs_init);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-scdc-link-=
health-v7-0-92df1b6ad5fc@collabora.com?part=3D5
