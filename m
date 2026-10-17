Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98364CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4B110E64C;
	Sun, 18 Oct 2026 14:53:14 +0000 (UTC)
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D637810E325
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 08:36:23 +0000 (UTC)
Received: by mail-pj2-f8.google.com with SMTP id
 98e67ed59e1d1-3ac749e0719so156127a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 01:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792226183; x=1792830983; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tDddWpoHqTtkxFsBbERUVZlldFJw6rS3OQ/sbeQSp+8=;
 b=WSYjMHVxdl4li3JmDx2IrsOSOpjDMpAXfaECwf42nr1FzygNMadW9ra7Vjp6lDpNAD
 w0478f2o+v4kwhB6Gqz/2idNnHVJq6IYjDns/O9qfYLISmnPNarE4HhXlUIOEE2RWMLm
 cB+Z1tBLccBwIX0RVSUGsX+bPYwS8dZHrYaNOxPg8P9aEg5tUwhsllrrAphcZKaQu0X/
 IC+Qycn7aaumFjCht9ZWy8Ice8QvOWGVBN0BVquc8flK1Mbq6BY5kMLojDNO6xswvlLe
 9TG+jZco44bRq69hD27+q7SSECSRf180r5Wo9MGnQvwjrA4PVosati4CsYtBY2L1ea+1
 zYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792226183; x=1792830983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tDddWpoHqTtkxFsBbERUVZlldFJw6rS3OQ/sbeQSp+8=;
 b=1yLZNWwqLJBhWMmcBCdOPesPdHiMuGinJsQeCPN9ziI3zoquA69CR5+pIZ2SeWmdbh
 2QpnKR/crnip1wOnh2e2yXn8E/Gd8Z6ZzvDmN2D8U+iqo1ascmzRHzNMHu0HJI1YI7yF
 nchBFx5hN6lFt+I4SwUlvUb7dlYizaF2KsKbpNnQKjvdfNB3qDrBKzUzz/0iZo77s6zO
 t/+QSmxKCFAVrBPiaW0iRaztFtzibeQ0SYDC3nkMvmRbXXz4rkAq1zrV9MnN5RCB03+p
 0iGaX+x4SadRkbCcFUb0VVcL1Y/stbtt5jceL7zocaLciCkx8g8PfH896+yDTH2h8TiN
 1dkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy96oIKA7lGZyqUs8n3UAur70OnOgEAaPuWGBJKZy2hz1q3cKaE3Pzsj+e51Fawmfv5HQe82UIDPBU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJVyduDusDIW2GHiAMn18tSSEGVO1oB3QpIZqhiFMsZez8NUyW1
 vwJXp63cVUBO3N7kJEoQ5a43pIcaKeFl4RXLBrGkCRJdzslcFmYNTHid
X-Gm-Gg: AYBFou0TczJW8pUYgtkDdAO672SX5Y9HI/uL7hwACghnZY84NB9RVb580g6D5lg5neK
 QxfMOsygLn0w974ib+CbcI7rYNx/0WVpOWiLxUlI1mXjaE6N3if4GVvAhP87T4HD+59k4gdDx32
 TWA6qMSaGkrGOTpVjQqdSONSPEzxTHfyh62FWk9CWa5xmxON4HbYtid4pl2RwlOsuKkjJi9yljn
 2Ag06jrfslMUg02upMY+pXZ4TARkY1GcsIQFAM5wAtm3CGJlUwu+O33ebD604/dB/kJHbIGTp/l
 /yvQL9/5w2jqOEEWQZg+SUxRrd4HlMF1Mp1K8iOgIOXWHTiSrRn91ip+s2rBvLF6uItP0iv8CLz
 KdbQhWYqL1TgaXRjLTE8aMUUObTz8lxzTfWlD/dk7MK1TmlzngehnhC73DTkYoCv5jVikq+F12r
 Ni/icS5hkG7U2Owhiv53YjGEcHrJERdOWjnwqd+zRriafWjb3j0xHRiV0=
X-Received: by 2002:a17:90b:4403:b0:3ac:8897:7bab with SMTP id
 98e67ed59e1d1-3acee277aeamr1748958a91.6.1792226183357; 
 Sat, 17 Oct 2026 01:36:23 -0700 (PDT)
Received: from Linux-PC ([2a09:bac5:1f0f:3141::4e8:8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9461d71esm12548544a91.7.2026.10.17.01.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 01:36:22 -0700 (PDT)
From: tianshi12127 <tianshi12127@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Lu Chen <tianshi12127@gmail.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add smartisan
Date: Sat, 17 Oct 2026 16:35:29 +0800
Message-ID: <20261017083531.766557-2-tianshi12127@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017083531.766557-1-tianshi12127@gmail.com>
References: <20261017083531.766557-1-tianshi12127@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

From: Lu Chen <tianshi12127@gmail.com>

Add a vendor prefix for Smartisan Technology, used by Smartisan
devices such as the R1 (trident).

Signed-off-by: Lu Chen <tianshi12127@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..6ad8d3499227 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1535,6 +1535,8 @@ patternProperties:
     description: Skyworks Solutions, Inc.
   "^smartfiber,.*":
     description: ShenZhen Smartfiber Technology Co, Ltd.
+  "^smartisan,.*":
+    description: Smartisan Technology Co., Ltd.
   "^smartlabs,.*":
     description: SmartLabs LLC
   "^smartrg,.*":
-- 
2.56.0

