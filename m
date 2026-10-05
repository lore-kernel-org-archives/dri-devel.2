Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04386CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 00:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCF310E1B6;
	Mon,  5 Oct 2026 00:03:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TPO/vTzL";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9760010E1B6
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 00:03:36 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2dd76b1361dso6879285ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 17:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791158616; x=1791763416; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dF19qIW2ffUCh6VD/Ae53xb47tJQQbelYm7eZnXY8lI=;
 b=TPO/vTzL6i2kE5ExNYvMr0OjhNroM3yO2tQChgsRm4PNDVUZ//gPg+rDdDn0ZOKRhC
 MQHli/t75X7jl9QP/CtHqE+5PyKowr8ECm8wnqB594G5sPCBCVZgbifGvmbR2H49n0Es
 HlW7oPCyNrIMquym2npDfm2BC/x3XeRGb7fak7IWf9aOYRN1uhM+68U0Hlzsv7SeBpbZ
 29wOj58NBToVk4hebyI8z3wPL8afBn7bmB1DWSVy1XQTZEdHMglCivrYC3LdwhQkjXmL
 xmCVw000cR3LLycILThLTVPyt2F1DLuJw8/j6a4NXkAYWRmUtJKRwyrv39ub3Q4f2Zuz
 WdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791158616; x=1791763416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dF19qIW2ffUCh6VD/Ae53xb47tJQQbelYm7eZnXY8lI=;
 b=V6AWmJdmcytPPWL144lKdLsN82fxWhG/9aIXt0YFep3YHb0YDUNqEVieKrgA01ibs7
 FKcFtolmDX77DRYchgbCmhpGhPV+0wkr1G+gauqJerPz+KANsBFHHRHZSmFF+qK9Tb85
 4rcEy6iKex4no1WpKX+L6a0QyuSHk+VrtM84FtIeahDrgmqXNvFr+Fd6uuCK3ToYl6L4
 AWyXonzn3UXCrX3ouF3X0HMP00mY1xBj4zN56SbsOm4g5NM/DfzexE4S5d4KUCKEicUP
 HGQeadCCcJj+6+ZJPHP4uESqr644P28AcJphoOPx54i/pRywEH9tMb57IGgS7l+Bye5Q
 kx+g==
X-Gm-Message-State: AFq9FYKGs3uNQC3agj7wEwmVb/TXTek0L+CxG8XJy9BF1vzWEUPN8oR3
 w/GFtnJtInrb7AxCa54ReGFJ73oPAf91cRkLvSTCXEFXeLHMgbpnufoqPf6urzS69XY=
X-Gm-Gg: AYBFou1zxkThV9TdJCoXfUaKu/5qITIS26qf1WZD7KRejXqfOxcJSTXH23zTmHcYyeC
 rWJLnkqW09BLsnbQL66BtmKdf1+Cg8eed/2oDiHAUU047HuqD5280fjApZ3FWtNQt+uczrQIByV
 13CbC67+CkHEGv0gkcFs8GJNnqW+2XMxI4Sd1HDByGlWFpqgvQ3mF2d9zHxCCpfAXR3ZV+UUJhA
 6qB1IqSTqljnenxjwrhtRMS5H8OfEvm6VoftSJzj+H8oQdlUdV7LVzG+9DU75QsrHkyv1n4LqJ3
 Dajg6ofmhPddP80fhUhqVSDcKwupq5FYJuQzbk9wLuc7II5sudIPSZ65pKrCjhtIDFyG3Kxm1IX
 UpS1BxP3TWaJ381M0J82kWl6vRItIgYxRqm8K98OV9s3GTn1iN5f1vqJXa3ioVAl1Jdx6shrc+J
 Oqjv+MbR3IjvEbt3Ff4hNfX6yFdoY+nnlU1g326dypbxihDhbfDgZ4isMWTbbozlcE8XCWzLw82
 17BdaiQR56pFQCTJWExQyJn/6SUAxjzgAqF5Qm/5ISDTwTiDOXJW8vbru/jiMbVddxXbxqZoPTK
 AkY0EhHNEDaQoTMR7ZOVXmgH6HmXOHSsMPCg8uhSIEIH/PZW
X-Received: by 2002:a17:903:2f84:b0:2bf:7b62:a038 with SMTP id
 d9443c01a7336-2e4ea1bed43mr51060855ad.9.1791158615905; 
 Sun, 04 Oct 2026 17:03:35 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6aea97sm27019735ad.45.2026.10.04.17.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 17:03:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/panthor: fix kernel-doc for nested struct members
Date: Sun,  4 Oct 2026 17:03:30 -0700
Message-ID: <20261005000330.561623-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The kernel-doc comments for members of nested structs in panthor use
the bare member names, which kernel-doc reports as excess members of
the outer struct, for example:

  panthor_fw.c:143 Excess struct member 'start' description in 'panthor_fw_binary_section_entry_hdr' (did you mean one of: 'va.start', 'data.start')
  panthor_device.h:338 Excess struct member 'core' description in 'panthor_device' (did you mean one of: 'clks.core', 'clks.coregroup', 'coherent')

Prefix the member names with the enclosing member, as kernel-doc
suggests, in panthor_fw.c and panthor_device.h. In panthor_gem.h, the
label lock is documented as @lock.str instead of @label.lock; fix that
too. While at it, fix a typo in the @data.buf description.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_device.h | 30 ++++++++++++------------
 drivers/gpu/drm/panthor/panthor_fw.c     | 14 +++++------
 drivers/gpu/drm/panthor/panthor_gem.h    |  2 +-
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b55a3f9edd41..7fbb95af3244 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -146,13 +146,13 @@ struct panthor_device {
 
 	/** @clks: GPU clocks. */
 	struct {
-		/** @core: Core clock. */
+		/** @clks.core: Core clock. */
 		struct clk *core;
 
-		/** @stacks: Stacks clock. This clock is optional. */
+		/** @clks.stacks: Stacks clock. This clock is optional. */
 		struct clk *stacks;
 
-		/** @coregroup: Core group clock. This clock is optional. */
+		/** @clks.coregroup: Core group clock. This clock is optional. */
 		struct clk *coregroup;
 	} clks;
 
@@ -260,11 +260,11 @@ struct panthor_device {
 
 	/** @unplug: Device unplug related fields. */
 	struct {
-		/** @lock: Lock used to serialize unplug operations. */
+		/** @unplug.lock: Lock used to serialize unplug operations. */
 		struct mutex lock;
 
 		/**
-		 * @done: Completion object signaled when the unplug
+		 * @unplug.done: Completion object signaled when the unplug
 		 * operation is done.
 		 */
 		struct completion done;
@@ -272,17 +272,17 @@ struct panthor_device {
 
 	/** @reset: Reset related fields. */
 	struct {
-		/** @wq: Ordered worqueud used to schedule reset operations. */
+		/** @reset.wq: Ordered worqueud used to schedule reset operations. */
 		struct workqueue_struct *wq;
 
-		/** @work: Reset work. */
+		/** @reset.work: Reset work. */
 		struct work_struct work;
 
-		/** @pending: Set to true if a reset is pending. */
+		/** @reset.pending: Set to true if a reset is pending. */
 		atomic_t pending;
 
 		/**
-		 * @fast: True if the post_reset logic can proceed with a fast reset.
+		 * @reset.fast: True if the post_reset logic can proceed with a fast reset.
 		 *
 		 * A fast reset is just a reset where the driver doesn't reload the FW sections.
 		 *
@@ -295,11 +295,11 @@ struct panthor_device {
 
 	/** @pm: Power management related data. */
 	struct {
-		/** @state: Power state. */
+		/** @pm.state: Power state. */
 		atomic_t state;
 
 		/**
-		 * @mmio_lock: Lock protecting MMIO userspace CPU mappings.
+		 * @pm.mmio_lock: Lock protecting MMIO userspace CPU mappings.
 		 *
 		 * This is needed to ensure we map the dummy IO pages when
 		 * the device is being suspended, and the real IO pages when
@@ -309,14 +309,14 @@ struct panthor_device {
 		struct mutex mmio_lock;
 
 		/**
-		 * @dummy_latest_flush: Dummy LATEST_FLUSH page.
+		 * @pm.dummy_latest_flush: Dummy LATEST_FLUSH page.
 		 *
 		 * Used to replace the real LATEST_FLUSH page when the GPU
 		 * is suspended.
 		 */
 		struct page *dummy_latest_flush;
 
-		/** @recovery_needed: True when a resume attempt failed. */
+		/** @pm.recovery_needed: True when a resume attempt failed. */
 		atomic_t recovery_needed;
 	} pm;
 
@@ -332,7 +332,7 @@ struct panthor_device {
 		/** @gems.lock: Protects the device-wide list of GEM objects. */
 		struct mutex lock;
 
-		/** @node: Used to keep track of all the device's DRM objects */
+		/** @gems.node: Used to keep track of all the device's DRM objects */
 		struct list_head node;
 	} gems;
 #endif
@@ -353,7 +353,7 @@ struct panthor_file {
 	/** @user_mmio: User MMIO related fields. */
 	struct {
 		/**
-		 * @offset: Offset used for user MMIO mappings.
+		 * @user_mmio.offset: Offset used for user MMIO mappings.
 		 *
 		 * This offset should not be used to check the type of mapping
 		 * except in panthor_mmap(). After that point, MMIO mapping
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4f1fab66a13b..e2a0dbd79233 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -126,19 +126,19 @@ struct panthor_fw_binary_section_entry_hdr {
 
 	/** @va: MCU virtual range to map this binary section to. */
 	struct {
-		/** @start: Start address. */
+		/** @va.start: Start address. */
 		u32 start;
 
-		/** @end: End address. */
+		/** @va.end: End address. */
 		u32 end;
 	} va;
 
 	/** @data: Data to initialize the FW section with. */
 	struct {
-		/** @start: Start offset in the FW binary. */
+		/** @data.start: Start offset in the FW binary. */
 		u32 start;
 
-		/** @end: End offset in the FW binary. */
+		/** @data.end: End offset in the FW binary. */
 		u32 end;
 	} data;
 };
@@ -192,10 +192,10 @@ struct panthor_fw_section {
 	 * We keep data around so we can reload sections after a reset.
 	 */
 	struct {
-		/** @buf: Buffed used to store init data. */
+		/** @data.buf: Buffer used to store init data. */
 		const void *buf;
 
-		/** @size: Size of @buf in bytes. */
+		/** @data.size: Size of @data.buf in bytes. */
 		size_t size;
 	} data;
 };
@@ -251,7 +251,7 @@ struct panthor_fw {
 
 	/** @watchdog: Collection of fields relating to the FW watchdog. */
 	struct {
-		/** @ping_work: Delayed work used to ping the FW. */
+		/** @watchdog.ping_work: Delayed work used to ping the FW. */
 		struct delayed_work ping_work;
 	} watchdog;
 
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index 5ae37d0d3646..00ed3c46d026 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -207,7 +207,7 @@ struct panthor_gem_object {
 		 */
 		const char *str;
 
-		/** @lock.str: Protects access to the @label.str field. */
+		/** @label.lock: Protects access to the @label.str field. */
 		struct mutex lock;
 	} label;
 
-- 
2.56.0

