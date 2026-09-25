Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E2AC98325
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BBC210E2B3;
	Fri, 25 Sep 2026 15:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o8AcaWl3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PSji11dL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0912D10E2B3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:57:56 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PA4G4V609249
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=EBl2dFsWiMsFSqUAN5NQylf+8ZNg8zQAaPd
 vj+WmO8o=; b=o8AcaWl3pzLm7MttTikh/ZzAMiyEqPkxid/F2lrgp/UB/VlvgSU
 LfEQW+w+JPZ6ufnUF6kbgpilPCbo8SGf6zf/4VN4jV6HYSTdHbDjzIt5tcOkou/n
 5z0aqkPkcHX2XuGrHSxzm2/dUpDduAet6l7J1aIYdU7kzbKuKYT2sMa9aAsKsqWa
 /9ZqppQitZ4ALWqInj/J9j3lIRpr1HP/vl4rUzOWwyf1AYkB8mhd4qxOqHakYv3N
 Ilon22rLMfQM8JUO1SzsSEvaicmV8JOLgGmeIcE/gC+tNJcwZsAbH/lLXJBlI6ST
 ZOsRheDYR7yKt7UFMw4ty3uhPa7ukGPUjAA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvns6ku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:57:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8696b921ac0so906545b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790351875; x=1790956675;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EBl2dFsWiMsFSqUAN5NQylf+8ZNg8zQAaPdvj+WmO8o=;
 b=PSji11dLPRxxvtlQeg/9OqR3QXZeprGcUKcRz9dVayad1eIN1o6dIj7aGcl41K3vMY
 u/+gjY9u0dTHm4nNQNqUAdnjM+iNRI8gWIAnyC8eDRpNiQd432QwarrJ2f3fEwOvzz0C
 Iv4tKvu2YfLQisOcqRfr6SrXHBV1hWIsEa2K1lj6Mod0EQTotGdPDfxMlSYhNjfGssSm
 UrpfNRKw55CK/9wc+7jHWlfkWJGipHh8KOcd6lCEXVUfXh06+1t5jpaUPqYaVza14XCL
 L63+WM3BaBnaFQtwwGzsvk1DdDSbmB0sDzl5MTEjy2J76w5Tl0B6uh24sn/tAiVSOu2w
 DZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351875; x=1790956675;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EBl2dFsWiMsFSqUAN5NQylf+8ZNg8zQAaPdvj+WmO8o=;
 b=wdqR43OpUPhgZJ/JrOld+vk81m2fWXiGx2/PL7c3hz3X53unMDdGr7BbuhCbhAvXcu
 nKMRzGZXMIchQqUZ+Mxu5DZFOMEMOK1tCXmmK3F53Tkmwyex04jsLQxN77gutLLETvjk
 J5DbiZijC/sn2vcnam7Gpvajzc+TNc2eiZ80d0baHqgHmVXk99xE1/xY4Sm2yjLsZOk7
 eOM/n6K6hNTGjTGPScm5molWt5Ss1Kq3ATp8njHKfCFuR+2xu/LpQPShBldzztjBNrJp
 ILw9QOOhCzxWcdSbh5Z15EXZa1B22P+YUaxST61n7sTcHT7vjZKiZQ3SbBEEYAmLzyeN
 TsBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8eb7JgqNzqwAQrF8cq2UPGwvijn+ONqP7RxqtHInPUcrEtLhv8313q/QMIX20tekE91RhecbmwYw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kjHqw950tH1tlim+QTGkKuZy4t9vZjZk4eddveL8uCxSnYfa+i
 UMBtR8b6B02Nz2UFxyrfW6mW0SOY5wMetwwyZbk+GYRxYuY7/oaC0YSMuQb1k6a/QlhfdMw05gn
 mCqDROrjeRRSvKfPzkunvkQm4ZzR6c/RC8NtQRCscXz772asx+iO9qkzGva4DMBRecjcbcKs=
X-Gm-Gg: AYBFou3Uv3I9beFhgbxw1f0lo4LAcIdR4bk6ghwHr8rEHC+59DDwevg3CUWrYzR6xo0
 iFuScCG51bdTP6eCVIJ0AJkk0mZq02tatsXgy5p7ZgIdesEawwOttKhF41oOiiJJDlbMI55hCFv
 08rc4a8QPZ2qfpSiO+U3FXTypuQw527pbODCVr1Eqa2J5XELnSKNwbjh+vDF/lVtLktNCuQmXrH
 FEO0+3UqY9Z87K+da4OBgU5KAm2nQH/XP+sxcdevoCXaKy4fVVc57nwv29Jhaf+3qK+agjxwlPa
 snG3WgpZGNXQR8g1hb22aQB+1xsDnJu+JWytVEr5v2F/CY8VX5V4874sLh7hpcQmKdLniIz670K
 A4u2UpHlxpW0lFHf9qdVPpOzMz/g=
X-Received: by 2002:a05:6a00:2d96:b0:880:d0d9:fece with SMTP id
 d2e1a72fcca58-880d0da1e8fmr852036b3a.36.1790351874749; 
 Fri, 25 Sep 2026 08:57:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d96:b0:880:d0d9:fece with SMTP id
 d2e1a72fcca58-880d0da1e8fmr852010b3a.36.1790351874126; 
 Fri, 25 Sep 2026 08:57:54 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87ff354d854sm1361299b3a.2.2026.09.25.08.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:57:53 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 "Bryan O'Donoghue" <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 0/8] Migrate PAS clients to qcom_mdt_pas_load() and
 qcom_pas_prepare_and_auth_reset()
Date: Fri, 25 Sep 2026 21:27:29 +0530
Message-ID: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Zd3gHNy45MBGXMq7po5gZa9pBitxRcgG
X-Proofpoint-GUID: Zd3gHNy45MBGXMq7po5gZa9pBitxRcgG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX3VuMvVn4RZ6M
 QR1Fj2Ho3eVUojikzFXJCyJWqLEtLbMKUC0CazcvYl+TH3ZGd/6ZumVB8yLy1gXFpunNla9+Ejn
 VkL1jYCdp6mSReRxnwOkdcy2bwjd4L4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX3zuk1Nx7s4vE
 COn8UxB6jXgtkr+3FjFdbTSND6T0XzRuOIPFl6sbP7AN85Vzj48A+M+cxksVYuFME5GkpvH/tat
 gPFSqftaWMF9oS8UNpQHqFyoS8dO+IVL1+uhdKPGyeQTzBryKyNChfF5PjQcmr75MspbwCeptqp
 0EZ2XZH3LcuFFbezHnSiuhUUCSV8lq1OxgPBDcO3Kwg7ah06z/GGoHL/BrxKza9iM6YA7BKhGbD
 N8HqBAYDKVcfj72WVP1RhDSRRUBJF2s4D6Eei/kE0Oe+AO2it71cS+gUdEw+1v+Ru7xxPdKquLi
 0iN6p9GDjPD86KtsW82xkRv4fcZGRHdj0Z3NPp4uNy3F+EXlUMEIfP5svSrOmc+lVmIBBc+yyeL
 oOZZtHlPQz78gjQdOZuUhaew1ZVHSQSnuhiU4MAPvh3vrktus2xl5WNaYMPrhV69HYjKjN40+pV
 ybWQn8hJbMdkjmwkBjg==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab69a03 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=zG7KPAmT95cOeVn0dqYA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250063
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

In preparation to remove qcom_mdt_load() and qcom_pas_auth_and_reset()
public function, migrate every user to the new PAS context-aware API
qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset().

This series migrates every remaining caller of the deprecated APIs
(qcom_wcnss, adreno zap shader, iris, venus, IPA, ath12k) and then
removes qcom_mdt_load() and qcom_pas_auth_and_reset() entirely.

This series is based on top of although no dependency as such.
  firmware: qcom: pas: Make MDT buffer retention explicit


Mukesh Ojha (8):
  remoteproc: qcom_wcnss: migrate to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  drm/msm/adreno: migrate zap shader loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  media: iris: migrate firmware loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  media: venus: migrate firmware loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  net: ipa: migrate firmware loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  wifi: ath12k: migrate firmware loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  soc: qcom: mdt_loader: remove qcom_mdt_load()
  firmware: qcom: pas: remove qcom_pas_auth_and_reset()

 drivers/firmware/qcom/qcom_pas.c              | 16 -----
 drivers/firmware/qcom/qcom_pas.h              |  3 -
 drivers/firmware/qcom/qcom_pas_tee.c          |  6 --
 drivers/firmware/qcom/qcom_scm.c              |  7 +--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       | 21 +++----
 drivers/media/platform/qcom/iris/iris_core.h  |  2 +
 .../media/platform/qcom/iris/iris_firmware.c  | 20 +++----
 drivers/media/platform/qcom/venus/core.h      |  2 +
 drivers/media/platform/qcom/venus/firmware.c  | 29 ++++-----
 drivers/net/ipa/ipa_main.c                    | 24 ++++----
 drivers/net/wireless/ath/ath12k/ahb.c         | 31 +++++++---
 drivers/remoteproc/qcom_wcnss.c               | 12 ++--
 drivers/soc/qcom/mdt_loader.c                 | 59 ++++++-------------
 include/linux/firmware/qcom/qcom_pas.h        |  1 -
 include/linux/soc/qcom/mdt_loader.h           | 12 ----
 15 files changed, 96 insertions(+), 149 deletions(-)

-- 
2.55.0

