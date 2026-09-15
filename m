Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50369C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E59810F3AF;
	Tue, 15 Sep 2026 09:28:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZoGFAlzi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DF00x+Y6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C651810F3AD
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:28:01 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F6Zgwl3126518
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=dwbltoz28/icpViL8WHNMd
 s2UytK2mXXode9Ychb5S4=; b=ZoGFAlziyitaTgGpu65LmxS0uRwG2cMA71LkoX
 x0tMBvewaN8k7Q0bxYZaR9zcRESzLpcEvmpX0qeOKuhxZi+NDIxY2Ftkcscaba0z
 57LBiewrups+gasJKhB70tEc6E6ULLIVa+0vDvDVvZntL5doZK5LizlfwxDDgJ3l
 XILpOnrYgBV9qcrpZoHjH/oBNFTDM3GF3UH+SrWUXcgy7BWGBzy72XC6UIgagQs4
 s6uje1Gy5oFbIDoMkRnHytetmdwuQQSaA1vKkfQTLUhezLDzpFDTBl7AJtb6Bwnz
 VLfRDbuxvSKqNCNML5rCKl9tXwHoyuY2trMCsmO5eDnsRsQw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpmx9uqe4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:28:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so437356085a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789464480; x=1790069280;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dwbltoz28/icpViL8WHNMds2UytK2mXXode9Ychb5S4=;
 b=DF00x+Y6SlMeHbx633j9vPs+9kYVauaTlfYcr7q1f7IMuXiZ3c2qau776YqfW/INDb
 sj7giKuc5zVmION6Ut9nO9j6ATevHUmEPBGvwtS7T2PVggFj9Squ/q1/Uu7XDqIz3Mh5
 NbKXqvOQfMaHRKc0tE0/lrA0p6lToNE8mB7qCcylnMYXMvlpnudnmi4eHFPv1QTco3I/
 MxxU+DqEPOKqQM/azr1qdyYpp2HQh06jTSblA5huWMS43Wbxnp+siKPYkVeEUfMVSFwS
 8j8n0l9bXsiRbIMbdnTxhzhlOMwf5sneOAR7+XAOUJEzaNs0MsO8ATAwqYvLTNMEziP5
 tZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789464480; x=1790069280;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dwbltoz28/icpViL8WHNMds2UytK2mXXode9Ychb5S4=;
 b=w2rI9ck6WgGCKykkn4Cs6jnYW6B2U0SbsfObq/toyHIPbRYvzn/jLNC4PszoL/cZ7u
 67HPDLTLcQjdyi5ogDbvjZz8mS1T3z+QKZyFO+vMx7aw0hvh4zjAwnwJYOIst3yxUzho
 cJXmdLURfJC4dlgTHfTLvMhmP2S3Az42DxSEU+VxCFULqdNr3hpSQrTiiAzN3EAJGb4+
 /nSjkope/fShkQ6TUDKAidJiTJLTFapezovwnqtCY5r4t6Pkpv1zl/e/Ss/rDOiTmUXI
 81rSDmtAbfxQVSSbE57YerLEnkn5wSKCgSwHLxLghn2D/2T6BaiMc+WDSaF2c7Y2WzUV
 yWiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByNqD1SrPbVxHIUteOlO7NZ8uV3EEup8EOP9o0YlvbvNwLShF2XFP3dIzdV1L2oeDRkjyHQJ9y875w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k8mwbtnzRS5Qb1z1LBzB6OMWI+/FbmGbk7S/Xo0TYLj9KCzWWN
 BPLeN2Z/Lhf7Yi+cK0z52ybJtwoev5qPgxy0xlKiz95ftVPu21L3UuGLFxWTPhAdXKOlkAkQ2CJ
 LhcRyCUMD7d8HEium19fynF3kYtKU7/kqHO2y1PT7n1rKG6pXYxa029O4txOcziOBFqXxRWw=
X-Gm-Gg: AYBFou08yg7qJJrQWTTp4zEeEXFDKWk52w01F356DT9NSUZbdhQzaum2t0PtNziRHiu
 6qbAf6G+ic4TpFIKZd2WKCa4Jl/p8YWv7HVv1cWHHZA9bGv75sx6rD2+suO10x2Q41kBfkp5nrp
 Ic6VnzLLIQBHOuJoUDfarMAsLUgAsUXbT1U3OqwUeF4F0FU6iwRg3FZDrHoGiAOdLPSLnUjRwEr
 Rr4IF9N9PoYGxRU0qUZL6Q6RaNACXKgRwVk807tdDqEwRajbhDf8ro1fhzMbkbs8TuhLlv9flo5
 yr6iBI7IhQLyFAvW3KBluspKMZMAMuAJlawvLqkNbkzwaVUC+BXuanvFy7goTjh1NTKRgR7XEeD
 CMqTAnG0huu9mNxMGOIC91dWObKWWfQE9zA5vnrdY1va5VWL8/j8lB0h18xuSOgI=
X-Received: by 2002:a05:620a:1a28:b0:939:ff11:5338 with SMTP id
 af79cd13be357-93a29a14534mr962823785a.40.1789464479739; 
 Tue, 15 Sep 2026 02:27:59 -0700 (PDT)
X-Received: by 2002:a05:620a:1a28:b0:939:ff11:5338 with SMTP id
 af79cd13be357-93a29a14534mr962818785a.40.1789464479293; 
 Tue, 15 Sep 2026 02:27:59 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93a3f467566sm18939785a.39.2026.09.15.02.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 02:27:58 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v2 0/3] drm/msm/dpu: Add INT2 GDSC power domain support for
 Kaanapali
Date: Tue, 15 Sep 2026 17:27:47 +0800
Message-Id: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJMPqWoC/22OywrCMBBFf6XM2kg6rUnqyv8QkTwmGrBWM7Uo0
 n831q2bC+cynLlvYMqJGLbVGzJNidNwLYCrCvzZXk8kUigMKFFJjVL03B9PgT0K7zpspERtMUC
 5v2WK6bm49ocfZ7o/inL8leAsk/BD36dxWzkirZqwiU1bu67zsdVoI7mNNKHtjIkKrfK2hq/rn
 Hgc8muZOdWL7M+iqRZStMpoo1RQ3sndwLy+P+zl+3RdAg7zPH8AH0qKE/UAAAA=
X-Change-ID: 20260720-msm_gdsc2-cb9230027a2d
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
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789464471; l=1690;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=tS5jYHAOJiHwqtVjHphp88eu6y5+S+EodtZQBgori04=;
 b=7tl1t99L/eer1X7h6G9i0YVXv+uuiXjnDmBy1pJtQsinRKG6Wz0LgXvJ6daGyiR+PmRG70xN7
 AYrKFQ2cdNoCNBkvUufsDR+Gng9T4t6C5nSDS1KqOcHYRTUsWe2eYAz
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=G+KJgNk5 c=1 sm=1 tr=0 ts=6aa90fa0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=smZlIRouz1c8XS0CwesA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEzNSBTYWx0ZWRfX0wB4RHIgofx8
 xYlct8NfTGrJH3T9BQJ2l3azvZZ5g9KrXGQssrvVSutyjWGFF0UTYf5fia4UzZe8X/VqKD2cn2L
 HgA1F7bbY4XeYvP2dbpnAPVyiuzhlc06oQ/Bh01s0U2xwcJNnKMfdhsHAsbe9sTH+sr99uuiGwX
 HmxwMo3Ayg1EjI9iKd1+tG+wwvmKLCnG4qLYO387GV4c5KRKq4cxB0+OPaowiNoJv6Q1pf37lOb
 2JU9VNpuz/OVTkSGY+hiIiX72+uv82yJGGysosteO533Wrhtx0qydS3HMJ8C3RpCkTO2+jlmdOt
 jTzZ1JvPbk3LW3huz26UPXoTRa7SdBdvcOWR8d3zcjyHoMkoowTsIm2J/XcINFsEfDKDqExHol2
 ArO2Z6zTB8mMeVx8v9IOWncYkkbBOFxH58d/tm2eGxhmHkcmA5Mbpw4cl63FyN9zzlgxqjkQmWi
 gKeb2hnx1cfMZYgVltw==
X-Proofpoint-GUID: 57Bc-PokfSJRvisXcTsRQ834_jOMpf7Z
X-Proofpoint-ORIG-GUID: 57Bc-PokfSJRvisXcTsRQ834_jOMpf7Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEzNSBTYWx0ZWRfXzd7/zLbihF37
 nE/+xJ1lV61R6a1no7BFmt2mw78YeVFq2CH1OI2vcZtHC5WMP3R3PA03T6H3dutP3/csziYoM9c
 oyGJO7NW4viP2x8hbKr8gUvZxxoX0kA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150135
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

Kaanapali (SM8750) has an additional INT2 GDSC that powers a
subset of DPU source pipes (VIG2/VIG3/DMA5). Without enabling
it, those pipes remain inaccessible.

This series adds INT2 GDSC as a second power domain on the DPU
device node, updates the DT bindings to describe it (restricted
to Kaanapali via if/then), and attaches it in the DPU driver
alongside the existing MMCX performance-state domain.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Changes in v2:
- Moved INT2 GDSC from MDSS to DPU, as it only powers DPU-local source pipes (Dmitry)
- Dropped Glymur — only Kaanapali actually needs INT2 GDSC
- Used if/then in DT binding to restrict second power domain to Kaanapali compatible only (Dmitry, Krzysztof)
- Dropped PD_FLAG_NO_DEV_LINK, let device link auto-attach handle INT2 as runtime-PM supplier (Dmitry)
- Link to v1: https://lore.kernel.org/r/20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com

---
Yongxing Mou (3):
      dt-bindings: display: msm: Add INT2 GDSC to Kaanapali DPU
      drm/msm/dpu: Attach INT2 power domain alongside MMCX on Kaanapali
      arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU

 .../bindings/display/msm/dpu-common.yaml           | 19 +++++++++++--
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 23 ++++++++++++++++
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            |  4 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            | 32 ++++++++++++++++++++++
 4 files changed, 75 insertions(+), 3 deletions(-)
---
base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
change-id: 20260720-msm_gdsc2-cb9230027a2d

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

