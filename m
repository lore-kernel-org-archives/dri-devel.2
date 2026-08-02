Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A079C55182
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 780D010E429;
	Sun,  2 Aug 2026 14:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TJRgtkyB";
	dkim-atps=neutral
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B8E210E429
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 14:35:37 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so2349881a34.1
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785681337; x=1786286137; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R9/ZBBWwxbo/L0scHa1+0PKeDSXAJU8I4FcEXNAE4v4=;
 b=TJRgtkyBaWYT7de38l8uEQMLLxqCnrXKZ5gvOAazCZlMdp76R7q0p0y4ClXuhUH392
 0zuhSlnUj8pf5gVZcip8307AYImOGt++O8QmZrAbJJAXin3V6qCqScvEoTWyGLXIiJ1U
 NoUICWb/hCTxNc8gvZ9x6ZBjzgEzd2oKm/g5c8M+562x3SK3pcawgtlKhtmW54mj9kez
 F6H7fumvSAtlO7HwNlBzszaZhEdfCkySM//d2IL+ypkI5X7tINfs5PjrEpDwgWgVwcMx
 ui1ygZ9xjKQGDJcHuwwXAdes0sqWJR+xw4TWuv3CeV4w0Ts1bXlXgbFDoArp6TOdJPOz
 2KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785681337; x=1786286137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R9/ZBBWwxbo/L0scHa1+0PKeDSXAJU8I4FcEXNAE4v4=;
 b=G7Ft0+aHItWJ+fFbBdYXVT3SVk07DC6JU7jzaUCKmnnjdyMy1JPK8OeF6mWtqAwW4L
 FJe3smVqTcOOgipiqoheYjbjVEUHhhMVZkyFmQCht+Fs2Lu+n/rB8x3438JFdDkYEpp2
 i/fZtJC796apAEm6FSw3WHr5YP3HR4vgeb5o3R52vC6JqDJd8Z86njBfKe1eBNIT1dCa
 44OiJdqdJRGACcU6ipaZOKoKjLN4b/lC1Yfuq2uhIVGNCNuuK6AZdhDayN5B1qQfoKvl
 6IlUk3RTxHxYry1hN/mR1BGuAzvU386wcyj7DEh7tLD1z7W4aJYV7ZG3dr1P4LLykP67
 ZIng==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZGNIxT2WqxfsvFIh+j7VsCj9BVD/i+APh57ZXjm2rw6dJJ/RjcQa+G6TE/X8Its+NFFz0gDPXT0g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKZDcxt5itCZdCDCmrKXpPxLrRmSunM02eTtsgTcr41xRaYcXh
 C3CjgOFycMxW38LwfplEFe2auU7dZaqTRpZE6fcxqiXtm0eptifApexG
X-Gm-Gg: AR+sD12OVHOrXowgWggH5T7ezNFI2IJ/KELt4R0q9xHbEoeW8BB/hQ73XomEItWqYlY
 ievgyvVOt5XG5aPRm/BtErz+Svt9Kl/gNr2XF/o8NI2FEhtJ0TNAaJCiQWFyJWN2Ri/NnjpmApC
 hcBISFAL61s5rZ7lvofcTpLeISJ8DU3Hdo0kuW9vB1eK5H5Mpz+cfVbmzFli1z2m6V9ERXpyBJc
 QHh33yKEDsI8FJCYr0anFPt1rL4bk0QHxsyv91F62Vtcl71lQueERy/KJUWAQRrB3JJ0+95kYTJ
 NM9iafgu2LPoFlEYVePH/A1G51Cu56/ZyrHQHPRSlYL5Iu1bxrKuxvGmQ1tk50ePMVo6FZoRouH
 /jBc5cTq6BmuAvn+DgWjfM6jQdh7qFgcykG9SJHmToseQAKgXVsiZi6dk9CHn7x/oi+DNHI/ToP
 iPxIxxpSbeJ1FLZ3Oda7+hLACfM1R0sDK/t+nU8hWNNF39MZpdwgh0oO4q8xiEzs/X4+cRiq9se
 O7GFUrSmOA+L0IDMyGYQ2OS1zaL/UnVPeHyq6pPcryI
X-Received: by 2002:a05:6808:bcd:b0:497:8f1:df07 with SMTP id
 5614622812f47-4af5e0583c4mr12361035b6e.7.1785681332450; 
 Sun, 02 Aug 2026 07:35:32 -0700 (PDT)
Received: from natebox2.jabitha.com (46-110-104-162.wmnscoaa.metronetinc.net.
 [46.110.104.162]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4af58e9551dsm4778877b6e.11.2026.08.02.07.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 07:35:32 -0700 (PDT)
From: Nathan Lucas <nlucasgit@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, joshua@froggi.es, mwen@igalia.com,
 leorize+oss@disroot.org, alex.hung@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amd/display: fix BT.2020 YCbCr output CSC matrices
 for DCE
Date: Sun,  2 Aug 2026 08:35:24 -0600
Message-ID: <15b28cafab1b55f3e4cad9bb542847d22e776bda.1785616749.git.nlucasgit@gmail.com>
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

The commit cited by the Fixes tag added separate limited and full-range
BT.2020 YCbCr entries to the DCE output CSC tables, but populated both
entries with the same matrix copied from the common DC table. That
matrix combined full-range scaling with limited-range luma offset and was
incorrect for both limited and full-range output.

Replace the coefficients in both entries in the DCE paths with those from
the new COLOR_SPACE_YCBCR2020_LIMITED_TYPE
and COLOR_SPACE_YCBCR2020_FULL_TYPE entries in the preceding commit
("drm/amd/display: fix BT.2020 YCbCr limited output CSC matrix").

Fixes: 51e6668ab4ba ("drm/amd/display: add missing CSC entries for BT.2020 for DCE IPs")
Assisted-by: OpenAI-Codex:GPT-5.6-Sol
Signed-off-by: Nathan Lucas <nlucasgit@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c       | 7 ++++---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 864491bfd7f7..83f819890020 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -115,10 +115,11 @@ static const struct out_csc_color_matrix global_color_matrix[] = {
 	{ 0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
 { COLOR_SPACE_2020_RGB_LIMITEDRANGE,
 	{ 0x1B67, 0, 0, 0x201, 0, 0x1B67, 0, 0x201, 0, 0, 0x1B67, 0x201} },
-{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868,
-	0x15B2, 0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },
+/* COLOR_SPACE_2020_YCBCR_* values corrected. Not included in the TODO above. */
+{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x0E04, 0xF31D, 0xFEDF, 0x1004, 0x0733,
+	0x1294, 0x01A0, 0x201, 0xFC16, 0xF5E6, 0x0E04, 0x1004} },
 { COLOR_SPACE_2020_YCBCR_FULL, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868, 0x15B2,
-	0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} }
+	0x01E6, 0, 0xFB88, 0xF478, 0x1000, 0x1004} }
 };
 
 static bool setup_scaling_configuration(
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
index 1ed018aaa4bb..f5f8cd2d47a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
@@ -93,10 +93,11 @@ static const struct out_csc_color_matrix global_color_matrix[] = {
 	{ 0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
 { COLOR_SPACE_2020_RGB_LIMITEDRANGE,
 	{ 0x1B67, 0, 0, 0x201, 0, 0x1B67, 0, 0x201, 0, 0, 0x1B67, 0x201} },
-{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868,
-	0x15B2, 0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },
+/* COLOR_SPACE_2020_YCBCR_* values corrected. Not included in the TODO above. */
+{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x0E04, 0xF31D, 0xFEDF, 0x1004, 0x0733,
+	0x1294, 0x01A0, 0x201, 0xFC16, 0xF5E6, 0x0E04, 0x1004} },
 { COLOR_SPACE_2020_YCBCR_FULL, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868, 0x15B2,
-	0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} }
+	0x01E6, 0, 0xFB88, 0xF478, 0x1000, 0x1004} }
 };
 
 enum csc_color_mode {
-- 
2.55.0

