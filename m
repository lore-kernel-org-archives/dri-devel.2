Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE316C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC90210ED1B;
	Wed, 22 Jul 2026 09:50:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EAfKanLH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED5110ED1D
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 09:50:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90F8A40884;
 Wed, 22 Jul 2026 09:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E37E1F000E9;
 Wed, 22 Jul 2026 09:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784713833;
 bh=cGzKdDIq40NgsJAnJa5axHzzAzBU+82htX5o0TsEIUA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EAfKanLHba0hZWecVFcPHeMzDbHjmAnIBvO9WkYj8Dr6OkgT9Ig6mFuNHo5eu69+u
 g1ghJeFlOzqnVeGiIzdso1rUAl9nqnIm3Zq0foYc8u+a9LadlrnfhkEbrQaMKuXlhF
 xabicKFUusC2OEoYzvzeyJozCSxq6b4FTIFcFQ9KWTofbHt5jMuxHx/STpldGtC776
 a78YipHjLgLev/DWs3t4+j9SnbgLT154sL5G63PS9/9xvQ3VYEo4/6FfWi/0msJfx3
 E2p19kReaj07TjtfoXK11eFMc8jPuVcJpgO6sRwE+AdQpOCvOZGY5lP8jNfptV4l9y
 f03QIjGhJve0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/5] drm/display: hdmi-state-helper: Init SCDC
 debugfs for HDMI
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-scdc-link-health-v8-5-cd1dacbb85d9@collabora.com>
References: <20260722-scdc-link-health-v8-0-cd1dacbb85d9@collabora.com>
 <20260722-scdc-link-health-v8-5-cd1dacbb85d9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 09:50:32 +0000
Message-Id: <20260722095033.3E37E1F000E9@smtp.kernel.org>
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
- [High] Missing `mutex_unlock()` in `scdc_status_show()` error path leads =
to a permanent deadlock.
--

--- Patch [5]: [PATCH v8 5/5] drm/display: hdmi-state-helper: Init SCDC deb=
ugfs for HDMI ---
commit a1a858eb6a63d66446abae1340fa115153801dc6
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/display: hdmi-state-helper: Init SCDC debugfs for HDMI

This commit initialises the SCDC debugfs file for connectors that call the
HDMI state helper's debugfs_init helper, making the scdc_status file
available in their connector debugfs.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 8d5ee10ceb874..709524b40c26f 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
[ ... ]
> @@ -1116,6 +1117,7 @@ void drm_hdmi_connector_debugfs_init(struct drm_con=
nector *connector,
>  		return;
> =20
>  	create_hdmi_infoframe_files(connector, dir);
> +	drm_scdc_debugfs_init(connector, root);

[Severity: High]
Does exposing this debugfs file introduce a deadlock if it is read while the
display is disconnected?

Looking at the file operations wired up here, if a user reads the scdc_stat=
us
file when the connector is disconnected:

drivers/gpu/drm/display/drm_scdc_helper.c:scdc_status_show() {
	...
	mutex_lock(&connector->dev->mode_config.mutex);
	...
	if (connector->status !=3D connector_status_connected) {
		ret =3D -ENODEV;
		goto err_conn_put;
	}
	...
err_unlock:
	mutex_unlock(&connector->dev->mode_config.mutex);
err_conn_put:
	drm_connector_put(connector);
	...
}

It appears the error path jumps to err_conn_put, bypassing the mutex_unlock=
()=20
at err_unlock. Could this permanently lock mode_config.mutex and cause=20
subsequent DRM mode setting operations to hang?

>  }
>  EXPORT_SYMBOL(drm_hdmi_connector_debugfs_init);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-scdc-link-=
health-v8-0-cd1dacbb85d9@collabora.com?part=3D5
