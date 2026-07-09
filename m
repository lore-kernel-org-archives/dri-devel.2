Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB22C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF76110F2EE;
	Thu,  9 Jul 2026 18:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kttAp11+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N/0o4ojI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7332110F2EE
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 18:43:20 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXJ9B2386427
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 18:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VZQa/mqvt93chY0RVU5zPGmb1at+p5NGdnFyV5RZOgI=; b=kttAp11+1wwuB+SO
 rITOqpWpy1QK9fpn+uMaZKyNalwD7bIGGLtFn5BeOZkpPVi/+zNYM+KkfvzDRdlL
 J3kAbwQhVdMMv4BPn6OIPeS+XTWxyKuz+l34yGxtPHIgNHjbFd7nrjHkeC7Jnkcb
 tDLPYYOdjPN7VbH++3Q33STz9tgjxtB8ptOCoaeNIpVOt/Y8+wpeHCWudekjg5Q9
 GIAfy1rL70lAHnOuviXTOLTLdjlupoibNXJ5f2gtBsntJ5Jnai9X7QKapndaPOk3
 VpVPC/mEFbUhgFNzGW6NNAyTxDPyW4x3YesjtJ8I7BskFT9hDf82Z/qilaa3KWiU
 fg/eEA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa1ydvftd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 18:43:19 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88e0d11a3fso118622a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783622599; x=1784227399;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VZQa/mqvt93chY0RVU5zPGmb1at+p5NGdnFyV5RZOgI=;
 b=N/0o4ojIQr6Arwq/JPeyY5qWmqbJfYRVnJxNGML4ckXSYw70VmF5bTOfoLYD6q+AxU
 lebNYKfkbiLoGaDta+xeEXm4sOJB1zKwKrKUS1Ys1cF5YhdewH1V9EH9eJlc2tHoT2nw
 PA9QR4RIymKtIwG+BDmbOOZY+Qw5xb4O5g77A8vyeyzGHS4DjX6gBnp5A675/43713MA
 PIzzdOPYEYHwPrgCb12r534jHTkUl6tjiTe/BxKGDfQrlntzFc4Z4svBzBmWK1W/pZmb
 UCEdrneetY1oE2yBRGbsu8IEn/oBnfzv0CnZJQNwOyrexowxN4m3W8H9JYmcAnj9iDnY
 7EBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622599; x=1784227399;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VZQa/mqvt93chY0RVU5zPGmb1at+p5NGdnFyV5RZOgI=;
 b=fynoXow8hUeVNAprCtYjb8dgw3uWsJ10GqXGBMvLLjXLSB7giJxY/FUs4DYRo8xDPI
 2QGG8lnD8N28fDp7a8DSjGa2TmU8Sf0UmnrPESjzkCpZLjnUO+n5P55rORw+z0xL6Svf
 COE7n4RtUZyh/7ReFBYLgA/+BQNgISoClYZ6FW3rf2js6yiDNrR6834HEfezCZ2Lb4ZB
 A3reGGctkUwFeUzH4b2l/SAE7L1jQbfT73UoOjtB3AvJ7oj0/9+YaGzs8M1wdM9O6Al9
 huIUdnnRexMzTHUBAo3fUMOhIS1jJuaTY3BHTKpy8quvmmDMgHBl6M7wtYLXmSrnrqRe
 1IZg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqm3iwoYqPRO54XUDZ7JmivH6mdOj+gtNybs508vXNTfxaP4VMRxacGymq5o7gh7unTNK+WgRFjD8c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyREKM7CHsKtD80GaFR5AB6fMqmDgE50tVkwhwBEmMyB20RiTs5
 7WbVlWdntJnEkF7/4TQlZBCU9qoCQpPYEhxqQ82NXCQl/6L2mT2nI+TRzUzlv/gAriVUiA7KUIY
 WKLTRysVamDm45kP5IyEQHdeZUYE9buIVDwcBGXlAF2OXn28O/uDXVzVDScBp6MuS6hGFJcg=
X-Gm-Gg: AfdE7cmPR/V+WX7mYNstEVXsXq0treWCzKFHuPAeYCr7nvKyfzDdtNj/VOFKEgbuFIZ
 vSurWW8qhwNp1n6quYWil6Nyw9JomnWzZJcU7X5Roe0N8ELDpb6qlD5AtummI1GO/cj+2oiDsJu
 Cf8FsSncm9aeNiBV8OQ+AleZR6umOq+8Xx4NcqhG1ktvCuZH0w6hWScogzxX3f/Xxn3LfUrISNY
 gpxfIjjcmcvuaquJ/E7mTAX2kLJRbgP82W3kteBn494Hp2amTjUGOMdHeEbP1QaTPRw3TjumqUv
 mIS/63ez44q4w/AP9K7vcoThyHsWO7UvcobyxxLAzDxhjAioARfQoIQEiqr7s9V5Kc9WV4lhBs1
 ddGXjSQtfIjmUmICQvaFOPiuZKiAYze4qZko=
X-Received: by 2002:a17:90a:e7cc:b0:381:9ff6:3dd5 with SMTP id
 98e67ed59e1d1-389415e9f47mr8816706a91.25.1783622599287; 
 Thu, 09 Jul 2026 11:43:19 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cc:b0:381:9ff6:3dd5 with SMTP id
 98e67ed59e1d1-389415e9f47mr8816665a91.25.1783622598836; 
 Thu, 09 Jul 2026 11:43:18 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56848sm34205652eec.16.2026.07.09.11.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 11:43:18 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 00:12:05 +0530
Subject: [PATCH v6 6/7] arm64: dts: qcom: shikra: Add GPU cooling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-shikra-gpu-v6-6-b388ec5dce77@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aastha Pandey <aastha.pandey@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783622535; l=1606;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=hyEGcjwM6KENpeiGPhvJEAD4XFMZNW+63d9GkBZxZpM=;
 b=NnPL1pTXwyODmjoz9V6QImzaxRVMlFXSMFKP0EI3HRuym5woRxSxuwPBcZ6F2RmFq4guFSEBF
 HlxdGGQu0CeB7RqV2YL9E3KoLSDrA8wK8H/NZ1rspf394vAZc1s+TfN
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfX2mHkuhDEsm3K
 kzpsf8Mb1lvTwM0+eARflvs+tBFd5XA1z6+Um28ZV3vz9NOYa3qLIV1SC/UKYqXq3+jQyu4slnd
 st6955VjMukogJdnUr4/9Y4/O4i9bvo=
X-Proofpoint-ORIG-GUID: hrLHLDdT5WF1bl0NNqXF9lGoIA6JXQ0x
X-Authority-Analysis: v=2.4 cv=cOLQdFeN c=1 sm=1 tr=0 ts=6a4febc7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=tZdy-_Mj5ciOPZFqPb4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: hrLHLDdT5WF1bl0NNqXF9lGoIA6JXQ0x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfX3uajXhgX+9Me
 tngz4QOLCthWF9WeoD69qLblnnNoBmXYJQvUx8ZpSbRWz10DX5E+zrCFfU0BNYLToXCKu/B0Lyc
 KOmZZZTw74szpXU+P4c9eY5P4TIpF9AM8DaklWnNo0NbY8v5PeMnZNd9PaCvH0DnrBre1dBU6HE
 Vbbzgjamr8G+0edu0pck0otbN574t1uvjJQEnXPKtKm+DmJx9xwGIC3g0Km/FPJVL5ZvpaBBOY5
 AD8jIUOUfk2+EH0JzOSmHFTY1jkoScmHFjhw6ybAwr5ezHNGoEHTs8SUEEdP9MEP6C+Zpw3PJQL
 63cC9o+rQOQxeoTscG4c31eE86h6tDPCqZteL9MygjGnN57ifCRyRICM+ZB2lAUA0fYyUyrU9jz
 CoY94x8e8gGONol0FwWkaVvlGgHo2W8wSWCjm6c2spYWID/BUqtd8e7y04tuvCkfg+QD7NFAPrT
 ugph5crg8g3TLeR2erw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090185
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

From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>

Unlike the CPU, the GPU does not throttle its speed automatically when it
reaches high temperatures. Set up GPU cooling by throttling the GPU speed
when reaching 115°C.

Without passive_delay, the governor fires only on trip crossing
interrupts. Temperature stabilizing between two trips generates no
interrupt, so not all cooling levels are applied. Set passive_delay to
enable periodic polling to ensure all cooling levels are applied.

Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 34261221664b..eeeaa369d3a7 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2510,6 +2510,7 @@ cpuss0-critical {
 		};
 
 		gpuss-thermal {
+			polling-delay-passive = <10>;
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
@@ -2519,12 +2520,25 @@ trip-point0 {
 					type = "hot";
 				};
 
-				gpuss-critical {
+				gpuss_alert0: gpuss-alert0 {
 					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				gpuss-critical {
+					temperature = <120000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-thermal {

-- 
2.54.0

