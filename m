Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D9DCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2BB610E064;
	Tue, 29 Sep 2026 10:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="yr/lQ+cH";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2668610E064
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:26:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 52EFE4E410B7;
 Tue, 29 Sep 2026 10:26:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 097E0601BD;
 Tue, 29 Sep 2026 10:26:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E000F10328018; 
 Tue, 29 Sep 2026 12:26:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790677574; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=btRHvqc+GZq+uriH33EH+G3Kt+qUrdgIIHAw6CNyiAk=;
 b=yr/lQ+cHZgRAeMbjHWCLcTevfD7wnq7SWEJKzk593NHY+Hvs8u4YDVMEzQ/GvZYhXv7EtP
 oH+u6gT3/NkBqDrKpNV3MKf85Dh2TYp19xxLev6vuMEb4yvPIjmXXOIIRV+5ir8LAgLKzt
 gEMShrQntj5Xq5RCaA6iHIgX5syA7wjEgJhvsIfup6Zo7IZlA6XHskdusQsDh8oDQsWIMh
 vZP/GCNiRJer2ueBRRoJvlHORG8isDpaLYGIpM4yayuyxr5e7qzOcG+uQp6577niDhG9ou
 VaIGDutXK8zG2s5zUmaqkfUMR2XQRpdGyx5OgOKW0ezuy3kMvhqJSiCix8jZ1g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 12:26:09 +0200
Message-Id: <DLRQ7Z331OX6.HIK92AEHY682@bootlin.com>
Subject: Re: [PATCH] Documentation/gpu: fix location of drm_panel kernel-doc
Cc: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 <dri-devel@lists.freedesktop.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>, <linux-doc@vger.kernel.org>
To: "Randy Dunlap" <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260928210326.1526997-1-rdunlap@infradead.org>
In-Reply-To: <20260928210326.1526997-1-rdunlap@infradead.org>
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

On Mon Sep 28, 2026 at 11:03 PM CEST, Randy Dunlap wrote:
> The source file location was changed, so update the documentation
> accordingly. Fixes these warnings:
>
> ERROR: Cannot find file ../drivers/gpu/drm/bridge/panel.c
> ERROR: Cannot find file ../drivers/gpu/drm/bridge/panel.c
> WARNING: No kernel-doc for file ../drivers/gpu/drm/bridge/panel.c
>
> Fixes: aa8a8c7e4641 ("drm/bridge: panel: move all code to drm_panel.c")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
