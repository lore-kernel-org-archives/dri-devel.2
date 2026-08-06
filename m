Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0136C5620A
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 08:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7ADF10F14F;
	Thu,  6 Aug 2026 08:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NX0JlZg6";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E70A510E2C4
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 08:52:35 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4954b3c5cbeso1726175e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 01:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786006354; x=1786611154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=khPuyJHv89zY4dZVkmNZIJYQNoyOM1lI8MsDyIAf3TY=;
 b=NX0JlZg6+WW/o7flCbP9xlNvijDNN3Hl+u8NEBvMpYqd7o9TnK+OwFDaRVGf2p9xI1
 tWerrXdzwBV+ECqWTSwwoZqgnGP300WcRumSw2RUEZeoy6hYT0FNsGAapZTrv8sBTAHR
 xiALxMUREjyroRCZXYLSLdSaZA0B3yWE8I14fUSpFcNhN+a2TnObVL5E6E9akRpPZSmx
 h6TOO+KYOzYWl/h9m6aOBzVFPHrSNo6UiyOtTkgobceGfszobUJcZ2JQeDmUanoNChxh
 QtQG1K92XbTQE21xcOnQE21Leb9pnrkAFII6N3yetvSsvTxTBcDqMGeRBtrTGJySs8S7
 I+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786006354; x=1786611154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=khPuyJHv89zY4dZVkmNZIJYQNoyOM1lI8MsDyIAf3TY=;
 b=ob24/PeAAo+R6/+YHCPU0ABHoTc+lCE34Dfr3fQ5afgSMNw7j4O2jMptcHWchc9tbI
 Fauq8rnaZOyOuHGT0A0lnp0wyE7reYQct9IIq8n2MrVcMgNgOzlLTMCED7TqND6AITlr
 7T/0K4x57MmTwAIjbQZ9IUWvVmfG5V78pqf6YJ+f3S7HlUY4/S/sKLxuHlHL4sfsII37
 0F0mNcXxSefEn8+dHn9kE6SX4Hqlfd4lXYSviXq6L88FI064wQyJpbbsimkWN0iBWiXo
 VF5cRFmRPj01COcTTSScB3c2iTrjra6sssA3Xw/jrSPqU6kqr3PTuS4EBMiBx9UHlMKb
 trJA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqmd70HMUVFryJONJgt/yc5wffNTe+TRONFXSMEV9vVPig6fc9CGDKJCxm9qickOrDkDsxW+E26LfI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7dOWkczuKM8M8WEbvNrBixeGY+jiZFsai/9ErhQdGWfULpsHk
 Xrscu/AD5rEWPF60j2xnnQiUg960/80kxBvBx+PIS+eUFT4cAr+tT2ky
X-Gm-Gg: AR+sD13riibluLZdfXqpUPE2tId7/YWQIq26piK8CI8CT8MDJNTPwnT800TDI6xtvGM
 Wbx5oGWYGtr8YGfaUaSYspWcm7H52SsTq/fQjyOd21mhv/SqpbqIgCQsYTnh/cxXXv+E3twYeOe
 yHM52s+Hg5/s/9oJ0+nfHWkGaZC7oiwIWXODu1xXKyztNDzD2UQXZhSWYJl+qPg7n9mdAC1rBZg
 ARrLQYNQTZ+je5gmFJIrOX6huGsOXcj60vlIggGyZ/QXUsjZQmzPg4S5G7M8mirGZzvuNxI0HzV
 4md2ICoKYudO+YqzVq9Gi4U3oj321z3rsnhZDSHoG5iP2uYq+CflQ0JxdTEssqh+3ienMNskaX6
 3HOIYaB1rzcTYocioNGiMYfakfrNuiGOYBDy6BdOHDJ5T02V0ZzzdoiZuosJG14fca4zW50WxCR
 FZX4AzmAQYzCHcfaDSHy4v2XkwHblBkj91E/vHi6y13ZC8przezPOJS1pIOO5CbEnFJgCWp2eji
 4GXSLyn4clwarwmNquxEcLvpqUGQR9ma0y9OMWJZxSwzcT1NDkdqB8=
X-Received: by 2002:a05:600c:c8c:b0:495:7561:a9cc with SMTP id
 5b1f17b1804b1-4994e7d5c76mr84278115e9.4.1786006353850; 
 Thu, 06 Aug 2026 01:52:33 -0700 (PDT)
Received: from Neo.taile6b6ba.ts.net
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995420cb4esm45985355e9.2.2026.08.06.01.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 01:52:33 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/nouveau/fifo: add recovery path for Tesla
 cache_error/dma_pusher
Date: Thu,  6 Aug 2026 10:52:28 +0200
Message-ID: <20260806085228.1848994-4-mczernohous@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806085228.1848994-1-mczernohous@gmail.com>
References: <20260806085228.1848994-1-mczernohous@gmail.com>
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

From: Marek Czernohous <marek@czernohous.de>

On Tesla / NV50 family chipsets (nv50, g84, g94, g98, mcp77, mcp79), FIFO
fault handling in nv04_fifo_intr_cache_error() and
nv04_fifo_intr_dma_pusher() logs the fault and resets hardware registers
but leaves the offending channel running. Compared to Fermi and newer,
which call nvkm_chan_error() from nvkm_runl_rc(), Tesla has no
escalation at all: repeated faults on the same channel keep firing
forever and there is no telemetry beyond dmesg.

Add a shared recovery helper, nv04_fifo_recover(), that both interrupt
handlers call after the existing logging and reset sequence. It
implements two tiers:

  Tier-1: kill the channel with nvkm_chan_error(), but only after it has
  faulted NVKM_FIFO_KILL_COUNT times inside NVKM_FIFO_KILL_WINDOW_MS.
  The single PFIFO cache puller names the channel that is *resident*
  when the fault is noticed, not necessarily the one that caused it (see
  the comment in nv04_fifo_pause() about incorrect instance offsets), so
  one fault is not sufficient evidence to kill. Below the threshold the
  behaviour is unchanged from mainline: the method is skipped or the
  push segment dropped, and the channel resumes.

  Tier-2: after a burst of faults within a sliding window, request a
  device-wide drm_dev_wedged_event() so userspace can rebind the driver.
  Tier-2 is fed by every fault, including those Tier-1 lets pass.

The per-channel streak is keyed on the channel object pointer, which is
used purely as an identity token and never dereferenced. It is dropped
in nvkm_chan_del() so that a channel id handed out again cannot inherit
the streak of its predecessor.

nvkm_chan_error() is called with preempt=false. nv50 and g84 channels
have no .preempt callback, so preempt=true would dereference a NULL
function pointer under chan->lock in interrupt context.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
 .../drm/nouveau/include/nvkm/engine/fifo.h    |  31 +++
 .../include/trace/events/nouveau_fifo.h       |  58 ++++++
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  29 +++
 .../gpu/drm/nouveau/nvkm/engine/fifo/Kbuild   |   1 +
 .../gpu/drm/nouveau/nvkm/engine/fifo/base.c   |   3 +
 .../gpu/drm/nouveau/nvkm/engine/fifo/chan.c   |  14 ++
 .../gpu/drm/nouveau/nvkm/engine/fifo/nv04.c   |   4 +
 .../gpu/drm/nouveau/nvkm/engine/fifo/priv.h   |  10 +
 .../drm/nouveau/nvkm/engine/fifo/recover.c    | 176 ++++++++++++++++++
 9 files changed, 326 insertions(+)
 create mode 100644 drivers/gpu/drm/nouveau/include/trace/events/nouveau_fifo.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/fifo/recover.c

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/engine/fifo.h b/drivers/gpu/drm/nouveau/include/nvkm/engine/fifo.h
index 96c16cfccf16..973c3ee445dc 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/engine/fifo.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/engine/fifo.h
@@ -55,6 +55,36 @@ void nvkm_chan_put(struct nvkm_chan **, unsigned long irqflags);
 
 struct nvkm_chan *nvkm_uchan_chan(struct nvkm_object *);
 
+#define NVKM_FIFO_WEDGE_RING_MAX 32
+
+/*
+ * A channel is only killed once it has faulted NVKM_FIFO_KILL_COUNT times
+ * within NVKM_FIFO_KILL_WINDOW_MS.  The PFIFO cache puller names the channel
+ * that is resident when the fault is noticed, which is not necessarily the one
+ * that caused it, so a single fault is not sufficient evidence to kill.
+ */
+#define NVKM_FIFO_KILL_COUNT 3
+#define NVKM_FIFO_KILL_WINDOW_MS 10000
+#define NVKM_FIFO_KILL_CHID_MAX 128
+
+struct nvkm_fifo_wedge {
+	spinlock_t       lock;
+	u32              count;                          /* faults inside the window */
+	ktime_t          ts[NVKM_FIFO_WEDGE_RING_MAX];  /* ring of fault timestamps */
+	u32              head;                           /* ring head */
+	struct work_struct work;                        /* schedules drm_dev_wedged_event */
+	atomic_t         wedged;                        /* Tier-2 already fired? */
+
+	/* Per-channel fault streak for the Tier-1 escalation.  owner is an
+	 * identity token for the channel object and is never dereferenced.
+	 */
+	struct {
+		void    *owner;
+		ktime_t  first;
+		u32      count;
+	} chfault[NVKM_FIFO_KILL_CHID_MAX];
+};
+
 struct nvkm_fifo {
 	const struct nvkm_fifo_func *func;
 	struct nvkm_engine engine;
@@ -86,6 +116,7 @@ struct nvkm_fifo {
 
 	spinlock_t lock;
 	struct mutex mutex;
+	struct nvkm_fifo_wedge wedge;
 };
 
 void nvkm_fifo_fault(struct nvkm_fifo *, struct nvkm_fault_data *);
diff --git a/drivers/gpu/drm/nouveau/include/trace/events/nouveau_fifo.h b/drivers/gpu/drm/nouveau/include/trace/events/nouveau_fifo.h
new file mode 100644
index 000000000000..46d043a82850
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/include/trace/events/nouveau_fifo.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: MIT */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM nouveau
+
+#if !defined(_TRACE_NOUVEAU_FIFO_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_NOUVEAU_FIFO_H
+
+#include <linux/tracepoint.h>
+#include <drm/drm_device.h>
+
+TRACE_EVENT(nouveau_fifo_chan_killed,
+	TP_PROTO(struct drm_device *dev, u32 chid, u32 fault_type, u64 info),
+	TP_ARGS(dev, chid, fault_type, info),
+	TP_STRUCT__entry(
+		__string(devname, dev_name(dev->dev))
+		__field(u32, chid)
+		__field(u32, fault_type)
+		__field(u64, info)
+	),
+	TP_fast_assign(
+		__assign_str(devname);
+		__entry->chid = chid;
+		__entry->fault_type = fault_type;
+		__entry->info = info;
+	),
+	TP_printk("dev=%s chid=%u fault=%s info=0x%llx",
+		__get_str(devname),
+		__entry->chid,
+		__entry->fault_type == 0 ? "CACHE_ERROR" : "DMA_PUSHER",
+		__entry->info)
+);
+
+TRACE_EVENT(nouveau_fifo_dev_wedged,
+	TP_PROTO(struct drm_device *dev, u32 fault_count, u32 window_ms),
+	TP_ARGS(dev, fault_count, window_ms),
+	TP_STRUCT__entry(
+		__string(devname, dev_name(dev->dev))
+		__field(u32, fault_count)
+		__field(u32, window_ms)
+	),
+	TP_fast_assign(
+		__assign_str(devname);
+		__entry->fault_count = fault_count;
+		__entry->window_ms = window_ms;
+	),
+	TP_printk("dev=%s wedged after %u faults in %u ms",
+		__get_str(devname),
+		__entry->fault_count,
+		__entry->window_ms)
+);
+
+#endif /* _TRACE_NOUVEAU_FIFO_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../drivers/gpu/drm/nouveau/include/trace/events
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE nouveau_fifo
+#include <trace/define_trace.h>
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index e16f59b00f6f..9a9278589a3a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -22,6 +22,8 @@
  * Authors: Ben Skeggs
  */
 
+#define CREATE_TRACE_POINTS
+
 #include <linux/aperture.h>
 #include <linux/delay.h>
 #include <linux/module.h>
@@ -74,6 +76,9 @@
 #include "nouveau_uvmm.h"
 #include "nouveau_sched.h"
 
+#include <engine/fifo.h>
+#include <trace/events/nouveau_fifo.h>
+
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
 			"DRM_UT_DRIVER",
@@ -111,6 +116,18 @@ MODULE_PARM_DESC(runpm, "disable (0), force enable (1), optimus only default (-1
 static int nouveau_runtime_pm = -1;
 module_param_named(runpm, nouveau_runtime_pm, int, 0400);
 
+MODULE_PARM_DESC(fifo_wedge_count,
+	"FIFO faults within window before drm_dev_wedged_event "
+	"(0=disable Tier-2, max 32, default 10)");
+unsigned int nouveau_fifo_wedge_count = 10;
+module_param_named(fifo_wedge_count, nouveau_fifo_wedge_count, uint, 0400);
+
+MODULE_PARM_DESC(fifo_wedge_window_ms,
+	"Sliding-window width in milliseconds for fifo_wedge_count "
+	"(default 60000)");
+unsigned int nouveau_fifo_wedge_window_ms = 60000;
+module_param_named(fifo_wedge_window_ms, nouveau_fifo_wedge_window_ms, uint, 0400);
+
 static struct drm_driver driver_stub;
 static struct drm_driver driver_pci;
 static struct drm_driver driver_platform;
@@ -1495,6 +1512,18 @@ nouveau_drm_init(void)
 	if (!nouveau_modeset)
 		return 0;
 
+	if (nouveau_fifo_wedge_count > NVKM_FIFO_WEDGE_RING_MAX) {
+		pr_warn("nouveau: fifo_wedge_count=%u exceeds max %u; clamping\n",
+			nouveau_fifo_wedge_count, NVKM_FIFO_WEDGE_RING_MAX);
+		nouveau_fifo_wedge_count = NVKM_FIFO_WEDGE_RING_MAX;
+	}
+	if (nouveau_fifo_wedge_window_ms < 100 ||
+	    nouveau_fifo_wedge_window_ms > 600000) {
+		pr_warn("nouveau: fifo_wedge_window_ms=%u out of range; resetting to 60000\n",
+			nouveau_fifo_wedge_window_ms);
+		nouveau_fifo_wedge_window_ms = 60000;
+	}
+
 	nouveau_module_debugfs_init();
 
 #ifdef CONFIG_NOUVEAU_PLATFORM_DRIVER
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/Kbuild b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/Kbuild
index 376e9c3bcb1a..1ff29753731d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/Kbuild
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/Kbuild
@@ -5,6 +5,7 @@ nvkm-y += nvkm/engine/fifo/chan.o
 nvkm-y += nvkm/engine/fifo/chid.o
 nvkm-y += nvkm/engine/fifo/runl.o
 nvkm-y += nvkm/engine/fifo/runq.o
+nvkm-y += nvkm/engine/fifo/recover.o
 
 nvkm-y += nvkm/engine/fifo/nv04.o
 nvkm-y += nvkm/engine/fifo/nv10.o
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
index 9dd924694306..a61183fa38af 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
@@ -337,6 +337,8 @@ nvkm_fifo_dtor(struct nvkm_engine *engine)
 	struct nvkm_runl *runl, *runt;
 	struct nvkm_runq *runq, *rtmp;
 
+	nv04_fifo_wedge_fini(fifo);
+
 	if (fifo->userd.bar1)
 		nvkm_vmm_put(nvkm_bar_bar1_vmm(engine->subdev.device), &fifo->userd.bar1);
 	nvkm_memory_unref(&fifo->userd.mem);
@@ -390,6 +392,7 @@ nvkm_fifo_new_(const struct nvkm_fifo_func *func, struct nvkm_device *device,
 	fifo->timeout.chan_msec = 10000;
 	spin_lock_init(&fifo->lock);
 	mutex_init(&fifo->mutex);
+	nv04_fifo_wedge_init(fifo);
 
 	return nvkm_engine_ctor(&nvkm_fifo, device, type, inst, true, &fifo->engine);
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
index 418a8918bcb8..79774c6460f4 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
@@ -275,6 +275,20 @@ nvkm_chan_del(struct nvkm_chan **pchan)
 	nvkm_gpuobj_del(&chan->ramfc);
 
 	if (chan->cgrp) {
+		struct nvkm_fifo *fifo = chan->cgrp->runl->fifo;
+
+		/* Drop this channel's fault streak before the id is reused. */
+		if (chan->id >= 0) {
+			typeof(&fifo->wedge.chfault[0]) cf =
+				&fifo->wedge.chfault[chan->id % NVKM_FIFO_KILL_CHID_MAX];
+			unsigned long flags;
+
+			spin_lock_irqsave(&fifo->wedge.lock, flags);
+			if (cf->owner == chan)
+				cf->owner = NULL;
+			spin_unlock_irqrestore(&fifo->wedge.lock, flags);
+		}
+
 		nvkm_chid_put(chan->cgrp->runl->chid, chan->id, &chan->cgrp->lock);
 		nvkm_cgrp_unref(&chan->cgrp);
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
index fa13cd55b593..cb81941ecccd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
@@ -345,6 +345,8 @@ nv04_fifo_intr_cache_error(struct nvkm_fifo *fifo, u32 chid, u32 get)
 				   chid, chan ? chan->name : "unknown",
 				   (mthd >> 13) & 7, mthd & 0x1ffc, data);
 			nvkm_chan_put(&chan, flags);
+			nv04_fifo_recover(fifo, chid, NV04_FAULT_CACHE_ERROR,
+					  ((u64)mthd << 32) | data);
 		}
 	}
 
@@ -410,6 +412,8 @@ nv04_fifo_intr_dma_pusher(struct nvkm_fifo *fifo, u32 chid)
 	}
 	nvkm_chan_put(&chan, flags);
 
+	nv04_fifo_recover(fifo, chid, NV04_FAULT_DMA_PUSHER, state);
+
 	nvkm_wr32(device, 0x003228, 0x00000000);
 	nvkm_wr32(device, 0x003220, 0x00000001);
 	nvkm_wr32(device, 0x002100, NV_PFIFO_INTR_DMA_PUSHER);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
index fff1428ef267..bf551906dcd4 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
@@ -83,6 +83,16 @@ void nv04_chan_start(struct nvkm_chan *);
 void nv04_chan_stop(struct nvkm_chan *);
 void nv04_eobj_ramht_del(struct nvkm_chan *, int);
 
+/* Recovery helper for Tesla cache_error/dma_pusher (recover.c). */
+#define NV04_FAULT_CACHE_ERROR	0
+#define NV04_FAULT_DMA_PUSHER	1
+
+void nv04_fifo_recover(struct nvkm_fifo *fifo, u32 chid, u32 fault_type, u64 info);
+void nv04_fifo_wedge_init(struct nvkm_fifo *fifo);
+void nv04_fifo_wedge_fini(struct nvkm_fifo *fifo);
+extern unsigned int nouveau_fifo_wedge_count;
+extern unsigned int nouveau_fifo_wedge_window_ms;
+
 int nv10_fifo_chid_nr(struct nvkm_fifo *);
 
 int nv50_fifo_chid_nr(struct nvkm_fifo *);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/recover.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/recover.c
new file mode 100644
index 000000000000..ea962ddf0bcb
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/recover.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: MIT
+/*
+ * nv04_fifo_recover - shared recovery helper for Tesla cache_error and
+ * dma_pusher fault paths.
+ *
+ * Tier-1: kill the offending channel via nvkm_chan_error, but only once it
+ *         has faulted repeatedly inside a short window.
+ * Tier-2: after a configurable burst of faults within a sliding time
+ *         window, request a device-wide drm_dev_wedged_event so userspace
+ *         can rebind the driver.
+ */
+
+#include "priv.h"
+#include "chan.h"
+
+#include <core/device.h>
+#include <subdev/timer.h>
+
+#include <linux/workqueue.h>
+#include <linux/jiffies.h>
+#include <linux/ktime.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_device.h>
+
+#include "nouveau_drv.h"
+#include <trace/events/nouveau_fifo.h>
+
+static struct drm_device *
+nv04_fifo_drm_device(struct nvkm_fifo *fifo)
+{
+	struct nvkm_device *device = fifo->engine.subdev.device;
+	struct nouveau_drm *drm = dev_get_drvdata(device->dev);
+
+	return (drm && drm->dev) ? drm->dev : NULL;
+}
+
+void
+nv04_fifo_recover(struct nvkm_fifo *fifo, u32 chid, u32 fault_type, u64 info)
+{
+	struct drm_device *drm_dev = nv04_fifo_drm_device(fifo);
+	struct nvkm_chan *chan;
+	unsigned long flags;
+	ktime_t now, cutoff;
+	u32 i, count;
+
+	chan = nvkm_chan_get_chid(&fifo->engine, chid, &flags);
+	if (chan) {
+		struct nvkm_fifo_wedge *w = &fifo->wedge;
+		typeof(&w->chfault[0]) cf =
+			&w->chfault[chid % NVKM_FIFO_KILL_CHID_MAX];
+		ktime_t tnow = ktime_get();
+		unsigned long wflags;
+		bool kill;
+		u32 seen;
+
+		/*
+		 * wedge.lock nests inside chan->cgrp->lock, which
+		 * nvkm_chan_get_chid() holds until nvkm_chan_put().  The other
+		 * users of wedge.lock take no channel lock, so there is no
+		 * reverse ordering.
+		 */
+		if (atomic_read(&chan->errored)) {
+			/*
+			 * The channel is already dead but can still be
+			 * resident and fault again, because nv50 and g84 have
+			 * no preempt and the handler re-enables the puller
+			 * unconditionally.  Do not restart its streak.
+			 */
+			nvkm_chan_put(&chan, flags);
+			goto tier2;
+		}
+
+		spin_lock_irqsave(&w->lock, wflags);
+		if (cf->owner != chan ||
+		    ktime_after(tnow, ktime_add_ms(cf->first,
+						   NVKM_FIFO_KILL_WINDOW_MS))) {
+			cf->owner = chan;
+			cf->first = tnow;
+			cf->count = 0;
+		}
+		seen = ++cf->count;
+		kill = seen >= NVKM_FIFO_KILL_COUNT;
+		if (kill)
+			cf->owner = NULL;
+		spin_unlock_irqrestore(&w->lock, wflags);
+
+		if (kill) {
+			if (drm_dev)
+				trace_nouveau_fifo_chan_killed(drm_dev, chid,
+							       fault_type, info);
+			/*
+			 * preempt must stay false: nv50 and g84 channels have
+			 * no .preempt callback, so nvkm_chan_error() would
+			 * dereference a NULL function pointer under a spinlock
+			 * in interrupt context.
+			 */
+			nvkm_chan_error(chan, false);
+		} else {
+			nvkm_warn(&fifo->engine.subdev,
+				  "ch %d fault %u/%u within %ums, resuming\n",
+				  chid, seen, NVKM_FIFO_KILL_COUNT,
+				  NVKM_FIFO_KILL_WINDOW_MS);
+		}
+		nvkm_chan_put(&chan, flags);
+	}
+
+tier2:
+	if (nouveau_fifo_wedge_count == 0)
+		return;
+
+	now = ktime_get();
+	cutoff = ktime_sub_ms(now, nouveau_fifo_wedge_window_ms);
+
+	spin_lock_irqsave(&fifo->wedge.lock, flags);
+
+	/* Insert current first, then purge expired and count survivors. */
+	fifo->wedge.ts[fifo->wedge.head] = now;
+	fifo->wedge.head = (fifo->wedge.head + 1) % NVKM_FIFO_WEDGE_RING_MAX;
+
+	count = 0;
+	for (i = 0; i < NVKM_FIFO_WEDGE_RING_MAX; i++) {
+		if (!ktime_to_ns(fifo->wedge.ts[i]))
+			continue;
+		if (ktime_before(fifo->wedge.ts[i], cutoff))
+			fifo->wedge.ts[i] = 0;
+		else
+			count++;
+	}
+	fifo->wedge.count = count;
+
+	if (count >= nouveau_fifo_wedge_count)
+		schedule_work(&fifo->wedge.work);
+
+	spin_unlock_irqrestore(&fifo->wedge.lock, flags);
+}
+
+static void
+nv04_fifo_wedge_work(struct work_struct *work)
+{
+	struct nvkm_fifo_wedge *w = container_of(work, struct nvkm_fifo_wedge, work);
+	struct nvkm_fifo *fifo = container_of(w, struct nvkm_fifo, wedge);
+	struct drm_device *drm_dev = nv04_fifo_drm_device(fifo);
+	u32 fault_count;
+
+	if (atomic_xchg(&w->wedged, 1) != 0)
+		return; /* already wedged this cycle */
+
+	if (!drm_dev)
+		return;
+
+	fault_count = w->count;
+
+	dev_info(drm_dev->dev,
+		 "nouveau: fifo wedged after %u faults in %u ms\n",
+		 fault_count, nouveau_fifo_wedge_window_ms);
+
+	trace_nouveau_fifo_dev_wedged(drm_dev, fault_count,
+				      nouveau_fifo_wedge_window_ms);
+
+	drm_dev_wedged_event(drm_dev, DRM_WEDGE_RECOVERY_REBIND, NULL);
+}
+
+void
+nv04_fifo_wedge_init(struct nvkm_fifo *fifo)
+{
+	memset(fifo->wedge.chfault, 0, sizeof(fifo->wedge.chfault));
+	spin_lock_init(&fifo->wedge.lock);
+	INIT_WORK(&fifo->wedge.work, nv04_fifo_wedge_work);
+	atomic_set(&fifo->wedge.wedged, 0);
+}
+
+void
+nv04_fifo_wedge_fini(struct nvkm_fifo *fifo)
+{
+	cancel_work_sync(&fifo->wedge.work);
+}
-- 
2.54.0

