Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1122BC624C2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D39310E732;
	Mon, 31 Aug 2026 08:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q53QtLwl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fOIRrtFN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B4010E740
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:59 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xeOG2824429
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sZCZYdxulAt+REaXNWP3pgTyEN5GhF1cMFMAFW7SEs8=; b=Q53QtLwln5sj/mGi
 Lrb3HkyZZaP52n3vxdS5mNBam1R0WHHjY148nMAa4ZV+EUTjKSNsbmd2Sd4nVjLD
 sA5H+XqjpM9btH1a2S4OGGRx/Zvryfhv3cxCDoZOOQ1X1jiWChsAXecTWR221x9r
 30BprRmt5U6KpiQC5/ori/n3BpR5ab5+sTq7gw9152N6y9EJq4g4EbixVzmW/HNW
 9Q1El3JpaO9xUk7DNxEhAChY5zIxLKy46+/r2E7zLMdlrhZrIPwP6DUbn9EkCRv3
 xwPgQVLClXvhcUMPJKx+tQD3sactrMPrEyP00GIJpUTPrUFoVfGBrfla/J6Krtrs
 Eufkxg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqe2ddgj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9375d92d8cdso572589385a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164398; x=1788769198;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sZCZYdxulAt+REaXNWP3pgTyEN5GhF1cMFMAFW7SEs8=;
 b=fOIRrtFNrQomR9M+sKBkyhE3w8ofx2dS3Jyl+GTKSuoggiiXnEbdAhySC81DoN+nyK
 Y79Dq+yHypskr+K3DPL6vDVdhNY5yZ4B4fECzk6qNKw9zWtSDc5ldh12O99G/tua0Odt
 CKSmBoQWnx5px7idtC1C9KuLPDMIjru9SbV0pGDdXKE32aSchwDPx1wxU6/bHJ/l2N+y
 vngtf83L5LGyt0vr246syBS+uqyzsNMeOTMVqD5DTQPT3Dj9EGpR/NqxKx+Cg4XC6+Gi
 0AcINItpFU32aI5jGJqRphxu2l46iouY/Wtwulzo+ghdv7P+KkrjCgIQtUG6iFcRyX8L
 rXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164398; x=1788769198;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sZCZYdxulAt+REaXNWP3pgTyEN5GhF1cMFMAFW7SEs8=;
 b=T+BmG33sNLHaPgHCo1EdgcVWZcr0Nlh87ZX0mjoSDtcdtbjywTzXlZ3bS7e2roZdTI
 sx3FlxcbuRxihiut9ASku/U98OYMugmwBzQ45YQaY4SJnFdEEuVKAdVTpDqGErBe34qB
 qgTsQftxAEcwvuAE0wDeaKMxZJnqz3rWrS36by26DhqedHZLwcRArjlDXqFcNCKIpaP2
 AVTHl6AfW7c3jzIjLv4O1Pi4x2elZSDZzdBE9CJ7pOmqwRUgwfe1AYkO6gw/1zE5AZmJ
 hzvaYkF9PykbPasmyWayl84Z5e6MwXgCj5g9KaZASongIEytfzT8xacHGE0HpHZmF+8s
 huuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqiuNHPd5Y9HR2LLsDWHnsjAG2IpX28Y6EOuOI0NNs3RuYYsrjYdr4Yajo9WT+dFki4IqZy4ghhAdk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ljRAsODxO1FbdiLWAFI8AgJ61HEc2sXQue+cXlQJ2XqNdUU6Vl
 8rCyT0+3rMWWh1AefyEXhbRFvtnTtZNrfCWTnJdV/xed18fyXHK1U2JgmbBtH40ByIsA8Cz82ad
 DSsctYmGGuuUGBmdq+qpVvWIl+6HMSyV9F4PM/x9IdivbM4Mi8HCH5wrVdI54DjyCv//r+KU=
X-Gm-Gg: AR+sD12/DJIqoGLpX/rRz8BHmCsa1YenJ1zI3EYtnCrwGWqC1Eqa+4BfqVUOtNwWU5k
 HgtBoitX+TLF7r+VVtCVr8uMVIeXdQQexlUK2gpxnRKx+6Ljw19pdCU5wiXw36TSAd8YPdBl4zQ
 LbxHWsHgZGJzQ1x2WhYxCW9ZUJbZlP41/0tqREIE9qEMD7HYGS5Th8N5CFdPNpVJctkiyigh8Yg
 Ey0FPaWesAwT0VkglHB1ECn960ZpAjJ0Rgcyf+xoe8mlR74jUKdP/HRWdikA4aeDBg7zNfWxqJ6
 kFEJMM16Q9eZwn+pHOrqNJpv0ByIv9HY3cGor9e+/LKy8q5wi5vePeneyWt/RiB2pfNUBrg3xWv
 ubasLhR9stynqwXYSRDsZDnZGEs0SdjTz049Jf/jj87qrNt2hY7bhbNg0szXEKng=
X-Received: by 2002:a05:620a:6886:b0:92e:9d63:a6f6 with SMTP id
 af79cd13be357-93913808713mr2845147585a.17.1788164398423; 
 Mon, 31 Aug 2026 01:19:58 -0700 (PDT)
X-Received: by 2002:a05:620a:6886:b0:92e:9d63:a6f6 with SMTP id
 af79cd13be357-93913808713mr2845142785a.17.1788164397979; 
 Mon, 31 Aug 2026 01:19:57 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:19:57 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:43 +0800
Subject: [PATCH v6 26/29] drm/msm/dp: mark the SST bridge disconnected when
 mst is active
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-26-c91d35d6fb9e@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=1108;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=b73mCP5ZBsxlgkNfg3qBRcFP4q1t83IPYmEGlCDuRyU=;
 b=UGx9/qKyXIjm9cwePvp/w9ztl7xoA2V+jY6pysn1wTUFaxUjitPwpFA+hUJ9wg0bVBiK8LW81
 kxHoNR7ZyTKDUoduaqZ66Kn1I7SV2rhl6oNElMz1W+EUXm2TYO+WBmr
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=Iskutr/g c=1 sm=1 tr=0 ts=6a95392f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ao9NmXljvuVdf-BuN7wA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kjeToY33gbACDdLlA3Ov9JHqLH-YqvTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX6QYiXwyAw9LJ
 uJoHz4TNnGUiv7l2mtB6pfU3YjcxaRnsCMZnTi2R9OKqhBe6mbO/sjYqCD5MNh56nAXv3Bv6ra6
 5QtR6XBlEh/HePyiEDPIiGYfK+Ol0Jiq7UsqsD0ED2Rj3sjdIGko60LMcB1qkx55YQxrxKcygrF
 WM/AMlNyUuO3CGw5msRZgTCd/n1fw0TPSmpctuvAMuWoWaSnWwuusbgj2QAGg920OGlS9jLSri5
 z9f6m6aK4zZVKK3rALxt4Vz4hfIBxFzy7XvUzaJ5WYoVmsd0sulPdJCInrmL5KJQ/SAp/ZAzNuM
 C5yLYM+4hLNS7YzEt3ITCxuJ6YrbFayxjVcgn/qj8MokxGUaMveCxTNIwQGBxZBXsLC+2vk8iAZ
 zAavxx/yz22PmDoaMeuoPctztpDwbREva3j2eg0qdtIWfMaux4A1AzifNaTb2QbP9oYKiqXnpvx
 gxTONnjFhvo2+lJFT2g==
X-Proofpoint-ORIG-GUID: kjeToY33gbACDdLlA3Ov9JHqLH-YqvTV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXxEo4adwQOTgl
 1PWLAVdiy5/owXIlj0DTmpdwS3QzsZGaL7Mx5VUqptnTNEtFZfzjAOYTEGBF1Bw/HiXkl7PuXF5
 D2occDXI6IZJVnSE5TiCkDRjiMFkGBo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

The bridge detect function is only applicable for SST. In MST mode,
connector detection is handled by MST bridges. Skip detection for the
SST bridge when MST is active, matching the behavior of other DP MST
implementations.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 22b925277462..f350c1d03b06 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -959,6 +959,10 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
 	guard(mutex)(&priv->plugged_lock);
+
+	if (dp->mst_active)
+		return status;
+
 	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
 	if (ret) {
 		DRM_ERROR("failed to pm_runtime_resume\n");

-- 
2.43.0

