Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BEFCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D8F10E30E;
	Tue,  6 Oct 2026 09:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ogjUw7UJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SYgo1bS1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796F810E30E
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 09:50:36 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966dtLA094605
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 09:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qxyG4KgmEl89usgJJNZYb7Aho1Zz4VpduITf2fvcXYI=; b=ogjUw7UJxOo7z8/P
 TllZBRsv8OaKMfawAiyVHrzrteeKnXuOGTELF7UHRgrA2gmkaHE7KE4BQ8Vae3EA
 CKbK/xmt0Ex+03JcpNdBbyB3m2HUrQNdzC9DN6sCWZdRTVrbIm75O0wFV601d6cK
 A0EJNHShUESBZW3f8N7Uajl7ewMGZ49Ac/OUwUCqP8BgxBEuAL86HYucCXfx7ZiR
 zQk2OfoTknWmHR7fASnJ5uKe3PPQ4XhZvJpT8j1jQHH1nyD+hJBWnKhuCksc3H0l
 G8B5NZI61zb7DAKJJSVNerbMu3TzeOQ+RGqApjL2HkB9/V1a4Hw8kTgltod3rJ2i
 sNau/Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr3k14j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 09:50:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-88b59692e0dso2520612b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 02:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791280235; x=1791885035;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qxyG4KgmEl89usgJJNZYb7Aho1Zz4VpduITf2fvcXYI=;
 b=SYgo1bS1EVebRorVEx7FGAVEFwmK2ysjp3kta+e/XT0KvW5uqjFWHSkoH41+zxYgaF
 jdYt/f119S2K5Z8+FEDPMmhpQYN24p+rBkmxNMXppbZRAE54FpXD3CZ98Ensv1g/cYCW
 N02bFuqPL/gnTZ+buh/VBEtzOf7fh00l13Pmuo7vgVBqRkns6/EXwWNTk+3rmsD9FEnZ
 TIpQaJt4/GBn3fPBJPY+Va832ZoIXgpZdrp5jZUVShx4D9w9ukMz0ayGO6/rG340WA4y
 a/CT1F9iJQUnJRKaj1CscUpMsRGCxUtcMtaruH1da8MPQFlxjHM9KbyeqZoir1k+0dRX
 AaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791280235; x=1791885035;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qxyG4KgmEl89usgJJNZYb7Aho1Zz4VpduITf2fvcXYI=;
 b=RHbAkM65ItWsuXPVlyumHFO+z6zEmLHitaokMg8rWsMu6Vp87aw8BQ15RvLhBZGteY
 LVbpOzL/w4QTgLzqpIX0NHXa7pX6veRMyDn6vtYe95eoHlMBoJ/meMSP9CvsQ12XUtF1
 HZXxzTqLwdr0e5Rm2fNIu3W9lOqOlhrp594MGbiq+MuxgtGrt8Rog8p0kLnWTzcEKnud
 fvpTwuEv0qIWYzbdu6w0MC3JPuj3tijt08HwDo3jYaYsI80PWLzCxTbCQN8GIb6CYSTj
 JqQg4jWGbFicJfBFJEORQ9A+NAQwqSFzhxgz/jc0FaVO9WlZjvM6T/wE2PTtI5kxSPB2
 COWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0G1lw0jFWIEUgXS5IJdWhXx/ganNOX8DX88K0Hftp6lKe1WiSTe4Nj9raNj5uIlMGYHWCIM3s+58=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n9WTZZouUa1nOtbfHj9fBUty0RLsOm4AchPZHxmGhCDNRg2qiN
 Gn7RVFwYyoSwODy2v4NiXXzT9dSqdPp/zRtOLN659k0B66ZBT88jy6/B7bd4wKo8SjstTYRUmAT
 vaNb0lvLnoCtGhKR6jnYDKXHkRxuERLns3df4ut9/QnXD4rTaBZM58B7Fkcav3/DQXQz68sw=
X-Gm-Gg: AYBFou1PeIie0wI/dO3bdgsLSdJDEfNd9dW6nuzQvh2w6TG30pTpoJsYFvbHBRyhjS8
 Tm4i5pEQI+0ZxUfn3F3EeeNVu+pqNSXl5v7XpVmKWd1l8B3wkXGLCr/PkUTJgdYTFW3OmliOU2J
 jM6qzRmRQeF/LNKRwTJX/f2Xd0mcSoaH9ZyvkqG8ptupmtcZgrfra4X6ObCYkYBI6h4+ELEeDcY
 HNy+HIaqX4WWh4reLnv7MBIqiwRUM0LK55+15yDJVGB/rL/MAYJsIZ71ULQ3lF94yB9RK7Fh6HE
 PFM7iEQvjssFwLRfdSz59X5yXWpq2fKU9VRfwvGe1WEsYbbidVJ0a7nwNVftGafUY9963vdrFMD
 Rteg9GQUml5AGUqVhCuOPXOMCf/WElxuDl6l70n0BwjxRZIIXC2l26qjHXjuESuVv
X-Received: by 2002:a05:6a00:f87:b0:880:e0f8:2d9d with SMTP id
 d2e1a72fcca58-890df9992dbmr816106b3a.55.1791280235145; 
 Tue, 06 Oct 2026 02:50:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:f87:b0:880:e0f8:2d9d with SMTP id
 d2e1a72fcca58-890df9992dbmr816040b3a.55.1791280234490; 
 Tue, 06 Oct 2026 02:50:34 -0700 (PDT)
Received: from hu-ggarmidi-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-890acde961asm535523b3a.61.2026.10.06.02.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:50:34 -0700 (PDT)
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 02:50:27 -0700
Subject: [PATCH 1/5] dt-bindings: arm: qcom: Document Microsoft Surface
 Laptop 8th Edition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-mahua-surface-laptop-v1-1-406fc042162a@oss.qualcomm.com>
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
In-Reply-To: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791280230; l=712;
 i=gopikrishna.garmidi@oss.qualcomm.com; s=20260102;
 h=from:subject:message-id; bh=qsPzPjmVY7cJFQqS5S+8Iufy8k0Jcjs1HvjgGJjzLrQ=;
 b=qvRzKuir7c11cUWFzXRoyjqo/4wSU1zZUU0UoCbRVzYctYg5+4INWLYVrNQm4gp6+TNPAprsS
 sxPPAVGvIAGAHKhLZ0HpahkYBg6HolxvON21g/jb7/0uVJNV4FEomIg
X-Developer-Key: i=gopikrishna.garmidi@oss.qualcomm.com; a=ed25519;
 pk=TkSjNEhrfsj90i3wkABTZtAjLNr2cfYsujaTvyOIDsE=
X-Proofpoint-ORIG-GUID: AlYeHR1cO0c6yB6Uc1vFwbJQsf11r5Mo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfXwyIWlcth8Ttk
 C4OrOaUB9Vm7AZCi3O75Btb8kCH9L1jtokfZ45C3u5xLOS1tG+Efv8Mbx4ZIvWsmEzc3fXU2pqw
 /gBN+LdmjmNmp7+3MEs7MNROVfzKTFs=
X-Authority-Analysis: v=2.4 cv=PNWaavqC c=1 sm=1 tr=0 ts=6ac4c46b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_byYVBOMx7OMby22r04A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfXwfPWmtumknTy
 SRcvKJeNXAwicDD05pchftoNBpKHCCdlzXeGpOwJzLuZn1hU541Ck+5HMj2SoVfOU5viKCWNj5Y
 x/6N9O5PKHiODuuaK4LnJ+W4EDpKUgt14fzqVyyoq7866WSgBuV1nzUEDK4SH3dmnlmGJA2l5YS
 2EYJq1pv0MdQoIcapWDZgiBp44jIsz3MTvzaxsIVWkPu50PDAmmmCRpOoD/DZxWrnQpuccqh7Zs
 gCfsCoLnYWVPeByiE9BFEsdLrbs8TuxaMUdBfffy1JQZpRTSkzz5Wy/cO88NGi7v6oxj6koE0A/
 Mevz8KUVjYhNIwiiIJPMNudn+/GCt02+TU6KRyeLL2+GqXqsjQX1IerZJ+j33ORGSD/9WCSXkz0
 WG1SXqfb/i9Ww7ghlvfhoigeFSbuLzYBCCF06JfgpCsKXI34Py96atJRTBnaTtHZhreJFdo1kWb
 kGGzQfRhY/4EgFwPeUQ==
X-Proofpoint-GUID: AlYeHR1cO0c6yB6Uc1vFwbJQsf11r5Mo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1011 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060039
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

Document the Mahua-based Microsoft Surface Laptop 13.8" 8th Edition.

Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1e..eecc00e2a718 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -191,6 +191,7 @@ properties:
 
       - items:
           - enum:
+              - microsoft,surface-laptop-8-13in
               - qcom,mahua-crd
           - const: qcom,mahua
 

-- 
2.34.1

