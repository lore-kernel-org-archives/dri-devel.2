Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FEEC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6091C10E6FB;
	Mon, 31 Aug 2026 08:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JFY34tmf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YANuxpu/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A71810E709
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:50 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xsV31844169
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GYzN3WW/T5PYDupoBOf6xq5Ubj+LwYC+2OZfV6qkjFY=; b=JFY34tmf8t/dXPYG
 8vnpRYz+ksqSqkVxTiDgIY69Qi0hiV+8CX5m//FmxtfRh9bsrqzp009BKrUXrdzJ
 wPBQFL0BXw5wCnn9VxINzGCS+AzY6rVdmwDka8oIhOjCrAzWZ0ljJA6PA7cYP+UZ
 XXnsmZtlQzEKA3UEAiiDiQ9gYxWRbkVWAM7XqqilCgVOWYpI398pPgTOUn8i15rD
 QTY18ZZEZh7R/C1CeDAmvREdY7HyAhDp1lvGd4CT24+4GkO14QpMDrTO4haykUwJ
 2AZ1REFl6Yey8AYDx9gSFTlieHmqxVvmp8sHa+KdNfbiHADpsDgzKx+fhf6KhsOy
 4hTxCw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrkgw6re-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93917f4ccb4so339932885a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164269; x=1788769069;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GYzN3WW/T5PYDupoBOf6xq5Ubj+LwYC+2OZfV6qkjFY=;
 b=YANuxpu/Gcohu7YGx7GOt8SKCxuWiwS817+UDTMW06SZlwMCQN39AQCe5tV8VWCQ7d
 EcFT+mrwu8dFobQLapxwsHes8kYJi3Ac28GdBgrOOvhAxCEyoSS+gLxeDePtUZjcuN5n
 lExCiaKHbBWVEF9RuivcF6pJXaMn1PgOC4YGBYxN0/YyfstTFwdPCygHssGeo0UJCT+b
 Ba99hBe++ujIeavmpKn6yuwFrBh5KBcLWvBD0/fBYir7mfbB/rA8BXM6l7qO4ZWU1fIv
 YSLkMWoWS3KuqgjIHinKOZm2PC3Zl/kyaYE2nrcwwUQ54U9wdxIGJSzs9t/YEYu81NLT
 1+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164269; x=1788769069;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GYzN3WW/T5PYDupoBOf6xq5Ubj+LwYC+2OZfV6qkjFY=;
 b=pgqqmc3E9f5x8cVfiswWnMzW6cNSCF7SC7xk4jrrUYBMnRS7Nj2yJEg9HZu61vzJW1
 5Qdh0ZHdtzqeS0Nra01UWrOofiarj0AuXLqU2LFhgpS6nLxS4HiaGby7sjcZpyr3K7WT
 FnHok9fP3sRQ6tK/H5Es/Gw2MaI8bGkXdK6BMltjcccDi1KxL8tGOi5+ES6Q+/h2qjgZ
 vJZPFK+wPnSBFTSxEUSco/8IY2x1aHq258wA2RWRpnn2v3N+BN2yd+D03+k9f/bNDAnm
 VIkUgVTQLUs9mY9iqaOMyC1p+3CgQDSm1MzxpJDMvROi4quOQR+R9hyc2NT4MMNmI4nv
 ZkZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnNINrKwFTvmOfxAZJidfOyAK0JH14Lp068DdgfoGQxKnv2XVpaXcJGiOcw+tlPS+mqBqnsWPOPCc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nYiaJ3dY+uft+MuD9l8aDk9qlanlwVU8dlKoM6rawLjuRlg6cE
 UCalBMgPSg6T/LtLVG9sdnQtfcXWc2ZZzgCBiQlMPQiHVv3RSt7B/O/t/r5XnmYRTDyDuoHTg0t
 Jxq835hNhgQRGCJABcdlwfIDlsrj1ywfXuZaZgbbFDSwq4HDgSiaA9zQUOr5BMRfnUvFxbjk=
X-Gm-Gg: AR+sD11IOUkzvbXI/f2UH7j1eK+3ei7TeQezAG8ZhfgzUzypdeJecWBhUDrZiHBdj7d
 bJ6AEEFCJPrzEi3bKR09FPV9MZUxOZyLxvdYo9RzYJkAmOS2Z6r2ugcfi8nurQngcFbH7GhIDv9
 UD9EeMHgWpiW+0wNhD/qdtc7luPSsgK5BBbB4qllptmMrFNvzDlOI0TIUf/uDrGzU9CXs2cmxok
 ArdKqHDs1hwspSjISQTa5g9koAJxdnCQpuq7BMVHaSjUvEoLMdo0zjTCzOc/OCdeto21UVjOIdI
 i7/WCipfFbjuKPuTtUSQCAf4apiJmrFmXyRkUUlVZNEcBncmd4KlBnVxYckXA4bWUIDig2g/TQR
 u8T/U8zHlZeDYjJpRIriYSC29G8Yga13lRVZU5SQ3IbglB/qa2cirxdoOy0cR+zo=
X-Received: by 2002:a05:620a:941:b0:936:576e:227b with SMTP id
 af79cd13be357-93913909dfdmr2230435685a.24.1788164268656; 
 Mon, 31 Aug 2026 01:17:48 -0700 (PDT)
X-Received: by 2002:a05:620a:941:b0:936:576e:227b with SMTP id
 af79cd13be357-93913909dfdmr2230434185a.24.1788164268291; 
 Mon, 31 Aug 2026 01:17:48 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:17:48 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:20 +0800
Subject: [PATCH v6 03/29] drm/msm/dp: drop redundant config_ctrl_link()
 from msm_dp_ctrl_on_stream()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-3-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
In-Reply-To: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=888;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=K08RSR7jFMIU1z3Wf63hI19PHcL0gXlgR6VRva1a4mo=;
 b=JiH+b0PUcxR9TZDRGECUHDy8hG1r9PNwZcW+rV8WYP5iMs8wXbkI9XMuK9Q/ZskgO/YIEsqMt
 y+gBOKOYN6EBulj7OEfmbDAC8XvHo/R/cHC1xPsbKNjpN/NJyPvTHP+
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX3IQpEu0nv1hg
 BpWjujUmsZMuLVoDuZAKus9rRWquoZOFwq4LNua3MdjsnQsrtMqC/axHS6nM+wUKtpxgCcx0XM9
 0qN7l9syFFNdQPNeXLBBAznJcel9+kkesGz5JEG712JzrAMLOJr1fF6CFjBuic6LPJqBXTwf7a2
 NylpQYzz508P9YrXBlniR1kiBrg63aQVIOPgyXIzSeXLwAg4OKmGnfePdo5XND50TI5h6XS8BZ0
 fRjYh8MSGXa2FOehtYwzePOMsQz0vscvSpOIJH0sXnuq/8VYBKy9oahihHFeqnjQYSx7WHD1COF
 FczaJ5Y+9CDpfAfHkjH7X7IWJahInt3TopmbOaUmIEMK+coANttoEWsDbjC8QLU2L2RZkAvJmJn
 CNeOyxyo288O926ojDmEi9QgGyfXX3nfn3PWbBwFfRQFMkRausZULZRJeuZdQQ83vw71qBbHlPq
 +OnQvDznBBAeRM/elkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX0sTC1o7O9TSG
 M+i4q5RClZfUV65h+etdAKMMuZEaLQAH3DOy1TM8b/Yy3jeOwIkknx4AxK3gdkY1IkUHMmqm756
 naW/qlvG1sPsCHxt6Jx8XeLFqQ2sPi4=
X-Proofpoint-ORIG-GUID: 4QMM9rAPbsTOFX6SAybRAhg7KA_hAPFb
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a9538ad cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=P3NwbF1cJ5UVZmgLWE8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 4QMM9rAPbsTOFX6SAybRAhg7KA_hAPFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310070
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

REG_DP_CONFIGURATION_CTRL contains link-wide state and is already
programmed during link training.

Calling config_ctrl_link() from msm_dp_ctrl_on_stream() rewrites the
same configuration and is unnecessary. Remove the redundant call.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 1ed713b957c6..e7bb9558c0b4 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2598,7 +2598,6 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
-	msm_dp_ctrl_config_ctrl_link(ctrl, panel);
 
 	msm_dp_ctrl_configure_source_params(ctrl, panel);
 

-- 
2.43.0

