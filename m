Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98746C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB45810E1ED;
	Mon,  6 Jul 2026 21:05:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OB3SWaDO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NXcsUG3i";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54EB910EAC3
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:05:02 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDqNW1628698
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ep/7FXUXye2OKnoYYBiKQZ
 +RJlOWy5+Z58OqDRKG4fc=; b=OB3SWaDO9LBTQVdXvsoTybQM5DNmjh+hVAKx8o
 W0n+t4T6jBlg2tfMKPOqsbbZZcqpYOv8bT1UBMrTSQmDh2iZNlbU54bjhEcC1onX
 en6ym0K/r/EIGD/AO5fpgD0UeSDd0bacInZ/6GDgSCmo2zLNNSqLeE+BHPKDerR8
 df26PIxCCq7XwJAMYg17imKo/3OAJicj3JKSUZIx5OQAL7zEba7/CVOG86tD8eSx
 4mCekkVsynit1B5J5JoFKOYazxFnUJwos+eto4Hz0677GvTVDv4TUy5qj+pvaSqY
 0kzcwd1D49akvH8tQ8Ymv96Oq3O5GX3ObgzcSmmAhb30kuog==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8fdw18ke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:05:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8894570b58so2431234a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783371901; x=1783976701;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ep/7FXUXye2OKnoYYBiKQZ+RJlOWy5+Z58OqDRKG4fc=;
 b=NXcsUG3i9aY8576Jojr3zY3mQzYhAXWfsZRCBdF3eiTbMjnrq0l9Ja3fVu8YVqOr6d
 QMmpe8PsfUfzI1FZLCj89JEVEtBhRcR/aqNAMPyQ2bkvnsqCwRwKx94obFCR9dcRv7wQ
 o8nCWJ7gAdk6i6Yj249lu764GVK2MurVo6d7lTdYNk5Z+rudHw2ejyR/U3eVGd87nLFL
 VT7H0bmUUpvoBVnQx6PMjmgUFGJoZMC4LLjNT2virttsKhoJNnUZKE1/39LsJst7D9kq
 7p5XnWicL4tG49GlsipWqBX0NZU2JKie5JVF0f8xduYoYGWKHMmhU16iinNSnUcpEktl
 vcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783371901; x=1783976701;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ep/7FXUXye2OKnoYYBiKQZ+RJlOWy5+Z58OqDRKG4fc=;
 b=iCZh/15IYi7zqBLYqQ1fklmlD7m/16ERQ0IIWPJSEnxOO2VwdwKiXwo5dWW51Ynu9B
 wjmG/FMka96H1dPSbysQKawJhBfZsTDvwpDrKRJL0mLz6Pt2EV26DxX/mbTqo5cMHKRg
 xt49v5xXXoNFOstt7+8/6D3XADgyaCVonSLI8oLB7CefVw+1R69+Ckh3xwjyew6UmSOA
 ujQkj3UJ3UKGvgf5a5Doxq8l+F6H9/KcTagFfydw3ssVMDx/U06yjqwYGBZwqgu98zZv
 kYSr3aMidJmR/Mh8GKAdkLsHznOc+XOZiNOR2P31lt7TpxfWBnYMd8QjKEmG1g2qr9tX
 mtXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtlWcPaO49zvkFLTSyMd1oPtu9IekHK29gIdy0PjH6NmadMXpwotYIN2Mg7arG6ZKZN4DUspRYojY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0jgAW+aLaEnv7pm9Fin8KnRr57q07zo0kV7F41RMZIesO0ElL
 6ixrbWwLv0jTGIv2YeCmtpBK6eP6DPZ0ZJTqtktAApStoqjcFO/UuqtOw0UIo3EMrBWOtojWKzd
 1kNNiA95QjLily3VFbkNP9E9CqCC+zINnuHBP4nt6+lmSbEbRdUHzKK4tAicprnfC3bCRM+bBeS
 GkgW4=
X-Gm-Gg: AfdE7cls9/C1l5XJlX0BYx+HOSFcgTDIZR4lce+P3c3f1uqDrs/v1gRLSSuhMgm458O
 Rljtrjhn3Z1+BOxnC58NJ3QJHB2iT9Ccegwei4gBc9PxoS3q9T9hpfjjHV3jSaLCvVdF0k5Ipyj
 2wysGGJNgSlcShmfnOKC9SE+dbzU71lV+ztIxyy2tMSX4eJY9ejlzpptVm/s75+Eyyg1FL123+E
 F5fPPt1+xzv5VpsFd+vbsxWJNnHUhPQ3xaKx0keV3r2EDxr4ul35/EfKyI//TSoJiA/0Kzuj2MN
 K2RrTDk2/WBNlcwF/mMtJJK8+4AyXrz6gxrgmj6b4Og01ukPEd5A6cRbWHK9cUdsFxijxS11O5D
 t5ufcTGv6L/kpLIDt6M9lnlemLAQxgz/fPOk=
X-Received: by 2002:a05:6a20:d494:b0:3bf:a11c:176e with SMTP id
 adf61e73a8af0-3c08efab30emr2850782637.57.1783371900911; 
 Mon, 06 Jul 2026 14:05:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:d494:b0:3bf:a11c:176e with SMTP id
 adf61e73a8af0-3c08efab30emr2850727637.57.1783371900307; 
 Mon, 06 Jul 2026 14:05:00 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:04:59 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v5 0/7] drm/msm: Add support for Shikra GPU (A704)
Date: Tue, 07 Jul 2026 02:34:32 +0530
Message-Id: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGUYTGoC/6XUbWvbMBAH8K8S/HoOd6cnK4yx7zFKkKVTI1I7q
 eWEjpLvPjkPbbOlkG1vBDL2j7v/SX6tMg+Jc7WYvVYD71NOm75s1JdZ5Veuf+Q6hbKvCEiDBlv
 nVVoPrn7c7molBbWBXYRoqvLBduCYXo7Yj4eyX6U8boafR3uP09ObzB5rqG0AButdi6i+b3KeP
 +/ck9903bws1aTt6YOA6kqgIlCkgEIaL2L7iSA+CNRcCWKqoaXGiRa1YfxEkO+CAXklyEkAH9E
 pYiXsDeFwCmng510JejwlVbUucz29lMbFrOeXsT77NIXacc7uOIbF7Os5vvfSva+HbVdW/7TO9
 V5NNUjPsWRJzOKPGr7dJhXpM7lM3i/XftPH9DhNBmuvGhtaCkDC3/a2bvSro8YNsDNWQmsbNFJ
 az57QRafZspSCAQxqHW9XIQVcGksdd3Wb+pD6SxnaGk3CRgvx7rYAL2D2v3lWBBNdxNY08h+80
 efhGgSPQge0Qou7Qf3eMQfnT1eBGtMKEoIkurshfKssjKdzgCA4kHaNInsvYwBRK1A4l0hEypa
 +1kPKq97N17vBlUmnv7LISDWXZbII+j8sDeJyPnmb8/JJnG6s8MTQGqvZNPfXRR+i6vCUVrSIz
 lsyBP5+SbxJKW/LLSw/grIeQV+OQ0M6yKBuTfHhcPgFEoR3UHwFAAA=
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Aastha Pandey <aastha.pandey@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=6748;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Ahu8xNvk1lKmwpQNy6Y+IkeezPJfKbRhhPCuckBKhAU=;
 b=WpydgwWDk+cqu4ba6ffFGiuXyxIISbpArIe/urfxSv46q2Sgous3Dv2YEqyjhe/SD2+d61v+V
 1T1uNMT7AUACSxeAtPQfeLve+4HP+mClMJ/qfZB6QA2DhKyoCoxen8v
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfXzKmXRfOWuF40
 ONkeVBiZWrjti1Y25DtJNvWypzkvo6SEbjHrVVU7OS+8vUSgU9C1Jdgl10SdFyqvQPNP/Jr02ac
 PKGHcAkxNMA5zFRdnBHnb8MHVHJRzFw=
X-Proofpoint-ORIG-GUID: fOq86AiWeyzgEQsbfgzOmwuVmRY9G3_t
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4c187d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-nh9RajweDyCoOXDqwUA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX5YI8oltEb2zC
 WzNr00se98cbRIFYdP/B2BRNPCLRMpA6ZpBs5jAYyRegWn1Pu3Od7Q9zw4NMU8vj89KzYsHTyMF
 CiKdXBRx5NmaJtrb9xZaUEMYInVW8F9kBZE92CJQoJM5TBp4YixHys8sY58iVtb2DfdPWPiOo5n
 LNoaRUN4fPvO8E2FxWrC9izFOiy3iomwnwwKSrum6GNXlUPfXvu1ZxsnwkisA4Dnykdq/WxllJG
 ol9xDv18vKdmSAKLSFYRrA/JYFusUbRLgNJ/U1m9zTG8DrLmutYXSscO841SYspwd+RufM6C/AK
 qqCSGpLyzqevhEpircCFx/eylchLwAjqART5uaglKCIn6aBPssHAvWW6EDhIUCtU4V+KgCiyNlw
 WDfBZrZjXSJUwQD4066WYR3ZD75QhIpkbkOtETSt6x9Yya1qBB2gHWNwdtS0lXwvMiYm+ufD6zs
 J+z53oYk3B1rexq3tDg==
X-Proofpoint-GUID: fOq86AiWeyzgEQsbfgzOmwuVmRY9G3_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060213
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
Changes in v5:
- Drop dts patches and enable GPU DT nodes in shikra-evk.dtsi instead (Konrad)
- Update commit text of GPU cooling patch (Dmitry)
- Link to v4: https://lore.kernel.org/r/20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com

Changes in v4:
- Rebased on top of next-20260702
- Included additional DT patch for gpu cooling
- Link to v3: https://lore.kernel.org/r/20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com

Changes in v3:
- Rebase on top of next-20260626
- Included GPU related DT patches
- Link to v2: https://lore.kernel.org/r/20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com

Changes in v2:
- Add a new patch to document the GPU SMMU bindings
- Capture trailers
- Link to v1: https://lore.kernel.org/r/20260609-shikra-gpu-v1-0-9d0e09cab115@oss.qualcomm.com

---
Aastha Pandey (1):
      arm64: dts: qcom: shikra: Add GPU cooling

Aditya Sherawat (4):
      drm/msm/adreno: Add support for A704 GPU
      dt-bindings: display/msm/gpu: Add support for A704 GPU
      arm64: dts: qcom: shikra: Add A704 GPU support
      arm64: dts: qcom: shikra-evk: Enable A704 GPU

Bibek Kumar Patro (2):
      dt-bindings: arm-smmu: Document GPU SMMU for Shikra SoC
      arm64: dts: qcom: shikra: Add Adreno SMMU node

 .../devicetree/bindings/display/msm/gpu.yaml       |   1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   2 +
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi           |   8 ++
 arch/arm64/boot/dts/qcom/shikra.dtsi               | 143 ++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |   2 +-
 5 files changed, 154 insertions(+), 2 deletions(-)
---
base-commit: a9498e40e3e314ade387d3ab0d5cb14f0f3aa1ad
change-id: 20260609-shikra-gpu-5432bdeaf0f7
prerequisite-message-id: <20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com>
prerequisite-patch-id: 59bb0a7828e41f546f734f127d81da83c0adcda9
prerequisite-patch-id: 197da6bcb15cadc47869dba88c8020987b25c335
prerequisite-patch-id: 8ec9c1eb03f052ae232ed54117abed38672c23f6
prerequisite-patch-id: 350db4f4bcdfc0fad9ed57cd5b1723f85ad44f5d
prerequisite-message-id: <20260526-shikra_icc_kconfig-v1-1-c589db2d023c@oss.qualcomm.com>
prerequisite-patch-id: 028f3a3c64f57a611b6ddcfee947c56aa6251e3b
prerequisite-patch-id: e80ea7940b9817449cec21afa6e9e443e007166f
prerequisite-message-id: <20260430-shikra-imem-binding-v1-1-c6976239f90f@oss.qualcomm.com>
prerequisite-patch-id: 80d8ab865b7b0663c5b2878b45b55e2e4fde9c19
prerequisite-message-id: <20260501-shikra-scm-binding-v1-1-93d7faf1b784@oss.qualcomm.com>
prerequisite-patch-id: 8e645e1c6ad6182de4813a726c293654324de1df
prerequisite-message-id: <20260501-shikra-tcsr-binding-v1-1-0c136d193634@oss.qualcomm.com>
prerequisite-patch-id: f6781d2cf0829ccb32f1400623c95739972f2ee2
prerequisite-message-id: <20260630-shikra-edac-v1-0-287b3233241a@oss.qualcomm.com>
prerequisite-patch-id: fb821179cbe1fb1a97b987d04acb5a656aee9c14
prerequisite-patch-id: 1981818fdff444d3bfbe15f5f52a654a73b91c81
prerequisite-message-id: <20260611-shikra-dt-v5-0-103ed26a8529@oss.qualcomm.com>
prerequisite-patch-id: 3a689e8dda5fd2755b689d94d095806b3f2e6eed
prerequisite-patch-id: e9f8fc7688e5b366cfbd2449856c0aa524424051
prerequisite-patch-id: 2357cac636e019eaf14d6a493a1c72bca56fe405
prerequisite-patch-id: 2885f299e711582da312ca9d13983d296a3dd5dc
prerequisite-patch-id: 91af5f3c01e766a53ce8de69aa21847a2d6bbbf8
prerequisite-message-id: <20260701165051.4122259-1-krishna.kurapati@oss.qualcomm.com>
prerequisite-patch-id: 0cbcb69abbbf83da785619c266c96af624c38a87
prerequisite-patch-id: 1d1ae48f09e537312052f93bff8d04093addc996
prerequisite-patch-id: 6126fcda921fe53b86b3a18c649fd8ff2e1f43d8
prerequisite-patch-id: 3a0482207e363349423f81ee7589328a84752de3
prerequisite-message-id: <20260701162745.4043106-1-krishna.kurapati@oss.qualcomm.com>
prerequisite-patch-id: b4d2580ed983cd0262302ad93304dbe5398e5d6f
prerequisite-message-id: <20260603-shikra_epss_l3-v3-0-3c2e0b796e78@oss.qualcomm.com>
prerequisite-patch-id: b5d7f75df02fde56181f576a936baf09d0a72276
prerequisite-patch-id: 3ce52e07ae57139c2e2b71a29ed7d7250f6fcc87
prerequisite-message-id: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
prerequisite-patch-id: 48ecd66c06c4fad81f91283c26ec57d95bbde29d
prerequisite-patch-id: 7d92e5a301d09616840e54dc9e4a81f30a64383c
prerequisite-patch-id: be1a16f53e23dd5ab90210a056c9da3559c6186d
prerequisite-patch-id: 3eff04500c55100c763aeac1f1f8c5768d500500
prerequisite-patch-id: ab22c5fdb2fa65b78ffef76bbe4459c8d5ffe7b2
prerequisite-patch-id: cb24efedb648271ef5c60ace96e2366d89254e8f
prerequisite-patch-id: 8be7df0395c5847a988c7e814c7db878b5932b11
prerequisite-patch-id: 0510992d022cef7317b6efee6765ac78c0225356
prerequisite-patch-id: de4327fcbe81f92a337f429b74e8220969a5b79f
prerequisite-patch-id: 968bffc36646412f8289b917f37e762a4297bcc8
prerequisite-patch-id: 35944403bd4480caad12657342da15ea71c6afbd
prerequisite-message-id: <20260703-shikra-dispcc-gpucc-v5-0-cc13826d4d5a@oss.qualcomm.com>
prerequisite-patch-id: 23b24fb512c882a045ed8339b22269bfc2c5d02c
prerequisite-patch-id: 0e79e46bc5a88849a2f0a410b39c08f3244dfed3
prerequisite-patch-id: 17b412a37859fba801efdbe451db31e5bd77438b
prerequisite-patch-id: 0396ac157aba73a5afd7ba4a8a744847f5a7b433
prerequisite-patch-id: 2b1aecd97b9c073a1b323138cd7a98cb34e3715f
prerequisite-patch-id: 823bc7bc713f6fce1b9de47a266307f1829636b9
prerequisite-patch-id: 1b990e46422307e558300815c1166b90d96fbb9d
prerequisite-patch-id: d78e0b95758b82977d80c7cf18da49661cd181e5
prerequisite-patch-id: f62b00cd64ac3191e0906514443dd43e88746818
prerequisite-patch-id: 0fab99455f954a917fb65348656505cd7ab45bc2
prerequisite-patch-id: b59fd05f9b62bda86079c9d86538b80289110862
prerequisite-patch-id: 71691d8b40e36cdbff6a52c3999ea8bb2c164d70
prerequisite-patch-id: b2868bc50d74afd13c8a0d0fd62301fa9546a211
prerequisite-patch-id: f83f24719ac475317507af09bf08b4a69b02d429
prerequisite-patch-id: c9f2942207341ad4f450b20f049199f35188c02a
prerequisite-patch-id: 3a6e9752793f2d7b084008b47daed10ea572064a
prerequisite-patch-id: 3338cdc5915c1e6b991067d3a7afb734c182663e
prerequisite-patch-id: 59cf68a3a49958a60833aa0464980f8c8d879961
prerequisite-patch-id: 5d146a518f2f76bf9fe93e23a2cfa63c73731883

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

