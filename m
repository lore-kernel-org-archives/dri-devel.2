Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0436B60A2606
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uL7S7Bc+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C3110E22A;
	Fri, 20 Nov 2026 07:34:14 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0309B10E22A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:34:03 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-49a92144733so232223f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795160041; x=1795764841; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
 b=uL7S7Bc+scuYY9bPLOI2aV+rJ+RpSC/dmEp1MK1AGCvnC44hy0sAIp2D4gz+TiAKd/
 9zOlOD4Bf6vEPdbmTRgAveysGfoUflqRaEUMY/tcBZc4K82qeDPSLpNWGsGaIXsYLn61
 eZxghr4uv4RHg8YYhhXiN+ZaLRT8GHTqE2NJSqMH1QkClmyOvvWeku3oZLcnYfeBnf1F
 xCdqvq0Mlnu9Xp2xQX0qb0up4txiyIr1l8vhTcAnnE3NCEil5jUpy3z2PgRJAI29/rTd
 5tE4vDEpTVdamH3QjZETI7XH5mFmcTk8smQ401Q6DSuZS4inAdHjIJvS9/vpbA9zgKkH
 b1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795160041; x=1795764841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
 b=2TWUgwwcOXRVhYQzTAIxvY0iiNti3lCwEzhEBxToYvW3u1F1pxebD85YDdvtJly6Po
 36NCijvBWuFP2X6aujtJc1x4EG8oEsvmZY8cJSXQRiB/yp1U8HtU2c2x0ff8FCalU76s
 9IenGHmk8fIaKNuXClwnSzfBmdbbRYBf46kiDtDllqX6kMB+G9s0SY40uffnpyX5ABIh
 1kMRxmXYtPup5uzHNYMwKfRdLxErA08Spv4kNM5Ba8b+5h7SyLk10Mq6GG/+5+O5d6eV
 e8QBQTo5RjNFi5VPkylzkBGHb6xv5L6MR0biAW0IRIzi/xN0edm910jxOeKpaauLLEnF
 +I5g==
X-Forwarded-Encrypted: i=1;
 AL+hErHKOOp4NeMId5F8pwtulPOvzyr+X9lf3OFFaKK9thJ0S0xBqa9kL6hSVZdhZiJwYwztk0pvM9iCm6c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ATWhTvi3NqL3ickhEIFFacDp/0x4GtlXWu2frGCOPPgkRwMLG
 SbnDUgg2GltlTY0kjBkEwLvo/GSEGd8sL/9i/AjeyYfKEri5WvvHWvCz
X-Gm-Gg: AYBFou2kwdBM4nhT6mzjKRQuphQ2GHJmMRK7q5z//8VYP94YWtyYUDwJ0KDg8YYn43Z
 t60Hbb0sRgEHc2AkoxzoI3xsa2QRmO7zolai0RKpU9ERwT/c36+Gw1VBdcwX/+MYfdEfg3IcVw6
 x/T9A5WxFORnB0FtAW02sUzkfpvlr8G5TZhQx76QFszhoztEZyzvjwcZKVq0kdO0gvRN0AlF0LC
 HHbXw/dgVe9xK91pb8zjmEgke+ohPTxE/ZOyNmF7RCVxjPGewQbOWQ6aWQtjOUxo9aEXzBcfgGg
 KgAMPPPridFfWusxXqFLnTW0XB7cOeMnHIXutC6C0uqRFnbwioD6NEqWSb2o8lKLVkL81OTah7S
 aRKz5lK7t5AEkxCnmyJ21iWrbxUvV1fXgHNA1NJgZjcSeP2F7KhKDttHun/qV7Vy6L+74KjFERU
 MFS9nG9z75nVIDT+o+IMt9a73eDbJ0EI76iZ3OIXKm3OEQQc3MAGmdD87LEe47LQgV3tlWWy6mL
 M70CfZdad+X3d0k/v6bFFWGbAjuh4MnmFJ2IoFHpvSuXov8b9ERjVnffHi0OSYFIz9ikbF9lHPC
 gqUq5OvB+UdB4EJtyOr/6bToD148luclUJKYSallUGe5WZwDfh1ELOB1Fe2CWOfZNwfT4K7zuHg
 =
X-Received: by 2002:a05:600c:b90:b0:4a7:76fa:87e9 with SMTP id
 5b1f17b1804b1-4bb8892cb02mr41369415e9.21.1795160041183; 
 Thu, 19 Nov 2026 23:34:01 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm54154045e9.10.2026.11.19.23.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 23:34:00 -0800 (PST)
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
 Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v4 01/10] dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
Date: Fri, 20 Nov 2026 08:33:49 +0100
Message-Id: <20261120073358.10267-2-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120073358.10267-1-rofikcoga@gmail.com>
References: <20261120073358.10267-1-rofikcoga@gmail.com>
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

