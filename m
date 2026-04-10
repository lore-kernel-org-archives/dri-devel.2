Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B95AE99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C5610E91B;
	Fri, 10 Apr 2026 09:35:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xr9LNeJa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dMJfLKTA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082D110E91B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:35 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A6HZIE2866398
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G/I4bTSOiGY1jIhDj9cBBNJ5NjBusFbpH1J5Y5qViqE=; b=Xr9LNeJa0pKQD88G
 kV4cVa4QaX4j2gk9YgsZlPlwoOH3VNYm7JScfxBKnjAOHm/kEk1QK5uG9tov5V9d
 CLuxqVKecLiagRUieaWTcy+Pqwla0kpQycRjLB7+NphEjFu1126BShILKMd1x4z9
 MrEmc8DTmjBjQ/0yhC6znwNYo0cTV3ei4tVuDmW6jVCTzygnVeZNvsGbGtuGeEED
 Ls0mG9PEbkO8OnvWJ+/kG6MVuMJqK8QL+MD0k+kDjvHarAx/wk8FqFIfvX9x1DhR
 Z3WLh7IUUsv0t8hVQ8YlSzj5im0PgsOH/t4j1eNNgcYtV8gD+NJF0x7CvLYU52ms
 JmcTRA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decaykt1n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:34 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8a1f96bf221so62761026d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813733; x=1776418533;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G/I4bTSOiGY1jIhDj9cBBNJ5NjBusFbpH1J5Y5qViqE=;
 b=dMJfLKTAFXIt2tpcwTXx+w+j27MmDQCAG6FAugK5TIY4owmYO+Sovmc+nYrRHe4xWP
 1ClFHDeqA+4fMGxsZPEDOxC8ZWQxb+Ye/3OOpuKkgMqtff0KGQlZuvmCtMLtbX5A8yqU
 0RfFfPG+qJM6wVDtNvnJBfQ12mpIdBaaU41Guj76X4V97RFyUr8i2Gnq9NF+ZYZnvH8o
 cXvVU7+N0vaL/z945vn9kAXx5pnv4nl6l1ChQL/tI6ZqB9rEqdU499Hr1dALK3zTqk8J
 DwI7JCG7tgf3zgBWwX5DYLYlwCJrEyKFTNFPlvwqaE+EjOwOQlBtRlbEIQM/asumvn2r
 iMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813733; x=1776418533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G/I4bTSOiGY1jIhDj9cBBNJ5NjBusFbpH1J5Y5qViqE=;
 b=GeSanIhk01+pQGjKAZqoIiv6NVopimZWY1p/pd5tniqmcsj9DtrHyRUrrq4ZjHfBni
 MkQiNtaOkmsqkr2sKrHb/fnlLV1ZBJ7bEqvkQVe6VKCNgF7whqLsNSHXRENvlAw00ACD
 VwLX1va0xfLgR5/B6kPQkh9hYrX3Z45YPbl0I7jvooWnbBHmXjPdxmJ+XXEQ1DG5aSrK
 m0wifRuM31mAAoSs2rGpqfF58eVfwg0kg5jKMDmMLaVWLM4t8V82LdFAOUDcTonkz0Vq
 wLvWtsQqCCsgKb1v90JZRb1vR4idp3P3LVznZbi8zwzzs+H86djpqUAjClfJGAzTrJgj
 EPZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXWUKWVZOn+GEDZpOsMzhgSDbIf4sn47uPEOJsoh36qJxKTQSRbioZT0gWPyRMH3waS+gcRFKOMG8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJnsfvvUsjCelQ6uHSf8TufYqBWGCWcxpIn0dJkM7XXjWOZG0r
 N3IXB5gr2ximxJflihnYbAPgd9dSMfvVHoBNF5ZW6ZtXubgkrbVaZFNKIk5hm6jWTuj0C+TXo0Y
 O0MkkE0iyO9dn1fFj1sQKPzML++S3wzKZHYyabIHEm2aDMk0jVCGpoPZY7NvQmWEkzbLXO1M=
X-Gm-Gg: AeBDietfr/eQG/tYKfRh/0R5YijZCHu/b3Ffq0ZQdBlH85810xs/lcLp9a8kqeK1p70
 BKpr9QdC8+VuGa2xEfgVyhNlTND9fH176mxS0eQdGfxIcjLFmTKxKhQ/Io79QGYS8w8deQf4ifK
 8ISX/KjFSPSmqCTqIg1vO94YlthYVLOm7ONN4HX3JRkqX5pA5qoDXCGbbGmkjL/wheOoqtenBE/
 2avPbOljmH7jwNopNzekBOoHExLswoMFIPac7I0RZyZoMxKurNrkFBFdW+7m2ur+smxnCLxWMBj
 528Lwdmhx/auJKtIaUlzO8V2uDHwJVwzf4ydSjWEmrtCEvfJnunfIfiDk5BjWpSchChrk2r00Oz
 HGXP1nMWZJmRfaT+sussPM3x8zmr2y3wQCK0mH+6O8+KKAm6kHt9uKjWJksdVQwE5JkAjzLj53F
 mCjcwgMZ0=
X-Received: by 2002:a05:6214:29c4:b0:8a4:8b2c:428f with SMTP id
 6a1803df08f44-8ac86156589mr34211536d6.2.1775813733575; 
 Fri, 10 Apr 2026 02:35:33 -0700 (PDT)
X-Received: by 2002:a05:6214:29c4:b0:8a4:8b2c:428f with SMTP id
 6a1803df08f44-8ac86156589mr34211166d6.2.1775813733092; 
 Fri, 10 Apr 2026 02:35:33 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:35:32 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:55 +0800
Subject: [PATCH v4 20/39] drm/msm/dp: no need to update tu calculation for mst
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-20-b20518dea8de@oss.qualcomm.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=948;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=7rIh5JObexl5wqWddoGzIlCl+b0BF+eozfwLe9V/icE=;
 b=L0VlX548K0Ak9M3bU1jIVULRvNBw2qHMvQPV8mzvfqFtmoRyUXEUPU82trTojGRtaXSWLLHFu
 c6KQX481U5nB3g9OiYzdERFd4EYX4isXmZeLD/bwF8w06mr08S3PT0i
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=69d8c466 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=IvrVfA4mKswhpIek5RMA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfX+zU1t7WAa43/
 m71SyD57F/25RJ1uzVRKc+poTD2+DvXhmCzWnpepp7/1YlMrzOztkGf5kyf550JIGMR/G+JwKqr
 hPfPEF93Q40GBo4HxPtTZglh76ovZI3eSuCAjG4u5pP6oi3b26uGL/IG12BAyfydAB5nQpgHVOl
 A2Zxd4lwffbvGbfeCno3T2I8VN8iav/Wd+R5YzGvhaXt+dKH5UfgC0WNCCkyohuhb13SMutELbr
 cQuCIusJjRugkrPOX4pDgVKP0X/tZfiCHz3qFR2tCBXUfvPn+kvIm+9xAJPKaqDlW4BK3xVxyVt
 SvA4FjBAPu0Wbg3rgchgNdzOJbQqr/+e2CmXo2xGUjDQ6W/q1wnrVMH0pNnrkxEtO7mmy7vRGjx
 ldLBWYCtYy7IF1rtk0uVrL53xt0w1vjsl74JA7OkwQzpX863pPJZ2+c45rc7h8WVVEmU1eUIEoP
 Y8wvFHGPFwUTAnccvLA==
X-Proofpoint-GUID: BwQpFMq9t7euS6QZv5pNj_vrfhmRNxXR
X-Proofpoint-ORIG-GUID: BwQpFMq9t7euS6QZv5pNj_vrfhmRNxXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100089
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

DP stream is transmitted in transfer units only for SST
case, there is no need to calculate and program TU parameters
for MST case. Skip the TU programming for MST cases.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 9513de81abc4..98316892eccd 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2698,7 +2698,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_panel_clear_dsc_dto(msm_dp_panel);
 
-	msm_dp_ctrl_setup_tr_unit(ctrl);
+	if (!ctrl->mst_active)
+		msm_dp_ctrl_setup_tr_unit(ctrl);
 
 	msm_dp_write_link(ctrl, 0, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 

-- 
2.43.0

