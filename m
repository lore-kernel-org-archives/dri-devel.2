Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B6CCA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7505610E6D6;
	Sat,  3 Oct 2026 00:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R4rCdvbc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dsFLpYeg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C8EB10F9B0
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:03:10 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeAvj3337217
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 44NLFpPE8ZdO6HqDLmJN/0Wy5T0B4W+VTtDVgGOjxNo=; b=R4rCdvbc4C7Yb5Iv
 b2bwv1nfYfvAqtDvQexaGnq1EZXe5S+laS6w0OxBYLM4fsdVklgFebKq/0z6oaCi
 xX3V0i/ImOCnFNZPXaVegu1EVa3Vj43S/aj0sZEF1QoqtqdBfl29HpfzzAF9WmbJ
 fVkaMvdwupR+n/eGBd/z6xP7Ub74cBfwu2SRyc6Oc0HMj7To2Roj+794nb4BHAzc
 Dc2eG/21f7JzBVi2cs42rkxOOlEWxZMBfHqerInfboGIYs6piv+8yJjD7zSVPqE2
 EUHHWuJ9kG2miye6rhJO4Aotk0aKtQdH306l8hOHDcJ0QhtDuLfSF31kBlAdBm6Y
 j8RiYA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2aj031f6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:03:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a082c014aso27681285a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790985789; x=1791590589;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=44NLFpPE8ZdO6HqDLmJN/0Wy5T0B4W+VTtDVgGOjxNo=;
 b=dsFLpYeg8DmIUcnE7PkeXPpRDaqpXrCfJcMWKdonZoVHRB6Nvg+W4B5m0HdBZkvyO/
 LoIU6+P/MUXk8cIx8Sx/FZOSbVquTrmlBxiRVTGoBSy89mNG1aLCErKqFaJ6RT1x2ubF
 lixcDkaV/6s/w/Q2kdooKzk8v/lz8/zHkdwGaxJlD67UDqV8pXCeAhvbZ//oO33z6tHs
 4jARqIN9/hW09b3JqnZM5szMksa17XXKQdlPPwGLXTANAwnty5kiqXScAPXHM6FBAGL/
 lzHvvQ3FMTWp2bC2Awrke4SYF3DitPNravYyCe7n+U3hIRq8a4rBb/mTWHGbcjZodXX5
 0toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790985789; x=1791590589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=44NLFpPE8ZdO6HqDLmJN/0Wy5T0B4W+VTtDVgGOjxNo=;
 b=GXPx8yleZmdRPECM3HIR3r4QVWOvuRr83dlLRnYcQES+33iLuUD+SV2MAwitHzCAUA
 xxMUsXubiwnUBtneDnkGAq+mXtB3VMP4SH66n/tQ++fSlBC+kDsNu/y4VyVXdmMQjYgs
 zMw5X1XV9/M/g1HP9t5KKvAZdpPhn9ka5hwxe4OBybrysYlgI1X/46Ufp2naKRnkE2eC
 30xGWLaKLatq75k6quVpImHg5YgfuClUZW4STPd9Ce6Oc2VdP2ZDL0P+gAUdNrhvRsL5
 PJb46Ra0DA7BrvwDy7X7YxTorFY3YncceSmQRRv4sTEq6I1PK4Txvaf9Tfc5tsuXyG+t
 QKlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkm3FMG1RRABLqlr2KGsLuDgv/JQWzAKOPc+ClpaXL/LhK2t1UMP94IbqR3uN32IVaLpJiqnVg3AU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++la/KEjBWBpfM/bupQvf3k+z9HJ3+zVRA5E4DNrXW8xJK10IVOP
 wL7m//kNWQgi52lGyXrNclJAruk0QPIOkEOuvqpVTUPJXtqAV6025CFLpuLGPZT8hVXbA0f0DVq
 Lz6ctoELKnsE93nXRG3kjK07fsYwp0UTg0f8ncZGtaUn5i8cXjXd+4b7aKb/xx1llvT5f9S3vpl
 LP2b0=
X-Gm-Gg: AYBFou2ignty4H5kW0Loalgk8qTXiT/6Yp0sL7Mxaneab2J4e0X61wLF+i5OhV4d6qF
 bu2boSI2dG92czojm3ApIkQA8RQk3uvtMVDsOTFR26ZMV3xhA9PYhSzaCsXaPGMOKQ/dG8Czrse
 sphyFII/BObddU0Cxdp/1EgfTNSaH9HcCbJeNNyxspNc9w+mYjwDwEVxjf3IqHi4ZToC7r1ied6
 FTUQSP9Qoul+0QNQd/FZJKHyEWU+94cHWQWWUiQj/dWiPsnOdnVnhXu1/XQYipTuGSjhkhKW4Gn
 +jm7cf1ZgVrDd71B6jZpl6x9DHmClbX8CR3UsEbKRYNTLfUq4iwo1ea8RD6gtEYP1DS9ibyzy4h
 RV++GGXsDfGIp6pIDR0y3ZlUGcU+0K4XhdDNRdHHrBhlR6vQOY//ezhsDEYFpzRc7n8fv+TVi8c
 +Cvk0Ux3tVDVLa
X-Received: by 2002:a05:620a:7088:b0:93b:d88b:ee01 with SMTP id
 af79cd13be357-93cb5c4dd5fmr1632720585a.34.1790985788869; 
 Fri, 02 Oct 2026 17:03:08 -0700 (PDT)
X-Received: by 2002:a05:620a:7088:b0:93b:d88b:ee01 with SMTP id
 af79cd13be357-93cb5c4dd5fmr1632714385a.34.1790985788333; 
 Fri, 02 Oct 2026 17:03:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e2f7b4esm14234531fa.14.2026.10.02.17.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:03:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:03:02 +0300
Subject: [PATCH 4/5] drm/msm/dpu: enable 3D merge when there are more
 mixers than interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-dpu-quad-pipe-fixed-v1-4-6a6a00917b71@oss.qualcomm.com>
References: <20261003-dpu-quad-pipe-fixed-v1-0-6a6a00917b71@oss.qualcomm.com>
In-Reply-To: <20261003-dpu-quad-pipe-fixed-v1-0-6a6a00917b71@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jun Nie <jun.nie@linaro.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1803;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=x2U68697ySuHlAjEIAMBnxsSwSjU9Y4ak2l+lWJyMrA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEY0VnOP7gP6vJRj9JrS41FbONPrVB8m4RBsN
 YmBs9IPgTKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBGNAAKCRCLPIo+Aiko
 1azrB/9+sqJG86unJ4o4I/jwihLrJHUZTelcwVaI2Kn76A6cvnyROTz8lp7SwIhP6Fd0hNsqFWQ
 x3z1lu4veKJRYwEXVin2mVq/LNZuqrTGELwb9X6Vd7ZAW8CpZ6BZwJIRdvH3WVX9odSehTzTrzh
 PqJGQWDiyVvSVULJf3H2YvALOGAr8w4MLdfofKUszR9RPQXGc6qMsK9Tbq2D2RLPcmaxcd/QItp
 rExEOstnNoMxaGtYnBMdMLOTe6/IHZtH70SPKk6ho1c1gafK66dCRE0mPdMowMAbQaTb3yetSR0
 z5bwX6BUHN10INw91MfBQ33QHTEakEMT4bglFtCekYn2OcGT
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA5NSBTYWx0ZWRfX46SL+bdrQgv6
 9qIlISXZV7i9Z0FAu/45v0iyXc3ILhM2v/yULSKhiw1EVgRuFZdvQu25k9+LJY+O1EKhRSd8qqx
 CpIgF4CZ+QFi6OyCrrb5F66hpyyjJ4g=
X-Proofpoint-GUID: L-CikiOg63XWbrc--u_jy3Zx2FQTdWAa
X-Authority-Analysis: v=2.4 cv=UJZIjyfy c=1 sm=1 tr=0 ts=6ac0463d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=-SFlj5aAlSBlHhkUAg8A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA5NSBTYWx0ZWRfX+1nei/zDalh6
 R/88TozNgrqS+boQi0uBHT/adj//Dt2PT7pjjgec9nUMpaCw5x3qTLKGgcDRLY76CggWkkUxwHf
 AbN8X6qASfENRQmS/oXg3C0868u4/D9zy7lDqQ7FgcIwzHW+yCHoIsHE1RGBtqnIJ/+IsXOO/RZ
 fGkKi9Oc7MD52NMjsaP9m13O/FWObCV64xtWuRtlhTNw+7uJznx/1VNGy6/FPh/Mw5cUYmVvBZu
 lGGSq5/pxxs4HWKbvXp0k1we82FbNdvRSZ39Dp+Xf2Zy7OzK4mPU2gPXmqY2nwqHx/PiAaoKJzu
 Hw09RECSslx2iWKuyHH1AWW1/AtWiXfGwh/lY7i0GP/5esgXp3dR2MD14qxFoQauldMUIOBWnVH
 M/HyhJOBRYY6+wvH8xONVg+oRIjWApppvnH5OwjPUFIABMLAprvuwKWgw5o1nA2d3HCsv9t2kJx
 aM2NeaZjft4onVkcNrg==
X-Proofpoint-ORIG-GUID: L-CikiOg63XWbrc--u_jy3Zx2FQTdWAa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020095
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

dpu_encoder_helper_get_3d_blend_mode() enables the 3D merge only for a
solo physical encoder driven by two mixers. This covers all the current
topologies, but not four mixers driving two interfaces without DSC:
each interface is then fed by a pair of mixers, which has to be merged
too, while the physical encoders have the master and slave roles. The
3D mux would stay disabled and each interface would output the data of
a single mixer.

Enable the 3D merge whenever there are more mixers than interfaces,
unless the DSC merge is used. Nothing changes for the existing
topologies.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
index 61b22d949454..d24e39597f2f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
@@ -294,15 +294,16 @@ static inline enum dpu_3d_blend_mode dpu_encoder_helper_get_3d_blend_mode(
 		struct dpu_encoder_phys *phys_enc)
 {
 	struct dpu_crtc_state *dpu_cstate;
+	unsigned int num_intf;
 
 	if (!phys_enc || phys_enc->enable_state == DPU_ENC_DISABLING)
 		return BLEND_3D_NONE;
 
 	dpu_cstate = to_dpu_crtc_state(phys_enc->parent->crtc->state);
+	num_intf = phys_enc->split_role == ENC_ROLE_SOLO ? 1 : 2;
 
 	/* Use merge_3d unless DSC MERGE topology is used */
-	if (phys_enc->split_role == ENC_ROLE_SOLO &&
-	    dpu_cstate->num_mixers == CRTC_DUAL_MIXERS &&
+	if (dpu_cstate->num_mixers > num_intf &&
 	    !dpu_encoder_use_dsc_merge(phys_enc->parent))
 		return BLEND_3D_H_ROW_INT;
 

-- 
2.47.3

