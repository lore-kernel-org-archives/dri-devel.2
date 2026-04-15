Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59DBF8A144
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EEE610E844;
	Thu, 16 Apr 2026 08:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=metarealtyinc-ca.20251104.gappssmtp.com header.i=@metarealtyinc-ca.20251104.gappssmtp.com header.b="rEmKAbza";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8683C10E226
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 13:06:35 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8d67a483d3eso724120785a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=metarealtyinc-ca.20251104.gappssmtp.com; s=20251104; t=1776258394;
 x=1776863194; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMMALyjYNJKGT7Yxy/N12LBRHyFY9Za0gj2L+9O7R6c=;
 b=rEmKAbzaq8IvAsr4N5RmpPbfIFx4D48OOAgsfJZo31xm85B0Im8qTk156S1djrZw0d
 0QD2jXrulWGREfqDZHQS/uzU8Sgfkduani7nx4gsmL2XarzrlfjIicNd4k1DrqMMBCfl
 P8wXDlzL5Z7TOFHHONB77lN6POlfnMi3qlN0aSN7KKOm/6E3qNZ/ncnwl66ScQP6jPSX
 VgeVbKGo1io6Fgmbd0QWoiXpW4ZJbhXF/TT7/zMzbm/bA4i38qND4BZcRVbpBh8l0K6D
 fspzOmeyx2DXCO4oQegoRZW/DWlQu9pACd/MAsi20y4Xj2wyYHfEPbXkc1Rb/rslUqqj
 YRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776258394; x=1776863194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pMMALyjYNJKGT7Yxy/N12LBRHyFY9Za0gj2L+9O7R6c=;
 b=S6R8IzCw9pPKXQC2VUI4D+FUOZVjXmjDak+/yMpvEaDYlbY3bszYIlpxYAd4eghkqD
 6xAnFgpCCmLbvW3NWBMXFEBLOGGcs/Psb0l4r546JSq0x/xo8ooI4O4trDwWBspCqRPm
 JPpO2hIDpoJZlerfUAX1CDp53hnOZ9Vwtzqf56CN0KyJntMw+hlBIV1ZQgdftikGwtcD
 hhpGX9kcnKgEUWW5Eui/1Op2fCHgq+OyM48HAqaTpplSn0ZVX4Fj3q57TbPxh3/v7rsM
 PgaQPKnwKcXxBO+n4xURHHRx+F2LRlZmwj+mEmCaJPtJGQBsusN+hOJGuGhexS5FN382
 5PDQ==
X-Gm-Message-State: AOJu0Yx4RVpq40KdHmlQiikzZJInc+nnUKMiFbedW8fDN6sT7k+9n/IT
 q53xAxm4mYVEXuPyAkfEvlHUi1ykysFQNYXW6cSAI+8w5nUUBkLMOq8qkgCALqZtgVU=
X-Gm-Gg: AeBDieu2gjYqGI+KoA9RiLvIQrLP+N6QDHwbee+mqzTkjXjKhoesT9n1f7OEuKBxhMP
 8MroTpDdhM5Ll5VkXP8laVm/HGmkNKRXBeH1McJP5ZXKfidSKy5tJ4rsZcLDOmFF9ICemngHsq5
 XMS6oOGUENsp6/8K30QE0o6zYgn7Yh3eDYrPohl8xEIHz/O+FghP3NyHpAmz5SrzIh2YIcmvlPo
 0346kneAukELI0JbRZQ8SY+PrlhWMViPgY1B9r1XxJ5DSszuOWf4WPJ/uRoYXEYc2X+ZZxLQZew
 jCaX7wHVdwf9kGke+Azf3xPmDLNUcf5PKcTPelMTx84pJeG+3hvHKXrrIufzOqWEbo00dgHfKld
 BNjoK494TXT2r4Dw4pKIu7hhHFcPtWtuxR6eErSNtVr7o7VCgQUYwt4bOOfbkFg8L7XbfNQctCw
 AM/bXBJ6mdVkHwAOSaQSkfOo3ZnMpsefo9SXKh76QySJJYISrt0cxvwR0hYKOKjJRtJf2IA+xrY
 zxZzyRAVL1SSXf4dxQuUDLSqKKWel1+PzOkBiM8OU8=
X-Received: by 2002:a05:620a:468c:b0:8c7:1118:c514 with SMTP id
 af79cd13be357-8ddcd6fee90mr3190551985a.17.1776258394418; 
 Wed, 15 Apr 2026 06:06:34 -0700 (PDT)
Received: from jake-laptop ([2607:fea8:e5:500:8e39:827f:e928:9eb7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e4f31f95f9sm125192385a.43.2026.04.15.06.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 06:06:32 -0700 (PDT)
From: Jake S <j@metarealtyinc.ca>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, rodrigo.vivi@intel.com,
 Jake S <j@metarealtyinc.ca>
Subject: [PATCH 2/2] drm/i915/display: allow eDP VRR when EDID has adaptive
 sync range
Date: Wed, 15 Apr 2026 09:06:26 -0400
Message-ID: <20260415130626.10523-3-j@metarealtyinc.ca>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415130626.10523-1-j@metarealtyinc.ca>
References: <20260415130626.10523-1-j@metarealtyinc.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Apr 2026 08:39:27 +0000
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

intel_vrr_is_capable() currently hard-gates eDP VRR on the VBT (Video
BIOS Table) vrr flag. Many OEMs ship laptops with VRR-capable eDP OLED
panels but do not set the VRR flag in the VBT, making VRR impossible
on Linux even though the hardware supports it and works on Windows.

Relax the eDP check: if the VBT flag is not set but the EDID provides
a valid monitor range with delta > 10Hz (now also populated from
DisplayID Adaptive Sync blocks by the previous patch), allow VRR. The
existing checks for DPCD Ignore MSA and monitor range delta still apply.

This mirrors the approach taken by amdgpu, which has its own EDID-based
VRR fallback (parse_edid_displayid_vrr) for exactly this class of panel.

Tested on Dell XPS 2026 (Intel Panther Lake / xe driver, LG Display
OLED eDP, 3200x2000, VRR 20-120Hz confirmed via vblank event tracing).

Signed-off-by: Jake S <j@metarealtyinc.ca>
---
 gpu/drm/i915/display/intel_vrr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gpu/drm/i915/display/intel_vrr.c b/gpu/drm/i915/display/intel_vrr.c
index bea0057..f527471 100644
--- a/gpu/drm/i915/display/intel_vrr.c
+++ b/gpu/drm/i915/display/intel_vrr.c
@@ -47,7 +47,12 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
 	 */
 	switch (connector->base.connector_type) {
 	case DRM_MODE_CONNECTOR_eDP:
-		if (!connector->panel.vbt.vrr)
+		/*
+		 * Prefer VBT flag, but fall back to EDID monitor range
+		 * for panels where OEM firmware omits the VBT VRR flag.
+		 */
+		if (!connector->panel.vbt.vrr &&
+		    !(info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10))
 			return false;
 		fallthrough;
 	case DRM_MODE_CONNECTOR_DisplayPort:
-- 
2.53.0

