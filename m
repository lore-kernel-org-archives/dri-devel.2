Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970DDCA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBFBD10E12D;
	Thu,  1 Oct 2026 15:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ieDfAB85";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4871F10E12D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 15:49:57 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 29AB14E41115;
 Thu,  1 Oct 2026 15:49:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E56BF60343;
 Thu,  1 Oct 2026 15:49:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BAD94103282D5; 
 Thu,  1 Oct 2026 17:49:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790869792; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=uGiWo6C+ycX09EU8H32CDb7AmZmrCKj9IV2lN2Mp/Hk=;
 b=ieDfAB85stwwyZZSONxP4MucbdJVdGaD4CpTNy0XtKFsHuWU+pNP8OS+xoLFHBrWXaM/Vp
 1WYzN+Wc8w6iie1fbCnX32LrMk6e5YzcWJnq1SKuenvHkWs0XZytGUfVprH2foGRrwKqBn
 ZWNyWpZxptuyAsWuQ/dcVlL7W+hgLx0KBfqpf8PflbL0Np7aC6MD86rEJaMHhGC2TF9P+T
 pzorWpQcNQpiRbvbXIEUJXHGri4D5wGd1qywEMeZGLxL3XLDuoBwXb6DIiZNK3lK0/BF0j
 PPDx1NfHnVBER6DpUYsTEn45LfFjbpasGktZ1AsxhDb/j1/C1zMS+rJOgrwA7w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 17:49:39 +0200
Message-Id: <DLTMCR2DR484.2J56NLPQEQO3M@bootlin.com>
Subject: Re: [PATCH v2 0/7] drm: remove deprecated *_of_get_bridge() from
 non-OF drivers (fixes build regression)
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Doug Anderson"
 <dianders@chromium.org>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray"
 <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
 "kernel test robot" <lkp@intel.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frank Li"
 <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>,
 "Icenowy Zheng" <zhengxingda@iscas.ac.cn>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Dave Stevenson"
 <dave.stevenson@raspberrypi.com>, =?utf-8?q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, "Raspberry Pi Kernel Maintenance"
 <kernel-list@raspberrypi.com>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260929-drm-fix-of_get_bridge-build-regression-v2-0-6da431d8f180@bootlin.com>
In-Reply-To: <20260929-drm-fix-of_get_bridge-build-regression-v2-0-6da431d8f180@bootlin.com>
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

On Tue Sep 29, 2026 at 3:39 PM CEST, Luca Ceresoli wrote:
> After commit Fixes: aa8a8c7e4641 ("drm/bridge: panel: move all code to
> drm_panel.c") some drivers fail building:
>
>   error: implicit declaration of function 'devm_drm_of_get_bridge'
>
> This is because devm_drm_of_get_bridge() (and drmm_of_get_bridge()) have
> been moved to drm-panel.h.
>
> The affected drivers are those which:
>
>  * can be built without CONFIG_OF, and
>  * don't include drm_panel.h
>
> The affected drivers are 3, fix them (patches 1-3) by replacing the
> deprecated *_of_get_bridge() calls with of_drm_get_bridge_by_endpoint().
>
> While there, do the same for all drivers which be built without CONFIG_OF=
,
> even if they don't fail (patches 4-7).
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Patches 1-4 and 7 applied to drm-misc-next. This includes all fixes to the
known regressions.

The two missing patches (5-6) are improvements, not bugfixes, and have
changes requested. I will send a v3 later on.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
