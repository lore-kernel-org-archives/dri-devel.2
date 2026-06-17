Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC740CD98F3
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F06710E85C;
	Wed, 17 Jun 2026 16:02:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="BGFm1QRw";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F21010E85C
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 16:02:34 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 5627BC2B9FF;
 Wed, 17 Jun 2026 16:02:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4D6A1601AA;
 Wed, 17 Jun 2026 16:02:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ADFA6106C8586; 
 Wed, 17 Jun 2026 18:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781712152; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=iwMtEM2T60ynSijh5S8MXf0a2p138A2HNJ3VCfrEp+s=;
 b=BGFm1QRw/kU3T7JBTN+BRTX9bR4TtuC3hmqiVyhXa9eCRApyKnmIcqNNtXnzFXns6VFPO1
 fbydQHvMd81Xm96pmJWErwM1fjKVJ7tIWNpiqetAKUOj86LexgTu+v+Y6pASn9pL97Ku8q
 praT/tD55qplAlIkd88+HAnL6zFai+QFkDY7ufdoP97CLglrCjM8AuiTplsrPwQICl9oAZ
 LvrNe+1wgMfw9T8IluWTroAAbYVDIhNyxJ/0WlpnzGJij4gZ4WIB/82JJMIh0yXQynf70O
 /ly9HgBPRpLKt45NhBkm8NfJGy+BtwWs9pFEROTS1Fao5UMRnbjt57wlvtsScw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 03/78] drm/atomic-state-helper: Rename
 __drm_atomic_helper_bridge_reset()
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-3-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260608-drm-no-more-bridge-reset-v2-3-0a91018bf886@kernel.org>
Date: Wed, 17 Jun 2026 18:02:16 +0200
Message-Id: <178171213661.312625.3305256746748374254.b4-review@b4>
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

On Mon, 08 Jun 2026 16:35:45 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> __drm_atomic_helper_bridge_reset() is used to initialize a
> newly allocated drm_bridge_state, and is being typically called by the
> drm_bridge_funcs.atomic_reset implementation.
> 
> Since we want to consolidate DRM objects state allocation around the
> atomic_create_state callback that will only allocate and initialize a
> new drm_bridge_state instance, we will need to call
> __drm_atomic_helper_bridge_reset() from both the atomic_reset and
> atomic_create_state hooks.
> 
> [...]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

