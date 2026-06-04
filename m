Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F5CCD6E6D
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF6E1127C0;
	Thu,  4 Jun 2026 12:31:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MfoqlJm3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JyRhQfWx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7B4113FB0
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:31:29 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6546urqd2477899
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 12:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y6UZz8IjVdVITbvOPHhdrUuJW0/kbNYyuOsWRAfVo8o=; b=MfoqlJm33MHz1RXo
 VaPPkj7+9L6dYSMphzMDlXqrUxYF/tjEoIaBQsTAwlti6OLji+gN+nAsJGO/pgOr
 e4NpL7icnywOddrjOc7u8ASzihLlaBh2FYSz0ImFmOBxThr2oVP4m4sD5PfCv02i
 FaX5dBYRefGXGmnzO0Tnz02AdXhHQlZl/Kk/9Iki20jVBtV4drzu5xcwRx8/YbVo
 edZGNzE9MGTpwvdaI3whUS+bByWFPVr6stI3/QNNzPNBbn/tFvxrkF+186FmDCGO
 fzIVCAyvweoGEd7bJ1AyvG8AINWJrj9Vyb1oMQtgIs+3kYleQcfTYXtadv24EWTa
 YiUnww==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek4hvh7sd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 12:31:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8421ffff8a3so925118b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780576289; x=1781181089;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y6UZz8IjVdVITbvOPHhdrUuJW0/kbNYyuOsWRAfVo8o=;
 b=JyRhQfWxi2bp1ExfxqcOPHSrAstT+GA+K+p2QTpKcaB2TRFjeb+TdAfqEb1UQM8gqj
 6gVLwRcjZrq5qPl2ng2eRtZUgNM919uPZF884DkdhBKzhn7SSSbdHm3HXcpDi1Vsx04p
 rbeWLj5UnaED1N42FuimfMWsqR7HTuF7p8/B1NG3QM2r8HpXZYPYrkpEt3X5uvv8Gut8
 JxWi9mZ1+ofVs7It3Wxo/DpVv2vr91RumBQVu3zOKC5apfC5UcLifHf+sxp9OfjDp75w
 D5aHMFyYEUci1uD3ifU3c+fk5/xRj+U2/LBn7g69QaKnJ4rtWlvZ3B1iRU6ns0RuG8yw
 BWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780576289; x=1781181089;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y6UZz8IjVdVITbvOPHhdrUuJW0/kbNYyuOsWRAfVo8o=;
 b=kQkxxUdDm65FwR1j9UzEzOCCOJ0a+VIRJ7VWHKkNP0nvdzn8t295IBpgdythgy0kfV
 CSgwC2jzQ+oM3g7EnUjZRW65gYA7NLzYLXgE7dlLjiLk8sYrsSshOoe/ud0CjAaCNOfk
 WIDpW7JIpDAarwA6kvECalDtuqqqPxbTRrPQRWx3v4rzptlnh+w8zJYCwrh2eiJqblfj
 v3145Ct3zfVEbJSQ7O3XNbCB5j9DjDIMZDmEvNYtslAnq2C9JBL64xWUS3m0hDDXlQjU
 y/5JV3UfVOZ0bbaw262NtkdqqsA25EbNY1AJtYeZaS4kszfzSo6TdShe5fOk51FY3chR
 o3pA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YAOz+INQlQ1Zqo/P/qHEfScWu77fkL+xw8TvopBxs/93Lt7Key4UAhjH2tGSSx5ho3J6Mip74GKM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGeEQ76dSLgDbVAATjVB5IwtOxRjoTApH1hrujdap/+bfGFwYT
 jMR2mdeyGu3figsoPRRG6CcfqICkAOBRQmRIUowm4RWhPckNUsjcAq/XlQetVgx7qhlabUxjtmp
 Oewf/LoWgLpZ9YrBcWK+4UYcmP5V6jGyjqy7x2vu0DElJwqp2QftspIYHcfbM2bvAclab9tg=
X-Gm-Gg: Acq92OE6u07kJexdy6GrNGAs8VAY7E7oGsU7n6avHqP4DaWhwAKJIZoIqLRXAXMac9F
 CmKgkE/fLy/XGqBrK9mbtz5qrwSXOhMNlkmZxAG6JQ36QXARx5uVV0qA4+YowATBmy2qDMX9Q1o
 8yDdRlutNFNG84hF+72kUkYVDate1tkGQ9dwTBCVHqQ8w/2xrDz4I2e6r2GPCPaGNLFHzU5SUTx
 8g8iXhn6h+Ut+1a+lxuno9DugiRf2uQFTCM6hvJAG0tTlAIR2YmBo0mHxxxju9yZqxK6dhEXqsV
 mDb3TNfjv5bjHbxKzYHoT2fr59G4A38XZ6bcchWWTFKCj1hNywQndYzigXeVxuYCDHOlnDR2nEA
 /X8DOD5//1XbTerbazjm6/1K09tkW1VtBl2xIRHnrxUkY2hlQldm2zk2MfyE=
X-Received: by 2002:a05:6a00:6c87:b0:82c:d7c9:5479 with SMTP id
 d2e1a72fcca58-84284e8e557mr7258359b3a.32.1780576288654; 
 Thu, 04 Jun 2026 05:31:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c87:b0:82c:d7c9:5479 with SMTP id
 d2e1a72fcca58-84284e8e557mr7258325b3a.32.1780576288185; 
 Thu, 04 Jun 2026 05:31:28 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428325d9a3sm6015917b3a.34.2026.06.04.05.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 05:31:27 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Thu, 04 Jun 2026 18:00:48 +0530
Subject: [PATCH v2 2/3] arm64: defconfig: Enable ILI7807S DSI panel driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-shikra-display-v2-2-b3c1b2b67edc@oss.qualcomm.com>
References: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
In-Reply-To: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780576263; l=708;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=SCs9KQKBtzRapnZIGqIOvP+xU2+TnEvlesLmeM6sxt0=;
 b=m9yIbYKaT8kCKl/fs9wocRmDzoj1uNJswWvdoxbvdIWYfP842Sv1SMBB1G9LaTbU0FTO9Vdyl
 QvUjcv/T4EUC2yeF7PvcAc73PU1HzUvdE6d8SwFee05DqQT2ZjtUuHp
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: LTFxRNN0WboDBcQekEf6lU_MSz9l-Lzc
X-Proofpoint-ORIG-GUID: LTFxRNN0WboDBcQekEf6lU_MSz9l-Lzc
X-Authority-Analysis: v=2.4 cv=Zp/d7d7G c=1 sm=1 tr=0 ts=6a217021 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=aMhaXRkMA95IrCOZcTgA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyMSBTYWx0ZWRfX81/8MqKmlViB
 EOiZDt4R4fuiR+wwXr9sRCg78sUOETDu538JDCN/ShVj44m3izyg9BPa7K0GNM1+TBW5Li6i2XH
 g3Ul3KTHo6n42+q9Y0HJJOaYEGutBOmWsYclO1UFfCO6fInPm0hZKKbXdanwzy5wHhiR27VO8Hj
 qNoQQD0YlkKQJdYKd7wyoSGeU3ZOQejUJF4ZqsfA/t/puIPEvH13T7JF4NQ7b2otvCBvjrxUIXn
 eZgwG82iK6rv+ZgE8BEOGr9Tw9mRivxDXgJGxQKV68QyYZkj9nsS95a1OjZtHS/sRjN2rh7+Cyx
 JVaWkQUw2XEHoJAmqT3n9ZSKJMwObv2LdRi8xbgoNLgdCE0xMffKorZ3kLIQhTw7z5GUIAMFZEP
 419yHWDsovD/05Fg4VgTeofSU5cWw/rqDocY7NpqHQoZqpda18uYvsm3eDlaxGOXQPbUcrI0Gb2
 DulpGrvKC7ZOO4JHJvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040121
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

Enable the ILI7807S 1080x1920 video-mode DSI panel driver as a module,
used on the Shikra CQM EVK board.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 909f3c188e75..a6d72ff63e57 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1005,6 +1005,7 @@ CONFIG_DRM_MXSFB=m
 CONFIG_DRM_IMX_LCDIF=m
 CONFIG_DRM_NOUVEAU=m
 CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
+CONFIG_DRM_PANEL_ILITEK_ILI7807S=m
 CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_HIMAX_HX8279=m
 CONFIG_DRM_PANEL_HIMAX_HX83112A=m

-- 
2.34.1

