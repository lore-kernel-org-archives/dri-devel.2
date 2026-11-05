Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD4606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 03:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jndl5XB8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A0110E081;
	Thu,  5 Nov 2026 03:47:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2976A10E081;
 Thu,  5 Nov 2026 03:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793850467; x=1825386467;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GNlgRYMpprZyno9nyFl8JZ1JQyWiZO7Vptq6p2E0QKQ=;
 b=jndl5XB8mJz7t446Adfm6Q+YDsDW5ZvE+tmA6meDLn1TjlLH3JIACQjR
 E6KgSyCjRozwvKjb6d7Uu1503eAiBL2LKKQUUWgaI2kBDKCKhuxor4KUs
 EyZZCkVp/ZzDsO+EyfVZfRKR6XbBed8FVjhZWDU1Sj39EU0bswzB6Y7S+
 Cr6VWyXS66J088ClO4f8MtDMZj8CiOtSRuwJU+/iiMnMnz4vCVWtx9Qft
 n9W/aS2KeY6vIMynEHKE8PMuXTsKT4joWoyNK9ta4nKQ9v2qhMLFzKycA
 EdvMgHlQqQxp0CZTwiTdVvWkqDZDvnic3anl4PJpRfEStZVxzk4u6VzvM Q==;
X-CSE-ConnectionGUID: qY/pMxP1RwOKqgA/y+G+YA==
X-CSE-MsgGUID: GCHJlIHpTB2j/2wi0jtBIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2630493"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2630493"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 19:47:47 -0800
X-CSE-ConnectionGUID: wiPU3gEnSV2O1m65CRX87A==
X-CSE-MsgGUID: idpvQEziRjKU0kBlaxGMTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7241354"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO kialmah1-mobl2.lan)
 ([10.125.110.84])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 19:47:47 -0800
From: Khaled Almahallawy <khaled.almahallawy@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Khaled Almahallawy <khaled.almahallawy@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Uma Shankar <uma.shankar@intel.com>,
 Jonathan Cavitt <jonathan.cavitt@intel.com>,
 Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v3] drm/display: Increase DP_RECEIVER_CAP_SIZE from 15 to 16
 bytes
Date: Wed,  4 Nov 2026 19:46:58 -0800
Message-ID: <20261105034658.18959-1-khaled.almahallawy@intel.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Several Link Layer tests (4.2.2.1-2, 4.2.2.7-8) fail because DPTX doesn't
read DPCD ADAPTER_CAP addresses (0x000F and 0x220F).

4.2.2.1 test states [1]:
"Fail1: Source DUT failed to read the DPCD Receiver Capability field
(DPCD:00000h:0000Fh) through AUX_CH before link training."

4.2.2.2 test states [1]:
"Fail2: Source DUT failed to read the DPCD Extended Receiver Capability
field (DPCD:02200h:0220Fh) through AUX_CH before link training."

Additionally, the spec [2] states:
"The Source device shall respond to Hot Plug event/Hot Re-plug event by
first reading DPCD Link/Sink Device Status registers at DPCD 00200h
through 00205h –or– DPCD 02002h through 0200Fh. If the link is unstable
or lost, the Source device then reads the DPCD Receiver Capabilities
registers at DPCD 00000h through 0000Fh to determine the appropriate
information needed to train the link. The Source device shall then
initiate link training."

Increasing DP_RECEIVER_CAP_SIZE by 1 byte ensures passing the test
conditions for these link layer tests.

[1]: DisplayPort v2.1 Link Layer Compliance Test Specification
sections 4.2.2.1 & 4.2.2.2
[2]: DisplayPort Standard v2.1 - Sec 5.1.4 Source Device Behavior
upon HPD Pulse Detection

v3: Rebase, drop deprecated test 4.2.2.9 from the commit message
v2: Rebase

Cc: Uma Shankar <uma.shankar@intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: Khaled Almahallawy <khaled.almahallawy@intel.com>
---
 include/drm/display/drm_dp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index e63c7f075f54..a2a7338552e1 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -1715,7 +1715,7 @@ enum drm_dp_phy {
 #define DP_LINK_STATUS_SIZE	   6
 
 #define DP_BRANCH_OUI_HEADER_SIZE	0xc
-#define DP_RECEIVER_CAP_SIZE		0xf
+#define DP_RECEIVER_CAP_SIZE		0x10
 #define DP_DSC_RECEIVER_CAP_SIZE        0x10 /* DSC Capabilities 0x60 through 0x6F */
 #define DP_DSC_BRANCH_CAP_SIZE		3
 #define EDP_PSR_RECEIVER_CAP_SIZE	2
-- 
2.53.0

