Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0000606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bAk2+frR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nfs/nb0m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21FD4112D41;
	Fri, 23 Oct 2026 23:26:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 775E0112D45
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:59 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvG3I297426
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Rez6lWrCXKWNd1C4fPh4T1jC+3Mob3goTs0GLfBz0nM=; b=bAk2+frRzCzBfsE1
 hMaJ+IpdT/5f5XliI6eVQhn6SG+FLituzh8uC/JD918Xw3is+TAf0Sw5qt2/b2Ge
 n8KdB3IUFusV7yqQhKUGHFmTzUMHCZfwezoTV7OF2JvGi1IpXLBE36PFsWLZqgOj
 uX6IYhe2KkgJ2A1WEUoUI2vxpX0g9T3BoxsukB0YeU1OC8DQAoou3LXy9dHLp2Xn
 RNPCo/tNp0J2Ts+kybtAUFcOv+qjty5GOA2LnnlHrioQbF9d7eF48kUlYVxWPOl/
 QhjxkmkP42SYcYMN69kvw3dhLc4fr1w4rG9cRgool0Fc6mJvz+FpFU9UFewuCSfF
 Kmw/zA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgaruhcjm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f568dee56so55280985a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797958; x=1793402758;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rez6lWrCXKWNd1C4fPh4T1jC+3Mob3goTs0GLfBz0nM=;
 b=Nfs/nb0mVy6NX2629bRIynjKzyKpgO+0mP3zaSq9+Sw/Sd6xuyoVkybHbZXhW1mpZX
 X5yYe6KuHtcXcxiAihkypQz9hEvyayoy1ORX7VPLMYaj0IfiuDUXDA6VhIJwiCyFAMy8
 L/NQfGaKBYUIOjzR0DQ/o/gIJ/H8xWI7P+lUrmkx6fPRtTjhjimeeRY/5GgCYtZc712e
 DO98fisIrQ3CI+be2MumNDxf1IglXkbJLm04lCnKF4AGWxvj/v+gEtMCdO/0QbiahDnl
 MpA8igTN4dW44l1Xkj874sw80MVWwSDJuTkz8uzwsoiVozm+rBVh5K1RxhnzThqs7yt0
 ItLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797958; x=1793402758;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rez6lWrCXKWNd1C4fPh4T1jC+3Mob3goTs0GLfBz0nM=;
 b=CkNmk+tMBdC4xKfo0M0c9OrjCBgh81xbYdq4oob0G+DunSrqcoUdXbBnvGY/zHF2UV
 g9LZZZR6VzL7WrKU8SHoYrtKhD/AlMkDdTzFcpb5J7FKroVLbUkNKgA/F1SDy44Xrf6q
 z+70Q0ym7tVr2fUwbATjCOLegsEcjsMesQahx0CenR1IScohMqWvUPrXguUnLtQio+E9
 Gs4Be/Rxfi6qAoofBT010CH3mvUjdOLCEBwHQEk/E1AYTRVgsZb4O95xd/mt//+ghOiu
 kDjiwIUOhPmTnam0XVLzkp8WUNVvC9v2BC43x8fF7gySXlrHC4/I+Bc9aKRehsV05xBS
 EczA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3JhUb8HAlqrR0c60lROQ3eGGp6fE1cEqhT//iO4Fl/59+6gUl4dEqF8LNjZXEGiharHzFBMpDsIk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI8V1pZyd+qTQcUrOIQKuZFv5hDtD6N432vI3IYK1USpwTXDdMf
 aZuPWX7OQtMBH0CenngxCShswUxZsFYbC+hABQByhVvTDes6FwCMDItuytVkQV3NJ0E1VdOSuVt
 qn5Tn6tquWCD/RRyylitFk+ltTIhPelOACVjXh3cIt3F63EiRO/fKqxy3y4VFXH9ZdJpQ7vY=
X-Gm-Gg: AYBFou3NVReKxe6j9aRHQ4iH/t0/2fKaLbM0KAvoI8fN+wWq3xje7V9kleI16fkWWAg
 gnUV3aD0QxkrCixd2bxw+B3l1YvCgh8EfgOiUa50kYW4AC9nYWIZf7HEMqvUceQr1FKi77pTRej
 iXzweMFgrwN7Blve/1wxq+dXlMHGlNHYrS8AH/UvHnRfbCTZCyNs3nwYTlXYNh5G1mkLw0oYZ3A
 ZrwSXQ4NijELUWnNu29K3b4G+AkT6JEdx46kstA9kGhfS/9WhItHL5UIa953/I0/+nyNjaEOxf5
 v6a4jG0FdVDCbZ+EAzjjfzGTjFoYp8gvlxIj8r4wnG8UtmCStV2CbAcGvTf4t7dIhr+eUesfdpY
 ZIgcPmJyRL2jT1p3H8Zuoc4JjGdEBc1zxswKvUPovIS3fAzsBib4tLFkWD4HmBrduO8YysGmp7x
 y7Jg5kdsdDCMWV
X-Received: by 2002:a05:620a:4398:b0:93e:5e2c:8bf2 with SMTP id
 af79cd13be357-940ef8be9aemr96329285a.21.1792797957661; 
 Fri, 23 Oct 2026 16:25:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4398:b0:93e:5e2c:8bf2 with SMTP id
 af79cd13be357-940ef8be9aemr96324985a.21.1792797957119; 
 Fri, 23 Oct 2026 16:25:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a9ea71sm60217e87.81.2026.10.23.16.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:25:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:25:29 +0300
Subject: [PATCH v5 08/10] drm/msm/dpu: clear the DSC blocks left by a
 previous reservation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-fd-kms-fix-smmu-v5-8-a5b0b284aead@oss.qualcomm.com>
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=udqMWUS3ZNDRZgnWIleo7N3VNOY49EUuFnGmacwENkc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+zrqQD/+e3M3SNpy7jUSpforrUk+5ANjdaB4
 Xy/clql5JOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvs6wAKCRCLPIo+Aiko
 1XpMB/9bNxciSLAV7RUK/wQL/hZFMaf51A3NbiaVgVEajV6jG3zFj1WArwoAqAk4fEpAc59XRcI
 Rl9vXq3y9rjlqxJD9OlRS3DoGFwligsF7bw6IV9gqfblJZSOhKn4otYSab3O3AmSxqMgGtzWB0r
 ikTl3TXPsxa9DErWd4VNAVBjbUiK2XSDN1vmfuI3uURzKa25TStB2hXZJhSk1jy1yHdc5ajyIyf
 4PtrgpJQHCtQuwUpj1yB2vfREWMB24Aihx5D/l9DSb3f6+oyKincx2qdkpbTc4oqqMH/i07Valf
 IXV6pCGUHb8/buTwa1Xy2LD0RoaJTcq74Ds6yc5zBuXwrGYm
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX0HgxAJ1wmt+X
 yBHR7HUWCmWWA3ak0k82jUUfkFosyTVzjdUE0wJjzGpW7IsqM4qNePVen6XHBO4CsjwmD0OYLjR
 LMVbpY2343hqYzsOJUyN/mYreTSMo2o=
X-Proofpoint-GUID: mEFtk8OOVDhntvzi94cDXKcajf5qtjnx
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adbed06 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=mN6KdvlfDCua2x_U6QQA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: mEFtk8OOVDhntvzi94cDXKcajf5qtjnx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXyUCgv9riJCla
 ZERQDXGfam2hjwRzAsCK0AH2VkR32gt5iuVucLVFi1c95Wu8JuKJpFQyFhkQ7QPp/pwdAoKP9GB
 sbyTv9KuA1Vkbo5uSoLHxcAWr7Hf51zO2GjpgskW9jdyr/UCXgVfWCks2yxv/L4RZJRRf3c8qwh
 tYo5PLuA22nGaDWiruqhbp4oxvN6l+XUw0kjfobvZYLK0diTZG8jHd4AttWQlOyXEhR2ps/Ishi
 71c/m4MjU0o4PyD+zQGVuPYQl14Dv82+/3OeuB/X+3l2Pn0L9u48BvJdPLAvO1huoiTUJKcmjYt
 /Gx8js3ZLR120JFUhyhcwaZacrnvVNAa2dvSINAlzxuDFkAqnwfEKRV2TmXvyR1/Ib4GMC5B17J
 8PXQzgV8R4CkfG/xnnIhLVIrfv4fQkfbgRC7SuDUaYYVtOj+TWQg30EbFPPA0g+1hlRfL092Zzg
 +jZYxSUSe/yitG5wWZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230092
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

dpu_encoder_virt_atomic_mode_set() fills dpu_enc->hw_dsc[] with the DSC
blocks of the new reservation, but only the first num_dsc entries.  The
array is never cleared, so an encoder which once drove two DSC blocks
keeps pointing at the second one after it has been given a topology with
a single DSC.

dpu_encoder_use_dsc_merge() counts the non-NULL entries of the whole
array and compares them against the number of interfaces, so the leftover
pointer makes it report DSC merge for a topology which has none, and
dpu_encoder_prep_dsc() then programs DSC_MODE_MULTIPLEX into the only DSC
block that is really used.

Assign NULL when the new reservation has no block for the slot.

Fixes: 58dca9810749 ("drm/msm/disp/dpu1: Add support for DSC in encoder")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index b337f197d3f5..419e0c6e8ef1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1224,9 +1224,10 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	num_dsc = dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
 						drm_enc->crtc, DPU_HW_BLK_DSC,
 						hw_dsc, ARRAY_SIZE(hw_dsc));
-	for (i = 0; i < num_dsc; i++) {
-		dpu_enc->hw_dsc[i] = to_dpu_hw_dsc(hw_dsc[i]);
-		dsc_mask |= BIT(dpu_enc->hw_dsc[i]->idx - DSC_0);
+	for (i = 0; i < MAX_CHANNELS_PER_ENC; i++) {
+		dpu_enc->hw_dsc[i] = i < num_dsc ? to_dpu_hw_dsc(hw_dsc[i]) : NULL;
+		if (dpu_enc->hw_dsc[i])
+			dsc_mask |= BIT(dpu_enc->hw_dsc[i]->idx - DSC_0);
 	}
 
 	dpu_enc->dsc_mask = dsc_mask;

-- 
2.47.3

