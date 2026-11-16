Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA3606A330
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SEBaEYpH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ehnqj38z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4359F10F160;
	Mon, 16 Nov 2026 13:17:34 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B71E10F160
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:17:18 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGC0vr62472545
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1w0FWR5wWQFDU0ye3GVQmTCZT/x5MR8HdbR0B68w3LY=; b=SEBaEYpHc8jEl+Tz
 VTfNtRbaEmPc2jrwl93W0jgyzhiVnqxEyy96KKDGqfOIzzOoHdfTo/FNCousA585
 /BZk5zDyNUvjk5C+02CzTQPKyiP+khk5F6dMJqDC2Kequ5/sj2vLzxy8og8KPiRB
 xBzT+cMUhTZleyuOIsvg4lxeVgKA3sgdYefq3el6EKI9Sot5Mx7o6TUqcxyXmr5x
 g4b7gpwffP4tJmzx7FuPNZkqcxJwBqKpvrNp36qMEbS/QaAFD9/aXAmCEPr34R6o
 YwiAj8P4FvJlbrH+SrnDVseHGi06M8XW+rylW90SxbLciHpljZILQ1YmFebMGCbm
 pO05uA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdxhke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:17:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f2005ce21so631865485a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794835037; x=1795439837;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1w0FWR5wWQFDU0ye3GVQmTCZT/x5MR8HdbR0B68w3LY=;
 b=Ehnqj38zJCAoDTlCFyUDoSzVqqmuT1AOXzrzYYqH380hPFDsnMMkxy7IqDUsBfoErf
 AYXzshYrgn5G2OgWSmWd4vyjSi1R7s7zwiw7+rvk9BQHNMmL6m7Z9pkq7Z/QNohv9sCz
 PpjErAcedAhSP9b4X6/96lGbB7SEj+5ldtF9kVzoS2FMkJRf1yj8BvA3w1+TzplJXPG/
 JV3iQQdGPe/9lPR5aSk6f2jJAiJjWtrpxxRXvNnxTU9LPShXQ10TalptvINoMlw25bgp
 cHKDPdMbvrUSAyAnQhYq3w6dLUPO1VNygKo/B0bjdKs4UoslrXPmwvzGU0HezGRiTsRW
 S93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835037; x=1795439837;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1w0FWR5wWQFDU0ye3GVQmTCZT/x5MR8HdbR0B68w3LY=;
 b=hTB2MH5HgBGoiF2Tjsnw5lZsrU41/ivKsXMm2j7NLaBiMnVI8g/eimCVP/UaEqTg+b
 MfVhVtvLAFo+SZweTB3Ej/ryxZxJLxDwX/Vb+lJoSTmFdk6fYKbeTN7C+1Uj/HJKwrwh
 CAaesA4ZMDunetaqdwC8+h3dgKXIiLAhB6+moFeVAU9fSxC5YTeoVdwR+LEyvAtAutQM
 5USacq35fuCSr0PbyeFORj7RocryDYY9gm4KcV029JCOsSeI5tThhikXuimbtDQFsX8J
 IDAtkb/JMyvbeG+dseD7kinb0MHokFBb5CX9hzILhwSdZEG3tTnrPRSG7OhXFBLz1w5n
 n2cQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGD/cpA90hOeUXahV2Wqlm6mK/hDKbmkxi6rubK17kV5R1wykEUFilc1RKbH6kg/ka2zmxRd5+0RgE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z863d12kPIIgFqnmiyEBX78lGqzCs7Wkp3N4VWzduVaau13Vpd0
 VgLgrmbdzyJM6Irk7vWSzpSVeNGCuEPUV9WnAwYCyoIvbPc/YlJy8Cl70aKf4ZIUe8ds2ISeaeQ
 tAkpI9wehw2PVG8kuivMRPXPqlkFZrw4fQ2ddhfAubOY+et4wwfCxmP5Cio/4ztQhYg6GbH0=
X-Gm-Gg: AYBFou1JvmHK+lDoKvM8JHPnyjmR8by1m18oQC355fciwIBZTFafdyjBt2uYzctzEOd
 cSBubsHtUjoQq0PeETOQ/LXEKDzf7gOgIVx45SZkxVRnm9k0CGu3n8zEjRcLDoZnaNMojP1TwcT
 RHNaQwVypoGcjoCM+yoxDN5o6YWPOOKICP8xFQkpQyOHISOdXc0vNDJ6GHrKDVRfohPbMS32SxG
 JTQTRZTb3Gbv7WXwsgXIJE8/PX0Yil2h0Bqrvqd4nJGzbyRwX0I7p2oBVSGepk9LDHQ7BZo3gLS
 10IKdOAaK/ocHdKWYLfNpYSBgxm7ous1I+gKDTQHYOwr5Cxk0LSpQywZD3br3kJKhN9pCpD+3Yl
 Bxd3FxZ4JDuu5n5ThXIOPfAUNPAxpkfUHWken5QNioi4AK2oLtrTfek5UCUBlNUmfK2eRRCVJ+w
 TG
X-Received: by 2002:a05:620a:8002:b0:945:c4b9:3de2 with SMTP id
 af79cd13be357-9494bcb0e9dmr1652194785a.73.1794835036788; 
 Mon, 16 Nov 2026 05:17:16 -0800 (PST)
X-Received: by 2002:a05:620a:8002:b0:945:c4b9:3de2 with SMTP id
 af79cd13be357-9494bcb0e9dmr1652185885a.73.1794835036121; 
 Mon, 16 Nov 2026 05:17:16 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8e1c94sm843927285a.39.2026.11.16.05.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:17:15 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 18:46:40 +0530
Subject: [PATCH v3 01/11] dt-bindings: phy: qcom,edp-phy: Add DP PHY
 compatible for Nord
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-nord-drv-dt-v3-1-e3d3bf0e2c49@oss.qualcomm.com>
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
In-Reply-To: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794835013; l=1366;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=htFubjaJPIibVGGK/b3gnFKqJhVT4tGAGnQz5T8JsPY=;
 b=qUoDsXThlUNNuRFU0T+sympFDVYGr9xmnyLWpJ06LdBycStF71umIvFt9uuV+rBK3WP3Y1cwM
 cbD7HwGrAdrDCzrbDAebYAipwZgM7ip3HF7Gf1tso2kcQQ8PgEacPWq
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6afb025e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=kfPMoZk3nD7OVdbVor8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX78JEgOoZjHnk
 pxnvYNANiQZ1BMip20umX8TqSN9cw6zXuJE1gav/D6Wj51nQj5+Wsto7+8CxxciYq+IRu077CyM
 4i1xnkltMsLinI1woeCRfRHXAmwmTbE=
X-Proofpoint-ORIG-GUID: l5QtGiK_Xx8M8WlXqYZud5jn8fxu7QPv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX8GYYDEj6JQKd
 p3yhgvUhKnr2M3tiJSMg9iE81VLxwWjmhtnGGfZ4fLaT27ZD2jLX7LAa0/a7P+UaF4wt1TKVidx
 E/vdtV/D4Ly3aIFroM1Ynu67nPyRqKPHhN6um/8jyu+7cR+hoFAc+VEEnYN14Xrp4a7yNhw24lB
 8pA75aiwy7jN5aPOCxaRMG0fWgYahgfNqOPZZqrhN1itcekvezj6l+cH7DxD6eMY5VBofsmINSD
 X0pDnOFKqkeJdKLh4Ch75XPopxeweLx2roa/5yBOvYktcbu1UatTlkTLmq+O3+gz77G/FyuI4B+
 gEOi+mFuR95oSAc2boUtX4Apb9WqenFyiypwSv37MB+PSSBBNO4lZ1g8149MQZec13cVpuHfhp6
 l7Kd6np3Bsfi7rl5q4fBEXkoBR6MTEE2z794asUrn8IsGema+MAVcs7rq3niDekMJ09fIlil8ab
 RM6HyeZHCgIm91AioDw==
X-Proofpoint-GUID: l5QtGiK_Xx8M8WlXqYZud5jn8fxu7QPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160052
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Nord relocates several PHY/QSERDES registers relative to existing
SoCs, so it cannot reuse an existing compatible. Add qcom,nord-dp-phy
to the compatible list. Nord also needs a dedicated ref clock besides
aux and cfg_ahb, so add it to the allOf condition that requires
three clocks (aux, cfg_ahb, ref).

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
index 0bf8bf4f66ac..0ff07ddcb76f 100644
--- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
@@ -19,6 +19,7 @@ properties:
     oneOf:
       - enum:
           - qcom,glymur-dp-phy
+          - qcom,nord-dp-phy
           - qcom,sa8775p-edp-phy
           - qcom,sc7280-edp-phy
           - qcom,sc8180x-edp-phy
@@ -74,6 +75,7 @@ allOf:
         compatible:
           enum:
             - qcom,glymur-dp-phy
+            - qcom,nord-dp-phy
             - qcom,sa8775p-edp-phy
             - qcom,x1e80100-dp-phy
     then:

-- 
2.34.1

