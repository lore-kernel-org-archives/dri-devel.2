Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61484CD5BD2
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 11:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E3D10E628;
	Tue, 26 May 2026 11:35:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="DYoe+6bX";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A14F10E629
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:35:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0CD2B1A36CE;
 Tue, 26 May 2026 11:35:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D2CB76011D;
 Tue, 26 May 2026 11:35:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 92F081088862E; 
 Tue, 26 May 2026 13:35:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779795344; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=vJ2eTxf2bOVB2Sa7mZv6SIpQ81Big2MiLsICy7jB5PM=;
 b=DYoe+6bXw5m8ZJKwqMS1WuttC+jB6JzYjN3iyEeckKdvP2CCHq7NvuM1BfhEuondkKeBrm
 JpfLx6uAj0o0eDAxDSfb6ylNyo0YcFLf1sC/woMw2CYQfZs4ckOCt8NsOoapLAQg4Y5d11
 C0FLvcIpSGNmsJjqc5lViRHxylwkZB2eY3el2sNa/qPPGPKkXqWGCxv2Z0Bo6c3BJAr6ry
 W5fqiXpoCqP6bIHV6q7iDQyizpmgqkGDn+XWyLt9r+iMjQFamsf7twI4HVO6gX+tbUaKCU
 zVQj8YapsyezjEyCPVrBSn4DsswyOhc9++ASi9eM5Qh6KwFHo37qec2lVtXBig==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/4] drm/scdc-helper: Don't use ssize_t return type
 for scdc_read/write
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com
In-Reply-To: <20260526-scdc-link-health-v3-1-59e4a4aaead1@collabora.com>
References: <20260526-scdc-link-health-v3-0-59e4a4aaead1@collabora.com>
 <20260526-scdc-link-health-v3-1-59e4a4aaead1@collabora.com>
Date: Tue, 26 May 2026 13:35:32 +0200
Message-Id: <177979533269.297330.8882105635223780267.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Tue, 26 May 2026 12:19:57 +0200, Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> drm_scdc_read and drm_scdc_write, both of which are only used within
> drm_scdc_helper (although exported), use a ssize_t as their return type.
> 
> This would make sense if they returned the number of bytes read/written
> on success, and negative errno otherwise. However, they return 0 on
> success.
> 
> [...]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

