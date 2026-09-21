Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A358CC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 108A410E010;
	Mon, 21 Sep 2026 21:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bbdLrFGq";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB12410E5CD
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 21:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=jxJF3fS5c8FFBcAG4E5WFTTUrHSp3009n8pVxYWxBYo=; b=bbdLrFGqihBB8lsW7HAabvqGcG
 c0fEEb1cYpaTNg0/OSaXmpyIbn5NGrrBG/6jG1WGFL72Og4BgZG31f9sAlraVEBUe3h4uD51ZNmx2
 BEqErbv7t1G7l17DYTrm5vDsBVtAsMeP7IRFBmrFaxG+/Rg5cFlLoIqvK6J79t6SlM1UP7lrrRZZd
 vQDBW7SvIhO/hi9/LVSdYChgjUZUKyJKMnsA8D4afybfBX3JgrdoNqmby5fqzYpCJzJoHSuoLDz0d
 JhMR1z4e/AEN3zCQoxiQQFL1+KeNzcy9odRHVZuOXYn2o8848ZxohoIaBu8psE75BLQmJCh42MMUW
 GJBZsqvQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x8lVF-005Iwu-J9; Mon, 21 Sep 2026 23:24:45 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/2] drm/v3d: Skip perfmon serialization when it cannot be
 observed
Date: Mon, 21 Sep 2026 18:24:30 -0300
Message-Id: <20260921-v3d-quick-exit-perfmon-serialize-v1-0-e58aea1075e2@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQqDMBBG4avIrB3QlKrxKuIixN92UKMmVqTi3
 Zu6fJvvnRTgBYHq5CSPXYLMLkaeJmTfxr3A0sUmlaki0yrn/dHx+hE7MA7ZeIHvp9nxnzGjfME
 aGpWFsc+qpMgsHr0c96Jpr+sH3r43DXIAAAA=
X-Change-ID: 20260921-v3d-quick-exit-perfmon-serialize-9e9e8ceac587
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=zLKjzznR0xj/cbaWObIrL0XLDtZEhh+U379U/nBTCvI=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqsaCYgaYIzFkD8kvWzcbWNDMxFvWIkyvms5IES
 SjxAkA6wNWJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCarGgmAAKCRA/8w6Kdoj6
 qqKzB/0eOWQOs0vRhmKmqYw8HOuVtUcaAi6UAwJINOHzMctwqDgtOspCDl69NTIqd7wBsdP10Pr
 0KtWUVJM1DzNEEsT8PJ3G9qSZ7QjH7/0BzUVYNT3iO05UCLeT1nBKKBw1RFZC0pdSUStejFbbtv
 HvcZiBUkQ3wx9yun5/GfIHRgc4CK1uFEQ4ls0c5GHGWwizmRT/yBSQ80nnZY1nGH5tNIUL0zFRT
 zNuMaLAOqNNFfxbG9CXVHRdFTTN4GNjmvDDp0AKPNlPcqRraWFNWME3aU2z/ZfI/rU8LkQtXn45
 20UZIH5SMxh4WhqgsPS/HnP0gSYPp47U1RpNgANtltH5cMnE
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

The V3D core has a single set of performance counters. So that a perfmon
only counts the jobs it is attached to, a job carrying a non-global
perfmon waits for every job still in flight, and while it is in flight
every later job waits for it. Knowing what is in flight requires every
job to merge its finished fence into a per-queue accumulator.

That accumulator is maintained unconditionally, so a client pays a fence
merge on every job even when no dependency can ever be built out of it.
This series turns the bookkeeping off in the two cases where that holds:

  1. No perfmon is alive on the device, which is the common case since
     perfmons only exist while userspace runs a performance query;

  2. A global perfmon is set and the job carries no perfmon of its own.
     A global perfmon counts concurrent activity from every job, so
     nothing has to wait. Jobs carrying their own perfmon stay tracked,
     since the global perfmon may be cleared before they run and only
     one of them can be programmed in the HW at a time.

Both share the same trade-off: a job that goes unrecorded never carries a
perfmon, so the only cost is that the first job measured after tracking
resumes may overlap it. Considering the use cases of performance monitors
and that it will only affect the first job, it's a reasonable compromise
to make for the average case.

Best regards,
- Maíra

---
Maíra Canal (2):
      drm/v3d: Skip perfmon serialization while the device has no perfmon
      drm/v3d: Skip perfmon serialization while a global perfmon is set

 drivers/gpu/drm/v3d/v3d_drv.h     |  7 +++++++
 drivers/gpu/drm/v3d/v3d_perfmon.c |  8 ++++++--
 drivers/gpu/drm/v3d/v3d_submit.c  | 19 ++++++++++++-------
 3 files changed, 25 insertions(+), 9 deletions(-)
---
base-commit: 402491eefc5ea9a40e19b08dccf0c045aec4efc2
change-id: 20260921-v3d-quick-exit-perfmon-serialize-9e9e8ceac587

