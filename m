Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A82CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 06:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA0910EF5F;
	Thu,  7 May 2026 06:23:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S+GcArRV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Os3eQVGb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 793EE10EF5F
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 06:23:45 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6475MfeT3924169
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 06:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9rNAGIYUfdj
 1piWxOjlP8LFzd1d7wyZuV9JLCGPlDQ4=; b=S+GcArRVddDimIfm0VImbZsU8Jh
 BojGaEBTeO+nt1ue0Qo77p3y/UgonoABpbOevp9/nGuz9PW3MF8YD5gHhF3zl6D3
 hTbt6hN3PiAxkOddtM0HDKwxg/OVlFgQ3y+zFUoo+Ir757YYz0cSM3HdaX+Dc4g8
 JPOhe9WYHuv+8ys5rhJJS4AvMG1Nt/DiWN7ecMTuA8YRyDgBD+vIs10wF+mKJfPE
 sLqluSCWDcs9MXVlPhRwAWBCNFi0RtdqP0G5c3astwdk6iv7GGOBmCSmzCNXz636
 djZKA2peeZvhaK0RSj0lQgIs5gf5KcijeJQx9NmYIQFMRCOiydiW/FDeRsQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0c889r36-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:23:44 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-835444b6ce1so374198b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 23:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778135023; x=1778739823;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rNAGIYUfdj1piWxOjlP8LFzd1d7wyZuV9JLCGPlDQ4=;
 b=Os3eQVGbtrXXSjPQJhcmzamZbdef+egd4E9DhNC8LDJEoUhMuIsrwhB68/MrSZgcj1
 CotKNKsZSQ9io/zvlSdONg1TmzmVi1Awx67+NBNnSzm87Vn0nfD2xFJQVkZtO5qIjwz5
 n/bvpG4gxTo2asNWruPwq7tlyRlzm8XlIyEznr4KG5tHw5rhvtUzxmHjXmiW9QJk6plf
 XPEZJX9l2mYluYKnIZnBcE/u+09rAcpLJJLEZSY4RfrNzUoyzCuDBVaMEzk5SJlkLaEr
 5b9lZjvBvFYBXuHpKBkbPq2rTYE+9jrR7rgvpW38/2EGLreVlrzSkmxQmYzwrLVWraHF
 05Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778135023; x=1778739823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9rNAGIYUfdj1piWxOjlP8LFzd1d7wyZuV9JLCGPlDQ4=;
 b=tRtyv4VMWMQzKrq8i8DJEeSXvojYUqiq/zntfXN0iFonkQcn3+X2a1XnpSlV3h9iIu
 mW4Vx+tcH1hcN0PVu2s9lL3zfcELIa0MciXRsEm0uXg7WrcAj72/N2wpI1cSPMfWF8eH
 j7QKy3jF6akVkQ0cn3TJf61OXqu8UBhaaBugEsXKHkrpkMqx0MmRoQfvSTDZsGI7wMPo
 T58nhIEYptw4Gy9lyHT5eWpp/yj6Px64ZAr4iOz2QaNyQyQmHq9g9Sww7QDtYd/B+djy
 mR7avCWxehKb+WQGnAzju1Sew5ND1hVTvDZO9WRjoFBMIBywi4IgbIOLMQjjuYrTpbCv
 CNxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tew3LCLvTm4o52OeTflZM+rxxAjZ5NDrBgsSLN1T5/U/ZEYYmVk7u5f5nkrv/rAKnPq71cSl9ymA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgNqqGvW5yOAEyJ0HzITsH+AtcU5M3n+r3p9rw15Xa/ZJSqq8F
 UQCqOgdZWWTL7sBCo5TZ5OBpR77EllkfBUVj/J/fiANMDZw1fhJlfJ6kCN5ooEg26TxWVSlzaN0
 lSKcjsIlFl1Ymkp3jrgc+4vN8Qms//VdG123yBErx939lhgeyt2YKxcDi2x/TrEczuH/s9sg=
X-Gm-Gg: AeBDietsd0q+xhzRi0B3X9UbWC89KgiSMsGLeM8E7hyWLXQMLSf+4S9ef4jE26ja273
 O0qGkHLk+p3oksfq2yVGW4e8gPcqMMNMJLlcIVWAilHk6YAJdPYFMHfQwDgAONqNAlSQymLOUPV
 PO/Mk+HsXHBV2DUu+eyISHaS+Kq6lK2cTRGIcAxcCniaQ9nBMTZMNSYXDiv/1g/hL9orVGyV3Ka
 FzTgzXGJ4fgm3fdmrRXrTGQ7Z4aM2SgjUfd6BegBnpBn/mcvesEPC/rU+4lkqv3M9KfDBUAqrSB
 0uEUdhjkTUOlw1IcTvMd+We8jcq37NQ3W06Xo8XNyHTdgFbuULo/XbdWKy1wKk/RAciYMA9pNHh
 F3MDbHsfjwC8zmqV80sC/upBqARBnl+ecFUaQiuWFchi9qbHNfNBTKivxV4F4ULrY83h+VF7Pbo
 xANaXVlHJnlSz/VoYzzvgblZOtcGJkmHeFoSMmouSnzjYoZYVsV3qIuMnIXw==
X-Received: by 2002:a05:6a00:460e:b0:82a:7dfd:9757 with SMTP id
 d2e1a72fcca58-83a5b2d3078mr6499165b3a.4.1778135023535; 
 Wed, 06 May 2026 23:23:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:460e:b0:82a:7dfd:9757 with SMTP id
 d2e1a72fcca58-83a5b2d3078mr6499131b3a.4.1778135023021; 
 Wed, 06 May 2026 23:23:43 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945101sm7346557b3a.13.2026.05.06.23.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 23:23:42 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com, 
 kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
 konradybcio@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 jonathanh@nvidia.com, thierry.reding@kernel.org, digetx@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: [RFC V6 8/8] arm64: dts: qcom: hamoa: Enable LLCC/DDR/DDR_QOS dvfs
Date: Thu,  7 May 2026 11:52:37 +0530
Message-Id: <20260507062237.78051-9-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: F-U3Bj9BRomwZAbYxPNEoeLswK5Sy_mC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2MCBTYWx0ZWRfX7a6x4+eWJ5TG
 kN8sWhNjunAIHU5GLrLhpqgx0qm7/GV/NneqnTFBk+9Urso8zesJggSH2IsfTtUnN4chF6l99QV
 LnEW4uXkqZVo5dqMAcmb+Xz4qEg7I/LDhfPhw/RAP+OwxV8lUYBtVVbEc8T0w25ifxeV+YrNdk3
 yStJBXnl35ZKWg6Rvmx7ZRgNDsUREPQUn9T2apA4/+LMgSPOvPE0yql6tMHIt0R2j4dbfyCTFrT
 UzL4669v5rc7L7QWPC32PgdunljRPfR2X0jNGjgvSPp6Sw3e4RkrGb1psTCtMFjTQeYn4Pgfu/c
 WKBzkkGynobs/POq2Y9aj3519U2JOCQ9wRXApGkW5ZunhfiMcb9uY4kTApEoey396JmRWWlPq1a
 D97Bp4BpJ3SSH3Iy3R83PQOZabNRAxjgYeAvjQDqmfXzNqbeOwoh3anfo2Dp//DqFqN5ixIl0V3
 CmoHnvn4Dikjgwb3jkw==
X-Proofpoint-GUID: F-U3Bj9BRomwZAbYxPNEoeLswK5Sy_mC
X-Authority-Analysis: v=2.4 cv=X8Zi7mTe c=1 sm=1 tr=0 ts=69fc2ff0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=gKi3Cb3mJvt5RuhTHbAA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070060
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

On Qualcomm Hamoa SoCs, the memlat governor and the mechanism
to control the LLCC and DDR/DDR_QOS is hosted on the CPU Control
Processor (CPUCP). Enable the nodes required to get QCOM SCMI
Generic Extension protocol to probe on Hamoa and Purwa SoCs.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 051dee076416..a2d5c9db984d 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -338,6 +338,10 @@ scmi_dvfs: protocol@13 {
 				reg = <0x13>;
 				#power-domain-cells = <1>;
 			};
+
+			scmi_vendor: protocol@80 {
+				reg = <0x80>;
+			};
 		};
 	};
 
-- 
2.34.1

