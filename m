Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76A1C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44BF10E852;
	Mon, 28 Sep 2026 08:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="ISSf/tqA";
	dkim-atps=neutral
X-Greylist: delayed 387 seconds by postgrey-1.36 at gabe;
 Fri, 25 Sep 2026 12:47:17 UTC
Received: from mail-proxy25236.mail.163.com (mail-proxy25236.mail.163.com
 [103.129.252.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB14C10E90C
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=LC
 j1gS6mo+8bA9TVubBcb0q4WeEjMzjeJmbHoKOVv9s=; b=ISSf/tqANPthljrCKs
 ffTfZqWSE0PmG0mBAt382veh8FMr06CacyotBKczDtcq1Ve/dkWVExt9eZhjzICg
 76d2DV84COuDve62TY6DrqYi4bMdAy9bR36FspMFqCLtyf7jGoWtXJR7ZFImxjgG
 5//EmUXJ2DVsVCEJ8AZF1Qw6o=
Received: from pc.localdomain (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wD3_5u5arZqp98VAw--.59006S2; 
 Fri, 25 Sep 2026 20:36:10 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Mehdi Djait <mehdi.djait@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/tiny: sharp-memory: reject devices without match data
Date: Fri, 25 Sep 2026 20:36:08 +0800
Message-Id: <20260925123608.2082429-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_5u5arZqp98VAw--.59006S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw15uF1kCF4kWw4DXr4rGrg_yoW8GF4xpr
 4xJF90kryDJFnIka1xGa1DCFy5Z3WvgayrGFy7AwnIgrnxCFyUZryxK3yYqry8JrW3GFy7
 tFnrJrWfWas2yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piL0ePUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhoRS2q2arpTXwAA3O
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

sharp_memory_probe() immediately dereferences the returned display mode
to calculate the pitch and transmit buffer size, causing a NULL pointer
dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before using the display mode.

Fixes: b8f9f21716fe ("drm/tiny: Add driver for Sharp Memory LCD")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/gpu/drm/tiny/sharp-memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index 7efd7b567f3b..049e98f657f3 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -557,6 +557,8 @@ static int sharp_memory_probe(struct spi_device *spi)
 
 	drm->mode_config.funcs = &sharp_memory_mode_config_funcs;
 	smd->mode = spi_get_device_match_data(spi);
+	if (!smd->mode)
+		return -ENODATA;
 
 	smd->pitch = (SHARP_ADDR_PERIOD + smd->mode->hdisplay + SHARP_DUMMY_PERIOD) / 8;
 	smd->tx_buffer_size = (SHARP_MODE_PERIOD +
-- 
2.34.1

