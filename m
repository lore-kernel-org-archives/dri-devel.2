Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C15CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 14:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84EEB10E619;
	Fri, 15 May 2026 14:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="ENC6Um7x";
	dkim-atps=neutral
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB6610F53F
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 14:02:32 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-50e5eb0fabaso86576611cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1778853751; x=1779458551;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8GCYT+w3Aho95/C+fNjFi1Z+weTfOUHld92VJE85ntg=;
 b=ENC6Um7xdCIUKNY3MWgEmqF2Dz+GNjIwPacshh7J8dApjgd85WIzP77CbdJKveXRzW
 RL8mK/3XtKd2m5qHCT9TJSNV5jjSbKzR/vlhxkpoFQoNNs+6saVmN2CsZzFHqTn9YMM7
 WHKtk7xDfD9cKEnWLQrTkOor5ytE9K9vnw3qAUcmU5imEbkQuG5iiCr3jSLsCxFEOjoT
 v+9LcN/pVPDv4ktB9R6I2Xpl+YZ6DAKdadkLlgaIWL4aPYr1GV2DRmUbAOtC1iKSRjmY
 XNgt3Eja5BaGtG93JUJ0Y29lpROso3RnzOFy+wzRhZT+tgaV87wWwiHGFBe+t6vlNeIv
 kGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853751; x=1779458551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GCYT+w3Aho95/C+fNjFi1Z+weTfOUHld92VJE85ntg=;
 b=J0xHpCm6JOOTMUXbJnOAwvhPAE7HnNBK7HZrNZXjbeNAFYodat9z7vWTV0HDYAyrec
 M0OhM8ZIAV+Wa5L3TkEVRO+XYRE4zL/SymMzmkFsgZSgq102r8cJwtJZSHP73Rc2A0UP
 6cmmKPQwUJTg9HA78X9A73jGlZ1IUNVqshEwjsFHnsZvaTaYXUYurZi7iUjG6eNchOrk
 Gk8NVS39X9rbg2egrPxATPCUcUvpdHoACsYIc95QjqZXA74trPzlTnD08iCSGvudI07A
 RU/CxA6UIQDAeFiv3AdEyRG7cfMLKjGSheD9MyAoQUIQw4AL0cVPtNlEEVj28h6Uy0LI
 xhXA==
X-Gm-Message-State: AOJu0Yy47eSJ2fbI6U7Z2TPU/qvSm61RcpZz/YtOM5pFJ5kMs40f3A7Q
 BcrTrG3rq383V2AZj9YScAjghtNJuRGS19PgKYmijtKq4w/LmwrR7Gf861tk6i8PcFI=
X-Gm-Gg: Acq92OGQlbdQNHC7Bn0g180aXVfg0cCQA3RawfJai3t4lrM0qqfiCeEeSlThwBRNFbg
 xwfT/+kWhQP8rjAY4hgZPavmFA/DDfpLkcFZCd+bcR9Zd0L+zmzvWVhom+z3ljjibGdHrJ9GBwZ
 cSC6UMq3mC5IFYcc2CLVxFjHI/rgmyzNf5wTAD4WeKnP3Sx7qVRf8/IMJCmNpM1YUYYFXDVru0Q
 q9kNnA+pP34YPh+iMHnvQbmeEspn09DFyf9kzyD2V0yZ1ibyO+aXFNvJ2kd21x0Q3pfwz9a4WUt
 AAcwdL6NJ/tdF7N2Oi5z6Z5aJfEiGJuGAUDAoVHdEmHdprRXISNltH5iAaPYVVNyHVPbeF9QPi+
 vzjsbt1MTxQQEn9t7E5PZHbIPgo2xmUTmU9854MGo/SgK7uZFrZvNgZLfMNGSAoMLpflCxeeBMn
 4j8STPLtkcdm5M3mwfjgAuzEs3orKC
X-Received: by 2002:a05:622a:5a9b:b0:50f:d5c0:7f38 with SMTP id
 d75a77b69052e-5165a0ccb68mr52159981cf.34.1778853748236; 
 Fri, 15 May 2026 07:02:28 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516457d630csm43545051cf.14.2026.05.15.07.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:02:27 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/3] drm/panthor: Use trace_call__##name() at guarded
 tracepoint call sites
Date: Fri, 15 May 2026 10:02:14 -0400
Message-ID: <20260515140214.2239486-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
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

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/gpu/drm/panthor/panthor_fw.c  | 4 ++--
 drivers/gpu/drm/panthor/panthor_gpu.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 8886002e1d31..601d464b312c 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1080,10 +1080,10 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
 
 	panthor_sched_report_fw_events(ptdev, status);
 
-	if (tracepoint_enabled(gpu_job_irq) && start) {
+	if (start) {
 		if (check_sub_overflow(ktime_get_ns(), start, &duration))
 			duration = U32_MAX;
-		trace_gpu_job_irq(ptdev->base.dev, status, duration);
+		trace_call__gpu_job_irq(ptdev->base.dev, status, duration);
 	}
 }
 PANTHOR_IRQ_HANDLER(job, JOB, panthor_job_irq_handler);
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 2ab444ee8c71..b19754d7093c 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -87,10 +87,10 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 	gpu_write(ptdev, GPU_INT_CLEAR, status);
 
 	if (tracepoint_enabled(gpu_power_status) && (status & GPU_POWER_INTERRUPTS_MASK))
-		trace_gpu_power_status(ptdev->base.dev,
-				       gpu_read64(ptdev, SHADER_READY),
-				       gpu_read64(ptdev, TILER_READY),
-				       gpu_read64(ptdev, L2_READY));
+		trace_call__gpu_power_status(ptdev->base.dev,
+					     gpu_read64(ptdev, SHADER_READY),
+					     gpu_read64(ptdev, TILER_READY),
+					     gpu_read64(ptdev, L2_READY));
 
 	if (status & GPU_IRQ_FAULT) {
 		u32 fault_status = gpu_read(ptdev, GPU_FAULT_STATUS);
-- 
2.54.0

