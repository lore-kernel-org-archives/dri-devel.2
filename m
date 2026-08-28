Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B356DC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 21:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AE310F485;
	Fri, 28 Aug 2026 21:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BbS5vcBY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAECF10F485;
 Fri, 28 Aug 2026 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=gf9LmWXVmFT0+M/yUeeTzCTuBMKywidGwfoi86/cQvg=; b=BbS5vcBYxnV9tZhfeo+lMAiZLB
 XT7mEvWFjaK6684QCfTi9JPPXurx3xAMGLzBJsc1STeoZrbNdDLi57SMMiIVGVyIny206x5PgliMY
 oOSmzPb2+xpS0nd2MLTdtmBlA0rytKsbiYorv8l3ronDYVKCpYdfqyG22QDzZgi9WXbjv5eh0QB+W
 y2r6tFYYd3shoexnXGn4+8IeTfPGaqYgxYvAD/R9iFRnXEsgayN53sinWMQc0x5IjeMkCf+1H2572
 zw+8FvgypGpsonNM8a4KDJbCo7+Xop1an6OTW/wSoEvhfSczJrmikeuO6DvBi4D3M09ZLo7fa7h+Z
 g806xWKg==;
Received: from 179-125-75-211-dinamico.pombonet.net.br ([179.125.75.211]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x03gI-00B1Zk-Mk; Fri, 28 Aug 2026 23:00:11 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Fri, 28 Aug 2026 17:59:59 -0300
Subject: [PATCH i-g-t] Revert "lib/igt_kms: Do not treat writeback and
 virtual connectors as connected"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-vkms_virtual_output_fix-v1-1-789718f4cb00@igalia.com>
X-B4-Tracking: v=1; b=H4sIAM72kWoC/yXMWwqDMBCF4a3IPDdgp9KO3UqRoOlUpxeVTBIK4
 t6b6uN34PwLKHthhWuxgOckKtOYcTwU4IZ27NnIPRuwxHNJSCa9PmqT+BDbt51imGOwD/kaR4g
 1XWqsTgT5PXvO81a+Nbs1dk924Z+Ddf0Bs9KuTHsAAAA=
X-Change-ID: 20260828-vkms_virtual_output_fix-c82298792438
To: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.comm, simona@ffwll.ch, 
 melissa.srw@gmail.com, robin.clark@oss.qualcomm.com, 
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run, 
 marijn.suijten@somainline.org, 
 Kamil Konieczny <kamil.konieczny@linux.intel.com>, 
 "S, Sowmiya" <sowmiya.s@intel.com>, kernel-dev@igalia.com
Cc: Mark Yacoub <markyacoub@google.com>, Jani Nikula <jani.nikula@intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.16-dev-62088
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

This reverts commit 321448df7fc9af29b4c6697dc74e6c5e2100af6c.

It has broken vkms testing, which has only Virtual connectors.

Cc: Mark Yacoub <markyacoub@google.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 lib/igt_kms.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/igt_kms.h b/lib/igt_kms.h
index 695f666bacb9..27f8877a9f6a 100644
--- a/lib/igt_kms.h
+++ b/lib/igt_kms.h
@@ -669,10 +669,6 @@ static inline bool igt_output_is_connected(igt_output_t *output)
 	    !output->config.connector->count_modes)
 		return false;
 
-	if (output->config.connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK ||
-	    output->config.connector->connector_type == DRM_MODE_CONNECTOR_VIRTUAL)
-		return false;
-
 	if (output->config.connector->connection == DRM_MODE_CONNECTED)
 		return true;
 

---
base-commit: c0c86b23b316bec7d22bbb95e433a8dc25884a1c
change-id: 20260828-vkms_virtual_output_fix-c82298792438

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

