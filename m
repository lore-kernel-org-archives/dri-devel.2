Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C51CC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 18:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E82D10E661;
	Sun, 28 Jun 2026 18:24:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iHB71d6a";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pivk9RaB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2322110E65B
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:24:25 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SHjAE5450033
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=uNyxdOLXPvrnl8aepSQH6t
 OHrLPu9lyqtOJV4hZUZBM=; b=iHB71d6a12wWorhyr4tE4zsiS50LJiPXqDQgrz
 L7hOht1Dhr3qJWpbQ3/GAvP7yX3fIp6i8ZSi3RavSnXRfI2kOQsN5H7pv8n0hZOb
 T8RFEht9dYmUwbghDklagUAcYufaB7lSJLnyuspWTu6CJFICoidN9x1tcwBmv/DZ
 5Z0/Z6Ui3/QJkhUCJftuMdl6bvWm36Hq7iJtMiyE2MTtkH+BdUSO1AZe7XfBxBxW
 DazyYyEcI7AmLRaVuAiz9peRm3diJ68qn3R9aZJfS2dTUL4P5VFI2/iMDFLt6Pid
 Uj02lbujDbPi++rh6pMAKarqtaEH73lglxm5Nbz+RJGWV1iQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8kevd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:24:23 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c17f62afdso2354358eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782671063; x=1783275863;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uNyxdOLXPvrnl8aepSQH6tOHrLPu9lyqtOJV4hZUZBM=;
 b=Pivk9RaBUVvXeQ5lKqz1tG4ZyP2XWU+gTF2q3YhI6Y3AaaX9vQzTrOIjzlbtSFabcT
 n839cqGwL+GPxZEh31YK3gn40ns+Ol1D1pxJdtKr9N1cXd9TQC+QneEtCaqxLEDbnHgV
 m0MjkyedLmTHLplGdaBorse44cOqqhm4m9r/oXat/F+G8v26D7gB/OkkJufiqP2+YprY
 wRHrRwlKgKjFsdCVoRBpBw8o4IZZdM6auZ8VvOInKauMrBpRkSlgUx02+QQMSRCPd5h1
 iGp1oZLSrBaVt7mke0goaN/inIOHNVPcf96E5+HIaFEVlzOSjbtKw13xhNWxM1wrTNW9
 uoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782671063; x=1783275863;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNyxdOLXPvrnl8aepSQH6tOHrLPu9lyqtOJV4hZUZBM=;
 b=YsUgXl2Yyc93xwplCXorRmHDGKHq7CToIINxbmJimV6V7UmwmvHpaLV7Vm/Pgl1tpv
 Kn8EVpFiDxM9xFim55eYrffJWXQLOfepFfz0M84vOur9iwgJjLDFxHOtIsRqVF4mLdB5
 vQ1wilr8pUM+zUo3hYL40apU1EzOwQWiITHepQuptX3X/41O9WhQeh2plVQmqrBHHZh+
 BWNH8TfRv7Znox5pZ+VKias6wM9F7KK7y25FcUKa5SAYG9XsHohNov3DbPut7px/nn6T
 NauImcgJSW1y5nX1u1v1al+LYShT2CxLgUV6TRbOuu30QkYNCDEjfD2V1PeJGBiiOTDH
 fmEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RouniJHmz3C8IEB0beusRdEkbwuBWSqvCtAr/vNApcPloliS7JC4k32q9A2n6/X5EVb3PJngN4Uz2M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOOCseStNiGbX6PvHWSIS2ciMULXKIwjhbSUQ8Og2l8aNnl3Ae
 juT/HmMVRSpmvvziaoaXt1P53nxRHRjsPT/c1GyzbJtOepHgYG7GpU4en5r2P24/XkU3lbbsuyZ
 xlOzB1r+jM0bwHWsEqcCePqumHIEh+SH3Xrk5sNobJzzwA3eAV+7Uyo4svTsFKF1nOe8V7MWLRg
 IkqpQ=
X-Gm-Gg: AfdE7cnN7KyMsmN0AD2iT36xv+wnmKDl/XkzGNLmw0xatlLYMihPOzM+Ru/30+EY8eM
 r1PIL82aKdYJZcUpwz/rH8GWFthFeb0RKNp5Z0Gqpx3Xm5p8nUjJ0ZEI74lJYJiqHMfS6MbVsTl
 HGrqiZZMFqGf33VknRGM0YkbXfV1uBuSoHkEvGyvvibyLH1pyc0fwWDrgPOyFso+AJZdx6zMQIn
 4n+BHlIIu2k5ZgnKtZLsqsLDPgX6kKL+9+DYUkWyYeEO+1gSQWi2aj+2rQ6kgaN5fA/ZulRMcmT
 GeRLRy78kQ2tBhjdW56d70WvtlJY/DXdG52qwjHUrn7swffN5NLOkoZ6jVLJRSOFCkIoeWmAHNO
 xmFEJUTAr8LWjC4g9gbMcCSqhj7c2bvx2mAU=
X-Received: by 2002:a05:7300:ec18:b0:30c:ab96:7306 with SMTP id
 5a478bee46e88-30cab96771emr7743496eec.22.1782671062549; 
 Sun, 28 Jun 2026 11:24:22 -0700 (PDT)
X-Received: by 2002:a05:7300:ec18:b0:30c:ab96:7306 with SMTP id
 5a478bee46e88-30cab96771emr7743467eec.22.1782671061966; 
 Sun, 28 Jun 2026 11:24:21 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 11:24:21 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v3 0/8] drm/msm: Add support for Shikra GPU (A704)
Date: Sun, 28 Jun 2026 23:53:53 +0530
Message-Id: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALlmQWoC/43Q3WrDIBQH8FcJXs+ixnwyxt5j9ELNsZE2H9VEO
 krefSfpVjbWwW4OHNGf/3OuJIB3EEidXImH6IIbemzSp4SYVvUHoK7BnggmcpaziobWHb2ih3G
 mmUyFbkBZZguCD0YP1l027G2PfevCNPj3zY58PX3IRE4ZrRoGrDJKc569DiHszrM6maHrdljIq
 kXxTeDZD0GgIKxoeCoLk1r9QFhuAT2cZxxyuqUkWgWg6yU31UkPl4nefJGvA3UQgtpWUCfPn9H
 L+8fGUD92WM3pGGjM1imkAYtzCID0V4aXP0guvshmojFHJte50VnZaFkU/2aYvDMujBgLN4M1S
 gRLwaTlTFQp5w/A/bJ8AHPEn0AJAgAA
X-Change-ID: 20260609-shikra-gpu-5432bdeaf0f7
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
 Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=3664;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=75L9Gwo4Nbyb7dmgSjP5dJBoAyyIjloISpF52plkp3I=;
 b=PgRzW4o2SddLK47Q3Hm5eNNFLiSkki9yVLGnmz57FrcBQ8JSkSDQa680Sqq/oBzheZtbPJobX
 hxTLBJgd66XDIsUa5+sMHBz5AH7d4P8S6U7bNs3OOxACVuEo85A2Aam
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX2xD7Qx3Y93TR
 dCDS42icsDzgKkrnJTbg5yNDwf2KkybVmP0itxTkmOGYyofUjzsKH/saVS0Y1FEOWdH/m95FAMw
 oZ41MGJ5jkG1IrU1+1XOXJEmOI1cSXU=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a4166d7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QyemgOkiUGGnp4gUInsA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: oEuYiCe9S1X1XhINLZVA9vvTnw7oK1mu
X-Proofpoint-ORIG-GUID: oEuYiCe9S1X1XhINLZVA9vvTnw7oK1mu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX25GbIKsqiiVZ
 uMO37b8ptkGkye7g51m474r99mbqiq4lhcG3AdW7IA4/uxx3JSQc57DdDvU5b+3Cd0J/vWJjHXz
 ey8fIWdCQMQxDjYF/9NtwzwhjLkP3Tq1nG3oXdKCyQuIeGL1iY7LeTwicrRa9YQlvNt5bRxH0Op
 G2NDrEi24jcodm4L0xO8huLVvcWjM5Z76ISUbI1NFXLWXvhRHD4PnBmHmn7hTbBqm5rKlnrSeDp
 gWesyQ8q+EtOpgJIZxSgWb+rOjQ1u5jB+c+X44uGWeXYxrU/dfSCFihDZ9DnOsOC+TsNwn3q8si
 gHu13ti5Q7JXvp8dpKlG/fotTRHOfLG3HQErTzjcIZdvsdNE1YGVT7PYGTtgGNXKiwsGeVB2n9N
 pJCjhV0Bws38ypSAvJKfDdNP3LYobWiwik430qsUHv8ZcH5oLkZRwyBZKWkG4mBFRq0rywbBwOb
 sKtzfS5OCNSygAWvcmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280165
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

Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very 
minimal changes. The only KMD facing difference is the chipid and the
zap firmware which is specified via devicetree.

Mesa side support is already merged:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/41762

Included the DT bits in the v3 revision.

-Akhil.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v3:
- Rebase on top of next-20260626
- Included GPU related DT patches
- Link to v2: https://lore.kernel.org/r/20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com

Changes in v2:
- Add a new patch to document the GPU SMMU bindings
- Capture trailers
- Link to v1: https://lore.kernel.org/r/20260609-shikra-gpu-v1-0-9d0e09cab115@oss.qualcomm.com

---
Aditya Sherawat (6):
      dt-bindings: display/msm/gpu: Add support for A704 GPU
      drm/msm/adreno: Add support for A704 GPU
      arm64: dts: qcom: shikra: Add A704 GPU support
      arm64: dts: qcom: shikra-cqm-evk: Enable A704 GPU
      arm64: dts: qcom: shikra-cqs-evk: Enable A704 GPU
      arm64: dts: qcom: shikra-iqs-evk: Enable A704 GPU

Bibek Kumar Patro (2):
      dt-bindings: arm-smmu: Document GPU SMMU for Shikra SoC
      arm64: dts: qcom: shikra: Add Adreno SMMU node

 .../devicetree/bindings/display/msm/gpu.yaml       |   1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   2 +
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts        |   8 ++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts        |   8 ++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts        |   8 ++
 arch/arm64/boot/dts/qcom/shikra.dtsi               | 127 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |   2 +-
 7 files changed, 155 insertions(+), 1 deletion(-)
---
base-commit: 10a31245d8ba950c7fe87face7d0c190009cb572
change-id: 20260609-shikra-gpu-5432bdeaf0f7
prerequisite-message-id: <20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com>
prerequisite-patch-id: 59bb0a7828e41f546f734f127d81da83c0adcda9
prerequisite-patch-id: 197da6bcb15cadc47869dba88c8020987b25c335
prerequisite-patch-id: 8ec9c1eb03f052ae232ed54117abed38672c23f6
prerequisite-patch-id: 350db4f4bcdfc0fad9ed57cd5b1723f85ad44f5d
prerequisite-message-id: <20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com>
prerequisite-patch-id: 3a689e8dda5fd2755b689d94d095806b3f2e6eed
prerequisite-patch-id: ac83151a889855498d36288ddd36216d451340c8
prerequisite-patch-id: 2357cac636e019eaf14d6a493a1c72bca56fe405
prerequisite-patch-id: 2885f299e711582da312ca9d13983d296a3dd5dc
prerequisite-patch-id: 91af5f3c01e766a53ce8de69aa21847a2d6bbbf8
prerequisite-message-id: <20260604-shikra-dispcc-gpucc-v4-0-8204f1029311@oss.qualcomm.com>
prerequisite-patch-id: 67fa5f31ee5109470da23db3b513721580f4c86f
prerequisite-patch-id: 0e79e46bc5a88849a2f0a410b39c08f3244dfed3
prerequisite-patch-id: 0396ac157aba73a5afd7ba4a8a744847f5a7b433
prerequisite-patch-id: 2b1aecd97b9c073a1b323138cd7a98cb34e3715f
prerequisite-patch-id: 823bc7bc713f6fce1b9de47a266307f1829636b9
prerequisite-patch-id: 8a8a9df61f7c7c51d7ea9cdacc52b7bdd917f12c
prerequisite-patch-id: 5b89b41d7c729c23b3b1fff9b5f572f4baa915ca
prerequisite-patch-id: acd08e91e5e2c6f4799879e48481b07167c0a400
prerequisite-patch-id: c9f2942207341ad4f450b20f049199f35188c02a
prerequisite-patch-id: dd62ebff6be6a2e2d32743812d35ec54daf91d00
prerequisite-patch-id: 3a6e9752793f2d7b084008b47daed10ea572064a
prerequisite-patch-id: 3338cdc5915c1e6b991067d3a7afb734c182663e
prerequisite-patch-id: a3026c858ffdfd3bfafc837e72c67fffe46021eb

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

