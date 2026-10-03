Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0325DCA5FF5
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F1510EAFD;
	Sun,  4 Oct 2026 17:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=saltyming.net header.i=@saltyming.net header.b="xUh3KfUZ";
	dkim-atps=neutral
Received: from smtp-sv1.saltyming.net (smtp-sv1.saltyming.net [152.53.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2F6C10E2E5
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 23:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=saltyming-dkim-202512; d=saltyming.net;
 c=relaxed/relaxed; 
 h=MIME-Version:Message-ID:Date:Subject:To:From:Content-Type; t=1791071147;
 x=1791675947; bh=hxN7kjCEhLnn1+Ezysc3TnjEFzT6AYEfF7E3Sz1y6Gg=; b=xUh3KfUZFx
 DexYy5b1FZq7L+fk8wKQJALT7UNT+fhPEwDlM+9/hZRoux9A0vcZ+iFaWr+VNeZKtt4eLumMZeU
 CM8zNuyMxq7gY4c8YRBUM793XvB6+YiYA4dBpIbdYn7Fw+v8ZgqIJnsDHLBXcANJZ7p1rJ6Mat3
 R+CAEIL1X4/D9QsE2RGyL5oF5Ry4QU+93RAt9pMQ+UEroqtTZAXsXLAA4qyRPrufryKMWXdl5eR
 ylyhRJhY894ZtaoqKs5pPf1bPfutWqMf+MDcnfSQtmyg+1eNTFOgIHwp52Spart6PSuJIjbVBzH
 D28DEkVt9QC27FYbfgejMw24vhYqAUbQ==;
Received: by smtp-sv1.saltyming.net (SaltyMail) with ESMTPSA
 (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256)
 (No client certificate requested)
 id 455f2149-f629-4f38-9c76-c196b5d4287d
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 23:45:31 +0000
X-Virus-Status: Clean
X-Security-Tags: spf_none, dkim_none, dmarc_fail, dmarc_quarantine, arc_none,
 av_clean, ham
From: Hamin Sung <hamin@saltyming.net>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Aaron Kling <webgeek1234@gmail.com>, Hamin Sung <hamin@saltyming.net>
Subject: [RFC PATCH 1/2] drm/nouveau/pmu/gt215: add graphics engine load
 counters
Date: Sun,  4 Oct 2026 08:45:20 +0900
Message-ID: <20261003234520.69573-1-hamin@saltyming.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003223420.77993-1-hamin@saltyming.net>
References: <20261003223420.77993-1-hamin@saltyming.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

The PDAEMON in GT215, GT216, GT218 and MCP89 has idle counters that
count PMU clock cycles depending on the state of a selected set of
engine idle signals.  Nothing in nouveau uses them on these GPUs;
gk20a_devfreq.c drives the same counter block on Tegra.

Add nvkm_pmu_perfmon_init() and nvkm_pmu_perfmon_read() and implement
them for these GPUs: one counter counts every cycle, a second one the
cycles during which the graphics engine is not idle, and reading returns
and clears both.  The counters are only programmed once
nvkm_pmu_perfmon_init() is called, so nothing changes for existing
users.

The next patch uses them to select performance levels through devfreq.

Link: https://envytools.readthedocs.io/en/latest/hw/pm/pdaemon/counter.html
Assisted-by: Claude:claude-opus-5-5 sparse # max effort
Assisted-by: Claude:claude-fable-5-1 # max effort, review
Signed-off-by: Hamin Sung <hamin@saltyming.net>
---
Sorry for the duplicate copies of the cover letter, and of the two
nouveau fixes I sent with it: my mail server delivered each of them
twice to most recipients.

 .../gpu/drm/nouveau/include/nvkm/subdev/pmu.h |  2 +
 .../gpu/drm/nouveau/nvkm/subdev/pmu/base.c    | 29 ++++++++++++++
 .../gpu/drm/nouveau/nvkm/subdev/pmu/gt215.c   | 40 +++++++++++++++++++
 .../gpu/drm/nouveau/nvkm/subdev/pmu/priv.h    |  5 +++
 4 files changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pmu.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pmu.h
index f57a3a5a288d..de844e69a5e6 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pmu.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pmu.h
@@ -39,6 +39,8 @@ int nvkm_pmu_send(struct nvkm_pmu *, u32 reply[2], u32 process,
 		  u32 message, u32 data0, u32 data1);
 void nvkm_pmu_pgob(struct nvkm_pmu *, bool enable);
 bool nvkm_pmu_fan_controlled(struct nvkm_device *);
+int nvkm_pmu_perfmon_init(struct nvkm_pmu *pmu);
+int nvkm_pmu_perfmon_read(struct nvkm_pmu *pmu, u32 *busy, u32 *total);
 
 int gt215_pmu_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pmu **);
 int gf100_pmu_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pmu **);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
index e556b1905702..fb51db6a2ca3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
@@ -51,6 +51,35 @@ nvkm_pmu_pgob(struct nvkm_pmu *pmu, bool enable)
 		pmu->func->pgob(pmu, enable);
 }
 
+/*
+ * Set up the PMU counters that nvkm_pmu_perfmon_read() samples.  PMU
+ * initialisation resets the PMU, so this has to be repeated after resume.
+ */
+int
+nvkm_pmu_perfmon_init(struct nvkm_pmu *pmu)
+{
+	if (!pmu || !pmu->func->perfmon.init)
+		return -ENODEV;
+
+	pmu->func->perfmon.init(pmu);
+	return 0;
+}
+
+/*
+ * Return the number of PMU clock cycles that passed, and how many of them the
+ * graphics engine was busy for, since the previous call or since
+ * nvkm_pmu_perfmon_init(), and restart counting.
+ */
+int
+nvkm_pmu_perfmon_read(struct nvkm_pmu *pmu, u32 *busy, u32 *total)
+{
+	if (!pmu || !pmu->func->perfmon.read)
+		return -ENODEV;
+
+	pmu->func->perfmon.read(pmu, busy, total);
+	return 0;
+}
+
 static void
 nvkm_pmu_recv(struct work_struct *work)
 {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gt215.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gt215.c
index 32cee21ed858..37310a8ebe81 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gt215.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gt215.c
@@ -260,6 +260,44 @@ gt215_pmu_init(struct nvkm_pmu *pmu)
 	return 0;
 }
 
+/*
+ * PDAEMON idle counters.  Each one has a mask of engine idle signals at
+ * 0x10a504, a cycle count at 0x10a508 (bit 31 clears it) and a mode at
+ * 0x10a50c: bit 0 counts cycles in which all masked signals are set, bit 1
+ * cycles in which they are all clear, and both together count every cycle.
+ * Idle signal bit 0 is the graphics engine.
+ */
+#define GT215_PMU_COUNTER_TOTAL 0
+#define GT215_PMU_COUNTER_GR    1
+
+static void
+gt215_pmu_perfmon_init(struct nvkm_pmu *pmu)
+{
+	struct nvkm_device *device = pmu->subdev.device;
+
+	nvkm_wr32(device, 0x10a504 + GT215_PMU_COUNTER_TOTAL * 0x10, 0x00000000);
+	nvkm_wr32(device, 0x10a50c + GT215_PMU_COUNTER_TOTAL * 0x10, 0x00000003);
+	nvkm_wr32(device, 0x10a508 + GT215_PMU_COUNTER_TOTAL * 0x10, 0x80000000);
+
+	nvkm_wr32(device, 0x10a504 + GT215_PMU_COUNTER_GR * 0x10, 0x00000001);
+	nvkm_wr32(device, 0x10a50c + GT215_PMU_COUNTER_GR * 0x10, 0x00000002);
+	nvkm_wr32(device, 0x10a508 + GT215_PMU_COUNTER_GR * 0x10, 0x80000000);
+}
+
+static void
+gt215_pmu_perfmon_read(struct nvkm_pmu *pmu, u32 *busy, u32 *total)
+{
+	struct nvkm_device *device = pmu->subdev.device;
+
+	*busy = nvkm_rd32(device, 0x10a508 + GT215_PMU_COUNTER_GR * 0x10);
+	*total = nvkm_rd32(device, 0x10a508 + GT215_PMU_COUNTER_TOTAL * 0x10);
+	nvkm_wr32(device, 0x10a508 + GT215_PMU_COUNTER_GR * 0x10, 0x80000000);
+	nvkm_wr32(device, 0x10a508 + GT215_PMU_COUNTER_TOTAL * 0x10, 0x80000000);
+
+	*busy &= 0x7fffffff;
+	*total &= 0x7fffffff;
+}
+
 const struct nvkm_falcon_func
 gt215_pmu_flcn = {
 };
@@ -278,6 +316,8 @@ gt215_pmu = {
 	.intr = gt215_pmu_intr,
 	.send = gt215_pmu_send,
 	.recv = gt215_pmu_recv,
+	.perfmon.init = gt215_pmu_perfmon_init,
+	.perfmon.read = gt215_pmu_perfmon_read,
 };
 
 static const struct nvkm_pmu_fwif
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/priv.h
index 2d0a8fa6f196..880a7785589a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/priv.h
@@ -30,6 +30,11 @@ struct nvkm_pmu_func {
 	void (*recv)(struct nvkm_pmu *);
 	int (*initmsg)(struct nvkm_pmu *);
 	void (*pgob)(struct nvkm_pmu *, bool);
+
+	struct {
+		void (*init)(struct nvkm_pmu *pmu);
+		void (*read)(struct nvkm_pmu *pmu, u32 *busy, u32 *total);
+	} perfmon;
 };
 
 extern const struct nvkm_falcon_func gt215_pmu_flcn;
-- 
2.55.0


