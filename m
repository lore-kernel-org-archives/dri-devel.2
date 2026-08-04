Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BEAC55182
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 03:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4380110E0DD;
	Tue,  4 Aug 2026 03:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="l3Tysb2X";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F3C310E0DD
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 03:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785812641; x=1817348641;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fz025/z3UawH+L/V+CfEivqAFGOPAentcJSQIZkOe5c=;
 b=l3Tysb2XQkiUtJ0MjO3WbQZVjMa/8VNcW/ec/y3YwxpA/nCJwFB5i/qd
 vVslIUjNlZCG/SyioZrSXSMQ4M+jbMKyb0bndNGVQR1piS/YXfgT3rPDR
 4864G2JYNfTlc+MnHzAm5645SN/TFrKLD4JottANyyl4evCmwzT7uZAH+
 tju11QPVJWMofacVXSJjDz03cDTLj0ZNt02ensC3NHMWZzq/VOxuX39N6
 SIvsJa2VbMlef6PGDZlFOkZVu0fhAlbBHf/UwbP01PGCDO2aSRkev64bV
 dZYt0A7xPoqjUwk+38/0CCvNt74f7j4xwBPLX/wE9gnSg+KqZOcNriHSn w==;
X-CSE-ConnectionGUID: 0lpVOb+vRr2AAAglTHea+A==
X-CSE-MsgGUID: XzCnDkLvQ329pIppD5kAfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103759423"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="103759423"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 20:04:01 -0700
X-CSE-ConnectionGUID: biiYxiQrSOuk0toZxzRvuQ==
X-CSE-MsgGUID: I+i9IfBiR4y2t2qbP9+v8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="260139962"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 20:03:58 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>,
 Junjie Cao <junjie.cao@linux.dev>
Subject: [PATCH v3 2/3] backlight: aw99706: Validate all DT property values
 consistently
Date: Tue,  4 Aug 2026 11:02:54 +0800
Message-ID: <20260804030255.1934470-3-junjie.cao@intel.com>
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

The lookup helpers for dim-mode and ramp-ctl take a shortcut when
lookup_tbl is NULL: they accept any u32 value without range-checking
and return success unconditionally. Out-of-range values get silently
truncated by regmap_update_bits instead of triggering the dev_warn +
default-fallback path that the other properties use.

Add a field-width check for the NULL-table case so that values
exceeding the register field maximum are rejected the same way a
table-lookup miss is.

The switching frequency table has a second hole: reserved slots use 0
as their marker, so "awinic,sw-freq-hz = <0>" matches slot 0 and
programs a reserved encoding. Make the reserved marker U32_MAX and
skip such slots during lookup.

While here, also switch the error returns to -EINVAL for consistency.

Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 drivers/video/backlight/aw99706.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index e130f164303a..6ec49b6cb14c 100644
--- a/drivers/video/backlight/aw99706.c
+++ b/drivers/video/backlight/aw99706.c
@@ -60,7 +60,7 @@
 #define AW99706_MTPLDOSEL_REG			0x1E
 #define AW99706_MTPRUN_REG			0x1F
 
-#define RESV	0
+#define RESV	U32_MAX
 
 /* Boost switching frequency table, in Hz */
 static const u32 aw99706_sw_freq_tbl[] = {
@@ -94,17 +94,19 @@ static int aw99706_dt_property_lookup(const struct aw99706_dt_prop *prop,
 	int i;
 
 	if (!prop->lookup_tbl) {
+		if (dt_val > (prop->mask >> __ffs(prop->mask)))
+			return -EINVAL;
 		*val = dt_val;
 		return 0;
 	}
 
 	for (i = 0; i < prop->tbl_size; i++)
-		if (prop->lookup_tbl[i] == dt_val)
+		if (prop->lookup_tbl[i] != RESV && prop->lookup_tbl[i] == dt_val)
 			break;
 
 	*val = i;
 
-	return i == prop->tbl_size ? -1 : 0;
+	return i == prop->tbl_size ? -EINVAL : 0;
 }
 
 #define MIN_ILED_MAX	5000
@@ -116,11 +118,14 @@ aw99706_dt_property_iled_max_convert(const struct aw99706_dt_prop *prop,
 				     u32 dt_val, u8 *val)
 {
 	if (dt_val > MAX_ILED_MAX || dt_val < MIN_ILED_MAX)
-		return -1;
+		return -EINVAL;
+
+	if ((dt_val - MIN_ILED_MAX) % STEP_ILED_MAX)
+		return -EINVAL;
 
 	*val = (dt_val - MIN_ILED_MAX) / STEP_ILED_MAX;
 
-	return (dt_val - MIN_ILED_MAX) % STEP_ILED_MAX;
+	return 0;
 }
 
 static const struct aw99706_dt_prop aw99706_dt_props[] = {
-- 
2.43.0

