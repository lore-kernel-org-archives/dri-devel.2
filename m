Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF9CF8E4B0
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB60C10E967;
	Fri, 17 Apr 2026 06:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bDwpkKKz";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2907A10E95A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 06:50:06 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5a3cee3a271so371013e87.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776408604; x=1777013404; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRVCqY8swwC0PUrYKMetJYUFRU1Yu0YEh2/EkBz/11A=;
 b=bDwpkKKzKdJnQZ1t+isDsyrKHBIcoetJNC3aIXvX3e5fjtEPd6+kZ3EWSaWCqY0hDT
 24kXRWiWwT/mjUg7flRKVAFY6IltdD9JPaanvA9+C8t+yTaiV3vGIANX87el69fmc/3b
 7aUceFuFC9rL4D+9FKJ87ZItbWRo+L+uajl2bU2kF+7YrVF7Sp50EqBHBcq4O/kfiueY
 P7Q7IUky2k0CqbROlVnFBSXwZTXd1vb/bae13+gs3e7gaGAbUnTX3EIfz2PRdYpW4sB7
 oNCsZHFx7JZrPENNaMMGco+llrHnWc4a5Mhv6ufu7wx0FdPrE3B0eVk7lR9oZt2Xwvxi
 +hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776408604; x=1777013404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wRVCqY8swwC0PUrYKMetJYUFRU1Yu0YEh2/EkBz/11A=;
 b=Pz6/rm74v8lI1ISSsTmAdttLRGH1iU26607lGhsskBloNDf5EH8Rfa/kBelSEaeF35
 LaPJjLGyv1hVOdhPcX6fdB0flevtn8HXgKlRuFOntz3GzfkIWCX6ZlsQATiCWXxc6H4G
 y4y1u6rvlpUg6/4vmde203s0a3xT6bUp/T/9vbtVfNFsxNRlJbEChA4qcyyl/KNtx6P2
 Hfmsyk7Ddo+8AqiTXjXOALIZxp8qHW62kuIWCHp7g884tS2Yu3vljEdJRR1WYD36LNlE
 R6qqAZcAtZhcJoio7MGVjVdCzRVtUOlxa4ilwJkZFmWxu2L2aQ+HFCcUqiAzp7NIhvaI
 Khjg==
X-Gm-Message-State: AOJu0Yxss99lB5ze5XWYph2AuMk201/8IrsqSkb+5jiX6RloV89tyv+U
 vfV33zYJnUvTBBmblZa5gChd4TQ9dclZLMfF897mWc/ScFsNL6Pm6cU6
X-Gm-Gg: AeBDiesWfxjN7vuB0UYkd3XXnzQe3RVn/eCbkr0yuEgfpHbRxf5at7j/Ep1XO4ZQPkw
 BSY+Aw8lHrMCuuE2NoeM7cKnwUYCX9/yRzYLG+zQyamL4CtV0laNoIUJoH3p7SHsJnMXXEjG8e0
 zQti19yw77GOMy5DeiGiwSjFv3Ha8v6EhQX9oNHa1+X5vjErYR6WlNt0VFqc7Dq4aUmZzt2df5j
 rrn6WAFevGc9W759i62Ef0fkRBe4Ye7ymPIuysJNGp2Zj+MwJj7Kf0dpSF95JgNLjLI/16msUZT
 J+mMex/ikNOjc0oRyM9w4tJSrDWjQc71eWcIcv4fYd507pgWcSU7K/ikL2jSfLpZNHU68sQLf43
 JN57X9NaWy5NawvEm9KhmMlA8fxZoySdXpd1hCSuQ3/cJx6VfU4Bwb0XKzsl2L1TK7xW/Uulw6L
 Q+nVeFyAh+9A7yjrC4kI3jkzI=
X-Received: by 2002:a05:6512:304d:b0:5a4:b02:66a2 with SMTP id
 2adb3069b0e04-5a4172e1bd6mr507559e87.27.1776408603471; 
 Thu, 16 Apr 2026 23:50:03 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad143sm153202e87.7.2026.04.16.23.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 23:50:03 -0700 (PDT)
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
Date: Fri, 17 Apr 2026 09:49:51 +0300
Message-ID: <20260417064953.20511-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417064953.20511-1-clamor95@gmail.com>
References: <20260417064953.20511-1-clamor95@gmail.com>
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

