Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B50ECD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C110110F0AC;
	Thu,  7 May 2026 13:03:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RWB9IAfQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vr9DsTtu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF7410F0AC
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:09 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647C5WmN1971666
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=yP6BlX9MTBbBZXOHamFcqp
 o/Q6taTCzMdwFPHVrhtZ4=; b=RWB9IAfQWOYiQVR1Maa7/Uk2/qhRacq86MZdkk
 6zf2NNK0f+6NdKoAsRVe/qJ16VD5oGoTPZzLSsKHuJYUvzDbedIbIxy39Yl+L3sc
 Ytes4qpjabmGLlH3TFfPtfWkipQv9JkYZyrzlffriLXOROAxiB0m5yBBrJqv0pDr
 7pzgx1pek30J2uB74OeAuHSdP9ZiRUqafRAMkP+4U18ceN6SxwOuwB8DtsmckYeE
 fGxOU3lgxe5zwLiq3OX+6LBvfgCsV/z26LJ6r4PBD3z6sjrse0n/98r8sWBD+exH
 gUYwEQNlMuLuS6mXERpMfP7xZWz01b5n+IpbJwtcrnsPbDYQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tej869t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:09 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c7985752be1so398054a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778158988; x=1778763788;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yP6BlX9MTBbBZXOHamFcqpo/Q6taTCzMdwFPHVrhtZ4=;
 b=Vr9DsTtukFq8B8AkisMACkiTFmKxi3dPDdv+67qcFYFJjAISBQbQIXWV+Az1SWXcEB
 mL/CIJdz/Qr5HiVkoEoEZWK0fDavFll25TNSSiXohxJf9XPqyFED1yoEm9F2dZY4Sw0V
 tMVj8kf5hgbv5VedsK90PCUKdCUyAlQrKB4Nn/s7Klj3JFmjaVB1xH1yhEP0r5cwQRqb
 wyfQhY8M7nX6oWJ6aqN1iTFgtK06t8XG9zrH2zQWKYCTceY8krSxI8SleBXSFNIXsMSu
 mkWtpLYNHsGE6h3xxWvowymOOK0gVyfyfpHXxE3LH+0SWGrx+NodYFxmJm820w7jAFJ4
 KVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778158988; x=1778763788;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yP6BlX9MTBbBZXOHamFcqpo/Q6taTCzMdwFPHVrhtZ4=;
 b=XageuLHTwFkku4zLAEfneUY7d26H7HN9AVC9/OumMFq+rclMy6i9ga+MZ3YkO8s8ZI
 EC9TEWiyC0estFjaZPycomn/VyMghNJPjebNhMTwQY+Qt5crVrSt04mlQRhzxjLwFqWR
 nUm/NU702vRuuUufLG95x0jKdBJJS/RSpTwfiuKCn4yc9oAgRyyThknlQNB0I8FKQdQ6
 HrJmnpTJH454kAF0ovxvvJr1vyMAc9Tt8w/l5cfeq2KfMVs/grQWWn2XqgW+jvwr8gjq
 /n68waYFdWtWYUC18iV92nw5G3IkQVNyDthtbAqpLPIDxc6qqKnXUxubClofNGPnjo/6
 yOIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/rRMykQBjk8OvFDs2RT17SQStSPvhDUqUe6kzdyhKALOtf7LGAzHuid3b1uMMy843IID3G1PVbPw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFdYAieYpAAfA9WyxDKXnulR4BKHvPA4+s+yWjJTg4e/vd8Oxq
 4dtlJoeSjM4AtR1zsX99k2lsu0ciBxNEXXF19MyXTdysqVd0ULM69Ps2hARZG5ocT1SpzU2rPs5
 QHGiK/yCM8qmG6tEo+MNQ8tMw8GAj2138eQIiS5cCoA7OPbWMa5HeaYYXd4IEOe78TVggQ6M=
X-Gm-Gg: AeBDieuFG4bFYnhM2qHd1yYBQxI+RD7I02So2oBHsEumNKeXQFmJb99dD1E9j18hsjg
 jjX2Z1erhPzko+I05niIEZGeuGbUGStDnoYpkHw87HnqJxrGGjPholc9PS261ZMW85C86SSLjD9
 5tfJVZ31QSprdv2rifnjPUCzsm+4XlhmDta2x4Ip5teU14lau0Vo3Cc+TotruGH83l58WIQvRL9
 tPas26NzawS/29F/5ubAcvdXwY0r+x/+TtazfxyfrdeLJfUDI7E6gmqgja1Wf4RUHrQTnmNCOa6
 rTEXtG/izCFbwuMuReceMXZmESYca27an+GOyXDwECfhJtjiW3ma55YC1NSEpvEGSTj1UPcsGQ8
 t88Vp/leDHK0vXYRXUkMjlhATiOf4330tvLAyTlcMOQ+8XpqbXpfEiVzrZI8GYtXxq4G7hYqGzg
 HWMbfxFBj/JU+59qxhjpmR5tZbrUlJbIfg8j+rIKSgmBt+ug==
X-Received: by 2002:a05:6a21:6da9:b0:3a3:a894:327b with SMTP id
 adf61e73a8af0-3aa5a90d7d6mr7807743637.25.1778158988128; 
 Thu, 07 May 2026 06:03:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:6da9:b0:3a3:a894:327b with SMTP id
 adf61e73a8af0-3aa5a90d7d6mr7807661637.25.1778158987441; 
 Thu, 07 May 2026 06:03:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v4 00/29] soc/qcom/ubwc: rework UBWC configuration database
Date: Thu, 07 May 2026 16:02:56 +0300
Message-Id: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAICN/GkC/3WPzU7DMBCEXyXyGRf/JLaTE++BOPhnTSxIQm0nL
 ary7rjupUWwh5Vmpf1m5oISxAAJDc0FRdhCCstcRPvUIDvq+R1wcEUjRpggjFK8mpPFEU5L/MA
 gLFCnwHSMoPLxFcGHc6W9vt10hONaoPl2REYnwHaZppCHZoZzfp50yhDrt852LHZD0xkrXRnSe
 +tM6zveetUKpQ3XrqNSUSEkEQJdTcaQ8hK/a4ONVpcalhPxEHajmODeeuc9ZZ4Z87KkdDiu+vO
 a51BWxW3sDvGr78YKQvReUuWZprb/B8HvEewRwQvCSFBeEUKl0H8g9n3/ASEVBSmYAQAA
X-Change-ID: 20260211-ubwc-rework-e6ce1d8eb520
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4306;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CO5tfN+499tvaXP1CHeXqw4zhbrG7t+QQHj1USl4veQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2D4TCvj69nv3UN3jfpQZjSuIJACa9tIg1XV
 nOK8917u4SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNgwAKCRCLPIo+Aiko
 1Q7aB/4o6BEVNYS4UGGq+RiCbRTHtktv31BwHBNrg/PCHeF68kntmlzTPGgbrO1Y4EwQzMXJmcc
 lZK0ncPfwv8Vr9wKQUORvADfzipJ2iAbKUDZjRY9OfwcjRP9CY9mURSiG1/2GshDfmNil/eGzHn
 iBwk4dC+x5i57uvTiyr4qLNbadMXcaguN+G0heW3UXMDJzi2zTVgXYKw9wa1MxwfawjKKwF25Rv
 uarCTuozEmnpbeEEzGN8LS71lmu7hJ+PNoIz8oCs2cclBA+OhT8qoCHJh+9e3cv8jDw5YZ2L8jt
 eF9ZiFn/8C1tUV9qUTG8Q+glOxqq0PGJyjO9AndFUEL2xXiW
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX1z2EPqQ7FIGh
 AUwaHiQXtTNzJCxY3m5ZIeFTR0B9pFTF31j1PN2zAxEsKqmfKHib3nlEoP9cpeUiKoVYwbusmZS
 DTH0/UvRTaEOm5IlDmFZpKsLoNtawGS2TzXKt7fp186hx5MoZ0JztyzaD3qzwg1H+Imq24ilX2H
 Cvo3bWwgmCNT/+FdGISxYUU0xFXsXe4YDjjc9CM83b8+pV7M0wGC/ZBJtpb0cqvhykRSqKwTDqc
 cQFdL87ZGyXVP0rBqwWVipYFS1dwtrVh1XF847aVAkPmDB2SrSLAmlGD5SViqw/cq/PYoy13zme
 4pI/t2LWYW2eFYVWTbFCV6GVLsaUrv01J4btdJEj9tkPNPED0Rc6FKm6eN3xW/vJHNEbUIkWcCU
 qHvJWLd1A4/DrkG4nwfB4NTr7g6LeasneQfEXW6VJS88fOppK8WBPmWuE9a61TnxDMuwSRJveRY
 kX3j/r59+tuZTIYjWow==
X-Proofpoint-GUID: 3uDFVS6Gmg6PZk7IL3mQ3Zvur8dPQjQY
X-Authority-Analysis: v=2.4 cv=VNbtWdPX c=1 sm=1 tr=0 ts=69fc8d8d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7hJuk1173Q_9pT7ms5cA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 3uDFVS6Gmg6PZk7IL3mQ3Zvur8dPQjQY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070130
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

Currently we store several settings in the configuration database. Some
of them are incorrect or not completely matching the expected
configuration settings. Others are directly derivable from the UBWC
version. Rework how we handle the values in the database, trimming it
down to the UBWC version, HBB and several flags.

The series includes patches for drm/msm as well as for the soc/qcom. My
suggestion would be to either create an immutable tag for the first
batch of soc/qcom patches, which we can pull into drm/msm or to ack
merging the first patches through drm/msm tree directly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v4:
- Rebased on linux-next, dropping merged dependencies.
- Reworked A8xx, simplifying several corner cases.
- Link to v3: https://lore.kernel.org/r/20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com

Changes in v3:
- Corrected UWBC_STATIC programming for MDSS 5.x platforms (Konrad)
- Switched MDSS 6.x+ to qcom_ubwc_min_acc_length_64b() too
- Added qcom_ubwc_enable_amsbc() helper
- Reworked the DPU handling of UBWC config, making it simpler to handle
  minor revisions.
- Removed the comment regarding the best guess for min_acc_length
- Link to v2: https://lore.kernel.org/r/20260311-ubwc-rework-v2-0-69f718f2a1c9@oss.qualcomm.com

Changes in v2:
- Renamed MDSS UBWC programming function to make it more obvious that
  they are related to the MDSS revision rather than UBWC version
  (Konrad)
- Brought back the patch to use qcom_ubwc_version_tag() in msm_mdss.c,
  got lost in rebases (Konrad)
- Link to v1: https://lore.kernel.org/r/20260306-ubwc-rework-v1-0-9cfdff12f2bb@oss.qualcomm.com

---
Dmitry Baryshkov (28):
      drm/msm/mdss: correct UBWC programming sequences
      soc: qcom: ubwc: define UBWC 3.1
      soc: qcom: ubwc: define helper for MDSS and Adreno drivers
      soc: qcom: ubwc: add helper controlling AMSBC enablement
      drm/msm/adreno: use qcom_ubwc_version_tag() helper
      drm/msm/mdss: use qcom_ubwc_version_tag() helper
      drm/msm/adreno: use new helper to set min_acc length
      drm/msm/mdss: use new helper to set min_acc length
      drm/msm/adreno: use new helper to set macrotile_mode
      drm/msm/mdss: use new helper to set macrotile_mode
      drm/msm/mdss: use new helper to set UBWC bank spreading
      drm/msm/adreno: use new helper to set ubwc_swizzle
      drm/msm/dpu: use new helper to set ubwc_swizzle
      drm/msm/mdss: use new helper to set ubwc_swizzle
      drm/msm/adreno: write reserved UBWC-related bits
      drm/msm/adreno: set fp16compoptdis for UBWC 3.0 formats
      drm/msm/adreno: use new helper to set amsbc
      drm/msm/adreno: use version ranges in A8xx UBWC code
      drm/msm/mdss: use new helper to set amsbc
      drm/msm/dpu: drop ubwc_dec_version
      drm/msm/dpu: invert the order of UBWC checks
      soc: qcom: ubwc: set min_acc length to 64 for all UBWC 1.0 targets
      soc: qcom: ubwc: drop ubwc_dec_version
      soc: qcom: ubwc: drop ubwc_bank_spread
      soc: qcom: ubwc: drop macrotile_mode from the database
      soc: qcom: ubwc: use fixed values for UBWC swizzle for UBWC < 4.0
      soc: qcom: ubwc: sort out the rest of the UBWC swizzle settings
      soc: qcom: ubwc: deduplicate UBWC configuration data

Konrad Dybcio (1):
      drm/msm/adreno: Trust the SSoT UBWC config

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c       |  11 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  93 +--------
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c       |  50 +++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c     |   4 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h     |   5 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c |  39 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c   |   3 +-
 drivers/gpu/drm/msm/msm_mdss.c              | 120 ++++--------
 drivers/soc/qcom/ubwc_config.c              | 294 +++++++---------------------
 include/linux/soc/qcom/ubwc.h               | 103 ++++++----
 10 files changed, 235 insertions(+), 487 deletions(-)
---
base-commit: 735d2f48cadaa9a87e7c7601667878de70c771c5
change-id: 20260211-ubwc-rework-e6ce1d8eb520
prerequisite-patch-id: 5bc7dddd09fcdb4f534f8468ab3ad51781667066

Best regards,
--  
With best wishes
Dmitry

