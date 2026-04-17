Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB1CF8E4AE
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18AFA10E248;
	Fri, 17 Apr 2026 06:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UVl8gZtY";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 921AD10E95F
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 06:47:20 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5a40cfab24dso394061e87.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 23:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776408439; x=1777013239; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MiuoIrxNKK6hZD8s7gRYWwj4CEpCWmzbv6ZdQWdvne4=;
 b=UVl8gZtYQvMBiHRl5j5dq4Mgph6rXIPKqV42gJ+vc0nqSEOgIICWB8RtbAJ6Xrz7vd
 biuN6DNilfKg0UMZdFSTwRcMYuDSmCIncKpPKjyrezNnTCyqxfKY0gzydkTD7WvsuNQC
 lwOGy+cTacNcqLeZe0twK6AYsdv2UF2Jdk1LT8rXY1fhhl/9DnFlZvL70sVUc4YxsBl2
 scwA/epjf8PFBZ5QIIdZemlb6QrlKFUdXnJq5yKpejwk8oJAvPMiXx+WOV+SKoQ44/cX
 kpFU3Yu9Qnc1AFjB1h4AnBXy3n63QVmu/+b2akcnrjjx4Enz7vLpGtdtjlTA2NI1Xjld
 TzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776408439; x=1777013239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MiuoIrxNKK6hZD8s7gRYWwj4CEpCWmzbv6ZdQWdvne4=;
 b=hQkC6JO0P1tCEqU1mY5+Q+7xSKdm0/aWyU/eAtRevKx2Msznl6pHWAE/hVo/zcSYVy
 z7BvZ03yfmzBYOQbWu5LXR6HMBgYEnB2ija3Vu2wm2tNWRYMu5atXmdZ16v9C4H8dUqc
 zU9rBADki03+JpqXj0Q/Fcce+6QgQQazDJymvmolP7uMMuzzxNj/f3oylsbRWXmLoMco
 wjj49RzUR3rZuHMPQ9P9shRW8yTFSJbmXIGFL1d+ICI0GwHgqst2IhbO/aeEpLUp9Zxz
 FjZpyscua4F+ctzxHQCAkdGDSOviYxjHyRQ5/exhQNPymEJ24ce8SO9e6UJfEYo8Pa29
 +E4w==
X-Gm-Message-State: AOJu0YyqzsbnnZ8+/qIfI3k26sIq1rNc1t+XcMw1k+7LNzDrUDvjtXDL
 VpRN+e+MOIM+6q1+nBKI/yVwp6KIlAZvrWIcVBy+PmkD6GsVRdPm78Gl
X-Gm-Gg: AeBDietmpkrZWURUv9L/SutWm6/modfIbm/GAJvlV30qH5WX9vRfny3fJ7n5I+ZLcQh
 rtS4e9W0jYFHvqxoLCAO1LtdHD/TXayIWR9cu3mSG9z8qJE9jsJ0CmoqqkHEm9j1mO7ybPNIHbM
 tCmfis2qQEDcD7u/OMvW7cJ5TvbDaB/cepif6arnwf0n4uPEI/9lAp9uETj/TYisFTyeBti+V7a
 Pe4fqqZEmNwNnzbP1b5TeS//HKFWbDPY4+cApirdGrb951backMfia8lAXIAsI0AfDLusMH9yTn
 WHsq0wOJ1gj3ZMizg/y8S8JgsdeSkUu3ZtEr7ZC33wimcWxh4W9BCrPWpAL6xXJzfb6Koyh9XQ0
 hDwE+P+s9Kf1VuHCllbqSMB+WLGCqvy5XlDVlFG8/KdUFkxKuUYGhM/S/HBIRywTHK+Mx7mp0ca
 pHPSS5so6pjPGnYaOMyXW9Zt5UuiEXmb2kdg==
X-Received: by 2002:a05:6512:692:b0:5a4:2bf:28b9 with SMTP id
 2adb3069b0e04-5a4172ea032mr465325e87.43.1776408438577; 
 Thu, 16 Apr 2026 23:47:18 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187ec365sm141768e87.83.2026.04.16.23.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 23:47:18 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1 RESEND] dt-bindings: display: bridge: ssd2825: inherit
 dsi-controller properties
Date: Fri, 17 Apr 2026 09:46:57 +0300
Message-ID: <20260417064657.20293-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417064657.20293-1-clamor95@gmail.com>
References: <20260417064657.20293-1-clamor95@gmail.com>
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

SSD2825 being RGB-DSI bridge should inherit dsi-controller properties same
way other DSI controllers and DSI bridges do.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/display/bridge/solomon,ssd2825.yaml    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml b/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml
index e2d293d623b8..760645493031 100644
--- a/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml
@@ -10,6 +10,7 @@ maintainers:
   - Svyatoslav Ryhel <clamor95@gmail.com>
 
 allOf:
+  - $ref: /schemas/display/dsi-controller.yaml#
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
@@ -86,7 +87,7 @@ required:
   - compatible
   - ports
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.51.0

