Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA5FC55838
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70BBA10E727;
	Mon,  3 Aug 2026 16:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HmIv2/Zn";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E8410E727
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:11:43 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso491825e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773501; x=1786378301; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QwcCW5bnIxEMSTfDGEDmQeCwaEieT0mPnUwcX4qTD6M=;
 b=HmIv2/ZnQvNhe4kETF6AsJMCmjO0iFebJ8TkFMEcKr3B20uR+bKNglFk2NYoRTUCIK
 y4COHEurGq48GvpnFwga/HVOvf3d++pcxkf5ux/xUR/4vAlw+69lpjJ3qvM3yM5nqvRQ
 JhLqMqSTFv/KB5kQ/7BMjW4//wYZKD1vp4H/b8SlbUWanck5eJiBgo/2iXmU6D26Z2Vp
 s5Wg9BB2CEbXiOJWAnJiXU0bOeg9bkUVHeyVtuVjZ1dLLEyrBpPdVp7ZYf5uQZ0YPYYM
 v5HkPQXfiAfFU19xzhnM0qKGJAa9jnVoTI7FPhuCFbzEdpONvesSBalEPl/6jPzEkuBG
 mb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773501; x=1786378301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QwcCW5bnIxEMSTfDGEDmQeCwaEieT0mPnUwcX4qTD6M=;
 b=aoUJqIo5ZM3iXJ0W5I/Jln3Atwk9hiL16yEwkb4AAGQbx7teNRbXRjYextlSiRizO0
 W0G96eyz+7U/cyUM3RrYO5ZCWL7h4AGUAegFVW2EIcHbX2Toai9QIHfg75FMaW6kHp//
 kXYVMWPu9kxGjGzllKZVPIsixEm0sP/V9BB9qDubCMRkO9l4zw2aoTK0/Fxj2lnmNBrp
 v/EHelXo7F26rHWG87VBYyrSMyxkhNvpG1ranM1DfzRfr9CX2og3RrOcGTbrMh7eGUW9
 Xxl4K84A2xAmPHUYlfZMnN594uOkdC3uQny5v6xHLjoKlgVMrPfoQnCbBD3MvYEfqBoB
 eaSA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrs1mIj+dA2Qq6dzaH5kJYb6wLaUrH9N/SGXzSZAmfZmSnXuHT32VPRcM6sF5NenCXzRYcwta38BrU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwoulBEZy6Z6gnvj9b0LSAopqZiH+3yAj3si+OcZAGaAzZboHFf
 Nmu+FGZBIA0/lN7k3LZb5BYnndrPeWpZ7kTE8ixdn7wyYWajwoyXpKrC
X-Gm-Gg: AR+sD1260fXcwmAMgZlsTTijfUbUZ6EovnowX8AvJVzXbDiN3WedI9YxOjV5g4pxJf/
 JA3PTaNPcfvG6KYRgXAIAjUfM5hCCMIIx3d3DA1eZK5smal9BzCJBq3l22u3DAhg3q8UWzUXnQc
 LtCvWuvf7f8PjL9CGv6bnpUzdHXdtPpN/EdruTrhEjTeqiisj2gputj0bxQ41T+6dNmRDQTuZfm
 XlBsMkdSpUjvjZvSG5EnaioaDB73/3xIEEx77lJdYQFx0TodZdHwyvV7vtZSVB5zQTyaZa7vsdu
 jyhREUTG9JWroO+lFi3o/GgVTSYLkUD/BLCUtrn3iyfI3VzLHqP2e9LDAh7lhgTvRiTEaDmwtX+
 mhwcXEVMJ0erGc8SPRs5coe/32/VNiNQ6YYX+c/9gxT1VahoxDidFOfbCSornmvUZSXihfb8MAH
 TSm9pD14J8JwON7nmg/GTEvDhR9rLRbfxYtP6HPzbEoGQjTxLU91koGa1B3khHm286JD0NLyS+O
 L9YHHpBqsW2pC4HmtiliQ1qgFFY3wk8zuZA81CSu8GofN3WpAiWwY1Hp9+b3Doz0FmWKq6gleoB
 1P8ahYZNaaL59mA3/3faPZA/wNKKG1S8YCNg5SNLqnSEBeO61jNooFlDlh3x9UkL9w7ObczUcaY
 aK55eJQaWo/+lIvaQj9AjBhIqAvr8Qm7HbFZ+RC0m1Mn+aeKiwM7xel40fEGojjIewsz882pN+U
 bs8g==
X-Received: by 2002:a05:600c:8010:b0:495:4f84:7280 with SMTP id
 5b1f17b1804b1-4994a0f6838mr3426715e9.4.1785773501354; 
 Mon, 03 Aug 2026 09:11:41 -0700 (PDT)
Received: from jernej-laptop (APN-122-100-117-gprs.simobil.net.
 [46.122.100.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm3363735e9.3.2026.08.03.09.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:11:41 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 12/13] drm/sun4i: hdmi-phy: Fix H6 8-bit MPLL config at 594 MHz
Date: Mon,  3 Aug 2026 18:10:50 +0200
Message-ID: <aec9060209473b8176eb43bc7c63c20b21306adf.1785772659.git.jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785772659.git.jernej.skrabec@gmail.com>
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
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

The 8-bit entry of the last MPLL row (594 MHz) doesn't lock reliably on
H6. 4K@60 RGB/YUV444, which is the mode that reaches this entry, doesn't
come up.

Align the value with the vendor driver. Other entries are left alone,
they are used by lower pixel clocks which work fine.

Tested with 4K@60 on a LG TV.

Fixes: 0fb4b858b102 ("drm/sun4i: Add support for H6 HDMI PHY")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 4fa69c463dc4..489ea94693ff 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -91,7 +91,7 @@ static const struct dw_hdmi_mpll_config sun50i_h6_mpll_cfg[] = {
 		},
 	},  {
 		594000000, {
-			{ 0x1a40, 0x0003 },
+			{ 0x1a7c, 0x0003 },
 			{ 0x3b4c, 0x0003 },
 			{ 0x5a64, 0x0003 },
 		},
-- 
2.43.0

