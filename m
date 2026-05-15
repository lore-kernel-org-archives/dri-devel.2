Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7536CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 15:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F4D10F55C;
	Fri, 15 May 2026 15:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bV+zbh7j";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1902610F562
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 15:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3ChAEMRW5MjabdeAsL1szOBn2HKqRAx7Wt4ipZjen9k=; b=bV+zbh7jIJdCKDPjxaxsQPksxx
 EAhe9cIHNJsdXhP0L1usNegE4cYydG9IGteQGDC075e9AmQnRpUWhF4VcJrB9KmevTPPEY0sjAa0c
 KlksBjNs4wONmTnwq4dYkzotY5ORrb9jj51zA5CtqCJUqDmAtZgTyKMr5nb2+HQ+rgwZKkHzyiYcf
 p1dDyPw+SZV1Qt4STvAUVuhXGFkUGzo1ZjxiOqFxvb295ys2J7MTM5lV/Q+sM7GjHiIdQHkIAsETy
 knvd/vpVH4jnkNyMpQ8Dy/Z1Xm3lT/0XyNtfvMgMC1Xs3Ab/13EZAlvTqCGhI3kP6EMMyl5myNfKH
 w6FTlPvA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wNu9F-000ZQ7-HG; Fri, 15 May 2026 17:08:21 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/2] drm/v3d: Fix CPU job teardown bugs
Date: Fri, 15 May 2026 12:07:13 -0300
Message-Id: <20260515-v3d-cpu-job-leaks-v1-0-7f147cbbf935@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBuYjFx0lWhhNtZUVChJIN49a
 fkW/ycI7IUD9FUCz1GCXGdBU1dgV3MujDIXgyKlqWs6jO2M9n5wuyY82OwBSVtNThmnSEPpbs9
 O3v85jDl/G1H+aWMAAAA=
X-Change-ID: 20260515-v3d-cpu-job-leaks-06c60f2af206
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=FoiGqwIJW2qUEcyklHLnhaFbkPH+GGy0ncXoXM2ceKw=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqBzam1/5hLcbld14kuoWv++mnOq6QbnmjhT5zJ
 TuD9IBFb7yJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagc2pgAKCRA/8w6Kdoj6
 qqF8CACaMCWyLfCL43tS0cZwb0sLLOn1TXkGeF94EsSNgaUCRcW/TNtQFpTDTHlZ9t3oxRiPLfz
 Ww0UCX9jIV7Hi6SuTV1nhdA28W7BeYF6ES+gihGbeFuMLpGap/XL0OXfuLB+So6KtuPHq5bzG6K
 t2a3mXwB+U1afi2t6Cvc6P9fbAh31XOWmVboSzCtGxKepoWhjovFdVdOKlBTOgTItpRfpy+bg+x
 dLgX3wT+6NMt5b8UX8UmMnzhD931MxZ5iIktBFf55PBJtPZZGsYsG6kg4yRs2zqwQJ4hC5be/nX
 TCII9aBW1vksq+nhqNwc9Xo9NubDiRNKuw0cPcwyOywAV79M
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

This series addresses two independent teardown bugs in V3D's CPU job
submission path:

 - PATCH 1: A use-after-free on the ioctl's fail label, where the timestamp
   and performance query arrays are freed through cpu_job after
   v3d_job_cleanup() has already released the job. It consolidates the CPU
   job teardown into the job's kref destructor so a single code path covers
   both the scheduler .free_job and ioctl error paths.

 - PATCH 2: A GEM reference leak on indirect CSD jobs: the extra reference
   taken by v3d_get_cpu_indirect_csd_params() is never released. It adds
   the missing drop in v3d_cpu_job_free().

Claude was the one that identified these teardown bugs, although the fixes
were written by myself. Therefore, an Assisted-by tag was added to the
patches in conformance with the AI Coding Assistants [0] policy.

[0] https://docs.kernel.org/process/coding-assistants.html

Best regards,
- Maíra

---
Maíra Canal (2):
      drm/v3d: Fix use-after-free of CPU job query arrays on error path
      drm/v3d: Release indirect CSD GEM reference on CPU job free

 drivers/gpu/drm/v3d/v3d_sched.c  | 16 +---------------
 drivers/gpu/drm/v3d/v3d_submit.c | 22 +++++++++++++++++++---
 2 files changed, 20 insertions(+), 18 deletions(-)
---
base-commit: 0a9c56dd387605d17dabeedd9fdd2c4c1d0bab7b
change-id: 20260515-v3d-cpu-job-leaks-06c60f2af206

