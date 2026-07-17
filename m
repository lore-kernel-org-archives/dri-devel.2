Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D9AC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE1F10E45A;
	Fri, 17 Jul 2026 14:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="t64qZ7iP";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79DA310E45A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:02:43 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A99D01A105F;
 Fri, 17 Jul 2026 14:02:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7C7D960361;
 Fri, 17 Jul 2026 14:02:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 137BA11BD0007; 
 Fri, 17 Jul 2026 16:02:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784296957; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6y4E2HeKoBDCQVi+JB+A3GuJXSQ7xBzliEdGumlAGC4=;
 b=t64qZ7iP2dZq4iOGNeg4J9z6BRLMofsv5RvDKkkuhYMgbB6k1XE7j9XGyrH/Mt1HOQ6aeQ
 eqhpQPQNTZlmSNp0RGAUw+ZxSS9mHNtd3SL9IbrhZo053pw67SwoVmJNHqvJ14oeitSpGD
 shcy309WBaeWVhFqv4TFozD83aiySgMnxPx+DzKWvL+jwA4K26V/qUix2XHyms8MY04ffS
 dVe8doWJr1dFNfg32FXwm9/jIAl7KGXi2R58+EqC6yYMXpkrw/4wl5uWNdA4cBJCaXWcCj
 BjZudZ7lIL7pmnzBqHMxoDjPAs3NJEiTi/hR32O1vbjTC0o8NBX9aOpu4hL8nQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 16:02:31 +0200
Message-Id: <DK0WHBO1R2YM.284307RZK645L@bootlin.com>
Subject: Re: [PATCH] drm/bridge: Replace outdated forward declaration
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
To: "Laurent Pinchart" <laurent.pinchart+renesas@ideasonboard.com>,
 <dri-devel@lists.freedesktop.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <20260703224143.3886069-1-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20260703224143.3886069-1-laurent.pinchart+renesas@ideasonboard.com>
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

On Sat Jul 4, 2026 at 12:41 AM CEST, Laurent Pinchart wrote:
> The drm_bridge.h header forward-declares struct edid, whose last usage
> in the file was removed in commit 27b8f91c08d9 ("drm/bridge: remove
> ->get_edid callback"). Commit 11f6c4b1b259 ("drm/bridge: Add
> connector-related bridge operations and data") then introduced usage of
> struct drm_edid, without a corresponding forward declaration. Fix those
> two issues by replacing the struct edid forward declaration with struct
> drm_edid.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
