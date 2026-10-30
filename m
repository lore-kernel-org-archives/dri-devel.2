Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FBE606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WBuSE04f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAB4910E822;
	Fri, 30 Oct 2026 06:13:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFBF510E822
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 06:13:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 798D741523;
 Fri, 30 Oct 2026 06:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BC01F0093A;
 Fri, 30 Oct 2026 06:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793340830;
 bh=htXtJTiGTPEHl/409wGNlOfuQo6qQbI+M1FR31qnmcU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WBuSE04ftgTkWuN4YyTmh7WOPvXIgnBzqM5sQTQfXuwwEkA6ZoOg8E/O3FcDGTB8s
 kw14VQlZKubk1Z3I25WWRLYN7lUYTuUXNlRkQXcunKbVgoBUlxRfL5qA73OHI6N7lk
 wkXUH6zSebqvlU9yC+Mm+K2Q84sdu/LDplabA5Erb5ficS+H9mT176DtElrs9qUVhQ
 IeRlZ35LcBzYA2yj89grSgKJ2g6AyBDzLqKAtw7lO7pOSvbyPk9fcp4jFs8E7rcAtn
 LylH321IHfyUeSo3+aeCVFK/j8kA6e5rmBAbz2t2+CFujsUNxfVTzuq3qvsfydegmr
 7SBJD6fDyMlWg==
Message-ID: <sashiko-outbox-190591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: fix cmd mode transition when
 disabling
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030055806.4102994-1-zhengxingda@iscas.ac.cn>
References: <20261030055806.4102994-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 06:13:49 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/bridge: dw-mipi-dsi: missing dsi->slave cmd mode switch in a=
tomic_disable()
--

commit 99d2bade79250c503a435eb9a6a3898d6ebd22f7
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

drm/bridge: dw-mipi-dsi: fix cmd mode transition when disabling

This commit moves the command mode transition from the atomic_post_disable
hook into a new atomic_disable hook so that the DSI controller switches to
command mode before the panel bridge runs its atomic_post_disable and
panel unprepare callbacks.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/=
drm/bridge/synopsys/dw-mipi-dsi.c
> index 22d1b8cbe1d57..7cd0ca76b86ee 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c

[ ... ]

> @@ -1057,6 +1049,20 @@ static void dw_mipi_dsi_bridge_atomic_enable(struc=
t drm_bridge *bridge,
>  		dw_mipi_dsi_set_mode(dsi->slave, MIPI_DSI_MODE_VIDEO);
>  }
> =20
> +static void dw_mipi_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
> +					      struct drm_atomic_commit *state)
> +{
> +	struct dw_mipi_dsi *dsi =3D bridge_to_dsi(bridge);
> +
> +	/*
> +	 * Switch to command mode before panel-bridge post_disable &
> +	 * panel unprepare.
> +	 * Note: panel-bridge disable & panel disable has been called
> +	 * before by the drm framework.
> +	 */
> +	dw_mipi_dsi_set_mode(dsi, 0);
> +}

[Severity: Medium]
Should dw_mipi_dsi_bridge_atomic_disable() also switch dsi->slave to command
mode when operating in a dual-DSI configuration?

In dw_mipi_dsi_bridge_atomic_enable(), both the master and slave controllers
are switched to video mode:

	dw_mipi_dsi_set_mode(dsi, MIPI_DSI_MODE_VIDEO);
	if (dsi->slave)
		dw_mipi_dsi_set_mode(dsi->slave, MIPI_DSI_MODE_VIDEO);

And when the panel subsequently sends DSI commands during unprepare,
dw_mipi_dsi_host_transfer() transmits the packet through both controllers:

	dw_mipi_message_config(dsi, msg);
	if (dsi->slave)
		dw_mipi_message_config(dsi->slave, msg);

	ret =3D dw_mipi_dsi_write(dsi, &packet);
	if (ret)
		return ret;
	if (dsi->slave) {
		ret =3D dw_mipi_dsi_write(dsi->slave, &packet);
		if (ret)
			return ret;
	}

Without switching dsi->slave back to command mode in
dw_mipi_dsi_bridge_atomic_disable(), won't commands sent during panel
unprepare reach the slave controller while it is still in video mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030055806.4102=
994-1-zhengxingda@iscas.ac.cn?part=3D1
