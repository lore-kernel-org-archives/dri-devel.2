Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FE7CD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 10:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5376010F53A;
	Fri, 22 May 2026 10:12:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GeyoKsJL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Za50Rrgu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B659A10F536
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:12:32 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M5sXPp777027
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ygzXnRmnIfi9PfYTeE5iFb
 e27GiW5AXsmvzhwk2ysvQ=; b=GeyoKsJL9AsFkrxFikRPNe3HPwuc2BB+UxDYAU
 VnsEI2Pni8YvCbejT4sOZr3ukWkukbsi2Y87g7L9O0qXX4F2QbpAzxS+rKpAWo5m
 sjr/D6EP4yB/+G9x5/FqLbn0w6f2h8lOVcFvFejj8kFp4VnnNSIm97we2HRFFv8s
 Y12dlxs8RnEjZF8dmNQXVG/lnZOFKvGstQKsY49NAo5Tt6FKZD4ogJx6q0XQEW6F
 3iJKsgka3W4y3C7nKJNOmV6z6uUFPIn9gNGBShys1OMBFCfWdCqp5cZ0c+Cj6MGQ
 XbhyMWnzwU41gPfOpKyEjCuk/m/CQMVCVwUfYxNwiCrMTPLQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea94h308c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:12:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-367cb6de61aso13012457a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 03:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779444751; x=1780049551;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ygzXnRmnIfi9PfYTeE5iFbe27GiW5AXsmvzhwk2ysvQ=;
 b=Za50RrguTvCovvI5GFKzh/l20f5949LJZY1xsS3g5tf1Ilt6W0bDC01Fe0ARlEe+ei
 g4e1Xz8CPZm6BV2WT0GiylXIiQvWepkk0enb7+oV4ZbJBQr2BPllQ7xgbIPe7NciAANv
 nJP7Xd2Hin/W4tZIxW4jnwQHN29K1ncm6DxG7mQX2mH3M/i8TM8pi9vJqHtFC5nCJCk2
 8Jhj4pYe1aFm17jrZSdM7vFg1arM0Lp4uEmqIr8PeXkB20p/zWJK+T8Eo6PVHrq3TKBO
 xMVZYq6CiGzKF1mLGhq07wOXTO62/5MSLr+1Ftq47aclGY28d4iVixV6Fz1mJyJez0AQ
 ziCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779444751; x=1780049551;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygzXnRmnIfi9PfYTeE5iFbe27GiW5AXsmvzhwk2ysvQ=;
 b=Z5wGbgAymqgsIZk1t9Lp7dgkSg6q2yUJesOKLHueNZJSUHRc8tqces/nKisyz6tI20
 jgCYZJsKi2/QyLaojrSlO6TMGO9t8Y23wzeUO2ExhDOVpvo82ztxNLyX2NeUc3voDxW3
 ZDoyK267ThECg03/UaCAZYWBw9fW8UR2L8K5NLRjDlnWDJHEDd0iuLgfvzIae85jgm1b
 25rv6oJtWLPzdxYBvviEegj42VcuFzs3tW+UO0wSuGSMIXDsb63sInxCi0cTzdcEYNB/
 6d68Dej2FPp91ci0khxMhTkmWFnAS+y81OKmlcesMatx3GUql42ZPDpBz698EiGdhotu
 4Ijw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9o1GkBTHaw7+V7mgYD36uKXzt6DsB0DqpoBCydXam1ixxwWSq8cvtHjvnzW8K4Dd9569fuF3dkbeY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWCHfeo45Rob4r5g0NiAihXIwTWknzAA6eRZ6Qfpiur0gZaUZ0
 WhuTdVRKfevu4c4/BXSftS3GaE3C0JCn254FZCgxpiIGq4k+RgRq7G7fsaJn645CdFjG4swjYop
 gn4R7KELR7GlmIjcb2kAUWV8ZI0qN5ih2bsFNiNMa+6+I53qVZkdSKOuowSuORW9mKtjEmZ0=
X-Gm-Gg: Acq92OE7KIeM8jWIgCK83JtCoFpW1qdZmUZKKnFRpEFCEFgKpZ/nS20D0QpFGFF1Q6r
 qTIG6kL+Zw9MpSmqnNyoSJVKJTI3wWt8KyR+UFMC0frbaTS3HOjDopt8KZe3AaAqL2Wh17X1nE4
 /2dTfCt1XPCKR1e+X7oM/iuogujQzFsGI6/IGBsCW2Ld3yf0vRF3IrV6d0WOxUEdyrRKtX02jgK
 u38B+3hNChvW4RnlznB1HOqoAdaSY3Y77Z4J1C3SjDSbqDs7TxiRsxsBd71d0dZMfaJYk3AvVRZ
 xqUN/DPBDmlK5U0OHm2ihhxtlck1SbAmPCPj0wUvMZKexfpKT7MKvgRNkDZPkGu8FCTKX25y7W3
 V8R+P+Jkh+/WqmXKZ90Jcty1WTtVqQtvaTD+Ps0t6Gxxf0OquanjD8uBl
X-Received: by 2002:a05:6a20:d709:b0:3b3:c28:45b3 with SMTP id
 adf61e73a8af0-3b328e4f8d7mr3008449637.26.1779444750735; 
 Fri, 22 May 2026 03:12:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:d709:b0:3b3:c28:45b3 with SMTP id
 adf61e73a8af0-3b328e4f8d7mr3008398637.26.1779444750288; 
 Fri, 22 May 2026 03:12:30 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85202b4442sm1143498a12.12.2026.05.22.03.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 03:12:29 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v5 0/5] Devicetree support for Glymur GPU
Date: Fri, 22 May 2026 15:41:56 +0530
Message-Id: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOwrEGoC/3XP4WqDMBAH8FeRfF5KcjFOZYy9xxiSxNMGGm2Nh
 pbiuy/qYMWtXwL/HPe7uzvxOFj0pEzuZMBgve27GORLQsxRdS1SW8dMgEHGADLanm5uGmh7nmg
 9UiEKlKyItUyT2HMesLHX1fv82vKAlymy4/ZJtPJITe+cHcukw+tIVzoVbOl36L1ah5bJ21bg7
 Gdm5ZwxVT1Wpu8a21YBaBCUUWUMFjVnGb7CR+/94TKp0zLhEJ93sqxxtH7sh9t6ZeDrHhvO5O6
 gwKMIXEjUnBuZ/RVXMMAvIhnfI7AgDYdcS1lkWj9BxAPCYY8st+UpCKgNcMPEEyR9RMQeSSPS5
 CIXYIQ2hfoHmef5G/eD6xwHAgAA
X-Change-ID: 20260226-glymur-gpu-dt-339e5092606b
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
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444741; l=3476;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=kTZkqQMBsGBq0RgXdzBTEek0U9w6bkU5wpcpKO9PBwQ=;
 b=CHtXeQDP4hxrxwaBHy1GmF0IPY/324K7voescovnfbeHnVyH79TDAQ2nGYRnw6OvjvF6xeUS6
 9+M9+HCmwDFDj10U5kVChHguRZKqP5hOlDjVnNs+DcPMbLlLdR2EKjX
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: SSNFnwPOqAxkGWLYSvVvS7NkleroPOXp
X-Authority-Analysis: v=2.4 cv=QblWeMbv c=1 sm=1 tr=0 ts=6a102c0f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-08r9DDlpfC4vgu8VQ8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: SSNFnwPOqAxkGWLYSvVvS7NkleroPOXp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwMSBTYWx0ZWRfX+JOz/4axkz5Y
 lT9ADFzutUVckidVumqZmdBDIKX7FTuNOJpyp9tgEEFQEtc9gW1HINBYRIlZ5/LmxwkvFHieuDV
 K8Pn0IPghmWflLrDRaVCOESe1CcwGqVOu3HHosNPu63KPv4c0M63PmJWXttLj+t7x5GnK3zSmvc
 pA9l1B2x65a0bi3IuP6iBLuO8SRAXi3DWA8uK6zAetSVjIdU721NEl1/dOQCd8HnENCzcu5sPsX
 WftnQP6LZ964RTFSvWfKtzrCe2uBhlcT6YQkKXrO+drhV/sv+V3ZTrdA9580QbqHCvdzpVsx6Bo
 LWaKxJj2kWr/Tk5XN5zWYysOtDERq4bjMWA0xlOP4Bu/zu2uz3B7mOjHumDPvTy0O7j/2ksUUIb
 HDSs118KY3ZS0mtyfETn7iyOALXEG4PnRJmFR4jkPuAAR8ZiQzV+0cW/C48IAX7VQ9yq58Z+PB7
 aWc5XAp+q/rhaJCiLaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220101
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

This series adds the necessary Device Tree bits to enable GPU support
on the Glymur-based CRD devices. The Adreno X2-85 GPU present in Glymur
chipsets is based on the new Adreno A8x family of GPUs. It features a new
slice architecture with 4 slices, significantly higher bandwidth
throughput compared to mobile counterparts, raytracing support, and the
highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among other
improvements.

This series includes patches that updates DT schema, add GPU SMMU &
GPU/GMU support. Keen-eyed readers may notice that the zap shader node
is missing. This is intentional: The Glymur-based laptop platforms
generally allow booting Linux at EL2 (yay!), which means the zap firmware
is not required here.

There is an update to the gxclkctl/drm drivers to properly support the IFPC
feature across all A8x GPUs. That series [1] is necessary to properly
support Glymur GPU:
[1] https://lore.kernel.org/lkml/20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com/

Just FYI, on top of the linux-next, I had to pick below series [2] to boot
the device properly. But it is unrelated to GPU or this series:
[2] https://lore.kernel.org/all/20260331-qref_vote-v1-0-3fd7fbf87864@oss.qualcomm.com/

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v5:
- Relax contraints for reg-names property (Krzysztof)
- Drop the smmu binding doc patch as it got picked up
- Link to v4: https://lore.kernel.org/r/20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com

Changes in v4:
- Add a new patch for passive cooling support
- Link to v3: https://lore.kernel.org/r/20260512-glymur-gpu-dt-v3-0-84232dc21c03@oss.qualcomm.com

Changes in v3:
- Add a new patch to fix RSCC base vaddr in drm-msm
- Remove interconnect property from adreno smmu dt and the binding doc
- Add a contrait in GPU binding doc to limit the reg entries for Glymur
  (Krzysztof)
- Link to v2: https://lore.kernel.org/r/20260501-glymur-gpu-dt-v2-0-2f128b5596bb@oss.qualcomm.com

Changes in v2:
- Keep GPU/GMU enabled by default and drop the enablement patch (Konrad)
- Drop zap shader node from DT
- A new patch to update GPU SMMU dt schema.
- Adjust reg range in dt nodes to avoid overlap. 
- Removed cx_dbgc range as it is already stable across chipsets. This
  region is now part of kgsl_3d0_reg_memory range.
- Link to v1: https://lore.kernel.org/r/20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com

---
Akhil P Oommen (3):
      drm/msm/a8xx: Fix RSCC offset
      dt-bindings: display/msm: gpu: Document Adreno X2-185
      arm64: dts: qcom: Add GPU support for Glymur

Manaf Meethalavalappu Pallikunhi (1):
      arm64: dts: qcom: glymur: Add GPU cooling

Rajendra Nayak (1):
      arm64: dts: qcom: glymur: Add GPU smmu node

 .../devicetree/bindings/display/msm/gpu.yaml       |  16 +
 arch/arm64/boot/dts/qcom/glymur.dtsi               | 461 ++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   7 +-
 3 files changed, 427 insertions(+), 57 deletions(-)
---
base-commit: c9bd03db3e792a99e9789fde20e91898e3a29e8a
change-id: 20260226-glymur-gpu-dt-339e5092606b
prerequisite-message-id: <20260410-glymur_mmcc_dt_config_v2-v3-0-acce9d106e72@oss.qualcomm.com>
prerequisite-patch-id: f7ab29f2f0241b6536d3b0c0593f0baa0e435221
prerequisite-patch-id: 56c830b7718129323b006e492aed9822d7c30079

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

