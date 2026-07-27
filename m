Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7C1C54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CE4210E7C4;
	Tue, 28 Jul 2026 07:21:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jjGqbq9s";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B3189C29
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 19:58:25 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cbb85186d43so1503588a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785182305; x=1785787105; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Sqd7xY3TaLuQY6NkycJy1WSdnW1yt4Ypj0KHceVm2q4=;
 b=jjGqbq9sA6VMFUG4nh0BPyfaS5ob/5X7wV/3HMzf5BPHcb9ZUavsANyNzWLIuRO/eN
 40S230jkCQSgljUDNIkd8pzo4wuRdz0KT4qKLGe/nHblHlSYUL8Y1pzz1sru0vg92zYg
 HRRZWunGRO95Jma1a0BPQQbKy/Om04Ws0xl1eSSUUnwqm9d7RKAuCpBxtJTRh7tMZSbO
 D0NV6xROHKJthVzZXGg4+OSnAZE+hCcxxJtwJkdXu8DFVNpk+s4DP+HoZrRTfKI+owN6
 oNDJKGtJqKT/8xKlC0a4WHErGRWUa6hhTZEI2tB5vAcpV/w3xb5LKatlyzMUIqajGouW
 Xp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785182305; x=1785787105;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sqd7xY3TaLuQY6NkycJy1WSdnW1yt4Ypj0KHceVm2q4=;
 b=VwZqKvkVI0Ns+aE79kf1xr6eGuRNxZOsXG5F23cJqGBKEwn1L72PlKV1TBL41PAFIc
 iwTLcwLC47Jh/9Hn78lBEO8T1DVI2J9if8RiFbrX5eOKxI7CsAFnm97KMZRTn1HWF/LJ
 b3p/IV73KDt4IkvkauEPeqag1t+9/OdQ0VjMT0TYSfUOTbgX2X2DfGAtAfIZgMeLW1m1
 wwTvA5LAalgTUBSJR41qLVOXg1AMMTIwPvjCgoSqD46fNhL0MmIbnGDBf026q4uP2rNi
 uEpsbGWuyJYAfTYdhy8r7LhIGxX0cQeAqGny33qR5Zd3HILx93UWV7uyC0c6sqiXOSwU
 W9ng==
X-Gm-Message-State: AOJu0YznCdCQFxQuCc/SJWetItYTLBy0cnXO9AXmlhdNiGzhlfRSeof6
 R/tDeNspyd5WVL7ZZ3fw35ovksZ+bsnz/AjgUyt0KOXChCm6NfIM7s/vuPAfsZZ7
X-Gm-Gg: AR+sD12ctsUyqADfEu86wwDVhGlZnD5IoSxx2L+ewCaehYLpw4CwbMt/a5PkvvxLesY
 +7G/MdjekeuknUbov9dcsfxi5tETtBg6SYks9AKo1onvN093WIt/y+vv6OhVMu8/qdavkwauCap
 bVhhd1xFweetYmIeE93phHowMTwLofvyyQDEYpItCutWTwIHAqV4xtoELyC4DZIf3PDwvtXDkr1
 z+1BSaf6IFtU+o6u9QROFzuIw2x2MMuQBK1Zjk0qBnK0GkupEc0Kwyq+l5sUDvoV6nGSluypgMb
 bb2Dm3V112oQeEJih92FcT+rWHFUW8AF5IeoA1L6t3awREkkEBwQFe4yfhlGjpe40WK47aa4D0V
 BbkER3QlwOid+veZGAsY7WFqs8pFCrFUG1akQzWKPirCiXJwZ1BUMX2ch86KDmu3xszHYa4aw3q
 G1up1VleQQ04Gs1LeWgvtgQeVlk6GqzGZLKMkR090s2HWmVXpZ12D9QWgr9MpYFnbB
X-Received: by 2002:a05:6a21:e081:b0:3c3:6928:8b25 with SMTP id
 adf61e73a8af0-3c67da6f7dcmr9114574637.17.1785182304559; 
 Mon, 27 Jul 2026 12:58:24 -0700 (PDT)
Received: from [127.0.0.1] ([154.17.229.144]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130cc5ebsm74265164c88.12.2026.07.27.12.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 12:58:24 -0700 (PDT)
Message-ID: <82fc6395-3425-4f71-ba58-813856cee61d@gmail.com>
Date: Tue, 28 Jul 2026 03:58:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Doug Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Weiji Wang <nebclllo0444@gmail.com>
Subject: [PATCH v2] drm/panel-edp: Add BOE NE140QDM-NX2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

Add timing from datasheet for BOE NE140QDM-NX2.

edid-decode (hex):

00 ff ff ff ff ff ff 00 09 e5 f2 0a 00 00 00 00
20 1f 01 04 a5 1e 13 78 03 ee 96 a3 54 4c 99 26
0f 4e 51 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 60 d2 00 a0 a0 40 32 60 30 20
35 00 2e bd 10 00 00 18 c8 9d 00 a0 a0 40 32 60
30 20 35 00 2e bd 10 00 00 18 00 00 00 fd 00 30
78 c6 c6 36 01 0a 20 20 20 20 20 20 00 00 00 fe
00 4e 45 31 34 30 51 44 4d 2d 4e 58 32 20 01 f8

70 13 79 00 00 03 01 14 30 69 00 05 ff 09 9f 00
2f 00 1f 00 3f 06 31 00 02 00 04 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 4d 90

Signed-off-by: Weiji Wang <nebclllo0444@gmail.com>
---
V1 -> V2: Changed entry sorting and shifted to 'delay_200_500_e50_p2e80'

v1: 
https://lore.kernel.org/dri-devel/697e79c2-98a9-4bb3-b5fb-db327cbe1bce@gmail.com/

  drivers/gpu/drm/panel/panel-edp.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c 
b/drivers/gpu/drm/panel/panel-edp.c
index 14dd40afa899..c6cdcd12002e 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2036,6 +2036,7 @@ static const struct edp_panel_entry edp_panels[] = {
      EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a84, &delay_200_500_e50, 
"NV133WUM-T01"),
      EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ac5, &delay_200_500_e50, 
"NV116WHM-N4C"),
      EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ae8, &delay_200_500_e50_p2e80, 
"NV140WUM-N41"),
+    EDP_PANEL_ENTRY('B', 'O', 'E', 0x0af2, &delay_200_500_e50_p2e80, 
"NE140QDM-NX2"),
      EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b09, &delay_200_500_e50_po2e200, 
"NV140FHM-NZ"),
      EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b1e, &delay_200_500_e80, 
"NE140QDM-N6A"),
      EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80_d50, 
"NV122WUM-N41"),
-- 
2.51.0

