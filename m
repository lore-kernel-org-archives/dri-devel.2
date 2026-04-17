Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B89F8E4AE
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5F9F10E972;
	Fri, 17 Apr 2026 06:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EcKQrtdC";
	dkim-atps=neutral
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E25410E96B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 06:50:07 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-38c620f1699so2893981fa.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 23:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776408605; x=1777013405; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSTYwE59cdM0X+83Cupw2VCvDy7g8S/i6/wXCW+hROU=;
 b=EcKQrtdCxLtjk4H5g3HHlaNos8Q/4eHr8H8P9lYQDRX5ZlNaYbfXfqjxNM1DPelDFP
 pYvsXnraojhfXoMwDbBEuYT9JCqcJcYYGIglAKW/jZWZCxCRczhOjYTNQJ+3RnFQwyft
 LMIXKFl9u2X7anu7f8xpxrUz2tgJD1r0iDrW/y3F6j+5j0uluoicyOMwSNEbazDLewQM
 nD0/V8SmhiGuFlVAFYrSLNKRpzr0R+F1mI45kZ8xj0ktpfsXmJvIBEI69JcBPkvyckTS
 JLbtQpnyFJxbhgtdlseLKtQtkFL2CHXD7MvQNYoOytIB1SLjkoZyynOqeWWSktCLbERP
 wquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776408605; x=1777013405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VSTYwE59cdM0X+83Cupw2VCvDy7g8S/i6/wXCW+hROU=;
 b=VLx+Y1vC8kyQxjV7prYeG8vVdcENh7BKfwA0ayFXVrBoB8H3aSE/DtMZlBXDcyfOXt
 tikAYGPCnVT+y4XmBF9qrAuZoM9ktJIRQN5ivCzOQgU1SSLQuPK49tfVdA6tRMyGfai9
 SxLuWoATcherquwzzqm6qTr9Z/M8LNpQqhDML6H9fueSeTxe1JNQ0uzIZrioWjo5k14u
 ekLi8Zs2H5oqqh9erPuzfkQTMQlZc0QcB6yrgmliQC2gdcTtMowx23tQU7k0hHeYXs1s
 vCbiPlkW0KujI5tOduWUep21hQwJK+oRhSG5EElCHhVcApPsL67u+YP0Twsl4PMLe6ge
 2VlQ==
X-Gm-Message-State: AOJu0Yzo7/ICWK4BCO9pA4D/dRVelh2LFmsP4LqgC5+wTPk/eayE509Z
 rZXZSHojdh3ofehZHb/Zjw5jFXHRv6QBT46y/N33j739GT5nTiomJoGR
X-Gm-Gg: AeBDiesXyCbmxWtRvwyJkrQkyoxLwIcba1iFe/Ry4HGsdRTo90eEQi5RX0G+caCFCGO
 kSTkj/9qTSnrHp4cwf56glENbI/h+tmOXG4vYWoImcfvO8viZHjDr0qAqcbduMccepEztdML27H
 lOEvaFYaX962xKor7P/obCI15/W/s2SSuwIfGtQFHUGHEZ/1C5Srx8YrWQX6x/uUhxh7sc16loR
 FTr7NMEXPsf3B9We8rxN2MXQdpIGW7zQM9L3B333EhA3hKutyd5W8WNZG3+LxUSylTyaHfUypix
 f1FMKYJN0zDXcBw+QM/rMVyQOSfRdlHUgL5/iEwUdFvb6nb45SJM9mIGLUtB9Jq7MeKdh1HyzBH
 JlHvF8LcWqh8BazrOcNmynNp313ToBbWdleIo2unfx96wEU62xAEnioztlnpCcJfqvA5dSW9Wbl
 Qo8By5ifr/71oLtBoppiIe7ls=
X-Received: by 2002:a05:6512:6cb:b0:5a3:ffc0:882d with SMTP id
 2adb3069b0e04-5a4172eabc4mr447159e87.41.1776408604501; 
 Thu, 16 Apr 2026 23:50:04 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad143sm153202e87.7.2026.04.16.23.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 23:50:04 -0700 (PDT)
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
Subject: [PATCH v4 2/3 RESEND] dt-bindigs: display: extend the simple bridge
 with MStar TSUMU88ADT3-LF-1 bridge
Date: Fri, 17 Apr 2026 09:49:52 +0300
Message-ID: <20260417064953.20511-3-clamor95@gmail.com>
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

A simple bridge used in ASUS Transformer AiO P1801-T.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/display/bridge/simple-bridge.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
index e6808419f625..7636c24906ba 100644
--- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
@@ -30,6 +30,7 @@ properties:
           - algoltek,ag6311
           - asl-tek,cs5263
           - dumb-vga-dac
+          - mstar,tsumu88adt3-lf-1
           - parade,ps185hdm
           - radxa,ra620
           - realtek,rtd2171
-- 
2.51.0

