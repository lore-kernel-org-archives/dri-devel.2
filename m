Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B3606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=hmW4mW/+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=g0NnamYk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7900B10E3B3;
	Sun,  1 Nov 2026 08:31:44 +0000 (UTC)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D44A910E3A6
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 08:31:32 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2C40B140030B
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 03:24:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sun, 01 Nov 2026 03:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1793521472; x=
 1793607872; bh=Wz+fYkTCr7Okjzso8/sJigIF8iC1QkX8G79jwaGo5+4=; b=h
 mW4mW/+aPVBZ12gri7GuURka7Yb3p9Y4E44hVeEwoHCvOm2aq8DZAvueo1jOXfVk
 pMA3+Pd8FRAvn7Slg0gqEv14XuSSUi11EvMRhCq32TD//tImCQMLnMaD1OJ4vCdN
 V9H7v2ZH8jqSV9dAtJC117IfFXyDAsx4tansCzd+BA7RcCmIuYnPX+zmK6p+kRyE
 qXeux/0NB1loSvMMZMrEWZh2BaluAmibHSJyN5hgukl0Vp7AAEDbpl5ieemVfJnt
 dlYoteeiAIXdVhXpxGJ0bKevq5Krd3O3Gdth6sPwuS3Nk66qxHTjTdAUi62YAE+a
 k2gN/3n/DWhyvKzzkfXNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1793521472; x=1793607872; bh=W
 z+fYkTCr7Okjzso8/sJigIF8iC1QkX8G79jwaGo5+4=; b=g0NnamYkx/KPdK/In
 PvdbCaZmjQkFTAu7PS5IxejRr7YSED+aSUS0hr03lVDc+U+AgfyWSOIKVzZpB9De
 L+EHkvVfQcfj32J9rkubcyaJJg6DaZts7ZouRy/dMpgCUL/8SMSqNCDi/RmjTi8V
 YLHo5U77xFX9XtdExOgnmEjZCcbVsHJh975/uJHaaJ6sSyPhhB30dPONfM3dULd+
 HnhMNCtIUO7I4yTMDufXmwosBmeKZw95P+bXP+cUjJYdb/lIukFIOLSGJigPtYZG
 H6trEihD3TBPMOzwQPYZn6eKhtD+B2/ZQ0StXCx5kidZcDhVSeYTGdE6FmX+ye6M
 w6ZTA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521472; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:a3qJNQcCbhoJJy9flzB+r1E4kRQ2xXFPDqV0jTQbCBqVlb6
 ktFbzo/dqaNI3Use7U7MbhCrEJUcF0ou2/tgJn4K6lIjeM/62h4JMXAtcV3lFBlE
 tf+DmyfJNHyJvatxGKNLlN+MU/ICscxwAS0YroTtLk0S0xRUICAEaHiznI6Lx7/M
 2krGFsC6SJzuWtClYjj65a7eBfbKXHwkkbwYmqJaVa59rQjE87nMpBmi97l9VpDD
 XJMYuvJDgeVlMmqOU28XLSFiOoMSYGjjVvRNn9REEsau7tyZAvl43huisMeshne4
 qUKAlUqrkTKFkaOyhjUG6IVH2/vRXwNxONBD7/A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:AuDY1rQ3xE4m6EAZjBzoq6dlquujFZmA2PQVC4HCjLw=:TN3aTeRgXt68gG87dISQ7raaJX+eIrztSRy9WTHvnVY=;
X-ME-Sender: <xms:P_fmaitgk4_rRnpAACXTmKhb_9UVHphmEFKhntW2AwFZtkcyj6JT7Q>
 <xme:P_fmah18Oxocb3bNQ0hi8reSp79ckXKzBDIpnyrQxfE98EyazNhW1xxCRLxfMIK9l
 lK4XZaGtxUCua9IEQxLqP7DbzabC9CJhbIxkGIwS4VIfvW4uZSDeNgh>
X-ME-Received: <xmr:P_fmapVna8kk-hwAW43lPrUsxjcFIqt2XYPu2lfOyIe11pnEpnO3qLa1YcKfr-U4Y_nMzPyA>
X-ME-Proxy-Cause: dmFkZTE59zONyjwT0eThdL4FPYOz+8ja6SLa5l4V3bgwpmkkDmFkoqDTfNyo3apIgr+5zA
 +GX40G2i1WjExuIg5f5j0S/Ul0HK4oypT7/1B1/SHJWWpq2lopVq+LGYa22qMV7xnKcOP7
 nRamCIXVbfPCWyur+KyeL8Jgz3udE+CkcK/xQ7qb2IPu5P69VI4I9xemnhlkMQog0/jfKC
 oYas2+gp2OvHPeMU6mZxc/LQ5WKZoTqdbza+oPxY9QtBcecYkd+Ww+gWTbHJc2mvPlzBGk
 WhmlNlJQOs9rb90D95CuWSzhQ9o2nA9QMy/4PmQEE3kbXGgLzjYG4iahzc7VhQuu8rHVIs
 QRXj8IcUMCV6LqOsUbX8MEKLnWMZkyqK5P/8oawKO0OwXr5tFPSUQ/FZCKOqEWegYrbq0Y
 yEg4Zqtz1RhXaYrCrREFs4Wil0lSsx0c+ymoyf0Olx+xoxk6d4skSFbyTMWPUcWgkxrT6J
 aB7N56U9RV+/r0vBB+iAsp1dvOV+rFGi1kfBGaZgFnWwV1clNb6ztPS8TzkerH2vyWpZcT
 F7QhknNQlUQnb7u4Dsay7UkITB1PwwkwEj0s7vB1qvXgp+enFLULJDji7a9TwBrvgKYWLn
 60nmASarAT5aHHEn6VDz9kDb+nPe9ELb67ADMhpAR3kxQTGVkw1aFXPWsaVQ
X-ME-Proxy: <xmx:P_fmanOzxkL7WT5FwgQiOhjo-gpWXKDZDOYLo73jvsGGZOjLow3a_Q>
 <xmx:P_fmasxLEOuZuxJ541X4aClTtgLXeYvyy32_HFQjVOYG3yjrnnEYWA>
 <xmx:P_fmakhaQVQyvX_dT-jPshwCAa0G8TfaRyLuTYKui5vL1kOSZPflug>
 <xmx:P_fmarTYN0so67cnY4B7Hq-ywrSXcfiMUArZoN6YNCB70tqhX06MzA>
 <xmx:QPfmamu_M-sm0g9knLLqJjsqc-3fbwzrWju5nVSvmXUWe1f1BhLS8uy1>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:24:23 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v15 07/15] dt-bindings: power: rockchip: allow resets in a
 power domain node
Date: Sun,  1 Nov 2026 21:22:59 +1300
Message-ID: <20261101082307.151957-8-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101082307.151957-1-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some domains need a reset cycled once power is on. The RK3576 NPU domains
are one: without it the first access after power-on takes an async SError.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/power/rockchip,power-controller.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index b41db576f95d..83741f048716 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -136,6 +136,13 @@ $defs:
           A number of phandles to clocks that need to be enabled
           while power domain switches state.
 
+      resets:
+        maxItems: 1
+        description:
+          A phandle to a reset that needs to be cycled once the power domain has
+          been switched on, for domains whose logic does not come up in a usable
+          state by itself.
+
       domain-supply:
         description: domain regulator supply.
 
@@ -216,6 +223,7 @@ examples:
                     reg = <RK3399_PD_IEP>;
                     clocks = <&cru ACLK_IEP>,
                              <&cru HCLK_IEP>;
+                    resets = <&cru SRST_A_IEP>;
                     pm_qos = <&qos_iep>;
                     #power-domain-cells = <0>;
                 };
-- 
2.43.0

