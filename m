Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504C3C624C9
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B4710E746;
	Mon, 31 Aug 2026 08:20:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pMzXF9Gm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HgAAOS5/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84E0310E744
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:20:14 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xGTc3664595
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5meTGQRfLkmoxesHwymgB3zPNdHgZ1238p0DYKLFKD0=; b=pMzXF9GmyYoSImuZ
 cvr/mPl2X0wtsLq4P4Zm0RUXyVUA6hcXBiG/9d4w5A3aL68qiCqz5Ax1VLp0BzrK
 az+sYgF5cbvrPqrJNNI9T7BLRMzBQFXY7JFY88LVed8RTcT0wH09YKohw5mVUBGA
 H1K84PczBlEnr9SEj9FzCamMPnV9V5c18Bkr/kz9bh4rHFJINx4Sos/g8UfzYlPE
 goyg2EW9la1OisG5XO3RPzKtdB1VMzjSzx5TWqdjbV3q7wRLgnpX73bfHXtBqkHV
 Fr5qdwJOf6NJ2M4+ZRUMy2sbGiwj26VZxntK1fP6QaVGrUYoeI2QLYvm7NdTgt8v
 hPB0Lg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd4x089t7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:20:14 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90e8472ee1eso17467606d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164413; x=1788769213;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5meTGQRfLkmoxesHwymgB3zPNdHgZ1238p0DYKLFKD0=;
 b=HgAAOS5/EPCWYBAY8LhIERv1n6F9sdgiqyQcwH1SW2TUpV6iCoOEGNRtFgfTIhlmJV
 ERnL86EfsS3v2l6Vs+aw/KUogkXyxyefLu6FqNYbZWyJuypuh3aJZz8YMg1hlIqJx5Vm
 AGkwu75FZ7K2CY7EhZE9c6pKK8COTIz3tFovbFLcqjHVapzqjJg8qnCPaTO+SLuGJ3XK
 jWxt7O6c5eIQFMzzrCqyUObrz8K5KIrhGqkHrFDpnDrOOsCeDfJb3QFrdOtgn2qZfacg
 N1FBVEtAHqK802UK+Y46wWKguoZj8MXipN2/ij9qW1g+ullT4PZhwZbggscwtFTHAwGv
 LAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164413; x=1788769213;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5meTGQRfLkmoxesHwymgB3zPNdHgZ1238p0DYKLFKD0=;
 b=QSk9haJvYLaGicPBOWBSlq6g9Vqs206mG/fPFVlFYqwDIAMz/ftosRmV05JvJeJhLY
 DQ3iG3oQWib9qkw6FAofJ1YcBebi0rvNcLG7nMs8oOzOQLJAKD2ohHG8Vzp83NQL2/AM
 RuuMyEyeu1LnSaHuQer77m2O8oneU3C7bU2OPB9zQoa8agMLvbt+lape6ipObqMeFutZ
 LOOI1cK6xFCYkAv/p8cWcu0HQy5+Qa+7qRxBAGIHOKlrRJ00459/6mi6hFVf1LKyTGQ2
 0q8ZPIP639jPwyejark9IahUyyhu6iooYHsrkJAWomtXBu0RhEa0Wd1cJ7GoCEahSi9+
 E+/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpU7S3tBM79OvXsj/wtzKWNotEojlS2I+Kd0I+5HWh+LnWWRInaCRBP/1N+tGv+Rg1124cRbJK78l4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lRCtwcBA5rMnTP0UPhH5RH5YFSJZqbFCJqcpD+hLpQgWuYkf0O
 D6QT//DALGjJeIW6XoVcG5ALiDug8JHroldL22FUOsREvOJSzIWBLkatoM0571sIXAVyMq8ZCX1
 F/V91vXt56UO4akBkwYJgML0Pzyjb0EwS16BDpXbN/jryxDx5UvT2diG+vV2skSKlCAqnZKo=
X-Gm-Gg: AR+sD13RV+SDVZ6eN3RarI1gWOxSniTt5xPA5xJpyO7h3S4MqsPYNcdkGnYlDEwxNM2
 r/ArGjdqJCnrkFjo1VVlO6bOtP/p1QM+HFNQgwWLSICe6QHHcA8or77gaAhtxHHSV6KtUhAoY5K
 UfokOpZidVfBS7DA6GSklXBqpFpUrDbmUogjgGJ03rNeGGsdPb3OXpMa/47NG7ql95w0wZKWA5j
 73RZusfzJCO1LEo4Z5QNPlaKagxET0Kbdk/R4fpSi9xZw6ibtOU1Gpw3PckPcxvtyqPz8MVNCZ8
 71VJjxCPhAa35cgKfsscoVvD3DCz78qtVDu5QKM8UqwtIBvkE3cZOHoMZWOxiGuBLXQ0Vhn+KNA
 HjbRog3Aj2rTX0sCKVhWqmwchL1JpCGz9SfeBly/UCbiEmHNZe7JHh0j8lAaeIbM=
X-Received: by 2002:a05:620a:31a3:b0:939:70d:c454 with SMTP id
 af79cd13be357-93942b23847mr127711285a.23.1788164413119; 
 Mon, 31 Aug 2026 01:20:13 -0700 (PDT)
X-Received: by 2002:a05:620a:31a3:b0:939:70d:c454 with SMTP id
 af79cd13be357-93942b23847mr127707385a.23.1788164412706; 
 Mon, 31 Aug 2026 01:20:12 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:20:12 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:46 +0800
Subject: [PATCH v6 29/29] drm/msm/dp: mark the SST connector disconnected
 when MST is enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-29-c91d35d6fb9e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=1197;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=JnaNlH0Fbk6AgAHQMZ5A3xTfTA+9VjQZ/fVSomodQWI=;
 b=J9YDz4tmwpF2ajXWoB2k267qD9qlr4g1jmtUrDs/9cH/UAmGr5x9l1EQFiVH5Qp/TWMttKC70
 8Ahed/E2IqQD2LAHoRSPDhQJmVpbtKnl+38TdGc0oachX+ye4FTkRtV
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX9AjBSr7eaVwB
 xJrb983n20079RQJVtVDg3AmP469Z6VkpYSf4FCG4JPpbgJtPfy6zD2ylbP2MqzWrTAbNoPP+Do
 /N68RH4zVBsNW7quGJHJoXbj9GLbpss=
X-Proofpoint-ORIG-GUID: Jg08UVtgxoptyWYXEqiNfaFKHy9UcxaL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX2Hvh7a1pUU83
 9jmgMlcJQk90J7aiRWJEOpr2akC+YokZITUaaZ1xdcQ7ULFqMnWW5OJGmN1tU2o0Ra+75oddVCb
 jLXrSKWCaTpzjvsbkl3Oa+Txmqk+pOqzBLP68l00WJ7AP9Z/UdrXQTo+84rUjr7cGWblXW2whLR
 Dmghvk/tbcd7KYnv3xdksYd8PtI1XIVvd2HY0q+V0auJc18GA5Zn09w/4YcZOBsSU3w3SNEMlyt
 pok7oEghI+zhcedjHJSJOEaT0QUiuusEjn0e3RZYxC8x3qhfjgr+4Mh4/VIxDkZ5E1kR3fhqwQW
 RfmaAXxKkBUH6fmLkuOIaNYJ00l27SIZK3R6oWX4LEDXxjI+zZ1BuYUZqsB52TBMj7A+pxGv/kq
 9mzmEpgVF5eTDbqYB5P0ytlTJHmYdJ1yTGe1z2taYphjmCOmIjHR6Z6Esg6ijWkPbM3B8Ms86fs
 4Wye2LCvv6qpv9tng/w==
X-Authority-Analysis: v=2.4 cv=Iqsutr/g c=1 sm=1 tr=0 ts=6a95393e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VuhzylXr5gTqft-DN9kA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: Jg08UVtgxoptyWYXEqiNfaFKHy9UcxaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310070
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

When MST becomes active, the initial HPD plug notification updates the
SST connector state to connected.

However, the subsequent SST connector detect path reports disconnected
while MST is enabled. This connected -> disconnected transition is then
observed by the polling logic and may result in an unnecessary hotplug
event.

Set the SST connector state to disconnected immediately after MST is
initialized so that the detect path does not introduce a transient
state change.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d2b2c7141db0..d207ec3ca8bf 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -290,6 +290,10 @@ static void msm_dp_display_mst_enable(struct msm_dp_display_private *dp)
 	}
 
 	msm_dp->mst_active = true;
+
+	scoped_guard(mutex, &msm_dp->connector->dev->mode_config.mutex)
+		msm_dp->connector->status = connector_status_disconnected;
+
 	msm_dp_mst_display_set_mgr_state(msm_dp, true);
 }
 

-- 
2.43.0

