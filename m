Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29567606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ketN7jOg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60ED11279A;
	Fri, 27 Nov 2026 02:08:39 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274B610EAB5
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:08:21 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so5121705f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 18:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795745299; x=1796350099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A5HReqGtLLp5CEvytgVMxYdO2cCkWTCzRi2iOsig/yc=;
 b=ketN7jOgPARASsRtXxCV1ALLcKh/hyFxCH52O4MLz76pDTVeJMdEma/1mbfR+nQfmw
 D211DuJQOuHgT5Aqa5hGnIC/dJUHKEu98MGKaNgX9HQHQlIkqprBvKuLa1xf3zUPlTuB
 zG98VeJAko2xCIheDiNsRWaiouJF5HJTFcAvLwP20JAjUTj4OGvNJMQafEPDV7WfKxAp
 7vgWEo4UteppYzDmwsAh4CJuepW57K4LKae+bzSFYcoWr2Qy7lxRZAZ6PjyYGIhWtP8U
 9fCqzLe0Jk7olW+52DJ1i+eE0MtmD46X8XdM+GJpAUoGpcHtI2toms8u1S4JuNmpbVSS
 6D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795745299; x=1796350099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A5HReqGtLLp5CEvytgVMxYdO2cCkWTCzRi2iOsig/yc=;
 b=xR9M9n59NTyyVC5uvhP1GdOlqz2KNwrQxUH5MFzKUY7S9vLoFT9IAzkCX3mQlExMX/
 CqFNqkHRcvz0Fzr+ow0L03BrZhQAnwRVOXYTK6pOTIvVvauof1TQtLSoNW24UIN6ySiL
 9oCMug/vIxqrrpNLQoVkvLbuWq4TpatzCPP0jneH15cRWP5in+D+SHZugSvPqRyG8rE2
 Bm9cCqoMe6HcTtE/pklgJUrYXRu9A0OEspK+Ijw8sJRm14hEU6HPr7zJaeo0Gm3gmUt5
 WhmSXkVKbzDbeXaS3GAEhXOQLhI9DkWNDLQYS+0OsdzFoGjbiOfVl1+8jD7jEYO6TAGL
 Okrw==
X-Forwarded-Encrypted: i=1;
 AL+hErEEmh/P4UL7nNIbSy0V1nxtG+Mz3b+0LisUJyc2+RPo+WpOaSjEZDZfp//PYqaMlOiuFLAcKVC7MqM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+TIfd3sZMKekqa9+3M/HgJtdl8QzZndTKukami80y8KKOkQW7H
 9/JsAEHyc2juCTatdDt8OlQnKAvjGFz367wJmNzz6fFZi7y68BwRdy3Mll0DpjwDo2o=
X-Gm-Gg: AZFdTZfijgCy4YqMKinRHowwVZGsByUyUbvGk1aVQhdSUWz9112c2SnmHqV9fbdfcv4
 ePQyxaQU8MezMyRhEMxvfujNWGMc8eR4A4u+jkeWMfQbhP7XoeoL0yhOR8PjGmwXLpU7LOQO4A0
 z7BdsmKB6cjiDwAs2nlzw3tzycAe4R4DMpP4NdrRtxRB0YrBlZd/Vpoz7rMQGTFD//t7p/+bv+m
 xCA+uObQxQICSxOAdnsZppFhRPro1qTjZI+9bohb9DIsO85o1OyQBfpK3r9cTyDPA2XLYkWaIjW
 CtfVFG4L5iyOlqa7PLo1OWaqM4bvuIIOfwY0xu+7YQaWabZ/ktNOIoqPVTydAFUDEZk1fLVmJjH
 1kgtOsNVP4tY8er5ylhRN44oDJWgi4ARSQZO+puDDcgO0RDn3C7SCnK1TETl9G5eb3idi2wTSw0
 o1kzxoD9jpk9miWWhQs+X1SYuW+eOhHlJnWcPfuSP0x0zv/zMLZHzSw5wk5wKhiOZBeTKnDJuou
 aufVUez17tFg8LpOCNnV6H9IjF1n74yDYliII5h+7W80XR4zT6c+ijdqL01GQY/W0vy3TE1Shar
 FcWRpT8CqqG1Yy3Sncv+iWb8pMHJd6AA17jqgDOUAwmhU4KfvNh5eChRbE6ykphQup+pmr6DKbD
 rIgt5h8aVYVvTcp/em6fM3+68P0JmUSa4eoj5fWOFOxuQ9w==
X-Received: by 2002:a05:6000:41cb:b0:4ba:a47a:f21d with SMTP id
 ffacd0b85a97d-4baa47af4fbmr12166998f8f.1.1795745299448; 
 Thu, 26 Nov 2026 18:08:19 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:861:39c2:e340:1432:1241:93b7:7b4b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3882sm43390844f8f.49.2026.11.26.18.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 18:08:18 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
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
Subject: [PATCH 2/4] dt-bindings: display: panel: sitronix,
 st7701: add the Miyoo A30 panel
Date: Fri, 27 Nov 2026 03:08:13 +0100
Message-ID: <20261127020815.1621790-3-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127020815.1621790-1-romain.tisserand@gmail.com>
References: <20261127020815.1621790-1-romain.tisserand@gmail.com>
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

The Miyoo A30 handheld has a 480x640 2-lane MIPI-DSI panel driven by a
Sitronix ST7701S. It is connected over DSI, so it has no D/CX GPIO.

Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
 .../devicetree/bindings/display/panel/sitronix,st7701.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
index 3ca9aa215b7f..8d9bddc8118e 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
@@ -28,6 +28,7 @@ properties:
           - anbernic,rg28xx-panel
           - densitron,dmt028vghmcmi-1a
           - elida,kd50t048a
+          - miyoo,a30-panel
           - techstar,ts8550b
           - winstar,wf40eswaa6mnn0
       - const: sitronix,st7701
@@ -89,6 +90,7 @@ allOf:
                 - anbernic,rg28xx-panel
                 - densitron,dmt028vghmcmi-1a
                 - elida,kd50t048a
+                - miyoo,a30-panel
                 - techstar,ts8550b
     then:
       required:
-- 
2.43.0

