Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14633606D814
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PuE42Izo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E00910F85F;
	Thu,  5 Nov 2026 14:06:12 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208CB10F4CB
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:06:03 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso507738f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 06:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793887561; x=1794492361; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C46XMF9ntFd1cNzpW0ccZaBdDtR6GkHK7zbgrzppajQ=;
 b=PuE42IzoUdqrLmZzI3vyia229yJo/trStkrnIDlb1W4XdPAMqBpZiV+mBAAgY1kTMt
 hMoIofdQd127+BlD7qupA1mBCDecf9rOx4kcwB3I2EMXLNs87zwgmv2tJvu0ehbChdzw
 WpiIANoYOkMdBXymxmD7bMhECgHH5s4XEdaclkDe7v8x+MZFY6Tfny00Uv8d26acXtTR
 RUwNukXRUzkAIHKMoUik3CWiRearKzkV77KA0iaYFjnG5J6jNp9wr9S55X3bUExFgGCE
 TLCCDTzUd8r31WTttam4cCR85HozXKM58b5ZAYkhLfVg0efrv6HZvhwkLEAbLLU9r+xw
 29Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793887561; x=1794492361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C46XMF9ntFd1cNzpW0ccZaBdDtR6GkHK7zbgrzppajQ=;
 b=H6HRVXVLRVHPQ8xUbedYUWtZ4pgtsQ6JO5qEJZxdOa710h72ibYj6cHk2APxOZya/T
 ehnmoThUXFYwD+C9MmCc4XhDqqk9hXw5MkV8oBX6L+d/qXQzQ9h5rAVXMUaBB7tOhVRB
 cyqLQSUwcuNbrj/6HTH1AizeGJbHatR0Bew05N0hmTFFX5whxvNNUo/mYJpvsKlvqsXb
 3G6pqxGqnEUY1VK+uGxfXU+oXcwnE/xDlrTX7RULH3q+TOqdri0JLrk/r9JrDxrzfJnu
 JAGGDk0pNiTcJup86hwCjcIb0jURwnyjoJR9uqfFJi7PcwrSqV4pIQl2bItSwPPpBZZM
 F88w==
X-Gm-Message-State: APuU4Z8UndQue+a8pvziXL3MlhUt4FQXNmd8GgEy52aIWw9Ej/yjbXdj
 FaTXZPmN0ddSt5MjMmUNk0nubS7XLX6LmJ9BlO/9tU2KSNx956h39Q9z
X-Gm-Gg: AYBFou3TeIoxRg3JG7iaeVT49RZn0xvtMhHhNUeHKMUFtOMi3T3UvNEWVEUB2FDtDUY
 a4WJ6VfWyM7+HQqs/nQ/gKQnJXFzGWEvAlZbXkccFqiwu0en/VCi2+Z5D4VfqeZIBK1LwRoU5X6
 I/rnkCm5ephwsA4HEvW8e7rq8tbx9oi/rd3aRUHlRChjhVbK34YlWJZjDGSN6ksfZHmgEG644Bw
 fgYFxd6YyOm2/nBbRpduRy4ogSw/5Q5GDuRAPDduovkzb3sEd3HG7Ll0H58d+P67y1gkEidTNu+
 tobtgzbW1Q0BJmFOA9Z2DkQSGWeYzK3Y3wzb4/Vel94bOwD7wKoHKpZPbCXb7uYlnB50A14gJhW
 rj8jhlaEhzUEAvQ1wx/ceK0sVVKh9pIJ7zSKHO7nJhmLKhdJ0+J7blOaSYOMPSjeR9Rgw0XRf3M
 qY3E1lnH21Aq/Y0LVcmnPD5icKZpyCjnKVxC5loRSaDxufO9Rvdxz6up/ZQcaO3+JzJuNdeelj8
 HyKWgNafLLOsiBrkgn/faCuE4N38eYa3WJVQrIqSqMZ9eLJB7m4HyqMoACuqKAu8mzVfhUEP7iC
 rZlQR//6jswd8XFC5VY0EzaM7cJ/73h3VQra9igxdQyftj3AFQ==
X-Received: by 2002:a05:6000:46cc:b0:491:1468:a504 with SMTP id
 ffacd0b85a97d-49117491f15mr3215686f8f.21.1793887561432; 
 Thu, 05 Nov 2026 06:06:01 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed92a753sm11454111f8f.45.2026.11.05.06.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:05:59 -0800 (PST)
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
Subject: [PATCH v6 05/10] dt-bindings: display: tegra: Document Tegra20 DSI
 port
Date: Thu,  5 Nov 2026 16:05:05 +0200
Message-ID: <20261105140510.165165-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105140510.165165-1-clamor95@gmail.com>
References: <20261105140510.165165-1-clamor95@gmail.com>
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

