Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655C6CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 13:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6FF110F4A4;
	Fri,  8 May 2026 13:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rT+LGN4r";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3628810F4A4
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TD63NL0rdsH/88RfhPlZtCVrKC7rD5HY6lMmP6yno4A=; b=rT+LGN4rDLoVlDbBuqRV4s/uJy
 IacNc2yLbX2Fs6wkFKax0wOKZ0gKjYlu2EVNcci8oo/nNGoHeYdJxd4g/RcMSss0ygIxbfkfaJ6Ry
 MJXldoVHZVvwujTjAJU+zwieZoQGOvJJ3l4k54of8C0scSH9ot2zYzmXP9Wa59aVAFatQDNCpSqD1
 jIjBWIZvfsZJRDaz/QulvQeAdB7huqTc2eTmd4VjVnwx4svlbTt+rZx98jiYZikCU98lgedMBn8Wj
 NkQ15tjeSe2ihEvhT5QEHG9TVfdsXW444BpkXUDz1aWTSaWWDvCSH+hZjG9+M37sWko/tJHm+HRmE
 idWFpEaA==;
Received: from [189.7.87.137] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wLLSU-007u6e-MD; Fri, 08 May 2026 15:41:38 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/2] drm/v3d: Fix perfmon locking and cross-queue isolation
Date: Fri, 08 May 2026 10:41:28 -0300
Message-Id: <20260508-v3d-perfmon-lifetime-v1-0-f5b5642c085f@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0XMywqDMBCF4VeRrDswMd7iqxQXmkzqQKM2sVIQ3
 72pLrr8D5xvF5ECUxRttotAG0eepxTylgkz9tODgG1qkWNeYYklbMrCQsH5eYInO1rZExSN0Za
 sRC0Hka5LIMefk713Vwd6vZO+XuMfb7OTLrA+6WhGsuA5GjgFqHJVK42yplK1m/zpQx8JzOw9r
 21mECtdN7JSzoruOL6lgSSg0gAAAA==
X-Change-ID: 20260505-v3d-perfmon-lifetime-48c9ded1091b
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3875; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=4DuxPtSbvcBD+ARjZ29j8HnxkHeFIvk0Q6KRB9r2n1w=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBp/egOpu0w8407whbP7/UFwAI1CwIemYfkvl8KA
 HwLSQRh8LuJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaf3oDgAKCRA/8w6Kdoj6
 qq7yB/4gLSRz1ngPXLWfEBvw541CN8sRPoG4LnHIHksrwU/Jh25oCar+6lAgcj3Hhf35uiJGLrR
 fp3vnpzW/eBb/8rPhrAQs0ol/ccGshOvcnNFfnuq0fO0pwaYaW2BdI8Ncx8vvI/LKSx/JHgkMCg
 I5Vmgb/IKqSZ4yHiINthb8zcEwiw0Xo6teFsoG3t0kVOXmKEWsuuwK3SA+eoDvbpumQ9lXZ5o+6
 CVY2H4U1lfvwErqv9oOb248+Gn8S+JHyoSbSh9Q9Y3CXWxT+gs1xM0LlSFi5yNuwCJDdZqhauuP
 uHJapXSKz1ienWYjBZVREZi59FqJFy7aFfzF/PwK/qL2wDVR
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

A v3d core is able to expose a single set of HW performance counters, so at
any moment at most one perfmon can be programmed in HW. Currently, the
driver tracks the active perfmon with v3d_dev->active_perfmon, but three
long-standing issues makes perfmon handling unreliable:

1. The active_perfmon pointer is accessed lock-free from scheduler
   callbacks, the GPU-reset path and the perfmon ioctls. Note that the
   v3d_perfmon->lock mutex serialized start/stop of one perfmon object
   against itself, but the invariant that needs protection is device-wide.

2. perfmon start/stop is hooked exclusively to run_job() callbacks via
   v3d_switch_perfmon(). If nothing is queued behind a perfmon-carrying
   job, the perfmon is never actually stopped.

3. A non-global perfmon should count events generated by a specific
   submission, but the scheduler can run jobs from different queues
   concurrently. Without explicit cross-queue serialization, an unrelated
   job running in parallel pollutes the counters and produces unusable
   results.

This series aims to address all three issues. PATCH 1 moves the locking to
where the invariant actually lives (fixing issue #1) and replaces the
sleeping mutex with a spinlock, which allows us to stop the perfmon from
the IRQ handler at job-completion time (the natural boundary for "active
perfmon follows the active job") and fixes issue #2.

PATCH 2 addresses issue #3 by building on the new locking to enforce
cross-queue serialization when a non-global perfmon is attached, by adding
scheduler fence dependencies during submission. The fence dependencies
allows us to enforce two rules:

1. A job that carries a non-global perfmon waits for every job currently
   in-flight across all HW queues to finish.

2. While such a job is in-flight, any subsequently submitted job waits
   for it.

This allows us to ensure cross-queue isolation and the reliability of
the performance counters values.

To make sure that this series actually produces the expected results and 
improves the overall reliability of v3d's performance monitors, this
series is accompanied by a IGT series [1] that adds new perfmon tests
for v3d.

This series depends on [2].

[1] https://lore.kernel.org/igt-dev/20260508124446.1260672-2-mcanal@igalia.com/T/
[2] https://lore.kernel.org/dri-devel/20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com/T/

Best regards,
- Maíra

---
Maíra Canal (2):
      drm/v3d: Refactor perfmon locking
      drm/v3d: Serialize jobs across queues when a perfmon is attached

 drivers/gpu/drm/v3d/v3d_drv.h     |  50 ++++++++++---
 drivers/gpu/drm/v3d/v3d_gem.c     |   6 +-
 drivers/gpu/drm/v3d/v3d_irq.c     |   6 ++
 drivers/gpu/drm/v3d/v3d_perfmon.c | 148 ++++++++++++++++++++++++++------------
 drivers/gpu/drm/v3d/v3d_power.c   |   4 ++
 drivers/gpu/drm/v3d/v3d_sched.c   |  24 +------
 drivers/gpu/drm/v3d/v3d_submit.c  |  90 ++++++++++++++++++++---
 7 files changed, 242 insertions(+), 86 deletions(-)
---
base-commit: c006978163fd001fbca55e5fa57bddcf49f47ad9
change-id: 20260505-v3d-perfmon-lifetime-48c9ded1091b
prerequisite-change-id: 20260407-v3d-sched-misc-fixes-623739017e53:v1
prerequisite-patch-id: 01823e165a822ddec72b0b18e49c096d35149e9a
prerequisite-patch-id: 1df1c11ec62617336e2ed5445c24bbb912570035
prerequisite-patch-id: 738852cd3115283b43cef336ba8fe88616f28a88
prerequisite-patch-id: 8614f719aa20e50a006ed6ce32133cdae287988d
prerequisite-patch-id: 32c804d9921bcf259b236b3f1d74f7972aec02f2
prerequisite-patch-id: 737306a958062699aa5c0ac34fb4dfebed9ec5bc
prerequisite-patch-id: dd4af1c51cf194a331814ba0ed997da19db633e3
prerequisite-patch-id: 62fbbb75f3d28b21ac3922dd36aec6e7721d2c55
prerequisite-patch-id: b5bd534295a27c8d4539bab81db0a4cfef4ea242
prerequisite-patch-id: 11274552d6ed495d712083c5dced8aa2886185d2

