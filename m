Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84A1C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA42A10F261;
	Thu, 13 Aug 2026 09:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aSy/uvJx";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE1310E49D
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 02:30:31 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cbed97fa26fso396153a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786588231; x=1787193031; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ldz6DL8CjhzOSVRnFSPcYSPJn9r/HSeMGQbHfgC9q48=;
 b=aSy/uvJx3SAJ/VgrNF+8crs7q/uUELh4CpvI+Q/aoF1/j/Ou7ugGq/sZ5seD1D9HdA
 ERB+Zpz13iIwmWrYyJnmqpNt630aK0x23WQ28HxfwRgfud86CQpVhzolQF5jXQ7PlStr
 nCOEA6t/0rkQHXBydGeOjSzjyPRgPKzuC8RCPfPkCMBnSs7sr0JYaLR491vFLjGuk2sP
 eYltoiBXMfPgjZYd5UOkyu3Ha2XSqH2H/D+k+jWBClHw3+623NtbAx8McvRkxJB6WNxh
 MUFC68+BAGvcZMSREtkPOnp9PXMu77KmFzSMlfDE+I3IA32jU8Me76oq9/yYAucggNbg
 QSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786588231; x=1787193031;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ldz6DL8CjhzOSVRnFSPcYSPJn9r/HSeMGQbHfgC9q48=;
 b=sb/yPbwbJ8xrsVc/ez8/0FtsnLZwRFV8v4vKwJdL5UR5W85f+xwguiWUt/NWQ7oaue
 Z0c65K4UxpjzvWVGv5Nr3VYenQDbW84l99QsEMM46VNkqWN2BoXtTlfLEgratastqRjC
 GMzDjeTCchgNECkeUaA2h5SEXptIt+lMi6PYBN6NmdCsB//udDo1b2IXv8CKlvGSU5GI
 MCULYNHECe500skI+HgEFv76sUoRPof8gciDGwHw45Ncb2SR/HJgiH86Udk3SKy8ALD4
 SS5NW6WzcYlTjdYW8YFVBVmXzXZrnvhtIkDyUR1E/9hSGWv7JKU6LgDNcQoVpXiGqgdt
 Hipg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8iLomg6BO6Ugvfld3ZjFjNITyth147/HHB5nlyYrHOe1WUq+7nIGaYwieOaT1JwNS9FUXEDIygSI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw48LBj1KoTJ6zFVJfz6FzOkguQX7bNKrcsIZ34dK8KMvxZ4lDu
 PqWo5V8PnJa2RInQbuPpSzU7vIL4b5IsemDl7wBKYrJbZYHi4SZk9KR9
X-Gm-Gg: AR+sD13K1dqKytAxHXOz9QanYnG7f45Bw/atFlV4/ED92Bzqw1hy1DsnYDk+Nh9IFok
 U3/u4PFoSFP6IHRzyxXZuf6BgYQSWv03hxWoIH6lKWLdaLRxOV4rQZ7CcTCH/ZKs1pwJflI+uJL
 QVLNkCI+RNtZ2kq6yf0A0N8jIKJsfD0mQ7HMOYQrlJKAdIUKH3NiNFm4OeRAgugLRUa4HpSy4DS
 HfGgePQqMSR3clWbvs6vht4t5beQxp0OPc6yYZGTkfiJGdAQQ9Jlm8RTYEJYq8vNAt8a7NQb7Va
 b4Y0xRbjdAdavR05DeEIuitj4Mmf419epyoumv0+r93cHHwCS1MHUTO0iHYPTFOzDUE4+++x5Rq
 tD5+DpMb1wn6uXoghOKu4hWEQ0e5Pjf0JpUttgU4V7wqOPILkFFBoczirRm1ctdUzOdzmaARMsz
 tpgZbg5csSlibi+kOvaMrRQWr8beRIqHcJKIe4dR53u5jMHBvdyceb2grjUdl1Eh6bjVC2ZyAPr
 lE2T3QJbHm7p4uNd5F5Sjnkm4dpn5//A5pUxGxVtdi67lwwUjKqwUPE
X-Received: by 2002:a05:6a20:244e:b0:3a2:c9a1:2c26 with SMTP id
 adf61e73a8af0-3cc57372d8bmr2480871637.7.1786588230599; 
 Wed, 12 Aug 2026 19:30:30 -0700 (PDT)
Received: from lord.bigscale.net ([170.246.208.200])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebf731f95sm1950053eec.15.2026.08.12.19.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 19:30:30 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com,
 stuart.summers@intel.com, julia.filipchuk@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v2 0/3] drm/xe: fix GuC TLB invalidation ack stalls on ARL
 (Wa_22016122933)
Date: Wed, 12 Aug 2026 23:30:13 -0300
Message-ID: <20260813023016.805573-1-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

Hi,

v2 of the TLB invalidation ack stall series for ARL, tracked in:

  https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678

The investigation concluded since v1: the GuC always replied in time.
The CPU was reading a stale cache line of the G2H CTB - the GT1 caching
bug that i915 works around as Wa_22016122933 and xe never inherited.
Thanks Daniele for spotting the GT1 pattern in the GuC logs and
suggesting the test, and Matt for the review and the guidance to mirror
the i915 workaround.

Patch 3 is new and is the actual fix: Wa_22016122933 for xe, scoped
like i915 (media GT on media version 13.00) and covering the GuC-shared
allocations the CPU reads from.

Validation of patch 3 on two ARL machines (7d51 and 7dd1): before,
20-60 ack stalls/day, every day, for weeks, on two GuC firmware
versions; after, zero stalls across 6+ days combined and >5M TLB
invalidations. The 7dd1 machine, which could not survive a day of media
workloads on xe without a platform freeze, ran 34h+ continuously
including video transcoding with zero incidents.

Patches 1-2 are the diagnostics that made the investigation possible,
updated per Matt's v1 review.

v1 -> v2:
- Dropped the "kick" workaround (RFC patch 3): obsolete now that the
  root cause is fixed by Wa_22016122933.
- Patch 1: unified with the existing devcoredump path -
  __xe_devcoredump() taking a GT plus nullable q/job, with
  xe_devcoredump()/xe_devcoredump_gt() wrapper macros (Matt).
- Patch 2: record the first timed out seqno instead of the last one,
  and use xe_warn() (Matt).
- New patch 3: implement Wa_22016122933.

Based on today's drm-tip. 

Thanks,
Tales

Tales A. Mendonça (3):
  drm/xe: Capture devcoredump on TLB invalidation timeout
  drm/xe: Log when a timed out TLB invalidation ack finally arrives
  drm/xe: Implement Wa_22016122933

 drivers/gpu/drm/xe/xe_devcoredump.c     | 46 ++++++++++++++-----------
 drivers/gpu/drm/xe/xe_devcoredump.h     | 15 +++++---
 drivers/gpu/drm/xe/xe_guc.c             | 16 +++++++++
 drivers/gpu/drm/xe/xe_guc.h             |  2 ++
 drivers/gpu/drm/xe/xe_guc_ads.c         |  3 +-
 drivers/gpu/drm/xe/xe_guc_ct.c          |  6 ++--
 drivers/gpu/drm/xe/xe_guc_log.c         |  7 ++--
 drivers/gpu/drm/xe/xe_guc_pc.c          |  3 +-
 drivers/gpu/drm/xe/xe_tlb_inval.c       | 39 +++++++++++++++++++++
 drivers/gpu/drm/xe/xe_tlb_inval_types.h | 17 +++++++++
 drivers/gpu/drm/xe/xe_wa_oob.rules      |  1 +
 11 files changed, 124 insertions(+), 31 deletions(-)

-- 
2.55.0

