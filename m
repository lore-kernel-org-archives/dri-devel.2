Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A1606A332
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JEXre3Tw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B049F10E552;
	Fri, 23 Oct 2026 06:39:54 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B6D010E552
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:39:48 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso273572f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792737587; x=1793342387; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zM6qRbp5A9CbBlh2Bu/tmcTR/0lPEgQHJG0kewWnWN4=;
 b=JEXre3TwN/rIYOu50mHNd4/wMAxKmQ+MEWWq8kRcBBbXBT4GmxfaocvBM7njEiFPrE
 aN5r1a6a5AZV6iW9K6Cc1t1vKfaFrz1rD4C3JUiTt/Q1XXseRCVXSxuFLCej53Q5qH6/
 S4qVVy6rAIbENIJrc8QWQo1ex7uZAlAhzuXBHr+vkle6WazR3cPqoUe1jTwvuPBeS1LG
 fF7gQSTsThTuCNwyNJYOCg6QBGJdB1W5zbo5Wa+sUwiwgs05Ns9I0oLL5+PPvd0QvKW6
 +c4AvB+GJx62G/+cMXl59E6OjAnW3VFvNJQI9D7p69nRpDcoFLGZo4y5vCDpRxJkhcjR
 95Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792737587; x=1793342387;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zM6qRbp5A9CbBlh2Bu/tmcTR/0lPEgQHJG0kewWnWN4=;
 b=N90xHSvC2CGk3B+e4B5PcD29XsQCQwshiUI4N9zoIjP7BIiUKrd+25VzXDuv1SUNfm
 2iwxMcFe1pmidKNP178jaGUwhXy3rHlJLS+ebD8qqxQ0WnXFu+GZTVuJ1NeeM6WlkOgF
 +y0CTAGPE7WoxEGSUGYtWEh6lddSXLDAIO68MAyq0ZCttqTndtmPmBrv5B3bb8A61QLi
 hw5RTTCFY/CoUPPByj5OqPjXGr4Ew5k+oK1DRmKsEv2rrvr62YYZiltGMZ0xp+EBSw86
 22XkxmNYccvSk/chLsF0/KdRlgb1WqWv8kZd2zyFjNosvlseT850D8eXnT5l0Q9DpRlt
 8HgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByLcm1cIiQWk3tCjZ/uPoHfFUjHsSzRr3DuZ21HZyRQBsMB1NlscjKW0JQg5Lt1LTmU62G+2co+vBI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLGt7tcUrotcHN4PLR14A1Q8tL2AilP9S8uGQR8SEbAk4k3KR0t
 szs5nO6y/KA0kPQtEpF5xbz96DNselU5in9oBQ16K5q83J66Vr+xKBpw
X-Gm-Gg: AYBFou1jQcbFNaPMgGMEqa9Ap/8BgdmAzpvwUiVMurBUM1c6o3O7ll4s3k+rwVhzDGy
 3BHQUuM9UV1OeeQY9U4rxw8HSav2LDbQxcrTDTgz38WhM1ol32/rEiFDLkC+J2wecsq2ZZ1yNBY
 gGzHsI/9QW8MVF7B48nRRt98AVxXPjgt26iFbBEKFLIsX5HUVsg5mV3XSbfgehTVlrGlniAYAlQ
 4DVAqL0O1/Q5oJysOxUpDojwc6y/pN8BaivOUGruPKayqrs6SZfMIZt8tvAt0sRxFJcqe5hnpd+
 sHbZmCpTtKvtrN2nK9YPwmbvEhw1H6QYBts3vaZo1sNbDUkeNl7Cm3MNNQCliWXzUI+sioskqNf
 vYqfitFmP0veMsQxlXM04xjSoENEBGfV9Ax660i+qhXxIH++QRJLrOj5ecGalEr3jpW/kmhkbDf
 a7YClnjjiCmf34AqLJZFeudwXSdc2Gl+Ba1BUMO9CoqDsLuSTwP4yCvEB3ZSuSTcfa398ElpPxA
 dTUWHfIVl34Oj3HYf8ioq+LFSnrPGPd56e0mVrZazlB3jnW1stm+fB4vvnUet7SEwAFeCHbUa3v
 8ScLe2/jR8cr4GvNlCZ0HSY4hM4ccM0jkD2PV+jtPYbKPcbkfpz6D/mNfvayFbiPLxQYRM5hQf4
 G7GA=
X-Received: by 2002:a05:6000:41c9:b0:48e:dee:52bc with SMTP id
 ffacd0b85a97d-48e384e4205mr1725429f8f.0.1792737586551; 
 Thu, 22 Oct 2026 23:39:46 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz.
 [46.135.49.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:39:45 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:28 +0200
Subject: [PATCH v3 03/16] dt-bindings: remoteproc: k3-dsp: Allow
 referencing the timers' power domains
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-3-3ab40aa17157@tomeuvizoso.net>
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

A firmware may drive the core's timers, which need their power domains
held; the remoteproc driver does not hold them, so let the DSP node
reference them for a driver that attaches to the running core to hold.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

---

v3:
- Initial version
---
 .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index d6319c8e96f8..80eaef0a19b8 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -76,6 +76,23 @@ properties:
 # Optional properties:
 # --------------------
 
+  power-domains:
+    description: |
+      Power domains of the SoC timers the running firmware ticks on and
+      times its work out with. The firmware programs these timers itself
+      and makes no power request for them, and the timers' own nodes are
+      reserved for it, so nothing else requests their power; a client
+      driver of the firmware holds them on while it drives the processor.
+      The processor's own power is managed through ti,sci-dev-id, not here.
+    items:
+      - description: power domain of the first timer
+      - description: power domain of the second timer
+
+  power-domain-names:
+    items:
+      - const: timer1
+      - const: timer2
+
   sram:
     minItems: 1
     maxItems: 4

-- 
2.54.0

