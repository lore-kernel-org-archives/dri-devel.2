Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45529EF4EA4
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 07:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39BD10E1E9;
	Mon,  6 Apr 2026 07:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SscDo4XU";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 629C510E1E4
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 07:39:55 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488b8efed61so65885e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 00:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775461194; x=1776065994; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSTYwE59cdM0X+83Cupw2VCvDy7g8S/i6/wXCW+hROU=;
 b=SscDo4XU3rHnuI7XF9LeBtHwmLeKW1Od3p4a9ROtBWEY57uQTKP8dOrdI9UcgGD4kh
 ltWyBRNdN26zC7L07I27Njicts5Vsqab0PYCyJCFXMfimlPTz3rmsV1A2flMZxMAFsk+
 T5YlHdRFeGkYcTy336uGPfLxdY9FN8ihH65PxbXRH+C5XpBQuKwmxyZLv4tOBJSVvkEX
 ICazqKaUQSCGrXTII4fM9eU4O/GRuxlsya9ujNMBvMbMBdqCshReDFWdl/Sa0edpnU3g
 Y7/Ru1twzlwL82yfqaCX5nTtXvc3LYVdHSPgwPg9ABRsR7FjFGYXaC6KRyykoW8FNu8p
 /beA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775461194; x=1776065994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VSTYwE59cdM0X+83Cupw2VCvDy7g8S/i6/wXCW+hROU=;
 b=EaHIFsC89+Z526s2lRaHXcftcWU2npKqVXfd7Olu3w9JmzgmTSqnZaXdVeI1rXhhfe
 IYZBgMVBuAnvxSWTLdcdfZpzqfszvXXKWEDtDVP5p9sMXzpUreG1XYXb8wcEt+mptnn5
 z0krW5Qk7d5YBJzdH9kVTAsW1+k2sZQ9T9b5NE1s2HkwTZtSMo1BMUQddPypnL7Yf1e8
 u0sPsoz7CDz4dkv41PItnMofvI5Wf2OfJOLDKBJeAGDPqQ8Amls+QACSTgej2K9mQAyV
 OOk+bhmPVN2l6VR9q69icjCfGyteSTwsxO4vyq9X/8TPiXdTI76vsDRHeVRTnlxX7fbS
 C+Xw==
X-Gm-Message-State: AOJu0YyZ0rLIWdwB65Ci1+o0gW+V1sI5VBIG9rvE/3lqkwjHr2UOQnCY
 IxEpl20BAOj4y2x7as/xOe1tlIJR/EGeq5b8LUzQWnhoDxJ0aoUwD/Fb
X-Gm-Gg: AeBDiesnqcxLtqi5tsidmfoqNSy+8QKkPg5Lg2mZcb8aGj4jp6X36PX9JkjsyY1gUP5
 TEbIDF6drgiHddO03SC+wAvSQy5NhFY3wOMvC6Z7Q54J7y/YUg5BhV/H1Uo4s77gjtLiTdY0X6b
 f9rQU4vrD/8Grmq3pZcTAYTpi666BVoVyxJ7dM8gjMNVct8kPAqyQsNbp1zWCQ/s065ti7ynR6Z
 bv3rHwWmLKtGAh0vbBIGUep2g4yASv14qP8oRNKI4HC+Mz3LXGrf2su5nsakv7Ba6UFr4DShXwL
 SjMCajW3iZMMR/W2QjPJgJX6qyvJCPv8owfxeCRv7NEgz1uJcrkMSvV1nqmSJiB+5m7/Fp9kJn3
 xFVwAs9ZsU3c9Cij1MmnSALiO8jpzMZB2fD5tuVMNs7lxAUuWlav4h1MU1UQ2hNy0Y9Tpiowe4I
 LJtwbVBmfMOoXn
X-Received: by 2002:a05:600c:620d:b0:485:fbd2:f72 with SMTP id
 5b1f17b1804b1-4889945faa5mr162825145e9.1.1775461193827; 
 Mon, 06 Apr 2026 00:39:53 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e83e906sm527201325e9.8.2026.04.06.00.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 00:39:53 -0700 (PDT)
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
Date: Mon,  6 Apr 2026 10:39:28 +0300
Message-ID: <20260406073930.24662-3-clamor95@gmail.com>
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

