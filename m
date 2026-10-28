Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E7D606A320
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=compal-corp-partner-google-com.20260707.gappssmtp.com header.i=@compal-corp-partner-google-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oACF3Fb4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD32910E41D;
	Wed, 28 Oct 2026 08:02:09 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4BF10E41D
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 08:02:03 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cd61a2dfd7aso244889a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 01:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compal-corp-partner-google-com.20260707.gappssmtp.com; s=20260707;
 t=1793174523; x=1793779323; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IJmE3oA/krvQNz+oei6INePC4WWOsJ5JbTHntRya0h8=;
 b=oACF3Fb4jmIllS+algPuzkCeh29eg6eEWLGIbiTYAph/L3nB4lI6DLiwb08kEpW1HL
 sEc3talagkdRpb4mb4TIHBrZ4rHG2ZAcTo0iXgyfyNnepP0PyzXi1a3guwCcu7j9Q1TF
 z4/8uvC4KwZOq1GDCB/sy5d2kjD67LAxI+3QV5QPzUV7Y4VFqpB/Az+WojMZrz40gDBA
 Gv0dEaBb7K0nxcmmd7wif1mMaglXWeSG3OrW55byrUDubZrhKyEWHeaXpRCklL5F7GwT
 9UVPwcYb95BqWD1NSBKQItlfdPt0kngJqdalgzIogQYgrRynv/k7YF5Rgr3HQrXyEz2s
 NjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793174523; x=1793779323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IJmE3oA/krvQNz+oei6INePC4WWOsJ5JbTHntRya0h8=;
 b=hY4sybsjnlVStFs0Q3K104/bY/JXv7eP700RCXolLpyMdSdQoKrWTRrfoY4hI5qXG/
 Zuegdwv+S2FlaVm+YyV98IS+1m44DLpNM2QrqKPNod6RF+j53207WQBGhMnia1PUblJO
 gCoFNEmpymGqfTed15jYwJ0rq7Gr2FT2unS4bFX9jsuBHLZ9RZvij9pOCqqxxUB7YowQ
 m2AdVCegudhRjTkIdzOLO4JfFo9iqVIRZkcc1roQqfKajjNyWUZQ8jgx0m8ZxoMSdcYI
 CL5KkRME6Vo4hRMjwhgqsQXwx2MzpmNcFnxFMc/7yx6NxFmEQVAJfRECM/4Bf24+2+VT
 cNdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZL7BB1O7QtzKedaRocTipxhXyANl6hoA6w7b+mprH2wG0o2danlFvsvhziIe+jSBDEEGQ8OEuNkI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ4khVUVQymscW4Tbm3dPlQQ+rqSKBdiknGLjTRpR3kWRE5Fu6h
 1TVNLnhBYb5wkMobw0C1sNH0mnKgH4vYYuEnNW1Dc0dxwTMeaJ0bFE2kHNDDjzOwUfJrP793nKF
 8hHM1
X-Gm-Gg: AYBFou0ofyY1hRTILPTc05aMt/XgmemgpzpBB7c7EBbsCNw87BdXa4T7wRT3phJZteh
 1zRoHvV2hYp1T4Bmy/p3D01VfXXQouwn8HBQx50TjFZ/Qk3SXYnFKCd+pjEfC+NcI7fvRrYcurZ
 i3Oh1gHNjSKCu8Tl6o8qpqHuVnio+I8FJxJDET+6Sa7vrVvw0asuUHNsPsZ99HzGHYY+GvDji9J
 PUKoaibOslYy7gCRj1b3dwihlxmSeT0hDYj7KBtAbxcgbPRSWEnC+ppUjg2oJL6XsO2xJ7H5pGW
 hsRPEsoD8THSzU4k7y8WCrNLIhCToPb68VyQxc0ee+JwmznWTdcMEBy5QUAO77qNsPgW1KooV4H
 q6c4VIbWAztYOckWzKujvGYGGRQoSEgfFA9j2Q7WeX/nOWCe5NK7oTPb9io3s0Egv88JLqcZ/ry
 dmVB11yjgJkXM6/nnG+q331ONNVr+e72EJU69xPjq7P1iC4v4NHPjvr+sXba9ql+nA/L66Mi3IY
 T34l1YoSbTnk1vuxAteX+9B1idNjpd5I71ZEw0EnTirG/WYs5XR3vATLVMBH1hbuEJ6SxjXqlf4
 5D4BoB6w+t9w7I8S/TLQNl0rAy1PNa4ARS89KZk0ZyQ3ZPN6fEuCzGFb0K4LGSnVGov4NtpOZML
 G3gn752ptHxkr69BNATM=
X-Received: by 2002:a17:90b:3eca:b0:3a8:495b:d64b with SMTP id
 98e67ed59e1d1-3ae57e2ae86mr1161170a91.4.1793174522900; 
 Wed, 28 Oct 2026 01:02:02 -0700 (PDT)
Received: from terryhsiao (61-219-175-100.hinet-ip.hinet.net. [61.219.175.100])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a5d45a8sm1929049a91.17.2026.10.28.01.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 01:02:01 -0700 (PDT)
From: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Subject: [PATCH v1] drm/panel-edp: Add BOE NV116WH2-M32 V8.0,
 PNB601LS1-3 HW:1.2
Date: Wed, 28 Oct 2026 16:01:41 +0800
Message-ID: <20261028080153.91945-1-terry_hsiao@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The raw EDID:

BOE NV116WH2-M32 V8.0
00 ff ff ff ff ff ff 00 09 e5 10 39 00 00 00 00
27 24 01 04 95 1a 0e 78 03 0b 55 9a 5f 58 95 28
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 96 1d 56 c8 50 00 26 30 30 20
36 00 00 90 10 00 00 1a b9 13 56 c8 50 00 26 30
30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0d 40 ff 0a 3c 7d 0f 0c 17 7d 00 00 00 00 c0

PNB601LS1-3 HW:1.2
00 ff ff ff ff ff ff 00 0e 77 10 11 01 ff 00 00
13 24 01 04 a5 1a 0e 78 03 a1 35 9b 5e 58 91 25
1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
36 00 00 90 10 00 00 1a 06 14 56 dc 50 00 28 30
30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0c 3d ff 0c 3c 7d 0e 0b 17 7d 00 00 00 00 fe

Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 94bc54c3833a4..ee880dff5e02e 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2090,6 +2090,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x388c, &delay_200_500_e80, "NV116FH1-M30"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x38ae, &delay_200_500_e50, "NV140WU2-M70"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x38ea, &delay_200_500_e50, "NV140FHM-T0A"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x3910, &delay_200_500_e50, "NV116WH2-M32"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116BGE-EB2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1132, &delay_200_500_e80_d50, "N116BGE-EA2"),
@@ -2141,6 +2142,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50_d100, "MNB601LS1-4"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x110a, &delay_200_500_e50, "PNB601LS1-2"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x110d, &delay_200_500_e50, "MNB601LS1-8"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1110, &delay_200_500_e50, "PNB601LS1-3"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x143f, &delay_200_500_e50, "MNE007QS3-6"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE007QS3-7"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x144b, &delay_200_500_e80, "MNE001BS1-4"),
-- 
2.53.0

