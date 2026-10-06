Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BFFCA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 05:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C7510E2DC;
	Tue,  6 Oct 2026 05:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="I6WaP3DC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FC9310E1C7;
 Tue,  6 Oct 2026 05:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791265218; x=1822801218;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5FnNGK6BZuRpwepjvvzVBUWjijlYuTAnnY/h8Rt+sAM=;
 b=I6WaP3DC+uizeMejDNgltBOI2ykunY3DxZwCrL3uPvPcpxJ6lnZWVZ6K
 MjH6K8nHIC0maMjz7XKcFQYJ1t7VeIPHdjkRZGobdBGvD6BTvsdhUCQs8
 4zv9VLQniM+jQadcmMECMZ6thYVXytrmqUW+nwSQbujjHV56GIqUFkmzN
 UM2636HcR2IcIxDsFDay7xzRhAdC+goHGIY2TXaYhPXexQzKJg56lK90q
 GNNBbUPgc23HKcbJPD/ZtuizbFN/B9EGYwPUIkbR6gLfWScj+LEgt6szX
 h9gdX3sbHmCzak5Ps4e0P9LHAkkK8E8cK+Y6pKB7FB4eyUMrsVpfXI5Zs g==;
X-CSE-ConnectionGUID: wHHTtLo4S56tq+KFtuclvw==
X-CSE-MsgGUID: OcJdvej9QkyE0dEpvE47oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="109434281"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="109434281"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 22:40:18 -0700
X-CSE-ConnectionGUID: agAubdDiQfKPSjuD9/T0Qg==
X-CSE-MsgGUID: TJ1nfrxQRh2fKQRzvwHYyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="285160498"
Received: from pranay-x299-aorus-gaming-3-pro.iind.intel.com ([10.223.74.54])
 by fmviesa005-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 22:40:16 -0700
From: Pranay Samala <pranay.samala@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: chaitanya.kumar.borah@intel.com, sameer.lattannavar@intel.com,
 pranay.samala@intel.com
Subject: [PATCH v2 1/2] video/hdmi: Add hdmi_eotf_get_name()
Date: Tue,  6 Oct 2026 11:10:03 +0530
Message-ID: <20261006054004.285744-2-pranay.samala@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006054004.285744-1-pranay.samala@intel.com>
References: <20261006054004.285744-1-pranay.samala@intel.com>
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

Add hdmi_eotf_get_name() next to the other hdmi_*_get_name() helpers.

Assisted-by: LLM
Signed-off-by: Pranay Samala <pranay.samala@intel.com>
---
 drivers/video/hdmi.c | 23 +++++++++++++++++++++++
 include/linux/hdmi.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 45b42f14a750..cd62afcd38d7 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -1429,6 +1429,29 @@ static void hdmi_audio_infoframe_log(const char *level,
 			frame->downmix_inhibit ? "Yes" : "No");
 }
 
+/**
+ * hdmi_eotf_get_name() - get the name of an electro-optical transfer function
+ * @eotf: electro-optical transfer function
+ *
+ * Returns: a human readable name for @eotf, or "Invalid" if @eotf is not a
+ * transfer function defined by CTA-861.
+ */
+const char *hdmi_eotf_get_name(enum hdmi_eotf eotf)
+{
+	switch (eotf) {
+	case HDMI_EOTF_TRADITIONAL_GAMMA_SDR:
+		return "Traditional gamma SDR";
+	case HDMI_EOTF_TRADITIONAL_GAMMA_HDR:
+		return "Traditional gamma HDR";
+	case HDMI_EOTF_SMPTE_ST2084:
+		return "SMPTE ST2084";
+	case HDMI_EOTF_BT_2100_HLG:
+		return "BT.2100 HLG";
+	}
+	return "Invalid";
+}
+EXPORT_SYMBOL(hdmi_eotf_get_name);
+
 static void hdmi_drm_infoframe_log(const char *level,
 				   struct device *dev,
 				   const struct hdmi_drm_infoframe *frame)
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index b80a5ee63bb2..60a9ad3677b3 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -468,4 +468,6 @@ int hdmi_infoframe_unpack(union hdmi_infoframe *frame,
 void hdmi_infoframe_log(const char *level, struct device *dev,
 			const union hdmi_infoframe *frame);
 
+const char *hdmi_eotf_get_name(enum hdmi_eotf eotf);
+
 #endif /* _DRM_HDMI_H */
-- 
2.53.0

