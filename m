Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03810CDB47F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C759F10EA57;
	Tue, 23 Jun 2026 09:46:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="M/NfzJBC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7E810EA52;
 Tue, 23 Jun 2026 09:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782207984; x=1813743984;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KB20HugIkev5hCQXnL9GWISqBm9YDcNQgif+lzsSDSM=;
 b=M/NfzJBCzCoxTqkTHqDjuftQSAiju9uQ4TQrZhT++he8VEELcPpOR+Cu
 ETnQAAkrXUXFDdZZ5hRTwvTShZ6FpQjuudRHatvN7yCcOSFHGL38KISnY
 xqD+cbDu4P1ffjg/8UXKyJlReRgFn+1lv1mZVUu/37mNu/tmlYYrj3jer
 AHwKdFzklwphM3zHTS4m2RG+xM6TpBe662I93PAaRQIffsciE7aGpRWRB
 SugVT4QMmXMXe3FrKuH8/J7UdzQw7dC1jIZInVoNsSdXnZi/xScRvtXiv
 QuQypfaRo/lie++OXmbxM8EC66c5HuhBuB2KZpgo6Mm67N7Gxbv4VBt/a g==;
X-CSE-ConnectionGUID: JDS3dDkSSxuBY9VuVQL7Eg==
X-CSE-MsgGUID: 29G7nT2NRB6DwqjJi9es8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="94336276"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="94336276"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 02:46:24 -0700
X-CSE-ConnectionGUID: Wz6qP3EmQGab+p6VIGFSdA==
X-CSE-MsgGUID: 2Lw44VF3TwmmOgveW5y7WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="247130381"
Received: from nemesa.iind.intel.com ([10.190.239.22])
 by fmviesa008.fm.intel.com with ESMTP; 23 Jun 2026 02:46:22 -0700
From: Nemesa Garg <nemesa.garg@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Nemesa Garg <nemesa.garg@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [RESEND 3/4] drm/dp: Add max bpp delta computation constants
Date: Tue, 23 Jun 2026 15:12:35 +0530
Message-Id: <20260623094236.1586318-4-nemesa.garg@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260623094236.1586318-1-nemesa.garg@intel.com>
References: <20260623094236.1586318-1-nemesa.garg@intel.com>
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

Define macros used for decoding DSC max bpp delta values
from the sink DPCD. This includes per-format masks for
RGB/YCbCr444 and YCbCr420, as well as definitions for delta
scaling and the YCbCr420 bit shift. Also add version_1 as
suffix to MAX_DELTA_BPP.

v2: Move constants under 0x6E register. [Ankit]
    Add mask for Native 422 also. [Ankit]
v3: Rename _DSC_NATIVE4222 to _DSC_NATIVE_YCbCr422. [Ankit]
v4: Move Version_1 edit ti patch_1. [Ankit]
    Add shift mask for native also. [sashiko]

Signed-off-by: Nemesa Garg <nemesa.garg@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 include/drm/display/drm_dp.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 57e8143a1374..7154216e0aff 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -358,6 +358,10 @@
 # define DP_DSC_RGB_YCbCr444_MAX_BPP_DELTA_MASK 0x1f
 # define DP_DSC_NATIVE_YCbCr420_MAX_BPP_DELTA_MASK 0xe0
 
+# define DP_DSC_BPP_DELTA_444			16
+# define DP_DSC_BPP_DELTA_420			12
+# define DP_DSC_BPP_DELTA_SHIFT_420		5
+
 #define DP_DSC_BITS_PER_PIXEL_INC           0x06F
 # define DP_DSC_BITS_PER_PIXEL_1_16         0x0
 # define DP_DSC_BITS_PER_PIXEL_1_8          0x1
@@ -365,6 +369,9 @@
 # define DP_DSC_BITS_PER_PIXEL_1_2          0x3
 # define DP_DSC_BITS_PER_PIXEL_1_1          0x4
 # define DP_DSC_BITS_PER_PIXEL_MASK         0x7
+# define DP_DSC_NATIVE_YCbCr422_MAX_BPP_DELTA_MASK  0x78
+# define DP_DSC_BPP_DELTA_NATIVE_SHIFT_422	3
+# define DP_DSC_BPP_DELTA_NATIVE_422		16
 
 #define DP_PSR_SUPPORT                      0x070   /* XXX 1.2? */
 # define DP_PSR_IS_SUPPORTED                1
-- 
2.25.1

