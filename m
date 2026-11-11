Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF8606A887
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kLItfe7U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93E310FA5F;
	Wed, 11 Nov 2026 10:37:32 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94EB110FA5F
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:37:26 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 72562C69165;
 Wed, 11 Nov 2026 10:37:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B57326017E;
 Wed, 11 Nov 2026 10:37:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 10B5B11BC10EE; Wed, 11 Nov 2026 11:37:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794393443; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qbvOK4wGLvq6MAbrIiYOQK6EHUzZB6RXJUnU4xqfb1Y=;
 b=kLItfe7U0H3r8+ahfhHE4RMyE3GB7QPGfo6TZx+IIVB7GZFu1bRFe3rNsFikTdIy7nJeNa
 YPw3AEFP+F6Vm2D+qpNW6w3kAtGy8DhbWjxIkZPiAP1LLBEKS9VrZoEvRScs88Izbp3aQq
 bufiNV94Acg/GWCNvat5cd/kr9DevU//zDgD8i3fl3WcRNvW0u0QHVjJiGqf2BC1qUoeyk
 mZiQHpj6p4eeb00GF2xPkjNugVHy7W2smZ09X7YrSGUGpK0lia10BZroiYrjwAJi+crgdo
 Eqn7im90zdBW7ABoCpkotJDIgnEi+b0cbq/ILLMFTbhT7vdRMbFRWLOxQ9ZHHQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260929130701.1029644-1-alexander.stein@ew.tq-group.com>
References: <20260929130701.1029644-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v2 1/1] drm/bridge: tc358767: register DP aux bus even
 in DRM_BRIDGE_ATTACH_NO_CONNECTOR case
Message-Id: <179439343868.1617651.10273802266437546850.b4-ty@b4>
Date: Wed, 11 Nov 2026 11:37:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 29 Sep 2026 15:07:00 +0200, Alexander Stein wrote:
> Even if DRM_BRIDGE_ATTACH_NO_CONNECTOR is set the DP aux bus has to be
> registered. Move the flags check after registration.

Applied, thanks!

[1/1] drm/bridge: tc358767: register DP aux bus even in DRM_BRIDGE_ATTACH_NO_CONNECTOR case
      commit: d360c8eba0f174ae81d2a1343a7371bd7514429d

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


