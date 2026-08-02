Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75638C55175
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 451DD10E424;
	Sun,  2 Aug 2026 14:35:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PpjQ1vRe";
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 604F010E419
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 14:35:32 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7eb42a2f5feso1274072a34.1
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785681331; x=1786286131; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Io4qfNiJxrvTXDG74iRNZw9/a8wNffmXNJvx5MlsNa4=;
 b=PpjQ1vReN3b4Sx4uk268jM2tWa4D0nhQv4mzddRryXNsMRr6kbf9952fxQsvZSUB4B
 1DB7vrEy4CwjOaLCoSq8izDkQmipCjcdAkGKtaui1MvriW7wO2R/RpBD/i5vx6MATQu0
 Ya7kgUBUOAIZQwYej2dGH/dcdfF1LsrDyx2Haj90WsqRa9SsPZKKQ6nwgHkDlqjwKGAL
 3l7+Tl/7k7sW/Ym8E4BWhC9ZG9HpvM7qCBxwdwpsQyTaMW02kDcWCSqpSB9RemZ0A+jz
 yOHGV3spLQn+2t9SI8UsXvcv8bplkOCKg1foQ30XOw4i4t5Va4DlgIpg79XIEyeam9VQ
 VgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785681331; x=1786286131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Io4qfNiJxrvTXDG74iRNZw9/a8wNffmXNJvx5MlsNa4=;
 b=g+q/dQWRPr4NHRKf+DjYK7fyxCbZqODtaa85/4TGvyl5EaPkiz1EOkMoU4wPTSQRS4
 lw+Y8/dlQYkf7Io6cDr+jixaM7no4ErLW8EIr6W3QZWUEFTE7eAl1fr5l83HGRSOTJMc
 eBiYticyLMtGoEXw7RvG0hMDelftX92z00lM6/KPwMCg+xhSZycxD46QxruY8HP4DwjN
 cc+QyRLT70zm2WxGYy1jIF6c3feHswTEpcCsFwUElIS4QQbeFhBYxCTx1I6OuwILUnbW
 ELwOQQ66Q20q1tkeLN0Pj+FqlLIuv+pIllJX0W/r8DBg2MeRia+XWcD1g3uZltmBI2mr
 IYlw==
X-Forwarded-Encrypted: i=1;
 AHgh+RquMwhrRwG7SJqc7bf5BpTqTMzuNCqcRrXIEqYyyKSogLo7tnN8s77K8tzf7YKipNoLGT5GjrWsu6I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLg1oFyXbb4k3KN6QNqzapIh86iEwtDqFteX6kMBnuBBYi5Qhq
 0ig/bVbnVmhzKrSnqONjQZJhEgkFtXaGBod78FSfP835L4nqMjbNLkcvk6T0GDIIkV4=
X-Gm-Gg: AR+sD12dbd9hirb0WmAX/pJtCGLEuzQeQFmLHJ3XZ0LyxvRe5kUgwG61ezOFygO7vmD
 LsfiFzFrCTC6XEq8JfG9kgon8e7bOVEwnRNcROqC+7DU/2UPdTHhQ12nAwsIePRkWjHMtB2QziL
 0yh3L9u0X50/Z3aTxSCHQf/qbBpZThuCgOCh0e3OYkL521jIl1JAFPWQ5vn8KcEazgCF/JSPunY
 I4Gb6sXBPtv81fYA0S9hOKbVr4BQckJ/yJHw2FLUTo3UV42shdQXeV04gZkx1r/e0f952MhBYPq
 EePGWtDKtr9EKsTSV0P2cf/M6NUOC/a+oXMbFIiLlsen13oNihKHa2tjmnsZCqpKA2wtAELx/kt
 pFkGCDUFlTrWDjKhtNF1m2OyeFXe1lJ/RrgVTnM6FoonkA7MXaNYPWtBGWnKrBJAxvPKHye3xL9
 QPupUrZB7qR0kQpkJlayEdOj54Xh7G8h7/iRLB44n9mVZLhB34b2jzH/FSgOcdaAgC/j/qZd5I4
 dazdlp7AUjJsWlJuPfp6inokJ+0Lt+KKluUG2ue2v6r
X-Received: by 2002:a05:6808:17aa:b0:487:530f:5754 with SMTP id
 5614622812f47-4af5e2f59b4mr12709212b6e.20.1785681331520; 
 Sun, 02 Aug 2026 07:35:31 -0700 (PDT)
Received: from natebox2.jabitha.com (46-110-104-162.wmnscoaa.metronetinc.net.
 [46.110.104.162]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4af58e9551dsm4778877b6e.11.2026.08.02.07.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 07:35:31 -0700 (PDT)
From: Nathan Lucas <nlucasgit@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, joshua@froggi.es, mwen@igalia.com,
 leorize+oss@disroot.org, alex.hung@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/amd/display: fix BT.2020 YCbCr limited output CSC
 matrix
Date: Sun,  2 Aug 2026 08:35:23 -0600
Message-ID: <2fcc52cc1a86d6e9e393e72f6038ae42ccf1930d.1785616749.git.nlucasgit@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785616749.git.nlucasgit@gmail.com>
References: <cover.1785616749.git.nlucasgit@gmail.com>
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

COLOR_SPACE_YCBCR2020_TYPE, which is selected for
COLOR_SPACE_2020_YCBCR_LIMITED color_space, has coefficients that are
incorrect for limited-range output. Its luma and chroma scaling is
full-range so output is too bright and colors are incorrect.

COLOR_SPACE_YCBCR2020_TYPE is closer to a full-range conversion matrix with
incorrect luma offset, so correct the luma offset for full-range and rename
it to COLOR_SPACE_YCBCR2020_FULL_TYPE.

Add COLOR_SPACE_YCBCR2020_LIMITED_TYPE with correct scaling and range for
limited-range output.

Fix related functions so COLOR_SPACE_YCBCR2020_LIMITED_TYPE and
COLOR_SPACE_YCBCR2020_FULL_TYPE are correctly selected based on
dc_color_space.

Derivation of both matrices follows ITU-T H.273:

Table 4, MatrixCoefficients 9, BT.2020-NCL weights:
KR = 0.2627, KB = 0.0593, KG = 1 - KR - KB = 0.6780.

Equations 45-47 in matrix form:
            [  KR             KG             KB            0 ]
M2020_NCL = [ -KR/(2(1-KB))  -KG/(2(1-KB))   1/2           0 ]
            [  1/2           -KG/(2(1-KR))  -KB/(2(1-KR))  0 ]
            [  0              0              0             1 ]

Limited and Full transforms based on equations 30-32 and 36-38 with bit
depth 10, normalized by 1023:

            [ 876/1023   0         0         64/1023  ]
MLimited  = [ 0          896/1023  0         512/1023 ]
            [ 0          0         896/1023  512/1023 ]
            [ 0          0         0         1        ]

            [ 1023/1023  0         0         0        ]
    MFull = [ 0          1023/1023 0         512/1023 ]
            [ 0          0         1023/1023 512/1023 ]
            [ 0          0         0         1        ]

M2020_NCL_Limited = MLimited x M2020_NCL
M2020_NCL_Full    = MFull x M2020_NCL

The upper three rows of M2020_NCL_* are stored in CR, Y, CB order. Each
M2020_NCL_* value is stored as Round(value * 8192) in its 16-bit
two's-complement representation.

Fixes: 973a9c810c78 ("drm/amd/display: Fix COLOR_SPACE_YCBCR2020_TYPE matrix")
Assisted-by: OpenAI-Codex:GPT-5.6-Sol
Signed-off-by: Nathan Lucas <nlucasgit@gmail.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 31 ++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 11411fa94665..e686815f9a0e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -59,7 +59,8 @@ enum dc_color_space_type {
 	COLOR_SPACE_RGB_LIMITED_TYPE,
 	COLOR_SPACE_YCBCR601_TYPE,
 	COLOR_SPACE_YCBCR709_TYPE,
-	COLOR_SPACE_YCBCR2020_TYPE,
+	COLOR_SPACE_YCBCR2020_LIMITED_TYPE,
+	COLOR_SPACE_YCBCR2020_FULL_TYPE,
 	COLOR_SPACE_YCBCR601_LIMITED_TYPE,
 	COLOR_SPACE_YCBCR709_LIMITED_TYPE,
 	COLOR_SPACE_YCBCR709_BLACK_TYPE,
@@ -111,9 +112,15 @@ static const struct out_csc_color_matrix_type output_csc_matrix[] = {
 		{ 0xE00, 0xF349, 0xFEB7, 0x1000,
 		  0x6CE, 0x16E3, 0x24F,  0x200,
 		  0xFCCB, 0xF535, 0xE00, 0x1000} },
-	{ COLOR_SPACE_YCBCR2020_TYPE,
+	/* Corrected. Not included in the TODO above. */
+	{ COLOR_SPACE_YCBCR2020_LIMITED_TYPE,
+		{ 0x0E04, 0xF31D, 0xFEDF, 0x1004,
+		  0x0733, 0x1294, 0x01A0, 0x0201,
+		  0xFC16, 0xF5E6, 0x0E04, 0x1004} },
+	/* Corrected. Not included in the TODO above. */
+	{ COLOR_SPACE_YCBCR2020_FULL_TYPE,
 		{ 0x1000, 0xF149, 0xFEB7, 0x1004,
-		  0x0868, 0x15B2, 0x01E6, 0x201,
+		  0x0868, 0x15B2, 0x01E6, 0,
 		  0xFB88, 0xF478, 0x1000, 0x1004} },
 	{ COLOR_SPACE_YCBCR709_BLACK_TYPE,
 		{ 0x0000, 0x0000, 0x0000, 0x1000,
@@ -180,14 +187,14 @@ static bool is_ycbcr709_type(
 	return ret;
 }
 
-static bool is_ycbcr2020_type(
-	enum dc_color_space color_space)
+static bool is_ycbcr2020_limited_type(enum dc_color_space color_space)
 {
-	bool ret = false;
+	return color_space == COLOR_SPACE_2020_YCBCR_LIMITED;
+}
 
-	if (color_space == COLOR_SPACE_2020_YCBCR_LIMITED || color_space == COLOR_SPACE_2020_YCBCR_FULL)
-		ret = true;
-	return ret;
+static bool is_ycbcr2020_full_type(enum dc_color_space color_space)
+{
+	return color_space == COLOR_SPACE_2020_YCBCR_FULL;
 }
 
 static bool is_ycbcr709_limited_type(
@@ -216,8 +223,10 @@ static enum dc_color_space_type get_color_space_type(enum dc_color_space color_s
 		type = COLOR_SPACE_YCBCR601_LIMITED_TYPE;
 	else if (is_ycbcr709_limited_type(color_space))
 		type = COLOR_SPACE_YCBCR709_LIMITED_TYPE;
-	else if (is_ycbcr2020_type(color_space))
-		type = COLOR_SPACE_YCBCR2020_TYPE;
+	else if (is_ycbcr2020_limited_type(color_space))
+		type = COLOR_SPACE_YCBCR2020_LIMITED_TYPE;
+	else if (is_ycbcr2020_full_type(color_space))
+		type = COLOR_SPACE_YCBCR2020_FULL_TYPE;
 	else if (color_space == COLOR_SPACE_YCBCR709)
 		type = COLOR_SPACE_YCBCR709_BLACK_TYPE;
 	else if (color_space == COLOR_SPACE_YCBCR709_BLACK)
-- 
2.55.0

