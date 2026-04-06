Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1F6EF4EBE
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 07:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D1910E012;
	Mon,  6 Apr 2026 07:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IiA9/Z7M";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A64410E012
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 07:39:54 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso30146515e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 00:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775461193; x=1776065993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRVCqY8swwC0PUrYKMetJYUFRU1Yu0YEh2/EkBz/11A=;
 b=IiA9/Z7MkGIqPCA8n1JFIHCeSUvSLP3KZyiUlQalx/a1qxS17qkqRSB6dSismDHdZ4
 xpucyoxKeAOli70g7/s5R5Sh7o/48ht/94rbTSpBqva5ODaj0B+b2MFvk5WlCctlx+f2
 wxo53U/owmztSEv2EqLT+dvDnuKyg2hEOF5wXkGBZVoEyJGI9dsJ3k1G5LNHNELeP9SR
 tDcTtc5J+zvP7HDLgZqiOE+7K930M6yL+VEoa/a2D//PKE3LQgrYoJ6UzDC70kHwqElw
 M3RgzWlBzNG/bQvu6oKlX3PI8UzNWKg2/zSIWmey1KssJeDAgtDGG36adSziE+mptfCt
 KjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775461193; x=1776065993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wRVCqY8swwC0PUrYKMetJYUFRU1Yu0YEh2/EkBz/11A=;
 b=ooO0aKs63Sa9uhztkQwLQALqMlbV/BrMYzynes5xjZhSXPMYPBB/chk8UpOajLh89H
 4FfaMhEuJbr2c0XdRtV6XsOJlJGw6riIdgLLXGWlPtIW0z5MXDWN1HsDHQVI85dFUGZx
 JFHzAMvfV16r4TjTZQDovPVXJeAkeopp/1O+yErZy1oVxfGczBOxpSJIoen5f+oo86fE
 OmthHpPbVxGs7vucDN0HHn5w45C9CcS8o/YcSK9F2+7wwuPgad831F9O8ovvxIyyEs4i
 dWUh5w9lx+PHBZGTq3fNFxfiWBNSuSb6gqswaz4AmZ/eaD34l9QG+2X+l5HtcQSLsbq7
 1kEQ==
X-Gm-Message-State: AOJu0Yw55jgO/AgqWFS/npQBWvoImyaZm0UuS3cKBZ+TZAGak4YHeIBf
 56uy5g5nt/GJ79xQP0mq5CsC9sDtAbexcdo4Ql+xU6d3cejT+Hyyjkzu
X-Gm-Gg: AeBDiet60P2COhOsH/SpDhLAt8IKDRfrDoFTkwVn0w97jAuBnR0wtvSlDfKu8NO2/a2
 DdgzC+yTD2jUJXgtkGI4RJu1u9MT0mxWB1L/uYSdAULQX8q2GRGPbaYr6xHqKBDUPLQtta5Snh3
 WcltwU3GkoqjF9oaJL96FS5y4krA25EnLKm+u18F7shwl2bakozGyRfnm8rjN9dP7QdKxO5qJFN
 IEH4bwVceCrdxyJizE5sOr25qACsevMm7s1ZrvWzSbBKtBaaa1tZ1GgDfgUJ9D6ueHL+5JwhJhC
 1HKIvp7YkWMYx+ZRlHuNp3CiVu9UljPX4be4ZJpsuvM8nvWV7hA+ZIeGb7TKNO0QzzfUdqvQ0lQ
 8CzVjaS+stNeSFP4PKN3zaEr6YInnXDsFs0UrqRNO5G8qIDMBOfRICK83tH7HaXIv2HLSwdnw/0
 H9aCdK9mrHzm2J
X-Received: by 2002:a05:600c:8907:b0:488:b5a3:fda1 with SMTP id
 5b1f17b1804b1-488b5a3ffd8mr9815675e9.29.1775461192711; 
 Mon, 06 Apr 2026 00:39:52 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e83e906sm527201325e9.8.2026.04.06.00.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 00:39:52 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3 RESEND] dt-bindigs: display: extend the LVDS codec with
 Triple 10-BIT LVDS Transmitter
Date: Mon,  6 Apr 2026 10:39:27 +0300
Message-ID: <20260406073930.24662-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406073930.24662-1-clamor95@gmail.com>
References: <20260406073930.24662-1-clamor95@gmail.com>
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

From: David Heidelberg <david@ixit.cz>

LVDS transmitter used in the Microsoft Surface RT.

Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
index 7586d681bcc6..0363201f0e61 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
@@ -34,6 +34,7 @@ properties:
       - items:
           - enum:
               - doestek,dtc34lm85am # For the Doestek DTC34LM85AM Flat Panel Display (FPD) Transmitter
+              - idt,v103      # For the Triple 10-BIT LVDS Transmitter
               - onnn,fin3385  # OnSemi FIN3385
               - ti,ds90c185   # For the TI DS90C185 FPD-Link Serializer
               - ti,ds90c187   # For the TI DS90C187 FPD-Link Serializer
-- 
2.51.0

