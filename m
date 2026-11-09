Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3D606A326
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kGAoxmCP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEFEF10E1CA;
	Mon,  9 Nov 2026 16:07:20 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1123910E1CA
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 16:07:13 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so9056015e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 08:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794240431; x=1794845231; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YeXOVU3Dlu3RGzoo7GptmhPvzHeqqfiDgx6SA9rp6Cg=;
 b=kGAoxmCPY1Fl6deze5Sw1qmBrIERiDgaECb3UN9RHL6tWmQnipyS6ZW012Epj9R6Ga
 OQ2FqILVOFGUoTzMzdasSGG2DO9J4DRwyqNa1C9GlCOfyyVx+R3IzT9VHXDGJmgDjDwM
 //C6DykvStT2DSQ19hrbX4fTMaHRR83gIkpMHKHE1kbZPl9sPvaAPrLvcCu6YnIox3sI
 h9iVvvlqM3upNpHzxnH9pTcMcxWN4DnOK/nGO9YJyLl48LSLgRoQhYTpaY4dCTuHBbHG
 DHeeNNgV3sRmQUlKQMTV2MCM6b1uL6QufNWP274X4WdOgsoKonnVzipPipAAybrRlPL4
 2aPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794240431; x=1794845231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YeXOVU3Dlu3RGzoo7GptmhPvzHeqqfiDgx6SA9rp6Cg=;
 b=DZJYjrTYv+6J1l+QzAY25yEl00ZWWhkEtYrDNMsDBmo+jcaWGXpt77BKcAM1AJeauf
 0q8+qju3CjCvC84wF+d/p2fq77uQvhgw2U+xc3yRYcB58cHEvVw/GKgbve02VZOIQz9P
 3+0nYPCuZMOA504HAJrToArQqtiQdoTMx5pZJFOImOh1F8m8B0Q0eH/gdywfbdbPXMvt
 l6vVcmdz+doRmugjD2GuxZGS5jXgdqQfRcV8e25QhW/pb0t13XFT6Q3xn+tBTm1hxrii
 QU1lSzXgy2lC2wYsiyW8msKpZeHYu0QHiAmesxu/uKHX76nuQkXH8cWtqROghbK7fHzR
 hC2g==
X-Forwarded-Encrypted: i=1;
 AL+hErEo5lKNZOkgcN7IxMw1H+6r5iFWs62Y3SLJJ6c3q1SXr4NsI/R1Xb5eFhwaJbBhu1tDTo6YEfxE/sI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+kIq2V4qwCVrv/Fqw3pARHWLgvmOQIt6cMjFmbmQlx9PviPGwF
 ZGDDR6167hE56E+r+bg3AEzX2wWOsRJdfWXhnMAgcJMRxS+sWxIrUgDS
X-Gm-Gg: AYBFou1UT1MWvMPluGgvu4CyTY3nl+pONwr2MjiBYqHKPEDbd70/lVWBAVzg4mZ1hi8
 V33Kvy97SzE2v5LfpyzNK75/6iByal8SfZBehUnAzlRoStf9QL+TMFsYD+/AUPnVIxFZGPbPQgG
 jGqsxb3VxBzM2SqKUxdoWYul4biToZHTTE2o4/9g2luX4ezPs+x8Plar6dwZguLcrRxz1kzGc0d
 dZs8Fxo+7pT/nC6US4TVoVzvha57PIZg/+sJ3AFtYPEWtwwch3HZzkW9Bhi/vodKfnkR3jlqRQU
 hRP89zBwz8o0wrCuCQ9MO42uIr3KnfndJud/binMwLHhI7mCHFl6zD8qNCY0tzMnUVw0G0VHYQd
 gEVOsqwGwKGDtxt1CFIIo1u88+BavUNodP3ROTnYlfMWhwiSGGFVikO4SWRP8amklIgkWnBqY+z
 VAexvNHiH3z7Ip0XdPupalgx8f5lXm4iYSyphaFngHb+HyQf4eBtzQcMIliR5YuBDKZcmqXFP5J
 2KbpP2c01uY2j7wD7mA948HNv5b0h1kT1HE6fmjmcIJCyd5lBMfC9IgSfdJH51YHdcD747n8TYP
 ZglH/iQ0MgZM4EW/15eQuvx92wxNpjMDvRvAIwW0tajKNiQesfytmvWl9oa86BGSMRUOZoEuJ2g
 vtCgI00zmxV1DF6JP98SecAFwMmX2pCwjJGj1ScDngsAxmX5zH3cA1ik2MBnrev8=
X-Received: by 2002:a05:600c:34cc:b0:4a1:de8a:603a with SMTP id
 5b1f17b1804b1-4b960da49admr82912395e9.6.1794240430762; 
 Mon, 09 Nov 2026 08:07:10 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:863:742:6109:ac9d:152:38c3:6463])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b90f119b96sm159174245e9.15.2026.11.09.08.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:07:10 -0800 (PST)
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
Subject: [PATCH v2 1/3] dt-bindings: display: panel: ilitek,
 ili9488: make the port optional
Date: Mon,  9 Nov 2026 17:07:04 +0100
Message-ID: <20261109160706.2272332-2-romain.tisserand@gmail.com>
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

The panel is a MIPI-DSI peripheral, a child node of its DSI host, and the
driver does not use a graph port. A port is only needed when the host
links its panel through the graph; other DSI hosts, such as the Allwinner
sun6i-a31-mipi-dsi one, link the child node and have no output port to
point at. The PinePhone panel is described that way on the same host,
without a port.

Keep the port allowed (panel-common) but no longer required, as for other
DSI panels such as ilitek,ili9881c.

Reviewed-by: Igor Reznichenko <igor@reznichenko.net>
Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9488.yaml        | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
index ea7449273022..016a573893b7 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
@@ -32,7 +32,6 @@ required:
   - iovcc-supply
   - reset-gpios
   - backlight
-  - port
 
 unevaluatedProperties: false
 
-- 
2.43.0

