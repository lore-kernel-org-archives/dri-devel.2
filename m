Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A15FC55182
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 03:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F0E10E0D1;
	Tue,  4 Aug 2026 03:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="liQNkW3V";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 714E910E0D1
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 03:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785812636; x=1817348636;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lA2DmJzriDcvH7vLXFl8ctxo5/s99YAuZ3P8QctO4ts=;
 b=liQNkW3VslrppNlbv2Rr7k5dIC0kR/UVs0n28DnxhYwONDse4j/thSsr
 bDlPXWYHXdKsU6HmaAG5tJTSIPw2Bpkkq2ARnsYOUMHJr0f7dpyVENn5P
 ZloFV+SMwwAxysk3nTW0jv0/l7NBoLRS8zLxlR4/5YhZ0tt2e736T3sYZ
 l/YaVJuuG1pANRMZWb2yjJlJHGWpbh52eUC/N9uzL4mUyX+t2+wMhkQJF
 Pi1j10G+YKg2C1Tkl3LXqhwB2I+V7jXF/jAMnEBT1Iy6z3ZBvprT9CAim
 zc8USQS0xjAW5Hdz+5lRHfkn1O9be0GJn4yNOE79Wy0Q6tPWHvNFkiVns Q==;
X-CSE-ConnectionGUID: pg/iC9IMQrCzwn9FdL566w==
X-CSE-MsgGUID: 15KbW6prRwWYCkmQi02LHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103759416"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="103759416"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 20:03:56 -0700
X-CSE-ConnectionGUID: OHeryRtxQJGUADaGvfVipQ==
X-CSE-MsgGUID: jL+8s0SVQDKthgXdprztUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="260139935"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 20:03:53 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>,
 stable@vger.kernel.org, Junjie Cao <junjie.cao@linux.dev>
Subject: [PATCH v3 1/3] backlight: aw99706: Fix DT property names to match
 binding
Date: Tue,  4 Aug 2026 11:02:53 +0800
Message-ID: <20260804030255.1934470-2-junjie.cao@intel.com>
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

The driver reads four tuning properties without the unit suffixes that
the binding mandates: "awinic,sw-freq" instead of "awinic,sw-freq-hz",
"awinic,sw-ilmt" instead of "awinic,sw-ilmt-microamp", "awinic,iled-max"
instead of "awinic,iled-max-microamp", and "awinic,uvlo-thres" instead
of "awinic,uvlo-thres-microvolt".

As a result, device_property_read_u32() never finds these properties in
a binding-conformant device tree and silently falls back to the compiled-in
defaults for switching frequency, switching current limit, max LED current,
and UVLO threshold.

Fix by aligning the property name strings in aw99706_dt_props[] with the
binding. No value/range changes are needed since both sides already use
the same units and enumerations.

Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
Cc: stable@vger.kernel.org
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 drivers/video/backlight/aw99706.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index 18299faf06ad..e130f164303a 100644
--- a/drivers/video/backlight/aw99706.c
+++ b/drivers/video/backlight/aw99706.c
@@ -130,23 +130,23 @@ static const struct aw99706_dt_prop aw99706_dt_props[] = {
 		AW99706_CFG0_REG, AW99706_DIM_MODE_MASK, 1,
 	},
 	{
-		"awinic,sw-freq", aw99706_dt_property_lookup,
+		"awinic,sw-freq-hz", aw99706_dt_property_lookup,
 		aw99706_sw_freq_tbl, ARRAY_SIZE(aw99706_sw_freq_tbl),
 		AW99706_CFG1_REG, AW99706_SW_FREQ_MASK, 750000,
 	},
 	{
-		"awinic,sw-ilmt", aw99706_dt_property_lookup,
+		"awinic,sw-ilmt-microamp", aw99706_dt_property_lookup,
 		aw99706_sw_ilmt_tbl, ARRAY_SIZE(aw99706_sw_ilmt_tbl),
 		AW99706_CFG1_REG, AW99706_SW_ILMT_MASK, 3000000,
 	},
 	{
-		"awinic,iled-max", aw99706_dt_property_iled_max_convert,
+		"awinic,iled-max-microamp", aw99706_dt_property_iled_max_convert,
 		NULL, 0,
 		AW99706_CFG2_REG, AW99706_ILED_MAX_MASK, 20000,
 
 	},
 	{
-		"awinic,uvlo-thres", aw99706_dt_property_lookup,
+		"awinic,uvlo-thres-microvolt", aw99706_dt_property_lookup,
 		aw99706_ulvo_thres_tbl, ARRAY_SIZE(aw99706_ulvo_thres_tbl),
 		AW99706_CFG2_REG, AW99706_UVLOSEL_MASK, 2200000,
 	},
-- 
2.43.0

