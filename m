Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51B7CD98F8
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2175710EA7E;
	Thu, 18 Jun 2026 15:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pfQQ2yKd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4A110E7CA
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GjVWOzbpXbHK09Tz0/ORdoRGxK2v6ig13uXDOcr+awc=; b=pfQQ2yKdIbEGnsh3lAB3uFZw/z
 qaUMgbwXX5lov+ReuP44oftoCpaI5kRd18noifyKAxHqaseScBeh0DKfqhTnZCsDzLHGvuXnyyz4M
 0TPztRrCybG2JugqiuzYXHGNx8makS3wB8XhWIPYtBKjqoREUUgB9NnWuJdbCmBYtvHJxrgyZDenK
 /1+gH2JFQua5WWNvLOtHvIbWYXS0BoJeN/7NoK2H9yZ3yTbVwGyct0HCRo1wF3LyfvofVmV29cyH2
 zv3KtnFBRrvzQ5Z2lD8WLx8kyghO897VB63i4qhSoKWg0dMbi8jcyg6DFNbBir8MgD8Fjg1PGy8aX
 AceY1WbA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1waEH3-001vhd-6P; Thu, 18 Jun 2026 17:03:21 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 0/3] drm/v3d: Miscellaneous fixes
Date: Thu, 18 Jun 2026 12:03:12 -0300
Message-Id: <20260618-v3d-cpu-job-fixes-v2-0-fec132484fc4@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBBEf4Xs2TXbEgn15H8YDqVdYI1S0mqjI
 fy71Xj0+GbyZlZIHIUTHKsVImdJEuYCeleBm+w8MoovDJp0Qw0ZzLVHtzzwEnoc5MkJh541HVT
 PXFso3hL5WxTt3BWeJN1DfH0vsvqkvzVFf9ayQkLyxrWtaQ17d5LRXsXuXbhBt23bGxPx9LKzA
 AAA
X-Change-ID: 20260609-v3d-cpu-job-fixes-fbe2051bee3a
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1666; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=7qLJAHABBmpDal4dslwW2VuQb3j7HH4lPVqZzMc3NLo=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDFkmHNv0NK0zXlpts/Jb8oih+kxa8RyT+ZHVQpzFUwL8a
 iR4r5d0MhqzMDByMciKKbL8eBJbyyhWzq65rPwizCBWJpApDFycAjARwSz2f3p8LMXndnWm/mR5
 XHNP49Hd+2Wy5gdb1i9403VkwiLtINnKiRp3fmWYVM8N2rcs185b6pWt/V2PrnKxtyu82z2aRdQ
 FjsuudelR371lqkwcu03sC+O9pnYF/ZafvfRTNWJC5z7nXRK0503Loq3vGDW1aw3naa29fPvWHp
 tvHJdO/8lbu7cieTv31YemB2a1WkuIcpz1/d/bvFD+84qD9a8Zdmu6VjEns67xKbq7eAGny7Hl7
 7IX5P0U8q16anjL03mD4VvuHiupI3rXC55qZ/pbs769mNPrbmxQlB5U2Wyr0f3vVDJPN3v2NrXJ
 qgcX/JX86PzyEp9QwFOdD+LFon/r/H//7J/hy126S+4hAA==
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

Being brief, this small series collects a correctness fix (#1) reported by
Sashiko, a error-path fix (#2) reported by Sashiko, and a cleanup (#3)
found while reading the code.

The first patch is the only notable one: a v3d submission expands into a
chain of jobs (e.g. BIN + RENDER + CACHE CLEAN), but the BO list was only
ever attached to the last job. Since implicit synchronization is added
per-job and gated on job->bo_count, every job before the last one silently
skipped implicit dependencies. In practice the RENDER job could read a
buffer object while another context was still writing it. It's fixed by
looking up the BOs onto every job that references them.

Best regards,
- Maíra

To: Melissa Wen <mwen@igalia.com>
To: Iago Toral Quiroga <itoral@igalia.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com
Cc: dri-devel@lists.freedesktop.org

v1 -> v2: https://lore.kernel.org/r/20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com

- [1/3] Don't attach implicit dependencies to BIN jobs (Iago Toral)
- [2/3, 3/3] Add Iago's R-b (Iago Toral)

---
Maíra Canal (3):
      drm/v3d: Associate BOs with every job that accesses them
      drm/v3d: Reject invalid indirect BO handle in indirect CSD setup
      drm/v3d: Use write_to_buffer() helper in performance query copy

 drivers/gpu/drm/v3d/v3d_sched.c  | 11 ++---------
 drivers/gpu/drm/v3d/v3d_submit.c | 38 +++++++++++++++++++-------------------
 2 files changed, 21 insertions(+), 28 deletions(-)
---
base-commit: 98b46e693b912eef0e6d497327489113845cbd15
change-id: 20260609-v3d-cpu-job-fixes-fbe2051bee3a

