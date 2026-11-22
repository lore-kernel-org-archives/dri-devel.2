Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177E8606A32C
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PZn5UuGO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3FC610E480;
	Sun, 22 Nov 2026 08:19:08 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6007610E480
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:19:01 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6b8627e0eb2so2891409a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 00:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795335540; x=1795940340; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RasVRzt5BSAwU9nANSyfsH3MNXe+l8Z8yVQSBiyQGz8=;
 b=PZn5UuGOiD5ynXHDuQ7vSnDsEWjp3qZQ1tvsHTcARrqjx6bOfHIbbLtyw/4gT9CNjg
 KgAQ/Zebw7TNp3ojLLq1ewLXMu1TzVRhBloPDN4Jg7QHFKXTSjDPUcBMGIdb0qeLpVzB
 N8+c2ufmY1GyJ+rqilnvDOoVrBEfx36wi0BEhYoSdOU1eC7qlKFMStiqac8DNMWDpxY6
 3vHY2xVQIzXwqp6mwwnJFg69YRn1kwDvCCDuQqTcaTL7qFCuCv7cmGOSrqyhSJAZKSCa
 bNcr68Cmlw/aS9fnOk9s5j8naSV4QOLQbgxkVSgui8KBC/upGPMXVVofKcm0avxgJNee
 g8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795335540; x=1795940340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RasVRzt5BSAwU9nANSyfsH3MNXe+l8Z8yVQSBiyQGz8=;
 b=YkYFAFW2fxThGk6SMujm7C2rK/X4wFCEbvKfLLWGMCEwr1kWNipvlwXj6x7T2dc37Q
 AsKh+QoCFCZBP7wGvde0rYWl8TtVXfLYC35OEFNY/P3LZucXz3uBieSaZLWpv8WmppA7
 rKqwu3LSgJZ2QTqLori02VGVh+M1wDCc+7EXpjpbpCrNcLZsQHpYvSMKtN056EMKab9W
 IkLxWkUs5o1r7XN8ZtrOcVRa2KFsl6QXiNkwnABfZ2MySzhBVn/5yRpBnhajx+o1lT/7
 KeY5HlwNzstNBLZbDntQfP7KxEMC6iaj1Ts2Kkgd1c1aqJaTbexlmznMPQVP7cZiUHpA
 +ftQ==
X-Gm-Message-State: APuU4Z8IwfZHkzIWxFQeFNjuPXvw6iEWlqXztMld3ayKyN8JlUjBU0vM
 T0nsQ7klLdM5SDM4eU0hopEzjNwz3lZrG6SyJu6R0gmDC6gaKjJxyu6E
X-Gm-Gg: AZFdTZedd/iIL6mbLv/m1+py6VxkcKNLIKp5DHvuzP3+D4iBZ95YuzRzHClE45Typhf
 BtGTKCkxa3HTkcTxlI9D8U9tAy7QOj+P5P/JsR+GybyV2pTGGxD1oQMN7udM/a9lWn2NG19KxXu
 1A8eK4JWNPfL1x9BELzPDWCkrjfQFx5rScFlmbKVONxjocKCkC+Juup4QHkcvHTHWaDuDQWLo24
 FANgIjK0xNzaMthzTenncnVFEpvf6JawjzDr5B7HCZz/794hZOGPxdik6UoR9Nbgl3o4lHSoMw6
 WoaMH9GzzXsX0qsZhd6Nk3qSU8H+pCCSaX2BRquWrogRhzjpkilMDoK1bjpc/BS+XTO8QdmYmNg
 mHs4akG+N5N6nlxxHxcSYbCVUjvttENZne7qprqI3HexQqZC6eDPaAjsXX/XSO2y8qH0WhINprx
 Ho6lsZkrGfapG3CDA4sEu31wzyDjjZ9sB2cY6k49fsjNDz+Y8IY7eXMld/+5KWDKA7oN87QNYwo
 N2qyiL5326f59khe3Qb17GuYmSzqpO9kshRSagFytZbQ8UZm73JyMmAbkk8IBcoL23KzgQ7jGKB
 6wEAU0LB74eEgf+jMlv9WrYwg160/j7B3d6g37UeMmHlgM6S2iKKkMSjlrSRXAW2Bo0gt/OKjxO
 MmCnT6MFxmw==
X-Received: by 2002:a05:6402:210e:b0:6ba:9d0c:cc83 with SMTP id
 4fb4d7f45d1cf-6ba9d0ccee5mr480982a12.31.1795335539667; 
 Sun, 22 Nov 2026 00:18:59 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370e8ad0sm3617167a12.18.2026.11.22.00.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 00:18:57 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 07/12] dt-bindings: display: tegra: Document Tegra20 DSI
 port
Date: Sun, 22 Nov 2026 10:18:15 +0200
Message-ID: <20261122081820.53199-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122081820.53199-1-clamor95@gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
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

Document the optional port node, which is required for correctly modeling
a dual-mode panel.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/display/tegra/nvidia,tegra20-dsi.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
index 59e1dc0813e73..0f4837648d179 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
@@ -83,6 +83,12 @@ properties:
       gang up with in order to support up to 8 data lanes
     $ref: /schemas/types.yaml#/definitions/phandle
 
+  port:
+    description: specifies the connection port for the dual-mode panel
+      and is required only when the panel is operating in dual-mode
+      configuration.
+    $ref: /schemas/graph.yaml#/properties/port
+
 allOf:
   - $ref: ../dsi-controller.yaml#
   - if:
-- 
2.53.0

