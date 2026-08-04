Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6852DC55182
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 03:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8DD910E0F2;
	Tue,  4 Aug 2026 03:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="L6AWTy0Y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A1A10E0F2
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 03:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785812646; x=1817348646;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j5qtUy7ODOvKHcirpmDeYnhjzJKBSG80aSpIZBvYENg=;
 b=L6AWTy0YbwUv0BQZv8i4d9O0lAHOmCT68Qqn63Z0J7gIF/y81lAtBaQA
 f38Jop9mfApz1xqIe6u8c3ds9F8zebAVkz8SdtbkdFY78cM7plCW6iX9s
 8RDMGwNq2rbAcinB2n2BqYgHybofEbaublEQ0PdEMrxP8FwG6DCcC/dRU
 EsCb0W1TbH7hApfB+0Ml7mKAmzmAbqcjKvkGCFs5hnceQAqO1MRSsa/jU
 MO4x3liKtcRSt2ctzsbHBY0+1EKCogRR9w0ONLytu5Kx/a9jezzEnrE0H
 8vUftBwxS3HZpJ63whZu+Cp+fzUXtDOq0EsxgpSf48qw2grSbrcasO5o3 A==;
X-CSE-ConnectionGUID: UBjTy21uQ/ikdG3Mf+dEGw==
X-CSE-MsgGUID: 93wKXI6MRXO/Fo5N6kRf/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103759431"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="103759431"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 20:04:06 -0700
X-CSE-ConnectionGUID: M82TH8EDTGWddIhK2wQ5UQ==
X-CSE-MsgGUID: Q2Hn4vrmSgaE3PgIVBIyFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="260139984"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 20:04:03 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>,
 stable@vger.kernel.org, Junjie Cao <junjie.cao@linux.dev>
Subject: [PATCH v3 3/3] backlight: aw99706: Honor the core blank state in
 update_status()
Date: Tue,  4 Aug 2026 11:02:55 +0800
Message-ID: <20260804030255.1934470-4-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804030255.1934470-1-junjie.cao@intel.com>
References: <20260804030255.1934470-1-junjie.cao@intel.com>
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

From: Junjie Cao <junjie.cao@linux.dev>

update_status() passes props.brightness straight to the hardware and
ignores the power/blank state tracked by the core. Writing 4 to the
bl_power sysfs attribute or blanking the framebuffer therefore leaves
the backlight lit.

Use backlight_get_brightness(), which returns 0 while the device is
blanked.

Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
Cc: stable@vger.kernel.org
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 drivers/video/backlight/aw99706.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index 6ec49b6cb14c..c4a66b59ecf1 100644
--- a/drivers/video/backlight/aw99706.c
+++ b/drivers/video/backlight/aw99706.c
@@ -340,7 +340,7 @@ static int aw99706_bl_update_status(struct backlight_device *bl)
 {
 	struct aw99706_device *aw = bl_get_data(bl);
 
-	return aw99706_update_brightness(aw, bl->props.brightness);
+	return aw99706_update_brightness(aw, backlight_get_brightness(bl));
 }
 
 static const struct backlight_ops aw99706_bl_ops = {
-- 
2.43.0

