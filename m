Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3733FC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFB510EBB5;
	Tue, 22 Sep 2026 08:41:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p6MX86H+";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83B9410E19E
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 02:48:26 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747eefae4so11286025ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 19:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790045306; x=1790650106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=273RPbWG7jPvSKiSM2cb6VF23JcSKRk4gJRjLYycPbI=;
 b=p6MX86H+IhobqWqjlQeZcEmcNYiq0XMKsDFAum3kiq6LHI/bC7iXJyNrbT9u8B2cr2
 RittpuWNHQrkBQ4hoDCaolzlBxa+LFH23CBtAlr7H15cL/b9oBA5ys+cdcOtT6P0jweF
 ckaJL5n2DWkfoLI7DoE/fRiaCkSFQzPt6SE1cM4rzVvUeJOJWAVn8dBrWBTNGyUSlHiV
 j3y9mCsx/eYJzAMhTslWwqlmfAle5IoDsE/9/W8ovJzWdc42wy01iXgeFLGKfxxDKLfw
 dup9Gzm5vgHQjSiCDyrF8VHjWZfbV4nh8phxEkCKQYrGk2uiFyMCiH/gz7vInTg5QLST
 IWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790045306; x=1790650106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=273RPbWG7jPvSKiSM2cb6VF23JcSKRk4gJRjLYycPbI=;
 b=yoToo+ZhtXGttFoBxQzUn6DJXWMA8cDD6HNNctKy/GXBq9hexrhgFruchsJGs8n/DR
 nGsLZZz0F0OlK4j1dMum9EXZPoN2W/y92n+lpRL84vaxQtw6wxwvWjPWRr3w1UxjZJZz
 eCN2f4LrKgcrKzEblW6tAlZiXGcU3JPP4Sg5i72RyI29X8xySh7KSuL/NxpmI/xHDzEp
 djoUuNbGx+P2mI6LyIXB3cmLxg9nPCKholUTo0pk1Cf2U0ydLOawSf2FEnSurauVybgn
 G9hg8L9jYPurT3B490xdnNLANhfZjQ/g28lKUQnZLoutpvVGbFH52z8A60J/3LVYh3ap
 omRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMAx8G+J1CKR9hcTBLla907hK4KaOfU6Zpfm9HkfyJk7YdxFEk6M7NbaOSGu317NC6acCdxxF5MKo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lpP9bbbx++Y5VMQ7AWgJfjkCDLbfLlgy3XfnAHUuj5n00xCqAc
 ZscoEWdvWL/t566tA6zPRJfk0liK2ijeHSokzbBtwefbGABtuyGVQC/q
X-Gm-Gg: AYBFou2KP9CHiQ6hTokgSWGxxx+iWzCAuFP4RRB+1PQTiHlu4kiKr/vxegFtYLnUBWD
 lvG1sGj8OCCvXX4zU9wHo5O2pDlF8hfd8zJBAR5II7bX1SWVHuW7FkrIeHKBVlJ7BLFVi5DIGeC
 ah77XjYe9MvE+CUMXzm2PR3n8RSVOT84xv7DkmtmSY4xhNG5bP2b0EmA20CIZ1gmI1GppT64otF
 qMOuUJMuimSBzl+cN80HmF6kU62AcWNbmyiK+eLpHiOImjGgQgRGce03+rTW8iXkH60czoKjgfJ
 6G7NK4z+HCvQV5dQ3wRxnx4BtB8bsXWtKFhpZwLYzTwoJCjoZe8VOE+qXFKyflM8LMz+svkVpLZ
 zC3jHyedLm49kaMXo2hWOik8tCsWxjvgEcaCnKRXXpcAw7pSpoZ+Z58BvZk9LLCE602cMXXn0wU
 +QBDGKgtsE89O9r/4whIvemJRt40Y1WfGpL8B5UYLkTkSnuzQF9l6UGjuQXE/sDIOzoO5BPA==
X-Received: by 2002:a17:902:e54d:b0:2df:42af:2fab with SMTP id
 d9443c01a7336-2df59a5a817mr14138975ad.34.1790045305892; 
 Mon, 21 Sep 2026 19:48:25 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d02eb4fsm1636465ad.37.2026.09.21.19.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 19:48:25 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Hans de Goede <hansg@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Minas Harutyunyan <hminas@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Inochi Amaoto <inochiama@gmail.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: [RFC PATCH 1/5] phy: core: Use EOPNOTSUPP for disabled blob return
 value
Date: Tue, 22 Sep 2026 10:47:16 +0800
Message-ID: <20260922024724.191412-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922024724.191412-1-inochiama@gmail.com>
References: <20260922024724.191412-1-inochiama@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:40:51 +0000
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

Currently, the phy subsystem uses ENOSYS for dummy blob functions,
it does not reflect the function state correctly. As kernel already
has EOPNOTSUPP for disabled blob function, replace ENOSYS with
EOPNOTSUPP for a clear return value.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 include/linux/phy/phy.h | 52 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index ea47975e288a..3e84b54a4b03 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -314,14 +314,14 @@ static inline int phy_pm_runtime_get(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int phy_pm_runtime_get_sync(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline void phy_pm_runtime_put(struct phy *phy)
@@ -332,35 +332,35 @@ static inline int phy_pm_runtime_put_sync(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int phy_init(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int phy_exit(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int phy_power_on(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int phy_power_off(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int phy_set_mode_ext(struct phy *phy, enum phy_mode mode,
@@ -368,7 +368,7 @@ static inline int phy_set_mode_ext(struct phy *phy, enum phy_mode mode,
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 #define phy_set_mode(phy, mode) \
@@ -397,35 +397,35 @@ static inline int phy_reset(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int phy_calibrate(struct phy *phy)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int phy_notify_connect(struct phy *phy, int index)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int phy_notify_disconnect(struct phy *phy, int index)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int phy_notify_state(struct phy *phy, union phy_notify state)
 {
 	if (!phy)
 		return 0;
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int phy_configure(struct phy *phy,
@@ -434,7 +434,7 @@ static inline int phy_configure(struct phy *phy,
 	if (!phy)
 		return 0;
 
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
@@ -443,12 +443,12 @@ static inline int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 	if (!phy)
 		return 0;
 
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int phy_get_bus_width(struct phy *phy)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline void phy_set_bus_width(struct phy *phy, int bus_width)
@@ -458,12 +458,12 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 
 static inline struct phy *phy_get(struct device *dev, const char *string)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct phy *devm_phy_get(struct device *dev, const char *string)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct phy *devm_phy_optional_get(struct device *dev,
@@ -476,7 +476,7 @@ static inline struct phy *devm_of_phy_get(struct device *dev,
 					  struct device_node *np,
 					  const char *con_id)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct phy *devm_of_phy_optional_get(struct device *dev,
@@ -490,7 +490,7 @@ static inline struct phy *devm_of_phy_get_by_index(struct device *dev,
 						   struct device_node *np,
 						   int index)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void of_phy_put(struct phy *phy)
@@ -507,27 +507,27 @@ static inline void devm_phy_put(struct device *dev, struct phy *phy)
 
 static inline struct phy *of_phy_get(struct device_node *np, const char *con_id)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct phy *of_phy_simple_xlate(struct device *dev,
 					      const struct of_phandle_args *args)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct phy *phy_create(struct device *dev,
 				     struct device_node *node,
 				     const struct phy_ops *ops)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct phy *devm_phy_create(struct device *dev,
 					  struct device_node *node,
 					  const struct phy_ops *ops)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void phy_destroy(struct phy *phy)
@@ -543,7 +543,7 @@ static inline struct phy_provider *__of_phy_provider_register(
 	struct phy * (*of_xlate)(struct device *dev,
 				 const struct of_phandle_args *args))
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct phy_provider *__devm_of_phy_provider_register(struct device
@@ -551,7 +551,7 @@ static inline struct phy_provider *__devm_of_phy_provider_register(struct device
 	struct phy * (*of_xlate)(struct device *dev,
 				 const struct of_phandle_args *args))
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void of_phy_provider_unregister(struct phy_provider *phy_provider)
-- 
2.55.0

