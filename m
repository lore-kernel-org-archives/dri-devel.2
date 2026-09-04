Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2D3C79F87
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 556FC10E55A;
	Fri,  4 Sep 2026 13:09:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sDWDyvg8";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3930D10E54F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:09:34 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4843886fc9cso157793f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 06:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788527372; x=1789132172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YJGYKkSgbzFZQ6ZkgtL51SBo2xzg1ldls2lL4TqE+fM=;
 b=sDWDyvg886t+KFXJ3ig9naKWLQQswNMFrx2am6logWLxotcT7gcHnHcHu2+d2AtrYb
 wouyMEDaL/+hYM4PAzejDaHAscKi/LryHhjsaP4wiYgE5VCrxnLZS+RCK64/Zhr34+d0
 wAmYGXtQgxPkKdxcTQvY0Wb+FzcRsan1kqese5ddkHlVl9NnuX0XcX3ywJkyqlwSdOim
 DCOOPCsWxxT2TgmZipKxyD4Pq1OQDe4aIlum0KdoBjbnojrQipQJ3rj8+WZ/Wvhr+FXJ
 +0LZ8RCkzpfksama6xZfKa1xBw1sVO+kFq/8kId6aOClfV+9KvMPEp/T/4T5sl7iVQp1
 x8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527372; x=1789132172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YJGYKkSgbzFZQ6ZkgtL51SBo2xzg1ldls2lL4TqE+fM=;
 b=FUcbdhjJLZVG4Pu2PAJqKuPINt6Tq5H5y680XNqymOqO+Rm6WroGPxQdxzuc/X6aaD
 l47+fWVe2M7rswCCj0i1tqJ1gYgkF35MK+UWdxq+z3avXtnLzUyvOswhXoG6pwHC8lIt
 e8kmzpFUTo5FlLe8VfXoSKMF/w5SSYA8eazsy26EKWzqhidlcfDx8jVLCAJfhyUihqc9
 fJu4R+um/KMNczrty0b3HwL+Td0QI4q9WNd67peNUfyJpDCIG6uaXYrAGEykDvoAWFt+
 618NInAkEpbeQNa56pXAJMN1OQNz5fCScrhPvSMUmsanAAgrdy5QQKSTgeORqPQiYwxk
 zl4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXXp00Ob4unGNE45VXpaTDElZqupzAgnC9radLpjjZ+trKUVNCcXOI+azCKCUdJQsb07M7EhcZPRA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lPKEQmR/oZDXR8QzYZhPkt++gGVQ9FaPjyImHw2CIv2cxkQ61y
 Kl342G8k3hjhNg1Uc7Y8HsXphXGrQvvMAHUX7IxW0IFbLVCssHiJjPdR
X-Gm-Gg: AYBFou3GmePEifJ80xaJ9FttRzPWswJ8Ayvzpw+3GNZYSDBcWIK4VAr0kk76UMAvxVO
 EcSg5MuJ/ytp3cwP735c3G2/05J5HWLa+biXGnU0VOovnaFImJuoYJswiSY6xBzaWb4ZSRHdfnu
 K6YbRg8BYZaawEoH2uh945rvAyqdbpXpYoeoPRLKQHe1+Da+j8hV1hwF76iK5k4G0AGxzF3Edk4
 SbZSmzJ/4r1dXHa/js7LwPnvsKB/W+25LrrPZRv036GxdlFTX9C7v+8mdyLcMm9bYsSOdtwVUwC
 43zk0LUXP1a0e3MHtOR6dPQgvruh2V8WP2cw0HNTruA41DmacDlEcvw6oXn64Z203kPMBw+d1S7
 Bty8qEiL6EmZEIflNhsFreWKtnBoLMx6I9c1VUCA9KqLOT4Wob7VbJwBScNT2AJo/L/pENY/jXm
 bny5ILYYIf7kXU+qMIARnt3VXjY5xy1UB8KmThQx11IivHrSG/5qvMJJnz4Fso/FVE8kGObQofT
 ormpAwfoj8UbyOkOYzTurzZ/ibTukPE2Rg8m9ktRpWJESibruushLGpiCrnG5UUl6Ks+ctTw5AU
 4HY=
X-Received: by 2002:a05:600c:1d26:b0:49c:cbf4:572b with SMTP id
 5b1f17b1804b1-49cf8245fe1mr47845035e9.2.1788527372234; 
 Fri, 04 Sep 2026 06:09:32 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B871500CB6EF488A18F9C42.dsl.pool.telekom.hu.
 [2001:4c4e:1b87:1500:cb6e:f488:a18f:9c42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce554d52esm135575435e9.3.2026.09.04.06.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:09:31 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 5/7] accel/rocket: add devfreq support
Date: Fri,  4 Sep 2026 15:08:56 +0200
Message-ID: <20260904130858.27803-6-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904130858.27803-1-royalnet026@gmail.com>
References: <20260904130858.27803-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The NPU has run at whatever rate the devicetree pinned it to since the
driver was merged, which on the RK3588 is 200 MHz. The hardware reaches
1 GHz, and the firmware will change the rate on request, so let devfreq
drive it from how busy the cores actually are.

One devfreq device drives all of the cores, because they have one clock and
one supply between them and cannot be scaled apart. It hangs off the core
that carries the OPP table in the devicetree, found by looking for the
property rather than by taking core 0: the core index is handed out in
probe order, which is not the order the cores are written in.

The awkward part is that the clock is generated by a PVTPLL that sits
inside the NPU power islands. An island powered up while the clock is above
the rate the bootloader left never acknowledges the power-on, and the first
register access into it afterwards takes an asynchronous SError. So before
the rate goes up, every core is runtime resumed, and the references are
held for as long as the clock stays raised. While they are held no core can
suspend, so no island can transition at all. That is what makes a raised
clock safe rather than merely unlikely to be caught out, and it is why the
guard and the thing it guards arrive in the same commit: no commit in the
tree ever raises the rate without it.

The cost is that a boosted NPU does not power-gate individual cores. It is
paid only above the boot rate; at the boot rate the references are dropped
and runtime PM behaves as before. What that costs in milliwatts has not
been measured on this board, and I would rather say so than guess. A
measurement, or a design that does not need the references at all, would
both be welcome.

Utilisation is aggregated as the maximum over the cores, not the sum. The
rate has to satisfy the busiest core, and summing would report one
saturated core out of three as a third of the load and clock down
underneath it. Whether that is the right aggregation for a shared clock is
a fair question for review.

The driver does not call devfreq_suspend_device() and
devfreq_resume_device() itself, which is a deviation from panfrost,
panthor, lima and msm. It ends in cancel_delayed_work_sync() on the
governor's own worker, and that worker is what calls back into ->target(),
which resumes every core; from a runtime-suspend callback that waits for a
worker that is waiting for the same callback to finish. An active-core
count narrows the window but does not close it. In its place, ->target()
returns early when the rate is unchanged, so a governor tick on an idle
NPU costs one comparison and resumes nothing.

System suspend is a different matter, and there the call does happen:
dpm_suspend() runs devfreq_suspend() over every registered devfreq before
it walks the devices, from a path that holds none of this driver's locks.
What the driver adds is lowering the rate and dropping the references from
every core's ->suspend, not only the one that owns the devfreq device.
pm_runtime_force_suspend() powers a core down whatever the usage count
says, and the owning core is suspended last, so a suspend that aborts
partway would otherwise leave the clock raised over islands that are
already gated.

The clock and the supply are claimed in one dev_pm_opp_set_config() call
before the table is added. Naming the clock there is not optional: with
no name the OPP core takes the first clock in the node, which is the bus
clock, and would scale that instead of the compute clock. Configuration
and table are set up on the core that carries them in the devicetree,
which is not the device being probed at the time, so none of it can be
devres: the call hands back a token, and rocket_devfreq_fini() releases
it, and the table, by hand. Leaving it to devres would make a later bind
fail on an OPP table the previous teardown never emptied.

The rate is changed through dev_pm_opp_set_rate(), so that the supply moves
with it, which also means nothing may set the rate behind the OPP core's
back: it caches the OPP it last applied and skips a repeat request for it,
so a raw clk_set_rate() would turn the next request for a raised rate into
a silent no-op with sysfs reporting a rate the hardware was not running.
The boot-rate restore added in the previous patch is converted accordingly.

->get_cur_freq() and the status callback report the rate this driver last
programmed rather than asking the clock. devfreq queries them from sysfs
with no runtime PM reference of its own, and the answer has to be a rate
from the OPP table or devfreq_get_freq_level() will not find it and every
transition is logged as unknown.

A devicetree with no OPP table is not an error: the driver returns without
a devfreq device and the NPU keeps its boot rate, as before this patch.

The governor thresholds are a starting point taken from the other
accelerators in tree, not a measurement. Inference workloads have not been
profiled against them.

Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Assisted-by: LLM sparse checkpatch
---
 drivers/accel/rocket/Kconfig          |   2 +
 drivers/accel/rocket/Makefile         |   1 +
 drivers/accel/rocket/rocket_core.h    |  11 +
 drivers/accel/rocket/rocket_devfreq.c | 458 ++++++++++++++++++++++++++
 drivers/accel/rocket/rocket_devfreq.h |  55 ++++
 drivers/accel/rocket/rocket_device.h  |   3 +
 drivers/accel/rocket/rocket_drv.c     |  80 ++++-
 drivers/accel/rocket/rocket_job.c     |   7 +
 8 files changed, 605 insertions(+), 12 deletions(-)
 create mode 100644 drivers/accel/rocket/rocket_devfreq.c
 create mode 100644 drivers/accel/rocket/rocket_devfreq.h

diff --git a/drivers/accel/rocket/Kconfig b/drivers/accel/rocket/Kconfig
index 16465abe06607..00ee845c871fa 100644
--- a/drivers/accel/rocket/Kconfig
+++ b/drivers/accel/rocket/Kconfig
@@ -8,6 +8,8 @@ config DRM_ACCEL_ROCKET
 	depends on MMU
 	select DRM_SCHED
 	select DRM_GEM_SHMEM_HELPER
+	select PM_DEVFREQ
+	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	help
 	  Choose this option if you have a Rockchip SoC that contains a
 	  compatible Neural Processing Unit (NPU), such as the RK3588. Called by
diff --git a/drivers/accel/rocket/Makefile b/drivers/accel/rocket/Makefile
index 3713dfe223d6e..e0944b3e68121 100644
--- a/drivers/accel/rocket/Makefile
+++ b/drivers/accel/rocket/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_DRM_ACCEL_ROCKET) := rocket.o
 rocket-y := \
 	rocket_core.o \
 	rocket_device.o \
+	rocket_devfreq.o \
 	rocket_drv.o \
 	rocket_gem.o \
 	rocket_job.o
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index f6d7382854ca9..7ada497571bf9 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -7,6 +7,7 @@
 #include <drm/gpu_scheduler.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/ktime.h>
 #include <linux/mutex_types.h>
 #include <linux/reset.h>
 
@@ -55,6 +56,16 @@ struct rocket_core {
 	struct drm_gpu_scheduler sched;
 	u64 fence_context;
 	u64 emit_seqno;
+
+	/*
+	 * Utilisation seen by devfreq, guarded by rdev->devfreq.busy_lock. A
+	 * core runs one task at a time, so a flag is exact here and, unlike a
+	 * counter, cannot be left skewed by a job the reset path tore down.
+	 */
+	bool busy;
+	ktime_t busy_time;
+	ktime_t idle_time;
+	ktime_t time_last_update;
 };
 
 int rocket_core_init(struct rocket_core *core);
diff --git a/drivers/accel/rocket/rocket_devfreq.c b/drivers/accel/rocket/rocket_devfreq.c
new file mode 100644
index 0000000000000..9d923a0b6ea30
--- /dev/null
+++ b/drivers/accel/rocket/rocket_devfreq.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright 2025 Igor Paunovic <royalnet026@gmail.com> */
+
+#include <linux/clk.h>
+#include <linux/devfreq.h>
+#include <linux/ktime.h>
+#include <linux/minmax.h>
+#include <linux/of.h>
+#include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
+
+#include "rocket_core.h"
+#include "rocket_device.h"
+#include "rocket_devfreq.h"
+
+/*
+ * One clock and one supply feed all of the NPU cores, so a single devfreq
+ * device drives them together. It hangs off the core that carries the OPP
+ * table in the devicetree.
+ *
+ * The awkward part is that the clock is generated by a PVTPLL that sits
+ * inside the NPU power islands. An island that is powered up while the clock
+ * is above the rate the bootloader left never acknowledges the power-on, and
+ * the first register access into it afterwards takes an asynchronous SError.
+ *
+ * Lowering the rate is fine at any time, because the firmware serves the boot
+ * rate from GPLL and only writes CRU clock selectors on the way there. Raising
+ * it is not, so before the rate goes up every core is runtime resumed and the
+ * references are kept for as long as the clock stays raised. While they are
+ * held no core can suspend, so no island can transition at all, which is the
+ * property that makes the raised clock safe rather than merely unlikely to be
+ * caught out.
+ *
+ * The cost is that a busy NPU does not power-gate individual cores. It is
+ * paid only above the boot rate: at the boot rate the references are dropped
+ * and runtime PM behaves exactly as it did before this file existed. The cost
+ * in milliwatts has not been measured on this board, and a measurement or a
+ * better idea would both be welcome.
+ */
+
+static void rocket_devfreq_update_utilisation(struct rocket_core *core)
+{
+	ktime_t now = ktime_get();
+	ktime_t elapsed = ktime_sub(now, core->time_last_update);
+
+	if (core->busy)
+		core->busy_time = ktime_add(core->busy_time, elapsed);
+	else
+		core->idle_time = ktime_add(core->idle_time, elapsed);
+
+	core->time_last_update = now;
+}
+
+static int rocket_devfreq_hold_all(struct rocket_device *rdev)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < rdev->num_cores; i++) {
+		ret = pm_runtime_resume_and_get(rdev->cores[i].dev);
+		if (ret < 0) {
+			while (i--)
+				pm_runtime_put_autosuspend(rdev->cores[i].dev);
+
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void rocket_devfreq_release_all(struct rocket_device *rdev)
+{
+	unsigned int i;
+
+	for (i = 0; i < rdev->num_cores; i++)
+		pm_runtime_put_autosuspend(rdev->cores[i].dev);
+}
+
+/* Caller holds rdev->devfreq.lock. */
+static int rocket_devfreq_set_rate(struct rocket_device *rdev, unsigned long freq)
+{
+	struct rocket_devfreq *rdevfreq = &rdev->devfreq;
+	struct device *dev = rdevfreq->owner->dev;
+	int ret;
+
+	ret = dev_pm_opp_set_rate(dev, freq);
+	if (ret) {
+		dev_err(dev, "failed to set the NPU rate to %lu Hz: %d\n", freq, ret);
+		return ret;
+	}
+
+	WRITE_ONCE(rdevfreq->cur_freq, freq);
+
+	return 0;
+}
+
+static int rocket_devfreq_target(struct device *dev, unsigned long *freq, u32 flags)
+{
+	struct rocket_device *rdev = dev_get_drvdata(dev);
+	struct rocket_devfreq *rdevfreq = &rdev->devfreq;
+	struct dev_pm_opp *opp;
+	int ret;
+
+	opp = devfreq_recommended_opp(dev, freq, flags);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+	dev_pm_opp_put(opp);
+
+	guard(mutex)(&rdevfreq->lock);
+
+	/*
+	 * The governor calls this on every tick, including the ticks where it
+	 * arrives at the rate the NPU is already running. Without this an idle
+	 * NPU would resume all of its cores ten times a second to set the rate
+	 * they already have.
+	 */
+	if (*freq == READ_ONCE(rdevfreq->cur_freq))
+		return 0;
+
+	if (!rdevfreq->cores_held) {
+		ret = rocket_devfreq_hold_all(rdev);
+		if (ret) {
+			/*
+			 * Runtime PM is disabled on the way into system
+			 * suspend, so this is the ordinary way for a governor
+			 * tick that raced with it to end.
+			 */
+			dev_dbg(dev, "cannot resume the NPU cores to change rate: %d\n", ret);
+			return ret;
+		}
+		rdevfreq->cores_held = true;
+	}
+
+	ret = rocket_devfreq_set_rate(rdev, *freq);
+
+	/* At the boot rate the cores are free to suspend again. */
+	if (READ_ONCE(rdevfreq->cur_freq) <= rdev->npu_boot_rate) {
+		rdevfreq->cores_held = false;
+		rocket_devfreq_release_all(rdev);
+	}
+
+	return ret;
+}
+
+static int rocket_devfreq_get_dev_status(struct device *dev,
+					 struct devfreq_dev_status *status)
+{
+	struct rocket_device *rdev = dev_get_drvdata(dev);
+	ktime_t busy = 0, total = 0;
+	unsigned int i;
+
+	scoped_guard(spinlock_irqsave, &rdev->devfreq.busy_lock) {
+		for (i = 0; i < rdev->num_cores; i++) {
+			struct rocket_core *core = &rdev->cores[i];
+
+			rocket_devfreq_update_utilisation(core);
+
+			/*
+			 * The cores share the clock, so what the rate has to
+			 * satisfy is the busiest of them. Adding the cores up
+			 * instead would report one saturated core out of three
+			 * as a third of the load, and clock down underneath it.
+			 */
+			busy = max(busy, core->busy_time);
+			total = max(total, ktime_add(core->busy_time, core->idle_time));
+
+			core->busy_time = 0;
+			core->idle_time = 0;
+		}
+	}
+
+	status->busy_time = ktime_to_ns(busy);
+	status->total_time = ktime_to_ns(total);
+	status->current_frequency = READ_ONCE(rdev->devfreq.cur_freq);
+
+	dev_dbg(dev, "busy %lu total %lu %lu%% freq %lu MHz\n",
+		status->busy_time, status->total_time,
+		status->busy_time * 100 / MAX(status->total_time, 1),
+		status->current_frequency / 1000 / 1000);
+
+	return 0;
+}
+
+/*
+ * Report what this driver last programmed, not what the firmware says. devfreq
+ * asks for the current frequency from sysfs as well, without a runtime PM
+ * reference of its own, and the answer has to be one of the rates in the OPP
+ * table or devfreq_get_freq_level() will not find it and every transition will
+ * be logged as unknown.
+ */
+static int rocket_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
+{
+	struct rocket_device *rdev = dev_get_drvdata(dev);
+
+	*freq = READ_ONCE(rdev->devfreq.cur_freq);
+
+	return 0;
+}
+
+static struct devfreq_dev_profile rocket_devfreq_profile = {
+	.timer = DEVFREQ_TIMER_DELAYED,
+	.polling_ms = 50,
+	.target = rocket_devfreq_target,
+	.get_dev_status = rocket_devfreq_get_dev_status,
+	.get_cur_freq = rocket_devfreq_get_cur_freq,
+};
+
+void rocket_devfreq_record_busy(struct rocket_core *core)
+{
+	struct rocket_devfreq *rdevfreq = &core->rdev->devfreq;
+
+	if (!rdevfreq->devfreq)
+		return;
+
+	scoped_guard(spinlock_irqsave, &rdevfreq->busy_lock) {
+		rocket_devfreq_update_utilisation(core);
+		core->busy = true;
+	}
+}
+
+/*
+ * Idempotent on purpose: a job that times out is torn down by the reset path,
+ * which cannot know whether the completion interrupt got there first.
+ */
+void rocket_devfreq_record_idle(struct rocket_core *core)
+{
+	struct rocket_devfreq *rdevfreq = &core->rdev->devfreq;
+
+	if (!rdevfreq->devfreq)
+		return;
+
+	scoped_guard(spinlock_irqsave, &rdevfreq->busy_lock) {
+		rocket_devfreq_update_utilisation(core);
+		core->busy = false;
+	}
+}
+
+/*
+ * Put the clock back to the boot rate through the OPP core. Called with no
+ * lock held, from the last core on its way down.
+ */
+int rocket_devfreq_set_boot_rate(struct rocket_device *rdev)
+{
+	struct rocket_devfreq *rdevfreq = &rdev->devfreq;
+	int ret;
+
+	ret = dev_pm_opp_set_rate(rdevfreq->owner->dev, rdev->npu_boot_rate);
+	if (!ret)
+		WRITE_ONCE(rdevfreq->cur_freq, rdev->npu_boot_rate);
+
+	return ret;
+}
+
+/*
+ * System suspend, called from every core's ->suspend before it is forced down.
+ * The first one to get here does the work and the rest are no-ops.
+ *
+ * It has to be every core and not just the one that owns the devfreq device.
+ * That core is suspended last, and a suspend that aborts partway - a pending
+ * wakeup, or this driver's own -EBUSY on a core that is still busy - would
+ * never reach it, leaving the clock raised over already gated islands.
+ *
+ * No governor tick can be in flight here: dpm_suspend() calls devfreq_suspend()
+ * before it walks the devices, which stops the monitor on every registered
+ * devfreq. That is also where this driver does get devfreq_suspend_device() -
+ * from the PM core, on a path that holds no runtime PM lock of ours.
+ */
+void rocket_devfreq_suspend(struct rocket_device *rdev)
+{
+	struct rocket_devfreq *rdevfreq = &rdev->devfreq;
+
+	if (!rdevfreq->devfreq)
+		return;
+
+	guard(mutex)(&rdevfreq->lock);
+
+	if (!rdevfreq->cores_held)
+		return;
+
+	rocket_devfreq_set_rate(rdev, rdev->npu_boot_rate);
+	rdevfreq->cores_held = false;
+	rocket_devfreq_release_all(rdev);
+}
+
+int rocket_devfreq_init(struct rocket_device *rdev)
+{
+	static const char * const clk_names[] = { "npu", NULL };
+	static const char * const supplies[] = { "npu", NULL };
+	struct dev_pm_opp_config config = {
+		.clk_names = clk_names,
+		.regulator_names = supplies,
+	};
+	struct rocket_devfreq *rdevfreq = &rdev->devfreq;
+	struct rocket_core *owner = NULL;
+	struct dev_pm_opp *opp;
+	struct device *dev;
+	unsigned long freq;
+	unsigned int i;
+	int ret;
+
+	/*
+	 * Find the core the OPP table is attached to. This has to come from
+	 * the devicetree and not from core->index, because the index is handed
+	 * out in probe order, which is not the order the cores are written in.
+	 */
+	for (i = 0; i < rdev->num_cores; i++) {
+		if (of_property_present(rdev->cores[i].dev->of_node,
+					"operating-points-v2")) {
+			owner = &rdev->cores[i];
+			break;
+		}
+	}
+
+	/*
+	 * No OPP table is not an error. It asks for the NPU to stay at the
+	 * rate it booted at, which is what this driver did before devfreq.
+	 */
+	if (!owner)
+		return 0;
+
+	dev = owner->dev;
+
+	/*
+	 * None of this can be devres. It is attached to the core that carries
+	 * the OPP table, while the device being probed right now is whichever
+	 * core happened to bind last, so devres would outlive the teardown in
+	 * rocket_devfreq_fini() and a later rebind would find the OPP table
+	 * still populated.
+	 *
+	 * Naming the clock matters as much as claiming the supply: without it
+	 * the OPP core takes the first clock in the node, which is the bus
+	 * clock, and would scale that instead of the compute clock.
+	 */
+	ret = dev_pm_opp_set_config(dev, &config);
+	if (ret < 0) {
+		if (ret != -ENODEV)
+			return dev_err_probe(dev, ret,
+					     "failed to set the OPP clock and supply\n");
+
+		dev_info(dev, "no NPU supply described, leaving the clock alone\n");
+		return 0;
+	}
+	rdevfreq->opp_token = ret;
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret) {
+		if (ret != -ENODEV)
+			dev_err_probe(dev, ret, "failed to add the OPP table\n");
+		else
+			ret = 0;
+
+		goto err_clear_config;
+	}
+
+	mutex_init(&rdevfreq->lock);
+	spin_lock_init(&rdevfreq->busy_lock);
+
+	for (i = 0; i < rdev->num_cores; i++)
+		rdev->cores[i].time_last_update = ktime_get();
+
+	freq = rdev->npu_boot_rate;
+	opp = devfreq_recommended_opp(dev, &freq, 0);
+	if (IS_ERR(opp)) {
+		ret = dev_err_probe(dev, PTR_ERR(opp),
+				    "no OPP covers the %lu Hz boot rate\n",
+				    rdev->npu_boot_rate);
+		goto err_remove_table;
+	}
+
+	/*
+	 * Program the supply for the rate the NPU is already running, so that
+	 * the regulator is not switched off underneath it by
+	 * regulator_late_cleanup().
+	 */
+	ret = dev_pm_opp_set_opp(dev, opp);
+	dev_pm_opp_put(opp);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to set the initial OPP\n");
+		goto err_remove_table;
+	}
+
+	rdevfreq->cur_freq = freq;
+	rdevfreq->owner = owner;
+	rocket_devfreq_profile.initial_freq = freq;
+
+	/*
+	 * A starting point taken from the other accelerators in tree, not a
+	 * measurement: inference workloads have not been profiled against
+	 * these thresholds.
+	 */
+	rdevfreq->gov_data.upthreshold = 50;
+	rdevfreq->gov_data.downdifferential = 10;
+
+	rdevfreq->devfreq = devfreq_add_device(dev, &rocket_devfreq_profile,
+					       DEVFREQ_GOV_SIMPLE_ONDEMAND,
+					       &rdevfreq->gov_data);
+	if (IS_ERR(rdevfreq->devfreq)) {
+		ret = PTR_ERR(rdevfreq->devfreq);
+		rdevfreq->devfreq = NULL;
+		rdevfreq->owner = NULL;
+
+		dev_err_probe(dev, ret, "failed to add the devfreq device\n");
+		goto err_remove_table;
+	}
+
+	return 0;
+
+err_remove_table:
+	mutex_destroy(&rdevfreq->lock);
+	dev_pm_opp_of_remove_table(dev);
+err_clear_config:
+	dev_pm_opp_clear_config(rdevfreq->opp_token);
+	rdevfreq->opp_token = 0;
+
+	return ret;
+}
+
+void rocket_devfreq_fini(struct rocket_device *rdev)
+{
+	struct rocket_devfreq *rdevfreq = &rdev->devfreq;
+	struct device *dev;
+
+	if (!rdevfreq->devfreq)
+		return;
+
+	dev = rdevfreq->owner->dev;
+
+	devfreq_remove_device(rdevfreq->devfreq);
+	rdevfreq->devfreq = NULL;
+
+	/*
+	 * Lower the clock before letting go of the cores, not after: a core
+	 * that suspends while the clock is still raised would be unable to
+	 * come back.
+	 */
+	scoped_guard(mutex, &rdevfreq->lock) {
+		if (rdevfreq->cores_held) {
+			rocket_devfreq_set_rate(rdev, rdev->npu_boot_rate);
+			rdevfreq->cores_held = false;
+			rocket_devfreq_release_all(rdev);
+		}
+	}
+
+	/*
+	 * Undo the OPP setup by hand, in the reverse order. Everything above
+	 * lives on the owning core rather than on the device that was probing
+	 * when it was set up, so nothing here is released by devres; leaving
+	 * the table populated would make the next bind fail with the OPP core
+	 * complaining that it is not empty. After this the owner is gone, so
+	 * anything that still wants the boot rate asks the clock directly.
+	 */
+	rdevfreq->owner = NULL;
+	mutex_destroy(&rdevfreq->lock);
+	dev_pm_opp_of_remove_table(dev);
+	dev_pm_opp_clear_config(rdevfreq->opp_token);
+	rdevfreq->opp_token = 0;
+}
diff --git a/drivers/accel/rocket/rocket_devfreq.h b/drivers/accel/rocket/rocket_devfreq.h
new file mode 100644
index 0000000000000..bdf8e89ed3761
--- /dev/null
+++ b/drivers/accel/rocket/rocket_devfreq.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2025 Igor Paunovic <royalnet026@gmail.com> */
+
+#ifndef __ROCKET_DEVFREQ_H__
+#define __ROCKET_DEVFREQ_H__
+
+#include <linux/devfreq.h>
+#include <linux/mutex_types.h>
+#include <linux/spinlock_types.h>
+
+struct rocket_core;
+struct rocket_device;
+
+struct rocket_devfreq {
+	struct devfreq *devfreq;
+	struct devfreq_simple_ondemand_data gov_data;
+
+	/*
+	 * The core the OPP table is attached to, and so the one the devfreq
+	 * device hangs off. NULL when the devicetree describes no OPP table.
+	 */
+	struct rocket_core *owner;
+
+	/*
+	 * The OPP clock and supply configuration is attached to the owning
+	 * core, which is not the device this driver is probing when it is set
+	 * up, so it cannot be devres. Zero means nothing is attached.
+	 */
+	int opp_token;
+
+	/*
+	 * Serialises rate changes against each other and against the set of
+	 * runtime PM references taken below.
+	 *
+	 * This is never taken from a runtime PM callback. A rate change
+	 * resumes every core while holding it, so a core that took it on its
+	 * way down would wait for a rate change that is waiting for that same
+	 * core to finish suspending.
+	 */
+	struct mutex lock;
+	unsigned long cur_freq;
+	bool cores_held;
+
+	/* Guards the utilisation fields of every core. */
+	spinlock_t busy_lock;
+};
+
+int rocket_devfreq_init(struct rocket_device *rdev);
+void rocket_devfreq_fini(struct rocket_device *rdev);
+void rocket_devfreq_suspend(struct rocket_device *rdev);
+int rocket_devfreq_set_boot_rate(struct rocket_device *rdev);
+void rocket_devfreq_record_busy(struct rocket_core *core);
+void rocket_devfreq_record_idle(struct rocket_core *core);
+
+#endif /* __ROCKET_DEVFREQ_H__ */
diff --git a/drivers/accel/rocket/rocket_device.h b/drivers/accel/rocket/rocket_device.h
index 466ebc4c26a8a..979ef4685443f 100644
--- a/drivers/accel/rocket/rocket_device.h
+++ b/drivers/accel/rocket/rocket_device.h
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 
 #include "rocket_core.h"
+#include "rocket_devfreq.h"
 
 struct rocket_device {
 	struct drm_device ddev;
@@ -30,6 +31,8 @@ struct rocket_device {
 	struct clk *npu_clk;
 	unsigned long npu_boot_rate;
 	atomic_t active_cores;
+
+	struct rocket_devfreq devfreq;
 };
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index b7199de57ccc7..779e1cb48c241 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -14,6 +14,7 @@
 #include <linux/pm_runtime.h>
 
 #include "rocket_device.h"
+#include "rocket_devfreq.h"
 #include "rocket_drv.h"
 #include "rocket_gem.h"
 #include "rocket_job.h"
@@ -181,15 +182,33 @@ static int rocket_probe(struct platform_device *pdev)
 	rdev->num_cores++;
 
 	ret = rocket_core_init(&rdev->cores[core]);
-	if (ret) {
-		rdev->num_cores--;
-
-		if (rdev->num_cores == 0) {
-			rocket_device_fini(rdev);
-			rdev = NULL;
+	if (ret)
+		goto err_core;
+
+	/*
+	 * Every core described in the devicetree has to be bound before the
+	 * devfreq device goes up. A rate change resumes all of them and keeps
+	 * them resumed, and a core that had not probed yet would come up later
+	 * underneath a raised clock.
+	 */
+	if (rdev->num_cores == rdev->max_cores) {
+		ret = rocket_devfreq_init(rdev);
+		if (ret) {
+			rocket_core_fini(&rdev->cores[core]);
+			goto err_core;
 		}
 	}
 
+	return 0;
+
+err_core:
+	rdev->num_cores--;
+
+	if (rdev->num_cores == 0) {
+		rocket_device_fini(rdev);
+		rdev = NULL;
+	}
+
 	return ret;
 }
 
@@ -203,6 +222,9 @@ static void rocket_remove(struct platform_device *pdev)
 	if (core < 0)
 		return;
 
+	/* The devfreq device drives every core, so it goes before any of them. */
+	rocket_devfreq_fini(rdev);
+
 	rocket_core_fini(&rdev->cores[core]);
 	rdev->num_cores--;
 
@@ -246,7 +268,18 @@ static void rocket_npu_restore_boot_rate(struct rocket_device *rdev)
 	if (!rdev->npu_clk)
 		return;
 
-	err = clk_set_rate(rdev->npu_clk, rdev->npu_boot_rate);
+	/*
+	 * Go through the OPP core once there is a table, never behind its
+	 * back: it caches the OPP it last applied and skips a request for that
+	 * same OPP, so a raw clk_set_rate() here would make the next request
+	 * for the raised rate a silent no-op, with sysfs reporting a rate the
+	 * hardware was not running.
+	 */
+	if (rdev->devfreq.owner)
+		err = rocket_devfreq_set_boot_rate(rdev);
+	else
+		err = clk_set_rate(rdev->npu_clk, rdev->npu_boot_rate);
+
 	if (err)
 		dev_warn(rdev->cores[0].dev,
 			 "failed to restore the NPU boot rate of %lu Hz: %d\n",
@@ -292,21 +325,44 @@ static int rocket_device_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+static int rocket_device_suspend(struct device *dev)
+{
+	struct rocket_device *rdev = dev_get_drvdata(dev);
+
+	/*
+	 * pm_runtime_force_suspend() below powers this core down whatever the
+	 * runtime PM usage count says, so the references taken while the clock
+	 * is raised do not hold it off. Put the rate back first; the call is a
+	 * no-op on every core after the first.
+	 */
+	rocket_devfreq_suspend(rdev);
+
+	return pm_runtime_force_suspend(dev);
+}
+
 EXPORT_GPL_DEV_PM_OPS(rocket_pm_ops) = {
 	RUNTIME_PM_OPS(rocket_device_runtime_suspend, rocket_device_runtime_resume, NULL)
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SYSTEM_SLEEP_PM_OPS(rocket_device_suspend, pm_runtime_force_resume)
 };
 
 /*
- * A kexec or a reboot hands the next kernel whatever rate is set here, and
- * that kernel will power the islands up before it looks at the clock.
+ * A kexec or a reboot hands the next kernel whatever rate is set here, and that
+ * kernel will power the islands up before it looks at the clock.
+ *
+ * Take the devfreq device down before restoring the rate rather than after.
+ * Nothing freezes workqueues on this path, so a governor tick that landed
+ * after the restore would raise the clock straight back up and hand on exactly
+ * what this is here to prevent.
  */
 static void rocket_shutdown(struct platform_device *pdev)
 {
 	struct rocket_device *rdev = dev_get_drvdata(&pdev->dev);
 
-	if (rdev)
-		rocket_npu_restore_boot_rate(rdev);
+	if (!rdev)
+		return;
+
+	rocket_devfreq_fini(rdev);
+	rocket_npu_restore_boot_rate(rdev);
 }
 
 static struct platform_driver rocket_driver = {
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 3141f210fcd1b..2ba03d85b598e 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -15,6 +15,7 @@
 
 #include "rocket_core.h"
 #include "rocket_device.h"
+#include "rocket_devfreq.h"
 #include "rocket_drv.h"
 #include "rocket_job.h"
 #include "rocket_registers.h"
@@ -151,6 +152,8 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
 
 	rocket_pc_writel(core, OPERATION_ENABLE, PC_OPERATION_ENABLE_OP_EN(1));
 
+	rocket_devfreq_record_busy(core);
+
 	dev_dbg(core->dev, "Submitted regcmd at 0x%llx to core %d", task->regcmd, core->index);
 }
 
@@ -348,6 +351,8 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
 	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
+	rocket_devfreq_record_idle(core);
+
 	scoped_guard(mutex, &core->job_lock)
 		if (core->in_flight_job) {
 			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
@@ -379,6 +384,8 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 		if (core->in_flight_job)
 			pm_runtime_put_noidle(core->dev);
 
+		rocket_devfreq_record_idle(core);
+
 		iommu_detach_group(NULL, core->iommu_group);
 
 		core->in_flight_job = NULL;
-- 
2.43.0

