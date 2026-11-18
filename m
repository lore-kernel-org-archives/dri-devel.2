Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB79606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=CSPJ6Qg9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D1610EBB9;
	Wed, 18 Nov 2026 08:23:24 +0000 (UTC)
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com
 [203.205.221.239])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A58E10E740
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1794989032; bh=JgUq40+uYaanNFCqDEPO2shydO8xg8uHhRQU5RuQX9Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CSPJ6Qg9PSfXTC39bnynNqqALfsWKTr6qxCXSP/7Aw0a6YHilfQVs4Oa54+wwxXMb
 V7T59/lO1ecBeLC4wPCCuAQqmzyykFmHdcuYNQgnyeJUqsMRYFY5EL9R3RSp7vGTC8
 qru7OzipKlEhjAgO/LbmtMhD6iemrxbYHWcUaT7w=
Received: from pjhArchLinux ([211.64.159.150])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id EC246C4; Wed, 18 Nov 2026 16:03:44 +0800
X-QQ-mid: xmsmtpt1794989026thheo5pa5
Message-ID: <tencent_74E280A130C68EAB42115FE6AE8E6809D109@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJ7zGM74ibgc4hXreu80LVCDQ6MaoDF8JZPeogqUP8BZEDEvp4aC
 uUMPc2k6qiA6zLbNn1kqT9NJn0ZSt+EqoFGrCIRmkWdUy1IK6TP0p/e+aKpo8HUZ64c5pcPQ4JfC
 pPv+NOmsVK4OMU7zpp9sJDKy2mGCLbV2IwN7zlmCbCy82Nlu/u01qiBRwVXuwW1plenInNgyQjKP
 KWWQSnTFzdFUomjfWMlnfYtpPugi+C71ruuHLyrYfaWWR91aRAiiJy9Gv7Oyjnl2pUUci7ZzaaRI
 YtgUqSdGochzUB7fQu/GqiGLUVSA0WPf+9Vh6lusZdow0OkZodQXsp5vls9Q3spkdwkk/37o2KOu
 ZlH4dsM/mNo1bvgjjkdv1UFGMyWS8VPhMVDpyVqydu8skEVOqutnF0Ajb9/RXaNkyM+gBkNj7WZy
 6jVeR3O2Cwu6YP0ZCqXd6X2PvycH0/iPoScVdua9xzIgaVO176pvDXgDq3JZJrwtu5RxcUYHIWQa
 m5AI2y2J2wNOLcX96tWm27wLVzokGqRo2kjwTPYALw7zZ+CkuRyCSfXnfYeMmAMT2Dy/m0yli3E7
 gGakPyYxpZteNd5uSSgkdZgIKJ/6BKiVTnszSAXKdSizIFJegjADx4qjhJQiUOCdkUw0Kwm1p0f6
 O8Ld7W0auHbS9m+DTCwscPckDEXYJbS0kJUmdM4od9LUmrKn1bj5dr2BSgcyuAygXOu7b1uT7iH6
 uJ2mINufknFHVpVHOto91YCGUqFD7rKDGZoJITPF88+BezcpcU9zKb2PD+WpJp5TU0S9+0fqQlA4
 Wn0uyxrWNVxI4+WvIitORt6S1K8knf3n9bZRxHdmPS0a2bSt3dq2beevQiJ6sf3Ri4OKixuWMJrO
 mLfBpxgc+e9ua8j6RpLfqi2F4rWN4isj5sZRrM9bM+KQakp9sk+n6tKAENtkhj91XL6LVhNANAeT
 XtBKjH2TqeFmhn3pntbeg6IuhG3em2EK2Wh2e38jPlEqca6jGnycsufK5iPqMx4QmcI/AoQMnp9F
 UwIzNj+AI2ls80ZyqPA4Gw0Tt9eWrDdtNbD9z4mJNYiwk9Z5f46XGOGhfYCYxGmOEFXEnKoZrkJd
 VHd0GW
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: pjh456 <147148383@qq.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 1/2] dt-bindings: display: panel: ilitek,
 ili9881c: add Industio Purple Pi OH panel
Date: Wed, 18 Nov 2026 16:03:37 +0800
X-OQ-MSGID: <20261118080338.523572-2-147148383@qq.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118080338.523572-1-147148383@qq.com>
References: <20261118080338.523572-1-147148383@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Purple Pi OH is shipped with an ILI9881C based 800x1280 MIPI-DSI
panel.  The module is marked ZC-700010BH and has a 94x151 mm active
area; the vendor device tree only describes it as a generic
"simple-panel-dsi", so no panel-vendor compatible is known.  Add a
board-specific compatible with ilitek,ili9881c as the fallback, and
allow the standard width-mm/height-mm properties.

Assisted-by: DeepSeek:deepseek-v4.1-flash
Assisted-by: Qwen:Qwen3.8-Flash-Next
Signed-off-by: pjh456 <147148383@qq.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index 42e35986fbf6..72d052ef2ccb 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -20,6 +20,7 @@ properties:
           - bananapi,lhr050h41
           - bestar,bsd1218-a101kl68
           - feixin,k101-im2byl02
+          - industio,purple-pi-oh-panel
           - raspberrypi,dsi-5inch
           - raspberrypi,dsi-7inch
           - startek,kd050hdfia020
@@ -33,11 +34,13 @@ properties:
     maxItems: 1
 
   backlight: true
+  height-mm: true
   port: true
   power-supply: true
   iovcc-supply: true
   reset-gpios: true
   rotation: true
+  width-mm: true
 
 required:
   - compatible
-- 
2.56.1

