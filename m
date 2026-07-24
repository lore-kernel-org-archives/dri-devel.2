Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216F8C531FC
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9240210E2D8;
	Mon, 27 Jul 2026 07:16:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mo2CEsbs";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D236310E03C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 11:55:53 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so319795a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 04:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784894153; x=1785498953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Y+Y1fqW1ooSKECeHK5MtsEg0yL2/pYBJJKbFGOS2vUo=;
 b=mo2CEsbs4pi/gZ3C27jhBt1M4IPbsY1tQ1kpDEjDMHyBL58jtXO+eYY1la/3nwCT0v
 e8gVFuCEwyTSRLpe6RxQFuDPR8hhX3vl78EjWTk4DiZ/JAW0ePTsCwT5OE9Ea44NlRWC
 hkWwAFTxEpk/d9RaQJE+WTSs066sIBIEyFoQgw82/ZmymwPrgx5+WJwwet/WgUOQbBbW
 IBuK0SYVl12lfC31kDid6YLENiUL8VueNEoNsHtBnWYz4hfLcEMckO+0EoaQN+k+IHsm
 SNw/+QQXYHhr5awc0MWoD3E+XJr4iFLI9OdpWYg0D+3bXIP4wWK0DbovAU9efLUwCqqN
 5RVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784894153; x=1785498953;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y+Y1fqW1ooSKECeHK5MtsEg0yL2/pYBJJKbFGOS2vUo=;
 b=FuH4as41sxxlBC8byDYciqS8bjqQjmALtdFto09zYM63C5HDRcpYgRJBrmo4AI2mpR
 WM8CTbl0v5a0GkhAfx0pi8viR4JNR9jP3LwBX2rESBWsnVkXp0CyUCztJ07rvCVRZkzO
 esNFsriNay+JlM97nRvIwKPhpGuwodaKGjCjiC2L8FnVZZ/DEdLW3onxTzz9JW7TS33B
 6GPLYh57MgGeO3GLnHzoT4BwOKyR71C1fu9Xsb+pu47Em3bm8C8ds9Xnye1q8D14StfP
 2/ZJFeMLyJOe7kR6j5sG7YuWapwYv+7WMYI9qcdMjsWCQwTzeo1ayrx0/RnpEathMhOL
 wfbA==
X-Gm-Message-State: AOJu0YyxEbeC9djJBkBXyWRxYntTF1jMfJAc+qJTG3JzrX6nuhh10syh
 ZTNjZAIGmZrBndbpF6jwEWF4QI1Q/Fggy4eDI6icRs6JTrpZMJOQsCSm
X-Gm-Gg: AR+sD122Lq61Y6znJI/EGCKi8P+JytjIGWJHhh6ngrwLaPC7oniLyM/tTBmOXfmMqRR
 RxuGVRtonhzGnRTuG+f27KMev4RU8SWS5RX/gGtMi61U//oBpRkN7wVOjXK2yc7ANFw1IuL6odD
 Ra8dClyjrqLMl8gYWjB316BDIMOKQpnj2Z3AEJyuwG1o2sq8z2yZ+Nin/EChzBpGFbE2lXKk6dh
 SKyiYLVhVOBdSjXOOsm06d+Hdl6vUkxSVJbfacBQv07v5pUByAHQot1UxRyq+po/ilZfGHSxflW
 kWfgdvI3wLSb6zP7NBvIWC9VT0CU9ElaUIT2zQLYq1FsFEPRJwY773QDcvln1PjCLkCa4srPNyk
 PQfG7WD9DfdIMiiVJ+U+M7SxHuwM4R1L4PDbJh71OcoymHvjS1DYPq0dQoQbr16zslyTtfY2m9N
 zeBWgszw==
X-Received: by 2002:a05:6a21:4a97:b0:3b2:a809:ffe with SMTP id
 adf61e73a8af0-3c44afb58bamr8011332637.14.1784894153291; 
 Fri, 24 Jul 2026 04:55:53 -0700 (PDT)
Received: from [127.0.0.1] ([154.17.229.144]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc9f2f0sm31657487eec.13.2026.07.24.04.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 04:55:53 -0700 (PDT)
Message-ID: <697e79c2-98a9-4bb3-b5fb-db327cbe1bce@gmail.com>
Date: Fri, 24 Jul 2026 19:55:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Weiji Wang <nebclllo0444@gmail.com>
Subject: [PATCH] drm/panel-edp: Add BOE NE140QDM-NX2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

Add timing for BOE NE140QDM-NX2.

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
  drivers/gpu/drm/panel/panel-edp.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c 
b/drivers/gpu/drm/panel/panel-edp.c
index df7286679446..9e0981ecbc1c 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2031,6 +2031,7 @@ static const struct edp_panel_entry edp_panels[] = {
      EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ae8, &delay_200_500_e50_p2e80, 
"NV140WUM-N41"),
      EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b09, &delay_200_500_e50_po2e200, 
"NV140FHM-NZ"),
      EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b1e, &delay_200_500_e80, 
"NE140QDM-N6A"),
+    EDP_PANEL_ENTRY('B', 'O', 'E', 0x0af2, &delay_200_500_e80, 
"NE140QDM-NX2"),
      EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80_d50, 
"NV122WUM-N41"),
      EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b43, &delay_200_500_e200, 
"NV140FHM-T09"),
      EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, 
"NT140FHM-N47"),
-- 
2.51.0

