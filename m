Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11BCCA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49F4D10E4DC;
	Fri,  2 Oct 2026 14:49:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="NcqoXURK";
	dkim-atps=neutral
Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com
 [74.125.228.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E04CE10E204
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:49:54 +0000 (UTC)
Received: by mail-ed2-f34.google.com with SMTP id
 4fb4d7f45d1cf-6aae359e2c0so12065523a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1790952593; x=1791557393; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=L9ik8U3QoQNQPe5SHdLCShleOIeiL5bJn3z99i0/GMM=;
 b=NcqoXURKYYTQ9UOKbPZSN52JwThzNbx10hnYrj4vEJnGv5gRpM/R1UzBwi6o4xYUtt
 PKoHBf3iHHCP0eIJceJKuiy8Tno/44ua5alH89l2Xzv/x2LTslv4EUNVDOc0559ksfKd
 ZJPqCkMDm6I+B8haPwJ9+OixZzgqd8bfOXwWb+A5srXPc+tqM9ewn4NBffBkSED0DJEX
 JgZRyOkKUnUpU03XNDFE9VYBftUIgFcfoFV13S2K4Ki1ul7R1eIQGEvPR/WGl7mMDKzV
 X8tGT5lggZUXdojEFVZD8GY71KZ+a0ay1jXaa2n8jUeBa66CtD3V6cyfTYA810/lJ8jq
 mbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790952593; x=1791557393;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=L9ik8U3QoQNQPe5SHdLCShleOIeiL5bJn3z99i0/GMM=;
 b=OMkamgoMU9zgxjchFIw3THoGwxdEusR6woo1czNW6jufCyjJBo78bssnEhgcUmsy4t
 WvoWCkpRhJhhBAmU/4v+ViMCHKGBUmY9U6hnTULhPaAkeNeZowXT7e9r8OjpH/OY6zC7
 QXnU+8eIaIkUgXsDaYjTDeR2RyKaqnqs4Q6km9lHC6gbJjsA7M33X42Eay0MCFWKoxrJ
 M9G8dnnd6EiEeq0P/KguUWu/MPkHbKcL8BDQ638uArYIRyfW/U+rro87LtQlN8d50Bij
 /ifl/jSI34hAJtIlxwiUVBe2wJyD0TBdVvQXEX1jqsI6w+I/Pflqnp1Ltf9e0yMo6ZA5
 R3TQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxi9hUNHafKX5HQP3lTkZD7/sRGf3Q47fwi5BWQVm47lX0f3s5Xs9MjIlUC021LtCY/ILe39PEwVyk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m1P1Z/c1/UQWdYlpJAm9Vcj+zRR4xtcq7OtDkILEt/WV8uW6x8
 HcCztrPd3Qz+i9SRpPtYLCdL6tH1etiUoQxto5lNh7ZMSAc4OPQnY3EjED02dHlEkoI=
X-Gm-Gg: AYBFou2C6xlVGdXEQdITOpK00mO6qxuuGnh9zFk5UCWEeynq5fFAHiglxKFxEtVB1VX
 AZjIKEZ/FAn0LaCA+itX2SKdHYvvb1/xlwhthLmrIAh/WZk8+p5wwx5cVCg+WCzAO1F7TQyjIIR
 EBcdjm6/uH3QRoWg96jRWUIyALF6B4CI52DiEahEzcFtUhQEssEvpj81MGk5rUPIIh0wsMaB811
 bu5j4paogkmTqlP7R7mGCOl8rqJN6bfuNwJPRvw0Kgx4553ttH3DZv3OG3Gj39zGDMCrd6EfuzO
 xVJOSR60dEwQxPWI98ZhXAVO6Az7+RRkAHEg/hdBapGa5KPmthOwAeHeWg442hIqjN63F0Jrsq5
 7fj+K0I247Wl6uIkUU/sssYpwLY/83vQnx5n+vtDVB4Yw+jOs6uFTMJy3ogkGz+ngDpl+rz/Yp7
 VA7mddf6TudZHaBlq24698FP4TxlxeCD9sSXqHHJu10jgMMHwVTlodtBatDqCAWAtryNYejpoZn
 UTx38bUuiI9HyWKYv/xnK7bmuYtzfifB2YhVqYUx/rWs9Qpb52E
X-Received: by 2002:a17:906:c143:b0:c2d:d289:e9ef with SMTP id
 a640c23a62f3a-c2e4aac989dmr291403566b.12.1790952593255; 
 Fri, 02 Oct 2026 07:49:53 -0700 (PDT)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e4cfa656bsm94539066b.74.2026.10.02.07.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:49:52 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] Tighten compatible matching for himax,hx83112{a,b}
Date: Fri, 02 Oct 2026 16:49:49 +0200
Message-Id: <20261002-hx83112-compatible-contains-v1-0-d558635ab7fc@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrBvIRJC0VyldJONYp7RRMmkRx
 Lub6u6/zV9BOQsr3JoVMv9EZUoVeGmAxpCebKSvBmddh9Y6My6+RXSGps8cisQ310wlSFJzxcE
 Te6aWeqiHOfMgy3G/P07rN76Yyn8J27YDMceoW38AAAA=
X-Change-ID: 20261002-hx83112-compatible-contains-91f8ce8ec3cd
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790952592; l=748;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=2O/S3XL50vnKkv2tSiVpbykmAydVtqNSzRobMu03p2A=;
 b=UkE+b8v+10J3b4FJm8JvS7FzqYhsFdpkNMq8xiMS/usGGxhwn04D9UYTOET/8+4palDdDBkbl
 DXBdzOwNR6lAUhyGtoQUbswtR0rsZ+DCL1BDR1e7yIG650exuYvntQq
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

As pointed out in the nt37705 series, fix the match for compatible in
the himax,hx83112a & himax,hx83112b schemas.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      dt-bindings: display: panel: himax,hx83112a: Tighten compatible matching
      dt-bindings: display: panel: himax,hx83112b: Tighten compatible matching

 Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml | 3 +--
 Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)
---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20261002-hx83112-compatible-contains-91f8ce8ec3cd

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

