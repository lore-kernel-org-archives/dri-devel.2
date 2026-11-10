Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E032606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vymj4uJJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 755AB10EFF9;
	Tue, 10 Nov 2026 11:46:31 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74AF710EFF9
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 11:46:25 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so18893645e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 03:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794311184; x=1794915984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=650xNz5E2WQUY3KnP5K1WhKYhZweVEKGeHri1CxDolk=;
 b=Vymj4uJJ5AnLmCtT4jaBaAnKHo6eVL+9aQYPuvv5EtfOT2QNaZySwRwCalYPFmBUDk
 k7o5b2iMsuwswPsc5OxCb4ZFg8Je7bAKopmijqDBVFtZa6t5y++2bynuD2gNH9v0jwor
 BfzEQ5NSvskcezq8Tnd93VpcLD96cJpQdMCUmbXWsnnoMfw16MT7mO5F57PcZ/e/9DLR
 yup3xFHdMCov2e5m1Ldknh2AcUJ4QH2zqWGA2Fq36dZoibM1rACU8t/hP9nQBqLit976
 JjKk4x8wCrtFxb1FHWdDOt5Vy76q49qrf2k/i0PpRVQHkAGZCp0m+6OMlKGvgNtp6vtZ
 l71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794311184; x=1794915984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=650xNz5E2WQUY3KnP5K1WhKYhZweVEKGeHri1CxDolk=;
 b=p2bM93XKMu1ioD9a40SfMoXpWJdyWu93sdUAiHUyxfF5VwCbIzHiCBqY4sGGBUrDI4
 06Qs/Q7P/2TXx/A0fsbVpRDvXEh95vNSZjsB+WT9poShGucIKXRyWEOj+l7Dj5x0OAmk
 7J+1s4jiFgc3EKgTOIOdjjfVcO6rSSljcjT40HLbzEoU15b/1U1gJ9+O97ZAr+hPt2sG
 SKFwCBTobdfBmjNu2mMkzK6a/le6Yt7LuwqihTBQzr15xyoB86J+x7RhwVEUN0EmXEK5
 T0QcoxB9/lGmLWrLAajRaJ2F6TObslRLcVj6xOkzFDJaSif3ee/V2BRE7p9uhpYkb3rR
 A/Ag==
X-Gm-Message-State: APuU4Z8mYVYkiefBK4iPORLRHzpGTh1CboXo3+etezDhJB6Ycai8gK3y
 4iOYOtlMK1Qkx0jjU3Ugxr8xygXqWqdAT4w0XKZ7nW5ZbiDsqxxfaVdQ
X-Gm-Gg: AYBFou2IXpl3s4W8zmMjae8txjL/BJePM/+1CVoeoWDzLtxVuSl/fyTaup9rwCb0Vl8
 DLalD8X36ef+0BnfPquH0FPeox9IVPvUta5ORjXcr/b+8I1DY5iSuVyxCM/dG6WzSKW2FDC6K4e
 M7wb5Jxfebb0YD9Y1DtFg4iJzQIy/mKHw/Xs7NUVxVcnem7ivEnq3VXp9Sm5e7e1U1SEo7fruLX
 ALMceHrcsjArfGD6D14WpiXh3YmhzcQK4uXyXgeuKA5QCuDGSOZrrUE6ZpRvSwAGkvEmDr9BCgY
 bpCJ5EzEwzE+r6upJgBNOtQZNG3dJQ6mdSPFLCXwUaD/31xnEMEJfTgcpGi+jhKpdHA90UtcoC6
 UjaC1tMEG+WAW//MWbT6QASo9um3Qnd8xuoXzCIviI4le+vD2gwtnzapVbo+RMsxX4mYygfwo4p
 FCclxJqvQhq3OJRYy9jpfEF5LaHU2QdjIzdKKS5ksIT4aK+cncjrAhMlK1s+EB/h/3jMudqQBZF
 owiF793vTh/Wq970+TOuNOrPRbndWWVpZNyHfFRJVH4ijVe/tWoCzcijpz8JbtGvca5SvT5oktL
 JOLoR2D/Wy9gX6XB0YE3MDqhfUbUi+9n9DZEct4QZQp0U+eqDFluW9cbsvXscpb0hCybIKlcJtC
 qotvC/XMoROB+A4h+pPPRlWiVM4+m0S/+wu7qT81aymRtRpOcmjPcD9E5FH+SWvUzOY4YszizT4
 8Tog5fvM5vFA==
X-Received: by 2002:a05:600c:4f86:b0:4a5:dc5d:20f7 with SMTP id
 5b1f17b1804b1-4ba0234575cmr38552685e9.14.1794311183540; 
 Tue, 10 Nov 2026 03:46:23 -0800 (PST)
Received: from iku.example.org ([2a00:23c8:254f:fd01:a442:471f:496d:2047])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0203a763sm59915765e9.4.2026.11.10.03.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:46:22 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Prabhakar <prabhakar.csengg+renesas@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] drm: renesas: rz-du: mipi-dsi: Drop duplicate
 platform_set_drvdata() call
Date: Tue, 10 Nov 2026 11:46:22 +0000
Message-ID: <20261110114622.229608-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
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

From: John Madieu <john.madieu.xa@bp.renesas.com>

The platform driver data is already set earlier in
rzg2l_mipi_dsi_probe(). The subsequent platform_set_drvdata() call
uses the same arguments and is therefore redundant.

Remove the duplicate call.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 5b257f5adf06..985d6e02203c 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -1576,8 +1576,6 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 	if (!dsi->dcs_buf_virt)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, dsi);
-
 	ret = rzg2l_mipi_dsi_pwrrdy_init(dsi);
 	if (ret)
 		return ret;
-- 
2.56.0

