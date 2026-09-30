Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C16CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 06:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9405D10F1D2;
	Wed, 30 Sep 2026 06:42:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=huaqin-corp-partner-google-com.20251104.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20251104.gappssmtp.com header.b="iNrJdacF";
	dkim-atps=neutral
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE83210F1D2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:42:08 +0000 (UTC)
Received: by mail-pj2-f39.google.com with SMTP id
 d9443c01a7336-2e2d42b972bso7487545ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 23:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=huaqin-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1790750528; x=1791355328; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2bOGTFWV9+cmfJzIAoMh3VDHw7N/QaGZFxNBjbDgjpY=;
 b=iNrJdacFsiU1aAQ07v8VncLFiD8ri9dG5uaIThyRlHZqSPJn6V1ivwkd2YiX0lqFW4
 GTI3HYBUQIByl+FNZa3UKY3XOcLuYdis6qKmAC9WA9R+f7CNoAyOKra5iI1GK0DhkX/X
 tPObX6PjIWPOF+ewpGhas/f+Hi7SeaZiR8tG//XaDXtoYAdZlSWRHv4PoQa92OU5ERyY
 2dkROp1bAr6wrcD7OxxnDMGIMxZfSpmc3bnRrER0Ygufj1IA0WsZrjPkVN0q8hnHIPzL
 uEsYPTlBmOW+aC/TzBrjyUDZOb3UXroM4ygfcezrsO+q4aAAbHPKKK2HAJILmCoiS+ol
 akGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790750528; x=1791355328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2bOGTFWV9+cmfJzIAoMh3VDHw7N/QaGZFxNBjbDgjpY=;
 b=luwEkByegaR1O5XU07gDx/hHszcdii3q6aF2f0qYZGouW0X1rFMwF2Fai+0CJBuP9m
 TVvFLAza2UmcTnH98sNLrv/FCEjCMI36fS1n3fqLBXMmxTMBjWFrAkP0JRmTthuZhv/x
 r/j8KSybRrhznbnyOg3osKzSls/Qxufs/IXtDz2y5emtlJq7LBIF0G9tq9nc33fTRWGe
 DwAcc0e7s9rFZr3IogrLN5FmEouPvegqCS0NIx08zYM94dTQSL4IUOaZHbD3o2dHJ+Zj
 u3DDEZlyAMWXLSWiqs4b8wWCqliCQiBX/4MJTuF/mAx2Rfm/5Mr/gqSiDfK+SDGdqLzC
 ss2Q==
X-Gm-Message-State: AFq9FYIzFlLcT9TSZRzKsg9dooNpTXEOGjgejX0IKQLlY/w3Sq0OrnMs
 rXIajVVMYI8YtgyFVqz0J2lidBGuxILlSQYXWty5GohZ5Gpf4HtDgA+iGjjnCr626CQ=
X-Gm-Gg: AYBFou2IghZp7QGGFnJk0/i38mV8f7OhIQ+G02pqe8gLaor4QBXlDwUj3aiB2OkdJh2
 uhuBTmb7sZ2pWsa4IFa6lhELGhoWKCHgCYsi4YMEHKuKJq1OPyMZtJMJUgjrsGih4l6dEbb0jso
 EXtEjCFW5xhOvNPf80FIvMys0/fRArSYFP5XuOvPIl1IR2PagLo/6KJIUds2dEXkw1xyNfl884T
 519srzAKyQnGcSnmtWQrdpWeklgC2/AL/WIxNeqXJ47XadhusGCo0LkVClTdv3ibxBuvCNeyX/2
 emGsbLMcUBxXy8qyae5jk6FxBEEYTYps3aq8U/SZo5MANUF8yjNb088F9Gskt23+6BHWE5JXm4k
 ORdf1kvIvp+0i7w3kq2D/EbKe/vAr/H/vLK58ubyI/5K6nw+k6I1p6GvdRZ9t5S8hYYdXKMX0TO
 2bA72dEKWASZqcF4aqGbDo/PGKtq5Q90tA6txRqKoVIrWjU599LXwJhlBsIcztCi8UrtyJ4aEN5
 AC4j9OPuqxqNJUgth074kiKcyjgSx6BRvrTKMNerO+UBzeyhBI=
X-Received: by 2002:a17:903:3708:b0:2dd:c100:80c3 with SMTP id
 d9443c01a7336-2e2e4ba957fmr4040605ad.62.1790750528322; 
 Tue, 29 Sep 2026 23:42:08 -0700 (PDT)
Received: from zhk-cbg100025892.huaqin.com ([103.117.77.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e2e5be5d55sm1940075ad.50.2026.09.29.23.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:42:08 -0700 (PDT)
From: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, airlied@gmail.com,
 Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Support NV140WU2-M70 edp panel
Date: Wed, 30 Sep 2026 14:38:56 +0800
Message-Id: <20260930063856.183763-1-zhouhaikun5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
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

NV140WU2-M70 raw edid:
00 ff ff ff ff ff ff 00 09 e5 ae 38 00 00 00 00
14 24 01 04 a5 1e 13 78 07 7a 95 97 5d 59 95 29
20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 24 31 80 a0 70 b0 3c 40 30 20
36 00 2d bc 10 00 00 1a 00 00 00 fd 00 28 3c 4c
4c 10 01 0a 20 20 20 20 20 20 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
00 4e 56 31 34 30 57 55 32 2d 4d 37 30 0a 01 35

70 20 79 02 00 20 00 0c 9a 0e 00 ae 38 00 00 00
00 14 1a 00 21 01 1d c8 0b 5d 07 80 07 b0 04 88
74 b9 5d 99 85 95 97 42 20 02 35 54 b0 5c b0 5c
66 32 12 78 22 00 14 3f 66 02 85 7f 07 9f 00 2f
00 1f 00 af 04 3b 00 02 00 05 00 81 00 15 74 1a
00 00 03 01 28 3c 00 00 53 42 53 42 3c 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 8d 90

Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 251e22ba90adf..cb2707cd98790 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2179,6 +2179,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x3879, &delay_200_500_e80, "NT116WHM-N21"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x388b, &delay_200_500_e80, "NV116FH1-M31"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x388c, &delay_200_500_e80, "NV116FH1-M30"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x38ae, &delay_200_500_e50, "NV140WU2-M70"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x38ea, &delay_200_500_e50, "NV140FHM-T0A"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116BGE-EB2"),
-- 
2.34.1

