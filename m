Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D69CA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 632B410FA74;
	Sat,  3 Oct 2026 00:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mrW99CZF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZGWoiE2Q";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C1E10FA71
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:30:52 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Ne0653883843
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eHOhCOzc/mfTLMETVqcNmf3tHPYnwjCQ14Z/p/+aNzc=; b=mrW99CZFoTtWEbva
 ASB9L6EE7QSfHG/biXyu7a8cz+yORecTwEvGWfLwpRxiZ+VO5/qKZsk4NW0VeSU+
 zyPKTJ4FA4//2OAahM9oxuuCof6aF6Nhj1pCGjL2FOqLTAhLS7lpt7NCBrw1KGJF
 grVRXWRc5r58jay+WApPoCYfQeDks2WDDgTZF+wPTGeHwXz8QSqAC0sCC2PSrzj0
 ENi/1EjaUUY+1kfgp1twV494gRhbCkOAUzC4sAXHKZfFcYrhw54Z7NTEGN3cUcXq
 cE7Gx+eoAcUFp48OrwAcJCjYKbfHDl4VpQToz7Ppb84wmgDmE70kmJa715CUfZ9j
 lr2CEQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h26bp40y7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:30:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c58ee2116so25400885a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987450; x=1791592250;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eHOhCOzc/mfTLMETVqcNmf3tHPYnwjCQ14Z/p/+aNzc=;
 b=ZGWoiE2QhsRdxuTL4mu+wEsq0YZFkdf1kDOq7dDbqDm0BczB0aYprrManFuI5WW//D
 w8wS23JYAIbcehW+QNbx1VrEkgdWQmCVivJAC9KNwMuWTJibciMzFe7vMppgcWjS6k+3
 kvMPFO1NZ+OsZY0GpRny4E8gzonwe3B8DkuRvkSZnX+TOK3WkF2WJigYlCzXQ8FnqGZT
 uIfVQmX+E3MSFZdbZ8LumqkSEdaqI82L6Cq02dTLhlB7tJj4lQylxCVjYVSRUnNq0l/q
 ucM5sd3ZwLHb8Iyod3SGXawkhdEeCAVhSkZ/vcTV83JUjSSdH9sJkj8tamoxuRuk0TRc
 lu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987450; x=1791592250;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eHOhCOzc/mfTLMETVqcNmf3tHPYnwjCQ14Z/p/+aNzc=;
 b=iB7TkB6crCxkGSQmoPcjgtUkPRDCiJzyQtDR8HmAlTdWTZfK8KyyeJQfQnYFEJ7Vs5
 EO3eG/oXYKLcr7gcWFoKdEZ/AkrKZXVb5W24znJXBDrriIVpiLiDZFI30uiW83vSdq1s
 UsAo3GHDhZd/TL5KDnAeZz0PTLoRdmJa5XwOb5Dp5q2RAybH+eAOVLpr/6hA5Dk4FrWv
 c/U7i0+8OsYbzwgzvQkX503eX4xQr6axmpTffSwCbK6dOA8hNXi87i/MbBmbwuGVmdxW
 KJRPPUiDXIOLIzUPrVkpALAg0hsPIdTkRCTMUq+enlq7UghHZRYtf78LjRSecNHgj2un
 NxKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByQP93Ah+UVEPvdVqI5YJPKWXwJEhRNp0/lUvpoR9NUV5DHoGTEn4dxfjyjNpHZzhBjdHj/eYtj5cI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++keagshRzgHqiWPxzin9QDj4fcEdELJxMYfNC6XyighfQpWCnt3
 yX7Y5qia2v6gTLllH6u3y4juJ+vM1MJVkaBP/TLLNnpq4KPQ7klav/SxdKyVZL/dCtUBZjO5rXh
 +mm63QkvXukWknVsxYmXhfDFI4jRHf12BslONLX160WD7ORUSIlpQMPRp8+7un71T+zQbrUg=
X-Gm-Gg: AYBFou35UbYZx9I5a8zY+XCioqiIOhaW1NreNOlzOFJf/WvHS4Yvx1gKNbgpY/WGEKs
 kLP5gpzihNA51KTAnmTuMpzuhYKt3Gdy7OK00CfX4LWxLvLpUhcXI5MAeKjv/n+8dgcQlrBkZWu
 KFQHnMC1JNe+cO1qpAD1iden0HcFqXShEVKnlLuEV2lQRZ9Yg1PUxd16eWzPLFLE28QDR9rQ/XH
 5gGfL+S8PrBHdXFrWtaYBSttZrPEdXaXRdW3C24lJI/aELEZecVS0zWbqDhp+WZc+UL6sy78QEH
 7HhKKBtpykStEf46WmKXjtvy+ZjUe2b5pB6fPmfPGGQPY2MiDPdCv7HrWykLb2wrgl0h+gfJuNl
 M/LnCuOy/WLfqsphj1G5g7q10iF0zBE3swJCuq4jP+VSHFaEAsVdwS5bJbcWLvm90ZswKQ5N4kL
 TSA9ersEijgpw2
X-Received: by 2002:a05:620a:370e:b0:92e:45e4:c6e with SMTP id
 af79cd13be357-93ce7c126a2mr814747485a.22.1790987450508; 
 Fri, 02 Oct 2026 17:30:50 -0700 (PDT)
X-Received: by 2002:a05:620a:370e:b0:92e:45e4:c6e with SMTP id
 af79cd13be357-93ce7c126a2mr814742185a.22.1790987449819; 
 Fri, 02 Oct 2026 17:30:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c7957d0sm1133979e87.31.2026.10.02.17.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:30:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:30:23 +0300
Subject: [PATCH v4 08/10] drm/msm/dpu: clear the DSC blocks left by a
 previous reservation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-fd-kms-fix-smmu-v4-8-2a44d4d8ac77@oss.qualcomm.com>
References: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
In-Reply-To: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Tcm1wwjFUx6qr560GHqjRbA//0DsF7WwB3VWVPjtYn0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEyeHM3qodO1Z4dWypShC9HlO1P5tnDPFr6/S
 c53ThRUNNKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBMngAKCRCLPIo+Aiko
 1SPpB/47Q77z17jpxRb0zyfwxmrG21V9owc/wpGMXOjNrvrBp73o7zHvOh9yD5inwpjcIrd9ewJ
 jqqE/akhDolwoF//pVDm1CB0RkCP0Rxzf/++W06MnXJfjmKr/8gzRStduh0a5cpJ+BF3XLfJxVd
 Up9uDma0k/ldJxYyIu6H21VVuwKeJIFbSxQNBe3yTGxIPxxDLx6hk62fiAOyWwbZeGhsCuqkIdc
 mEVxbyuw9ym0Y1z4o0M4XjJpecjmUSeKYr49h7xJtJewkTMHZKAqH20eIBOS+MW5BbH+PkifPzA
 PWQ7csibinNcvqdoZ+SQ2tWQl8XY8/B9Jc+iRed5eLqg39ld
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=OMqyTiaB c=1 sm=1 tr=0 ts=6ac04cbb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=mN6KdvlfDCua2x_U6QQA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: qFruuS9XEvAX6JqsveMo1sRf_Iyh82XS
X-Proofpoint-ORIG-GUID: qFruuS9XEvAX6JqsveMo1sRf_Iyh82XS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX2OB5Qh/JEMJk
 FWaDILUVycT/58Hjht1b/5/7935CKjjEBY6ckFr0FgyL0GpIWXzs9lm6+7nT+bjfSaTI737rcrn
 uDLyt2gT2Zg2Sb38kEcI0EtxdOnHNJ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfXyqQs+hNhsizq
 lb71Hp+5Fnf/dpP/jZ6pCO8EXZwarCUIXjpL5gm1SJUgwXJ/Ktno5YG5VqgLRYA4miD9mr++W0D
 +AX0KpWVGe3gDMeChFXXq43YVeYI/8VrBhSO5tcGm5/ZoUWlkEZyme+pojHiLPtfx1I55V55kui
 T68WLjLZSvba3jp2rViz4Bne06R9mkEE+c0mFcaTNZQs/fzDYV4iUw4MF8vtcRYYBA797Gamlm5
 ssW/b7Qzg8pKex9PM0o/llFOnJhwVPnCCctVsOdztkb3hxVAjdsEbMsxeehOd/ha+Q3w8tmCaiG
 cDhW0AA1Y5/btxT+T8B1UGuhtuI3Bpul0L8G7tWInfa91+yLnJnbR6vAzNY8DvJvPuC+mYnPriM
 PxWgfByhpLKlWzQulpkJCFlvQx6dCaeiDaFVb9P07zRIGt+tJHRHjL//ytXbSnSJ/MYrhMJFsP/
 To01B36jFeLoq0sdknw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
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
index 6129b01c35e6..c9ea303a4b2f 100644
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

