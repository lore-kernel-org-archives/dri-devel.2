Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E328BC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5A210F2AF;
	Fri, 28 Aug 2026 07:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RxgrGr8r";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE4B10F26C
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:42:25 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47f502ff678so72078f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 23:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787899343; x=1788504143; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ktRMVezOHSXu+KrKQhXPWvOXAM5roEQ780FkS0ZUNoU=;
 b=RxgrGr8rqa3JXNqc7s0jioJ8ZJn9vSntiJE4O97KoJMS75yz42uQ/tUDhpud6C8vjF
 Nlk3vY1BAeWzYlk9jFalKPXOgeZSAVhcClT1WpJWUFc8KJeKSoUYZja87F2xsuGdh8DD
 m38sIX+Tds+yzPLePiI6T9GyhPvdM5tPpzHfVN3uR8Ynh/rjx2helTdUzTXqtZyup+6z
 J6957/m+LgCtzToVnJEQmojiWCsubwfV/JYRDcXeveVqjajsEeIx8XrwsExfUSEQX1N7
 wmpt3lEa+AWkcw2DGTBZDHrfd6mJ+lsLiu0oUZSezIeiHGlQgUIAeGsQ6AcoHioIdZWs
 wkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787899343; x=1788504143;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ktRMVezOHSXu+KrKQhXPWvOXAM5roEQ780FkS0ZUNoU=;
 b=E6JID9PXAEfhdd5jBnlUbN9rqaPVzh/sEPPVcmW/QTbKy5mMxaI5p2e7OblKFj7bqw
 gWvmyXVlKOQfXRX2BLZ6S3LJWhrJWp+6MaMG9ymyWNmlCJVm6dM7uaLyFxh7R37zFxkA
 WfCWE3ZD4WLxgykn1YdWDDyWMgqtAo17RKUWKkph0BfkxGsomF+QRVo/fd7b+BQI5ETi
 l5WURUkqYjMGXjLINA/sV5S56s2XGxclsBughG6c0H+J579vQUgxcc807Zt9Hxe+8qvt
 k/t1vVpQ+jPzP6n/a3uG8tIIenGBjeb837KgZphablRLl2PVTkCPAgne5U0l1TWGfrIw
 HdUw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQfFw/+cEKfg6gLTv8c9WwiPRz2U7E0S064fIXCTPlXlB/1PrwmP7grH27GhMGIl6cFkYsvVJHW5A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kNF5hR4NFW64T821ehwOteQXmHh+L0WoyGQfkavBHdZYaICWXs
 mAsUNJW0UlR7C4f06VBVPdoG28z/6CGi0rS9QC8ki3ga5KOG3Bvyd4/7
X-Gm-Gg: AR+sD12QC0QNaTqFYM+G6yVcYedmwFQ7cxi60lkU025pY9+/3ybXB9ZBIYiTPjzg3wg
 1Ys/XLvRZhi2MJ1gVuYfuRfhJTdYAA6m0Ox9PePLnQevNXm2iA+LTOS8h2HtMzuFKqIO33lRHCD
 7yKGObyt99EKwraNovgu3acTHAnDZnQoK85d6RsgxwnlMXClbmkrvZpbvJtoGZzz+ZmlKxHS/4f
 jFX5HXgU/yhsypwX9BN2SzmnXRzz6n0MvmIwWiUEf6XASUI+ivcJPmSYM/HBXcNSyZzzk1FeAKV
 XOHsNw9sRr13/TfYx8mEqk0Gc6vUa6DzW5AtU6kmvoucT2cxTdtScrf/sx87aIYwH6EwH7Fte6O
 uaammMQiC4AzZQ6JStCAt4UC0ePQNVmB2CU6hkAKNm+hk7bjSqRaAn7VCLUAUOW700yVej2H+F+
 FEo1XnBYhu4Qz1+lOY3SMBqIpwXkZwpCkONOmdtWdOcKNQSDkqVEjQLUhKfTeERhghPy2vgpzdB
 EtBnfkE/qCL+w==
X-Received: by 2002:a05:600c:3103:b0:499:cef6:104c with SMTP id
 5b1f17b1804b1-49b91c39a77mr31949355e9.1.1787899343257; 
 Thu, 27 Aug 2026 23:42:23 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b945816f2sm33472195e9.8.2026.08.27.23.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 23:42:22 -0700 (PDT)
From: Dmitriy Okunev <dokunevdmitriy@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, lvc-project@linuxtesting.org,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Archit Taneja <architt@codeaurora.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: tc358767: prevent overflow in PLL calculation
Date: Fri, 28 Aug 2026 09:42:09 +0300
Message-ID: <20260828064209.4314-1-dokunevdmitriy@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:44:56 +0000
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

In the tc_pxl_pll_calc() function, the expression `pixelclock *
ext_div[i_pre] * ext_div[i_post] * div` is calculated using
32‑bit arithmetic, since all operands are of type u32 or int.

pixelclock takes the maximum value of 154 MHz (in accordance
with tc_edp_mode_valid()), ext_div[...] takes the value 7, and
div ranges from 1 to 16, inclusive. The maximum product
(154,000,000 * 7 * 7 * 16) is approximately 1.2e11, which is much
larger than UINT32_MAX, leading to an overflow and, as a result,
to an incorrect value of the PLL multiplier.

Fix this by casting `pixelclock` to `u64` before the multiplication,
ensuring all arithmetic is performed in 64-bit precision.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7caff0fc4296 ("drm/bridge: tc358767: Add DPI to eDP bridge driver")
Signed-off-by: Dmitriy Okunev <dokunevdmitriy@gmail.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index e3a57f8228da..39633f618664 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -640,7 +640,7 @@ static int tc_pxl_pll_calc(struct tc_data *tc, u32 refclk, u32 pixelclock,
 				if (iclk < 6000000 || iclk > 40000000)
 					continue;
 
-				tmp = pixelclock * ext_div[i_pre] *
+				tmp = (u64)pixelclock * ext_div[i_pre] *
 				      ext_div[i_post] * div;
 				do_div(tmp, refclk);
 				mul = tmp;
-- 
2.53.0

