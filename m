Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D54606A331
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Bequcv+J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9858A89CD3;
	Tue, 20 Oct 2026 16:52:11 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF9F10E181
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 16:52:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 6A9D24E4128B;
 Tue, 20 Oct 2026 16:52:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 317CA60393;
 Tue, 20 Oct 2026 16:52:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D8C5110328D20; 
 Tue, 20 Oct 2026 18:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792515117; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=oSwcbatNs/0w1ybzYQUcJ96P49RIqvbDSPb+DvWsh68=;
 b=Bequcv+Jg52fBKJhrJ+2pPNgXW9jgM3F5Dw/WyO4tABcbekj85upeLJnZiyaBvB/ZHjBLF
 KZZRwL+zYFedV4RXGhj24geCAZHpUyXOpigdOvjHH7QmBThF6dQUS6gGgTxLEVLd42VLYw
 IF5yqtwsXSPyQ1vawmEa8b3SLSXZLZQJ3WJCqMCWqhPZhNCw6Ms0fhV6n2BaD8uJY4e+9b
 A1HVp7ER6JVY9qzJo0bxRskh5dpH5yw3hSPzViWu2ix0QBXiYHAZj2MrMi7lUn5Dg1P2OE
 wMu2NvCb0hTuT2VvDJKvEHo4KwocXunLgMPBqmuM5VSM2zd9hqfygVuN3bP6JA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 01/14] drm/bridge: it6505: quiesce event sources and
 work on remove()
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
In-Reply-To: <3f7ab3881c9dc575da02ddcd9b110a834a11f2ad.1790552614.git.daniel@makrotopia.org>
References: <cover.1790552614.git.daniel@makrotopia.org>
 <3f7ab3881c9dc575da02ddcd9b110a834a11f2ad.1790552614.git.daniel@makrotopia.org>
Date: Tue, 20 Oct 2026 18:51:39 +0200
Message-Id: <179251509973.78870.17205773072726643371.b4-review@b4>
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

> struct it6505 is freed by devres right after remove() returns, but
> remove() cancels none of the driver's work items, so link_works,
> hdcp_wait_ksv_list, hdcp_work and extcon_wq can still run afterwards
> and dereference freed memory. Cancelling alone would not be enough:
> the threaded IRQ and the extcon notifier stay live until devres
> teardown and can requeue the works.
>
> Unregister the extcon notifier and disable the IRQ first, then cancel
> all work. Make it6505_remove_notifier_module() idempotent, tracking
> the registration in a flag under extcon_lock, as both .detach() and
> remove() call it now. The notifier_call pointer is left intact:
> extcon traverses its raw notifier chain without holding a lock, so a
> traversal racing with the unregistration may still invoke the
> callback. Also initialise extcon_wq in probe: cancel_work_sync() on a
> never-initialised work item trips WARN_ON(!work->func).
>
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Looks good:

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

