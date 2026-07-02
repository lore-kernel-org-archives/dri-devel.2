Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0A6C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C2FE10F276;
	Thu,  2 Jul 2026 09:37:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lba82xM7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qf1PeMbE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C09C210F276
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:36:59 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6628mxud3050526
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 09:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MctYkjewwWBGvbfRpPa8310fss6i++Wo9tL49fnfFqQ=; b=lba82xM7SIyC4KWE
 1IlWvz1n9Dyhas2t226nZBxJxFXkrIT1QMaci9iJNJWasSrxKC2vMLLpmjDuEq2C
 7Ps8bUCtXnEhOni/zaHVrCgP6/sZjYTZKWbwlF3wdR4DnyxGxLOPkK9tO0Mrqwhu
 sh+kOkEI9E8r4tbmO/mjGYmOEtt7CN1aUyP2LueG8Lb8l2btk334uwQBcgRr5hut
 OMgnX/7IRlxSOraP4rM4M3ddbX4gnR4Ss/0r+92c0/rj7sWOXFS5JT7LwCSdUG/S
 mBJGR+lgbZ2S2NLQy/LEZoAKzbQwsyJC1gRh7Y/OV9VU2PWN1iOxBIVdOKn4qsCF
 DDv3JA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f58k3aupq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:36:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ac0a54110so212149085a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782985018; x=1783589818;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MctYkjewwWBGvbfRpPa8310fss6i++Wo9tL49fnfFqQ=;
 b=Qf1PeMbE3HV/8HL6zlVOTQKWVGlTzA31pMT8hollHptb74s3tiA1O2oWuqWtK0rJht
 1mpLl55qc2sgmIGJcJ0V3+sjFBVVTiP2nDxv9Cg+8G9P6jWpPPcNLrUC3uBFy8+dLZDa
 Nuy46NiSfJ/q0o37ve4XC2S1caQkRK04mVCu/rOcWyGD/6vyaira/tn2rsOq9wkE68mT
 dFikQBQr4ggXpmmf2P/jycDwm016KuyQO069xX6RN+461Suz5u1/Y4uVdlPhSdlIHALr
 lPbx/pWztwSggQ/TNXhBMX5ryxja7IauXXJqE0qqCtaqLQ6byu/gaDy8SN0FeFSOj6zZ
 +HVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782985018; x=1783589818;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MctYkjewwWBGvbfRpPa8310fss6i++Wo9tL49fnfFqQ=;
 b=SsTdx8gXxKSbhDJI5QcgEftifyvMRdjYsZrniz3oIyC39QlXfN+GxsTVaPOe78SIL+
 99MkiW7MMRktAA0/SeiM75a3DdIsqst3lt8ky5I1v7WFRdga6CjIgBGye8OZbPzkiiYK
 mrUS64YGGW+rZMOKLLzOcqhm2F6x5aUfCLFMn7//mcqrwBR7sNIULxKCMYK0hmaCA6l7
 +9Myo8MoAFZg6nnXEqvCFj68aBhWnQN+R8Pr1mbiK+INz027SehlIicioxPFiFpU6xVW
 AcXF7mER6G3OJtaewPFhF1DPhueJ09/X0H6fYLGoqdVSvBlQwjYc94Cw+sDTXbbWXuBp
 D3ng==
X-Forwarded-Encrypted: i=1;
 AFNElJ+I5Quf0gCdVqbhDPo3pG1UoktVMLw7Hdqaj9EYX5mKHopvKVGBWcFvtGs1Ov3cUjGkm5l+rv8bUUs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5dQrlHgJ2ojlPcUqrczRP+RbLHTMjAJ5UZkv8sVQWCAFtBfXE
 1dJzAZB1IVhraQ43seK0pg7jI7T9L27j3n4W6PcsOFQRI2RgwnkO7WWpW3Uam+cVKlgc1JifjGl
 2n5CvOM0Yg6D8UAtNVJ2u+lWepY+Pz2VYZk/5KY9HInmCGyUivRD0wTYXU5252K6ckHZAyps=
X-Gm-Gg: AfdE7ckzNFfm02t6hzE5K1EpCwGMwmsjSeH7slYc5u2RCVmcMy/hnCriPqdteQYsM+3
 Km7DM9lKhp0Y07HQtDTLoIePVQd0B8RGDkAQKOVNwlTMIH6OSN4Fdket5pVEfAXTYpj9vFCflJt
 lSwMuMbdImz6N3eUTr9uL394EoD7d6sysvNItMfrta4RwU7VfMZpulWFDG0Dn2J3/JUWY4yO49v
 YowzLoVJNKXwE9tj+1+8NfUPOSyxzyF6nsL2kGiy4aP98Dij6+Sp5T6xdRtxCHnPTOoUX5QmlaF
 E6fy/kI7T2rIyFQU7ktorTxLiQQus9aeIXY8Mn6E1irmGSArKii8RJG+ARZKPUAMDFTwwrRaokZ
 53e922CqC7QYmxgX/jaiySmGZqNe70MiQRVE=
X-Received: by 2002:a05:620a:470b:b0:915:9984:5781 with SMTP id
 af79cd13be357-92e784da439mr669217785a.51.1782985017991; 
 Thu, 02 Jul 2026 02:36:57 -0700 (PDT)
X-Received: by 2002:a05:620a:470b:b0:915:9984:5781 with SMTP id
 af79cd13be357-92e784da439mr669214685a.51.1782985017477; 
 Thu, 02 Jul 2026 02:36:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.174])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3db964sm7101335f8f.8.2026.07.02.02.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 02:36:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 11:36:41 +0200
Subject: [PATCH v2 2/2] drm/msm/hdmi_hdcp: Simplify register bit updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-drm-msm-hdmi-cleanup-v2-2-a4a4f0e8895b@oss.qualcomm.com>
References: <20260702-drm-msm-hdmi-cleanup-v2-0-a4a4f0e8895b@oss.qualcomm.com>
In-Reply-To: <20260702-drm-msm-hdmi-cleanup-v2-0-a4a4f0e8895b@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9452;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=REG6+aa6GfDD+CkcLqDsKzEN3hrOPesgI+DFf4KGPkY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqRjEwf6QsDrWHy7jFhsHk9EtzBVZhEHAnyKolB
 squMmAFAWiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakYxMAAKCRDBN2bmhouD
 1x9QD/9Y8yGAdCkCTkts6vmz8HgHF7seJC3aS4SN2cWzLE5IzBotb68mYpabPNkkPcIEbakJk2u
 E+WhMzK2DVAARORyURTQDjlQsNss3M8habEyy8TEV3pQNTybaImr14cXdJVCaAN4IyTW3f8KLPJ
 M30xVMIbI7aE3YilqME4BtK6nVLX2zN7j6BdCefX6Ie+dRUrTGv25vRACuehkOwTs93oz3W7v+Y
 PHi+uyqV945MeMb6ZNOLQqQShOC5y+37e4/KHldBjn3B8iT4E3Ppz6alETdqsUYJbd0QC3l38nj
 z3maOBdQfxiycIVPxb4QRYCHW4c1MIkiF78w+8osQymeO58XouF9ycqxd/4nrgEFI4u0l4UmmX6
 knpvUVGO/MYTq12jnvVHBDQJ9cBInsuJSH5/dEPW9mrhNWyllB8gxkNiMhrxM2CLps/lugrwt/i
 UXfhiQu6pciVdzeqbdyBNalCe5TI66wW/bNEgtoYc1s4HbGRf8iJKF7g7DmIDsHZC5GRmJWGE6O
 aFUXu704risoZXe3Qtyu1F1eeruaWgQMnVGm3NspumPI6qcYG5DNyc9Zc5H10+/Sjoo8ovUwzlJ
 T4D1smQORVro5kugajqKZgzvZXcvfaAMBE4EZ/EzILaKwaN8aqbuqUblb6LUR0oMqxQbTLLtI+R
 ruf5zIzSG/jrL8A==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA5OCBTYWx0ZWRfX+jOjkzTx7sB2
 ucpzefSbPyhaU+NeF0RrkcQ36aW6dgXQw9tKCUSFSdH55rBIvPgJRGAmWsoiZaHwkm9Tguvs2x+
 lh58caHD8HM2tBWMModVxNiOIDJXfCUeMCE4bndjtsHRLwK2ITg0lgD0A8V47S3pb63uOVTay+b
 8usOV1BKJaYqUqddrbdtGGtY0mX8QcB+cFjCAciO2vCDDJQhSje1oQUo2WdkDAt4/g5h5So/vIA
 GvHEfvrwoTb8iQsvAaV5Xf1SeW0fLS+4QFrkdVxgfgxEk2iJ3bnlTUX2IJhXoBf3SI5LHNnjOXo
 zjf4RzKk55kgKGGkqNxqtLNtZ9cwxjbmcheWhUkE4zuBWTRcvCKfhTRSdK6UWAl+Ac4UW8sqqKy
 014A4FwTecZObQTMRLza8/7jxLlLkRN//VujGM8YYdEo+4MzQLkufL8qy0KLgEUPSMgiF43frjD
 TVT6meUDDTAkZCKdocA==
X-Authority-Analysis: v=2.4 cv=SuGgLvO0 c=1 sm=1 tr=0 ts=6a46313a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=kVIxuixzSQivcz-PG0cA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA5OCBTYWx0ZWRfX1S92tqioVIEu
 hWQ/HtuoLS/92vnn4bifOm+0ozOOBbi56nRXMS5hQrNvusUOycUE0TLmZslGVDvcZaaJQLhnSbZ
 2c/kLb+84LVT0M/CezKYNE/oYCh3kdE=
X-Proofpoint-ORIG-GUID: Rbipy4GmWYM3LOsQUWoS1H_cf6z8vyL7
X-Proofpoint-GUID: Rbipy4GmWYM3LOsQUWoS1H_cf6z8vyL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020098
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

Simplify reister updates (read, apply mask, write) with a wrapper to
make code more obvious and avoid possible errors of reading and writing
to different registers.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c | 85 ++++++++++++------------------------
 1 file changed, 28 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c b/drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c
index 8fb5497aac9f..7862bd67d154 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c
@@ -306,9 +306,9 @@ static int msm_reset_hdcp_ddc_failures(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 			HDMI_HDCP_DDC_CTRL_0_DISABLE);
 
 		/* ACK the Failure to Clear it */
-		reg_val = hdmi_read(hdmi, REG_HDMI_HDCP_DDC_CTRL_1);
-		reg_val |= HDMI_HDCP_DDC_CTRL_1_FAILED_ACK;
-		hdmi_write(hdmi, REG_HDMI_HDCP_DDC_CTRL_1, reg_val);
+		hdmi_update_bits(hdmi, REG_HDMI_HDCP_DDC_CTRL_1,
+				 HDMI_HDCP_DDC_CTRL_1_FAILED_ACK,
+				 HDMI_HDCP_DDC_CTRL_1_FAILED_ACK);
 
 		/* Check if the FAILURE got Cleared */
 		reg_val = hdmi_read(hdmi, REG_HDMI_HDCP_DDC_STATUS);
@@ -324,28 +324,22 @@ static int msm_reset_hdcp_ddc_failures(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 		DBG("Before: HDMI_DDC_SW_STATUS=0x%08x",
 			hdmi_read(hdmi, REG_HDMI_DDC_SW_STATUS));
 		/* Reset HDMI DDC software status */
-		reg_val = hdmi_read(hdmi, REG_HDMI_DDC_CTRL);
-		reg_val |= HDMI_DDC_CTRL_SW_STATUS_RESET;
-		hdmi_write(hdmi, REG_HDMI_DDC_CTRL, reg_val);
+		hdmi_update_bits(hdmi, REG_HDMI_DDC_CTRL, HDMI_DDC_CTRL_SW_STATUS_RESET,
+				 HDMI_DDC_CTRL_SW_STATUS_RESET);
 
 		rc = msm_hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
 
-		reg_val = hdmi_read(hdmi, REG_HDMI_DDC_CTRL);
-		reg_val &= ~HDMI_DDC_CTRL_SW_STATUS_RESET;
-		hdmi_write(hdmi, REG_HDMI_DDC_CTRL, reg_val);
+		hdmi_clear_bits(hdmi, REG_HDMI_DDC_CTRL, HDMI_DDC_CTRL_SW_STATUS_RESET);
 
 		/* Reset HDMI DDC Controller */
-		reg_val = hdmi_read(hdmi, REG_HDMI_DDC_CTRL);
-		reg_val |= HDMI_DDC_CTRL_SOFT_RESET;
-		hdmi_write(hdmi, REG_HDMI_DDC_CTRL, reg_val);
+		hdmi_update_bits(hdmi, REG_HDMI_DDC_CTRL, HDMI_DDC_CTRL_SOFT_RESET,
+				 HDMI_DDC_CTRL_SOFT_RESET);
 
 		/* If previous msleep is aborted, skip this msleep */
 		if (!rc)
 			rc = msm_hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
 
-		reg_val = hdmi_read(hdmi, REG_HDMI_DDC_CTRL);
-		reg_val &= ~HDMI_DDC_CTRL_SOFT_RESET;
-		hdmi_write(hdmi, REG_HDMI_DDC_CTRL, reg_val);
+		hdmi_clear_bits(hdmi, REG_HDMI_DDC_CTRL, HDMI_DDC_CTRL_SOFT_RESET);
 		DBG("After: HDMI_DDC_SW_STATUS=0x%08x",
 			hdmi_read(hdmi, REG_HDMI_DDC_SW_STATUS));
 	}
@@ -399,7 +393,6 @@ static void msm_hdmi_hdcp_reauth_work(struct work_struct *work)
 		struct hdmi_hdcp_ctrl, hdcp_reauth_work);
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	unsigned long flags;
-	u32 reg_val;
 
 	DBG("HDCP REAUTH WORK");
 	/*
@@ -409,9 +402,7 @@ static void msm_hdmi_hdcp_reauth_work(struct work_struct *work)
 	 * AN1_READY bits in HDMI_HDCP_LINK0_STATUS register
 	 */
 	spin_lock_irqsave(&hdmi->reg_lock, flags);
-	reg_val = hdmi_read(hdmi, REG_HDMI_HPD_CTRL);
-	reg_val &= ~HDMI_HPD_CTRL_ENABLE;
-	hdmi_write(hdmi, REG_HDMI_HPD_CTRL, reg_val);
+	hdmi_clear_bits(hdmi, REG_HDMI_HPD_CTRL, HDMI_HPD_CTRL_ENABLE);
 
 	/* Disable HDCP interrupts */
 	hdmi_write(hdmi, REG_HDMI_HDCP_INT_CTRL, 0);
@@ -431,9 +422,8 @@ static void msm_hdmi_hdcp_reauth_work(struct work_struct *work)
 
 	/* Enable HPD circuitry */
 	spin_lock_irqsave(&hdmi->reg_lock, flags);
-	reg_val = hdmi_read(hdmi, REG_HDMI_HPD_CTRL);
-	reg_val |= HDMI_HPD_CTRL_ENABLE;
-	hdmi_write(hdmi, REG_HDMI_HPD_CTRL, reg_val);
+	hdmi_update_bits(hdmi, REG_HDMI_HPD_CTRL, HDMI_HPD_CTRL_ENABLE,
+			 HDMI_HPD_CTRL_ENABLE);
 	spin_unlock_irqrestore(&hdmi->reg_lock, flags);
 
 	/*
@@ -456,7 +446,6 @@ static int msm_hdmi_hdcp_auth_prepare(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	u32 link0_status;
-	u32 reg_val;
 	unsigned long flags;
 	int rc;
 
@@ -472,14 +461,11 @@ static int msm_hdmi_hdcp_auth_prepare(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 
 	spin_lock_irqsave(&hdmi->reg_lock, flags);
 	/* disable HDMI Encrypt */
-	reg_val = hdmi_read(hdmi, REG_HDMI_CTRL);
-	reg_val &= ~HDMI_CTRL_ENCRYPTED;
-	hdmi_write(hdmi, REG_HDMI_CTRL, reg_val);
+	hdmi_clear_bits(hdmi, REG_HDMI_CTRL, HDMI_CTRL_ENCRYPTED);
 
 	/* Enabling Software DDC */
-	reg_val = hdmi_read(hdmi, REG_HDMI_DDC_ARBITRATION);
-	reg_val &= ~HDMI_DDC_ARBITRATION_HW_ARBITRATION;
-	hdmi_write(hdmi, REG_HDMI_DDC_ARBITRATION, reg_val);
+	hdmi_clear_bits(hdmi, REG_HDMI_DDC_ARBITRATION,
+			HDMI_DDC_ARBITRATION_HW_ARBITRATION);
 	spin_unlock_irqrestore(&hdmi->reg_lock, flags);
 
 	/*
@@ -498,9 +484,8 @@ static int msm_hdmi_hdcp_auth_prepare(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	hdmi_write(hdmi, REG_HDMI_HDCP_ENTROPY_CTRL1, 0xF00DFACE);
 
 	/* Disable the RngCipher state */
-	reg_val = hdmi_read(hdmi, REG_HDMI_HDCP_DEBUG_CTRL);
-	reg_val &= ~HDMI_HDCP_DEBUG_CTRL_RNG_CIPHER;
-	hdmi_write(hdmi, REG_HDMI_HDCP_DEBUG_CTRL, reg_val);
+	hdmi_clear_bits(hdmi, REG_HDMI_HDCP_DEBUG_CTRL,
+			HDMI_HDCP_DEBUG_CTRL_RNG_CIPHER);
 	DBG("HDCP_DEBUG_CTRL=0x%08x",
 		hdmi_read(hdmi, REG_HDMI_HDCP_DEBUG_CTRL));
 
@@ -537,15 +522,12 @@ static int msm_hdmi_hdcp_auth_prepare(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 static void msm_hdmi_hdcp_auth_fail(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
-	u32 reg_val;
 	unsigned long flags;
 
 	DBG("hdcp auth failed, queue reauth work");
 	/* clear HDMI Encrypt */
 	spin_lock_irqsave(&hdmi->reg_lock, flags);
-	reg_val = hdmi_read(hdmi, REG_HDMI_CTRL);
-	reg_val &= ~HDMI_CTRL_ENCRYPTED;
-	hdmi_write(hdmi, REG_HDMI_CTRL, reg_val);
+	hdmi_clear_bits(hdmi, REG_HDMI_CTRL, HDMI_CTRL_ENCRYPTED);
 	spin_unlock_irqrestore(&hdmi->reg_lock, flags);
 
 	hdcp_ctrl->hdcp_state = HDCP_STATE_AUTH_FAILED;
@@ -555,7 +537,6 @@ static void msm_hdmi_hdcp_auth_fail(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 static void msm_hdmi_hdcp_auth_done(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
-	u32 reg_val;
 	unsigned long flags;
 
 	/*
@@ -563,16 +544,15 @@ static void msm_hdmi_hdcp_auth_done(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	 * there is no Arbitration between software and hardware for DDC
 	 */
 	spin_lock_irqsave(&hdmi->reg_lock, flags);
-	reg_val = hdmi_read(hdmi, REG_HDMI_DDC_ARBITRATION);
-	reg_val |= HDMI_DDC_ARBITRATION_HW_ARBITRATION;
-	hdmi_write(hdmi, REG_HDMI_DDC_ARBITRATION, reg_val);
+	hdmi_update_bits(hdmi, REG_HDMI_DDC_ARBITRATION,
+			 HDMI_DDC_ARBITRATION_HW_ARBITRATION,
+			 HDMI_DDC_ARBITRATION_HW_ARBITRATION);
 	spin_unlock_irqrestore(&hdmi->reg_lock, flags);
 
 	/* enable HDMI Encrypt */
 	spin_lock_irqsave(&hdmi->reg_lock, flags);
-	reg_val = hdmi_read(hdmi, REG_HDMI_CTRL);
-	reg_val |= HDMI_CTRL_ENCRYPTED;
-	hdmi_write(hdmi, REG_HDMI_CTRL, reg_val);
+	hdmi_update_bits(hdmi, REG_HDMI_CTRL, HDMI_CTRL_ENCRYPTED,
+			 HDMI_CTRL_ENCRYPTED);
 	spin_unlock_irqrestore(&hdmi->reg_lock, flags);
 
 	hdcp_ctrl->hdcp_state = HDCP_STATE_AUTHENTICATED;
@@ -1304,7 +1284,6 @@ static void msm_hdmi_hdcp_auth_work(struct work_struct *work)
 void msm_hdmi_hdcp_on(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
-	u32 reg_val;
 	unsigned long flags;
 
 	if ((HDCP_STATE_INACTIVE != hdcp_ctrl->hdcp_state) ||
@@ -1315,9 +1294,7 @@ void msm_hdmi_hdcp_on(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 
 	/* clear HDMI Encrypt */
 	spin_lock_irqsave(&hdmi->reg_lock, flags);
-	reg_val = hdmi_read(hdmi, REG_HDMI_CTRL);
-	reg_val &= ~HDMI_CTRL_ENCRYPTED;
-	hdmi_write(hdmi, REG_HDMI_CTRL, reg_val);
+	hdmi_clear_bits(hdmi, REG_HDMI_CTRL, HDMI_CTRL_ENCRYPTED);
 	spin_unlock_irqrestore(&hdmi->reg_lock, flags);
 
 	hdcp_ctrl->auth_event = 0;
@@ -1330,7 +1307,6 @@ void msm_hdmi_hdcp_off(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	unsigned long flags;
-	u32 reg_val;
 
 	if ((HDCP_STATE_INACTIVE == hdcp_ctrl->hdcp_state) ||
 		(HDCP_STATE_NO_AKSV == hdcp_ctrl->hdcp_state)) {
@@ -1345,9 +1321,7 @@ void msm_hdmi_hdcp_off(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	 * AN1_READY bits in HDMI_HDCP_LINK0_STATUS register
 	 */
 	spin_lock_irqsave(&hdmi->reg_lock, flags);
-	reg_val = hdmi_read(hdmi, REG_HDMI_HPD_CTRL);
-	reg_val &= ~HDMI_HPD_CTRL_ENABLE;
-	hdmi_write(hdmi, REG_HDMI_HPD_CTRL, reg_val);
+	hdmi_clear_bits(hdmi, REG_HDMI_HPD_CTRL, HDMI_HPD_CTRL_ENABLE);
 
 	/*
 	 * Disable HDCP interrupts.
@@ -1375,14 +1349,11 @@ void msm_hdmi_hdcp_off(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	hdmi_write(hdmi, REG_HDMI_HDCP_CTRL, 0);
 
 	spin_lock_irqsave(&hdmi->reg_lock, flags);
-	reg_val = hdmi_read(hdmi, REG_HDMI_CTRL);
-	reg_val &= ~HDMI_CTRL_ENCRYPTED;
-	hdmi_write(hdmi, REG_HDMI_CTRL, reg_val);
+	hdmi_clear_bits(hdmi, REG_HDMI_CTRL, HDMI_CTRL_ENCRYPTED);
 
 	/* Enable HPD circuitry */
-	reg_val = hdmi_read(hdmi, REG_HDMI_HPD_CTRL);
-	reg_val |= HDMI_HPD_CTRL_ENABLE;
-	hdmi_write(hdmi, REG_HDMI_HPD_CTRL, reg_val);
+	hdmi_update_bits(hdmi, REG_HDMI_HPD_CTRL, HDMI_HPD_CTRL_ENABLE,
+			 HDMI_HPD_CTRL_ENABLE);
 	spin_unlock_irqrestore(&hdmi->reg_lock, flags);
 
 	hdcp_ctrl->hdcp_state = HDCP_STATE_INACTIVE;

-- 
2.53.0

