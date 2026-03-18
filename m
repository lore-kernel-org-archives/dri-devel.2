Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3098C10854DA
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB0E10E779;
	Wed, 18 Mar 2026 09:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FbXJltsG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E5710E779;
 Wed, 18 Mar 2026 09:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773826003; x=1805362003;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=N1i5m1NjWThIXJu4MxH3bwtIYEBGWAt82Nfiv5h2RLE=;
 b=FbXJltsGO8au7AWbYlwTTo7rZL3VDqVey3+0IPuPyv3/IDQxWMaAjExj
 Lnzln4rtDP9FwujQDsuGHcLNvGHvLO6tyN6bA6qf6ptDhp0NV8WLqOtum
 kgX9jO2W5ulwzxAkt5fFqPRV8b89X5/RcL9XJogYRjyeZhGz5fP3ZKt1S
 yA4+XoNWrATOMGRxXH7ZciyQn0oNyk3awzfBrA36d+gXxp+w+YlsNv2V/
 xDP0NFq60GVJV3WNQNOtoJBP/ZaU/kqaTmKF7r7Mz/KH6A8OqlL+sKr/w
 qXgnbzCAkjXm7VpALy3dXu0UjTl1GCYImJ91zKygnoIpcvWGCMpjfEI0f Q==;
X-CSE-ConnectionGUID: YrSr6Xf+Qg+kfsSOAZKaxw==
X-CSE-MsgGUID: ML2yC5paTmGfCQm83AgODQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85953857"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="85953857"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 02:26:43 -0700
X-CSE-ConnectionGUID: lXfv0MqDT/OVTLjiUUU5dw==
X-CSE-MsgGUID: kPCBeupGRkWEopuailZglA==
X-ExtLoop1: 1
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.223.74.76])
 by fmviesa003.fm.intel.com with ESMTP; 18 Mar 2026 02:26:40 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, imre.deak@intel.com, jani.nikula@intel.com,
 arun.r.murthy@intel.com, Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v8 0/3] Panel Replay BW optimization
Date: Wed, 18 Mar 2026 14:26:39 +0530
Message-Id: <20260318085642.3621166-1-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
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

Unused bandwidth can be used by external display agents for Panel Replay
enabled DP panel during idleness with link on. This patch series
enabling the same.

Signed-off-by: Animesh Manna <animesh.manna@intel.com>

Animesh Manna (3):
  drm/i915/display: Add drm helper to check pr optimization support
  drm/i915/display: Add hook to check optimization support for Intel
    platforms
  drm/i915/display: Panel Replay BW optimization for DP2.0 tunneling

 drivers/gpu/drm/display/drm_dp_tunnel.c       | 17 +++++++++++++++++
 .../gpu/drm/i915/display/intel_display_regs.h |  1 +
 .../gpu/drm/i915/display/intel_dp_tunnel.c    | 18 ++++++++++++++++++
 .../gpu/drm/i915/display/intel_dp_tunnel.h    |  6 ++++++
 drivers/gpu/drm/i915/display/intel_psr.c      | 19 +++++++++++++++++--
 include/drm/display/drm_dp_tunnel.h           |  6 ++++++
 6 files changed, 65 insertions(+), 2 deletions(-)

-- 
2.29.0

