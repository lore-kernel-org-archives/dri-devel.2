Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441B6CA5FE6
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C5510E6E9;
	Sat,  3 Oct 2026 00:03:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="asQbKqKI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="koC9QmCF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 061CD10E6D6
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:03:06 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeDlD1503926
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YybtDh5zEBf5n1HBSnKt3zrXz3bWQXQ2umvjEfaI73I=; b=asQbKqKIh2o/8EDj
 losj1YeP4jpp1AzPC1XXVAvhtttxsbWvJTTxb7vCNwzzCIqvA/Yz2ZFqkUqrMTEc
 9Tx3C1ZfkGS3O25dQWovIEdooc64/0FqW5IyATVTpdtGeXnaPhrdFjwWXZsPa8EF
 xvJpJcMDNn1JzLdBPjJzeH34/MmO6EY1sNp6/n79CCDCxSoK9/Wl5w892op9yu5A
 NLQ7fvODvevJD4cQCWWEjyhORJddj5YnXf//sz2r+fGwBv9INzXUOzFwAjNtds8f
 WNogmy654UNjrfzu76dPd/N1g8gapksaCtz6d1fKR5vnCRHShcZv5OeYImQXjsGo
 rDI7xw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2n2rrayx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:03:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93bfb2da664so25649985a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790985784; x=1791590584;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YybtDh5zEBf5n1HBSnKt3zrXz3bWQXQ2umvjEfaI73I=;
 b=koC9QmCFWFepBa0bislNLaW2xSNZDhjJR/AnORWpLpZdMVzHKhhrw/GyLMi2AKnkbW
 PS6fP4mQHO9thRLpvrLfvtNqnxqzk497eMFkBEKFYncRkxB7JKsgUsa1bC8JGJ7RsUaG
 /DFX+lODHeCnzqEJr0Z5hE68T0Ws1HChK0hiHSInD7tZMdW1aMs3quXtb8/0L4OnfT67
 j3zSrm+DS3yjQWALN5ZleUUhDVo29mZY/ymKFKZc+3m8Za2C1l6XqqXN6wW7RxtxGoPk
 PMT9vBOpO4hpeT/CtLmI4XrRvplFS9CDfHKOu3moiDpuER+tTanuoD4/uDh4/P6e1fbr
 Qkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790985784; x=1791590584;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YybtDh5zEBf5n1HBSnKt3zrXz3bWQXQ2umvjEfaI73I=;
 b=EzMeONXzOusooZz+acSf3OJccidedPMtUsP2QXwvSQNEHhHt60huYgWrfKFZDpry9Y
 EG1CvI5FwrCuAupjVSX50L7liECocHHSz+9iBl+OHUZ0VhrIftasf8nBfqX8YzjxHxxM
 63ilys6zZTqublgG9vwplCAvkwJWPYzNiWJd/w93hoWNnccQy9QGM1p8xtqWiVrO0DD4
 VQ2YoqjKfql4JgltirC2eksLWR/dk3VkrHKJuqUVgGGG1G/cK3H7FR+TdmSoimZThcKI
 oEJEbo9qXuoxzKYdKFjmjkjx5zF6PdmdxnWSDpcaBstBZtK60vvzlRpsbK8L7Luu/Gtk
 3BeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByjJeLgrOTNax9tLcXEJ8gg6XsvTCk8PtLRpK/CRrv5Pxf2b+UMZt8BRVjqQULD79tU5L/H2GmVUyg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kfM3wh5AsVIrIAXP/sME6/Hiz+822L3J7E2+b7e4pNn6dxXY9I
 sUcRXkJRG63xgT5rhTgAMHB+FpSObVqW+nxLKnHmxzU6N0vf5pVwK3WFHFeewAIiZRCa3bleGGa
 28n3NofOOKIwSLYSn4gq/7HgUYInwdKRGZZSMqasjwtYwhn4HR+MEMJZcx+ck7PVSnHvJ0os=
X-Gm-Gg: AYBFou2kY2+7U2Tnu5IeSqyNJ0LclPCcnwk6qRTQRx53NjscS0kDROMcvdtmvUsmWKs
 cM/fkTaaFJq3w83IU/K7u0CTpi5LHmv4Jb4iLX9GTnRRbJPMCcBAqp7dEUCGmY90VWszoaW1N3m
 2idPcP7fhIxOlZ3cUaBZKn8N764nsXFXt4XNoKAgegDt26bzqnc/wqw7lTeMkqkD9v5yyGwZjSg
 8fdFAVEPhYbsPHUIr69p8+0Htkt0Cp3awKIJfqURx82/b41o8HD0TonQpj/iovQZ4AhVlDEb3GJ
 0d/tnJ9tJ+Br/MkmRrfsRJ06kdm1QBhTUUpuQ6KSRioWLnkVYIpqMniWNARmTi9npU6frDwOSPH
 oF4Oma7s2y++umSGw0fZtnmUeMw4D/WVhlfzP/lG0XefDJ/iAHHD4/fbfFUvd0UAvhSn9+jPrO3
 04V692JdXm4QkT
X-Received: by 2002:a05:620a:4589:b0:93c:779f:3e02 with SMTP id
 af79cd13be357-93ce7c1229cmr768036185a.11.1790985784187; 
 Fri, 02 Oct 2026 17:03:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4589:b0:93c:779f:3e02 with SMTP id
 af79cd13be357-93ce7c1229cmr768029685a.11.1790985783682; 
 Fri, 02 Oct 2026 17:03:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e2f7b4esm14234531fa.14.2026.10.02.17.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:03:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:02:59 +0300
Subject: [PATCH 1/5] drm/msm/dpu: don't flush a legacy CTL after its
 interface has stopped
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-dpu-quad-pipe-fixed-v1-1-6a6a00917b71@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=IRuLvmE0+tzW0ijRMXTcaAZ1rYCTxwdRidPidjqJ/0E=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEYzaPJb1yOKg749Bbkvh+Ud1a40lcWZEygV/
 hLWhbmEXGWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBGMwAKCRCLPIo+Aiko
 1R4hB/0RnbaZnho6vaxm/YNE51kBpPHAIdL5cZyK1p1F0i+SD1gw2iMxinqP9K+G34fE4eLN0se
 8b9q+vzJ4qGOMxSXVs7LBrbGZuc1fM0HlVALedgw1mMaDOhNKoFL0xmaj1StBwzrCNfRC+YOYBP
 u/m/hvCrNXjk7RC4wZLfUcFYd13VaagXGs6ZXAwtXamwmzvSZRr0RUP2BM/OgE8KTp4vWnsUxnQ
 i/JJfCBI4sr5ixtjzKauayzimLoJtI7GUkfMsX8dIknXeoqPbvmYcAhcxYayEM2UAuKtNfUxblr
 aUHrgVnlvnG4Yp8AwxkQeelgZelsKR5FtR3yPC801ELpAtco
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=d/VgWhjE c=1 sm=1 tr=0 ts=6ac04639 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=EynL1qdohFGk3j19l_wA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 9j-jgTvFMynzp6xDOnqaHuKeMeVgg_Vk
X-Proofpoint-GUID: 9j-jgTvFMynzp6xDOnqaHuKeMeVgg_Vk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA5NSBTYWx0ZWRfX/lagDhw3q496
 8N0fd5mqA1PDxkJn71M1l2R9PNNLA4WrEieER6ckK1jga2GXm9L1LMkSwxpHrf1yrITxX1HM8GV
 lOm+P4YTm0A9Vwu9PtECQISEyCsZwec=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA5NSBTYWx0ZWRfXwHMrlRZDrZR2
 3V7j9Z3mDwLeFS+RYTDQlPKiY90KoRqyLeU8DV7Mi53K3YHqN41ObDEjKU9iMv0jr9bPNHCiajy
 0Odc/vyGkI3z7h+XqP9AIdbHIoH/SJ+JHJvHxCodQ8rxJpD7ANHST/gVdY7nobvsTFOBfbTQk6g
 wfYFRD31zYrGzMkxFSWQSZNI5Ac130smpn2Of9wBb0idqvGsAIEAAOcaKWY2dpvubCzp8YfcnmX
 893wE7nWdbZy8SV8Pr5OY02heyZD0c1tHr/3S83BZCj5yH69VvQ2M9VgPd3oxTAoKJpJhY4/8kf
 Xwiq7Jgymh2vf658EPHuNB2w4svHzdHdXLogeYv7sUAzLRYNKSwXl0E/dWBy4wbN6htrnHr00ZJ
 ZrziVoZ4X1P073zMk8mOKJCS9J2tRTC5yRNRFRoXvNV8fxfCUT0khzoT/DLkCbEilzEhIAfYpf4
 akALOz68NQIMsNUhN0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020095
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
 

-- 
2.47.3

