Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A1BC79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 12:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C7310E05E;
	Thu, 10 Sep 2026 12:16:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z9bed7aW";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88CFD10E05E
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 12:16:11 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d6f9e2f681so79570695ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789042571; x=1789647371; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z2qTN47DytVlrGBOGC1ZcAmYzr5IdVvI8pSq4pv9E3g=;
 b=Z9bed7aW4bIVcI2xmNdU9xvaKvd+QnhLkCy517CrfwCvPZSGZC4gmIUdv3ZY1uIPvx
 lrElXchUQGflN8JWpkk+8PGvFpsxRJ4acCceX4Ol3Qc3v9hFpw4eu/Xv1q2V16X9WgFj
 bdBtD4eFD4RAnq7+Q4fieU72wzqhiJuTZsLDl4ws63SkFeXtWoAysrRvJyI12T8oKQA/
 rmt+eOws+fC2RqRB4dvsu9azymHPJ+S85tVPVjSGyX8Le+37VJlxxkZTnSNlhbtghdFN
 2ByvSobuRAduxZVS7WtyDYZnC3wvfNEAR54GTeFCon1DnlCDFo0l3/Hgpr+57Xj10+3V
 q0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789042571; x=1789647371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z2qTN47DytVlrGBOGC1ZcAmYzr5IdVvI8pSq4pv9E3g=;
 b=X0TVauTLeTxa9HJ3Nu1L/xMGE41bEYz+qzGRDZyq9GlXog1+n0zaHU3jTuFLoZjkD2
 4coiOWWmXJoV6HVeGJBRFuxcedjutIONsKWVl4OcWSrAPDKUS7fqpauuaNKh8nDlINHs
 sszdjt9BopWUk+o2XGeI2z0Y5+KHvvVWtMZnSQYFjm/bZYygHa/jgYdoMKyP2uGebX2v
 t+9jfBA4BTglOlsMtxSsubzBTh5drBKG/RIwMGoDe7FK2M5Sb2+Hk3rV0A5rotTIuCix
 qQLa6DE5r2Wy1RNkp3UkoaGT1QYnIh9tLZ6EyDcRjdQY836q2DFbMA85kfDnv/e24F5M
 YQhA==
X-Forwarded-Encrypted: i=1;
 AKwUvByhsR+y5W6kbsWl+UEEpugE5EbrbKhoFSNGbILEk+7lUB5diOGglcgtkOCVfgelqO3ImhqIUjDI6cI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mAGr2cRpkxIj5GGRQvpUahh8FEYHGMr4B8C+Zp2plp55Xe+j9d
 XF3jsM6L0BPEeBSeNWmrizPcLOS7u8yelBH558e4kmBC1rL3KNw0lKI=
X-Gm-Gg: AYBFou2KfPeNl9WhBX204RJ3m3oH/msoCnqCHnxE84fUcRZyOCWWScvgJddzBSLWFhH
 gyvwRGZyUS47OVMewEwM4pRy7IvwUZx2njP2mmGFo1JThF0QHj3aQUW5NKiePZsrXhRsmCG0kqU
 M3UYVIHBGtYKESf5iI3yGCr9SPmnphJvfbWoily6fXzf9xcuoJWLRcli7m8fzf3PT8myJHQw0hX
 zFICw2mo+I0wC+d5bX4JOVu84hAQDlrEGV379fjrPg4aDUjqfUtQiQToxk7M825sGAKte+ZPt0m
 fpcznnq2FoYzY1rjupdVaVwv1mmCjeO2rqhVu696jXxli98bbLA9D5u0MWb5Fi36RXzD+hba4fH
 OfpnyCzIkzRIlf3MHqzjQBoS3GYqQKzj5EPoJthdgIBnNxJR8hNbRVEp+EEknx0nZHW9VrVcXYP
 3M/mCDNq3Y8VAW+eCDbNCGcFAhtq3V0oaxg3J1wE1xDWFIfiqnAq1c0lyo+weLp47hMKBYL8PjV
 z9/PId3dosgdy+Uglf7frjEKg==
X-Received: by 2002:a17:903:3c47:b0:2db:eb5:47ea with SMTP id
 d9443c01a7336-2db12106896mr612699565ad.0.1789042570833; 
 Thu, 10 Sep 2026 05:16:10 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA
 ([2001:2d8:7f04:fd2a:f01d:1dc7:1e5:47d8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db14841054sm88647225ad.3.2026.09.10.05.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 05:16:08 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luben Tuikov <ltuikov89@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, donggeunyoo.kernel@gmail.com
Subject: [PATCH] drm/sched: Free the run queues at the end of drm_sched_fini()
Date: Thu, 10 Sep 2026 21:16:01 +0900
Message-ID: <20260910121601.805032-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
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

drm_sched_fini() frees the run queues at the top of teardown but the array
holding them at the bottom. The early half is on the wrong side of
cancel_delayed_work_sync(&sched->work_tdr), which waits for a timeout
handler that can still walk sched->sched_rq[i] through
drm_sched_increase_karma().

No correct driver can be there, since every fence returned from run_job()
must be signaled before drm_sched_fini() is called. Free the entries next
to the array anyway, so run-queue teardown happens in one place.

Link: https://lore.kernel.org/dri-devel/20260910054605.634135-1-donggeunyoo.kernel@gmail.com/
Assisted-by: Claude:claude-fable-5
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Targets drm-misc-next (0878e6053d01).

A cleanup - no Fixes:, no Cc: stable.

The KUnit case and how to run it:
https://github.com/donggeunyoo/drm-sched-fini-uaf-repro

x86_64 under QEMU, KUNIT + KASAN + lockdep, whole drm_sched suite, three
runs per arm:

  before  38-41 KASAN slab-use-after-free reports, all from
          drm_sched_increase_karma() on the timeout worker
  after   0

 drivers/gpu/drm/scheduler/sched_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 6cb6f9546493..fec04c944c5e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1210,9 +1210,6 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
 
 	drm_sched_wqueue_stop(sched);
 
-	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++)
-		kfree(sched->sched_rq[i]);
-
 	/* Wakeup everyone stuck in drm_sched_entity_flush for this scheduler */
 	wake_up_all(&sched->job_scheduled);
 
@@ -1226,6 +1223,9 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
 	if (sched->own_submit_wq)
 		destroy_workqueue(sched->submit_wq);
 	sched->ready = false;
+
+	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++)
+		kfree(sched->sched_rq[i]);
 	kfree(sched->sched_rq);
 	sched->sched_rq = NULL;
 
-- 
2.53.0

