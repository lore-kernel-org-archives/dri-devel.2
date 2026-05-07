Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0092ACD342C
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 01:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EABE10E230;
	Thu,  7 May 2026 01:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E1kFBEXI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bdZuMLzr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1630D10E230
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 01:10:50 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6470IGKX443101
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 01:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=YjyMZ7Yja23dV1AwglOfBD
 khUZEse+Hk5apDcUojFv4=; b=E1kFBEXI5DTIvT45gV22HH4vUrwFc9Jw7Mq6Xn
 b2nxv15hoGR89MfVEDuulu7XefaTi0jkUl+Q7+RN1wceKBAwMB58A9pZIqbPUnBb
 8Bu80A4JUHls9Qa+oy3wkjf6UqRdM3IZRivn2CfvYtXPm1lH4v+5nDqeFlfv/JdG
 TsPtTf5lV96EJ2u5nvAJI9SC4yZWoqkE0lVu2p/4mPwP1ScgY4VmVtg8WqhJLcNJ
 8tQLZ/0WQ+1HRbIyeIpZf2hjQMrqwDCFmueIYOVDfXrfYaPG7hBg9XytwE/fu8hn
 703sln7+OTmA+qUUn5maYvCcPBjIt8V8vLFslwVVot3cDCXQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0299kbub-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 01:10:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d84b5f73bso8915371cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 18:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778116248; x=1778721048;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YjyMZ7Yja23dV1AwglOfBDkhUZEse+Hk5apDcUojFv4=;
 b=bdZuMLzrRZESzDVZCXu2XaG31tCCIepI/9h/9B1si0eQXWb7hn6s3g/b8upxKJO4dT
 IiSPUYRPuMPhBdV10xlwWFKezoAN5UIvnHIog905i1KqTUfpPx/E256n18MaexbhDdcc
 oRKicX3uRfdN7nIsORUbb6hkittG74qXENvCDE0gzgJN3AfiFo5wur6DQY8MCqLQRlUI
 Th0ynJrEcuTxNEGgoDo7EP+lWo4MHhBDF1TgGK64GTdX5YMRqgQu9zWSjrELeUQGMeaM
 aveDGFWd7kqPBRjHMA2FQueHoY7na1cuAWphhMou5AVzvStl4y9IdtikrgoiwozVWJBz
 DQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778116248; x=1778721048;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YjyMZ7Yja23dV1AwglOfBDkhUZEse+Hk5apDcUojFv4=;
 b=pFOa3vlirB3U6tMbUzHjxt9OoyqqiDTXGTwO8IGZeKD+fQCfvvx0xRV3Jn09DOMHHQ
 m4LSBV4Mhid0O9pD1lJpvb8OURZ0PlU5GKjIbJYuqbH/ss9JhOAjO8p0CMptcxeckWnf
 5yWZrLOXXIpHhOQXA+GzJuhRzd0k+hgExqYIKAA3OcBE+JIAbXf3BiR7a0Yi9W0erX8V
 GAttzwz3OOoBNXXoAfd+XP5ILSots8C6UGtIFz7O7n/3OcvAbVfJbEsmqPM+KcM0RleB
 sQIuspJL3z+Ggg3O0GTUgowpOHzwGi/hpoJn7jrfxGeVO7NjJTykTuu3DA6tWCTn/B1k
 TEAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vCDC/6UX3IOHBL4gN/0LwMAasEE0aoTYs1SxSkh/gvM+FJVCRcy6/8eIHc666scSRkNtQ/kIBpwY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4O9wz8iR4SdC8td5LO9V3ccSPhfSuBmv30YKdQW5q+53VB+Mx
 B9QaEjGmGhIElsv4V3S7eiao9tfiI5dSGBB6tylwr5ppmudfBbC6Q5/5vqyOys+mnAP7P3DcpAW
 SMxEweIyYscxWERRcSC9c8qOtP3r3feeefqBmW9MBFYbBPudRWBwXE2iLTQlKeKg9LZkDdBQ=
X-Gm-Gg: AeBDiet+090npWM/uXOY6aXZu6iVXWNZchtSDzVCkuQqWm8tLxcYyc2o/dQCFn7GMcT
 kQS9mgRQMpY+/zglJGFLreaXDJj/KvGdWiRZ1vllN+vhlgb6kRHoGo6kJaWl+fkzrzrGV0jt0Rn
 ny0jvtUZ/B0UoHKkCPvK+wxCuBszcFtUtdA0CG8xPrNQQyCx1JoYraExNAPU6mpkyhPXkLTdHJs
 8ww8Qm3soLEUamK0lWq4PJlKSmFgaM/zpfcdf9EyGH4LrKF8Ay5KYr4zkkAvBHAFhHFr8uGeibx
 M3UELjUSORNzoopWroF0UynBD18lFK+u98FTckBES6Ms0kp8UBCTWrXROYSi1ZSFgdymYgvNti5
 A82dEC1Y2ikGAnEjvrXG3KdM9VeFN5PqcKeLFCl0d1sJwdH15Zsoh2PjJkIOrpk1HuU0QwCrrF5
 ZQ0SgU8767PF8OWSqxGYqlNPh1DSzCUTEwqmhDrGzvOtP45w==
X-Received: by 2002:a05:622a:8c6:b0:50e:a1ab:67eb with SMTP id
 d75a77b69052e-51461fcea84mr84081251cf.33.1778116248188; 
 Wed, 06 May 2026 18:10:48 -0700 (PDT)
X-Received: by 2002:a05:622a:8c6:b0:50e:a1ab:67eb with SMTP id
 d75a77b69052e-51461fcea84mr84080781cf.33.1778116247678; 
 Wed, 06 May 2026 18:10:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230e00sm5221967e87.29.2026.05.06.18.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 18:10:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 0/7] media: iris: migrate to using global UBWC config
Date: Thu, 07 May 2026 04:10:39 +0300
Message-Id: <20260507-iris-ubwc-v5-0-e9a3aee53c49@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI/m+2kC/3XMTQ7CIBCG4asY1tIMMJ2qK+9hXFB+lMS2Clo1p
 neXdsVCN5O8ky/PhyUXg0tst/qw6MaQwtDnqNcrZs66PzkebG4mQRIIATzEkPijfRoO5AlN2yq
 hHcv7a3Q+vBbrcMx9Duk+xPdCj2L+/lJGwYFb2wBu0RrbtPshper20BczdF2VD5uxUZaAKgGZA
 VRImpyHRm//AKoEqARUBoikNuCgIeH/AFgAsi4BzIDwXgEharMRP4Bpmr7n3RFFbAEAAA==
X-Change-ID: 20260110-iris-ubwc-06f64cbb31ae
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Wangao Wang <wangao.wang@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2622;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Zu3i5XCzu22KzE0q09L9XHJ+S3aEkjW+7l8kQ0vzT/0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp++aTnu2eCICOVVoAmz62ya+oolHsK0dcWPaJ2
 8gni7kUvf6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafvmkwAKCRCLPIo+Aiko
 1eX4B/4tVdJsgGK3o2w5P4j5x6+2Kg6TcQcmK1nq1jUX4fwKu4oE1vlDg+JGaFomh9GO08hWHRW
 NqkUrE7L+ILAq7ZLaG6ShZgBc7ga7KHabJ6m0di448W/MkCP02675VQdUnf/Mr+K3VOrKV9NFDy
 89LQ7MCzxWo3BR/gwomGRdyOH3Qn6hSkEksrJIg7+CR/We8Ed7l5maoarM+ZFHcAQFcp6suFM5l
 cmB2XJ+n0dLVCAvWHMlGYpH+Qn5oSdv7YMcgHmEktRfXRn6yZZXLBlfz3T0F/9u7bmMfU4/Ujzr
 PphtJM8CJjn2zvuXOFmDGuV0ms2+05hNYnLJBZY/cGQeR2Ou
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=fMMJG5ae c=1 sm=1 tr=0 ts=69fbe698 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=sotOLrqpNFqtnHaJl_IA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 2DmPZQIfYdoGhNIsR6hOsZ7DWKL8l357
X-Proofpoint-GUID: 2DmPZQIfYdoGhNIsR6hOsZ7DWKL8l357
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAwOSBTYWx0ZWRfX06hzJfXIurmb
 ZQ7yWSm3f3qDKYld23Is4/j4qwIejoER46MEImCkq5o7fDa9P1yjm5ohgA0Lk9VCD2+PCF+1DWn
 GvorLylIm2DMsHnMDE3WC9zjerQPUfMuMg8TJzotI4SlPKPlAsP2TW+ni7qX1j2GFhQKMnArykF
 YpOKkwg9UC5YAHr4HlxRruwixFUJTVrnjuqOgr4AmHKUaeK/HtY0aD00bJ89rOPokTWfO+Fe8kb
 40cvcEjY2oU450A0+clcq0gkm6boOhN4Byld66F8q3Ckiicdna2lFMlFT43Mnlr1v9gFRdz24OE
 kp1bO+++1pt53anJLyQfyI2E4Gp7C+R9oszY0+o7l5N3LeEWUKRBoMYg7R/BtIcvzGLeaaY39nV
 l3kIiGgr6Nr51iYwmbt3HndOd7s/9H2iQRk5d7sKtebf71G2mthNWqTQEtAhQ9EqjsjXrCO54jo
 ntRUqhhcWXqkKK9znhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070009
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

Having UBWC configuration in the driver is error prone. For example, the
driver specifies fixed values for HBB, while the actual value might
depend on the DDR type. Stop defining UBWC data in the iris driver and
use the global UBWC configuration registry.

Merge strategy: either merge SoC bits directly through the media tree
(with Bjorn's ack) or merge to the media tree through the immutable tag.
The drm patches will follow depending on the way the SoC patches are
merged.

Note: the patches are compile-tested only because of the lack of the
Gen2 hardware at hand.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v5:
- Rebased on next/master, dropping applied patches
- Link to v4: https://lore.kernel.org/r/20260125-iris-ubwc-v4-0-1ff30644ac81@oss.qualcomm.com

Changes in v4:
- Rebased on next/master, fixing the conflicts.
- Link to v3: https://lore.kernel.org/r/20260116-iris-ubwc-v3-0-662ac0e0761f@oss.qualcomm.com

Changes in v3:
- Dropped applied and unrelated patches (they will be posted separately)
- Include printk.h, decoupling the series from fix picked up by Bjorn
- Introduced additional helpers to retrieve the data.
- Link to v2: https://lore.kernel.org/r/20260113-iris-ubwc-v2-0-4346a6ef07a9@oss.qualcomm.com

Changes in v2:
- Extended the commit message and added a comment for the min_acc length
  helper (Konrad)
- Link to v1: https://lore.kernel.org/r/20260110-iris-ubwc-v1-0-dd70494dcd7b@oss.qualcomm.com

---
Dmitry Baryshkov (7):
      media: iris: retrieve UBWC platform configuration
      media: iris: don't specify min_acc_length in the source code
      media: iris: don't specify highest_bank_bit in the source code
      media: iris: don't specify ubwc_swizzle in the source code
      media: iris: don't specify bank_spreading in the source code
      media: iris: don't specify max_channels in the source code
      media: iris: drop remnants of UBWC configuration

 drivers/media/platform/qcom/iris/Kconfig               |  1 +
 drivers/media/platform/qcom/iris/iris_core.h           |  4 ++++
 .../media/platform/qcom/iris/iris_hfi_gen2_packet.c    | 18 +++++++++++-------
 .../media/platform/qcom/iris/iris_platform_common.h    | 11 -----------
 drivers/media/platform/qcom/iris/iris_platform_gen2.c  | 14 --------------
 drivers/media/platform/qcom/iris/iris_probe.c          |  5 +++++
 6 files changed, 21 insertions(+), 32 deletions(-)
---
base-commit: bee6ea30c48788e18348309f891ed8afbf7702ac
change-id: 20260110-iris-ubwc-06f64cbb31ae

Best regards,
--  
With best wishes
Dmitry

