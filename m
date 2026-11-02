Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAF1606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YDo/lVhP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D4B10ECE6;
	Mon,  2 Nov 2026 10:53:57 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AFFF10ECE6
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:53:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 97E164E413C7;
 Mon,  2 Nov 2026 10:53:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6171C60750;
 Mon,  2 Nov 2026 10:53:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3055F10329123; Mon,  2 Nov 2026 11:53:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793616826; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=hIwGhic9aaDhslXB1BlcS2a5aNVnMVxhww6Z0E20VcU=;
 b=YDo/lVhP3Dm7tO3q2+wJCZaZCE2zgSZgs4MkYq0+w4Qc9kxFdX0fBtHQN3jRm/k/0k79ht
 YPZgvL+waZCSIJ8Bia9aam2Y5msSvgHqSJiYRXok3Dvvfc8NOB/+MCh1NVuSnFEi3ViwVQ
 9DOEOgVUBH4HSmDqw11AinfajC4LCIkC5n0DeECEFue6MlPJYvnCx+J3Rqsf4dnIicatii
 22SDckuf2HGhOhVtnHDjAwElgXiqbJFkiUtzCZ9cXNsXATgL0YU2rygSas5CoY3rfubA3d
 gARBCuk+/GPT9wZWvXDuO7FiFLEsdLeDL1AXKFT9LM+oBG/geFQ0EiqGCr+6oQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261012-drm-bridge-every-panel-cleanups-v1-0-0fd272f486b6@bootlin.com>
References: <20261012-drm-bridge-every-panel-cleanups-v1-0-0fd272f486b6@bootlin.com>
Subject: Re: [PATCH 0/3] drm: docs: mention currently recommended API
 instead of deprecated ones
Message-Id: <179361681996.195621.6558770131023458556.b4-ty@b4>
Date: Mon, 02 Nov 2026 11:53:39 +0100
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


On Mon, 12 Oct 2026 16:29:50 +0200, Luca Ceresoli wrote:
> This series replaces references to deprecated functions in the docs with
> the current recommended API.

Applied, thanks!

[1/3] drm/bridge: stop mentioning deprecated devm_drm_of_get_bridge() in docs
      commit: 70c53f96dd0167cc88fffb117909881017fac253
[2/3] drm/panel: stop mentioning deprecated devm_drm_of_get_bridge() in docs
      commit: 1b2dbea054aaa424a294309949c288bd31a139fc
[3/3] drm/drv: stop mentioning deprecated drm_of_find_panel_or_bridge() in docs
      commit: ba1019c160cc550c8f2648f0a93e6f556a2a15d9

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


