Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B4BCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE6EF10E156;
	Wed, 20 May 2026 14:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ub3/C+ZJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BRCjqZ65";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D63310E3CF
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:27 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K9oTVl1178134
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DhLMvVZQbF3J03WMc2id/1RoXxcDZvjE9wQx5sGd7p4=; b=Ub3/C+ZJfbhY6/ls
 axipwBKPQAqBpSWIq2w4QYZ90cJmsVCNNS+ZnQGHWwVP/oL7qg+0MwMBMCuIy1oA
 sMuUSl4hCKbD/cm9MIfN48FtHxKNbP44NLlimQXKdQLI2lW37540TpgxPSJG8Q0Z
 mDWacPbAGEUJYxlNG7vn1wmtCgIOp9ie/L69an/+CnDaErie0LMz+dlBZ4FG59qL
 ZMcswYya54H7DpVXBTHzLLSmOXUjEmvB/8CZ31zanZnGxMyjI1T/jwFb0QvzZu6K
 TuJ/SPVXi6CkS0x7CPQUEXmjw4DAuZFTrJppFQIVHWUM6DbLXZx/+yJJFcTIo4ku
 71al1g==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ap6s3hb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:26 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-575242b4308so12862925e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288686; x=1779893486;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DhLMvVZQbF3J03WMc2id/1RoXxcDZvjE9wQx5sGd7p4=;
 b=BRCjqZ65vciWIEAgqrfpZNUElHm3QM4gkkCEmuA+H5xX/hqgGkUjmmdpRRrVpWuwp7
 wFtj4sibXlGNc1gmv2Ga0Y5LBdInvtZWkVNo36n7EtR6HVF1lah84u/fBdJYloB++Jrt
 B15FZScd/qhCpSMPogT6vdHhSPyENgb7VVvlfAYCIe2L+zo9DjRtl2fehaBtXOPjg9Yb
 U6GFkaOe6ul53ztxHBlYWWWe1RHdy1+X3ChNbNDDtp3GLYNZAFUZiAIKyHZg2ZSbfZOA
 tCIWTCqWmhMW251S+vbiNjVU8++W4pkm4HHroa4nXOuotp8NSk5mGrXiyma4IDSRbmJQ
 vl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288686; x=1779893486;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DhLMvVZQbF3J03WMc2id/1RoXxcDZvjE9wQx5sGd7p4=;
 b=JloczzApHN4Q9PhYBBt9mbN5KkLsTs1RnYXzCQoEB4xlYe0VEt0h893UtleVoL7Ebk
 CQFKnbOlL8RXzy6OQpu0J2Z5vJWrC2rcraejReBUEQHt8lfoiZ6fcksJnYbxgh8RZCja
 NaT0V0/GgHjhid166aSLcRJ/CT88PeL0TOwrZQt10qQaFVFflNdfOhG/TY4b8arK8aH7
 zDQthkUmqjawPiC1gPZmVEzdhn/kvZ78ZAveiNIvqK67wDVPKwm71NVugMcuMpz+Pev+
 vE9EpL/hrDieiIEw7rOfKE1xUyZEuGnJEbX4qooDawiFFHV/LeyoxpK/Zf3T2OGof/ph
 50Ew==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ixrlAisIPqK/ekta7iOMFERfu+u2TAK2VV7POzqMmmc3+qfgruKX+ZyfJnX5t4B61zt6nyw9fVJ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhRjLB1w0mIiky/54G2jgyZrE0D/3U0Ssd3odSTpunXaF4jPwM
 0TFJO1+Y27WUxcjGTGoOJ5JwW1TpFNWQVhp67/GOqs2JAilFzZ1ngX1RuQhqKZ68+evPjzG81HH
 kWLk+J++qv9NPBnp73DtGQc1omsY1e0GGjXJ3JdaAOI4j9VGRRbI5z/zZV1jxcE+4KJOXDTM=
X-Gm-Gg: Acq92OGsFkGUgmTszbwzELYkARBNhsBblozvDqWYZTTch3R+xs/f09whVbHtoFJYcjD
 lPIfb+/RLuknd7YyjvshZliE8FQngJ/IvtX9SMCA+2WUhHw4faXOnzO+v2v0jYnX9dwJBipR9i1
 WlCRyDiRBxSQFGFRAaMrmMEIHRMMy/Kbne9yhjWZoha2Rk2L5UqznJubJYCbIznKFj6y34kdDpg
 W+GWcuhl1No9REzT4hFladC4DAP3hr0Sn4ElGfj3Lvfpeizou7n0jXO54ZRnfLUHUeQWPVVugVb
 UIS7Nuev00Va+fceLjl5bXPk83YpIe7E9PeBZaTJqFdP+/E7WCG+UQbnz7tRJrZk5F4LoLmJH5Q
 B3HiqJNPiV4qxJXMnypGp0thONnOKaYqDkYGWpxlr/O2+hmEq7wUGWYp/esfYYLBD/cIhCBEu3O
 N9w1H+1mP6cSzPGaM49OmLvDyIDqvO3ChXpaQ=
X-Received: by 2002:a05:6122:179b:b0:575:2ac3:4166 with SMTP id
 71dfb90a1353d-5760be898a1mr14028610e0c.6.1779288685688; 
 Wed, 20 May 2026 07:51:25 -0700 (PDT)
X-Received: by 2002:a05:6122:179b:b0:575:2ac3:4166 with SMTP id
 71dfb90a1353d-5760be898a1mr14028558e0c.6.1779288685286; 
 Wed, 20 May 2026 07:51:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:08 +0300
Subject: [PATCH v5 01/28] soc: qcom: ubwc: define UBWC 3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-1-72f2749bc807@oss.qualcomm.com>
References: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
In-Reply-To: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=914;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=0jnnTKmBVzx8ajx5YR0+k88TfAux9nzkeECglU8qUoc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcplYiehb7WoqTeu02NUv4h10NpVZjPhbe8EM
 6ruVayulkOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KZQAKCRCLPIo+Aiko
 1RJcB/9RW/moB8fe/PV5gy+RL/l4+HEVXkDKQX4mRW/3S8f2W4iEYaITIEeOIFX1mfQ/czZfVhq
 H/yFBOSA1NV7X0xsN4oNLJuQzeBfr5CmzLayhVuy6lWQNUAVMM/B+drkm2Ddym3f4evfcU6SddU
 q34oAMPW3lb3Z6WvwpL+MHx4YL+AqlwZiNwmtQG6rFG7WntaNnZw0+sjYVulRaoGY333QxXffHo
 GNW78p7+v/GOJ3EMWMrnf/nsyaQRWV74UKqoBSch56VyDNDE7HthLnoYpCgCQP2o8CGDGxGQV7j
 OIdSB+bWJqvQNCmcrUkWpY34g4F5XoA4u00BaoblFCJiK5qG
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: cyYNeW9V9-lTwP3l7MtTZkVgLY6jj9hh
X-Proofpoint-ORIG-GUID: cyYNeW9V9-lTwP3l7MtTZkVgLY6jj9hh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NCBTYWx0ZWRfX//vudXp3wuhQ
 DnEAPbnI2PCTWeZgcRADjKZBo6zZ8ZjpEwFGzlpKQSMZ1jzI45Rdo+32JpN27LGd+FFVyAq5LBM
 uTh07xo7OcA5fxnlVoj5pgehYLGoeNxGtC1nrBtIbbiHaHF8k8vnVPZjhqghEc2pycd0CIyJR/O
 S/b6sAze9Lb5+T4z2rw2TWKUjPvyoIZcURF39Qq8W5jt6tNwFn9thFBHs9nHWHw/MWYc+LswbYZ
 wXx0vzH4ru+LCO+og0xVumTo+XCIJTlFtE8G+DZboGpN37vGwd37YKGCSoD0CvH8KCr+lT7h0VO
 Jlc0a7axBS29XdyxM2GQa8oM6YH7zizjLwceNzlsjj/cDRl6RKTy+rC5uc4asc/3P03F9tACqPc
 BhqsrlAu/ktdiiDeVfZFqU52Rqzjt0XFuV3HygcFfH2GARkgZUHmShs95nUl2qNXs+PGVbgM/nO
 7M+Gvu+v3m6/2N8NvDA==
X-Authority-Analysis: v=2.4 cv=FesHAp+6 c=1 sm=1 tr=0 ts=6a0dca6e cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=o8D1m1ilSIXDguKSM1sA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
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

Follow the comment for the macrotile_mode and introduce separate
revision for UBWC 3.0 + 8-channel macrotiling mode. It is not used by
the database (since the drivers are not yet changed to handle it yet).

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/linux/soc/qcom/ubwc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index f5d0e2341261..319caed88775 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -50,6 +50,7 @@ struct qcom_ubwc_cfg_data {
 #define UBWC_1_0 0x10000000
 #define UBWC_2_0 0x20000000
 #define UBWC_3_0 0x30000000
+#define UBWC_3_1 0x30010000 /* UBWC 3.0 + Macrotile mode */
 #define UBWC_4_0 0x40000000
 #define UBWC_4_3 0x40030000
 #define UBWC_5_0 0x50000000

-- 
2.47.3

