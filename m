Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8336BC5DF76
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 990AD10E2F1;
	Sun, 16 Aug 2026 14:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OXyuvXB8";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDF210E570
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:41:38 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso618056a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 06:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786714898; x=1787319698; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZHoa1K49NDPsNuWHGok7ahf8ilm7bb0+sIWpxa8JDrA=;
 b=OXyuvXB87hn3CiTMbrAv4Df/izV85/pEbGtbsu2EmaU7ack5qT2fnheVF7xtz8dDxQ
 L9GiCeYvLCJP6LVuNhY9bEN1rROitewOm53/nLdi0EoYCFMyW1G2LzpsCLgHKPGcyB/f
 0qv3OAnB99zfEb4x3a+aVmjCer3ZAR6zySKBQI+PrGGWX9K/ZhUhMK+B3BIvPsS1lhFC
 iWeHikQgLPF3hcCBi5cVzueojMa1lVIO/iiqFDl9YBPyIA/QDNXAX2HXIw/P75Ff8abb
 8TaCbRBdZFvzlAv3h7Pc9XrI3hBIMGtrc/vBepl4uzO+L45rTHXTrJ9cYgFCUz9diyzR
 cQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786714898; x=1787319698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZHoa1K49NDPsNuWHGok7ahf8ilm7bb0+sIWpxa8JDrA=;
 b=lmBNuo9krUn+jbBurUoTqEsurMuO86vqyleHNjYzsg7Y7x2sfKTQcTO5f4Al8/VQ9Q
 9ZnkVVpNsoMNRZ3yMtcrGHr1pjuZ+Tu5H0B8TxuG/PRLZyfo7ICU7BepIcrMVL463Sx5
 lm5H4t64ny3yHQKwuEJX8bCMU2Ua2wqPRvuerbBOIMNWYztnvD2JP7OXZjfLV+BVDSyd
 ysfl7id6sf3+YrJUC3GfkbpxYCcLA2Z4vyEoQpm/TR99DLEL5l/L/kO8Xa1ewZwCQ5ix
 eAiaDq8c2lia4gvO3re+pDJtV0r+mwo1j/KJ+pV1XaS3w86e5yAcsOkwpfIWyZzwDiHk
 Dsww==
X-Gm-Message-State: AOJu0Yxe+LSWkLqSwtOcPMKgn4tb/DP9Ugz4y0myLhfIyGiBGc9kBLf2
 /BsapkLEuTQOSABV9IYkkuZj1rVbjhY2UbNi0yrzfADBnG9ZC1i0KkNQ
X-Gm-Gg: AR+sD11n+x48hrwplZJsFUnn96XlSK1qqt/hk/BH+ARrugjUUYnIV3mEZy6nmEhh1lx
 NjwSalwJ5sjmZ6VpF3CimYQx+lHbqdfEBFvqGzfcHGROJ5tMMEmVJPksHt5h1EW/J+E+tvXtuh1
 XQ4YYoRp5zGTH3FcwyH1yPDtsPztm2HregbP//auSfx93Sqq1c5WRYkUYloFjYsEOyT3Z12CyUc
 jGKstPxiwVrZgVabgz9g8zKLvaYlq1kL6hdAqVczwmIrOICsKnr6d4Zdx4hW2/K8QkW6ORAU0Pw
 1sP1NxgeivO+OEdSqbBj2QOO90sRidnedvCCBx+8Mr42awhfU/QqtG7T+hRPV+Y9hjn1Ek2JwJd
 8AIsVBhG0nr+ryHoN51ftgPe25sANZ4DwxBKS6hQ4x+btArPGj7JJpJzY+YakjT0+NNL2DPOFdh
 QcQ7OuxBmXeAqQ9G5jdroRCiQlhgM7FHLzBttczPbF4nhxyrz6bqVztZQHpEEWxn/jJTLiisd2v
 iYuM2rx
X-Received: by 2002:a05:6a00:3a12:b0:848:498b:e0d4 with SMTP id
 d2e1a72fcca58-84fde7d2ecemr5658625b3a.38.1786714897998; 
 Fri, 14 Aug 2026 06:41:37 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc095a43327sm592201a12.28.2026.08.14.06.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:41:37 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] component: Release match data on add failure
Date: Fri, 14 Aug 2026 21:41:32 +0800
Message-ID: <20260814134132.1387952-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

component_match_add_release() accepts a release callback so callers can
transfer ownership of resources held by the match data. However,
__component_match_add() returns without invoking that callback when the
match is already an error pointer or when allocating the match or its
array fails.

This leaks resources acquired before the call. For example,
drm_of_component_match_add() takes a reference to its device node before
adding the match, and ERR_PTR-aware callers can return from probe with
that reference still held. Calls made after the first allocation failure
can leak further references.

Invoke the release callback whenever the match data cannot be added, and
document the failure-path ownership rule. Successful match lifetime
semantics remain unchanged.

This issue was found by a static analysis checker and confirmed by manual
source review.

Fixes: ce657b1cddf1 ("component: add support for releasing match data")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/base/component.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 655d68deb590c..2b455d7499926 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -388,14 +388,14 @@ static void __component_match_add(struct device *parent,
 	struct component_match *match = *matchptr;
 
 	if (IS_ERR(match))
-		return;
+		goto err_release;
 
 	if (!match) {
 		match = devres_alloc(devm_component_match_release,
 				     sizeof(*match), GFP_KERNEL);
 		if (!match) {
 			*matchptr = ERR_PTR(-ENOMEM);
-			return;
+			goto err_release;
 		}
 
 		devres_add(parent, match);
@@ -410,7 +410,7 @@ static void __component_match_add(struct device *parent,
 		ret = component_match_realloc(match, new_size);
 		if (ret) {
 			*matchptr = ERR_PTR(ret);
-			return;
+			goto err_release;
 		}
 	}
 
@@ -420,6 +420,11 @@ static void __component_match_add(struct device *parent,
 	match->compare[match->num].data = compare_data;
 	match->compare[match->num].component = NULL;
 	match->num++;
+	return;
+
+err_release:
+	if (release)
+		release(parent, compare_data);
 }
 
 /**
@@ -438,7 +443,8 @@ static void __component_match_add(struct device *parent,
  * The allocated match list in @matchptr is automatically released using devm
  * actions, where upon @release will be called to free any references held by
  * @compare_data, e.g. when @compare_data is a &device_node that must be
- * released with of_node_put().
+ * released with of_node_put(). @release is also called if the match cannot be
+ * added.
  *
  * See also component_match_add() and component_match_add_typed().
  */
-- 
2.51.0
