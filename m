Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C17FEEF33
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 13:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAC7110E0F9;
	Tue,  7 Apr 2026 13:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="i0FywnFm";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D8B10E0F9
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 13:03:15 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 6530E4E42935;
 Tue,  7 Apr 2026 13:03:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3867D603C7;
 Tue,  7 Apr 2026 13:03:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 35B8410450143; 
 Tue,  7 Apr 2026 15:03:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775566992; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=F1J4OADq0wUd+CFSiWdB9CfbFoV+7FIneu6rPiEpIdA=;
 b=i0FywnFm2eZ71AI1BHAmGZpkx+d2ERDXvi5PQ3o9CO83pdRvJkFgi1/3qc63HNajilnAoH
 VGMB3z1Y1+twFaHA2UZMiF7Gv9beoahe+X2iF/OgyozP0JXPFfCiuiUv3BmjtSyno/zOji
 BhA5phd/eho4FtSfhetL96nfCBkElWyemDxO2HuPzUZzGzyHX7EhFC3fd87wpbI69n4ZPB
 j0EzRrD2eT4Gf2VnM6V8QvB5+IYxk858B/wtbqq5Czc+8HQBeTn3nst1K6Nuz5ZvS4T66U
 PboI+uBfRGsjDMDOWWTqMgsJ02/3SSldwB5KpgZW0U5G3d6jm6hROiTFYp7BUw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Apr 2026 15:03:05 +0200
Message-Id: <DHMXYSF3YNM9.42X7R9K21KOW@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2] drm/bridge: dw-mipi-dsi: Fix bridge leak when host
 attach fails
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, "Douglas Anderson"
 <dianders@chromium.org>, "Manikandan Muralidharan"
 <manikandan.m@microchip.com>, "Kees Cook" <kees@kernel.org>, "Heiko
 Stuebner" <heiko@sntech.de>, "Andy Yan" <andy.yan@rock-chips.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260403145208.15890-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260403145208.15890-1-osama.abdelkader@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri Apr 3, 2026 at 4:52 PM CEST, Osama Abdelkader wrote:
> dw_mipi_dsi_host_attach() and dw_mipi_dsi2_host_attach() call
> drm_bridge_add() before pdata->host_ops->attach(). If attach fails,
> the bridge stayed registered without drm_bridge_remove(), leaking the
> bridge reference and leaving the device on the global bridge list.
>
> Fixes: 90910a651123 ("drm/bridge/synopsys: dsi: add ability to have glue-=
specific attach and detach")
> Fixes: 0d6d86253fef ("drm/bridge/synopsys: Add MIPI DSI2 host controller =
bridge")
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
