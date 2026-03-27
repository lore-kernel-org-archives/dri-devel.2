Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5618010F284C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 961CD10EF11;
	Fri, 27 Mar 2026 16:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="nYd7kTxI";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11CAB10EF0D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:12:34 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-66b0684f98eso3376319a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1774627952; x=1775232752; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=14WR76NKv1FwsEs5HwWnn4/wFMyJv3sPwC6I4w0TIdQ=;
 b=nYd7kTxI+ToREeNDQkcrniGuPwa8Xi2dCF2jgZ5uJ2DzEoAE/dScNo5anGfJBw+9xN
 zwcrIqC9NjXLOcsk9NFuLEmGyQb29DfsrNflaEDI0T9kU7iwnkS6+r0EFM6aqbHMqEF5
 AFkTZr+q375lVtTRwMreyheNwWqIhewITi86NTp+WOeN6sPjPpzyHgUeRAz79W4qkXJu
 wQXaXHQqPYH6thWBN1ItaobpS01JXzPYd8VU5mu/4LT4hm7GxvfFCjLaH+dieb4ouBbF
 heUMVf3le0muUeP2Uu8chM79zmbT5sYDiMaLcLL/ALsrZKLSebv0V8Vrrj71ntHWXPw1
 5Ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774627952; x=1775232752;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=14WR76NKv1FwsEs5HwWnn4/wFMyJv3sPwC6I4w0TIdQ=;
 b=f3oBWJcTEVdiMXyyKAw9yAlzk3TGMreDSru1npNvBF9Odce4YQl4NhIoDLOYzXIeL8
 aZKgBvu3Vif+JF43MoDMz8a6tRRk6LpK4EknxjtZzuv3mjnoNzgzYq3Hc5NpuyD73b2o
 +Txt3atUeeHZAvsDXrA+VaxSQLIS5qMHScrDyyaiZxZrtFmYAntB0RFt3L3RBFxycJRd
 psGmtQ+pEvln3ERwt8bLZLfQ4SJ0f9KsEu3lgeDb4tg163mOOELUqLyfN2nrzFsll9IX
 nDQ+kKvhR6SqNJGK8wvFFz33/hvLIe0xm8CkEYfHusQ+HC1d21jpMlyX7g12WRnjTm9B
 zfjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyzIShg5pP5MY3GcGVXtEWkMVtqDMnorzPFgoPGxGMLyWHuKMpTnOYLHE26So4GqOIcnq0NH9CjVs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXBszIhHrRAoPR6bb+msI1h10bzPWPuaYymzkeqDJzkIATDh6M
 IYCKhNIDFO9ZHmYuVx1JjEqNc6Pt1p5/CAt4L4DUjaAYCLePrn/hzFusJNVt5BEnE/E=
X-Gm-Gg: ATEYQzwZjeOKYY/4r0OAG3sOLNLkLza2TVx84nc6fzOf3s8Rwma7u8bbngvqBYMxhZl
 fQhMJKliJVNp4ec8GrWhiHiScdhyX9YB+xa6PCkzuUyIkGF6g6dNuvhwT6hD8iNch+dgAIAGUbs
 swdXZ24cGwyuGU2Ki/8035mZ5ufpHeDVDP+F/F3swAL5GQqJ0lhVaWKrbMDG7/woxuqi2hZyPcS
 HFpkUQAC9sW8CxvIGnRinQseCYSWuSc2OfeCepLqG++bbkqpCRrO9tJmowiEZ6J9MddDmjp16Ss
 wkLAmsqRKUFr76717GH92FJnheTIaijp8t4D1r8AlAcRtjTAyne7ukW2mRge4cpMcT0WDDcjPE8
 JRBjBVwasKO3P2u5yuPBQO+dPz1JrXNIVqwxyOTC0nKpNw7H7uBIT+VPpTiZT19HIfW9iZDf9Wv
 JD/fjkFzeyz3cnw8ciFwc9Fs5wEhavb3jE/Ed0if2Mn3GqBfi+yfT5HpJpP85m7mIVl2dpO73NV
 M2DoQ==
X-Received: by 2002:a17:907:3e97:b0:b98:b51:6f51 with SMTP id
 a640c23a62f3a-b9b507a58c4mr241007366b.35.1774627952065; 
 Fri, 27 Mar 2026 09:12:32 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b20265cc0sm273518366b.15.2026.03.27.09.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:12:31 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 27 Mar 2026 17:12:20 +0100
Subject: [PATCH v2 1/9] dt-bindings: display: msm-dsi-phy-7nm: document the
 Milos DSI PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-milos-mdss-v2-1-bc586683f5ca@fairphone.com>
References: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
In-Reply-To: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Marek <jonathan@marek.ca>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774627949; l=871;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=EVldcqfPHPh1FF7QDMATcvXChGeMKnSCWknhWuq45Jg=;
 b=7Xs0w2eewxL5CZRI6DTsd3patfJnGDWajpneO0Gb7M04cO2ebwe9xVRUTwB/8n4ryA6yQf4XM
 Wst+Ph1T2SSBnUcinUWrXd3lqAzF+0vVz4Pe5oq0O1dNKX+diUB1slP
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Document the DSI PHY on the Milos Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
index b5a0c1461250..4bdec236734c 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
@@ -20,6 +20,7 @@ properties:
               - qcom,dsi-phy-7nm
               - qcom,dsi-phy-7nm-8150
               - qcom,kaanapali-dsi-phy-3nm
+              - qcom,milos-dsi-phy-4nm
               - qcom,sa8775p-dsi-phy-5nm
               - qcom,sar2130p-dsi-phy-5nm
               - qcom,sc7280-dsi-phy-7nm

-- 
2.53.0

