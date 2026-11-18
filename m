Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ADC606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J/Livr0m;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CSHP+Zqo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C134C10FC41;
	Wed, 18 Nov 2026 13:08:50 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B1AB10FC41
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:08:40 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AICLWuo3420713
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=r7iSbd2TueejGnIqUEPWs0
 leIgatCchC8EEoeiFyk2M=; b=J/Livr0mgoCmOzoWzzm5YLuoJcPrXHbPGCh7TR
 2SbqbG0OvwwVGWMKgzegY/2r/AjkDxq3pnWsLRUVZ5Yhi81uyl4RXJceNT7u+WIe
 vO7deMcvDbOc6uHnWFU3lQQ1EEq+eWsee+7Gd4HqRAaUQqLQqkODJhmuq1vIcKk7
 8bg+oumzbaEh1lKQ0XcIqt7+ezaLgJy84gcx10+Imp/r3KMs34uwugwoX87hT2ij
 Zt+AFwk7qvom5atTnhT+WGpOdYo5CMWl4qHqL9e95rl/nlO7sThie3t1NhYglTPo
 3iBobjMw/Wvg9G9Vn3Z8C3rs6Bxhw7beCotCWFeTQtWPoi5g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8u28b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:08:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3b141294006so197989a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795007318; x=1795612118;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=r7iSbd2TueejGnIqUEPWs0leIgatCchC8EEoeiFyk2M=;
 b=CSHP+ZqohNqj6ioxa9Yyz8hsw2byrsdxSkqUUXUJ2a7bAh2BBwrSWTJ2KUnzXlDEeg
 FTiR23+SOeBvM4ehgMOO2UqaktJL8M2+W2uHuB7+juXJ+YM4LasNgvaTbhMbIV3WXkB5
 WYJWxW3fZNHmOknsX6uF7FPWm0uVXvfpyyLMXEp00kad0zBUPVhh4nxNJHHcfCnCFgs3
 kRHXZ8VEO5LSCmSJP0+pIoylgfoOtqGQ0Vl188EM2tfRr7wyqTat5tC9bmbvwJwdWXW8
 kKVro8NAtyO99WKkzhDdKLOpPePRW7ceExzLhIJVKlfYDIClt1xcfQLCF1yaO6lJBOmC
 kKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795007318; x=1795612118;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r7iSbd2TueejGnIqUEPWs0leIgatCchC8EEoeiFyk2M=;
 b=Z3VRTbPgGbkxvmAw4GOtOdtbbYCwc/tGgH0eZb7O4ca7nWvrhHb/YPC0x9ph8wlVh3
 4/cfF5NZ6OiLIWJ59iNgMNBhmwL3olCxZ1TdlLbGkSFF0oqHJKHW0IdTiJ+B3R+HttgO
 U/lD3Jj/FgwpbiNgu8mOkk9We7kwkP5ewX4CUttnS15Iy3BE/SRmFzcVQJqoUvm1nwp2
 Gf2PiJ1M34wwuDhtuGGNDzGbf3T83nKAVJNtmFyFZenDSkle35H3SPJFAJIW3ZjL955I
 pa6j4An0goYCgd7XUh4nLynPhgHW9ozmEK87MxlgbmaCE5cI5Y1k8LHwWzdG9GZQ+fxk
 P6Dw==
X-Forwarded-Encrypted: i=1;
 AL+hErEtc1J2qKPo7IWHIs2kchryN4hr8XmaA/PwI5kKfLkzvxORp7k6OwlwM8c8YSwu9ey0c2dzFRgR/qk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/DI0KkjMaGqy/rqKHFmQAm5O4FNecbR/p0nUYOUNOccEScTcOY
 1N9b7FeM2WD342R2TUTJBev22PjSdu8yYCna1JuXGqLj265qaVsdpryh+/lce1JJAZzgYHXid/s
 4Wz4Nb1Z6dFBdOi1cNs1OpPEk2RJ4puYhxlX1cbhr1Q8aKSPZUrTubb4wcodFPLYu422f51c=
X-Gm-Gg: AZFdTZffOT7geRkQp39b1mMdmKEecvCSOjnkaXYUPtFhLvv+9yAJiiJUBTaZLW0u4TI
 MRb62oaDwYA+GeETe918IlPDETbrw1ya9D3LU5RfS3PU5+R9gcwVrRE8INEsXHtuYPDjWSlDd1t
 QToxLDbMj3WZpr+wQfW3+vX9SlrwxjYoAJ7A/CM//OcHEFsFF4dYUqjPMie4U8FxMFRuGe8cWin
 aLw/ST9UI8frWBvAG0Ko4C7tBPVDeHiITv7pb9Rt9XTtwNDK0XyIz39Su78T82+IL5L4mW3qwHn
 QD3Nam6+cxizxtESvwr5DTwlbRQsyoy8cq7xkUuqOB9pHs18e3madebUMc9us4n7uCwBEdlG9J0
 QQltgk3VXEpNMBRr1T0+EQ6H5fZCfWZIKSqIJshKhoMXd+7MAnZ+fibYvMyuY1eT/GSJKQ/ESVh
 olZSiHz5Ck
X-Received: by 2002:a17:90b:1e4f:b0:3a7:fef3:8561 with SMTP id
 98e67ed59e1d1-3b3d07dbd94mr4271672a91.5.1795007317747; 
 Wed, 18 Nov 2026 05:08:37 -0800 (PST)
X-Received: by 2002:a17:90b:1e4f:b0:3a7:fef3:8561 with SMTP id
 98e67ed59e1d1-3b3d07dbd94mr4271618a91.5.1795007317212; 
 Wed, 18 Nov 2026 05:08:37 -0800 (PST)
Received: from hu-pvgtejas-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d187dc82sm4909533a91.6.2026.11.18.05.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 05:08:36 -0800 (PST)
From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Subject: [PATCH 0/6] drm/msm/adreno: Handle unavailable GPU SCM calls
Date: Wed, 18 Nov 2026 18:38:24 +0530
Message-Id: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEmj/WoC/z2Ny2rDMBBFf8VoXQXJGdmSKSX/UbLQY5Sqsa1EY
 4dCyL9XTko3A2e499w7IywJiQ3NnRW8JUp5riDfGua/7HxCnkJl1oq2k1JqbkPBOXPyE492HJ3
 1Z669MyC1iKAtq81LwZh+ntbP44tpdd/ol031lyh4Xevc8oqxCYnsc25o3v/X5lwCP11WyW8tF
 1yHLhgjtOu9OmSi3XW1o8/TtKvnYxM7S8i3T1qGpgdjIeC+FyAMdOCjVkKiV64FJUME5TWgA3Z
 8PH4Bs4/WqQoBAAA=
X-Change-ID: 20261118-adreno-scm-fallback-8cb94180f48a
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795007310; l=3878;
 i=puranam.tejaswi@oss.qualcomm.com; s=20261118; h=from:subject:message-id;
 bh=awtkyavlgGWSAyT66OKXjEU1Y/a4zWSTFO6WDgjxs3g=;
 b=toWvvhXbS/Ng5gSxCqKuAZwLZt9WHZ9GgsEw7XDOrR9QDHIyJqF0l4LHEtvxa2PuQft/9SIvo
 yszVULaBxLhBtZ2UccXL4xWAf5SGb+a5hFj96qD1nTJxRqfnAqzd8gn
X-Developer-Key: i=puranam.tejaswi@oss.qualcomm.com; a=ed25519;
 pk=I7kFxZ7dcroo7ZWUatk8fR/J/KVbRzZq4ZBLhRRGpJo=
X-Proofpoint-ORIG-GUID: CHxNgpxImmR2eJnw2NpL_nzspdfbKae3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfX9aUXMZah5fOL
 IT5nI/Q6mb1CS+TpL8q8s5DweRnKoSSU3EYU/Vi+GScQgIZAo2naOPN2YzDT3vc2h/0Cca34OdG
 mUJlyaNEksXVTLqaZB67M7aHjKhPdkU=
X-Proofpoint-GUID: CHxNgpxImmR2eJnw2NpL_nzspdfbKae3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfXyUQRlIsRZsbH
 0h0afHZupPyzxUKqE0zwLuN3xslWp4vyJmJGbsMuLWyVQ7El14J4P1nRJY+gXRM4WSn+KmpK7/X
 ToqEugWOGSA9nZjC4NaDV6zA4YIlyyzFiuUrs92ppyBUlwMFLpbcaMoybYGwGT7vMGHsTJ/tLTW
 LMA2M4TeSxLYpk1P7XeIFF9eOu9CdKL7GlzdvKGtV1C2RFewxQXt1BAH6hO9yWs+Vx1ezpNmdqH
 dDUfvTQHgV5xG2uLy3yKs3mi9uli7xSnTbJbAxaDgLdh+77a9cUAVV5WlKSGzqxoPA3ppBjfh8t
 s/+55x3+WcfAmo0GS8wohXm7DlzfPSORvWjwbwOBZVC4GDMyPuQwjJwO9a7b14zuAyXoZkBHpTl
 1MCbFK2EFICH6+0v6OOPkgNrhB+6K8ybjltCm53zQLMT+dWv2yvjGzfwxkf7Lff6Gn0x3vf1DVN
 GJw/uZVtdArA8WLKNyQ==
X-Authority-Analysis: v=2.4 cv=NNVAaE6g c=1 sm=1 tr=0 ts=6afda356 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=APfxL9u4uAOGEWhvRr8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180052
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some Qualcomm platforms run secure-world firmware that does not
implement all GPU-related SCM calls. Two missing calls can leave the GPU
unusable, in different ways.

On A750, A753 and A8xx GPUs, a6xx_gmu_secure_init() asks the secure world
to program GPU initialization registers. If qcom_scm_gpu_init_regs() is
not implemented, the call fails and GMU resume aborts, so the GPU never
comes up. Separately, adreno_hw_init() relies on
qcom_scm_set_gpu_smmu_aperture() to configure the CX SMMU aperture. When
that call is unavailable, the aperture is left unconfigured and the GPU
command processor cannot switch pagetables.

The first two patches add an availability query for the GPU init-regs
call and skip it, with a one-time message, when the secure world does
not provide it. GMU resume can then continue. The kernel cannot program
the protected fuse register itself, but it still reads the register
back, so fuse-dependent features such as ray tracing are reported
correctly if an earlier boot stage programmed it, and stay disabled
otherwise.

The remaining patches provide a software fallback for the SMMU aperture.
They describe an optional aperture region in DT and add per-GPU register
lists for programming it when the SCM call is unavailable. The fallback
points the GC aperture at context bank 0, points the LPAC aperture at
context bank 1 on A753, and disables the other apertures. When the secure
world supports the SCM call, the existing SCM path is still used, and
platforms whose DT does not describe the aperture region are unaffected.
DT entries are added for Nord and Shikra.

Patch 1 is for Bjorn. Patches 2-4 are for Rob Clark; patch 2 uses the
new SCM helper from patch 1. Patches 5 and 6 are for Bjorn.

This series is based on next-20261116 and the Nord GPU v2 series [1].
Patch 4 needs the A753 catalog entry from that series, and patch 5 needs
its Nord GPU node.

[1] https://lore.kernel.org/r/20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
---
Puranam V G Tejaswi (6):
      firmware: qcom: scm: Add qcom_scm_gpu_init_regs_is_available()
      drm/msm/a6xx: Don't fail GMU resume if the GPU init regs SCM call is absent
      dt-bindings: display/msm: gpu: Document the CX SMMU aperture region
      drm/msm/adreno: Program the SMMU aperture when the secure world can't
      arm64: dts: qcom: nord: Describe the GPU CX SMMU aperture
      arm64: dts: qcom: shikra: Describe the GPU CX SMMU aperture

 .../devicetree/bindings/display/msm/gpu.yaml       |  3 +-
 arch/arm64/boot/dts/qcom/nord.dtsi                 |  6 ++--
 arch/arm64/boot/dts/qcom/shikra.dtsi               |  6 ++--
 drivers/firmware/qcom/qcom_scm.c                   |  7 ++++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |  9 ++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 27 ++++++++++------
 drivers/gpu/drm/msm/adreno/a7xx_catalog.c          | 10 ++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            | 37 ++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            | 21 ++++++++++++
 include/linux/firmware/qcom/qcom_scm.h             |  1 +
 10 files changed, 113 insertions(+), 14 deletions(-)
---
base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
change-id: 20261118-adreno-scm-fallback-8cb94180f48a
prerequisite-message-id: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
prerequisite-patch-id: c05f94606aaf87c23ee9f615c2c003fc6a76ee58
prerequisite-patch-id: af5ae392810d6e5e6faea17f4de1f2d067894d37
prerequisite-patch-id: 9b506be1f9a910d8da57d14d42d45ab2a2a52fde
prerequisite-patch-id: 5c8cbb1bd55d50d3f816c0ddf9c2edf7c7ec4195
prerequisite-patch-id: 01f6f94a2887d2217b5e27b84638f8ee375070ee

Best regards,
--  
Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

