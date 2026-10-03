Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C364CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C93FF10E70D;
	Sat,  3 Oct 2026 00:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i2+7A0Ss";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jvPT8neq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E18F10E708
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:27:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeebC1957213
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +fZhaZ82V4/5KLW1sTiPxhoM8r1KKvfY9E07z+Fr920=; b=i2+7A0Ss++IsHniX
 jHZr9RJOBCCvs8ix1FidNc9hpbS2hwzCdOcOBjJccM3r+epDo98tFvi+YEMli+Mz
 1kSo69Ut96F/BEilf19Uww3G8c69QkaUlCBe0ZjDrX/nYCeWXAiSGMMuGkWgAKAR
 byCgfvYXa4iwtLE0NJ/1cS4CDAzVJeY29ilSr+bDj1H2/GawkzAugsKTD5V3KmOB
 tLrHOpTsyleUv1i7EMDl0z4/N+/IoDzP0yUBqwfrsJFh4CpJCtRrUhoZng3/sCx/
 Rm2mEXj6d+1RbitUajeAUz8kUx5fZOv3DDe2wXSGx7B5NGuLD4HJ8UGD7V89biyP
 QcAw5w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2j0ks3te-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:27:17 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-917a7fffbe0so7400246d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987237; x=1791592037;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+fZhaZ82V4/5KLW1sTiPxhoM8r1KKvfY9E07z+Fr920=;
 b=jvPT8neqwDTv0o3pQ5Zu4rBNZ68pq1DcH9Vxw4dhk+aI3+ll8lOGIaUC2mCtYkj2qz
 7ybEkrkBdHRN6USCxj2xp680njX2Xg+SQRi8uPrTjIcbd9gejuwTWS8nafaSyjGhN/F+
 eUQZlv7IK8BrXwdEf38XAiEn4F8JYa++QP7PSL0vFsR/pIehgwzs/kpMiIvOU5H8WtH7
 9KfV+qZ0cgrVEba5y4vt9irhMvcD29VXF220AFMB0QFA7NPW+box/UAN4lQEG9gb7n/s
 TvE1+o9FCp7/pgNVscYXMdWhPeADTc1BtyvjRWAPS65Xn53gXMwF3AYBVhofYpVzvY6a
 nLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987237; x=1791592037;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+fZhaZ82V4/5KLW1sTiPxhoM8r1KKvfY9E07z+Fr920=;
 b=I4a+eStJrHMIi2XDRDark9VYaSwLThsNNgk2ay900/4obsyilcDz/dFXfJyNLT7dXp
 7L8+XFpwYxr5aJW3E2Bckx5NAbtHig89hiHKRUgKogpT153I8yu708c2jeOIpFq/YVS7
 dnG6OU2cCnMh3m4O9+55xIu/mUGtMCy4DMjDxNWWY028Ov3oIfQ/WehwG1xm/11c8Uz/
 mA96BfIq71zIvGmMA63bKb4wvP7hmZY/d8GSb746Dlnu6etdwdMbwGGjm1ZBm5Su9O5o
 K0iRsOpU151s6jRdgEB5nQnEr0KUaPnzjBSwis1hybVxQZUJsSIFM/IFyTJQxBRQE7iB
 +bEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzl7aDCLRQ8EAQw+AQNi1l2Vc6JdVf2RpGKcSrexTiOoEwxAg/zgaD4BlR3pBJi9LX1ie1HTy+TVKg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mUv29e4ISaZoRAFysgg1RUnUxuMQZrIXf2ka4v373majWsD79S
 QTfEUpbIV4+40OuQqldH2ndSzyxM8WEvlI/DCmyoHWcbrgIs7jniAu2BjoURPn5JUHjFvg7Gmyb
 /e7veqAOZ6F6kvygHnUOdVOY4WIDEXkQ84rqKxKri9hFh5eIOTqmZKqBWeJqfZ4ltR3l4W44=
X-Gm-Gg: AYBFou0o5Sempa8akZkCDaolvUnZh1GxKnRaqP24Lsa8J7FHwWe/UHzletnl6pf6iwI
 TuMyzGGqggUiX/YyoOBEsvmLwaAWmMy1lgTMgDQUEc4LEwpA/jf21aFyiCyrRSDS8vImnORzjg3
 N5kuNAKqH6XWUEDIcZ3nCMVzB7L3IU1hm0TACyr+NLfS7t2wmhcPoidXdrLFBfFBRdj5iAbzaW6
 DeEp1XbKlwaWoJCXlMUMVtrPRyZ3Oo5zjiE47Z8LalcHydkTjCOrcv1lzUkZzrYQq3GNerZqy+w
 gG1EXgCFZ4B6lnhf8MqoTOljAwfuLKzQNw2b9hPOCpE3GDX9Ls4xWQD5vyKGI95x6HRQyxBk+iv
 kUnxXE8Tm7bC5Nc8OzJIz0AsBIzzgbEXzt3e4qRy7isxIew6v0LgBiTRu/Ssi2jREM4lS0A2WQI
 r1/Oi25DpA9QJa
X-Received: by 2002:a05:620a:d88:b0:93b:d7a0:d9e6 with SMTP id
 af79cd13be357-93cf19ccb7dmr856258785a.64.1790987236692; 
 Fri, 02 Oct 2026 17:27:16 -0700 (PDT)
X-Received: by 2002:a05:620a:d88:b0:93b:d7a0:d9e6 with SMTP id
 af79cd13be357-93cf19ccb7dmr856255985a.64.1790987236227; 
 Fri, 02 Oct 2026 17:27:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb86e68806sm1120705e87.4.2026.10.02.17.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:27:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:27:09 +0300
Subject: [PATCH 01/11] drm/msm: fail the snapshot init when its worker
 cannot be created
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-msm-kms-destroy-fixes-v1-1-e062b7dae77f@oss.qualcomm.com>
References: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
In-Reply-To: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=WsQ21XZW4TA3F25Pv6HWJIhCOEkArUvMa6B6iciNKmk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEvfRImEwWEXqzztO+y8szwPWXJcWhAUSL3Lx
 jJ3aUKCCLKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBL3wAKCRCLPIo+Aiko
 1XpkB/9v1i+FsbBEgX2l/Y3XD9Dfm9TxNiseu2vyBSwCLlwwRTI9doiPEIuHx1zX/g1XbiLVxXH
 JL8e/xHpSdkv9UyuIT+LAu6TJ2pz9eEY1fNLREtmFOnNsK9l8XjwCX7ZM6HsZS4kP4rpc7UZIXN
 LP+i9RHDihHWw/ehyRfIaRPVSTyLpQK85ZD2GtmSHhOknK6qBaVyxC7yucToiEXb0I9kNMn74vE
 FDR5tXdrvfNec8/38HpD06qROOrVTye1ZD06WaUOyJNDoPJxFAbvB+Pz9XcnZR0bkxSPaSdwhly
 99yAK1fP9Ikp3p5ZVn2ESyYSrbD/UuA7Y0q/WYwf95b3N1RU
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX1RMbHof0wS/Q
 Yhd2yUZGEVhVzfbfe6C9mRxV5oT/z21D0YZBlgpFzGqpKnIW+0rFQdsXsZCHslrJXEFCuDto6rz
 HWXU30uhzvC6PZthMv117QwZ21nHhAJU6mgMBPYI05pKmyVElvsywQd83EBJPd2zg6H+dgl17So
 I0jpmpTM0fDxEv2WxFS1wi/p1RJR9c1ZWWBUx/Q8rTcTbfZAYrPGkNhwdPfSIW7SpYH2ZaoFd4A
 ouGioOVcL3lD+GBgxt0251KPaL+NCR2Dnv0ocJbNdp2VVRKUpN/VHb/YZ8vml9eXP/8w4qPoLYe
 RGYUClTpcur2spUO4Fty6RldLTQXRMTeVciTFusn+aDCVxWxBix+FklMnZTriNVj0KR+Ik6Z4M9
 lSRewTd22JxP0E+ugIMwWzEJvIMcCDtSZnMREpxWS5gzEpvi7yngyu+RSTnUyHh60kGdsY++Zax
 +6OAiThGjwQCzCvIbnw==
X-Proofpoint-GUID: yii3auioovUHay-EX__qhDimMZ6sTuyZ
X-Authority-Analysis: v=2.4 cv=Z8B5j3RA c=1 sm=1 tr=0 ts=6ac04be5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=D-zmcGmn4BrKCB6hg70A:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX5e6h/a9my9+2
 oQmOqKh0w3+A8EpR1hZvGOqXSeycrPDkYaSXmcfYXeOTYvm3j4XdLmJTHB1oqmOamOvaEuiCXAG
 CHkF7ZSLZx9ZPl9FKZxHoK2YcBNCXRQ=
X-Proofpoint-ORIG-GUID: yii3auioovUHay-EX__qhDimMZ6sTuyZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030001
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

