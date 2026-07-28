Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6682EC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90C4F10E826;
	Tue, 28 Jul 2026 09:18:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D6odFugx";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6A1A10E826
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:18:35 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ccf2360620so33824555ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785230315; x=1785835115;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wxBpcLwQpOW2vKL5WhYL3BFfyuddH3BZqW5fz8lS/T8=;
 b=D6odFugxc7KCRJr2bsYH4KS7YJDEjRccL+aphTcYmlZnAHGRt5BPffRIoP33vKT/xL
 AdDxLOSQijCv61rp/LShKn6q2lEBf2W0X0IFTkTMn2LQJ9xdA07Z4NiSxvue9i61LUsW
 CsdgNSBvFpP8nUnHhPKekr0eWKDObudivxY44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785230315; x=1785835115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wxBpcLwQpOW2vKL5WhYL3BFfyuddH3BZqW5fz8lS/T8=;
 b=NdfS4c1RniQwmuGBCJsoLHIgLLaoOuS+7kCQ0fVzBY5XeSRRsXG+6DayEbKiKFZA/V
 mFR8faPZgrsyhcRcgm1OQpjib+yJAFRE0tRYfTbmFfIgcfX+wuoLIlQAChVy1mlUjB76
 HDiE810mCbu6JvR9PWO7xdHqJrk9Uhh1Vy+lQN1KN1RY8Ag5ICh0kj1Acca7fmvYPNM8
 biJzuCAdvKrJWpp8PX/WhIF5OAweWSaiV4fF1ePEgzbipUdllilBfRsT6PwYUPyuJ6V6
 gXQgbCFIfQGSO2v0iQOIxMk1DBQUIHaHGnuAGHD/Q3VmTXqRGvsdmLTI7Lh/jHcopGnO
 uF+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJjni3e/tVbTOEGpGBrantGb3/E4ybL79OjOgCY4AWS/aILvO5DsS4HQ4MOpm8svPfaHddX8R4xns=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxmar6nWCNW8nRkRbTYljWlVuPpnJzJn92pN9umxfUcEVtzkJe+
 6tORk9KtySs1MuBgeZjwbjSSJd5YdJW8T2Y48drcPp407src8pbmhiBN5z+HumaBUA==
X-Gm-Gg: AR+sD12uUHQtOO/BJ49YD5KzUdqPXOeX7ug1f3LTyG331mKWsA1Gk5CSBkXc+1q3dlU
 8CXY+v1S8jys4OEjMuGpkG1QPwtgcPGo2hdqJiVng+Whe5wpo7LT9lC+DDbkDAOQkzZEiKKVaCy
 U/vVYjrAMko5bkQTCp0yCJ4T16SpElROaM9tXnRBGhyi9SATN626mUl+7RtrG4oSNSiawFebYB1
 /6gyv3LOVH5+vVYAii8d3XwZlZ8welmkGQMPKwD1WpyWLsLseZVzDeVygEnds43P7m2uJKiklHx
 Y+RliLJNS++b77ZKe4inWOvlTQmgqGF3ojgW7o+cOchsKsxINE8YX2LDpF+/PY2ycGhUniyyFh3
 cUwLaDmPfp1+yyFhHRzLptow/jr1Q6WvNle86enG7JN1K1ENuRbJgcHf5S3r3DkVzfl5IqKT3VL
 eUKF89o4RJ6xqbClwdPzaTkbhVP7too7vyzcrbTaXSjIPIkRtpgQCGBbQXxMI=
X-Received: by 2002:a17:903:8c6:b0:2cf:6f7f:55d8 with SMTP id
 d9443c01a7336-2d015cfb0e2mr18391495ad.37.1785230315142; 
 Tue, 28 Jul 2026 02:18:35 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:c85f:b2bb:a077:d544])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde81dcc1sm48616965ad.84.2026.07.28.02.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 02:18:34 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, imagination@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, YoungJoon Lee <getfeus@gmail.com>
Subject: [PATCH v4 4/5] arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power
 domain clock
Date: Tue, 28 Jul 2026 17:18:02 +0800
Message-ID: <20260728091804.382753-5-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728091804.382753-1-wenst@chromium.org>
References: <20260728091804.382753-1-wenst@chromium.org>
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

The MFG_ASYNC domain, which is likely associated to the whole MFG block,
currently specifies clk26m as its domain clock. This is bogus, since the
clock is an external crystal with no controls. Also, the MFG block has
a independent CLK_TOP_AXI_MFG_IN_SEL clock, which according to the block
diagram, gates access to the hardware registers. Having this one as the
domain clock makes much more sense. This also fixes access to the MFGTOP
registers.

Change the MFG_ASYNC domain clock to CLK_TOP_AXI_MFG_IN_SEL.

Fixes: 8b6562644df9 ("arm64: dts: mediatek: Add mt8173 power domain controller")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 78c2ccd5be13..556e806b7787 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -505,7 +505,7 @@ power-domain@MT8173_POWER_DOMAIN_USB {
 				};
 				mfg_async: power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
 					reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
-					clocks = <&clk26m>;
+					clocks = <&topckgen CLK_TOP_AXI_MFG_IN_SEL>;
 					clock-names = "mfg";
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.55.0.229.g6434b31f56-goog

