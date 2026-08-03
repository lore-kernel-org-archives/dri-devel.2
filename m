Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D16C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 04:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761D510E0E9;
	Tue,  4 Aug 2026 04:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="BWG2NJhA";
	dkim-atps=neutral
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [91.218.175.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6D510E0E9
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 04:10:49 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785766417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nNuvHuH8fsCvdyIJJC/9rVCMMyZkr6Bz657LnndEBGA=;
 b=BWG2NJhA9mYQOAkIRzvnKJR/41EUlAG1gSIASEIwHRoUUrBLE0hSosrNDnV9D7SkmtjUP8
 tw1iFogd3zU7Z7eFRlrvXEogNrfX/U02KOPDGp35Utfc9cC01q0zqivv0hycgiqDfZqYpn
 2FJFZ9Y5Ul9hXL/rw4deh36o3UrMXog=
From: Junjie Cao <junjie.cao@linux.dev>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 3/3] backlight: aw99706: Honor the core blank state in
 update_status()
Date: Mon,  3 Aug 2026 07:13:10 -0700
Message-ID: <20260803141310.1379194-4-junjie.cao@linux.dev>
In-Reply-To: <20260803141310.1379194-1-junjie.cao@linux.dev>
References: <20260803141310.1379194-1-junjie.cao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

update_status() passes props.brightness straight to the hardware and
ignores the power/blank state tracked by the core. Writing 4 to the
bl_power sysfs attribute or blanking the framebuffer therefore leaves
the backlight lit.

Use backlight_get_brightness(), which returns 0 while the device is
blanked.

Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 drivers/video/backlight/aw99706.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index dfb4b38b5b4c..d035ff5af52c 100644
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

