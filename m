Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8F3606A32A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y6lf8i1N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA9F10E244;
	Mon,  9 Nov 2026 16:07:23 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D616C10E254
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 16:07:13 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so10242435e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 08:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794240432; x=1794845232; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GMHTZUTZEeBhMzmR9yLS176DSNdNzj0orFiUqserfBc=;
 b=Y6lf8i1Nw0B40/4V0MIHMD7rVj/fByewr06udVhw/dlha3aZ3DH9K6tJ45FzZUrzUR
 rFwl2Bp4ng3cDxKCqc2t0dsJphvdJ/e2FMhrluJEoK8ngygTqURf4m20TWL7zjhf/tOm
 CG1ztvAr4fZ/Kq3ovFPvis/oBkhfT1BEObxO21BiusAmrbwSPipfGFLiuQbyqgaWga3m
 xk+iAKZczgxsqWGbcNsU+pvet4Q4y5ju6hNzIOzuXHomfXtxpVZFuFDDqCqwR6QR1B1R
 /CEM508D2vwtXgsBz5mNLK8h8O9TxZ6Ui6CU+vzgaw4ubgM6JtnZv7aZEtMBcB+A3Ajo
 zWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794240432; x=1794845232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GMHTZUTZEeBhMzmR9yLS176DSNdNzj0orFiUqserfBc=;
 b=MOMnGwipphgo3xvZrok37SShn2+plla1+jXsSqP/jeqOGYYclbG6foYRK5n6s5ClG7
 z5/0n2MS70gMRkutywwQVAcpOAWBZ3dK+vbj5Wi3ZWgAXF/McF4TckWdksNqlVSV2DdB
 QpS9T7yhvafFEXkMvSp/3KigsLCy6mcuxJC2L8hSFNR3+CjHdquxbdItRVvIobDher0Y
 eENk3tne8ym3NI3eid1gTzGbDHNrNHRgR+3JO4JrkQPqPFZPJwfq+2z4Hb9qlk5jO/fg
 9eO4P1tAgpKxinVeYtDzBARIFiwL2tNdqtSOtzMOBC7CnX42SM8yWq3fPMGLTpg/vUzw
 ocDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGLNOOrmept+d6/S54N6L83B8VhBNqDBuPmb+AnefcMxvPyFM5HeoD/+38yWbMunAYp+4TzZpSytL8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/07qN0vYZ0A5XEmN5hFfTIOV/csSHVFCNwO5rz9TaKSZBKGq6+
 bkB44+D8cKjlY36iWysCCp9hQUZBWwAnTysk7587jBAhH2u9BscrqwJM
X-Gm-Gg: AYBFou2RVLLCmgB42UReqzXMlMYAk1HLyqOGkcEt0jaSSt+m5pMGDKg6vE91MzzKNDp
 UHp/JEoYov8MbKIniGby1mVCI8AOSPGF5JYSDB+VOcLDvoPAOakJIbYGlqE1+Z+2qTuU1xz7GPa
 6500potnIjqT1QKeYOHK9JCwqNG95yilCDjGD5Pj0r69V+KcpNBS9dAV5p+15n6x6YgfmFv+Rk4
 dhy3oOxh+7nfjOGrBP6xms1RbuvpXichjIKSmUkEnYNsohSu79Zqclxv9df97zmmQoul901m436
 AXjutc2LR/LQEWRdjsJp6dCi1Z2Atf8Cgt4CS8PogAbjaFqyn8gObxYskQMuT6H67KvB0h2kSli
 D1p5aZTLgFbL7GMRyvUW+T2+Y7hRpwvH0Nqq4LrOa/er/+LJm8NFMFqK+k+5gK40ziPxwP7OZDV
 DJ0lebNz7/NS3uEp+FJGfwkbit3OOd03YND4/UV4FpUCWTz1glXbOszLnXkGdgJk59NZnQ7saf+
 Kc7Hatnb7pW7jGpRC4Bhv/RymgKkyq+eipQUjDGoXV9/DQSvxCNoN1z82KmkFgyY7tZXnzYfFhD
 hetH5nWZC8MpMaA2xtpwwCsWxEdAQ4qemhLvvRAAShLSKGTP2OvIDN8oiuakz/9EwZ7wcKhWg/u
 wDVyC0CApLFALUPYidcUMcpnasgy7ltDWo3EEoRsgYw==
X-Received: by 2002:a05:600c:34cd:b0:4b4:a551:681a with SMTP id
 5b1f17b1804b1-4b960d9c587mr81960605e9.3.1794240432064; 
 Mon, 09 Nov 2026 08:07:12 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:863:742:6109:ac9d:152:38c3:6463])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b90f119b96sm159174245e9.15.2026.11.09.08.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:07:11 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Igor Reznichenko <igor@reznichenko.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: [PATCH v2 2/3] dt-bindings: display: panel: ilitek,
 ili9488: add the PocketGo S30 panel
Date: Mon,  9 Nov 2026 17:07:05 +0100
Message-ID: <20261109160706.2272332-3-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109160706.2272332-1-romain.tisserand@gmail.com>
References: <20261109160706.2272332-1-romain.tisserand@gmail.com>
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
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Miyoo PocketGo S30 handheld has a 320x480 1-lane MIPI-DSI panel
built around an Ilitek ILI9488.

Reviewed-by: Igor Reznichenko <igor@reznichenko.net>
Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9488.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
index 016a573893b7..2908808393aa 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - focuslcds,e35gh-i-mw800cb
+          - miyoo,pocketgo-s30-panel
       - const: ilitek,ili9488
 
   reg:
-- 
2.43.0

