Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B191ACD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 20:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E78410E48D;
	Tue, 26 May 2026 20:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dsusx3a5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313C910E48D
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 20:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779828373; x=1811364373;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NQ/XpmKmZGuEkbOQHdY9LCznykeLgQQtb/On27dAGYs=;
 b=dsusx3a5Qc4Y8z6jqUObLKjqz4SoGdzdeS+2VEgGQqwOD40TtjW0NEfk
 aqjKlw+6Okam7GtOGvXtKcuwBKMXBz4wET8P5FaA1fzGIRIMxOa2X6CvO
 XOG+xiiGqW2Ru67XRnpCaaYVIHLEBw5uD9Li5sOKJq4gY79LxETb+jMdh
 hDSCd+B1qJPtWm+c/fuQ2SzqKaSejtdem6znTLZlTmjVxYEAprvK83vBj
 BArUflgHUbPRqOh9eIQHHHXwOi9FZKLw9KJBePOwPj2AFEAFFfqw9Xx+I
 /mLTmG5RqlF/1wpcYemfUFVxuRsS+vx3XD6qpY/q9aU+L6xqzMcKgPuBT w==;
X-CSE-ConnectionGUID: dwz34Z5jQcqWqzCWk97wbQ==
X-CSE-MsgGUID: czpcsBECTXC59RABOSEvvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80380324"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="80380324"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 13:46:12 -0700
X-CSE-ConnectionGUID: 4k0vCF3ETN6CF9Lkh1a6SA==
X-CSE-MsgGUID: yRYs5qfwS5SqhyIxEXu56g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="239419192"
Received: from smtp.ostc.intel.com ([10.54.29.231])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 13:46:11 -0700
Received: from ray2.jf.intel.com (unknown [10.24.81.183])
 by smtp.ostc.intel.com (Postfix) with ESMTP id 2DF1E6362;
 Tue, 26 May 2026 13:46:11 -0700 (PDT)
From: Dave Hansen <dave.hansen@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Oded Gabbay <ogabbay@kernel.org>
Subject: [PATCH] MAINTAINERS: Fix bouncing Intel VPU Accelerator entry
Date: Tue, 26 May 2026 13:44:57 -0700
Message-ID: <20260526204457.30581-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

The email for Maciej Falkowski is bouncing. Remove the entry.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Oded Gabbay <ogabbay@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd163..b423b7a918e41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7835,7 +7835,6 @@ F:	drivers/soc/ti/smartreflex.c
 F:	include/linux/power/smartreflex.h
 
 DRM ACCEL DRIVERS FOR INTEL VPU
-M:	Maciej Falkowski <maciej.falkowski@linux.intel.com>
 M:	Karol Wachowski <karol.wachowski@linux.intel.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
-- 
2.43.0

