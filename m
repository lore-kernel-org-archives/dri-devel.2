Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C1606A329
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZOAXMfSB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57EEC112737;
	Thu, 26 Nov 2026 21:44:59 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1FBB112736
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:44:41 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4ad6219f7d8so6744216f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795729480; x=1796334280; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RUcRI6foYh8f1Ya5l8kqwU8EomhWJwqw637x4+2iJPc=;
 b=ZOAXMfSBLBV5VFQ/9pgeAlCelkUeI670rvbUQCJ/UGk1tZECsNDUt42LWx7T9b3OkF
 vcd15W2jrmLnceXAT+6vVfXwqYtIoV/B9UfN3vjp1Yj9RrtdROjT2+n7UbjE+yXUmStB
 o6YlVb4YnRHwnSO/6hn80oEo/5palmdOQ2PT14AEx6Or7Q+5xAocbhyeEbpZbNdL9ePu
 zG15Ang/JpTTR90L0qLlagPXF9h0U6CyHrk2paS5paotyt8T9jU2DV4N6chpEqH7+96d
 EfPc1Rb2oYXR9y6nPpr6eAZsDUBoIKWXij6Ft5FHN4jz2exJDL4kwn+E5EWfuEVHJFs6
 3R1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795729480; x=1796334280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RUcRI6foYh8f1Ya5l8kqwU8EomhWJwqw637x4+2iJPc=;
 b=p+Tf785L6eTxxTYH7Bskqo3QRVx70jXIwvyTF/ZWXSiEfvC7ns5FeuU8JZ5xjXMtJb
 Rc6/Lzg20ceTtbr69ZcRxBlbbBCuke9orjLqGrqO0HqjsO7di5fxyqtFqXXBobqg4xvI
 D7nv46qc9/iJIDWGAlLRR+K+JnzUEcGCHRQm2kvzp3/CTncZ0AAiM6MKWx/am5JLn5Or
 YjkQAwBxs52inyLHM8WH2/MSmnL7UPKwstQMM4FJ2b93PBV3IaUnc/VFH5CozENnzrs6
 8HQ6pY5O4UJy8iXNfFyUGk3sLXfcNLHwrbGW4vJQpKN1W95TE0ftTNiwJiKx+IdQeq83
 z81w==
X-Forwarded-Encrypted: i=1;
 AL+hErEK/qAnG7DOC8Ne1mhcm3RKnYOAveGp/2EiP276uTiuUSU9tVLKkSBRCcDOUHZHcuQ8ulOu/MPBdLw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+EB9v8NNpSsXIU2h3NNTfG/9sNZU+hDzbR8ve7uF4EUnTcEgcQ
 0SxELO5MOIoVk8NmcX9jb3z8FIpHItbuN240jYe9lCZN87zkwgWL064A
X-Gm-Gg: AZFdTZdEGIsvuH9dW02gvRPX/1fu6vMtH/t7IW2btC90PNcPmIPnm8GzBKys7eGwMrn
 idvjA0j/dSOM6iimselnyWv51F9PCmn87+GvYOlbX/PySPk3D52LD85enoV9Uu4PGGTwn4NTMVl
 fNBj8OxfqKWPxSbR78eHgofZbhRoUV0dEfZAuhhZz+vM2ByY3jkbNesgNqVHSFikqm7kcAiMjE6
 QbRazKgvsqbNhpxjfkg/YwT6amyLWv2sqMluzjSMHM3+CxAnG4WxCLTGHBYX5shNDrdH9gOCCse
 30+PwA01ZublogZTb9NZKhIP1Q0xCmq6J+EGBfXk+mVE0mnWU4Tp0VucRRK/W7DK9UOUlOkzeu7
 iZhJia2mOp851/7q9zzzgmaX31n6Qb69rLCuBwzVmY6AJUS9tHAWar0batHyRvngUV5NQVRCpwx
 DvrG3sGEMNhn+r7LYGVVvo9xbwYDMqS6yuKGk4lRXCaC/dW2XOwru/jBAcjAkSHbt8Z50Vkv7lH
 AnhEewTaVx+09xkj4x92oXbg5dCghaDlbre6ancGAJ1zS3O2rf/RFBmQY5pq49DsaR6ckbDKNfi
 6s/iS9b+mKtWfHfCgHQSVh30KTU6FVuXyWhnhYsveT34Vs5WtJS32Sd/X4/k1Vm1gkFUsaLthM1
 0Eo3gOXlLWIRawNJ4RYMdmwOGDdwYJonYqPJO67tbxbCUORaN5pGx969xj2ZA+ElhrLvfEtQh1P
 tDapoIltSMxMuQk94fU9KLsHfzgeAPPpfnGDxf1RPBpor0/qDlPDcSyT4XjiEpnGfQ0E3IoaOaP
 d5W5qECMVZZMz4OawgjG2sgcC7NW8Dr2H/r71gxZR8=
X-Received: by 2002:a05:6000:2997:20b0:4aa:d196:f325 with SMTP id
 ffacd0b85a97d-4abb7f2ee9dmr30913744f8f.40.1795729479959; 
 Thu, 26 Nov 2026 13:44:39 -0800 (PST)
Received: from jernej-laptop (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm40403963f8f.18.2026.11.26.13.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 13:44:39 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 jernej.skrabec@gmail.com, p.zabel@pengutronix.de, krzk+dt@kernel.org,
 conor+dt@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] dt-bindings: display: sun4i-tcon: Add R40 TCON LCD
Date: Thu, 26 Nov 2026 22:44:23 +0100
Message-ID: <20261126214433.3562326-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126214433.3562326-1-jernej.skrabec@gmail.com>
References: <20261126214433.3562326-1-jernej.skrabec@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

R40 TCON LCD is similar to the A83T one: it has a TCON clock, which it
also provides as pixel clock, and separate LCD and LVDS resets.

Add a compatible for it. H616 TCON LCD is compatible with it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
index 724d93b9193b..05ed4ddcff3a 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
@@ -29,6 +29,7 @@ properties:
       - const: allwinner,sun8i-a33-tcon
       - const: allwinner,sun8i-a83t-tcon-lcd
       - const: allwinner,sun8i-a83t-tcon-tv
+      - const: allwinner,sun8i-r40-tcon-lcd
       - const: allwinner,sun8i-r40-tcon-tv
       - const: allwinner,sun8i-v3s-tcon
       - const: allwinner,sun9i-a80-tcon-lcd
@@ -231,6 +232,7 @@ allOf:
           contains:
             enum:
               - allwinner,sun8i-a83t-tcon-lcd
+              - allwinner,sun8i-r40-tcon-lcd
               - allwinner,sun8i-v3s-tcon
               - allwinner,sun9i-a80-tcon-lcd
               - allwinner,sun20i-d1-tcon-lcd
@@ -280,6 +282,7 @@ allOf:
               - allwinner,sun9i-a80-tcon-lcd
               - allwinner,sun4i-a10-tcon
               - allwinner,sun8i-a83t-tcon-lcd
+              - allwinner,sun8i-r40-tcon-lcd
               - allwinner,sun20i-d1-tcon-lcd
 
     then:
@@ -297,6 +300,7 @@ allOf:
               - allwinner,sun8i-a23-tcon
               - allwinner,sun8i-a33-tcon
               - allwinner,sun8i-a83t-tcon-lcd
+              - allwinner,sun8i-r40-tcon-lcd
               - allwinner,sun20i-d1-tcon-lcd
 
     then:
-- 
2.43.0

