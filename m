Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCA1606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wmIRrftF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1561811264A;
	Thu, 19 Nov 2026 16:54:47 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5165E112563
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:54:26 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso2160734f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795107265; x=1795712065; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
 b=wmIRrftFqyw+woyY5BUbo7oN2Tz7JmBPLq/Qje46dAon/gTCWtR0K15CNViP9NLjzq
 pYTqwniJZiZ4NuEcphuEJvxYsA2BwORacu0Iqg7wu/JBsBznX1A3Bl2TkAfw+EtQ/UaY
 JEp0KCfwZ+wj0rCo7TjbokC+VtzaJLsBXfhtBq14nHcG1bldSC0bEId0BI7Ns0EQkTrG
 fT0Fp6bJCPd4i/ngBCOwur1IaGO0GQYPWjQYWgFfdX/WHV6nSx0KuOELaCBwnuBJrwH0
 hx5ZZRa+jrHP79thS18o/TSYQqRiyEsDwDnmqrjZ2QIOjbU+ZebtqkVmkQVaHkLeYhhH
 cSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107265; x=1795712065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
 b=QeG06XPQyvxEh6mYZK25Fr6YXAzXCC9QNzjzl2mpHFhwY39Mkx8a1V+tqWREyOT3V1
 iB4xobqS9mxfpe3AXyPL+CbZ0yr4FnHx3SGsdYcEKD+1caRCfHIU89RfxjAfzdzaFaGm
 JzT6cMfJgLFEajLReqwP2/vg9RUv8eElQmrM+Sn5/UhyKWy8zqy5AtrZq+xL01L/grC6
 9t8BVFZP0maVsq0wY8EWTTsXR2BCt/7CCCsNygtFBa3ckDWmrGxC4hPxc0aRMy1WjbUN
 NbRpF7iROQ9VdPKT67Jgo/wKyltBkpIusc989UWMmJD+W1Hvl3l3b/G5QTU3q/oz414w
 IZ6w==
X-Forwarded-Encrypted: i=1;
 AL+hErFAyqEKtoGqyISvnoIl0+byq4SNGDDgKYE8amivQ7whkI2QNfC5FsFl6XuV44v2czJ4iOcALKpaAgc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+sb/V0DOqqT4yLkpJt4IObeD1CzFbpd/M83yDF7OEmIZ0dP9Ht
 HAMk0EPPznhpR0UdvtkOGF1AXrTcAKqmu4Qw/mgAoVx0nLf0Ue0piAkk
X-Gm-Gg: AYBFou1Wl4DwaZRjYhEv/D3giZKccC8k0ctnLgbC1rACbcWh/sHA4bFYF0Yst5XOgtg
 +ItVTbmofxZYtRMGJQ0pdPmfOHJG2foboYvRKQKd4jUg0zbel+6tbyT2UhfE8F2x7eLTMCUewJa
 SdYq/IkDa8Nc/z4lIndY724CLreXc2V1huKcUe/gHA2U4V4r8rlJgXe1IQx/wZNcwSTaHTN5G8z
 PGR9lV8XLkyPhRe+GtEBWL7k8wsN5oI4BU8pIAHMdqDlbsODIF9Sl+xdLB9gZBP9CCMdPDkwiI5
 LDiAxUXFVtbz1QL40od2kpEk++BwtFx3Ia9pRkvl9DaAvta5oQGLnRpj9a+Fusnz3gQqDa1jlkD
 g+RyfFRUZIOpBD5o0dvSLWpwmy8QIherz0zR1ptZonbEB4q8dv+2QIxeZWI1s7OKx07Uzxc9Evi
 cvpHndd0Zhgg9kJf0e2R2J2c0Khbcs/sjAB0CH1x3MkMdPZgSBEbTTsMVJTCysnJuUAfuiakOJc
 EWHEJvefO4devHdiYX4EKP3rHK7q1LiyCEGfnQcVmiPLt9Qp1oPMxMuh9ZX7UjPQof3GWsC7rw4
 gd66pCe/6bDgzdXDQuc3X0xjA4LEgDvm8ckMObzuQb5Et8wtYFd0Aglt7mZhlBVKdoikJY1mS+k
 =
X-Received: by 2002:a05:600c:6749:b0:4a2:1867:10e8 with SMTP id
 5b1f17b1804b1-4bb8881a294mr1876395e9.25.1795107264467; 
 Thu, 19 Nov 2026 08:54:24 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:54:24 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Ivon Argel <ivonargel13@gmail.com>, Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v3 01/10] dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
Date: Thu, 19 Nov 2026 17:54:11 +0100
Message-Id: <20261119165420.24466-2-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261119165420.24466-1-rofikcoga@gmail.com>
References: <20261119165420.24466-1-rofikcoga@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the compatible for the LG V60 ThinQ 5G (timelm), based on
the Qualcomm SM8250 platform.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1ef..85635a871e7f3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1139,6 +1139,7 @@ properties:
 
       - items:
           - enum:
+              - lg,timelm
               - qcom,qrb5165-rb5
               - qcom,sm8250-hdk
               - qcom,sm8250-mtp
-- 
2.39.5

