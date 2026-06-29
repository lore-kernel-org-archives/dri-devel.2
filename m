Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BB8C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A91BE10E8A7;
	Mon, 29 Jun 2026 13:17:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L9u1Qtgp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IAILAdJ+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6850810E8B6
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:07 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASrFp2601136
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p5iB5ejigL/1+7eiQKKge0TAmtZoQNU5D3awPHwLiWE=; b=L9u1Qtgp/pADBDvr
 fYzyFPwMyqEaDFUE/w/zeWYQjIRt40bV3xr5I9608p1O+RNtPflaBzpHgFXQem7c
 zylSiodGdA7C92GvsmjyaLXC8cWRi70FmbV8+/x8tjn0paJ6GdGiEVqvxttpIKjQ
 b1+Gf79mbl3fksuf08yfvQH9kOp47+uJqb1aVn0ITzz235Fk3oXk2Ki9+gT6GmN1
 oYAHHzEopyh02Nf15TzsnN8TfXPMRKXRpm7BpdPLGJYRMw4ijDrK39xuiV8aT5Ba
 CopYCxfb4hP3LV267vpnT3tYvBmoYoshhbsvBOEctXr1qIP2wdSGLNEto7RXY+mP
 gg0Izw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw8yv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:06 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8efc093d7e5so22604106d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739026; x=1783343826;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p5iB5ejigL/1+7eiQKKge0TAmtZoQNU5D3awPHwLiWE=;
 b=IAILAdJ+rz4KzNylRTT4W08zWX4NlHIg6smuqdfsggUu4Br26N5J78jEj1vNJLeCWM
 VHixXawJN6vxy0pQGkV73JNzNXwJTwOswlitXkotFMoMpm27z31CeR/KOba1IjVtAIR+
 0XcZKTtSw1zoLn7Oa/uN1ebz4phMr/vaBvo3ACENnXPiwB7GrevbJYhxtT+97407k5Q6
 01S3n5Zhxbuykh9WhZnDV6N6WYhBX+YD4lYwWBeYZNGSaWH0J0cnEYdLcdFjLgX702OI
 Gmyr2fSYtxR5vy2NlcNStzT5I/Tmf60w2i0iGYmRWSmMJsfAM6LnTPsU4ot17aCnjH4Y
 3KOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739026; x=1783343826;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p5iB5ejigL/1+7eiQKKge0TAmtZoQNU5D3awPHwLiWE=;
 b=aalMXIBJUPdnNNJKu1taEVLBHMn17slDwE0o6ib+Mb+Lr/+DkLGxXpPo7xdWdbED4W
 exluWOuJJgPmjp1gY9V29qftWpBNCeSc7LixYsz/M3b72uxb0SO/plcGO2BKPwYBECiD
 8BNHpJYZ1BgscnsK905Bn9jZK3dW9uiBvzsHjfN8RI8lbiRzzxtUWBGPQh8XOeui+eOe
 2LbAwGkhaVOoY5dKs0tohOIzq2UzxQMGzIgC9WJBG1n7wSnjrvZuz+AdUBOT4oxWPPpN
 +gPmTF62zRD5hvKAutMKMR63yaIdtJ3MRU1DaF6n6MZvPQ2U5S8b3XI2OLKv0CIq7J4Q
 2DSg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrESBM9kdmKZ8xYzJxB5Ijl6SbMpfIIa5Aysdzch3aSUX3CcUUE5KNg2PG29ZxTinxjFH6kJotOCdE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7zzhG8vl4oEXTR8e7at0VfT6YaQxK7YUSioZ1IaeU3U0Fv8xh
 49mSiS8TbKGohxmgZQN685WLp9p5M5enqluuDtxMFIjsUHe8HSHNCCvIWmvQJ9D5Q4be+BzySim
 otTS0CohEtbLKleT4Twfg75Cbgx9r/clbBSsfbNXECNklqhVw9fQ4CTbAQSI3WH3jWa35h5Q=
X-Gm-Gg: AfdE7clKt+ZIxQel+kC2/btv/Jrdnpe7hkVyJ4CyUfuH4n5pwVhBLOOl5Wj8cgjagtM
 VLYXJLzTr2UwosMgH0ubAwW3Lc/V0uI/4f2pguAhFtg6ZMfCXnWZpfwjg1ReVZUdXAntlqt7aOU
 UdiP9zoNWH6VlyLXIpBu37sfN/p/FiXCNYPraR2iQrHpwLvlJcl4catBxgxB0g2IorsJP7C4QoA
 B4xTAgaAAvEcMkSJbPUCFMuz8+jdrBk2bdLsZ4zpBtLHkec3CGMq6fNF2JKB4PXbuQUJDHhiL7A
 47gZg4ne1bRR+ukY49L5rTA1IUz+TeRIFYzSqQ/1rYM7jitxDJX1FuiASUVXg6Qgwo1XxuOcy20
 LSXBkMeu1ph7hsa4T6XcoXlcDx4pD5s6eyiafVd6CwyNyLkLFf6qvNeN0U5qZH6t5M0NiVZm+bA
 ==
X-Received: by 2002:a05:6214:d81:b0:8f1:323a:fc45 with SMTP id
 6a1803df08f44-8f1323b0825mr19720696d6.15.1782739025342; 
 Mon, 29 Jun 2026 06:17:05 -0700 (PDT)
X-Received: by 2002:a05:6214:d81:b0:8f1:323a:fc45 with SMTP id
 6a1803df08f44-8f1323b0825mr19720106d6.15.1782739024922; 
 Mon, 29 Jun 2026 06:17:04 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:17:04 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:25 +0800
Subject: [PATCH v5 07/25] drm/msm/dp: no need to update tu calculation for mst
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-7-1d882d9012f4@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=1019;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=hs6YElQtz09tmRSdX6C0+/uz+2FoQvn4lT6aOIb3i/U=;
 b=reb60TxU1bvgNegAvfCb7OiaNN4Sn8GZVf+rYVuwoznWl6OFH3DpNLQpBi6suoqYV1kP9wqMS
 EifVdezJJlUDGZt5qlcrw7JRZzoTZAC6M/b/oLYSJlpaGVQFLrFbZzD
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXwaLiHNsNPBQ4
 CCfTtrOp44n5745F4/BsbyeMuvHLS6miD2lOyWEVB8PPOGiRtTZb7LvV6KkrR3JjiA3W86/E42Y
 f4J2nTRsRlhMA/oDDwv6uQneI4QnIMg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX9k4ClICOlzL1
 4qagL/4vMrDELXchL4P7ejAfeJmuzxQZqw28l3r/iTGt+r8s89mKNo92+3XFXbstPQU1eruUbf2
 rLr1tJbapB4YEk+E8D3NF4u8doDRTr3GPJ0wlr3rdQyIJzCxMIZIr/0e5+ukK/vc87AoJsuPrLJ
 xJzLdvFzDlsO2NFvuaPDKL21Qiog+BidXKbuDV/qD7kxffOopqZwSgHaxZl9/UZ4+0CpXU1jIWX
 i89Vgoj2CbBhn9TE4SfceDGCVAPHHnvWXa66d8pngDqpz9SEzhjMY+hTJDkU+BdEwXDqlaB6nff
 jsE1KXWno13hub4WONLpqu46S1q17Klll6cQ5xXbD2nDof3xqy7z4nPwGWA86ZINyKjgTL/n807
 6NLYL2TDo93+blMmSVSz2rhg2YZ9VypqpKuWt89CJHGEkcmhuTKpxh8s+0AHi0yXlgpy6CxpeEm
 9H838ARTDibhEbRj6mg==
X-Proofpoint-GUID: V9f0002gwIRAE4SDDbgxVDyoCv3pC6Ny
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a427052 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Hn_uEZNTG89lqFF_qI8A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: V9f0002gwIRAE4SDDbgxVDyoCv3pC6Ny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index e9aa0e254234..5b5149b160df 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2705,7 +2705,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_panel_clear_dsc_dto(panel);
 
-	msm_dp_ctrl_setup_tr_unit(ctrl, panel);
+	if (!ctrl->mst_active)
+		msm_dp_ctrl_setup_tr_unit(ctrl, panel);
 
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 

-- 
2.43.0

