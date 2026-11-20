Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D84606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ENHY6cil
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B261128A2;
	Fri, 20 Nov 2026 10:41:14 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E491128C4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:40:45 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb606491faso3581805e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 02:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795171244; x=1795776044; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TFCzmZ4M04/o3IFI7frtTN+9XGw4ICc/oAP55nb79xs=;
 b=ENHY6cilGgPM18IT3uu56XpOfOoOB5SmPoxSHPm1019s4yU2KvnAHaBuSpyWd7MEPB
 ZBSpxideakUM2zi/OB8wlAM6oZL1XMRdN/QdxQhv9D0ZYigKnaro+dye/nSu2LShDWcL
 NjJQNj9FriyjM0C7lTNIWkQDzxPg67ZWjvmTlrOj7MZ1MiYHEtzxpDAa+27HT1VIeAir
 N/G6xJDAdUJ6+c6u0wKvg75UggV2eUl5yY7Oe1RS59RPuiEGmQwNMoyJp/WOIE6SrZ7l
 ZTEcmfhRTfgeyY/dSWJapNoDm5MvWnTYd1rkoPHaAv892Tbo46hOJn4yhS0Gw9x+VaKd
 1/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171244; x=1795776044;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TFCzmZ4M04/o3IFI7frtTN+9XGw4ICc/oAP55nb79xs=;
 b=xe5bcZKT3PMP2VcLL9PIF2zQSZeu8hrtRxpB2xK29m/+LvRwufLJWntucrxPaVwGzM
 Ti0j6EPJATTh9APM3JcGLCC84s0cg06znxGvy5PM9PFYRFASjDDYkZWPpJUMDkDAokyV
 UX4ysWrW27gm1kvFmZ3343iXnrAnfnJi/uQl4ECCOn/dQDEVZGtSZupiZUtLesrz1g4O
 VepeBXS9jVleWZ79oK3m5s8ZojGpk7WBpGa469qu6XKExP6Rsxj/p6hj+VeN22ZSZ0ST
 Crh1PrCdsCdlpJdwUfGu9imyu1pRqyZBX9eNOpDL3xmN8mFw7qnZzijox/dIoR0Thk1P
 qmCQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFXziBxt5nQ39aYM96hs2rK/rbnWP4ib6RWmFFkVbuFnOu3/IF2cUTfTqurtnpzRwvWKy54lSx+OsY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Y0s/MiScsaQPtG0pE0bswZPzuMsa145txaBt2L0hwp2zI3UA+
 T73MTGGRyte3NDH8+UuLRRE7HKNakiDvs4Lnn5ReNdAAKNVpbnyp3+xg
X-Gm-Gg: AYBFou39n2OeI1gQi5+hvdT5KcSyb2bUsdPMTNQ0Bgc5Y/plTN45SJQk0xPFQPa7liF
 Y8iH2J796s65hKYg6cC3wM9e8aYJR2eviPBiOirm/byHzxwAeE88BVXDPOqDLdkuAMIamCXFUdz
 AUsrjAxOZXA6hd49oyGfciiFUyyePACSCM4ucmuubrYa+BzWGHg1+efTVgCfWw6MwF1OIYmBpMr
 PQxRNbvPCYFbRNg2Cs07iEqx+lNamXZfj9ICkM8j/v+15PYk3WiLUSTG5/NHtKtzOxVNJ8ypS60
 9lzvEO7fNdja8U0EWha7QTlq90BBH8pc66h7/G/5mEzHY7Z/RmxkXAW8k2yGGQb9Riic2VYza7W
 Zigv0ph+7IczOtpdrmTKiFL/hqjyaaxqG10wqG57SdtlOOdLvfq+bmmp0Qnw9wc/iBhfnh6yjqn
 GwFNQYkKoqdQhd0BRBkNASW+VU+vedd6FUPykZ7khzrsk/jGK7OrFUBx/RowfTZcW0NI1d2fZ7P
 swaXYBDtylOdfhQpSMbiAYTagtqd62Dvg7G00qJQ+9OOyPLQWAAufWMBkjW/4KJnuaqUQsCCH3H
 DQ8gXBgyRRJ+ny8uPmZKTpgMfsiCAXu4vNqfLZ5uvx6VxARnOVv3rQzGSQPINaI1jEQsJzbnHJ5
 cL2dhhe2LrJ9eC2P2l2UaBgEtdBpmaXd+FYZgzJGTc8nJxrV7O1pszFJW+EqeyBOqk/O5iHOm
X-Received: by 2002:a05:600c:1548:b0:4bb:7347:d5df with SMTP id
 5b1f17b1804b1-4bb88814405mr61175445e9.13.1795171244052; 
 Fri, 20 Nov 2026 02:40:44 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb895eec06sm22297535e9.2.2026.11.20.02.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:40:43 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 20 Nov 2026 11:40:32 +0100
Subject: [PATCH 6/7] drm/etnaviv: Add a GPU clock change trace event
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-etnaviv-gpu-freq-trace-v1-6-445fc6eacddf@igalia.com>
References: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
In-Reply-To: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: kernel-dev@igalia.com, etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Christian Gmeiner <cgmeiner@igalia.com>
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Gmeiner <cgmeiner@igalia.com>

The GPU core clock changes via the thermal cooling device, on runtime
resume and after a GPU reset. Userspace that converts GPU cycle counts
to time (like the Mesa GPU tracepoints) does not see these changes.

Add a trace event to etnaviv_gpu_update_clock(..), which all three
paths use. It fires when the rate changes and has the old and the new
rate, the time right before and after the switch, and flags. The
clk_set_rate trace events do not cover this: they do not fire on the
FSCALE path and they do not tell the reason for a change.

The flags tell where the change was applied: on resume, on reset, or
without a flag on a running GPU. A change that was made while jobs
were still running is flagged as busy. This replaces the debug message
for this case. The flags are in the uAPI header, as tools need their
values to decode the event.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/Makefile               |  5 ++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c          | 43 ++++++++++++++----
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h          |  2 +
 drivers/gpu/drm/etnaviv/etnaviv_trace.h        | 62 ++++++++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_trace_points.c |  9 ++++
 include/uapi/drm/etnaviv_drm.h                 | 19 ++++++++
 6 files changed, 131 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/Makefile b/drivers/gpu/drm/etnaviv/Makefile
index 903101e8751a..4fb9b83f2808 100644
--- a/drivers/gpu/drm/etnaviv/Makefile
+++ b/drivers/gpu/drm/etnaviv/Makefile
@@ -15,6 +15,9 @@ etnaviv-y := \
 	etnaviv_mmu.o \
 	etnaviv_perfmon.o \
 	etnaviv_flop_reset.o \
-	etnaviv_sched.o
+	etnaviv_sched.o \
+	etnaviv_trace_points.o
 
 obj-$(CONFIG_DRM_ETNAVIV)	+= etnaviv.o
+
+CFLAGS_etnaviv_trace_points.o := -I$(src)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 9b112d053abd..03075f289c69 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -25,6 +25,7 @@
 #include "etnaviv_mmu.h"
 #include "etnaviv_perfmon.h"
 #include "etnaviv_sched.h"
+#include "etnaviv_trace.h"
 #include "common.xml.h"
 #include "state.xml.h"
 #include "state_hi.xml.h"
@@ -505,14 +506,24 @@ static void etnaviv_gpu_load_clock(struct etnaviv_gpu *gpu, u32 clock)
 	gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, clock);
 }
 
-static void etnaviv_gpu_update_clock(struct etnaviv_gpu *gpu)
+/* begin_ns is when the switch, or the restart that includes it, began */
+static void etnaviv_gpu_update_clock(struct etnaviv_gpu *gpu, u32 flags,
+				     u64 begin_ns)
 {
+	unsigned long rate_before = gpu->core_rate;
+	bool scaled = gpu->freq_scale != gpu->applied_scale;
+	u64 end_ns;
+
 	if (gpu->identity.minor_features2 &
 	    chipMinorFeatures2_DYNAMIC_FREQUENCY_SCALING) {
 		clk_set_rate(gpu->clk_core,
 			     gpu->base_rate_core >> gpu->freq_scale);
+		end_ns = ktime_get_ns();
 		clk_set_rate(gpu->clk_shader,
 			     gpu->base_rate_shader >> gpu->freq_scale);
+		/* a rate read back may call firmware, do it only on a change */
+		if (!gpu->core_rate || scaled)
+			gpu->core_rate = clk_get_rate(gpu->clk_core);
 	} else {
 		unsigned int fscale = 1 << (6 - gpu->freq_scale);
 		u32 clock = gpu_read(gpu, VIVS_HI_CLOCK_CONTROL);
@@ -520,6 +531,16 @@ static void etnaviv_gpu_update_clock(struct etnaviv_gpu *gpu)
 		clock &= ~VIVS_HI_CLOCK_CONTROL_FSCALE_VAL__MASK;
 		clock |= VIVS_HI_CLOCK_CONTROL_FSCALE_VAL(fscale);
 		etnaviv_gpu_load_clock(gpu, clock);
+		end_ns = ktime_get_ns();
+		gpu->core_rate = gpu->base_rate_core / 64 * fscale;
+	}
+	gpu->applied_scale = gpu->freq_scale;
+
+	/* a resume or reset that keeps the rate is not worth a report */
+	if (scaled || rate_before != gpu->core_rate) {
+		trace_etnaviv_gpu_clock_change(gpu->dev, flags, begin_ns,
+					       end_ns, rate_before,
+					       gpu->core_rate);
 	}
 
 	/*
@@ -536,9 +557,11 @@ static int etnaviv_hw_reset(struct etnaviv_gpu *gpu)
 	u32 control, idle;
 	unsigned long timeout;
 	bool failed = true;
+	u64 reset_ns;
 
 	/* We hope that the GPU resets in under one second */
 	timeout = jiffies + msecs_to_jiffies(1000);
+	reset_ns = ktime_get_ns();
 
 	while (time_is_after_jiffies(timeout)) {
 		unsigned int fscale = 1 << (6 - gpu->freq_scale);
@@ -638,7 +661,7 @@ static int etnaviv_hw_reset(struct etnaviv_gpu *gpu)
 	}
 
 	/* We rely on the GPU running, so program the clock */
-	etnaviv_gpu_update_clock(gpu);
+	etnaviv_gpu_update_clock(gpu, ETNA_CLOCK_RESET, reset_ns);
 
 	gpu->state = ETNA_GPU_STATE_RESET;
 	gpu->exec_state = -1;
@@ -1771,7 +1794,7 @@ static void etnaviv_gpu_hw_suspend(struct etnaviv_gpu *gpu)
 	gpu->exec_state = -1;
 }
 
-static int etnaviv_gpu_hw_resume(struct etnaviv_gpu *gpu)
+static int etnaviv_gpu_hw_resume(struct etnaviv_gpu *gpu, u64 resume_ns)
 {
 	int ret;
 
@@ -1779,7 +1802,7 @@ static int etnaviv_gpu_hw_resume(struct etnaviv_gpu *gpu)
 	if (ret)
 		return ret;
 
-	etnaviv_gpu_update_clock(gpu);
+	etnaviv_gpu_update_clock(gpu, ETNA_CLOCK_RESUME, resume_ns);
 	etnaviv_gpu_hw_init(gpu);
 
 	mutex_unlock(&gpu->lock);
@@ -1812,6 +1835,7 @@ etnaviv_gpu_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 				  unsigned long state)
 {
 	struct etnaviv_gpu *gpu = cdev->devdata;
+	u32 flags = 0;
 	u32 fence;
 
 	mutex_lock(&gpu->lock);
@@ -1833,7 +1857,7 @@ etnaviv_gpu_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	 * GPU. The wait must be bounded: a hang recovery stops the scheduler,
 	 * which waits for the job held back in etnaviv_gpu_submit(), and that
 	 * job waits for the clock change. So give up after one job timeout and
-	 * change the clock anyway.
+	 * change the clock anyway. Such a change is reported as busy.
 	 */
 	WRITE_ONCE(gpu->clock_change_pending, true);
 	fence = gpu->next_fence;
@@ -1842,12 +1866,12 @@ etnaviv_gpu_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	if (!wait_event_timeout(gpu->fence_event,
 				!fence_after(fence, READ_ONCE(gpu->completed_fence)),
 				gpu->sched.timeout))
-		dev_dbg(gpu->dev, "clock change while jobs are running\n");
+		flags |= ETNA_CLOCK_BUSY;
 
 	mutex_lock(&gpu->lock);
 	/* the GPU may have suspended while waiting, the resume applies it */
 	if (gpu->state >= ETNA_GPU_STATE_RESET)
-		etnaviv_gpu_update_clock(gpu);
+		etnaviv_gpu_update_clock(gpu, flags, ktime_get_ns());
 	store_release_wake_up(&gpu->clock_change_pending, false);
 	mutex_unlock(&gpu->lock);
 
@@ -1955,6 +1979,8 @@ static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
 
 	gpu->drm = NULL;
 	xa_destroy(&gpu->user_fences);
+
+	gpu->core_rate = 0;
 }
 
 static const struct component_ops gpu_ops = {
@@ -2099,6 +2125,7 @@ static int etnaviv_gpu_rpm_suspend(struct device *dev)
 static int etnaviv_gpu_rpm_resume(struct device *dev)
 {
 	struct etnaviv_gpu *gpu = dev_get_drvdata(dev);
+	u64 resume_ns = ktime_get_ns();
 	int ret;
 
 	ret = etnaviv_gpu_clk_enable(gpu);
@@ -2107,7 +2134,7 @@ static int etnaviv_gpu_rpm_resume(struct device *dev)
 
 	/* Re-initialise the basic hardware state */
 	if (gpu->state == ETNA_GPU_STATE_IDENTIFIED) {
-		ret = etnaviv_gpu_hw_resume(gpu);
+		ret = etnaviv_gpu_hw_resume(gpu, resume_ns);
 		if (ret) {
 			etnaviv_gpu_clk_disable(gpu);
 			return ret;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index dddeabce6eb4..c8d537c3dee7 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -163,8 +163,10 @@ struct etnaviv_gpu {
 	struct reset_control *rst;
 
 	unsigned int freq_scale;
+	unsigned int applied_scale;
 	unsigned int fe_waitcycles;
 	unsigned long base_rate_core;
+	unsigned long core_rate;
 	unsigned long base_rate_shader;
 };
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_trace.h b/drivers/gpu/drm/etnaviv/etnaviv_trace.h
new file mode 100644
index 000000000000..503015e4c973
--- /dev/null
+++ b/drivers/gpu/drm/etnaviv/etnaviv_trace.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Mecha Systems Pvt Ltd
+ */
+
+#if !defined(_ETNAVIV_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
+#define _ETNAVIV_TRACE_H_
+
+#include <linux/device.h>
+#include <linux/tracepoint.h>
+#include <linux/types.h>
+
+#include <drm/etnaviv_drm.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM etnaviv
+#define TRACE_INCLUDE_FILE etnaviv_trace
+
+/*
+ * flags are ETNA_CLOCK_x, see the uAPI header for when the event fires.
+ * begin_ns and end_ns are CLOCK_MONOTONIC. The record itself carries the
+ * trace clock, which can differ from it by the time spent in suspend.
+ */
+TRACE_EVENT(etnaviv_gpu_clock_change,
+	    TP_PROTO(struct device *dev, u32 flags, u64 begin_ns, u64 end_ns,
+		     unsigned long rate_before, unsigned long rate_after),
+	    TP_ARGS(dev, flags, begin_ns, end_ns, rate_before, rate_after),
+
+	    TP_STRUCT__entry(
+			     __string(dev, dev_name(dev))
+			     __field(u32, flags)
+			     __field(u64, begin_ns)
+			     __field(u64, end_ns)
+			     __field(unsigned long, rate_before)
+			     __field(unsigned long, rate_after)
+			     ),
+
+	    TP_fast_assign(
+			   __assign_str(dev);
+			   __entry->flags = flags;
+			   __entry->begin_ns = begin_ns;
+			   __entry->end_ns = end_ns;
+			   __entry->rate_before = rate_before;
+			   __entry->rate_after = rate_after;
+			   ),
+
+	    TP_printk("dev=%s flags=%s begin_ns=%llu end_ns=%llu rate_before=%lu rate_after=%lu",
+		      __get_str(dev),
+		      __print_flags(__entry->flags, "|",
+				    { ETNA_CLOCK_RESUME, "RESUME" },
+				    { ETNA_CLOCK_RESET, "RESET" },
+				    { ETNA_CLOCK_BUSY, "BUSY" }),
+		      __entry->begin_ns, __entry->end_ns,
+		      __entry->rate_before, __entry->rate_after)
+);
+
+#endif /* _ETNAVIV_TRACE_H_ */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#include <trace/define_trace.h>
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_trace_points.c b/drivers/gpu/drm/etnaviv/etnaviv_trace_points.c
new file mode 100644
index 000000000000..bd039899252c
--- /dev/null
+++ b/drivers/gpu/drm/etnaviv/etnaviv_trace_points.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Mecha Systems Pvt Ltd
+ */
+
+#ifndef __CHECKER__
+#define CREATE_TRACE_POINTS
+#include "etnaviv_trace.h"
+#endif
diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
index af024d90453d..83c58d94d36b 100644
--- a/include/uapi/drm/etnaviv_drm.h
+++ b/include/uapi/drm/etnaviv_drm.h
@@ -265,6 +265,25 @@ struct drm_etnaviv_pm_signal {
 	char  name[64];   /* out, name of domain */
 };
 
+/*
+ * Core clock changes, reported by the kernel for userspace that converts
+ * GPU cycle counts to CLOCK_MONOTONIC. These are the flags of the
+ * etnaviv_gpu_clock_change trace event.
+ *
+ * Every report is a rate change: a new cooling state, or the first clock
+ * setup after the GPU is bound. RESUME and RESET are set if the change was
+ * applied while the GPU was resumed or reset, without them it was applied
+ * to a running GPU. A resume or reset that keeps the rate is not reported,
+ * and neither is a cooling request that a resume has already applied.
+ *
+ * A change is made between jobs, so every job runs at a single rate.
+ * ETNA_CLOCK_BUSY marks the exception: jobs were still running when the
+ * kernel gave up waiting for them.
+ */
+#define ETNA_CLOCK_RESUME              0x0001
+#define ETNA_CLOCK_RESET               0x0002
+#define ETNA_CLOCK_BUSY                0x0004
+
 #define DRM_ETNAVIV_GET_PARAM          0x00
 /* placeholder:
 #define DRM_ETNAVIV_SET_PARAM          0x01

-- 
2.56.0

