Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289B4C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450BF10ECD6;
	Tue,  1 Sep 2026 13:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EGsAXSXE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4633610ECF0
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788267811; x=1819803811;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Q6Qx68lTAXz2Os5wDBHdNW81pA3UYxxQOdQeKpc2SJ4=;
 b=EGsAXSXEEsnkjaMglPdT9GnwXe5J58F9YX+uANftoiLkzLeLa97uqt0m
 Nz2xmJaqcnfoPe2E/tJR7LXqLai1b3pIWGyP0BrVIn10uwNVgZZ4FW5nU
 X2oSmqiMn8rpQS7psyvizLySmBSSXPog9ViPBb5smaSv8pneUGwi5IH9/
 LKqDNxKpbKM7XMp819Ngh1XvexbCMA7y6MGvoUf3KdH/WVEkp2zhEuQ7S
 nIQMpE99jd+ALFODJQ5OdNUa8RLsD1Pqq2YbtszUXy4qRortysLz/gR5t
 sUANv/KmEjOnxhE1g64uLst2o8/oYC+/rn7FbcLw3qcbNChsUPRLcA0IJ Q==;
X-CSE-ConnectionGUID: UBvjcTTVTCWL5pHzJIqTAg==
X-CSE-MsgGUID: t0dSA1v2QaeBzzt5JONlvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88706256"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="88706256"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 06:03:31 -0700
X-CSE-ConnectionGUID: 0To7jvPwTJOJ9IIdd8TfoQ==
X-CSE-MsgGUID: J8mrclAOS7uZbJwyXAc2vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="271029674"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 06:03:29 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com
Subject: [PATCH v2 0/3] accel/ivpu: Harden parsing of firmware-shared buffers
Date: Tue,  1 Sep 2026 14:57:46 +0200
Message-ID: <20260901125749.404338-1-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-31
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

The IPC and firmware tracing buffers live in memory shared with the NPU
firmware, so every field the host reads from them is untrusted input.
This series fixes places where the host trusted such input and could
end up dereferencing addresses outside the underlying BO.

All patches are tagged for stable.

Changes since v1:
 - Added a new patch ("accel/ivpu: Limit firmware log name prints to
   field size") after Sashiko pointed out that log->name was still being
   printed with an unbounded "%s" conversion. The field is fixed-size
   and expected to be NUL-terminated, but a firmware bug could drop the
   terminator; harden the host against that case.
 - No changes to the other two patches.

Dawid Osuchowski (1):
  accel/ivpu: Limit firmware log name prints to field size

Magdalena Schulfer (2):
  accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr
  accel/ivpu: Validate firmware log buffer metadata

 drivers/accel/ivpu/ivpu_fw_log.c | 87 +++++++++++++++++++-------------
 drivers/accel/ivpu/ivpu_gem.h    | 14 +++--
 drivers/accel/ivpu/ivpu_ipc.c    |  7 +--
 3 files changed, 67 insertions(+), 41 deletions(-)

-- 
2.43.0

