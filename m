Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DD5C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9703A10E74B;
	Mon, 24 Aug 2026 11:28:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YUUmRSM3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SPP316av";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 989B610E74B
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:50 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OBMgGd2864728
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z4joxmXfur7eXOiFFe3oqnFTTbEYcCWRQbkIKaQk2W4=; b=YUUmRSM3CJDubSmL
 OtcYcHNkHDipg3dVuaMDEehgY+hHE64+B9o82A1Ixo06Fc/kQQfRLkg1Jw6hX17s
 xm0SlJudYbEb1KNd0nMkMOO3/S7HHj+jN2H6RjYGIH9oOA81dHLP1iwqTAzPtuGq
 yEW9F/wlV1gOgkwjcmBjU5n7Ch5Ss5tuqmRQRlAE/X2YP5HEitRothDJVJZd0FvD
 Y9YmMPcoT9EIPyqSmfd6EcXKEUV4eRtrV9EvvIPBCcE+u9xNY7IUYrzl4rKHcJ0A
 pSFyB6NhMPFcspzfJUIGJONShsMNIiJpPfzPKNq5D0j8eu+4Lwj+8iqhiqJoU8bM
 tsz/jg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8bdr26uj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3954def0191so5893195a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 04:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570929; x=1788175729;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z4joxmXfur7eXOiFFe3oqnFTTbEYcCWRQbkIKaQk2W4=;
 b=SPP316avEBl2K/xLVASXQ7FAcM2RnB4saaUzPv3EBQmzcm5dWP49gB83TejEblQiSN
 IZvGsy5lxDZUjlS871EqfFMt6BpL7aTGXIjQN9ibPDlEVgGyjZMO1dq8cvbQIBluYIsI
 9P3AcAj9+tjDDFePnmhwlbGJ40WDoC80tgJNEHpWjWxpWJw+ZS0qbFht94M9JFxBB/eU
 n+1Lxd9Yyq4zKuDZp1QpW6JLvHvTSYATfpWN7G6Ntmld5Pi5Qbp/VJQ0pJGqCAvtctY8
 Tnecoo6jeJ1bgqfq3VySMJAPsm0lCXLOgjjV/ENsKDiIhTHXDRM6rAPl7bqPobLFt+bE
 eY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570929; x=1788175729;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z4joxmXfur7eXOiFFe3oqnFTTbEYcCWRQbkIKaQk2W4=;
 b=oBaPjmrjhNdZbVKva7BWt5eYQOnRtS5qpP37TKiZDKkF5Wb34yqRAmCo/8wvUqG5Sh
 +4iGRBJDApdj23gi3MJG1u6MuDwrDdotE2to6B/+W4vj0FwKR9os/DFG+1b7NEUI+KDs
 4bWl8Yc/b+Mrmag7lNvM8lW/XDnFLl/lUZMwLDdhDx8ErSctbQkNl+hoVOFw2opwjx6Q
 5m1s94b3IJweCk3v+jBzmJuTj/DAB8lXkbrGSt7NMtdJ5QA56asaCfBSxty0Zup43ZYk
 o8SMfXT/mUOZcO4x2totW5O38Fy6tFWoHctnrrnoskG7eDaQQt8hiLIDxC1FEEVsO/ox
 Jl1g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/TlajZU+2qbJKCE4ycdATD8d07V+Yb0iwN+9PNyNX39rRVHTSyRd0GhzLssW9fT8hx48biLcrqro=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lJlVcLVcXWtxMx03dRtQq97tpFhYIHF8QAQQlx9AJdi/sEzINt
 nilNqpCutlyZww7oKui7eqdSeIMJW1LMzZOkgi05728jHdQA2TqDD0o8EKA7CE91vgb4u8os5xc
 64zlCuBcQaGIj55w78yfIrn3V9V1wufKXOVJT/pfloY9AsxiNNf5/8jPjnztz3ZQZM6RlDgc=
X-Gm-Gg: AR+sD106xm4wipKhW/vyTlAh0Z1UhPZo/eedDjrDPhh/guMP3qkvFdgvBd0VwR6b3ZR
 ohCYjmdyHznCzZH+4fkLjB/T4nzsYDLNe0IyB3HgRQV9ycdJCU3fGlwB3sTih51gqYltLr8vfVK
 CAJq2WH4g7nxB62rFFNHTRh9ucMP4PE4Ngw21F9oWFIZX4ag9wj6qIXXycYbsmS1BU92KAkWjAd
 JIevIxN6A12xsq7WoXmhdcQJnXxbwAtgVHRklYWNQUJ6A7HA6W8HWjHwTnv08vuozsxtH+Ixbcp
 P2A3WoQmSfO+ZjdKuqUbHvFVcWY3hZ1BqD5NiKbdAUwR3IoaQ0fnsDjheO5QTqqoOSCsJUOPxS4
 q2HbhAqxKuAzhGemN
X-Received: by 2002:a17:90b:3d8a:b0:38e:6d4c:14e6 with SMTP id
 98e67ed59e1d1-395c33daf0fmr49022315a91.3.1787570928737; 
 Mon, 24 Aug 2026 04:28:48 -0700 (PDT)
X-Received: by 2002:a17:90b:3d8a:b0:38e:6d4c:14e6 with SMTP id
 98e67ed59e1d1-395c33daf0fmr49022262a91.3.1787570928363; 
 Mon, 24 Aug 2026 04:28:48 -0700 (PDT)
Received: from [10.213.109.15] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4af750esm9825643a91.11.2026.08.24.04.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:28:47 -0700 (PDT)
From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:58:06 +0530
Subject: [PATCH 3/4] drm/msm/dp: skip LTTPR init when no LTTPRs are present
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-qcom-dp-typec-reconnect-fixes-v1-3-2825e5bf8a96@oss.qualcomm.com>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
In-Reply-To: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Vishnuvardhan Prodduturi <quic_vproddut@quicinc.com>,
 Mani Chandana Kuntumalla <quic_mkuntuma@quicinc.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Saurabh Anand <saurabh.anand@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787570901; l=1187;
 i=saurabh.anand@oss.qualcomm.com; s=20260824; h=from:subject:message-id;
 bh=IbcoGzqn73EF/bO8GfdSrufbJAGc5IIrFGhyjXEiifk=;
 b=4Hj0CTrR6JsyaJTEBY/gXkQi3xfkAI2GTUD0DlJ+E7juBslV44zaJGm+H2nQxgdmzkFSp/rVI
 Iqbl/NaJexwBTQS0lsnfQTAnRMS/qgOSiunA+H5lWE4hyqry+bFIz2G
X-Developer-Key: i=saurabh.anand@oss.qualcomm.com; a=ed25519;
 pk=AzGwbGUPO11yi5XTeGyJKOJWLfzXp5Dru4z+PCg/uXs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX6/e3cGYKkE3Q
 vUUv+uYxv6j1gvRoguE1/YorF4OGy4DNE9LZZMArGh/lRSR5GzJmi1qs6zbTSpDR7GrrOUnDmmZ
 o1Hb4jx6OVEYFL8A2RdMR9wjdkvGF/Z9x53E+zPb2pR1O1U6lq3PVUeuTTwigwSN/fiE7qj/7tn
 wymKut8bntEAXFuJbrh4MYByZqq2UZiBZ/Fswmr67Y2XvWZjh+lAe6OPjBKDZ+ijQSaNyw+hXBE
 76DgV6zYyiZmWcPC4XxavQ9tf98k4X9nNA8VGJOrmY7SpKpF7lhHjZk2fBJJ3cacR7Hb/vjlWKP
 T6t0h+KQBpaiVp3z3UeWGyvTxFOAGEW6vn58Kdj4+TaRoZfv0xC2OIKd5wEkZrs/vCsa4NP3UC6
 9l3JMK8ICd5X1kc0jwezydxwPw/QT32HEESYus0wZDEtInFbxYNuesY0qghlbKvJkNAlvggFyXp
 Y6c0E6O12jFgb4Vt3lg==
X-Proofpoint-GUID: QJpRhYzcyBadqvN6FwpXNCC5njj249f8
X-Proofpoint-ORIG-GUID: QJpRhYzcyBadqvN6FwpXNCC5njj249f8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX+ZtqNkHwrB+I
 BRr1j3EsO8Gi22zpPk02tcgYX02Qc0GCJhqvbGydSg0k5r0GAZk85Z2xsLfLkOHM6ZoTvSMATOL
 XogbLr0GolzkVJAzz0WxD6kA5KM2HLo=
X-Authority-Analysis: v=2.4 cv=W8cIkxWk c=1 sm=1 tr=0 ts=6a8c2af1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1b-Prb_CKxP05DS9zwcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240096
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

drm_dp_lttpr_count() returns 0 when no LTTPRs are detected and a
negative value on error. The previous code passed the result directly
to drm_dp_lttpr_init() without checking, which would call into the
LTTPR transparency-mode setup with a zero or negative repeater count.

Add an early return for lttpr_count <= 0 to skip the init entirely
when there are no repeaters in the link, matching the expected usage
of drm_dp_lttpr_init().

Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 40e19d506a45..1f60c78a463d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -253,6 +253,10 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
 		return 0;
 
 	lttpr_count = drm_dp_lttpr_count(dp->link->lttpr_common_caps);
+
+	if (lttpr_count <= 0)
+		return 0;
+
 	rc = drm_dp_lttpr_init(dp->aux, lttpr_count);
 	if (rc) {
 		DRM_ERROR("failed to set LTTPRs transparency mode, rc=%d\n", rc);

-- 
2.34.1

