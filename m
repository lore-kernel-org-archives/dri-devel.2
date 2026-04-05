Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2B9E9D801
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 14:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5A610E252;
	Sun,  5 Apr 2026 14:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S/o5H1L6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fsk1tznZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D19D310E255
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 14:34:17 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 634LqGb31870216
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Apr 2026 14:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bjX6VMKyzRBT25xOykCqLKOuijJg+tPjmnlmSr8nHJo=; b=S/o5H1L69bXR6c2e
 UPkgC0eXKB2QLbMxCi04URc7urTKLNMLW6rD9pldZCWx/C7ikkzoDg2DHD2JGbCF
 S/GUMR2ebwaMdNz3AKVRSugMD7XVXhrc3eo7Tj5pxU5erNkf4xQ9navxz38aimYn
 2KhsLqbcvmQdgHpo0XTFyoE9O8Ra4hZDtCAX70jkF5oh/ks8HFAFsHkieQPcUn5E
 bLCAgj/L//vNNHiNZB2LfA989QGFALod8HiD5VNZ7nwnolqNfJK4YdWfmbYyzfX1
 VisKx8zsp4L22zNxjaiYN0jZ6lPqRRLvytLEh7A1gt8XaXvbvjQR0KzQr6i97Hks
 r3Y6bg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4datv1akjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 14:34:17 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8954803bd74so33968226d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775399656; x=1776004456;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bjX6VMKyzRBT25xOykCqLKOuijJg+tPjmnlmSr8nHJo=;
 b=Fsk1tznZm+KW3ZpT9bLkO23cltrorAk41gmHZqzlg7WSH4fl8oNxO90FOpz2Zo8u6E
 lOiF8LDUvRlQlDiCQJAuiFrvhVOpYUDUnCkv9M3Wc15h4XvkEe52u8+OO+Hod18siUui
 EYbXtgicTQOoE+T7EokQtoB1OCKBrOID56pDY3bXWKrKCmCvFoOnQgp9UlvGyOR8VURW
 JBHDjcvv1S6/pik/jC2nKWfERZAxTDrrY50f7p/b3BMXglYQGDW7JjVeuRR9PnvRFjht
 mGH+g0cjb39TKdMhagGFaUPa/u6dnDvbZFg9PNbvYpzXbs3PqSICWMT92TIwWxJ9nstE
 zGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775399656; x=1776004456;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bjX6VMKyzRBT25xOykCqLKOuijJg+tPjmnlmSr8nHJo=;
 b=Cl1Y4l8TI4pfC7W08YdhUk4bqWsCbn6LEqeyJl7HOUMTR6WInjHXaWtIm/hhvB62P9
 Lgul39cZFI4PrJY+jg70XUwQXMUZY24qyrPdtZQWAyCh+9V+CyYNA7sEMaxjQauesmIz
 oexQj//btJUZujRBzCuLLCbkI/6t5BQnP8sxzNcShBzLW3uUxSZ1ndq16ufD/qMZxVZJ
 YuY9mdsHVdYVzP+eDJlegLTIhZBETboAuzcssJrczwnz3HUTfiMHl58Hz8Q2InKr9aMo
 UnGKyr/le1g2vIvIEy4FOV9JFhmWTN0ho7Glot6K+r0QZt876hXtoJy5FnKIUPxlDXdj
 Kvnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaMjtlZSR/OamZaGm7jguaIRB+yAE0u9JEdB9Hl4VYNF61GFMaEDoXYsy2B63/JoO/5OYgMukezGU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMSuMg8WnedBZH0EjS8aIWQvNjo+hTkGWkYwW4Cd0QcLWPGoF4
 6v7mzrC7m4OJ1S8gPz1yQc7TdgTlKGoCLqfDOxpJwq86Ur+9aRbKfZCGEWU8n01J1ThLO303xfe
 cqwnAenjd2LBb7RzEFabRNBCcbqj1WlybePLZz8IZVtXPpJ2ORZbbsXhJK90tzyRW7AU4XY7D1o
 pnoRs=
X-Gm-Gg: AeBDiesL0W/veop5UbvMFMiZb1xgr33xANXg09bJL5A8BSu05iJkLK5dOanD9jvZhTA
 Jcrcq9MSL10vcNSKLF/Bd7Y9nULdj77+oeyH/AX9zFyOu8wNaWw7djua6Ri41PG0RznyWTxD7gz
 ZBR644HaI1ZitDjV6sfxf7fkCglWslRpoIsh8GlRpQ79sMW5ARkNJGCfEbpDOiVOrNP0th/vZV6
 tviw2fKovw6kiKEqMQo7SvSkTjkAhVjZlpix/YaOMAdzgQ25lYIeXHLQqHsBxH4Y+CugaqR41Bi
 UMBapGd84CShvaIFqx6qS3PGf6qAbE9wObtcAMIRhA8Awr4oxGPuMI84yrZeNWpSzd1V71UQ0dg
 iB9suKBjVC4mUkvWbUHgpS8K3x7Kk/6q4+P3EBGIBzW5I
X-Received: by 2002:a05:6214:5c84:b0:8a1:c536:57de with SMTP id
 6a1803df08f44-8a70548708emr136141006d6.48.1775399656097; 
 Sun, 05 Apr 2026 07:34:16 -0700 (PDT)
X-Received: by 2002:a05:6214:5c84:b0:8a1:c536:57de with SMTP id
 6a1803df08f44-8a70548708emr136140576d6.48.1775399655622; 
 Sun, 05 Apr 2026 07:34:15 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a616sm713934755e9.2.2026.04.05.07.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 07:34:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 05 Apr 2026 16:33:59 +0200
Subject: [PATCH v2 3/8] dt-bindings: display/msm: sm8650: Correct VBIF
 range in example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-dts-qcom-display-regs-v2-3-34f4024c65dc@oss.qualcomm.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/AwuQ3slvX7u+zXvSCxYc/1viX2dd/v8iApXYini06Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp0nLZ3SSBPm/uvtqMOn+RfGOk38qJUNHMZ36LR
 WPRavBcjZCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadJy2QAKCRDBN2bmhouD
 11NlEACarsGeDw7b1py/JLt8UVRxvS/VgAMCCZYD6oc57Wf4mzv+hCbwSDXjX6zmGav5RC2jwir
 awYxCN3CG+irUPy4UNGXFU46rqIvgLto9f6nxMYBjEAWnsjuumrTUcaNcMnUUQew0NhVK1DQ4pv
 9WbdQLdvCzhPyAzi9uGzTD+HF9Yp9zTzTCk9YMOXjMourdhugsdChVoBKgl++DWCtrbPUUZPE8X
 Ax3U5JeZ4frUg2ZHGQ4ZK4HqEiceR6gId5fG6Pue4Y4Ql2anQ5HtZztDX0XZyvv5RT+MsgbOGlh
 IMlPBOdTsM5LRovKo+M9U+rtXjOF3pSIuf47NxL7QQR4gdjIwP0dlC8M+KwFtX8Abe+C+Mn6Bqs
 9LD/rTM7YTU7JQasvNVbvw6awiWD6xH3B0/nkd1R2kjTJYbOdJ2LjSGSHVBm36Uv41LQp6tfLon
 f6V018d8AXbLr7EoS8TBAMY0f4pHQ4UBeQJDy7jzrkJMO6tVlh+lCeEW0X8HQb2MkM3OUSXEPu1
 Er4to4aVmyJXIDqjwIm3JQQjcYuYB/aCwGZWGyFv5fll5pkpY2YdzVUVFMaNQRjL0/PI10+xzlC
 VJur9JDMKA66LO5dIYKOTurjnuVer81hUbQXx6ftePmx4zMh6pT2mPdgFq45QsSqP0r9L/qje/J
 MAFD2xpfJmOm1qg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: JlWFsn0tcYFsvlsF7zK6NM_dWUZhJA5-
X-Authority-Analysis: v=2.4 cv=GLEF0+NK c=1 sm=1 tr=0 ts=69d272e9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=HWmKLdpjvklgZKno_vkA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: JlWFsn0tcYFsvlsF7zK6NM_dWUZhJA5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDE1MSBTYWx0ZWRfX2V/2jis5nVnV
 9I32xpblTK/UuuklDE4cjfTVNgpaiLAQ4lX0qpaBdt1P+AsPAbEiFYPX+zc9f2E/p9BoF9SUPWW
 9r1Ttjbx9LJBO/0J6hK4cbiPKnr5vSNP85mbczlwt2/gnqawR8L69cckBvrAz/B/IFS8t5fpztp
 uzGoHHA3PSxRxMEqcTO0V1h+d4f9rCEFrkcaofbx6Fbc2/Qo7D+la7brRQpyVsqBei5f2p25F4d
 ZfFdQdkFyzND8zq7o7qOn4p9Y1aZVJ5z1gMSg0O0/SUd5FWbxpgJItIdY9Wi7NYAmnYvYJL9IDg
 UvsEKVkoYuAVnSe4nXaNUSPMKfvn8qYu9AbTXyhR2XyDqay3r/PUwidWLwKJfGiIEaRmpAc03uM
 fxVbr1bcGVW6xvY/i46968lVvckDNEfZdau9mxyjvPxlt68pCZs5JT49CRNk//KFeH3RZV5l0SG
 ZIjri4x06sHw/JloqTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604050151
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

VBIF register range is 0x3000 long, so correct the example.  No
practical impact, except when existing code is being re-used in new
contributions.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml  | 2 +-
 Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index dccac525d202..134321b50897 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -70,7 +70,7 @@ examples:
     display-controller@ae01000 {
         compatible = "qcom,sm8650-dpu";
         reg = <0x0ae01000 0x8f000>,
-              <0x0aeb0000 0x2008>;
+              <0x0aeb0000 0x3000>;
         reg-names = "mdp", "vbif";
 
         clocks = <&gcc_axi_clk>,
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml
index a1c53e191033..0f7f79527748 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml
@@ -112,7 +112,7 @@ examples:
         display-controller@ae01000 {
             compatible = "qcom,sm8650-dpu";
             reg = <0x0ae01000 0x8f000>,
-                  <0x0aeb0000 0x2008>;
+                  <0x0aeb0000 0x3000>;
             reg-names = "mdp", "vbif";
 
             clocks = <&gcc_axi_clk>,

-- 
2.51.0

