Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD51CD5BB4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA2F910F38B;
	Thu, 21 May 2026 15:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r0v1bKa5";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA1E510F380
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:01:10 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso64085815e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779375669; x=1779980469; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kx4NrXh6e0d7nDyJTPlJmHDbVsDuIXTB3GMJlYOnaS8=;
 b=r0v1bKa5PI+U++YgfjW1KBm9fHlCaKeEKWG5u8A3zUna7YxchinWW74/GRQbBypLI4
 EZQkX2+kOzly2O2zQrLAXQrsbe7pHhRK7EhaMuAPnz+xUWomnViC78EUVFOsWQEP2dca
 lxdagE7+zxp1Z02mmCOt+TD8fSIy1ZjZUrXruKxq6tVcYH/sFjHH3Cx6PI/aO9emAAEg
 naXu3fYV7O04n5gLiMRr3pzTd0XcMIrb9AJfeTz0Sl8xczgqzK0tk5CbNUXL/nlqyeSs
 ICxzpJBxdGZTf3BpqOPJGN3UJqMS7uvbwwwSvTSeY0tLf+o07P4ja+D/7IA/s4qq8tk+
 WRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375669; x=1779980469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kx4NrXh6e0d7nDyJTPlJmHDbVsDuIXTB3GMJlYOnaS8=;
 b=Ryn/vDFm9G+j+G5DAF4h34ew4ItptBzrW436FYNDEcXRBZNa6UIqwiXQVWZu/yyqk2
 bQilnRQ8zPzHctt7zRmr6kUgs3/89d1ZCn+x2ZOkYAwq/Od6YHGNUKcSMH90Ykw22WYv
 nSwaJzzD2O7VFeVjDT6MfiHfOajkFv0P4L9C4DknqxyKO9Sn2qRZJFu63kenerl18KVD
 tERWpQ9uzGK9CZU9N/wiUPpHPx7pMjMeAWCYFQkM8YG8Pp6Uv8fv1efkRvFNwZ2XlW5p
 bvwMdfShfRBZZJbRUG1zb78qow/aRAGMk6+xI9MVPuKZdKUj4smpraWoegcGCoQmBWE0
 Y72w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rPGmRvwalZ1V/mMLvlBvN5RdfuB6p/VO4pSxKAfFWl2QsFkg1UWE/1/Od4cxQCK6HFXjBdzofnWg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxREvCu8nBO9Wz7/SSv8o3ZxqP2NRqmdRTv/Xuy55V9jTt1gA/y
 ztBJC/e+6qJpDDXeuYgS+B6Yi+25Ly0dba/F4HpCXThhQ48sZOEMFaGV
X-Gm-Gg: Acq92OHAr5ox+8f6W5t1Xr9IdMOle/o6SX42LVNobxbiTzXCSua/HonsyLz9PX/PCB9
 vg4b24kUpbUlEn/yYI7xxSFUn6acMJoApDJZeufkl7GSNPwO9S/XQoLqH0fi/SSHELetGNkPhqA
 VDSIBPOB0vQvPK8sCjvadcfQWDRfkudKx/YoXDeHnJVHbIwc/+4B7OVeLnA5zk0p2kNMOffZSOg
 EGxQS/1+kdNnShJt0b8/ZsoIcgfsbq/bDHhdA7nxr/mUURQD7WQZJyqa7ywdGmyJwmrJlx3DOHl
 kTSKT4N3eiQzQKHijjfzL6Y31vDJ7ENrsmsxZf9KDp03JefQoKO9I3J0/TvVqLzD6dYjgRCJu56
 4XHp7YhxkXo5VGQniVGjTpm0ffu1nunpx+LohuH78cYcWuR3aqFjn5/Ced88+1iOxJg6d5pNiec
 xWHGKeEmb2MMBfMwj2ygzQBjcCvaEyhdlr/P6xs/z6TQ==
X-Received: by 2002:a05:600c:4e8e:b0:48d:c0a:3813 with SMTP id
 5b1f17b1804b1-4903602cb4cmr54844565e9.3.1779375667684; 
 Thu, 21 May 2026 08:01:07 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm34056745e9.14.2026.05.21.08.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:01:06 -0700 (PDT)
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
Subject: [PATCH v1 04/15] dt-bindings: vendor-prefixes: Add Riverdi
Date: Thu, 21 May 2026 16:00:40 +0100
Message-ID: <20260521150038.103538-21-ivitro@gmail.com>
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

Add vendor prefix for Riverdi Sp. z o.o, a design and manufacturer
of TFT display solutions.

Link: https://riverdi.com
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..bac056d486e7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1403,6 +1403,8 @@ patternProperties:
     description: Embest RIoT
   "^riscv,.*":
     description: RISC-V Foundation
+  "^riverdi,.*":
+    description: Riverdi Sp. z o.o
   "^rockchip,.*":
     description: Rockchip Electronics Co., Ltd.
   "^rocktech,.*":
-- 
2.54.0

