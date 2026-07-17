Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B5FC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724CF10E6DB;
	Mon, 20 Jul 2026 07:15:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b="cW/oih/h";
	dkim-atps=neutral
X-Greylist: delayed 919 seconds by postgrey-1.36 at gabe;
 Fri, 17 Jul 2026 13:03:11 UTC
Received: from va-2-46.ptr.blmpb.com (va-2-46.ptr.blmpb.com [209.127.231.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8A8810E477
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2602171341; d=liuxiaozhen.dev; t=1784292465;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=h2qql/WrzP/FkAR7zs0ElNAIgMAvaP/NyI2tztNPzN4=;
 b=cW/oih/hreqkSyYZLl1INKjN3eVpW/fcdtu4yFcyix1IyFOPRFX+notx/M5fPze7vJsdY4
 BHfqaCQ881i8WViKaadNQ7UXI2YwtVJhNgpjuu86+A+u7+MKyRrapBiJ7pP4OyTWUXBYMn
 JIy4uCg7WOdshuBdPgYPaj0HQjmoPQNQrVWvn9QXeQkLqQosvsYOjA2F7+j/lvpJ9o15ip
 nSrAfdzeXrqSjMCw8s1LRWQmLECW0+bGZvo+vUPxGqU8M0rZMzypkAdxV5XmTlrJOOW3GK
 ZFBlxA8+cDWaHe/1cT9YM9wbVeQ7cUcPJ87Ky6zfdJ0WZYvfFail7nx6yiLkfg==
To: "Jani Nikula" <jani.nikula@linux.intel.com>, 
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>
Cc: "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>, 
 "Tvrtko Ursulin" <tursulin@ursulin.net>, 
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>, 
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, 
 <oliver@liuxiaozhen.dev>
X-Mailer: git-send-email 2.53.0
Subject: [PATCH] drm/i915/quirks: Disable PSR2 on Lenovo ThinkPad P15 Gen 1
Date: Fri, 17 Jul 2026 20:47:28 +0800
Message-Id: <20260717124728.11394-1-oliver@liuxiaozhen.dev>
Content-Transfer-Encoding: 7bit
X-Original-From: Oliver Lin <oliver@liuxiaozhen.dev>
X-Lms-Return-Path: <lba+26a5a246f+860617+lists.freedesktop.org+oliver@liuxiaozhen.dev>
From: "Oliver Lin" <oliver@liuxiaozhen.dev>
Mime-Version: 1.0
Received: from ThinkPadP15-Gen1 ([23.151.104.165]) by smtp.feishu.cn with
 ESMTPS; Fri, 17 Jul 2026 20:47:42 +0800
Content-Type: text/plain; charset=UTF-8
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

The internal 4K eDP panel on the Lenovo ThinkPad P15 Gen 1
flickers at 60 Hz when PSR2 is enabled.

The issue reproduces across multiple Linux distributions and
does not occur on Windows. Limiting PSR to PSR1 with
i915.enable_psr=1 prevents the flickering, while PSR2 triggers it.

Add a device quirk to disable PSR2 on this system.

Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16636
Signed-off-by: Oliver Lin <oliver@liuxiaozhen.dev>
---
 drivers/gpu/drm/i915/display/intel_quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 33245f44c0d5..1e24692f4e43 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -259,6 +259,9 @@ static struct intel_quirk intel_quirks[] = {
 
 	/* Xiaomi Book Pro 14 2026 */
 	{ 0xb081, 0x1d72, 0x2424, quirk_disable_psr2 },
+
+	/* Lenovo ThinkPad P15 Gen 1 */
+	{ 0x9bc4, 0x17aa, 0x22b8, quirk_disable_psr2 },
 };
 
 static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
-- 
2.53.0
