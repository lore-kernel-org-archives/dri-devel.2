Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F532606A328
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nhq43x+Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A35A10E529;
	Fri, 23 Oct 2026 06:39:50 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 040F110E552
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:39:42 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so1902925e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792737580; x=1793342380; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e9iXPCmoOhpVXWg91psYHS0PCZjsptq0x3nugAHkv9M=;
 b=nhq43x+QTyl5EZZNyRaP7FDueozMvWUyPJ3RaP7EHaYRjrtH68HM4WyvQYDopKScS/
 xlY8+x/iHvlXRcsBV0bB3BNSVrsn17A/QUnH+yWGYFx4NtcKw5bfeUc1RvFy/G7mApUc
 Nxj4Me1DVAMjUnsr90Di8IprExwsMW1UGXAg/0Jcpvl5zBi5E1rg3zDHf0v363/QZSSz
 SSLF1I9p1czJ/1RlWhqmlIibo6CeGXDoC/XBL8ZW1AO4nPRrXgRItVrMgX07LUTcrukS
 GyOTNTa/sl6p1G/qnbvIph726R5h0+KjW9+cLYzZuYyVbuopBrHQYBbGeL/oFzXs1E1Y
 pR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792737580; x=1793342380;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e9iXPCmoOhpVXWg91psYHS0PCZjsptq0x3nugAHkv9M=;
 b=LQ7+bgVnxBQKtbF0TSWfGz9XMqZxqWuhQMqELQasICkcbdklcCLqbzbS6kHUXsZjeP
 Ype89S3Uqjwjo2d/+O6hwPClS+nulYvBZFWgpnGFWsGjL4VEEgJxU8KuzOSHsAivXI/1
 Rp0a78ioFZN2i1AH/fE1jk/LhYpxf+/87SGZ2kcru5zr5g3DXugXQNAncCUOtCJ6C0nY
 f6rFgGSUC7UlGp1Lqn4dy8bTBIJQC6UJHCo8xziOKGQRbF/JE2nTADW+iRY6rBPvaGXT
 RKDJXZrXp7kEtVqnkjvkQCWfeV9WhwD7Ee6RSjeWTiuusLOyvLjg6dBDwi6FUQ0ixHTL
 azkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDSoQgnGFIgNi6+oVVIDMqddyS6KVSuIfA424Acz7setLfb6mBc0h8opwPMJzW22iBClLWlFdu9Ko=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIUUFHyVcKhk18JcoKPUh3QJwJXT0bZrKS1bHNiDBEFpepan72B
 9ZYACSjIdhALXfTmov8UVYTnf3jG33Z93LprFfnm2+Woulv5qZ8q9I2w
X-Gm-Gg: AYBFou2fCjBbLdG6u+sSfkhaOlVhKbXM0d827QuqWsDjn34s1RQgt4wWARazGlRYl/6
 Vp/j65GPj2fSrsFNRYvagtchhK4J3GUyex32fp4M6gBG8xZOlVah5c0xiPz+FWn+eisUKxYIGVL
 iSQxQA8HvruxO3cYAYAFCidYoHkPrgF9Ro69ltTWjdv99/VBIlGCSwCWkMsowUIhe9dKzz/cX0L
 tEDP5tdjH376n4yip56CjZ3W4qYJPcq+XeMAzcE3vikoyqSXwTa/HNXnSEwAxvQgh9rWFcPGVVH
 2HaLbftv9FOuhObZJ7sK6GbBTQRArVl1g5bnPWYQk5XTCBcVxOjmHRLGdXNvUd/UIQJEw9mlO8P
 Dp9hEz23CKqogiX6y8h9ESeeJBhpYochEwTqGPukJegvW7uUemBaDmjHAbMv5nCbRTTd5vlLYCT
 XIm6SvcHe4vv+qIzNqx32cKFq3QXDDtpAv4lIFHbEBGDFfv5jqUvM8vBuSkgMN1ZgPVDcxPszCi
 HFER0jvRT2pg2kfakfuz8ahnGjuCLz1aT0vcxjMIo6W+ErGtcv4gRJ6i2VDcPmfbyaOLNgGij15
 R/TlA2BAuOOiXJzYosSBbplo5P0hL939FUNtAGRJY20wGMajsFAdAWONbMnowzs5F3RPs3LTnGN
 fi8U=
X-Received: by 2002:a05:600c:a46:b0:4a1:db17:c7e6 with SMTP id
 5b1f17b1804b1-4a211c50e30mr19135615e9.2.1792737580211; 
 Thu, 22 Oct 2026 23:39:40 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz.
 [46.135.49.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:39:39 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:26 +0200
Subject: [PATCH v3 01/16] dt-bindings: remoteproc: k3-dsp: Add the L2
 auxiliary and DRU regions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-1-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
In-Reply-To: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
To: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2
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

Besides the existing L2 SRAM region, at least some C7x DSPs in K3 SoCs
have an additional region called in the documentation "AUX L2 SRAM".
This is just some more SRAM that is accessed separately.

Also add the memory region for the control registers of the DRU (Data
Routing Unit), which allow starting DMA transactions and polling for
their completion.

The two entries are optional, so existing device trees still validate,
and are allowed only for the ti,am62a-c7xv-dsp compatible, the C7x
generation that has them.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

---

v3:
- Initial version
---
 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index 8b1ed384ef22..278b88b7f906 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -122,11 +122,17 @@ allOf:
     then:
       properties:
         reg:
+          minItems: 1
           items:
             - description: Address and Size of the L2 SRAM internal memory region
+            - description: Address and Size of the auxiliary L2 SRAM aperture
+            - description: Address and Size of the DRU real-time register page
         reg-names:
+          minItems: 1
           items:
             - const: l2sram
+            - const: l2aux
+            - const: dru
 
   - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
 

-- 
2.54.0

