Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF404C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EDA110EF92;
	Thu, 27 Aug 2026 10:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NexwR6J2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8724810E648
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787826558; x=1819362558;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hn4fTThY7+TBPAOkxVrX0FadtaKzu5d/ZrEmTx+jJP4=;
 b=NexwR6J2AzVsxo1NflcWEwbsArBSmJyIEd1s9GdZmtp1YWWVCzY+ZO6N
 3rGZgAZikg5OgJb1M635jaU09S24xAlHMU60a2MChKuLSu1PH3GFE1QqX
 jaMrJnCt/Wx/wj5+Pkdk2Z0tyzjiybwzBDDeUxkVEB26rntgBnxwxSZtM
 NTYCeaElzAZPNUwX/pk4HaB6NBIYFu8EHzRlTQ13muAubK0SuzwY5ntAY
 UekG5WTNNmQCzLr3K/xNumDAg35CoaaQrrKHoQlhLbr28DQn/QkGwUZhu
 0S4aujUC7UXVBi3Q0OyuY0E8arHIGA+o5eTABeaXeUYgfxU0EB4pdbIqe Q==;
X-CSE-ConnectionGUID: pqcmzVBpQUKoslZP4lqkgQ==
X-CSE-MsgGUID: FHAFLPk5TFSExoXW4z9lTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="98920670"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="98920670"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:29:18 -0700
X-CSE-ConnectionGUID: Bj93LqTnRPydD0vSB9/bEw==
X-CSE-MsgGUID: XAIzQi9vRIaeASG2fyU0mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="261711606"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:29:16 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com,
 Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH 0/2] accel/ivpu: Harden parsing of firmware-shared buffers
Date: Thu, 27 Aug 2026 12:23:37 +0200
Message-ID: <20260827102339.281799-1-dawid.osuchowski@linux.intel.com>
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
This series fixes two places where the host trusted such input and could
end up dereferencing addresses outside the underlying BO.

Both patches are tagged for stable.

Magdalena Schulfer (2):
  accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr
  accel/ivpu: Validate firmware log buffer metadata

 drivers/accel/ivpu/ivpu_fw_log.c | 76 +++++++++++++++++++-------------
 drivers/accel/ivpu/ivpu_gem.h    | 14 ++++--
 drivers/accel/ivpu/ivpu_ipc.c    |  7 +--
 3 files changed, 60 insertions(+), 37 deletions(-)


base-commit: 4d4be202165e832d74849b4a68e289a2a377039c
-- 
2.43.0

