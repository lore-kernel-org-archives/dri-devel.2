Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC720606A320
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=Ex2KG1EW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=W80kNeCc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F84C895CA;
	Sun,  8 Nov 2026 07:11:53 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B0910E7A4
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 07:11:31 +0000 (UTC)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id D072F1D0015B
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 02:01:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Sun, 08 Nov 2026 02:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1794121289; x=
 1794207689; bh=D7jeB8Sl0+zRQHKbuwwkxQBuT+GoW8QxqW0+bnG9GYg=; b=E
 x2KG1EWXhcfdOhlAzkHAY+Zs/TRRZK/L8I2Kvul2EHD+hy2kf179Dv58QWtWRfS5
 J2sTEykS8ER280qtjelThxyo3WbuyiwuDp+go0I67WWxU/4PmDchUeSAA7+p5LgO
 jh6VbBrSQFcZPecHwaeU9WtlGx9eJQfqdJnWgj1w9mcBqMqySCe4SsZdpjIIjudz
 56O1JsvtBBoUIY4vBh42piVN7czjJxl3TO0IMH4NgGHhl1ETS3HzKqPMBA2b7k6N
 ztOFIdJE+4dMJo1yVlpfD8KLq017xrQkj2CORRyxQu7cbolPU3eDut+7qfUvo1PF
 748B5srLWqoqw6RSHPjeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794121289; x=1794207689; bh=D
 7jeB8Sl0+zRQHKbuwwkxQBuT+GoW8QxqW0+bnG9GYg=; b=W80kNeCcZbrjk89+u
 USwBA0gCjRQPWdExlgt6cPWY8IV8K0BpLmGOBv/F1pjBjqDSKU/rtb+RZaMTL59K
 IcQwaPKzkE3jPwhZMn7F00SPhF6cBWv5gl9bc0qrA4gkA2VdL+4gDVJMYA/C7Cm9
 /uy2e7ssPKqwv97XdTM2WTa0voPlDQR5zoNuseyusIbHi3h5dypUQjfBEwYBJQSx
 KBqhebhkkAhECz36/7KqQRvBU0T06OOmDoFdyt1euDFavDpE1HlloP0gk/uKa2cK
 U+gb+ErbAh686HykyKVhj80rsaAFgrhYZRZSijfCeLJ3ASt52+Wu+gdFoEMM+rtp
 6B9tQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121289; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:ZKn+pZ8t287gDfYP/HPw0r+Lx3hRMOHYOHBGaHOTVje+817
 aLab0MOEhfncJc9qpKVBp8EDSLlEOOa3q+vGOSW1YIwnkfdsD+G7S66PRiptp7Mb
 mRDutNJOAG7k072iLlYgUVCb9A3CNuQqhO4W2qwC22dtNFSQ1w760nri/qYX4XX9
 52/kaDMV4YwBJteL+HMAOxiSOACU/ozSm/cqQ9jqdwri861qWDw+uotOcM/extAQ
 pQIoO5qdoOqpAjL9WTcY0jfb3uXUIr+AVyqquDoQ/hZUOw9biVSO7Pehq8Bo90xF
 o9Ioy5JzVgSONx+LTwUu6xc5IpD1oQNxiOsd7WA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:1TpqjnqoHTs38drxSrprZmG20MJBnxs7rjrMy5tqrgs=:gwgkUKvPnY9Iy7hnavFA8AwFt8XMqTb7rh7Dag69Lnk=;
X-ME-Sender: <xms:SR7wartnSvHzU_0WEBYPug0qnUmuYsp01Aky41OJbFE4hpOXxXKp2A>
 <xme:SR7wakGvDgL-KhhP8BL5sedTZizyYJnYE-X-OYVmguV8XMoMn4aWkzsJ7ao9F8EOp
 JvHIuKLkUbgfBj1JhcQXjU7WAsP-EAPP9-ZhVPwOqtcdKztCALhg5ow>
X-ME-Received: <xmr:SR7wap9QPTzMDDvrbgzE8U_kgMW5R7VBb8FD_HBrNppnzCoDQELagagQNBZcNV3LM9weaHEF>
X-ME-Proxy-Cause: dmFkZTGvkKxq58o0YNxgTMh3d5jffRDgbsao96ujwv1USJioDVitFBsUz9Y9ALvBwrcFLj
 kqFzjA/JbfCca892DNnBgXlAIz/Xxro/f25InzU0DQtumgiyjJEPdVMs+6+yx7WUBJP/YG
 kYssWJdG03gLhVAFs6x0tZImyIVP25VaCkHrJsYEtQ25KNqyMNodRMMcDwL/ewfvSbUzXE
 lOpl8VaSDqhAlCB8LXVrtWvLZj7RTDhzgoNxVWjbpoiYOFTXCNgIrASZtbjWqAIunuzq8y
 RnT1o8a16XcyUiVZM+A24xqdJvaR2RIn2a0sf4Iz44fGqtMHdPP4kkbz91+OyZlEgQJ5fy
 b1zlLKi9PFjWSazuiUAe5/xK2+2z2qA9VwbcrB6uYqZ9AFo2Mc+F1O4Rw+qyOhRipqHPeF
 yZW9jprPtMnxoRGCjHCR3fm3gTNI4gY6bgI5fM2FXTU01zem9+uUEcmQS0ZiWoUfq1FAAr
 WkvG1By9DuB4+pbFEis+7d9xU3cWZZdsBnjBABI4KSBMQoinZcOuSqRo3y30iMk3crxmLi
 gpqjAn6z5ApWUhB4GU7pGQ2jZGBqwKfGk+HVgaCPLWCJGvon7Ye1l9JOWaxpsdSmI4m1bH
 MjQNUBDZikbowIp6oru0NuJ04PpiiB1uigPG1Jh4GBNoa0/5Ph6Br9O7tlYA
X-ME-Proxy: <xmx:SR7wakiTPpWICuiC1enYxECmz5fM4DGoQMEqlBkFVFf0pyK-3x8ULg>
 <xmx:SR7wav_75NeYNPKLfbSFzpjH-J4MD_rvmGqoeXiFTpGjq5osAzLsww>
 <xmx:SR7wagQx_C_kfpnTfN5ipQodUarUxwsVLpQt5Ib46nEP2L_7FX8kfw>
 <xmx:SR7waif6yskKax3BVa6A_M91sIpkwP0Q2JVx3p51ZP7zzjPtvcLG7Q>
 <xmx:SR7wanMtSMoVekfEuAWHAf6qyViu2KLeOW45Glinq0WajS3DrXQ6xWDk>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:01:19 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v16 07/16] dt-bindings: power: rockchip: allow resets in a
 power domain node
Date: Sun,  8 Nov 2026 19:59:08 +1300
Message-ID: <20261108065917.135194-8-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-1-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
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

Some power domains need a reset after they are powered on before the
hardware can be accessed.

The RK3576 NPU power domains are like this: without the reset, the first
access to the hardware after power-on can raise an SError.

Allow a resets property in power domain nodes to describe this.

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

