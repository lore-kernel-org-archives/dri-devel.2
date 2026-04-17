Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E243F436BB
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D0B510EA6B;
	Fri, 17 Apr 2026 16:12:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="HzwVPUOk";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B7EF10EA6B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:12:33 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A69FC1A332B;
 Fri, 17 Apr 2026 16:12:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 70CA460497;
 Fri, 17 Apr 2026 16:12:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7F3BD10460917; 
 Fri, 17 Apr 2026 18:12:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776442350; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6P0bROl+jiUSEISiQirvzHj8llaa9iOTsDFOgUDlYaU=;
 b=HzwVPUOkMAavjqxI2btzyz8KrXu6hROGyspTpaeN5myBEGTPwJ4lz4dYQsW9EDYF1YI7lo
 P1lVu+P5hsh8PALCa9hjEbHmNTMuKn4Ri3+qdz7KFpKhVthPFdo/68T64SOSERvemEU58S
 uMBr4W+jwDtkwXDXYzj9YXUpJezvoYl5EQglq9Jro4dcWKvQV1aiQJlBwow3Lucbe3dGVz
 vMBcvPmdU7VM+aciB7kEycC3iSjtjTjkd53kAOFMUt4/iuY9mky5uJfcCZM1zfDPVRaI5w
 4EHzGQTZEm2Iclb6gJsHePAFPKaaGbKYr+V2rRzQMMlRVLNk8aUOENeWkodzHw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 18:12:23 +0200
Message-Id: <DHVK967C5MJZ.180MLBBA7DEKY@bootlin.com>
Subject: Re: [PATCH] drm/bridge: tda998x: Return NULL instead of 0 in
 tda998x_edid_read()
Cc: "Bajjuri Praneeth" <praneeth@ti.com>, "kernel test robot"
 <lkp@intel.com>, <thomas.petazzoni@bootlin.com>, "Russell King"
 <linux@armlinux.org.uk>, "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
To: "Kory Maincent" <kory.maincent@bootlin.com>, "Jyri Sarha"
 <jsarha@ti.com>, "Russell King" <rmk+kernel@armlinux.org.uk>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260417155446.1068893-1-kory.maincent@bootlin.com>
In-Reply-To: <20260417155446.1068893-1-kory.maincent@bootlin.com>
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

On Fri Apr 17, 2026 at 5:54 PM CEST, Kory Maincent wrote:
> From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
>
> tda998x_edid_read() returns a const struct drm_edid pointer, but when
> tda998x_edid_delay_wait() fails (process killed while waiting for the
> HPD timeout), the integer literal 0 is returned instead of NULL,
> triggering a sparse warning: "Using plain integer as NULL pointer"
>
> Replace 0 with NULL to fix the sparse warning.
>
> Fixes: c76a8be4feec ("drm/bridge: tda998x: Add support for DRM_BRIDGE_ATT=
ACH_NO_CONNECTOR")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604172257.Imo6GOH9-lkp@i=
ntel.com/
> Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
