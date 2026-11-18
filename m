Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689E606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ze9bb35h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FAFF10FC8C;
	Wed, 18 Nov 2026 13:47:09 +0000 (UTC)
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA15610FA67
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:59:40 +0000 (UTC)
Received: by mail-dy2-f7.google.com with SMTP id
 5a478bee46e88-36c9b5c6faaso300314eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 01:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794995980; x=1795600780; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ACQDIMUUYn1EmTtADnmMvXs4q0DHe+wONMoEGR7DI8s=;
 b=ze9bb35h1MCR1OwyBMPg31mwCRhoZhXMphWEvmry6cFgRHXYYkDBQaMVVTWVPIqspp
 gPLjOWtK6u7smlIFAlEAUPlxRU9AGIqZ3IWdW/TQyhC/NdYqStYxPmBaLUrEehomRXF5
 O75TdrNNFdPPmfeMKm0BFodud/ehxekdwv4lHCaV9EhGj3TPBc1cFXPJqu2HwcqHfzCo
 toEmozjiJj7+GfKurdLvQvIWMqUa5nYNtY9vkiOOmpwOLlOQshPKwyp4cE3LmFMFSUdg
 mS0HpwOOAp7VjA6J4YuNxtFnPfIkzsNvenDJBwaxi10ODVnJoFBjf9Wr094Kwi/BeKua
 cs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794995980; x=1795600780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ACQDIMUUYn1EmTtADnmMvXs4q0DHe+wONMoEGR7DI8s=;
 b=hpQw/tU+CnhE6b1ZshXZxEsedNgA6BX9dLT1b5sua5JiWEgV8JWf2D/Af7Jw1QMwyo
 REfyfeCcNfndPfGY0iOcRwQByODsuOcheAQaOMpY2/FKr3HAzWTcyxPfeNdyUY8BmR7A
 1/aWAu+k3VzHO0r0biWeZQqMzjjuMwe4OV85gXPpJkFdsyiytXFxjVQnRIM5ovPpcVZF
 KXlRR4Fol8qvizhFc3Xvl97H3/p1PldeeyMh4xIqLm/3ISEZblxXEBp+TN94U/fC9HXY
 34iuPadmapJ0cWUDka9QuLFN/6bwfGoUgxsAfwQahND18vp5jd47z5G2HQtiUzh9fHPK
 JrPA==
X-Gm-Message-State: APuU4Z/gznzuoCsqbnsqX6KDhMla3FV4WkUZrnxmqUMw8xKZ0MVr5sQF
 Ct3lftPZUOZPraaSi16ni/34wbUmitN+3eqIOtKMd/wGdz/eO0BUcz7T
X-Gm-Gg: AZFdTZc3b4vPiYcRJDcNXLrk8vfwYULcKqyo8TGQurHAmjB/VrQbGu7TS7j/gWZmmJ7
 MB2cDf6zxEG3mS6uhbX71/qq2mpAIC4yt5QdjtT+d+oUtHBUOIXQc/TMO3EvXrwpxGdf+N2lxCA
 CrM3PZwO11dujQXqOL2EVST+kL7Pp+l2At/45I0X2WqhearyAGDZ4sJZE30J7Fv0FoYH0YKBJZU
 7RM3BJR6Qq4ma/XzmXoJ+AP/9LOKA+dLGS2AysJssASWdI68pbjri599xy0Uvml2I+jmwJKZK/u
 KFMvHLZIcqYndlQ+YFsJveO3/Y8uG8nyGeC/hn8xQzwkIdhJtgTcfFTcal0vSmSoxcfeqYIdgLg
 gBVA8tBDOra7AtA7/rJvox7+bYLMpGPw/8bCBvL1gRdSxb9hq1N1DJIzDd0sgBA+TWBrhvTex8T
 iGkgXBKD/F3AaCQr8DDsHKp+jJ8o/u0w29+228oWyiAAlSiYixsiJVmo7P67FF/rOBCojGi6+zJ
 aazmGQ8NAHHWw3GoMFnv3PB29ifLvf6cK8i+U1sblTJZcijHEP+LSbQagblQiwMQw8QtH1hHmvw
 D3Krr75/tdXzEZ+dBIorrbg1GMYq1qGm5n8=
X-Received: by 2002:a05:7300:f795:b0:366:83dd:46f7 with SMTP id
 5a478bee46e88-382803786c2mr2047731eec.17.1794995979940; 
 Wed, 18 Nov 2026 01:59:39 -0800 (PST)
Received: from pjhArchLinux ([199.102.217.182])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a680032dsm5868358eec.10.2026.11.18.01.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 01:59:39 -0800 (PST)
From: pjh456 <pengjunhao409@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add Shenzhen Industio
 Technology
Date: Wed, 18 Nov 2026 17:59:03 +0800
Message-ID: <20261118095905.127658-2-pengjunhao409@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118095905.127658-1-pengjunhao409@gmail.com>
References: <20261118095905.127658-1-pengjunhao409@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the "industio" vendor prefix for Shenzhen Industio Technology
Co., Ltd., whose Purple Pi OH RK3566 board is supported by a
follow-up patch.

Signed-off-by: pjh456 <pengjunhao409@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f1..9c149f327dd3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -831,6 +831,8 @@ patternProperties:
     description: INCOstartec GmbH
   "^indiedroid,.*":
     description: Indiedroid
+  "^industio,.*":
+    description: Shenzhen Industio Technology Co., Ltd.
   "^inet-tek,.*":
     description: Shenzhen iNet Mobile Internet Technology Co., Ltd
   "^infineon,.*":
-- 
2.56.1

