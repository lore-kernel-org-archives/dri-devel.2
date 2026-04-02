Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712FAD39410
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE42610F190;
	Thu,  2 Apr 2026 11:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jgokJVDY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DLJS/1ub";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59DEA10F193
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 11:45:31 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328dArh1249508
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 11:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hbW2GVtQLECICNbCJchxxSpZYBY6WOf1KNIaA4QN208=; b=jgokJVDYQEz7Wzk/
 VIEYiLLDapJbvJ0uje0/7KfvbQB+MVo5XwEodF4FWNdq3hsZ/i0LML1SYzamalF4
 Vn/hbl7nQ4w7AHatMek8M5rD1qeyOY2IvGJf8fvJtwCXJ7si1d9Fv9q9ZA4bJC6+
 q28WhuOYYnnSLrhOhXOMj0bNYtrFtKuUmjEn2qkUbvgELZZ10NIlvmuNlvkR6H9+
 9p9dtfCGDz75rNn56Jlb/qx6dvIvuVciKRKaXHkmiPCY3s+D/g77uFbio4Lnd68d
 R2oIsJiID+779qQIivETkencA2mpYg6a0CLpLYBaUVywEchmazpU+k1enLT+aYA2
 g3Rz6w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9n4t0qyp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 11:45:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5094741c1c1so22108611cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 04:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775130330; x=1775735130;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hbW2GVtQLECICNbCJchxxSpZYBY6WOf1KNIaA4QN208=;
 b=DLJS/1ubGEx/O00ErQN6TBxe93SyPuGZSFVBT9KxI8KRuNlS/6nsOo9M2QB8WcCZmc
 RZVQCsMsx+816LBEzjGp8ExZET1z9f6A+8dFrgcvpgh/WPoBO+KIqpeA7Q1NXpccNGE7
 LWom33fkRQkHj7W1ewXj7aqlj/HK7dMaMd6VnqFjbIVmprnzgrkZU9D7kVySScHXurWV
 DPWoVYh7ClLEUDIP1wgFcvrcE8aVzCsdd5x6PhpPQACUshHekdMj69SFCIdcBulM2QDE
 KxmjC6Zwd34R7NQjGp31+2ilkufmoKTpdlQYiduWwQyt6LJLdG3xKf+V+9QyB6n6A48T
 AohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775130330; x=1775735130;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hbW2GVtQLECICNbCJchxxSpZYBY6WOf1KNIaA4QN208=;
 b=sfM3sauqgzr7G9OYqZDrsfMQrFQDtbWzRoIO/PztOs+8wjJNXYAOc6Bc7C22qvGv+3
 53G8n8FUE6g7iQ9/oEuBvvrRscJBEPL+XPWW/5LexspX+/Ip5qQN01b8ffalHMBsAbou
 cND38xsK4sMFN4tnHz22qqnOM9mHbz/xAIO9wLW9hcLR7vCgCPmicG0W9SZul+q1KyRk
 IJyAztpUO3yBSA5f5GSBBlP5FxfoHA03ShfCfFnIT0fzkc6oTUywJ4wAQ+pA2dT81Ft0
 eDDfQ4IbVtHbzlKbhUf9VeYsXKCXn/7rbEFtrfRcAX2Fy/3QJsbid4Jw+PNTbZDL3nSp
 RqMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVqSgzdPnt9STo/1dRlf/d3KR3n5NYPpuMYhFlW1JgoNJefADOQf2owgFTw2Z2RHhis/BPDMCGlyI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBAk43+XgYBnW26FWeaC3OmVW9+YwDzGquyLTd+Buq87h2D6Lc
 5QmPcOeTNoWguhJdwdL6u8aFZFR7vqOsQeZVj4/FD3CFJ+9ubM5n9zSaJUvJLccXK3OLr+1BGPK
 UJ48AfWZFPwcG1/tS9II9/Diju4QVMC109AH86xGpBvQ8IclanbGCNTnwNrPHqLAqQAeY7Dw=
X-Gm-Gg: ATEYQzx+EY6IM9RGVND/SSm4jbudca7S0KB5fS/4J4GNqVjHxKu2jNlnM94virA4AIm
 ZLgc8lXQJiwvSGtKMm8pMcVVQ714wr0UTQaxXtObmQdCbjg9AdnQSVLVxpPubGWZAbW3/DI6Drf
 N5aJ2EpRUnnK0pTj+LwNmMaM+pV6oGdTNyuFn6QCTNhnSH/Am0qeESkr0/hocbYcJSrTRaN9ngf
 wzXDRlLPHYlLB5JlTqNSvmPoPdpZeIAVAWpbYbyc0iORtSsNSx+M6SB44ORM5A+eA5GgXz9Bk86
 0dfwBUpg06sZvjJywhPVLtR+tGGpgasl5W3oif3gWJZdp3Y71FP2YDzZkNMXkb7WFT6iwyQ1zxe
 xAG/mjyJHXEqI+VMqaIJp0W0tBvQVTRiOgO7khq9MAHxU
X-Received: by 2002:a05:622a:4d8c:b0:50b:2876:586 with SMTP id
 d75a77b69052e-50d3bc2d982mr96081791cf.5.1775130329865; 
 Thu, 02 Apr 2026 04:45:29 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8c:b0:50b:2876:586 with SMTP id
 d75a77b69052e-50d3bc2d982mr96081311cf.5.1775130329437; 
 Thu, 02 Apr 2026 04:45:29 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a567bfasm141614635e9.0.2026.04.02.04.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 04:45:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 13:45:13 +0200
Subject: [PATCH 2/7] dt-bindings: display/msm: dp-controller: Allow DAI on
 SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-dts-qcom-display-regs-v1-2-daa54ab448a3@oss.qualcomm.com>
References: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
In-Reply-To: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=3Z2/9UqtEtBsglgzBaJ0JiBgZ+BcLHLqDj6g4rOOZYU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpzlbNbiIvuacgY8VI0ynmZvX/Ny5JFSq4MJ8GE
 UDIavP3F9qJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCac5WzQAKCRDBN2bmhouD
 13krD/9t1ubnPWoTx8xk5+UEzCbniAX8/xtY6USzQOeOjJCAv7cXl4ensPg4oZQTPD9nEyqC6iq
 LrOVmpaKQ/Pn+cllIiV7xCcyPMXRczXifWWx6+xe89sx4fofNLyILDFAa1p4L9xl/awOZc8gqFY
 5TopRqONu6z55yVHaoAlZyfolP1yqeRAj+7cOe6nllTU5DFfPNQtPe1kU9m4ZS+k3hdvK1iWCoB
 2YlGaVjp8miHCDfRh+O6Qy+Nw4yVHI+xMqkVzU5qOiPEjq2txcXdQ0YSdNUonDCzPW18lyCNlz/
 3NfxL8/ujfw7ZY5Z/hr6ceG8jlz4DpsLmNEvXvIrLwNYYN3ic0KYAebinvwSzku567pe/NLCjyo
 WP9ZwdTirPOg228kNJ3sea9cvQXhP1o/+dG562Y80C3RWHwF4DlfRaQ9wW8UEwvbG/zYjIiqp7T
 KH0zEQZ1FSCyM934R0eVRRMIQpJuNpgNXEGuCtEoBKhbuJXaLEIDj9L/gGZEQGwIwc/RGPohTuU
 qL3yRSeIhy9H2p3+xdZ6w4+Bcm4zgpely7abiMZa3RIMlgP/6MA8uyOU/WW0bb+phRBJe9chYAH
 jrNBqCtDqbrQvKmB0Q8nLLvQ63VkGD/1IyuHBxdb6Kt4O8Vz62Iet8RQVMJpbE9PJUDKzTW5chq
 KDOKGjkJQSccXgQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: CgULNxOtP4a2IuYlL2lVUUxPPkbV26qs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEwNSBTYWx0ZWRfXxYo0oWdox0Gw
 uiUZvgLCh8V2yHrl0WLz5JLcJ53FJliKSjxUXMf3il7ricpTtaWTi2yGcOvSEPvjTpuYHpuVGwE
 BY9OrlwTk2T4MtuHeIufmK8/x9fbLu/sw+R/WtCpY+2od0jxuwQb/Ky52IBicPdczJgLnhwHI5w
 FIL4ti/Y8w8bs34f7oo72YmtcLGUEGb9dACewyYhABZVW8f11eUBye0EfXSjln4TewutBYwQDwt
 Le+zQuanJ/oq/i1cPFahy9brFRnjrcuNq0riDHpke/cQfpQubtr1MV5O6E1MpBTiF4HiXp/LFx/
 6Jz4upyeITl3B4+trSYURPPX0zwIoplIGivb83pYfnpd+IuNY+tMv5q0Dz2I5ckivDif4LwMdsC
 cpVgx/f27bKJ/kTHVuuLAX8QZAWt2MA5byEDfh2rUPljyVWrYjKMkR6oSuUNak1qqddmpCn3KRZ
 Be1+o0pL6hQZavn4GJA==
X-Proofpoint-GUID: CgULNxOtP4a2IuYlL2lVUUxPPkbV26qs
X-Authority-Analysis: v=2.4 cv=Ap/jHe9P c=1 sm=1 tr=0 ts=69ce56da cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=7SpLljjrIQYGA4yF3eAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020105
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

DisplayPort on Qualcomm SM8650 (and compatible SM8750) supports audio
and there is DTS already having cells and sound-name-prefix.  Add SM8650
to the list of SoCs referencing the dai-common.yaml schema to solve
dtbs_check warnings like:

  sm8650-hdk-display-card-rear-camera-card.dtb:
    displayport-controller@af54000 (qcom,sm8650-dp): Unevaluated properties are not allowed ('sound-name-prefix' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index e4f17d29343b..f8daaee8d065 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -210,6 +210,7 @@ allOf:
               enum:
                 - qcom,glymur-dp
                 - qcom,sa8775p-dp
+                - qcom,sm8650-dp
                 - qcom,x1e80100-dp
       then:
         $ref: /schemas/sound/dai-common.yaml#

-- 
2.51.0

