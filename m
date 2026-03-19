Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995C9107528A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 565F810E926;
	Thu, 19 Mar 2026 09:42:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lcfc-corp-partner-google-com.20230601.gappssmtp.com header.i=@lcfc-corp-partner-google-com.20230601.gappssmtp.com header.b="p8DO33wJ";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB8610E84E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 05:09:45 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2b04fc8851cso5139035ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 22:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lcfc-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1773896985;
 x=1774501785; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C/NKVHJ+E5XrJYl5OLfv8fWZoj58Wvo4nDncLHGqexc=;
 b=p8DO33wJ30XGzzT014cxUfm3LWnXhkwXDUGCBEQgmTIuMkKhU/Xga2wooBnGct4elp
 xDQmKVBTSOtHrTYak91k3tzi12IXZlt4sQXpb7/qETQIVObglzM0EoyGC/94L1K5Fzv/
 s6AzfVtjrIQEwRjrDoNi3WBe7TzTrISEui0ltdibU2UKJWDZ5LQQVDg5Lj/r5AQ7u4Pb
 tjxSxjWzrvR7C0/2WyO9u1xN0pE6siy7CXHGk4i0fTLu3dA0vmwoey8DMNrImNTj6QaM
 cBJuWi4zdN2QLHFZQFO9LLeuY8mHv848SaApTAf7i2Y+3ImBlzIgEUWDSRCRBBB4pTkF
 bjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773896985; x=1774501785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/NKVHJ+E5XrJYl5OLfv8fWZoj58Wvo4nDncLHGqexc=;
 b=IFM9dHqyoqNKFGNJocygEVwkt8phOPooIJKqonR4Yt0qAmtiEC5Oy9ilhxEN0+UqdQ
 EFCuHafAM6FA2ougcXfLRPX6gFKLxv4iFUHnYzOMMeX4EFqtignpuG5k+jzmjG4zBanO
 6vmiPf+NC0BIwvs2gBZKyNpZHW82RMibSSz+qjXnc1XOQzFJaAiJThb/Dftuc6JkPgUr
 zNQkF6uxCJXtZRvwsD00Zhbj0F7L8pE3EM79u6uLiTdWwOS+X3LS3RkrsSAn/CLPvko5
 NLb4GNDouSFHqwxVvEVFPPZKf7QlOLm64sYa7gPwESp5kdNyZPrd5d0SYJI3eJkt34P3
 l8xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqrtpmeRCniRlHdJW8cg2Czg3rDsAFbZjyVzUdIH9ODJ9xHcIhjSzyvBzSVMQ45UXeX4WDVezAbJo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4+vk79ayO/NGHnccrk5WZ86TRREmyWMdmw34XdoobZ6lhRRey
 NZNNiTTOtZGIFJvoTjgw/rKMKAGK5WSRko8//sV2K1lz7cNVkaBunUVHTRr/1OCLYLs=
X-Gm-Gg: ATEYQzyBvJuwYWW1+GdCgJLj31ZbIJWaDo78ljbPP1d07CidYJ0tFFQspiU+xtTYNj7
 vc7RGruDWfCUaqllaNwFjlGKEw/IYc6p2HlJwyI75rnuXe2f4Ba88fMzGzyilerKvmBV4C+nWBW
 BJyGRVwb8IJNhy6hlwUhYpoLRkhywLAXHH12+N3BREy7fGLcRNrEL9k3tYljIP7siEPiTJMpp9Q
 YoJzLkrkyD1mnHmaWT9cuwL+zUerikty/tUpE+VK7UkQVKCpNCox7BE+wEOgTPOIR8V1Q4JkEor
 8LDG4pb7GyQuhXtkkt6/vJNL4E9lIUx4uFtw3Zj+HwRNneLoSN63cygeJ071qsnrsBxPOTlo0md
 N3+SY1WF7RqrcyXe0rLPn7uC78zpCmcizaa3IBZ9eSYnESddmS4Runnh73orSBcFa7KxNFUwz34
 NCjoglnHOT+lHO5tib8OpoPrlALKhFDmgq7r4g/T/eVKI7kvcEzNbCRXe0yw1x8IJYUKgLGroW6
 wOR6KK8nw==
X-Received: by 2002:a17:903:1a2d:b0:2b0:700e:fc9a with SMTP id
 d9443c01a7336-2b0700eff76mr47412235ad.26.1773896985231; 
 Wed, 18 Mar 2026 22:09:45 -0700 (PDT)
Received: from thinkpad.. (211-21-152-94.hinet-ip.hinet.net. [211.21.152.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e41974asm46635095ad.7.2026.03.18.22.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 22:09:44 -0700 (PDT)
From: Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
Subject: [PATCH v3] drm/panel-edp: Add BOE NV153WUM-N42, CMN N153JCA-ELK,
 CSW  MNF307QS3-2
Date: Thu, 19 Mar 2026 13:09:38 +0800
Message-Id: <20260319050938.556235-1-alvin1.chen@lcfc.corp-partner.google.com>
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

Signed-off-by: Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 679f4af5246d..775bc4474916 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1991,6 +1991,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d45, &delay_200_500_e80, "NV116WHM-N4B"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
++	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_e80, "NV153WUM-N42"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ddf, &delay_200_500_e80, "NV116WHM-T01"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116BGE-EB2"),
@@ -2026,6 +2027,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N140BGA-EA4"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1565, &delay_200_500_e80, "N156HCA-EAB"),
++	EDP_PANEL_ENTRY('C', 'M', 'N', 0x156b, &delay_200_500_e80_d50, "N153JCA-ELK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x162b, &delay_200_500_e80_d50, "N160JCE-ELL"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x7402, &delay_200_500_e200_d50, "N116BCA-EAK"),
 
@@ -2044,6 +2046,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "MNE007QB3-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x147c, &delay_200_500_e50_d100, "MNE007QB3-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1519, &delay_200_500_e80_d50, "MNF601BS1-3"),
++	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1529, &delay_200_500_e80_d50, "MNF307QS3-2"),
 
 	EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po2e335, "LP079QX1-SP0V"),
 
-- 
2.34.1

