Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989ACFED9EF
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0234910E2D3;
	Tue, 17 Mar 2026 16:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="idlYn6ci";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72DD510E2D3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 16:57:16 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E5F5B4E426D5;
 Tue, 17 Mar 2026 16:57:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B434D5FC9A;
 Tue, 17 Mar 2026 16:57:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 03FB11045064F; Tue, 17 Mar 2026 17:57:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773766634; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=2QiYV0F71/XCbw152RM6X3SUP+u3rVdD48n9j2zpTNo=;
 b=idlYn6cirZQnbwBwMFIxbmUFgeiBkSiCXnt8aVYNf+2yhH97aVLl6ldyVeuLNBCrZdriKU
 Jbq8XCY/S96PtASuWvwO+2dnTIDsJfyyEUIiadCsIDHz5G8VD6dbRPqdwK0XsFSMd1MHf4
 bLkZRLBdhTXZ0x3zWpKXrI0znwOK1L+mb9GYad+Ihvn+f5VeWpDyNMltxgoofNxtzeqeu6
 lA3csGHOt1pbsmyXO72cWO/4MQPxXnLpnSougWijkGOImQ3486aaapZlH42oyGYgtmaYHb
 RLdgon4Zu0EOT3J3VhxJkEEnaPM9RIWFiJGFd74VFSkQX6OSWg2TzlTqrXQL/A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>
Cc: Bajjuri Praneeth <praneeth@ti.com>, kernel test robot <lkp@intel.com>, 
 thomas.petazzoni@bootlin.com, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
In-Reply-To: <20260305163907.717719-1-kory.maincent@bootlin.com>
References: <20260305163907.717719-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH] drm/tilcdc: Fix type mismatch
Message-Id: <177376662887.1844168.2498672453922409208.b4-ty@bootlin.com>
Date: Tue, 17 Mar 2026 17:57:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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


On Thu, 05 Mar 2026 17:39:06 +0100, Kory Maincent wrote:
> cpu_to_be32() returns a __be32 big-endian value, but the compound literals
> passed to tilcdc_panel_update_prop() were typed as u32. This causes a
> sparse type mismatch warning. Fix it by using __be32 as the compound
> literal type to match the return type of cpu_to_be32().
> 
> 

Applied, thanks!

[1/1] drm/tilcdc: Fix type mismatch
      commit: 27a39e135f5c1ceaf73e64648eccdb42b751d5c7

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

