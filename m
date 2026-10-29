Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F43606A321
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XY+lveV5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC2B1123DB;
	Thu, 29 Oct 2026 15:30:11 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB5D1123D5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:29:43 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c49b431f022so351315466b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793287782; x=1793892582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C46XMF9ntFd1cNzpW0ccZaBdDtR6GkHK7zbgrzppajQ=;
 b=XY+lveV57whFGq8Q+GVNT7I6Jm0QUAHGeK8eCs+eN7SDiRy0CTxtgH114s6o61EbZ/
 R7T2Dr/35tcT3CSiIZXotcCC7nN54/h8/MHg9s9S9F4vb4KIBFNuQ2JKpHVgRxc1TCKU
 YaEXDqAtkV0qY7hcWaF2C7MBFqxg7f+jlYmf5d0zkBeWoNeP2wmjT88geaxWMEPHzrzU
 dwYX7Yb6uzmLm1+5NcCn3wBx65UxwWENk6NPLwefQoZPc4gMRTGn2PBfCiNUeAQnBquT
 bTP03HNmXtDNsF1Se04j/bL6y6OOmlKanhyn0tPkGsHRPv2jUDiyxa/ygpS5DDzNALem
 sASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287782; x=1793892582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C46XMF9ntFd1cNzpW0ccZaBdDtR6GkHK7zbgrzppajQ=;
 b=KnaSV8bs3PDqvvU9gXBmrJqDTcoyqkZuvY82Qz33i/x3g3P3HZUqPrEY4tJXkB5QOL
 u1HfjTpNzktdsWh1cYjHroPv14YQlBF7FtDhja2634Ry2MzAFWdPOm6GqT+qpV4oA3lw
 yPx30kY65mxZHAxAOyWp9mLt37BuKrKL/3KTyTo4HrZ4+ctHF768epfLJzMOqEKsMBVv
 zcEWm0sDNjWXf7krvOgb02ZKLO6r06teZ615Xmk9DpuQXiO17O1ImcDmtNYnaLaRDnn5
 aW2vXwALSqJ+0W/WVHG0FEr28tgge7wZRz+RxhXF4OZgsi/c9F148BzR91tK4PMcYRqL
 4/Tg==
X-Gm-Message-State: AFq9FYLhXjWPGhDVRZmYymY1xat45kAmHP+56YfGeY2EdoxjS5AKh9l7
 5v7pRoSE8WykfpKGCKiqqK+v5JqAaZtu/lMWud1RPmU6YTw3LhVBQr+aNg3BYQ==
X-Gm-Gg: AYBFou0M0PCIjDygAz7b/DM/nP5HGnGoub+2Av3fj4GCgC/s/B13bL4yj7wRz8P6OQ+
 l2BfpoMZggqFXYlOszubsWZun0Y1AnIxMFASZkciBJlaSW6HRXijIun91oBcwBlV3D1xhQKLNcB
 MWlP7pD8ZBkWFLrvhPpU7zUMRq+oUhHQxeun8WsQdrcl5MF7I5up76RBHnvcu9vsU0/SpgyvEjD
 hD7yygrW8fpw+ZGJoPXpVNVy5gxccliz9h6SuAqqVi10eFuDW9+k0TEYXa2tt7K0mBme+h1jMT/
 uL1H67fcr0cztD+EriWzjE1wMNhFMXGOtmx4ggEgNpfL5KFn2kiwocX+Hi1q55xN3a+3MnIZIqp
 LjIYMLuWEsbZbbZ8xVKoVZVrG6t8fB6wEZCutYMoYTtcW2scuPpqnYi4HeF5YfpmTwjclVe+Jpr
 I3yQ1kmPWfHN9CW+GR39K4OW46u/3+BjmTurwseMwUqBA0q82hJ9hvUSz6muVPpuzzeOxwCnUpD
 hVKQvSc3+GIm90sirMKqBEQNkAEoWjXEFm56mt8i55hbg7EAWT4Zm/AFkza3zEQTdctDjbtQq1D
 Sb/2h/vIIyDm9Aeo1V87rBHwu+mm2wH9BY7ca14X3i69Lkds6A==
X-Received: by 2002:a17:907:6e8f:b0:c46:ba33:1f0a with SMTP id
 a640c23a62f3a-c49bdf380b7mr518463366b.31.1793287781542; 
 Thu, 29 Oct 2026 08:29:41 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4ca27984f8sm1252166b.80.2026.10.29.08.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:29:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v5 06/11] dt-bindings: display: tegra: Document Tegra20 DSI
 port
Date: Thu, 29 Oct 2026 17:29:04 +0200
Message-ID: <20261029152909.234584-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029152909.234584-1-clamor95@gmail.com>
References: <20261029152909.234584-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the optional port node, which is required for correctly modeling
a dual-mode panel.

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

