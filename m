Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3264ACD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DE8410E070;
	Tue,  9 Jun 2026 06:20:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="kQ+kUgOr";
	dkim-atps=neutral
X-Greylist: delayed 333 seconds by postgrey-1.36 at gabe;
 Tue, 09 Jun 2026 06:20:48 UTC
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [91.218.175.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E747910E0B8
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:20:48 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1780985712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=i2jpIDCVnNVhXSYDVvdDiQ1s+6wApppzolFVa3ePcBA=;
 b=kQ+kUgOrV6W6Jc16Kii3uxt27H6tnGH4ZT13H/tGloTnC2pxAr0+1e0lN87mGDlSsCwwUT
 byRLJdWy+OF38KcDXWI7VaMSELJjoswljJztiskoxvxrLRlYswbpJIeHHZA8qm2XiuHT4d
 nSyAaMFF4R+0aR7kWu7ve4uMSn0m2lc=
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
 Kaitao Cheng <kaitao.cheng@linux.dev>, Kaito Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH v2 00/14] list: Prepare entry iterators to cache cursor state
Date: Tue,  9 Jun 2026 14:13:33 +0800
Message-ID: <20260609061347.93688-1-kaitao.cheng@linux.dev>
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

From: Kaito Cheng <chengkaitao@kylinos.cn>

This series prepares for, and then updates, the list_for_each_entry()
family so the common entry iterators cache their next or previous cursor
before the loop body runs.

The first 13 patches open-code loops that intentionally depend on the
old "derive the next entry from the current cursor at the end of the
iteration" behaviour.  These loops append work to the list being walked,
restart traversal after dropping a lock, skip an entry consumed by the
current iteration, or otherwise adjust the cursor in the loop body.

The final patch changes include/linux/list.h to keep a private cursor in
the common entry iterators while preserving the public macro interface.
The safe variants remain available when callers need the temporary
cursor explicitly or have stronger mutation requirements.

Changes in v2 (Muchun Song, Andy Shevchenko):
 - Drop the list_for_each_entry_mutable*() helpers from v1 and make the
   cursor change directly in the existing list_for_each_entry*() helpers.
 - Open-code special list walks that rely on updating the loop cursor in
   the body, preserving their existing traversal semantics.

Link to v1:
https://lore.kernel.org/all/20260529082149.76764-1-kaitao.cheng@linux.dev/

Kaitao Cheng (14):
  drbd: Open-code transfer log list walk
  firewire: core: Open-code topology list walk
  drm/bridge: Open-code bridge chain list walks
  drm/i915/gt: Open-code active timeline walk
  drm/i915: Open-code DFS dependency list walk
  drm/ttm: Open-code reservation list walk
  spi: fsi: Open-code message transfer walk
  spi: stm32-ospi: Open-code message transfer walk
  spi: stm32-qspi: Open-code message transfer walk
  spi: tegra210-quad: Open-code message transfer walk
  locking/locktorture: Open-code ww mutex list walk
  locking/ww_mutex: Open-code stress reorder list walk
  ASoC: dapm: Open-code widget invalidation walk
  list: Cache cursors in entry iterators

 drivers/block/drbd/drbd_debugfs.c      |  4 ++-
 drivers/firewire/core-topology.c       |  4 ++-
 drivers/gpu/drm/drm_bridge.c           |  7 ++--
 drivers/gpu/drm/i915/gt/intel_reset.c  |  4 ++-
 drivers/gpu/drm/i915/i915_scheduler.c  |  4 ++-
 drivers/gpu/drm/ttm/ttm_execbuf_util.c |  4 ++-
 drivers/spi/spi-fsi.c                  |  5 ++-
 drivers/spi/spi-stm32-ospi.c           |  4 ++-
 drivers/spi/spi-stm32-qspi.c           |  5 ++-
 drivers/spi/spi-tegra210-quad.c        |  4 ++-
 include/linux/list.h                   | 46 ++++++++++++++++++++------
 kernel/locking/locktorture.c           |  4 ++-
 kernel/locking/test-ww_mutex.c         |  4 ++-
 sound/soc/soc-dapm.c                   |  4 ++-
 14 files changed, 78 insertions(+), 25 deletions(-)

-- 
2.43.0

