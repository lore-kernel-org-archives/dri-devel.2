Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050DACD8CA8
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 535D610E0D7;
	Tue,  9 Jun 2026 06:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="CpXqR0D8";
	dkim-atps=neutral
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [95.215.58.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1657B10E0D7
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:37:50 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1780986514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=smwcSwpSx3877vgkJVhF1DUcaQotbwHyv2wtpxTd7yQ=;
 b=CpXqR0D8sDUMklAOU53IFxyjHsOAHr7bre1RxmD/ICXb8vVnoTPwyiQ7PJllPlM2do2vji
 CZWIYF0tP4l5AIedEPdZwtoflwzjSpnKrsJsyiN0Col7fpwtC3VkX3UiTLeELwoG0QQZ8s
 IRkZWlzKv1ScExqwZEUL82ocOW2B5Z0=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Muchun Song <muchun.song@linux.dev>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Eddie James <eajames@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Waiman Long <longman@redhat.com>,
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kaitao Cheng <kaitao.cheng@linux.dev>,
 Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH v2 09/14] spi: stm32-qspi: Open-code message transfer walk
Date: Tue,  9 Jun 2026 14:25:21 +0800
Message-ID: <20260609062526.94907-7-kaitao.cheng@linux.dev>
In-Reply-To: <20260609062526.94907-1-kaitao.cheng@linux.dev>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <20260609062526.94907-1-kaitao.cheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

From: Kaitao Cheng <chengkaitao@kylinos.cn>

A later change will make list_for_each_entry() cache the next element
before entering the loop body. stm32_qspi_transfer_one_message() can
consume the following transfer as part of the current operation and then
advance the loop cursor to that entry.

Keep the transfer walk open-coded so the loop step observes that cursor
update and skips the consumed transfer. This preserves the existing
message sequencing semantics and prepares the code for the list iterator
update.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 drivers/spi/spi-stm32-qspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index df1bbacec90a..27d82a578c9f 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -577,7 +577,10 @@ static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
 
 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), true);
 
-	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
+	for (transfer = list_first_entry(&msg->transfers,
+					 typeof(*transfer), transfer_list);
+	     !list_entry_is_head(transfer, &msg->transfers, transfer_list);
+	     transfer = list_next_entry(transfer, transfer_list)) {
 		u8 dummy_bytes = 0;
 
 		memset(&op, 0, sizeof(op));
-- 
2.43.0

