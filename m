Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAD1CD5BB8
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA54B10F39E;
	Thu, 21 May 2026 15:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G7Fwlj5E";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8949010F39D
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:01:29 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488d2079582so59855895e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779375688; x=1779980488; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFf1Uwc1wFfrjp8DZawjtw8U6DafQ9Z9e4+vgFSrgIo=;
 b=G7Fwlj5EKesSETdObSkoMB4I2SSwOm0P+VIRmQh3d3h6Z0q8GAECf9R4whgfrshahT
 jMWCJXZ3yJJR0UN0tUcJdt9Xj7/k6c2tOHpgzDrANh2IjDdN0FesyxUxOnpmWf4A/KVH
 wKmIfrJlmYMYTxbrOnzXx+HJV7yZ+2YTltr+G562IHPm1pcdU9oo7Y1QiZHtG9t2dTHR
 y5AMuytnmsRUh70SzAuY6Gb6roy5trBEH0uBU2rddDcFUX4NIW/eNyalHkoriMmMx8mn
 5KNH5gMXrrKPnWuBbAqqGclIPPIA5RJaN9RNRuNoqHP+yWqXqmVN8AR/oai/Dn3m3f4z
 KpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375688; x=1779980488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cFf1Uwc1wFfrjp8DZawjtw8U6DafQ9Z9e4+vgFSrgIo=;
 b=pmxWwdkmM/J7EoLxcuZQF6Zcv6XEtn7dZNtnfE8LAN1ibAKxSBSMzngZu18/etKQDI
 mK5Bkc4GdZYc3wBUnEAV3eHxtlCRgtaYxgfAXNtDnGylIlBzlSNl6UCqiUmm+HSL+3DZ
 2nkuJsH9u39AprUyEo44YfxgZCsn6KmE7ng8AztpGd37ugOOyNM3WbGBCacTvwn11Ppr
 LAuiLyDzlm9GZxtc8xsWGeQGbcGsRbilLM9nce89lB8imyTI3bcQc1zPknqx2/DKCsoz
 dsZL9e7tqO0bNM343izMV5XZFxtVQn8Ix5fLiiKs3EvmcuZSeohGJeFvOQmJuCbBNO7P
 zk0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8h2P7EZsy/g8r+nM1Oru5sSxD8T468HkqO5cAXbcZ8ZMRR+EKm2DmGjqsICsDImHEivKmEL9Ccs8Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxz/Dbobtdjt9vgDEqZEwyfQv6ub7DMXSiRjRbQe2PAJcp/PLYR
 OwXLL9S6A/D2klbWtXBf5huAbil86WBqiYjtq+UZ1YXcQ6cpm2Lbd/lg+gh45w==
X-Gm-Gg: Acq92OFnEnBF9WCbDJaAY9TTRoAduWKV8pXWDE8L+oN14YcM4UNDS4mHlw40HI6wkJr
 7wgKDHchHaB2/uVb/fsUvC3vmI5bw+ig/Jndj6x4b4pd72zQUTbaIC3MampJVb7UgXH41C/xGxa
 IYGv4KK3yE9hqn1DQnQjF9/HGRAeYtynydNuG/jE3NNRXM9heQCex1j8ZdezNDP9205T4TpSq7z
 Qf6v5/25J4S8Lr0cSVpMuoeIhML5F8aApRWh/be4VHEGtLNo4uUnxGTmlmbGRKmfl2tWO3DIAvR
 jUNYLc0bOwliWesCApVwoXgLT3xe1GxP1j2COMjkJYnSc4qR8p537IEWiQXs+CwP4LI90CfDihj
 x6pqttVWKzDwn45etKHtHpyrx77KfcVvnpJ9MoQ3dRyuxxT4qdCml6rKYPmm86pr9PWDJHfFi7p
 DqBl1UZheskN2uxkqBL29mrQSxL51szNGGPQsjxWTU9g==
X-Received: by 2002:a05:600c:1796:b0:48a:563c:c8c5 with SMTP id
 5b1f17b1804b1-4903605ada2mr28491725e9.8.1779375687960; 
 Thu, 21 May 2026 08:01:27 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm34056745e9.14.2026.05.21.08.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:01:27 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 13/15] dt-bindings: display: panel-lvds: Add dual-channel
 LVDS support
Date: Thu, 21 May 2026 16:00:49 +0100
Message-ID: <20260521150038.103538-30-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521150038.103538-17-ivitro@gmail.com>
References: <20260521150038.103538-17-ivitro@gmail.com>
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

From: Vitor Soares <vitor.soares@toradex.com>

The panel-lvds binding only supports single-channel panels.
Extend it to support dual-channel LVDS panels by referencing the
lvds-dual-ports schema when a ports container is present.

Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 .../bindings/display/panel/panel-lvds.yaml          | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index 7ed0c486870b..45183a1439ce 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -82,6 +82,17 @@ required:
   - width-mm
   - height-mm
   - panel-timing
-  - port
+
+oneOf:
+  - required:
+      - port
+  - required:
+      - ports
+
+if:
+  required:
+    - ports
+then:
+  $ref: /schemas/display/lvds-dual-ports.yaml#
 
 ...
-- 
2.54.0

