Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D38606A32E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l6UYNI0K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF591121E1;
	Thu, 12 Nov 2026 16:21:37 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D471121D7
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:21:31 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so44125465e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794500490; x=1795105290; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+tpnmaCejDTdKprdiXgHKHQFYAbbd0rQZxDc9JTWdcM=;
 b=l6UYNI0KsiROjExGefRViRSakJsuDtI4LTY8eYwH3Y+iEEoWbi5lhrqrjxyzqJfxFd
 s+B8hiI2D2P1WiIIkfaKzZHR3kz09YQaIQBbnOnBZI4Wv1T2bHZl4Ok/75OiA05KJHhm
 ICPltIqoKDVdhBNExjBNgwaRRC93HJYQUailAtxMj0apc+iP/h/CyFFlsPMglciGyvp3
 DPeQjNjI08qOuflonFUJGfpgSBdM6ai+YT8lVAYCKs4bPh58lXcPyV3Xf0ixH6rbfUtX
 XempcmdA4o0k/sx9b/QITAF1q/FSMUt9b+ZGDykVhhryqf+5X14fo3Fyc7Dolxne2unG
 K+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794500490; x=1795105290;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+tpnmaCejDTdKprdiXgHKHQFYAbbd0rQZxDc9JTWdcM=;
 b=jRBUxUpLFUXRDtPW4tvZG1lAxmachX92akHfdcTWQpcRBTIEi4C+tpK5nBXW9X/LWw
 Zi5x3MkMD+3xR8yiGYNcSVugXyOsDsx97PGRHigIMhW0sYvGBgeTtQMq9TvK/dEKeGnk
 xB8AhlUNoTIMIVaeyBi34rifXGWeYdDFR8HQWSoq/f1hAOfoiNGlMIZewtf19E0BIW8v
 Ili8f+fsb1DBC1KiLEEp6F4XIKnEhh8AyyOgjPIo3EubkdBSQXiPzpK2i2MQ1VNat2Ro
 V0GZZI5rF7YKiRrWNty8z+KeW7Ly2IqoxxAyVYmn950fOYjmlgyAop6k46VDTojhh9O/
 4R0Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGFSjvVxQlRfV4tWQ1DPMt2LqkVsiw3QuOtlVFEUPbVGtZYiaJr10FpUo3cr6fhD7QLSh2Pgh8w7w0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8jGiCADiGSlG/RAHq8fMw3AwWiD5aHY1HP6Wuxd9MbCHRmP5T8
 ct5cSeSVux1uMCQ7pZmzv+N5VkzX1We+2PSD7W3KVQYkUco1rxNSBVIr
X-Gm-Gg: AYBFou3pwrV7yDO9znkepXyIWmcs3WyGHDpo/cdXStWvf+on8pSwmBAfWhDtwp18fHH
 doV9h3Blcy8vV/wVWZEokkbu6VB448uHB/6cYynDZUTrscxyNMhb/3O+pwsxuS5mbZXiRXqVJBT
 1AXuXDBqZeFSy0AYKmyHT58b0ecEEhTgjzfZnt3GVOYKwNImbzmZjpS09pdgigPtw1vL30LbOxq
 Oo12nBAFcRvlqnNAsXHd7d/2uUGazvfVLejGfgfUl3BNI+lSqp1ASW5cT9+i7TSFi3eu0RPnUFY
 ZP2K3nWRiu5xDI1OQ1UbkFigNuXSWRGlq2W/Fh9tV7X5W8E8yQ5bOPjyzKh+gNWBtyUDkprxoE4
 enV97e4Nmvb/4uUN0iidVBeqkU3zCQyRx3beu0AnWsTDag0nNpgLwl3u344K55SfJ2WZFJNmvp2
 HHYqLKa6NsrpF7LrSTcM2j0MmJCqK1GchaAtiFpGtJlJS/ZOBA3ZRNM0WygIv8TUibbhQXHVNDO
 02VYAWLqonfS78lKtFDL9F0RkYm3kNbmUvb5uGEV0klsQv0FI2RLa+FyINwA1A0s277gJ44e21v
 zIpjkNZA1D+NHO6rGEUAiZ6lHb4=
X-Received: by 2002:a05:600c:8b21:b0:4b1:32c8:27db with SMTP id
 5b1f17b1804b1-4ba093b9e0emr115495835e9.22.1794500490185; 
 Thu, 12 Nov 2026 08:21:30 -0800 (PST)
Received: from localhost ([5.83.201.131]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0951f237sm97155965e9.4.2026.11.12.08.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 08:21:28 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/bridge: tc358767: make read-only array ext_div
 static const
Date: Thu, 12 Nov 2026 16:21:27 +0000
Message-ID: <20261112162127.1592210-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Don't populate the read-only array ext_div on the stack
at run time, instead make it static const

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index f61c619fb305..3735e8db9e82 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -593,12 +593,12 @@ static int tc_pllupdate(struct tc_data *tc, unsigned int pllctrl)
 static int tc_pxl_pll_calc(struct tc_data *tc, u32 refclk, u32 pixelclock,
 			   int *out_best_pixelclock, u32 *out_pxl_pllparam)
 {
+	static const int ext_div[] = { 1, 2, 3, 5, 7 };
 	int i_pre, best_pre = 1;
 	int i_post, best_post = 1;
 	int div, best_div = 1;
 	int mul, best_mul = 1;
 	int delta, best_delta;
-	int ext_div[] = {1, 2, 3, 5, 7};
 	int clk_min, clk_max;
 	int best_pixelclock = 0;
 	int vco_hi = 0;
-- 
2.55.0

