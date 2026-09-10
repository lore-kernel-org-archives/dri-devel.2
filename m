Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAFCC79FB6
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 03:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E78A910E777;
	Thu, 10 Sep 2026 03:04:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=compal-corp-partner-google-com.20251104.gappssmtp.com header.i=@compal-corp-partner-google-com.20251104.gappssmtp.com header.b="Dr6Lf7oi";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D5C10E777
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 03:04:48 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so765618a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 20:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compal-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1789009487; x=1789614287; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sLZ97DnFTLkm0PkrD3uKvAkUsl4fwc4lT7Olf3ovjLc=;
 b=Dr6Lf7oid/cMf3yKFW6w6dt9I5tNXG6dFoz+UoGq2svJNoOvY6CAkGTpedpmUXEN8a
 /CQtGK8S7cQiYAijRhzZWsk+SNk1dCTEUFycanMqaEDGbO9PHPViMFKYb0C7XZ8JJgFD
 nV/bBjPaFxH+rSQcmCfDch5xiW5IGHQh6tMET3ntD470WpYMFw3E/SgMzQgcCljavIwD
 gBUZSmWibXTNaZ5XD70onhQKf1Nv0oTeh4h8mbYWYfz8T6GgyFSHObp8fpdQCz+Svox/
 a15lomJ4a3AaLMI5J5i5+xln+mUARUZE26nF9cdtyBtreSN61U3H4upboDSeXk0EWrgC
 AcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789009487; x=1789614287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sLZ97DnFTLkm0PkrD3uKvAkUsl4fwc4lT7Olf3ovjLc=;
 b=df2vDqiNNaTKkGOyE+990Pjwj5IDceKkTG9rmHqZSoSxCbps3GmcCELkCtNlq8m3as
 Lp/TJvVoX6rMtoHgBwBLSTPfCvPfvWo1xO+sYEVreEHh7XEkcV9X6LYfaEgF8kOTckf1
 /59nWC+4L8VVgVQKjFWSKykvv0mL01KcjrB1sA3pmhAyMJRGoOYvc16QiFX+ObM1YIfn
 h4sa3ECOeUpGfU/HXNGSyMJce5JRbAQFlOlz2NznupeQX4qg9gGMzA9AX+mk+T7bCaVs
 coKQYzi2DVnW8IKk/nErUtqtDC10mNAC0irFRiNMyVRe0jQzyJBYVeP2ebh+yoPO3xoh
 eu9A==
X-Forwarded-Encrypted: i=1;
 AKwUvByQzWzAIkMSdYQtEcAul5zCuegPD2anCsJAmP2QXq54mQYQ7t3gDP6vZvhvG+isu9FyuT/IhLUcttI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lLzGEiobbOkyAWtfIrO2pIvxeIkky5npzuiSuK7Ycn4OKD5BMe
 WQWrHfzHjOBFAutH3UFZ9wJc7pWxNnEs8zsbLw2BVbxA3RWFA/B9dis4Ql7UfDxibhg=
X-Gm-Gg: AYBFou28l6iM50D2LFvChsKLBQjgOHpWyDNnHEFrIPWsfYePENqaW9v1JrChNcOlNV5
 K96bDAKV8nppKCdcRKwIWZG0WYlhFcgN0/MM0R9ZAzFZjXjuDrISMY4xcrR1+m5XL3pSglbmiva
 iPGDrXvBq5wIyKTVsaTT1O5lj1UPVL6r/iLVf5nYdmwSO/ljwlw6K2NGFkg9KR+P4a5XaWiT1Ae
 elBH8vY5BNmgSPcUjH9vLRPNZqL6RXWltIcL81bcRZ+aspnZUV/dqfjmYHrdny6flvPJITVRhlO
 S8nX3Z1joyl1RXRvR5cumrrlVdNbYZ44bJsruwaEENDBKQMHcOFpS9wgaGTo9LGw6Tp5FNXeST+
 E87rLNp4M5XHH7zuZBuRnExzgGt6idM0lM3fjfDPNH4UI1Yw63WesSy9/dEEdvst+2FuWKuZhHY
 E2UwTy1bdnXyTdJ/7CGSv+FnyFZ2Ik5jvHkAIaZVqgFh3rv8JN8Wt1Yi+3zqJ9GvHdrFVGqgwV+
 uVFuVH6totmhpDzTXiW+TpcDBngDWLGMuK9D+CDQR1MCDq7OM9v/u3Ru41yNvU=
X-Received: by 2002:a17:90b:558c:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-39d70ae1a5emr7626555a91.13.1789009487545; 
 Wed, 09 Sep 2026 20:04:47 -0700 (PDT)
Received: from terryhsiao (61-219-175-100.hinet-ip.hinet.net. [61.219.175.100])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39bae865d2csm2733421a91.1.2026.09.09.20.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 20:04:47 -0700 (PDT)
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
Subject: [PATCH v1] drm/panel-edp: Add BOE NV140FHM-T0A
Date: Thu, 10 Sep 2026 11:04:31 +0800
Message-ID: <20260910030432.1009658-1-terry_hsiao@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.53.0
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

The raw EDID:

BOE NV140FHM-T0A
00 ff ff ff ff ff ff 00 09 e5 ea 38 00 00 00 00
1c 24 01 04 95 1f 11 78 03 28 65 97 59 54 8e 27
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 c0 39 80 18 71 38 28 40 30 20
35 00 35 ae 10 00 00 1a 80 26 80 18 71 38 28 40
30 20 35 00 35 ae 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0d 40 ff 0a 3c 7d 0c 10 21 7d 00 00 00 01 38

70 20 79 02 00 25 01 09 7f 41 02 7f 41 02 28 3c
80 81 00 10 6f 1a 00 00 03 01 28 3c 00 00 4a 5a
4a 5a 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 c8 90

Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index bfb49b647b96..b66751df502c 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2084,6 +2084,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x3879, &delay_200_500_e80, "NT116WHM-N21"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x388b, &delay_200_500_e80, "NV116FH1-M31"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x388c, &delay_200_500_e80, "NV116FH1-M30"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x38ea, &delay_200_500_e50, "NV140FHM-T0A"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116BGE-EB2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1132, &delay_200_500_e80_d50, "N116BGE-EA2"),
-- 
2.53.0

