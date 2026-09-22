Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F63CC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CFB10E654;
	Tue, 22 Sep 2026 08:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PNDLNXji";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F84E10E61F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:01:40 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6baf77afso1695625e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790064098; x=1790668898; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I32qcJErlvaRW+Ft0guC5hzjNkhNg6mkhTsESIhHnNQ=;
 b=PNDLNXjiaXVWNgJbNSkopbJTvGIvIAJN+Gnu8FZgPnEdPVldguGORQFvtzBk99d8aT
 H7D1/axC0DRJnn2PDqSszZCpkksd0kU6OzaQEFcolGOtQiX5nN7trQFFGARB6JFS5bHH
 ilJWSHyqxzBWrUmfMfJT0ZmTeNQMwnvLj3eVArgyV7LAL52mPj6VuBqQPSWv7k7cpyU2
 eOTUi1HhK9zv3crfnCqXzmr7XNNIbPlTvOOct4jWhsdQsP/ngcFvCBIIS49v03PPE14p
 T956MarGmp4L0HmFJgCeVCfuFVrJsU/RDKBmyVjkjMtQNrxIwsZvbaRGmOUREKVuSihw
 eoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064098; x=1790668898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I32qcJErlvaRW+Ft0guC5hzjNkhNg6mkhTsESIhHnNQ=;
 b=crjod8xZhwDiicYEkTYcvwu4/FdiILfTumllzc85vcm1GZqlw6pw3S287Ot7QfkD17
 NxYISlzsNxrqxiDDauhjdTRVaiVVjguh43Ru4h6MhGM+PlVSc5CptBCrUh8soafwm1Rk
 5kVVJTwxp54BiiTw/T9dL8HotlcHh0jh9Xm62aK9X0ug/dvsJrP9YwP8z9wtSuID6TXp
 Vu1Ftl59GNQColq6sYXlDQ0zry6VTegtjI8nxN4THasbBW4nacF5LDkBzwMugZhD29Wn
 MiSh4R/8obmMIQYJmD5Zb9GXsgZOMs0H8cVgcdWBKQpBY/OUVJGCBNJnNelErsTr6Odp
 otVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNGMcW3hKdgPV/8rAnz/i2NsgDIuCZrUupvja1DOcPGn/SI5ao6MbDQEfgPla690JlYXFkoPZ0yhA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lYjCFE+olYXp6s/rhozBnnVULJ22gm+jk2an1+UrTrRpKt4tAQ
 SJDdmHvD7e9Z764WG6Eaq8EuNwVHa6XwiQQm827ZJJ2UcGVNLf6SHRdw
X-Gm-Gg: AYBFou2LDiMi5euc/1be4k9XA2ezCWKP/vgsFAzn31NVNsvqfoa1H1fnhlyO8Dn92g+
 zxxTtppeoNyLztfEvkYI/kLjfg0Wrrw4StwhXhnSSJkBIsnbznTo4aQDfD04dDi4JotCAjg4m2O
 DqIiPL/dqCZU6CqGP0yPj1wFhRBm7YRmtbYM4kBBxpkePf71efEqxjbkQWrlsM7AVupoNLRJPCH
 f1zNYCDi7CGCpCE7Icsatj/nOM0TUBUEwJB7iCuOdGqqZlMjTSZ5Oj4Dsv44/Sgx0QfxfV8wYMp
 2SeLlAWLCX6qqPVclrSWJmykHSdK2WfvaMrgUMBfmabzQ/CmrD/9GhZzPI/chOr4EtP2M7cFJ1v
 4dallmjf0ALlu0L+FBA2JNXnLbf5QUqGCrm2GaSqLRceQycos3Vht7WD1bu+BSI62eZ4SmMU1Eu
 ab4r3UGMwcV85tsgpi5DsI7jAfOxklOpxR803kzuDtokN60/17f2vClBGdbPQRGyhnY1J8bXYfZ
 HvYamtDGmggbEWLwCCHHQsStNzosztmO0teE8YBv/zhgol3HyyoDZlDHLWCcPeVOzbA83gdFRp5
 LW0=
X-Received: by 2002:a05:600c:1c13:b0:49e:7186:f36e with SMTP id
 5b1f17b1804b1-49fc7dc1e75mr208981335e9.1.1790064098083; 
 Tue, 22 Sep 2026 01:01:38 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaf97e2sm18248625e9.2.2026.09.22.01.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:01:37 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2 09/11] accel/rocket: add devfreq support
Date: Tue, 22 Sep 2026 10:01:12 +0200
Message-ID: <20260922080114.44662-10-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922080114.44662-1-royalnet026@gmail.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
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
one supply between them and cannot be scaled apart. It hangs off the first
core in devicetree order that carries an OPP table, which on the RK3588,
where all three cores reference the shared table, is rknn_core_0. The
choice has to be fixed rather than "whichever core bound last": the
devfreq device is named after that core, and a cooling map in the
devicetree resolves against that core's node. core->index is the core's
position among the core nodes, so the lowest index is the first node.

The awkward part is that the clock is generated by a PVTPLL that sits
inside the NPU power islands. An island powered up while the clock is above
the rate the bootloader left never acknowledges the power-on, and the first
register access into it afterwards takes an asynchronous SError. So before
the rate goes up, every core is runtime resumed, and the references are
held for as long as the clock stays raised: no island can transition while
they are held, which is what makes a raised clock safe rather than merely
unlikely to be caught out. The guard and the thing it guards arrive in the
same commit, so no commit in the tree ever raises the rate without it.

Unbinding any core takes the devfreq device down, and it comes back
once every core is bound again: a rate change resumes all of them, so
the device has to be whole for the guard to mean anything. Every walk
of the core array here relies on that.

The cost is that a boosted NPU does not power-gate individual cores. It is
paid only above the boot rate; at the boot rate the references are dropped
and runtime PM behaves as before. What that costs in milliwatts has not
been measured on this board. A measurement, or a design that does not need
the references at all, would both be welcome.

Utilisation is aggregated as the maximum over the cores, not the sum: the
rate has to satisfy the busiest core, and summing would report one
saturated core out of three as a third of the load. Whether that is the
right aggregation for a shared clock is a fair question for review.

Unlike panfrost, panthor, lima and msm, the driver does not call
devfreq_suspend_device() from runtime suspend. That call ends in
cancel_delayed_work_sync() on the governor's worker, and the worker is
what calls ->target(), which resumes every core: a runtime-suspend
callback would wait for a worker that is waiting for that same callback.
Instead ->target() returns early when the rate is unchanged, so a
governor tick on an idle NPU costs one comparison and resumes nothing.

System suspend is different: dpm_suspend() runs devfreq_suspend() over
every registered devfreq before it walks the devices, from a path that
holds none of this driver's locks. What the driver adds is lowering the
rate and dropping the references from every core's ->suspend, not only
the owning core's. pm_runtime_force_suspend() powers a core down whatever
the usage count says, and the owning core need not be the first one
suspended, so a suspend that aborts partway would otherwise leave the
clock raised over islands that are already gated.

The clock and the supply are claimed in one dev_pm_opp_set_config() call
before the table is added. Naming the clock there is not optional: with no
name the OPP core takes the first clock in the node, which is the bus
clock. Configuration and table live on the owning core, which need not be
the device being probed at the time, so none of it can be devres: the call
hands back a token, and rocket_devfreq_fini() releases it, and the table,
by hand. Left to devres, a later bind would fail on an OPP table the
previous teardown never emptied.

The rate is changed through dev_pm_opp_set_rate(), so that the supply moves
with it. Nothing may set the rate behind the OPP core's back: it caches
the OPP it last applied and skips a repeat request for it, so a raw
clk_set_rate() would turn the next request for a raised rate into a
silent no-op. The boot-rate restore added in the previous patch is
converted accordingly.

The rate the previous patch reads at probe is the firmware's own number
and need not be in the OPP table: a board that does not pin the clock
with assigned-clock-rates gets whatever the firmware's divider produces.
So the boot rate is normalised to the table once, at init, to the lowest
OPP that is not below it, and everything here compares against and
returns to that OPP. Comparing cur_freq against a rate that is not in the
table would leave the cores held after the first change, with no
governor tick ever able to match it.

->get_cur_freq() and the status callback report the rate this driver last
requested rather than asking the clock: devfreq queries them from sysfs
with no runtime PM reference of its own, and the answer has to be a rate
from the OPP table or devfreq_get_freq_level() does not find it and
devfreq warns on every transition. "Requested" is the accurate word: a
rate the firmware refuses does not come back as an error, because the
clock framework ignores what the clock's set_rate returns. Keeping every
request to the OPP table, which names only the rates the firmware accepts,
keeps a request from being refused; what sysfs shows is still the request,
not a measurement.

A devicetree with no OPP table is not an error: the driver returns without
a devfreq device and the NPU keeps its boot rate, as before this patch.

The governor thresholds are a starting point taken from the other
accelerators in tree, not a measurement. Inference workloads have not been
profiled against them.

Assisted-by: LLM sparse checkpatch
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
v2:
- The devfreq device goes on the first core in devicetree order with an
  OPP table, not on whichever core with the table bound first, as v1
  would have done with the table on all three cores (Nicolas).
- The boot rate is normalised to the OPP table at init. Found by reading
  the code: without assigned-clock-rates the raw rate is not in the table
  and the cores would have stayed held after the first change. Code read
  only so far; a devicetree without the property has not been booted.
- Init holds every core while it programs the initial OPP, since
  rounding the boot rate up to the table may raise the clock.
- "last programmed" is now "last requested", with the reason.
- Comments and text updated for the shared table; a comment that
  counted ten governor ticks a second now counts twenty (50 ms polling).
- The commit message now says that unbinding any core takes the
  devfreq device down until all are bound again; v1 did the same
  without saying so.
- The utilisation counters of a core that was unbound and bound again
  start from zero.
- A comment over hold_all() states the invariant the loops rely on.

 drivers/accel/rocket/Kconfig          |   2 +
 drivers/accel/rocket/Makefile         |   1 +
 drivers/accel/rocket/rocket_core.h    |  11 +
 drivers/accel/rocket/rocket_devfreq.c | 500 ++++++++++++++++++++++++++
 drivers/accel/rocket/rocket_devfreq.h |  65 ++++
 drivers/accel/rocket/rocket_device.h  |   3 +
 drivers/accel/rocket/rocket_drv.c     |  59 ++-
 drivers/accel/rocket/rocket_job.c     |   7 +
 8 files changed, 646 insertions(+), 2 deletions(-)
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
index 46ed8352a79d2..c9995bd9e0553 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -7,6 +7,7 @@
 #include <drm/gpu_scheduler.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/ktime.h>
 #include <linux/mutex_types.h>
 #include <linux/reset.h>
 
@@ -60,6 +61,16 @@ struct rocket_core {
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
index 0000000000000..871fa370eb432
--- /dev/null
+++ b/drivers/accel/rocket/rocket_devfreq.c
@@ -0,0 +1,500 @@
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
+ * device drives them together. It hangs off the first core in devicetree
+ * order that carries an OPP table.
+ *
+ * The awkward part is that the clock is generated by a PVTPLL that sits
+ * inside the NPU power islands. An island that is powered up while the clock
+ * is above the rate the bootloader left never acknowledges the power-on, and
+ * the first register access into it afterwards takes an asynchronous SError.
+ *
+ * Lowering the rate is fine at any time as long as the boot rate is one the
+ * firmware serves from GPLL, which on the RK3588 is the pinned 200 MHz: for
+ * that rate it writes only CRU clock selectors. Raising the rate is not, so
+ * before it goes up every core is runtime resumed and the
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
+/*
+ * The devfreq device exists only while every slot in rdev->cores[] is
+ * filled: it goes up when num_cores reaches max_cores and comes down in
+ * rocket_remove() before the leaving core empties its slot. The loops
+ * over num_cores here and below rely on that.
+ */
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
+	 * NPU would resume all of its cores twenty times a second to set the
+	 * rate they already have.
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
+	if (READ_ONCE(rdevfreq->cur_freq) <= rdevfreq->boot_freq) {
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
+		status->busy_time * 100 / max(status->total_time, 1UL),
+		status->current_frequency / 1000 / 1000);
+
+	return 0;
+}
+
+/*
+ * Report the rate this driver last requested, not what the firmware says.
+ * devfreq asks for the current frequency from sysfs as well, without a runtime
+ * PM reference of its own, and the answer has to be one of the rates in the
+ * OPP table or devfreq_get_freq_level() will not find it and every transition
+ * will be logged as unknown.
+ *
+ * "Requested" is the accurate word: a rate the firmware refuses does not come
+ * back as an error, because the clock framework ignores what the clock's
+ * set_rate returns and the clock stays where it was. Keeping every request to
+ * the OPP table, which names only the rates the firmware accepts, keeps a
+ * request from being refused; what is reported is still the request, not a
+ * measurement.
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
+ * Put the clock back to the boot OPP through the OPP core. Called with no
+ * lock held, from the last core on its way down.
+ */
+int rocket_devfreq_set_boot_rate(struct rocket_device *rdev)
+{
+	struct rocket_devfreq *rdevfreq = &rdev->devfreq;
+	int ret;
+
+	ret = dev_pm_opp_set_rate(rdevfreq->owner->dev, rdevfreq->boot_freq);
+	if (!ret)
+		WRITE_ONCE(rdevfreq->cur_freq, rdevfreq->boot_freq);
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
+	rocket_devfreq_set_rate(rdev, rdevfreq->boot_freq);
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
+	 * The devfreq device hangs off the first core in devicetree order that
+	 * carries an OPP table: on the RK3588 every core references the shared
+	 * table, so that is rknn_core_0. It has to be a fixed choice and not
+	 * whichever core bound last, because the devfreq device is named after
+	 * this core and a cooling map in the devicetree resolves against its
+	 * node. core->index is the core's position among the core nodes, so
+	 * the lowest index is the first node.
+	 */
+	for (i = 0; i < rdev->num_cores; i++) {
+		struct rocket_core *core = &rdev->cores[i];
+
+		if (!of_property_present(core->dev->of_node, "operating-points-v2"))
+			continue;
+
+		if (!owner || core->index < owner->index)
+			owner = core;
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
+	 * None of this can be devres. It is attached to the owning core, while
+	 * the device being probed right now is whichever core happened to bind
+	 * last, so devres would outlive the teardown in rocket_devfreq_fini()
+	 * and a later rebind would find the OPP table still populated.
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
+	for (i = 0; i < rdev->num_cores; i++) {
+		struct rocket_core *core = &rdev->cores[i];
+
+		/* A core that was unbound and bound again starts over. */
+		core->busy = false;
+		core->busy_time = 0;
+		core->idle_time = 0;
+		core->time_last_update = ktime_get();
+	}
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
+	 * From here on the boot rate is the OPP it maps to. The raw rate is
+	 * the firmware's number and need not be in the table at all.
+	 */
+	rdevfreq->boot_freq = freq;
+
+	/*
+	 * Program the supply for the rate the NPU is already running, so that
+	 * the regulator is not switched off underneath it by
+	 * regulator_late_cleanup(). That OPP is the boot rate rounded up to
+	 * the table, so this may raise the clock, and a raised clock is only
+	 * ever programmed with every core held: the same rule as ->target().
+	 */
+	ret = rocket_devfreq_hold_all(rdev);
+	if (ret) {
+		dev_pm_opp_put(opp);
+		dev_err_probe(dev, ret,
+			      "cannot resume the NPU cores to set the initial OPP\n");
+		goto err_remove_table;
+	}
+	ret = dev_pm_opp_set_opp(dev, opp);
+	rocket_devfreq_release_all(rdev);
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
+			rocket_devfreq_set_rate(rdev, rdevfreq->boot_freq);
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
index 0000000000000..65a9de6d37389
--- /dev/null
+++ b/drivers/accel/rocket/rocket_devfreq.h
@@ -0,0 +1,65 @@
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
+	 * The core the devfreq device hangs off: the first in devicetree order
+	 * to carry an OPP table. NULL when no core does.
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
+	/*
+	 * The boot rate as an OPP: the lowest rate in the table that is not
+	 * below rdev->npu_boot_rate. The raw boot rate is whatever the firmware
+	 * reported at probe and need not be in the table, and comparing
+	 * cur_freq against a rate that is not in the table would leave the
+	 * cores held for good after the first change. Everything here compares
+	 * against and returns to this instead.
+	 */
+	unsigned long boot_freq;
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
index ba7c977cd6951..a91d5a9b09ed3 100644
--- a/drivers/accel/rocket/rocket_device.h
+++ b/drivers/accel/rocket/rocket_device.h
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 
 #include "rocket_core.h"
+#include "rocket_devfreq.h"
 
 struct rocket_device {
 	struct drm_device ddev;
@@ -37,6 +38,8 @@ struct rocket_device {
 	 */
 	unsigned long npu_boot_rate;
 	atomic_t active_cores;
+
+	struct rocket_devfreq devfreq;
 };
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8f03de1af488c..c6eab2239b6a9 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -14,6 +14,7 @@
 #include <linux/pm_runtime.h>
 
 #include "rocket_device.h"
+#include "rocket_devfreq.h"
 #include "rocket_drv.h"
 #include "rocket_gem.h"
 #include "rocket_job.h"
@@ -244,6 +245,20 @@ static int rocket_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_core;
 
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
+		}
+	}
+
 	return 0;
 
 err_core:
@@ -268,6 +283,9 @@ static void rocket_remove(struct platform_device *pdev)
 	if (WARN_ON(core < 0))
 		return;
 
+	/* The devfreq device drives every core, so it goes before any of them. */
+	rocket_devfreq_fini(rdev);
+
 	rocket_core_fini(&rdev->cores[core]);
 	rdev->cores[core].dev = NULL;
 	rdev->num_cores--;
@@ -314,7 +332,18 @@ static void rocket_npu_restore_boot_rate(struct rocket_core *core)
 	if (!rdev->npu_boot_rate)
 		return;
 
-	err = clk_set_rate(core->clks[2].clk, rdev->npu_boot_rate);
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
+		err = clk_set_rate(core->clks[2].clk, rdev->npu_boot_rate);
+
 	if (err)
 		dev_warn(core->dev,
 			 "failed to restore the NPU boot rate of %lu Hz: %d\n",
@@ -360,14 +389,38 @@ static int rocket_device_runtime_suspend(struct device *dev)
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
  * A kexec hands the next kernel whatever rate is set here, and that kernel
  * will power the islands up before it looks at the clock.
+ *
+ * Take the devfreq device down before restoring the rate rather than after.
+ * Nothing freezes workqueues on this path, so a governor tick that landed
+ * after the restore would raise the clock straight back up and hand on exactly
+ * what this is here to prevent.
+ *
+ * The hook runs once per core. After the first call the devfreq device is
+ * gone, and each later restore asks the clock for the rate it already has,
+ * which the clock framework drops before it reaches the firmware.
  */
 static void rocket_shutdown(struct platform_device *pdev)
 {
@@ -377,6 +430,8 @@ static void rocket_shutdown(struct platform_device *pdev)
 	if (!rdev)
 		return;
 
+	rocket_devfreq_fini(rdev);
+
 	core = find_core_for_dev(&pdev->dev);
 	if (core >= 0)
 		rocket_npu_restore_boot_rate(&rdev->cores[core]);
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 25ee4ab172a82..7846b627b00f4 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -15,6 +15,7 @@
 
 #include "rocket_core.h"
 #include "rocket_device.h"
+#include "rocket_devfreq.h"
 #include "rocket_drv.h"
 #include "rocket_job.h"
 #include "rocket_registers.h"
@@ -149,6 +150,8 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
 
 	rocket_pc_writel(core, TASK_DMA_BASE_ADDR, PC_TASK_DMA_BASE_ADDR_DMA_BASE_ADDR(0x0));
 
+	rocket_devfreq_record_busy(core);
+
 	rocket_pc_writel(core, OPERATION_ENABLE, PC_OPERATION_ENABLE_OP_EN(1));
 
 	dev_dbg(core->dev, "Submitted regcmd at 0x%llx to core %d", task->regcmd, core->index);
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

