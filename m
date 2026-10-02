Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60D7CA5FE0
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F421810E3A0;
	Fri,  2 Oct 2026 19:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mq2RteX0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R0Jy7KKj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A337210E00A
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 19:48:31 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692H6I4e1675799
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 19:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Ib3fLjMjNjCa+R4MwIblJ4
 9C5aNpt3ZHaijeoM/GS/I=; b=mq2RteX0+KqpemOtAMZw1atJMGJlwlo4DD65d/
 P7y3Kbna5RGLXw3al7nux3TRUxJcU5IJHVcW7SBfTgYikxNb3kVAG8qmeERvbqkd
 idqjZ+AqJQ+lVTCvC+2U2VkIinU6Uw2R1w6r0x3MFCM1sZCp+ElvtKTshu45NaGq
 0Sc7YUtks6u7Xfzn803kOSmM0ta6VhNKBk6AYAOBFuVF7piRcvvyQex/iKc93AXZ
 ALdgNkT3D/8t8Fbzz8rm5hb6KzQCycOC7V3P+kvO0oYQVHrkQwDyzJ3attImCdYH
 tqwsci5m5A7fSTeLdT9LJ1OWEeKcTcKkD/OmnXo5f8tYwJ6g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ft8rvg3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 19:48:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ce7a85f04so205851385a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790970510; x=1791575310;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ib3fLjMjNjCa+R4MwIblJ49C5aNpt3ZHaijeoM/GS/I=;
 b=R0Jy7KKj2zbmHXlXAm+n2Xxg++R2rS87Inrw9O9i3G7NxXsVnqswjYms2ln44xH23Y
 Tq20BgWyGGs5R9iTUWpUeBnyKFWq50cHF4q2YmHmHcCXeUlLDNzweQz3vGTdM50A4XmE
 TyPqyKxuqiIA/HrT3GjU7+Iq/GzEvRsp53dFXiLoQaunFLpCx09KdEMXBu40mZj3XJJv
 I0vgomesQw5Qj0LXKQL4aBFt/3/LAGYOfEN0bCKewIftiXo8vormFnl9YvCqItGKu8+I
 8YCZn4/ywTqMkyp9C3q3lL1GQlAmOt2DGab791d/MFu3BCx0YumdGoYS7Vmjowcym1y4
 WccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790970510; x=1791575310;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ib3fLjMjNjCa+R4MwIblJ49C5aNpt3ZHaijeoM/GS/I=;
 b=NWuPpcHtf4PLb64uNF73Diy3F7AHkO5jLk3MPLecFjHmxaU/TnAFEMAf2+QMuo0/jZ
 bsqRLuCsB3lmXy+DBONj4ho03MMrFr15wyIzVZOmzfAlyx/OrYiThODJ3tvDKZiAn9er
 ddjkT+BCnKlQTyaP39K3ZU8FqWjX3MncOoMDXOsLpwZIMb/xBSx8cWU/K0xr+SF94eGR
 8+W1w4ns0ZbdG/HQWM7K4n5CFl3WnyZiD06MXZF7Q7wIowa7qdjxpA8kqfUtSo5P6xin
 5YqcRlAYeQxpsSxrr7Sg/8Gswop4XvqjSRnwT7rDDZNNAtBiUDRovLxZmJ0u7SHRXmPU
 29Kw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtLums7EylOcdpox0EeDW99yOMUSqTHRYfZTcuIwhMC7EYw2ZBShrPe4Yw57NTjaiRBh/4wWQVOqE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nXIseZtg2KJ/zfRcgwQ8338XYcQob/IRMPhbbaeqWbjFibDHRM
 jghSV/pwX12bDziv5Ur+6A0+8+S0EYIgIwf330joprf2Z6VNNb7TmcB3BPaUvw9sl42OY2/50m7
 SHh61UfzSPZW/guh0TnUgM80gGyh2b1b8T4RsBnpFC4p4yZzQKtO/EpOjaIk/PyBkpYmuVEA2Hi
 DRRf4=
X-Gm-Gg: AYBFou3PcU56ESRPlws2p1FXVmRotTdbiR4v1inZMl/r38MxL5zhDIoKenAcj0OeDed
 WrEnHiOEbEfQ1/IIOVW5+iIqycsfSs+0I9LDYE/a9g9R63qcZPpWJ0hjp1AwZXX/U7aLYwMqwRH
 oPQUEXnH3LHmmdUM1RHe8Q7sFbake5xCzIEJ9AQDLjpIRlNAADsn4+4Q8YOSu2seigPzvP5QmKG
 p9eDfR/LKVKFG7hpURDd7yXg2IRgjikdjGYRsZItO+xdxNkioHAozHR440HygCpwW6ugrkw+p4D
 2PfpLU8BXA0DaFneqV7XEANp430EfTLETH01tAhEsOAqR44CTnGx6mkwKUm6cFoK2WbFiM/tPwC
 0L6YbQXSP8w5hGmW+EBOw5jVH/vS5oJ8zojY9mxLt9VZV+7NXR8wf9TfZ0kUZSysaSD3paYCMB4
 Eo4gC0mqeQS1k/
X-Received: by 2002:a05:620a:408f:b0:93b:d7a0:d9e5 with SMTP id
 af79cd13be357-93cf19ccc35mr616983585a.63.1790970509576; 
 Fri, 02 Oct 2026 12:48:29 -0700 (PDT)
X-Received: by 2002:a05:620a:408f:b0:93b:d7a0:d9e5 with SMTP id
 af79cd13be357-93cf19ccc35mr616978785a.63.1790970509035; 
 Fri, 02 Oct 2026 12:48:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e304663sm12054681fa.22.2026.10.02.12.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 12:48:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 02 Oct 2026 22:48:27 +0300
Subject: [PATCH] drm/msm/dpu: don't flush a legacy CTL after its interface
 has stopped
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-encoder-flush-old-ctl-v1-1-2a2f29e9b930@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIoKwGoC/yXMQQqDMBBA0avIrDsQQyraq5QuTGbUkZCUjJaCe
 Pem7fIt/j9AuQgr3JoDCr9EJaeK9tJAWMY0MwpVgzW2a42xyClk4oJT3HXBHAnDFtFdyXnvXT9
 QD7V9Fp7k/fveH3/r7lcO23cG5/kBZW68eXkAAAA=
X-Change-ID: 20261002-encoder-flush-old-ctl-45d4bbb489d8
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=4FWIx6VuylaQXp7SnJTicjNkiVgzklnGcPldcpLUBqY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwAqLlsmz3nRfDXmPxd7XaBWUqlLQbn3MpTmN6
 Xh1YWv9cW6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasAKiwAKCRCLPIo+Aiko
 1eQ0B/0cqLfLxEMbDH2p+2WQND3KvWHl+HpuVTNNSp+P/tw4rmVpASOWBgSyBj4/mdMEiFITBCp
 gTYc/HbCjy2fuK+xnSJngQc4J63/IgL0ci2eLkMVRmzFGg8ZZ4uYppe1D1l8fHhCwtZumiIEP6M
 eamnY4lLvrsoZKJqKI03dTCts2zzqS5jFQObd3zbFqkbAyDAdk0ZcR16fymoW53UUbnCqTtWexq
 Yrv+UChFe22b03FBuoSDzCwMqItNDPhBtZBql+cpbtiUfhdPkyKSNZqyuNAf3gjnH4GEs0F2zzM
 MHeeXKQsil6pYjdTR32mNb2TRcQLq91oGi5EMu/FTo1/zKVf
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: ciThSO_vfMb-axF4BwFndehfO_jFIjlh
X-Proofpoint-GUID: ciThSO_vfMb-axF4BwFndehfO_jFIjlh
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6ac00a8e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=hfaEzhZv1HUH2TEzNl4A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3OCBTYWx0ZWRfX6mEQEykJDyNo
 dySOxXl95jLUACjv2ml1FLUd5RVJFkSbZ2NomraXmbIzEHvlM92zrlswX+VRt9dfbhSw/Om1z+N
 ZJHE1tEVMcPw74qxaswApLJ/LWVq3QE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3OCBTYWx0ZWRfX5De0upo2vdyJ
 v5H9Z/MXdfXfMTik+G+SHvMGhvKRZeCY+AAEr/nJ8C5hku+CClQF5zpIxJIy/i6IHbVSPH17jiI
 Ax1/gZy7sMFMp5pWYOWIplOlmlvUPfvo8Z6qjB1t+z9gDkRq5e6OQ1tmDsmY93vZ/EW0JGOgNNu
 CyJ1/5vAcTwdV2HRvvPniudUJ7goZPYpozEAZ7KXlAjoUYgEaaz84MB8bQhZRzkOmW5Rsl4CKNL
 OOZDgbxlBXG28Uf/+xhsXKGsUQXYMdRfWeDNXSqDBTznRXd9Mr67MYbgpDkEohx5Et+wOUNd50V
 bg2gz0eLNzejrJSxVEwmmIBUZQRtsk2Dp+goefP3IcL1u65VyVzeG9DcCFt8XyF7YliDBPpLK3C
 3IOC4L1LhEc8eatT3jHjpChgjqdK4HTYTUvab7ytj5A2426j0gHOCAEp1q459Q3gjmSPu+dDKhH
 hzyVQjLQ8s5n4zvx4ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020078
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

On DPU < 5.0 the CTL latches a flush at the next vsync of the interface
it drives.  dpu_encoder_helper_phys_cleanup() runs after the video
encoder has switched the timing engine off, and still flushes the mixers
it has just reset, so the flush is never taken: the bits stay pending in
CTL_FLUSH, where a CTL soft reset doesn't clear them either.

The next display on that CTL then waits for a flush which can't
complete.  On SDA660, going back to fbcon from a two-mixer mode leaves
the LM_1 bit pending, and every following frame of the single-mixer
mode times out:

  [dpu error]vblank timeout: 80
  [dpu error]wait for commit done returned -110

Only trigger the flush from the teardown on DPU >= 5.0.  The legacy CTL
gets its registers flushed by its next user, as downstream does, which
rewrites CTL_TOP without a flush when it stops a CTL.

Fixes: 22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine disable")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 1f20695f81e3..5a06a0fbc7e1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2339,8 +2339,11 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
 	if (ctl->ops.reset_intf_cfg)
 		ctl->ops.reset_intf_cfg(ctl, &intf_cfg);
 
-	ctl->ops.trigger_flush(ctl);
-	ctl->ops.trigger_start(ctl);
+	/* a legacy CTL latches its flush at the vsync of a stopped interface */
+	if (phys_enc->dpu_kms->catalog->mdss_ver->core_major_ver >= 5) {
+		ctl->ops.trigger_flush(ctl);
+		ctl->ops.trigger_start(ctl);
+	}
 	ctl->ops.clear_pending_flush(ctl);
 }
 

---
base-commit: 5e4a3f7b262060d70cfdc7889cfe0f4aba9ea3fc
change-id: 20261002-encoder-flush-old-ctl-45d4bbb489d8

Best regards,
--  
With best wishes
Dmitry

