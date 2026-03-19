Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877A01075289
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD45910E93B;
	Thu, 19 Mar 2026 09:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lcfc-corp-partner-google-com.20230601.gappssmtp.com header.i=@lcfc-corp-partner-google-com.20230601.gappssmtp.com header.b="0s1gwelt";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5E310E0CD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 04:45:12 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-82a7539851fso121790b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 21:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lcfc-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1773895512;
 x=1774500312; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UqDf6fc36WCQgIfbd58mIqCGfDGaq5Nq56uohmschlc=;
 b=0s1gwelt4h9dTqKjd9egPIDHSdtmnqoFbutvThEO3vWYZJ0O5dryvavk0yWL0Om0EN
 LfpnFcLZJE06YxqZghXu9PdQZZqfm21MkRLWddWBWgFjczzTIk+0C3y1sgRTngBiGCzm
 3q22yCGl+rIUgSp8/V0GWrMbpvwVG4MFIK6sHZG7e4eO6uWr0DFOvNZpF62Bnn4r6Y+f
 vufSklz4fG2ZNsU6w8Qv7XKmVhY/gMaeLrVzBAQQZtd8mD8BET8hbyC5xqrEH0aKW5Cr
 z6sJfCbJCnlKuErelOGdjnEYuEmchNoqFMOxTHnMquQbNjfykjvRBNI4aJuE5pAyZx5m
 sNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773895512; x=1774500312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqDf6fc36WCQgIfbd58mIqCGfDGaq5Nq56uohmschlc=;
 b=KCKE3T3vMvt1sUre1c9wwmUdKMGVW2fME6Z5GoWrn14fKdl/lc+9VQVloA8lh1xJHf
 mS6w3cb/yPZvxkqiOnXQXE5EAM2SSlQkG0I5ZmKz5uzNzgQhpgGAR5GiG73yJyzzUgJa
 k362ari+kGPAoKdZ2roQt+dYkiujpV31cRce/ZUJ4zGYH6aYK1Dmdmz89jLI2Z5tLVoc
 OxDEzPrV9Y/sqCcfzyJADryVrPvV4z6facep2ew+qGSsCUo5hUlQTRzwSdO9/LPK9gj5
 gw3XOrugkvmJoVj05YLolNGnY39Ym6tBXXOa2meX7gVqPFpAvQ732PoZVndoJux3hM9j
 09bA==
X-Gm-Message-State: AOJu0YzMqiWjN1br4AhTq9gSGrdPTzx+5TnULdvZTmMEqTOeTW8wY0Qh
 jGHJp3lus01r71jlD7FbdNssmZ45lj3W+BkEEhLhEJwRrhdCGity2jKMQqOKceo4sBA=
X-Gm-Gg: ATEYQzy2oei8/r1Tb9805cNWntQ8eVeorS4WjY/rby+upXP76zN/IMpaZ7yopu7b49J
 lRQ4HEd62qfRTV+uHQaGOeM/u1V4XsZCQEZDSnLVua7Uxrue1iuv18gZYcVYV1K+vTnrXj6kumg
 JSAcDdVuqNp9YqM3YgoLasFWunTFHqY6+bygIX4W5XR0Zy5OVsdWJCnup2jL6s+RyE0472KrsOR
 uVPnJne9ExwkXv/l7df5+CBjvZ+E6fWyP5OIHFY4JYCC/5ht+58Rohg3qU0zJrkV4N77Z4N/GFq
 6uNIeVKse25L+6axb3LXOh8XGToR69obDejYILGj4JKT7zTX+7NGkQZ8Az2q9lVeklmJ8fyhV1w
 1JlFYW1zSC4D/2cWuVVUisuiYViKzgeQkSxzgVEwTU9eKzk74YjrmPCxPDU5qouYldJmbVKbOY/
 tOwJvJ05uF6Drv3VWEv+ZlHYm1u3oqaDSiuN5/Sn9tMZH0faDryGFSyqB22AioQEVrGPRDHk3kF
 drYMvNquQo7Hf1dli7/
X-Received: by 2002:a05:6a00:a216:b0:827:26e7:5c23 with SMTP id
 d2e1a72fcca58-82a6b260f7emr5299841b3a.59.1773895512328; 
 Wed, 18 Mar 2026 21:45:12 -0700 (PDT)
Received: from thinkpad.. (211-21-152-94.hinet-ip.hinet.net. [211.21.152.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6bbb51d1sm5573039b3a.28.2026.03.18.21.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 21:45:11 -0700 (PDT)
From: Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org
Cc: dri-devel@lists.freedesktop.org,
 Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
Subject: [PATCH v2] drm/panel-edp: Add BOE NV153WUM-N42, CMN N153JCA-ELK,
 CSW MNF307QS3-2
Date: Thu, 19 Mar 2026 12:44:55 +0800
Message-Id: <20260319044455.551571-1-alvin1.chen@lcfc.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Mar 2026 09:42:18 +0000
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

The raw EDIDs for each panel:

BOE: NV153WUM-N42
00 ff ff ff ff ff ff 00 09 e5 b3 0d 00 00 00 00
11 23 01 04 a5 21 15 78 03 af e5 97 5e 58 92 28
1f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 9c 3e 80 c8 70 b0 3c 40 30 20
36 00 49 ce 10 00 00 1a 00 00 00 fd 00 28 3c 4c
4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fc
00 4e 56 31 35 33 57 55 4d 2d 4e 34 32 0a 01 92

70 20 79 02 00 81 00 15 74 1a 00 00 03 01 28 3c
00 00 60 49 60 49 3c 00 00 00 00 80 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 cb 90

CMN: N153JCA-ELK
00 ff ff ff ff ff ff 00 0d ae 6b 15 00 00 00 00
16 23 01 04 a5 21 15 78 03 08 82 93 59 53 8e 27
1e 4f 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 42 3c 80 a0 70 b0 24 40 30 20
a6 00 49 cd 10 00 00 1a 00 00 00 fd 00 28 3c 4a
4a 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
4d 4e 0a 20 20 20 20 20 20 20 20 20 00 00 00 fc
00 4e 31 35 33 4a 43 41 2d 45 4c 4b 0a 20 01 d5

70 20 79 02 00 25 01 09 94 5a 02 94 5a 02 28 3c
80 81 00 13 72 1a 00 00 03 01 28 3c 00 00 00 00
00 00 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 ae 90

CSW: MNF307QS3-2
00 ff ff ff ff ff ff 00 0e 77 29 15 00 00 00 00
13 23 01 04 a5 21 15 78 03 9c 81 96 5d 5a 94 28
1e 51 56 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 1a 3f 80 04 71 b0 23 40 30 20
36 00 49 cd 10 00 00 18 00 00 00 fd 00 28 3c 4a
4a 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
4f 53 54 20 54 39 0a 20 20 20 20 20 00 00 00 fc
00 4d 4e 46 33 30 37 51 53 33 2d 32 0a 20 01 5c

70 20 79 02 00 81 00 15 74 1a 00 00 03 01 28 3c
00 00 60 46 60 46 3c 00 00 00 00 8d 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 c4 90

Change-Id: I78b81115aa3d52ece04c1e5f88dc1661a2d9305e
Signed-off-by: Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 436983fdd113..3367df526ab3 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2135,6 +2135,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf6, &delay_200_500_e200_d100, "NV140WUM-N64"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d45, &delay_200_500_e80, "NV116WHM-N4B"),
++	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_e80, "NV153WUM-N42"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ddf, &delay_200_500_e80, "NV116WHM-T01"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116BGE-EB2"),
@@ -2170,6 +2171,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N140BGA-EA4"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1565, &delay_200_500_e80, "N156HCA-EAB"),
++	EDP_PANEL_ENTRY('C', 'M', 'N', 0x156b, &delay_200_500_e80_d50, "N153JCA-ELK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x7402, &delay_200_500_e200_d50, "N116BCA-EAK"),
 
 	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50_d50_p2e200, "MNC207QS1-1"),
@@ -2187,6 +2189,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "MNE007QB3-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x147c, &delay_200_500_e50_d100, "MNE007QB3-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1519, &delay_200_500_e80_d50, "MNF601BS1-3"),
++	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1529, &delay_200_500_e80_d50, "MNF307QS3-2"),
 
 	EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po2e335, "LP079QX1-SP0V"),
 
-- 
2.34.1

