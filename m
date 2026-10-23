Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45961606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NJmdDXGU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bAlj/7ZU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA3B810E63D;
	Fri, 23 Oct 2026 15:32:19 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CABC10E658
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:47 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5xeD2109280
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +fZhaZ82V4/5KLW1sTiPxhoM8r1KKvfY9E07z+Fr920=; b=NJmdDXGU1uF7+X7w
 p5s7n4a7iG1Hyzi2ScuTHJ+cV+5G4GeL2MwD8OXZBy9U/oH6ojG875a6BaBcZHWQ
 bVOtoYvRssu18j7K5wTJHueY7UFaq1oqG6tE4h2sO5qC5voyUK1wrpMyBqcQfPCB
 lSqXpVleNBGoFoj4YzHGhv7qdEyameXjinxDaC+jEdQoUQ4j1Sg/k98wh3Vg1asF
 IvOjeUx/P28jtnSDOuCIfCT6VWfrGLLdlOkWScsXytrY7i6XrpPG4otity7/bgyp
 RXU/cVqZ8928d+V06KLFSN/A/NTQ85ZhiYAmftbNfi1H9JDpB8kMnE2HC1l+rMVA
 Z6Ptxg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms4adm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:46 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7c124d17880so272635137.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769505; x=1793374305;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+fZhaZ82V4/5KLW1sTiPxhoM8r1KKvfY9E07z+Fr920=;
 b=bAlj/7ZU876BC67vtF9HX3LeOZ9fZzL1heG4/SyGM6K9P+Je4p/RgwPD/KDdr3jgUi
 HLiN/SuyiBTvH7B/32tP1rob4PEV5V0E9P9qOaFCMLEe3mmpnCEsy/jq9l7l9JpSyndh
 247wtWLqpk5qHhihVwxLxOZt0eTMObyU+EB5lRvFSnbMyiNM10hNXsRS8Oh3XAUS2fAO
 hETGM1i9cEP+4D8//hE+B91K2R/I3SY+6EKkNb9qwxfsgfXYZRkla5YeEWbXCZoe6Gas
 NrGQh7HJ2dHQVcgAeK02jbJKIzXGsqr+GB8NVpY3EOLDFFNk09IgpA3b680bHX2Vr6dy
 ry+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769505; x=1793374305;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+fZhaZ82V4/5KLW1sTiPxhoM8r1KKvfY9E07z+Fr920=;
 b=dMy9/N7+NSiuwvyUXJRTwncmBOY/8xzKd7ziHOse6hDc6rJ2Vp/8OD/hvuEZWEdZlh
 5BhkXkR3sj5ECM7pWgLQVUDQaA+GQOMHW/2XJrZnDxZYWceHfBtsOs83UtUXasPJjR8i
 OSC9yoPR6FkLvP3fxaX671Wop278y6YStTC1keBHJdzQIwrvU6eSkqI6r/ngLDy1Xi8+
 zd37+Nqv83adUWkShX05/3WfwzXu1q0OxxJW/WYjD/Zo2QXVCzyaTgdM1YUmEmmOCotk
 LcMDqf13pHbwfiY23dJFITOtnZ9vwFiRS6O5yNEX25GFu7S2jADVRwvUE8FZCquUUPkb
 d9DA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJgT4XCsVEQvktW5O++tnP1DnFH5+SIcLOAoJhlv1zKEzqRvR0Py06qQIgUTjlfNhXyeA3QMyqtbM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIzL+/AvGtLSrUJmaOHUB5JvICh6Y2WKRuMztsO5zvOlLpXviBu
 lcIDRQQj/LLXt7qxB5s+bw+V9K85h/1HbR6xaQUDyKVax8FgEyX2rgKt0gP6yqHrTqB8sJTvnW9
 0ufQpvxyvYcCiySZ2sGHSkuqjoq19KxV4IUqD6ON+FvJf6S8RkAYlTyacw8iVWrnPB2MMFTU=
X-Gm-Gg: AYBFou0g8IzRFDGkZ024RtNNFhZmNG78JeJNtluS3K5v00UU6bGBrXp9/4RJwB8GHQr
 9BiAmec3HrG2SL7NW1FykZM7XpYlKekrfzw81y1Bfw/G1mXZwbu44qUZL8e2TQgqFkVdGswCFr1
 +gWO6h5K6nYjVy+T2NJDlubJXuttQjd3F7hY+qHv1F+2zT5BQdHSIgbju1RbRC1VtLP3068L64A
 7d8Poy6ZWqrw+i3giK1/uUxpiacx5/RKi4vIOfHNewm/UxLonjR1Wrixx5VjAP2uWbvr3oe0hTG
 NXgN7KtyFs54CByIwDc/h8/Aht8+PY+BS1VtdscGdZNyw2qcT/S7vaVk7s7zS3iSchFHFppU7CT
 SzJE4mR6or7lFa0Fhq+xq/cf5dTnnYbpWkleE8P1Pi3AW77mdR3awFL0dW5ULLcOCLEzU0HJws9
 gmFzYnYo5MhL/X
X-Received: by 2002:a05:6102:3e8f:b0:7c1:b55d:373c with SMTP id
 ada2fe7eead31-7ccc343d2cfmr938145137.31.1792769505525; 
 Fri, 23 Oct 2026 08:31:45 -0700 (PDT)
X-Received: by 2002:a05:6102:3e8f:b0:7c1:b55d:373c with SMTP id
 ada2fe7eead31-7ccc343d2cfmr938102137.31.1792769504814; 
 Fri, 23 Oct 2026 08:31:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:31:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:31:16 +0300
Subject: [PATCH v2 01/14] drm/msm: fail the snapshot init when its worker
 cannot be created
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm-kms-destroy-fixes-v2-1-83727c122de7@oss.qualcomm.com>
References: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
In-Reply-To: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=WsQ21XZW4TA3F25Pv6HWJIhCOEkArUvMa6B6iciNKmk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233POcq5+xBs5sKYiuZGBaLseVkHxghGTjRWs
 EJpo01elkGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt9zwAKCRCLPIo+Aiko
 1bdqB/9+l6xgnzDWlFKLsrNBYSCr40rrF1HkzMr0fqS+ZB7qwxvu5mOAAVCB3RyJNGX6tcG8gqr
 99LFNtxZYSPUSdZDAhIj75zherArAa/KLO2QnbFdGZLa4XkCtFA8ZCmLEjgqQgcfT53TFK5oiFz
 P/xSvcDV/Ty6kTRPE17EbNi7Yobftdny9pl8h1Q1IoIuFekMFg0d0ipnlK6e70neOzxVqUVVjz4
 pXDWcPTm/zh0IPBzXt0Dmb3R8gd7dF0azl/JkKiKo/rG/lWf9wZbr1XuZvbpVj5a/tIXbtvPSnQ
 oA9n3ISr4MzKprzDAhy0JkZSsNpaB4oZ/uShBNC2V/CTdu4S
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX9PmJmy3FX4W5
 G5kG7mUrhciitBchKuPz9fGqdXB+RFhknBqLLZe+y3Nl9aHZ4dh/5kG36WZn/T7iTu+8Ndl3P8n
 WMfAmKSo7uH8S3+1aypjKyhhnSt2wssYkhwjkFQ9mBbae40H+LSLvwiukAaoxBPhHPP59gUW/Qg
 PTB2KgfUhPYFW04K+z921/JiPPv6s4PasZkmr9WthT/nvrXMB1MqsOxL730uUXuftkunHtt0oDz
 Kj/i9TIVX9tQNLJ3/6VQXNyM8RGo27Wsz/bpMtlWRX4zRCYS9sS3/PECVt3juuH0NCvWTwnJ8N/
 WmsHnPn6ncXv8kXrJkxAEeDqgxsnGwLY8YgszSi/Y61oBuTN/CHco2ADlI8Fdi/T6kG2Gqa+8Qa
 3slZ0b96l7/uUjunKpgr3eHaAJZ+eknXUlWGMRgHHiM3Z7qWsmuKvYkYg9R76nUJFrDddSdwsBl
 5ejiQ+6NkRwZf13cJsg==
X-Proofpoint-GUID: t26ljxCUF7dlsMa-myUYC-jXvoHR9zPO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfXyNgbHMuI9Upq
 JmS/6ZHfHB0X+ztsS3bUBtWDlUJeoLSM0IpLSoBp0hJ//gTZ9YuQapeFscn8/gyjRF9pbeW898F
 uMjdceV+tF10586SS2sX+PkY6DBeWD0=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb7de2 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=D-zmcGmn4BrKCB6hg70A:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: t26ljxCUF7dlsMa-myUYC-jXvoHR9zPO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230060
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

msm_disp_snapshot_init() only logs a failure of kthread_run_worker() and
returns success, leaving the error pointer in kms->dump_worker.  Both of
its users then dereference it: msm_disp_snapshot_state() queues the dump
work on it on the first display error, and msm_disp_snapshot_destroy()
only checks the pointer for NULL before passing it to
kthread_destroy_worker().

Clear the pointer and return the error instead, so that the KMS init
fails rather than leaving a snapshot facility which crashes when used.

Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
index d99771684728..d1b10656e41a 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
@@ -98,6 +98,7 @@ int msm_disp_snapshot_init(struct drm_device *drm_dev)
 {
 	struct msm_drm_private *priv;
 	struct msm_kms *kms;
+	int ret;
 
 	if (!drm_dev) {
 		DRM_ERROR("invalid params\n");
@@ -110,12 +111,21 @@ int msm_disp_snapshot_init(struct drm_device *drm_dev)
 	mutex_init(&kms->dump_mutex);
 
 	kms->dump_worker = kthread_run_worker(0, "%s", "disp_snapshot");
-	if (IS_ERR(kms->dump_worker))
+	if (IS_ERR(kms->dump_worker)) {
+		ret = PTR_ERR(kms->dump_worker);
 		DRM_ERROR("failed to create disp state task\n");
+		goto err_destroy_mutex;
+	}
 
 	kthread_init_work(&kms->dump_work, _msm_disp_snapshot_work);
 
 	return 0;
+
+err_destroy_mutex:
+	kms->dump_worker = NULL;
+	mutex_destroy(&kms->dump_mutex);
+
+	return ret;
 }
 
 void msm_disp_snapshot_destroy(struct drm_device *drm_dev)

-- 
2.47.3

