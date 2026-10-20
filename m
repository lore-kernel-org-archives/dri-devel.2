Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE61E606A332
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=dJFL0Zy8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A69010E274;
	Tue, 20 Oct 2026 16:52:46 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2965310E274
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 16:52:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id F01F81A1295;
 Tue, 20 Oct 2026 16:52:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BCCAF60393;
 Tue, 20 Oct 2026 16:52:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CD03E10328D3B; 
 Tue, 20 Oct 2026 18:52:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792515151; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=V3lBDfIe7IPx+fVGzM7Ta3HhcKvhZuUi7zb60B5W+JI=;
 b=dJFL0Zy8azXfiqvY/WRgiT8WQotmB1KAuidILhoUdNPBv769NTqgbNd19lLAIGUdWLwVhp
 rTXLpvD2CPSoGBjTtriooq24ujx0+Bkz3SJooa0HMOZ51JBjDId0aglWz5oVSoUqi6lfhK
 3kFFcSD4NlTFi6lTrMjCozeRdgFCvnpwtPrdCy/mO2Y7dqTLWMMpTe7zqf7lKqfU2VFG6w
 xqsDEir8UAL1ceWpFFI7P2sHoK9gJzEVeGuZ2ORgFK37/NvKZcYgHJbE0jOrRD2IM7zipa
 CFC4WxxGm8Fef/yONhmlerfvxl9w9AKMQyrOr/yWbqn0QEF6Tb0/x1dv1C6lYQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 05/14] drm/bridge: it6505: complete poweroff even if
 disabling regulators fails
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hermes Wu <hermes.wu@ite.com.tw>, Allen Chen <allen.chen@ite.com.tw>, 
 Pin-yen Lin <treapking@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <94daa219c80275afc8d2dd85df72c602f0d3e646.1790552614.git.daniel@makrotopia.org>
References: <cover.1790552614.git.daniel@makrotopia.org>
 <94daa219c80275afc8d2dd85df72c602f0d3e646.1790552614.git.daniel@makrotopia.org>
Date: Tue, 20 Oct 2026 18:51:39 +0200
Message-Id: <179251509977.78870.1985601064843306523.b4-review@b4>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 28 Sep 2026 00:50:10 +0100, Daniel Golle <daniel@makrotopia.org> wrote:
> it6505_poweroff() returns early when regulator_disable() fails,
> leaving it6505->powered set with the IRQ already disabled. The next
> it6505_poweron() then takes its early return and never re-enables the
> IRQ, leaving the bridge deaf to hotplug and link training interrupts.
> The regulator core keeps the consumer's enable count on a failed
> disable either way, so bailing out only adds a wedged bridge on top of
> the leaked reference. Log the error and complete the power-off state
> transition instead.
> 
> [...]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

