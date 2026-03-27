Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0097910F284C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B13D10EF15;
	Fri, 27 Mar 2026 16:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="x8zwm6te";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 901D010EF0E
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:12:34 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-666f646f5cfso4987396a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1774627953; x=1775232753; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nMi8pPc1nu1OwZY0Xf/EDRaYl50oxCMJcLrOAypEPLo=;
 b=x8zwm6tea6VHInDW/01StYMxyWNMn7tZ9JeYpmj40f0kZNnXvXNOSFxl+xtm+27jny
 998F4X4WZRVW1gy3vwNbM904xfIgkMdkwdUM7H+Y0AK4P6gazNPGv4FL+2KE7sMhqYi8
 VSr6RmX+6Zh+ewAa2ecRancQW2c6Cb4WW/zTz+h5jlcuUFtGEmms6CVaudiIGjLujDPq
 ktog6IaVUhg+1c5zQqOpSNVtLPyzEP8kyXAZrVCQ5G6PljFomXMj/96cE4qFbhT662vT
 usw4no+I37Re7gMP4sAWaOS61ZxST08DwtK3GiXINGowl/rXLgxPHcDcVh7pM4fNnXTG
 hicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774627953; x=1775232753;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nMi8pPc1nu1OwZY0Xf/EDRaYl50oxCMJcLrOAypEPLo=;
 b=sxLk0hlVTemKfWsxHvtHu/XMC6TJkwD3Awestq5Md2bJ7frVzaYsEplZMhSNSMwPIw
 cg1qp48m5BqS7gdrm+OQ9xcsfIPX1GGVTyGkeGese3A1oxsRRki6/PPOsWmw2WEWw64M
 A1lKcnhoBuyruOJ1zaEsXZdRPm1/3erQrvcaZtVnzsW6AtgTG6QAsVA6Ndv5T2ssJVOx
 rXxMHxlVaRUJELJoEUsFICZq36na7Sk7jeKlXnT62IfNKF+WAmKxbYJxM45sC9cXWoHC
 bU30/7aYtH5dzP/5KEL819Lupv5FHmU89tzBJ0UcE6Cqyg86Ab46K9r9IyROua1kMgYA
 oeZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeUllvqlNZKGy9d1xNdyW4awqI4QWfc6Ux8Cx+O8Pxw2YzC/R/N53CCQAovnMBioougorCK49QcUE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnFandfsOUs6QVHsr1XuJlIKWonEQMdFAXAcEd9HaabVDXRoGF
 FSvauKkzQZUTam3J8UGnOhDZPxaNCxzI/jvpK9Sw4GuPK23cvMQiQBBrAY12T6m670A=
X-Gm-Gg: ATEYQzzZbfalZLPbRg/4xUWZNaCQuEaPFimBCF6jcEaUE52TPXIiQ38k67BNNKBLr90
 Dny9Qwg0iyDCha+3PdSYHuZofnYLKxkMOhyul7oyUOKt0l3jf8Ik7z7e/b/DFuuT4Nn9do/o3cy
 04UHdphczyQ05R6dstEB/pPoNE4w5j+gH1sQ10xkYKdxQ+K8uFYxK30/UTkGRo3fp4jOYDVKUq1
 1hUFyFMrC4icXsldPcAW1kJ87/ePdGWkR3CSQxyyWIAnmcRitEY1hKN0Ltl9mF9+M3El4skknQW
 lS9rFgA1qCCx3VzmPVl7BUQSxff7OgfsdQuaT0UmY1NfGteXhmSylnPcP4hXSl4soHK1m6P/4+/
 6MtP41e3/LAYSCvU+Mye5tnfN3KeDNrjuZRdt4bU7owFPk0OZ1qs+8S3CBLtgq2tgr+ccbL10So
 6VY4nRiNjK7tCyVqfEW8GitmWCJEzbI+up8k9KD0/7MYGW8/O0RX4ZMYZb+zmaBU07/FEgEvxG0
 imzsg==
X-Received: by 2002:a17:907:1c0d:b0:b88:58e5:86ff with SMTP id
 a640c23a62f3a-b9b51647766mr196269266b.0.1774627952962; 
 Fri, 27 Mar 2026 09:12:32 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b20265cc0sm273518366b.15.2026.03.27.09.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:12:32 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 27 Mar 2026 17:12:21 +0100
Subject: [PATCH v2 2/9] dt-bindings: display: msm-dsi-controller-main:
 document the Milos DSI Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-milos-mdss-v2-2-bc586683f5ca@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774627949; l=1141;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=/iuE8Of7PxtUN21ThxuyRVaZpwkJ5NvVO+YKGCgqQ64=;
 b=kINHrIcgMlj9z546raEXwcP6A0Lzrq1gQjA0FLzEM+5Rx5oXlRJ2E4maAJbpBS6QhgEJ6hZFp
 rLOVKD1c/CuAO+zU1Y1Cz+Jhso56+ar/zysDEdXku742owa567YKbMK
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

Document the DSI Controller on the Milos Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index a24fcb914418..dbc0613e427e 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -16,6 +16,7 @@ properties:
           - enum:
               - qcom,apq8064-dsi-ctrl
               - qcom,kaanapali-dsi-ctrl
+              - qcom,milos-dsi-ctrl
               - qcom,msm8226-dsi-ctrl
               - qcom,msm8916-dsi-ctrl
               - qcom,msm8953-dsi-ctrl
@@ -339,6 +340,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,milos-dsi-ctrl
               - qcom,msm8998-dsi-ctrl
               - qcom,sa8775p-dsi-ctrl
               - qcom,sar2130p-dsi-ctrl

-- 
2.53.0

