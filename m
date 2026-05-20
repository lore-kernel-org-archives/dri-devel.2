Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA46ACD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F3010E3CF;
	Wed, 20 May 2026 14:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hXQAb0CX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UKY2Zh//";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A2E210E156
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:27 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE6Sem118975
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zBklFj2t+5xCEM6rp+gL3G
 mHPa49NsPXvTRHaBqJpUA=; b=hXQAb0CXKBABwtcmRVYq4ZGW57hf7xYwa9Euhf
 S1IG4f476g6lfudWBs9nGfjUT6nqYgktEHrWDk81/yXn9Oc99K2CVTBm1AyQiYtB
 XZQjEgLVS0inRe0/+Qf+SM6V9lGzgFOACqq/drD0QtI+eFenyDCj9jLy8eeQRfFK
 k1vFZOstQZdq/fxUIzBQFvH6OLsxzSxg6TrbB8hB+jX2atdrX7QMJ0oFW6OEszA6
 Fzxqw3KaNwyiLnHCX7uHp8L4fQcimOI4/nwCFDmp2YxTqLHoiQY2FLktC7ap85Bj
 kQr/f2BLNQRzJo0LUJu64Y6bxOf4MB9qg5ir1EPTNd29DtXg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee886d7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:26 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-95d1fd7dce7so1965186241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288685; x=1779893485;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zBklFj2t+5xCEM6rp+gL3GmHPa49NsPXvTRHaBqJpUA=;
 b=UKY2Zh//Jbj3HcbmsVToEDd0D/WA1swlHqcTlvNLkBdQzpit3lUqZEUqLXrfjHV2V7
 tDpa2rBS8qam5A4ajpqyS+FyTM733Y4HNCFC1Mk4QJ9zTaCClpATLXmK8oJPWqpVtyYi
 hBWy7Xy0Ty1886mhe2Gu7eHPlcehb8oD6ExGxTwoDC4aYi4gQeRYLdlYmP9uK0D9letL
 EndjnQV7TGJ47Bq47svGlpNT+1LqmlKnb0hUlWpYHHMEuif9AjTfco3wYx4gvDhdS0OQ
 F63t0sG4+iNh+i6pKQRaq/QTt8UxzrMHZCzZtyYUA88qpMlOtdHAHKIJZESTzACbJ6DF
 dcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288685; x=1779893485;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBklFj2t+5xCEM6rp+gL3GmHPa49NsPXvTRHaBqJpUA=;
 b=GaDfoGDltUOeDSfS+Roqek/k3covjQ+mM98z6spY6mjawj1lAcUPM7SpxzziJm+he9
 Awp7woJCNKZyKacCF5hyrzsxCVOqOksGnl+acdcWorbKXYQ0YLTgJ5UgItTiDP3orlSM
 7XgUUVFYscsPO07DjGYxAuanSsHuquHTFeKJyCj46uUDSttNVGHVnRmO7SbGLmVL3K/C
 f7wNgk7Of+t3dCDdIr+Ly/AA1/Lqz2tC9grCyZE+GCW3V+jNLe9XFCTqVI8uXwdahIBf
 1Rt45PkOC2oiKL/J/7ZQAeDKvnG2FLEzNLROusubZedKiyWNd1Xu5lAnMZtS2Y2y4rGn
 JzsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8u3AeIX2hc733Dq4VgdA1j2tP/B2tRAGVTArAZkdJZY9Ev7ovES+WeVD4N2SUGfkbsuL57Io3btuE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyT7Cd5JrLKzxCPuSm6sTRRydtSpzg7NFaWWZAfYcHTAEojHsrg
 2B659bRzcrcbaU06hzfNJwhLOf2y+f4ncvSQ1/Lxv5sUuyUxuuRbKPnkMKs/XE1beBAcEmN+09N
 UmwvEe2AgZuPGEgodeJcbVpG1kzAw+icbcjogAm4AHtUd2gVlAzMaJq4g3Ge1HrlFr4bwZhXVG0
 0FFvY=
X-Gm-Gg: Acq92OERF+HE3/Gnqo1nEqKn4ZYmB/h7bA6yngM2Vhgph3zaKB5fYhCtiyLhLwLu2lW
 bldta3r7NVdssqW5pC12GworF/b1Bk5Vx9zSY6rlQ21hWFnaQjgoe4laKB+N4UzMkYxY00lHefj
 H+iAyegeoVGNC26NK5IltzXdKPo1u0LU99dCGmUTILILXDWbjlxSd8MBSQqazH+xE/i08DLfgh0
 2I0RWU0WwsKKWx6eyHj3GoHYJ9oPcniAxOeyppJW/sQCnptZSb7LtWZKKijHkQpe1+w8rJ9sWUn
 wKQM6qMoLmzALBgXnVFPosZhn8xnDapnJ0MHkDr890RYFylb9Cqf8eN/Q4L+t7hfM22FJLZPoE1
 HJGhlXVS5Ak4yYzHPJhnIYgtaQDeIjm4Wcd/I5yW9wVHrhkxnOw3U7iKRZvmGubxcfdAq8g+ydI
 93i2daorre5ByJDIhgWPRdpwswPQh4gWLP/v0=
X-Received: by 2002:a05:6122:da3:b0:56d:9e98:4676 with SMTP id
 71dfb90a1353d-5760c09d17bmr14071493e0c.13.1779288685169; 
 Wed, 20 May 2026 07:51:25 -0700 (PDT)
X-Received: by 2002:a05:6122:da3:b0:56d:9e98:4676 with SMTP id
 71dfb90a1353d-5760c09d17bmr14071298e0c.13.1779288683878; 
 Wed, 20 May 2026 07:51:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 00/28] soc/qcom/ubwc: rework UBWC configuration database
Date: Wed, 20 May 2026 17:51:07 +0300
Message-Id: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFvKDWoC/3XPwW6EIBAG4FcxnMuWARXw1PdoegAcKmnVLqi7z
 cZ3L+seujbdC8mQzPfPfyEJY8BEmuJCIi4hhXHIQ/VUENeZ4R1paPNMOOM14wB0tidHI57G+EG
 xdgitQltxRvLGV0Qfzpv2+nabIx7njE63T2JNQurGvg9TUwx4np57kyaM27aZXJfjmqKUvvVlj
 dyVErSTqIS1wFAarWSphDNCKWuRXEO6kKYxfm8NFthStmMFq3fHLkAZ1S7LHrjn1r6MKR2Os/m
 83nPIz8Yt/I7403fhmai1l6A8N+D0A0LcE3xPiEzY3MgrxkDW5gFR/hIVk3uizIQDXWnRcuag/
 YdY1/UHSKJW59sBAAA=
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4647;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=AbLKvmfV4ZLXMCCJs/BPfAUUoqn5PKxTORgcyw+lxck=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQxbvqdTZlw9lMjbtYvI5tqA7XrSH/Ypq5JcyNd7Aeb39n
 BO/uBt2MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAiVRc5GBZJvP8syjb7pn2n
 b+nVtk23frY01W5ofzlHM17ZYt6E1zVZfO2WW44J/9rsub75ZN61n1J91loueW/YrhnttXgY85a
 X7+Uzk9tMeydxs87rVsv+sv3JnDk67BvficfUiIXujtX3s+Hp313vv2jSaf/ZTqFOL08WnBPnsT
 o1T6neLeWvb/Umu47K2wsUrOy7Ffdp6Gn6p996FXFlqZvgVRd55tjudpU/j5k750eekA5cM9/Nm
 FXe76XwtD8rrSvucVY0XVkfbKSj+9B6+ZOUDc8zBGxNDXpWSc30vRpb4Wk54d9fw5vJuwWKP6zo
 tTJ8a3ZxTe1f5Th7n4USc4RK9c0Lkk6ZqLJIG1R1Rc0CAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: zGDJHjGIZW19zBiutcd3KhzSMI9jBGCW
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0dca6e cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=7hJuk1173Q_9pT7ms5cA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NCBTYWx0ZWRfX45MrT5odXNc5
 4mSyANv+9vq5ZTg59AVj9mRHKtuzZbvJhe+PXdE0HXm7dPgywODLdIIQt4cq60hSOHfXV9pO2yR
 mgQFRGRwEJ9sdhXiBLTz4IQjoOnX1ne+Pp7pHMjClyKLiSirUKl75fc0du31UFMu74zAXNBzUuq
 IUhyKQSsSIkdW7yVD5iIbh+v1wR+ilaPzlLPvgr2ujz3X2l7Ou8pL1SPKIdz/EjHWPVWveIvTqn
 1dGZ7bYGjjQT46ecSSuEL1qsidlAgHHH5MZoO/uszJG/Us8D8W5tuZeB5LDWyTFIqNNqbtSxOWW
 D//zCSQh3iNUkfnuEbz4DBCaTMOSkDKgrefXPUjXTvkkdBsja+OhG8SKN1Y6ygNh8v59NNdaFXz
 GTcNle60UgIdb5oa1Uo1oyF620XqO3efmRXlS5hNSyPHr5j5jUnz/2T985sDoXDYvpD0BYlH7mQ
 H+km1n6ddJq53kHjNUA==
X-Proofpoint-GUID: zGDJHjGIZW19zBiutcd3KhzSMI9jBGCW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200144
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

Bjorn, would you please ack merging first soc/qcom/ubwc patches through
the drm/msm tree? Or would you please merge them and provide the
immutable tag?

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v5:
- Dropped applied patch
- Rebased on next, fixing conflicts
- Changed SC8180X to UBWC 3.1 (as it uses the macrotile mode) (Konrad)
- Link to v4: https://patch.msgid.link/20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com

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
Dmitry Baryshkov (27):
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
 drivers/gpu/drm/msm/msm_mdss.c              |  43 ++--
 drivers/soc/qcom/ubwc_config.c              | 295 ++++++++--------------------
 include/linux/soc/qcom/ubwc.h               | 103 ++++++----
 10 files changed, 216 insertions(+), 430 deletions(-)
---
base-commit: 687da68900cd1a46549f7d9430c7d40346cb86a0
change-id: 20260211-ubwc-rework-e6ce1d8eb520
prerequisite-patch-id: 47fdf46e2c4719c7e83bb10e7a987483ca388bbe

Best regards,
--  
With best wishes
Dmitry

