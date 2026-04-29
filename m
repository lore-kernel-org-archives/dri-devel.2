Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659D1FF8864
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 06:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C1910EE63;
	Wed, 29 Apr 2026 06:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RzSRZLXk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D0110EE63
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777442682; x=1808978682;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IAmWhEXz3C5689FJGk7InC53wboRn6mLT3JhEFafqOU=;
 b=RzSRZLXk0HrepIAz/QTYbiKttl3bNMKfyP01mVhmwARsCtrDIPtY9+fW
 dVB0NTcDVP9Tlc82kydFvDHL+pCpt+SQYcTRRr6QcVLDw/xosdKWbmjAH
 IjaaqYs+2HRP3//1r5FWBCtKmJFFZhJElJeeZP8phd0ZoLP/GfxIgd3ij
 Is9Wi2EeV+1lEWFfW1No6nHPqhB6Pa+niE0GoBGpa4dwwnCAbsH0YJEA4
 u/u79TEHv9wd1f/RVtT33x5xmSX1+LlK8SZg6f7u4amHnDLssTMGF9Tth
 jxs6dBF3eF7Q4eFtkpfjvCSkCeMq4sqH9j/9JZtXDHIeR3o5CyvDE9tIG Q==;
X-CSE-ConnectionGUID: da/tnBZQRpSZoydptOVMDw==
X-CSE-MsgGUID: IOCICka+Qy+8M8Apo2Pvig==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88672081"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; d="scan'208";a="88672081"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 23:04:42 -0700
X-CSE-ConnectionGUID: blbSywj2Sx6/FIp4/NhIMg==
X-CSE-MsgGUID: 9dX2/qe2QYi9ov0JNTpevA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; d="scan'208";a="264562052"
Received: from otc-chromeosbuild-8.ostc.intel.com (HELO
 otc-chromeosbuild-8.intel.com) ([10.54.29.153])
 by orviesa002.jf.intel.com with ESMTP; 28 Apr 2026 23:04:41 -0700
From: george.d.sworo@intel.com
To: maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 George D Sworo <george.d.sworo@intel.com>
Subject: [PATCH v2 0/2] drm/i915/modeset: fix NULL/ctx handling in lock paths
Date: Tue, 28 Apr 2026 23:04:29 -0700
Message-Id: <20260429060431.1462589-1-george.d.sworo@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429025952.1202080-1-george.d.sworo@intel.com>
References: <20260429025952.1202080-1-george.d.sworo@intel.com>
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

From: George D Sworo <george.d.sworo@intel.com>

Hi,

This series addresses lock-context robustness seen in HDCP/MST paths,
where modeset locking can be reached with invalid or stale acquire_ctx
state and trigger WARN/Oops in modeset_lock().

Patch 1 keeps the original fix from v1.
Patch 2 adds a defensive fix for the additional ctx handling issue.

Changes in v2:
- Added patch 2 to handle NULL ctx defensively in modeset lock helper
  path.
- Kept patch 1 from v1 (no functional change) for complete series
  resend.
- Updated commit messages for clearer rationale and call-path context.
- Linked previous posting:
  https://patchwork.freedesktop.org/patch/721791/

Patch overview:
  drm/modeset_lock: add NULL check for ctx before WARN_ON
  drm/modeset: harden modeset_lock() against NULL ctx

 drivers/gpu/drm/drm_modeset_lock.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.34.1

