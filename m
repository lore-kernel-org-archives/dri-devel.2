Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC7FE9D803
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 14:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F3AC10E251;
	Sun,  5 Apr 2026 14:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i5J+werD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OB/63nNd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA49F10E251
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 14:34:15 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6351nwj82596142
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Apr 2026 14:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GA1/QUGFfB74DpxbTaloTa6Wd+eev5cFwBe9u7pq0Sk=; b=i5J+werDIA01YplN
 4vJu036+W9qJCVEmhfFFabA4Dq2nL1LD1vkVCBHBJZG6IdLGd6p+opPhCQ0nDx7y
 qCTOlzqzuZ9X/KVIW2PZba9Exd6fAFwqQwFs1pDpLCAIJbPDgvIALKrMWSIhAA6Z
 oAu1J+y/ul9kR0Llgt7icJMAEIZcZFspsccyIPl5LIDRlMhjC7Z6sKegP5De2W4e
 QhckeYO9Odnh3VmIBTwoc3xYwwSK2nb0hmypiXeTePEnUqdZFhQoiNDJ1olfzJhy
 96sK4bQUe96IumqId5nMlWO2P9cqNaehQJjx/pchWNIjJocGxoN9m4kyVe3zE81R
 lIr4KQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dasyfjpc0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 14:34:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b4ca7e7c2so77961921cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 07:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775399654; x=1776004454;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GA1/QUGFfB74DpxbTaloTa6Wd+eev5cFwBe9u7pq0Sk=;
 b=OB/63nNd5B56IUTGMakPIhGpe0aETMF9NS+d+8A1KCGZYTwW1U+5KsinytICh37fA3
 Pl0QUzmKsVbMuyG1lv/VF8KhjvztoXg67ecJ8CLSUvgD0kJXaiQLspfbtj9R8IcNlp6/
 IBnPfN92G66dxC/e+Pr0f10nNnCl2DhI3CNGJ/4r1jldKd86lXkamxHHYfGt4PNodzkL
 BpFug7KXsroCKugpl2vTpXu2UUy/N6IWXwD9w8yhHuc/88iE/gtNIL4lxJ5AeAsEXFe0
 l/kVAlw470ZUDvVOazLb4FzeivwW8UF2wKUhNQpEoCwIB4+ToIkc0I2Br+nMSh16uMp3
 MiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775399654; x=1776004454;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GA1/QUGFfB74DpxbTaloTa6Wd+eev5cFwBe9u7pq0Sk=;
 b=cVjtIjEISOToWpe63cd34rv5lfDmwnPJlAj4mxWyz7JFOcJHndkTUayKMRF6PR/5CF
 NEAGEO4vVU9DmqMloNmNdM0gHndvz2+OaqjfmCSIYdNwMfe4lkLYFd4b22/Ar/HpriDf
 o6EzZCmctE38Nq5xgwNDV4NI5TwbgY5fVTqArn5HEQ8JPjUszEualVrNwwe1I+y9a7Pc
 OPfyIuJfIXZASL6P0odxySodxPbYf7NaKoLW9xTxyuOP7eOdPOGh/rI4JZ06IlQLtHN6
 mrOvtQGKwuJrvu5bPNqidWLKU5rEj0hmkrFVxDtTo6vh2EgooIy/SDnmibVzgmApjXdN
 t2eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF9QE8J8U6nOBmkjhwjoWAiKS7bpc5gK8Y8DC7mpC4jhQPbVgWWNf+dislLuZ4cDiTfZR3TP+HvoI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgXk5mQdOkgSyWyq3i0m95YLXFzWcXI24E//EnzOp9qZXqdY62
 feiW13BVv8w33RB8ioWS8IklgqlWzJ6itwLcNm8kCIODOsxPVbCNA7WsWlOADK8yRXrepYHZ0a7
 i2Bc0bqplXndEjpqJif02FLNhllyGsVhLgkho/26+BMHkgYBG/yjw3reZ12T7QIt/p37p48k0Ir
 mCxQ8=
X-Gm-Gg: AeBDiet/nhV9jiTdtoMQ2SWWlzogeDig7evdJ+o2mlVhEmIKJlTKvm1MepEQsB84Kfk
 vv6IRa0e7qcG6zfDL314J41q3fSu9x6xjrCyoej6StLMbEGNt/VjudPqAqkALNlqRCdmciXpYfq
 iJGdwSzUAJqD2/6IREAkkp+XoQWwsyxNAWDVvQmc38+g08LFlP2wvWnNO1Nwtw2e6kBwqAa5XqS
 zhh+Dy7SViXQLymlzP8ygisqLggjTGuIU9EXMZUVFwNtjyJNnQVb97hQaFd2MA4bV+jLRbJEOOt
 jk36IEs3H9aTUpawk5Q/ea+s0YzBz1PFO5vurWnKdbwLDysnmMkeuGzyndb0dPwVut0B0lGh9r/
 7w8Zp96Yse87V1oQkNoYks7bZdoto99SsYl5qbhSTle0f
X-Received: by 2002:ad4:5c44:0:b0:89a:b0c:7268 with SMTP id
 6a1803df08f44-8a705782443mr179550546d6.54.1775399653907; 
 Sun, 05 Apr 2026 07:34:13 -0700 (PDT)
X-Received: by 2002:ad4:5c44:0:b0:89a:b0c:7268 with SMTP id
 6a1803df08f44-8a705782443mr179550216d6.54.1775399653486; 
 Sun, 05 Apr 2026 07:34:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a616sm713934755e9.2.2026.04.05.07.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 07:34:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 05 Apr 2026 16:33:58 +0200
Subject: [PATCH v2 2/8] dt-bindings: display/msm: dp-controller: Allow DAI
 on SM8650 and others
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-dts-qcom-display-regs-v2-2-34f4024c65dc@oss.qualcomm.com>
References: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
In-Reply-To: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=CvKONcYc3T9TBfcvhreqtjqGKG2psNVzlnhXVdP3IcQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp0nLY7kqLZOcOyLvz5MUeRl9v9KcYPi2karLV2
 1odhQ5SX5uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadJy2AAKCRDBN2bmhouD
 1zpkD/9cLZdzdR2wejfgCfDafYVz9UCCz7q6Ax5+8Z7MmiLsLVG1weEuq9lRNLBfbwKEBgVdgwO
 HCLqhpe9kODY4ulkshyPT0IHP5i+cCQ7LeXSvIMcGd1pAKMFbfgqUnUmtFX1mj6WfCmpj35JZu2
 6Bo3huIAzBB5G/P7jylmqjrSVFgk9894yj1HjjSz2uDOs873Z9st11AGMU5wDaxQZqkOuYO/YrL
 loOWKdI0V5dYkO+PUMHKfaPKzByEV3D9ypXuQ9l7GAvhUejbgBUysmIhNWmlvOIVLwurdxQfuWs
 jEFr/QElDvDRORlKda2HxrMUIlSPagZfc3Fic3ir3dGVNDZDqxYzUTTIqGZJfkabhjL1KgFqW+1
 uXrpSwQl4dJTbST/jpGMn+2b+j704aJ53tHyqTleOLtpBZZtWlNTk29pT5pZ6DxydB51o686Uq8
 7vHr7k18d5OyG7s8KDzW+YeyIVHUh3bi4gP1JUuHIriua2h5gOnMslOoJPJvil0fdBAehTzY6xR
 wQN0SIV4Gvubc0il4QkPEV/f3wswqmSX92DnWTkRo2t6oUwtWM6eXjAAv06EpW0MDh4grNdXbzS
 GFgFwjbB4u2Hi+vr8PBHebWXb6pnYjEpz9sFeVObpTR/qBu403x4rG48E3cUQQJJdvoL+zGsG7Q
 7NUThZZsXjGUsvQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDE1MSBTYWx0ZWRfXzsH7HgbvWtIt
 T9zRbJvp2CcdF6OXdzaLMVaeLFDL5oWJ2BWLDIdObTlaoqnn7RPprCg7rLzG/qkYAAkCOxwt3bG
 XpqqY6C3lgV7OTarFXJhHdDyfWQKa0nzq1F1AY+pasdCYAlZx/VLJR/dsKoRE2dd8DWRcWf3zyr
 IPQu70gZtHtDXQIA1vvbvr4bJ0i6AHAErYyqEaLKGviWnMm5FYeOLPZKbavvC3E1Mlfan2DIKA6
 2ErruLlxIrGeX/o7x727N5iySf2s3S28LeDs6loxF12OLRnHi/wwPpwYIg5ucqVxUfCw36OeBHM
 swvXVTr5Cn2FRqF7JfkmOx9rkjpWfK5pjqeMJZlIk6B/WzZskl9qNVA9o2ju9+frziwVcXr5PQN
 fCVQrJvz95GMI5in0YNCasPPxZMD15aOS4XoBfIEcBxdcatSu/cYLIiaIBpPKmOvpn8EttBef0K
 jbXJ7C5ResbwCQHyhUA==
X-Authority-Analysis: v=2.4 cv=U5qfzOru c=1 sm=1 tr=0 ts=69d272e6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=9q4-ovLXei0DaHkVYC4A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: n4P1ReE5Y6cYvo8o482CgUJk7qeutkG2
X-Proofpoint-GUID: n4P1ReE5Y6cYvo8o482CgUJk7qeutkG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604050151
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

DisplayPort on Qualcomm SoCs like SM8650 and compatible SM8750 supports
audio and there is already DTS having cells and sound-name-prefix.  The
"else:" clause for non-EDP and non-aux-bus cases already requires
'#sound-dai-cells', so it should actually reference the dai-common.yaml
for other properties, as pointed out by dtbs_check warnings like:

  sm8650-hdk-display-card-rear-camera-card.dtb:
    displayport-controller@af54000 (qcom,sm8650-dp): Unevaluated properties are not allowed ('sound-name-prefix' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Add dai-common.yaml reference (Dmitry)
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index e4f17d29343b..b96e1ea40d3f 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -219,6 +219,7 @@ allOf:
           - required:
               - "#sound-dai-cells"
       else:
+        $ref: /schemas/sound/dai-common.yaml#
         properties:
           aux-bus: false
         required:

-- 
2.51.0

