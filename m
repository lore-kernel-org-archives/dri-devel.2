Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD97606A338
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XlzxxB18
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA511123E5;
	Thu, 29 Oct 2026 15:40:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D1B31123E5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:40:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C152460207;
 Thu, 29 Oct 2026 15:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3136C1F01816;
 Thu, 29 Oct 2026 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793288412;
 bh=RHw1aYirtGLWEJrMfPnVO+TQAlJFan7Jz73AK4ixAno=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XlzxxB183dig8nNxRzKCrPIxh70Y4BKALIobC8q0/qnRgD3RNFSU3mtKeAUi2Z/fP
 vi21RvPbHIqFDc4WlNwbOKXQcAUQMmt/n8WgR6MYNZCkXULqtWhbbBEQTRA3lF36du
 G0gpVoH59013sIji8bJjc7lgQdscMas3EuntuudpUJRmqbTvmQRGUyTthdz/VnAEWg
 Q8w6PDj9grKL0awA8K8XAJUKDP6/WFQl7pKpSXurbxbBsSNzH9z6PXtNwhMG4bUmIz
 vM176+PYhg3CEoCXDhPutAL5KofX0/5FopNjP9yhvhjHSiIVEmzyguspptaPKwl9/E
 gCZKBmhRDpKHg==
Message-ID: <sashiko-outbox-189624@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/11] drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI
 Type B panel driver
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029152909.234584-4-clamor95@gmail.com>
References: <20261029152909.234584-1-clamor95@gmail.com>
 <20261029152909.234584-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:40:11 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/panel: selecting DRM_MIPI_DBI without SPI breaks CONFIG_SPI=3Dn=
 build
--

commit 6d2fecb3d7209826695a1566f8263dc71e26e02f
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI Type B panel driver

This commit adds a DRM panel driver for the Hitachi TX10D07VM0BAA 4" WVGA M=
IPI
DBI Type B panel used in the LG Optimus 2X P990 smartphone.

> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 7a520b4d60fef..0e86628bcdb80 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -274,6 +274,20 @@ config DRM_PANEL_HIMAX_HX8394
> =20
>  	  If M is selected the module will be called panel-himax-hx8394.
> =20
> +config DRM_PANEL_HITACHI_TX10D07VM0BAA
> +	tristate "Hitachi TX10D07VM0BAA MIPI DBI Type B panel"
> +	depends on OF
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_MIPI_DBI

[Severity: Low]
Does selecting DRM_MIPI_DBI here without a dependency on SPI cause a build
regression when CONFIG_SPI is disabled?

Previously, every Kconfig symbol selecting DRM_MIPI_DBI either depended on =
SPI
or used conditional selection on SPI. With DRM_PANEL_HITACHI_TX10D07VM0BAA
selecting DRM_MIPI_DBI unconditionally, drivers/gpu/drm/drm_mipi_dbi.c can =
now
be built with CONFIG_SPI=3Dn.

In drivers/gpu/drm/drm_mipi_dbi.c, mipi_dbi_dcs_read_commands is defined
outside the CONFIG_SPI guard:

static const u8 mipi_dbi_dcs_read_commands[] =3D {
	MIPI_DCS_GET_DISPLAY_ID,
	...
};

However, its only user is mipi_dbi_spi_init(), which is inside the
#if IS_ENABLED(CONFIG_SPI) block:

int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *dbi,
		      struct gpio_desc *dc)
{
	...
	dbi->read_commands =3D mipi_dbi_dcs_read_commands;

Because drivers/gpu/drm/Makefile enables -Wunused-const-variable:

subdir-ccflags-y +=3D $(call cc-option, -Wunused-const-variable)

building with CONFIG_DRM_PANEL_HITACHI_TX10D07VM0BAA enabled and CONFIG_SPI=
=3Dn
triggers an unused-const-variable warning on mipi_dbi_dcs_read_commands (wh=
ich
becomes a build error with CONFIG_DRM_WERROR or CONFIG_WERROR).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029152909.2345=
84-1-clamor95@gmail.com?part=3D3
