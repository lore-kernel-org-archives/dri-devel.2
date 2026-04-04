Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFFFE63FFB
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 21:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C85210E099;
	Sat,  4 Apr 2026 21:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GbaJtrYY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YzKWjZ8P";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6802810E096
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 21:03:53 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 634Kt17e3792283
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Apr 2026 21:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7ZvknanM1whbSfSnmntGaD5fuOzBhb0C116UCQrdDbM=; b=GbaJtrYYT2VYoTPO
 xucIKCOw7N3I/frjr2jwpUzP23uYQDXP/hpHT7k/XAXmxe8d1Vqal1H6W/XSecJL
 EZ00fOZmx0AncMCJr+JN6fm6ZzZ1qEjYC/50RI1UoTO4k2iXJXEMUX0yEy0Q0rPd
 2ttDM8qgze8m3b4se8r3a3ZowknA1qiO/GtSRWZApBsXOVLS+UNG6AYWueAP8CgD
 WrMyHNtyCHb9rHkp5XPh2tL295Eju5OoC7jYSLc3anM8JoY0HzVr175EkxSqwG51
 WXnAz770zYVWHqtmzTzUQ6o0IRVb7YRM9piFAz9DE8jL7ZPfabQ0jvIh3duDKlTR
 ec6Nng==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dar0mhq6w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 21:03:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-354c44bf176so3176683a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 14:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775336631; x=1775941431;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7ZvknanM1whbSfSnmntGaD5fuOzBhb0C116UCQrdDbM=;
 b=YzKWjZ8PuRSR3h4XCJZEbjo4T+EjLSaqQccVlVnY1TFyZfpzHcfC1fnHONk4VIa2hY
 ToAx5tN2UWASYhH4zwmnNKBhjK3W8i+YHSiQPj7DO9gdvGN6c1klGYX/0cYAnrxlaAfS
 ERIWqw/1sZRxZOshuN/6bNUBbLjZHE2BeCZyAucKm42Ne+7lX2HVX5ItckO+t0V9q32M
 xd4NqUtHIzJdJEPJ+to7OyLzT6HjV+T0o8e4DaD3nn7xe+j3OcjIAdsvp5FYzu/vY9g6
 gVL/cqdIAJfdoZZXF6yySPhtjbafDP6Mp+x8VbbYQB3Bg5JTsfwUN3WBwXLRTChA8DEn
 H8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775336631; x=1775941431;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7ZvknanM1whbSfSnmntGaD5fuOzBhb0C116UCQrdDbM=;
 b=pEhyBWJ2yLIMAWPYDkQRLJCI8Qqhd1W+Sc0rTmIhBYwY3bBF3kW0bvva60/NEXk4sT
 RthP4qRN1knJeSZpGFa1YklsaUkWKX4SXvBF9bKCqyL27QCEEbgxG244+7nS+Ap3Ykaw
 VCOZxTVdEg3DZCJFXgt03/Mp/wmYZebIlDI6jBDITTAzU8+tmdnpOjwk3+NdQbEaGOxP
 XkE6+mov/jafOwHUMAyYwnwYoCNXQXy69zQW96pC2PD4pVc8WlqnLowN2KCEVacbC2rL
 7sEyoNiAGj1lci1O9Js61gqJfzHsSZkEgsWaEuKGQLaVqgU8Yw7MC/qfmbamHBQJNmgO
 7vlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1BWv9EDTAkItEAuHWd6COJFV4DQm3u85r4Vz/po5xTqdf49Mmv83qiYySkQ8q3wssqewMFh41aN4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/gB6gum+GoOep1l4H7O4F6cnmgPr3vz7pMRCR36EW90m3NCcB
 CP6Y9A4FKRFv3aVhWxooDg/3+A1AGglJLHGSdYhpfT4m3D9mgdqdQytidond5/UJxYOa4uKVVvt
 nGW+qn7OYdYZ17c75Sd1wthe5Gmgz2wqmM/s9e5s/akSQcr5edL1+JUneKg7MS8pQw4LzwSI=
X-Gm-Gg: AeBDiesdAGsTSPIIEEiKIsv/DLR94QLt207FP2I2VAzJYTU4d+1nhjeVdUG6DKFekr6
 A4/9qNgGdfmIZs1mYEdJUqquMhFBWY9Pi3SB1LybEB3dQogcG4JYBaddMvh7PY4tBxI5mQu3M9+
 fmHL055E4b4rJ/x2OBCv1OODkkpcgz7jtO+kLvqoqoLlCFhBUbIr37GhELhZc3PgODH88T8pOMj
 lB8cVE51GJqGFqueS29lkmm+9vqKJlVFfhO5wF1qF5vMStCjhn3z2MYu1p9FE1YLNmwrI4VvOSl
 /NGHhjLKW9wT9qSzkmDmrENF0O41qTFj3FWk1ZQ3I0jyKX9HFG5iAuhMMCzQvPGWG41FwyscXBa
 m7qacUb+uM/ojk7wK8Wx+QpEHS5q/hzL0WtuXIE42pYbwOg==
X-Received: by 2002:a17:90b:5348:b0:35b:e690:c5ad with SMTP id
 98e67ed59e1d1-35de69d2217mr6357533a91.25.1775336631559; 
 Sat, 04 Apr 2026 14:03:51 -0700 (PDT)
X-Received: by 2002:a17:90b:5348:b0:35b:e690:c5ad with SMTP id
 98e67ed59e1d1-35de69d2217mr6357507a91.25.1775336631067; 
 Sat, 04 Apr 2026 14:03:51 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35de677e2dbsm2675545a91.4.2026.04.04.14.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 14:03:50 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Apr 2026 02:33:14 +0530
Subject: [PATCH RFC 1/4] dt-bindings: display/msm: gpu: Document Adreno X2-185
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-glymur-gpu-dt-v1-1-2135eb11c562@oss.qualcomm.com>
References: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
In-Reply-To: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775336617; l=1131;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=0pQSsN6kLJu1c2xkW18nAfQbObgvnTex0L4qjOiJnLo=;
 b=dJ/h64bEjXn8ZnjZvjsw4sHJmN2WtDg+m6rdoAEo4S5G0u10X+zOL2wkA+YLSFvUAsGfiy2ey
 ucRKe6Jog0bBSHgPCySYtwm2uQ2uaTtcB/DSPhOzoW72YZ1wpc8YH5t
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 3oHXwnAjO3kvZQAsUdrQ1srk_fF1eyuN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIwMCBTYWx0ZWRfX7OI86fNuGMAe
 bgT6vOhcSc3yEm8mv+DaFskM0L9Jlux7cQ6LWo0M7peRMZ0wlzP4xO1DClnXcqk7S2nxCWsyUwH
 JJtyEiFU8mQT43AnuzRb8MsiKDia6M2eWchzAEr6sTzoXxWxUW7sEpXDzDyMMH7IQg14ywj5lxS
 +7UY738kefhWwTupFYYaHUPWtvXfyWWpL+SSqyJbRV3UGJXzTd0E/S9/KU6ZUQI9F1+LsAjh4Tk
 pzUZcrNdnA9FT1qJLOXWvQZamD0wmePCLAf1BYbb/km9vLwDl4Zq7PTaVzQflNptMtygxMsls1L
 k5VAyb+4jqCZZmMhiPlSx0bbkVR8/iv2T7GbbK9ObU4DDRy4ou4500I5caQkXgCPSfmgsgV05+3
 Ix2N+RYIIpplgGmxMHxfW7eemUDitS2CN3/dYg1AhtCUfAsKVC2lmOOwHwB+DRtBHqtj/SUbSex
 8cQDxVwbGN4ssLjArbA==
X-Authority-Analysis: v=2.4 cv=PpaergM3 c=1 sm=1 tr=0 ts=69d17cb8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=aapufVXKjK5bSyzaIfAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 3oHXwnAjO3kvZQAsUdrQ1srk_fF1eyuN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040200
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

Adreno X2-185 GPU found in Glymur chipsets belongs to the A8x family.
It features a new slice architecture with 4 slices, significantly higher
bandwidth throughput compared to mobile counterparts, raytracing support,
and the highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among
other improvements. Update the dt bindings documentation to describe this
GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 04b2328903ca..bdc8e6fa5359 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -434,6 +434,7 @@ allOf:
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
+              - qcom,adreno-44070001
 
     then: # Starting with A6xx, the clocks are usually defined in the GMU node
       properties:

-- 
2.51.0

