Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F025CCD8CA7
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5526710E1FE;
	Tue,  9 Jun 2026 09:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BjptCqzm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DomekOH3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91BBC10E1FD
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:47:09 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6597rrs22001572
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 09:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IovUpKpDFwGWZaF4DLWER239PrNpT7oEBKFqXm1bx5A=; b=BjptCqzm590Fu46S
 SjV8Z874hVOI+rjjekLFtOZXE+FSxibiZiuAXMkC17tU4aFExizK3ZTYazEtcJZm
 6SwzytzkilEe5Keoea2/p06+1/aeI4NSX+Uf32stiHlMPAR9zbDTNU1QSa8H7RYE
 e0xvFhAc45JRq9zEeTWzJKj5YIVeyDfrSY2fPM0c3Xn9xjo8r2Xqgjrv1hmwTKRA
 DikfIdaAnQJ/pho12WAh3nPuKTnh3voeaLw2AFxwUeIfMjXVORurRvUfcVQ1Sh7U
 nn6EdL7a873RSbXiljHrlWu3N4ZqAxJ3gkLFkxJCJEefSWWfilCFVnJQeSXvQypt
 J/woNg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epe25rp7v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 09:47:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9159c4b210aso1028375385a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780998428; x=1781603228;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IovUpKpDFwGWZaF4DLWER239PrNpT7oEBKFqXm1bx5A=;
 b=DomekOH3iRCB9OVIeDIWPZSvACZ2PhFZBUVCV5Oz4tZFKHx/bC3QCn8mXvynSakU73
 ie+O2k0mep3OYCdJe+tRnEdr7QWnuAc09/WzXEMGAv2ec6P3WFw4H7uOW5iaOu+CRt9R
 Huk247dK4mktkJt6hBfKSHfycDaEzd+TocqSmtAcBxs9ZhkDj4+QwkxLaQC11ADLhETm
 6OpQmD3AT5IyCT7D9jIy+3x6N/4nlzK9MiFUsfZphSzZcMO21lE6XoGxgdWgQDvq01tL
 6vXBTrmACMZPm8552DR/Q9VIO3zyMxXli54fmnSUkvWib9WKdaVG6JGOTvdvLCYwRZ9D
 lVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998428; x=1781603228;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IovUpKpDFwGWZaF4DLWER239PrNpT7oEBKFqXm1bx5A=;
 b=iwXEwMmf6Y3YMyCJqGu54f8cBlBKoy1YzPwtEgttiup5qifHVyokAyjiqYNc+GSQ3o
 UcsQpTd1i7boWrWBM5nWNFmDHS9mtjRk9cw/e1qsyXScdNhjeCbtP74t8vXJTcxuj1UC
 UKDY7RV+NBIGMNxBDLNob8fyGoQS0eDeVcQFIobslTfLYlhfQRQvQ/aNm71xNGo1fv1p
 WUd29JUiKWW2gXsgWLXTv87MV7EOa0z9FOhsEG/XWzpwAVSiOx9H35OEUlM3/ZHbq+pF
 5ucVd5mOuDjvWV5iL0l9JVbO41ZUFZooEp8ZuFsCVK4Z6ZUFIQPqwrtRSkodcmKkoosd
 CiCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hVRiL/wmg14DogZPjiU0HH47i38RdVmzPORos7DnNpzWMGKek5bd1Pc4y93KieII227oiN0z+tng=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpGwldBQzt2ByzU0gEj4PtlgCZkqka3eL1ilNCZ8LoaYgDlWek
 a/5YvcgMbZmxQ6MHKAAKcSXI6uIHfueWERRXuBA4IknK6m7WK6mq/obHy+hnuHCP4mGaxQdNSjp
 LD/ng0DM0UA54WtPTHA7HyHeDLDo7A0gmjipVb1W9yQ15fcWS/G5SfLOeJaoW0fGU9cWLn+Y=
X-Gm-Gg: Acq92OF402vSLZ4g3Se3UmrnFDMPZ4/yT9Jl/xf2dSVxNGWkZxjuuTvXrfp15opRaHe
 LOQCJX83trnyCzPsGOW0DievO9Yk0qsEU4VfKdwthqODjCcG99aClBtHmE977OM4qc9Qrn1UBn1
 QC82S3WG6qmopb5WhNEicSFxrR8jnEhT4sprAvkxGX3ZznI3JhqGdjRhGh48htv3xNaexWvNTtQ
 DG+FPvYbSGsq2tMh5iLiTLhLmyMrP/iXvWp5DVuEgp8SlTGTvg9zH/ZZfSvn3+hipjEwQuooGM4
 dNqd2qwBKZpRKbpq443O7uZiNJYxy04LxpT8oG9M8WSdyInQnP6pchXzJ3EpGBq3ZkcOOjDBSdV
 U2VWHOp3WLu+jyn+LyjKh/BV1QmWIrLaMYODYj9+jGZcXaHv5XRSCPvrBeON2Rq+vLgB/D0agKX
 VEtf4dJBy04S35C0m5mw==
X-Received: by 2002:a05:620a:4150:b0:911:fba0:6d09 with SMTP id
 af79cd13be357-915ad1d400amr2109079485a.20.1780998428104; 
 Tue, 09 Jun 2026 02:47:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4150:b0:911:fba0:6d09 with SMTP id
 af79cd13be357-915ad1d400amr2109077185a.20.1780998427706; 
 Tue, 09 Jun 2026 02:47:07 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00afafsm2047489485a.2.2026.06.09.02.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:47:07 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 17:46:28 +0800
Subject: [PATCH v7 06/15] drm/msm/dp: split link setup from source params
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-dp_mstclean-v7-6-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
In-Reply-To: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780998392; l=1402;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=ixgmYJIVCgIesw8IPUX+/UcnW6cdOBjM+XPZmes1+Eo=;
 b=cwLlDtMB+tR/WNLTbcbaBPeGshrJL5YHvytxQA6nVZvm9k5TpQRKKVCK7YY6UwRqok38qz1YJ
 Oelf+qdAe20DObx4b+EmSxo3RijvO0qKxdXDmMwP5DNx/Pd45ZvEhSa
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: kBdAOCDeUhlhKs-rKOJw1XXNSyaVRIto
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5MCBTYWx0ZWRfX9POShCj1Viov
 0VTQDmvGI+LTRw9P3m5vd0Ud3FUP5QQFcUfjZvdmNGXU9NupvYEUuNCr2yh5u46kLkDPxaxu+ZC
 ttrUajMHHyR2cFlgFozssoqMXdkCrUjPAdHlM20cyWj7Gyoob+oEiVcy/zmSjdROtX5lv+eucto
 k2K06Eb0n5bsY0Vgf7s99gSJum7XCUXJDnW+CL7VL4vaTTtkVdLYF//xAUz/EcQBRRMDluTqO64
 9FrBPYzgn/S5/mQ5qXDedF/YbZ5mkZapIwQ6ysCcLAyHRTp+XTmaoK7G/VAvsUPE+3Rkd0jJhf6
 FJjbjY24wFkfaLwmiRX2O/j0nAw4+CIqNI8zIYtaow01pvvNLIkc2qF+vFZuWUWy+Raix34pKjz
 GZZR+P2AfOMNFLZm4OdnvPHX97mnAMQzhMntsLmcFd+ZywSw44gxU7PYK6sL1VmUJPxYQvh8SSW
 jkAVvGjk+xqSfLmUeyg==
X-Proofpoint-GUID: kBdAOCDeUhlhKs-rKOJw1XXNSyaVRIto
X-Authority-Analysis: v=2.4 cv=LoqiDHdc c=1 sm=1 tr=0 ts=6a27e11c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=saXSvH3Ee-fMY4W8qR0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090090
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

msm_dp_ctrl_configure_source_params() should only handle stream-related
configuration. Move the link setup out of it so MST can program link and
stream settings separately.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 71d45b2c4daf..1c2eccec6ec6 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -482,10 +482,6 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 
 static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
 {
-	msm_dp_ctrl_lane_mapping(ctrl);
-	msm_dp_setup_peripheral_flush(ctrl);
-
-	msm_dp_ctrl_config_ctrl_link(ctrl);
 	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
 
 	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
@@ -2551,6 +2547,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 	 */
 	reinit_completion(&ctrl->video_comp);
 
+	msm_dp_ctrl_lane_mapping(ctrl);
+	msm_dp_setup_peripheral_flush(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+
 	msm_dp_ctrl_configure_source_params(ctrl);
 
 	msm_dp_ctrl_config_msa(ctrl,

-- 
2.43.0

