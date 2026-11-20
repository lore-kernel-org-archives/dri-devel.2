Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A79606A333
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j0zljVKj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6925310E5F0;
	Fri, 20 Nov 2026 10:41:19 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A621128D2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:40:47 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so6899305e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 02:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795171245; x=1795776045; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qBLG4t4oO3794vWhQM2jRWw+A/4Ymw3vg7/JQp5J2Cg=;
 b=j0zljVKjwwhjx1x04jXCOrGcOi7qF5UUVOosbs0+zbPlh3wtnuCzADjhSjyzD3KgjL
 wl9WIbs2h8PGqKP/z3DQVkoG/rL527aAqvFJnLvACPF6rytZ97EZHT1SBY/6RuRJQ8Ko
 ejldh5sYYC6paJ7c4MpY4FBarAvT/nWkg+Xii/B2yFezfwbFVO8edUACGTaSr8yhdZEA
 H1RQYS9z2xOhD+ovrSm7DbkWqmmgb20UgtbpMXRQHcjW0zoPdVYQO97zjeIWQY2gM0bf
 oiRxlCQEO152Xwhax/uSQCwNYYKbvMTn24knZsS3TJ+cON1jp1LCdlqSGnnTkebVWJQD
 1GmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171245; x=1795776045;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qBLG4t4oO3794vWhQM2jRWw+A/4Ymw3vg7/JQp5J2Cg=;
 b=1o5EDC7ppNFVpj2SdKhbqbSbhj9C908JrJA2zAOj1vxyQwsnLydoy4nIBUMh9Mt2eb
 CyvXHF4ZgoMYuUGkdvnkw1K2/p4EC6LrMouiIvxgWjGhbMBdeRRpu1Xe1bPrbiJcpgqk
 D0EiaYxISSoJvKDSyhlMobH3ztCaqb8updh06ZlWCHAj7twQ9mXwqpd6ms2z/dpVxLYu
 YTI8lcx8/2eD3Ci0Kk7i1Kns4ZPVFWbiDIOAoySw3aeZl6AnuLHDMcMvcXop/U8+RoBl
 +x2riz9gID5Szj6SAs5jWFkzf0AQkSO65jl9RWTky/IWWy+GMaQ+2JjEy0YKRn8SeLmr
 V4kQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGCkTaKSjnjTfwGhHU5iLBKULLQPw+LoZpbRfTgUk84FHEJvwyftOZcwFTm9qvoWCpFuN9V+VdORcQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/yf5QvDZCFlgUNr7Wufg/QUElSqtgJhlPwT11TYK6j7kCoECCE
 9X9ob4n8xmje4QC7RvWFZon7UU/+FS3+nGzZbHvd6I22wXUXiKV1Bvxa
X-Gm-Gg: AYBFou0piaG/YeUeXUQQeJqiXr52DmJQpLXL+WWY5hBfxMIoF/KcE0DMNxlWn5tkhAF
 ORzCZMns8inCcxHxLlvkMcL68tedP6649mcXlR9dVX4KgSxRZmnnO444MOh5tZXZseNX4dY+71F
 q58GG0ZnIymggNqWCpL9dpiei7mIPmPg9Gk2CQyL3ryL6ehJZjpJOu6/tXBlJS8OZe3ijVJHdYW
 kAl8I5mh1XXI/cgy6qpIRthOHl4IfFi12fKz6Oq7yw9ZRnrWBUIY+UjBkgl/volMiXW/D8bDjG0
 1yBYEs6idsfhnIYT5qvbcqNaddxADcuwm3/h6b9cFaxJ15Y4Uq8TRkAmMTE6Gp5xYiAjU/TmwFn
 v+T0L7uYiT3wtSVFsjdw3+uK92uXopsXQfm4x8u7MClUiSZ5H0Io6VDUw9hkv2t/1dfjK0PBiBJ
 bfCMM5iO0l2Qv3YnHKr4v8Dw4EAd92HhaJX+HiOqn/7tExDfCJv8gIt9sluzmOlK13nCtyEDlrV
 cH+Fccs+IBfwbd3b11PO5NYYP0+oLfKmH5SnCQAc8IqKy7YHj06xmJaSpOJ1p0m+59Cwdx7NvcL
 SxQN7+VDp8x4Pnbo8A1PEsv2lcLZ7YGj7XvJZWHImBAjqX7UgHl7EokqPtF32Dtqr0+eTm5qVPx
 hPBf0JY+5CzRt9pKCFRpfvV929O0omsamwr1ETDqgO9/aNhKMaCFIVnNLRrbCF05ADsQTFuSc
X-Received: by 2002:a05:600c:a0b:b0:4b7:6a8b:9df2 with SMTP id
 5b1f17b1804b1-4bb8882432bmr54391435e9.25.1795171245423; 
 Fri, 20 Nov 2026 02:40:45 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb895eec06sm22297535e9.2.2026.11.20.02.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:40:44 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 20 Nov 2026 11:40:33 +0100
Subject: [PATCH 7/7] drm/etnaviv: Add an ioctl to read back GPU clock changes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-etnaviv-gpu-freq-trace-v1-7-445fc6eacddf@igalia.com>
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

Userspace that converts GPU cycle counts to time needs the core clock
rate a job ran at. The trace event has this information, but only a
privileged tracer can read it.

Keep the last 256 clock changes per GPU in a ring buffer, 10 KiB per
GPU. A record is written together with the trace event. It has the
same times and flags, the rate after the change and a sequence number.
The ring only fills as fast as the thermal governor changes the
cooling state.

Add an ioctl that returns the records newer than a given sequence
number. It also returns the newest sequence number the kernel has, so
a reader knows when to call again. A reader that has fallen behind
sees a gap in the sequence numbers. The caller passes the size of its
record struct, so the record can grow later without a new ioctl. The
first clock setup after bind is recorded too, so a new process can
read the current rate.

Bump the minor version so userspace can check for the ioctl.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 20 ++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 83 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  9 ++++
 include/uapi/drm/etnaviv_drm.h        | 43 +++++++++++++++++-
 4 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index ec1352c1b09f..317362137e4a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -473,6 +473,23 @@ static int etnaviv_ioctl_pm_query_sig(struct drm_device *dev, void *data,
 	return etnaviv_pm_query_sig(gpu, args);
 }
 
+static int etnaviv_ioctl_clock_history(struct drm_device *dev, void *data,
+	struct drm_file *file)
+{
+	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct drm_etnaviv_clock_history *args = data;
+	struct etnaviv_gpu *gpu;
+
+	if (args->pipe >= ETNA_MAX_PIPES)
+		return -EINVAL;
+
+	gpu = priv->gpu[args->pipe];
+	if (!gpu)
+		return -ENXIO;
+
+	return etnaviv_gpu_clock_history(gpu, args);
+}
+
 static const struct drm_ioctl_desc etnaviv_ioctls[] = {
 #define ETNA_IOCTL(n, func, flags) \
 	DRM_IOCTL_DEF_DRV(ETNAVIV_##n, etnaviv_ioctl_##func, flags)
@@ -487,6 +504,7 @@ static const struct drm_ioctl_desc etnaviv_ioctls[] = {
 	ETNA_IOCTL(GEM_WAIT,     gem_wait,     DRM_RENDER_ALLOW),
 	ETNA_IOCTL(PM_QUERY_DOM, pm_query_dom, DRM_RENDER_ALLOW),
 	ETNA_IOCTL(PM_QUERY_SIG, pm_query_sig, DRM_RENDER_ALLOW),
+	ETNA_IOCTL(CLOCK_HISTORY, clock_history, DRM_RENDER_ALLOW),
 };
 
 static void etnaviv_show_fdinfo(struct drm_printer *p, struct drm_file *file)
@@ -515,7 +533,7 @@ static const struct drm_driver etnaviv_drm_driver = {
 	.name               = "etnaviv",
 	.desc               = "etnaviv DRM",
 	.major              = 1,
-	.minor              = 4,
+	.minor              = 5,
 };
 
 /*
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 03075f289c69..2af1af33287a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -506,6 +506,80 @@ static void etnaviv_gpu_load_clock(struct etnaviv_gpu *gpu, u32 clock)
 	gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, clock);
 }
 
+static void etnaviv_gpu_record_clock(struct etnaviv_gpu *gpu, u32 flags,
+				     u64 begin_ns, u64 end_ns,
+				     unsigned long rate)
+{
+	spin_lock(&gpu->clock_lock);
+	gpu->clock_seq++;
+	gpu->clock_records[gpu->clock_seq % ETNA_NR_CLOCK_RECORDS] =
+		(struct drm_etnaviv_clock_record){
+			.begin_ns = begin_ns,
+			.end_ns = end_ns,
+			.rate = rate,
+			.seq = gpu->clock_seq,
+			.flags = flags,
+		};
+	spin_unlock(&gpu->clock_lock);
+}
+
+static u64 etnaviv_gpu_clock_oldest(u64 last)
+{
+	if (last > ETNA_NR_CLOCK_RECORDS)
+		return last - ETNA_NR_CLOCK_RECORDS + 1;
+
+	return 1;
+}
+
+int etnaviv_gpu_clock_history(struct etnaviv_gpu *gpu,
+			      struct drm_etnaviv_clock_history *args)
+{
+	u64 last, start;
+	u32 size, n = 0, i;
+
+	if (args->flags)
+		return -EINVAL;
+
+	/* records can grow, a reader gets the part of each one it knows */
+	if (args->record_size <
+	    offsetofend(struct drm_etnaviv_clock_record, pad))
+		return -EINVAL;
+	size = min_t(u32, args->record_size,
+		     sizeof(struct drm_etnaviv_clock_record));
+
+	spin_lock(&gpu->clock_lock);
+	last = gpu->clock_seq;
+	spin_unlock(&gpu->clock_lock);
+
+	if (args->since_seq < last) {
+		start = max(args->since_seq + 1, etnaviv_gpu_clock_oldest(last));
+		n = min_t(u64, last - start + 1, args->count);
+	}
+
+	for (i = 0; i < n; i++) {
+		void __user *dst = u64_to_user_ptr(args->records +
+						   (u64)i * args->record_size);
+		struct drm_etnaviv_clock_record record;
+
+		spin_lock(&gpu->clock_lock);
+		record = gpu->clock_records[(start + i) % ETNA_NR_CLOCK_RECORDS];
+		spin_unlock(&gpu->clock_lock);
+
+		/* overwritten since clock_seq was read */
+		if (record.seq != start + i)
+			break;
+
+		if (copy_to_user(dst, &record, size))
+			return -EFAULT;
+	}
+
+	args->count = i;
+	args->record_size = size;
+	args->last_seq = last;
+
+	return 0;
+}
+
 /* begin_ns is when the switch, or the restart that includes it, began */
 static void etnaviv_gpu_update_clock(struct etnaviv_gpu *gpu, u32 flags,
 				     u64 begin_ns)
@@ -538,6 +612,8 @@ static void etnaviv_gpu_update_clock(struct etnaviv_gpu *gpu, u32 flags,
 
 	/* a resume or reset that keeps the rate is not worth a report */
 	if (scaled || rate_before != gpu->core_rate) {
+		etnaviv_gpu_record_clock(gpu, flags, begin_ns, end_ns,
+					 gpu->core_rate);
 		trace_etnaviv_gpu_clock_change(gpu->dev, flags, begin_ns,
 					       end_ns, rate_before,
 					       gpu->core_rate);
@@ -2008,8 +2084,15 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 
 	gpu->dev = dev;
 	mutex_init(&gpu->lock);
+	spin_lock_init(&gpu->clock_lock);
 	mutex_init(&gpu->sched_lock);
 
+	gpu->clock_records = devm_kcalloc(dev, ETNA_NR_CLOCK_RECORDS,
+					  sizeof(*gpu->clock_records),
+					  GFP_KERNEL);
+	if (!gpu->clock_records)
+		return -ENOMEM;
+
 	/* Map registers: */
 	gpu->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gpu->mmio))
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index c8d537c3dee7..ac619f3020bb 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -96,6 +96,7 @@ struct clk;
 struct reset_control;
 
 #define ETNA_NR_EVENTS 30
+#define ETNA_NR_CLOCK_RECORDS 256
 
 enum etnaviv_gpu_state {
 	ETNA_GPU_STATE_UNKNOWN = 0,
@@ -168,6 +169,11 @@ struct etnaviv_gpu {
 	unsigned long base_rate_core;
 	unsigned long core_rate;
 	unsigned long base_rate_shader;
+
+	/* protects clock_seq and clock_records */
+	spinlock_t clock_lock;
+	u64 clock_seq;
+	struct drm_etnaviv_clock_record *clock_records;
 };
 
 static inline void gpu_write(struct etnaviv_gpu *gpu, u32 reg, u32 data)
@@ -237,4 +243,7 @@ void etnaviv_gpu_start_fe(struct etnaviv_gpu *gpu, u32 address, u16 prefetch);
 
 extern struct platform_driver etnaviv_gpu_driver;
 
+int etnaviv_gpu_clock_history(struct etnaviv_gpu *gpu,
+			      struct drm_etnaviv_clock_history *args);
+
 #endif /* __ETNAVIV_GPU_H__ */
diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
index 83c58d94d36b..2f039836e7a9 100644
--- a/include/uapi/drm/etnaviv_drm.h
+++ b/include/uapi/drm/etnaviv_drm.h
@@ -284,6 +284,45 @@ struct drm_etnaviv_pm_signal {
 #define ETNA_CLOCK_RESET               0x0002
 #define ETNA_CLOCK_BUSY                0x0004
 
+/*
+ * The kernel also records the clock changes. The switch happens between
+ * begin_ns and end_ns. For RESUME and RESET the window covers the whole
+ * restart, from before the first reset attempt or the clock enable. That
+ * is wider than needed, but no job runs in it.
+ *
+ * The first record is written when the GPU is initialized after it is
+ * bound. So a GPU has at least one record, unless its core clock rate is
+ * unknown.
+ *
+ * DRM_IOCTL_ETNAVIV_CLOCK_HISTORY returns the records after since_seq, oldest
+ * first. It can return fewer than requested even if more exist, call it again
+ * until the last returned seq reaches last_seq. A reader that fell behind
+ * sees a gap between since_seq and the first seq returned.
+ *
+ * record_size is the stride of the records array and at least the size of
+ * the record below. So that the record can grow, the kernel writes the
+ * smaller of record_size and its own record size to each element and returns
+ * that size in record_size.
+ */
+struct drm_etnaviv_clock_record {
+	__u64 begin_ns;    /* CLOCK_MONOTONIC right before the switch */
+	__u64 end_ns;      /* CLOCK_MONOTONIC right after the switch */
+	__u64 rate;        /* core clock rate after the switch, in Hz */
+	__u64 seq;         /* increments by one per record, starts at 1 */
+	__u32 flags;       /* ETNA_CLOCK_x */
+	__u32 pad;         /* out, zero */
+};
+
+struct drm_etnaviv_clock_history {
+	__u32 pipe;        /* in */
+	__u32 count;       /* in, capacity of records, out, records returned */
+	__u32 record_size; /* in, stride of records, out, bytes written each */
+	__u32 flags;       /* in, must be zero */
+	__u64 since_seq;   /* in, return records with seq > since_seq */
+	__u64 last_seq;    /* out, newest record */
+	__u64 records;     /* in, pointer to struct drm_etnaviv_clock_record */
+};
+
 #define DRM_ETNAVIV_GET_PARAM          0x00
 /* placeholder:
 #define DRM_ETNAVIV_SET_PARAM          0x01
@@ -298,7 +337,8 @@ struct drm_etnaviv_pm_signal {
 #define DRM_ETNAVIV_GEM_WAIT           0x09
 #define DRM_ETNAVIV_PM_QUERY_DOM       0x0a
 #define DRM_ETNAVIV_PM_QUERY_SIG       0x0b
-#define DRM_ETNAVIV_NUM_IOCTLS         0x0c
+#define DRM_ETNAVIV_CLOCK_HISTORY      0x0c
+#define DRM_ETNAVIV_NUM_IOCTLS         0x0d
 
 #define DRM_IOCTL_ETNAVIV_GET_PARAM    DRM_IOWR(DRM_COMMAND_BASE + DRM_ETNAVIV_GET_PARAM, struct drm_etnaviv_param)
 #define DRM_IOCTL_ETNAVIV_GEM_NEW      DRM_IOWR(DRM_COMMAND_BASE + DRM_ETNAVIV_GEM_NEW, struct drm_etnaviv_gem_new)
@@ -311,6 +351,7 @@ struct drm_etnaviv_pm_signal {
 #define DRM_IOCTL_ETNAVIV_GEM_WAIT     DRM_IOW(DRM_COMMAND_BASE + DRM_ETNAVIV_GEM_WAIT, struct drm_etnaviv_gem_wait)
 #define DRM_IOCTL_ETNAVIV_PM_QUERY_DOM DRM_IOWR(DRM_COMMAND_BASE + DRM_ETNAVIV_PM_QUERY_DOM, struct drm_etnaviv_pm_domain)
 #define DRM_IOCTL_ETNAVIV_PM_QUERY_SIG DRM_IOWR(DRM_COMMAND_BASE + DRM_ETNAVIV_PM_QUERY_SIG, struct drm_etnaviv_pm_signal)
+#define DRM_IOCTL_ETNAVIV_CLOCK_HISTORY DRM_IOWR(DRM_COMMAND_BASE + DRM_ETNAVIV_CLOCK_HISTORY, struct drm_etnaviv_clock_history)
 
 #if defined(__cplusplus)
 }

-- 
2.56.0

