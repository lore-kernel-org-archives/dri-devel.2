Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84260C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA67310E929;
	Mon, 29 Jun 2026 14:16:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C/aQkzxo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RXxV9Fmm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8681110E929
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:19 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATBLW2647650
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LzV7EjoUtPZtDBhS+QkVIWq9FjNr7Nkm+r9qnzqK9RI=; b=C/aQkzxow+Uydbtc
 4d5z/IUkDncbMGn/V5100zatjQCd/sEUcK6jiV/tFXfRPokl4Gimz6gSM70dILDT
 pwZUo+xwqc1G2Ok6vRXR/6+Me/+8lYzO3k+1SxaAu1cdzxzbA5Vqm7No5CFIcvXb
 evDuRZIsqhOp/TyfHn2PLbvImoygC1HYrDUb7dV8eYBjTBRBdB1U4Bc82NrIomtn
 09WnDnJI+ku8Xl2lkkGVarIStoER4/Boxkqb8oQrQjk2UWxWambZkU1BQM4egmxw
 1Dy/tYWc+zh4UCYfbIra7Qnu/l5xEZQgClbvZygtEIoFqpBsJafe7JSYMEfJpL5x
 yJogoA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kyjhp1e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so47721185a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742578; x=1783347378;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzV7EjoUtPZtDBhS+QkVIWq9FjNr7Nkm+r9qnzqK9RI=;
 b=RXxV9Fmm4rjXYEaUmYdD5gPatFBCsXP6oFfYMguqTMj7SjBhciLirUoTbgU57ZSi5E
 YyGPnJUZ3KH08e/+VnxD/zZA8RYGSinfcHWsG9DMM4beJnj3r08+uNZG3Cy6HZN877hO
 zaapw8RQVakQVAhppiu2UdXDBEhZ0GcZJXve3+U4oNrQQZToiElfNCSbRgXQn6Usy30Q
 bLMyXE3YyOioMVBE3CuEjUNHSXQNJMBjzLuuVHy0VVNKb2wvDBHjUNWeMP2MFFx8c9xY
 F865V9HGA1LdRbpfURrcMxdGn+dmPOKQ14Lg7W9n0hZ+J419uqe7E5OLP+RbjGmzljOk
 V0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742578; x=1783347378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LzV7EjoUtPZtDBhS+QkVIWq9FjNr7Nkm+r9qnzqK9RI=;
 b=MtLLRgl/OFTfWrb0MA6kFYtqGZivQG20EgFRQDwrPzsaupac2OvpcfdAp5h+dmpAWa
 ceZmfdvCDXqam2y+Aqaaw0a8EW2RqWKo3NN40g3sKt1TyFEkJoIA3701hPTYNaASq0QH
 f+eE7yHM4Lw/jBrvIp+HgjXk7WoxjXYdTxuG05UZ/w9XqyjMIn3qTlY5DPR35GrFBshv
 jbquEylwzwoiVQFt9HWAyvDl5GkVmtiLKAB1nowutnzQWX0mKbJoN8MkhvasfKOZ6xuF
 VDdOlkG6BmEJ2llHX2AgRi4OfqphnyMqjxvbydeWzg/yB5iJRP5OEFIaUEhDCwuf4Wpg
 oTGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IqWeGhOWPwWydANJejPI+ZJ9Jl7fNgV+f5n9mnfGGxlmPqSI+rwqe0NfQDbxw1838vnA3IUARxE4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUXFGduatRe2eDjHet7WdUrj7VHCMbaSjRX8Sxftf/CjbFnDiO
 lTNc7lEYcYpMtTvetHP6IBCLy3sC5siGcshZa2ieXvRKHCr6m8qgIo9yCIpeKUCVFsPcRZQenQf
 74im9ykYsuR15zfdO8NFnCkQkrQKL7HrhR4gH4Z6nDC8ZJFIyC5gSp5KooL6GZsfVaUNTTzw=
X-Gm-Gg: AfdE7cn/CjD5vzDSu6mJnXV9bXLx1/bxF7zMgHHvaH9Q5tYKfePt3Z4bAv4rXUZI4PH
 K8jM8jBmFKzZRzEYkoefHDzYaRg8zKu/rapFD9gfcMr91wABgiBEnS3dwg9lRqLhWGsEau3M0Xw
 iWij5XuSRL5AgTAt/gl1B5cAN89VIvvkzl5BCMAO3F+R2xWrX3wsF7s5uOZwlRSzstg94+As1Em
 r33g2r1fUGbQUDunFBuwbi4ro/T2+I3DLWgA//VPWuIupQdX3C8Q43ouo4Ds5x0HAy3MO7ZALYn
 X1g25Riuzxn3Rmp3UtOnPFnjpLGmxW0DjXomGAfB0k33DXuNkB+L/sxx1nEOnMxNB0zicd9nwBh
 2YEAfTpssa9HpHdh5zLcH50ZZf7TE5IAEpa+N+QJehPhTLc5WMQdHMzP3dwk36UvthdQeAA==
X-Received: by 2002:a05:620a:a187:20b0:92b:67e6:8ad0 with SMTP id
 af79cd13be357-92b67e68d96mr1066013985a.74.1782742577575; 
 Mon, 29 Jun 2026 07:16:17 -0700 (PDT)
X-Received: by 2002:a05:620a:a187:20b0:92b:67e6:8ad0 with SMTP id
 af79cd13be357-92b67e68d96mr1066008485a.74.1782742576862; 
 Mon, 29 Jun 2026 07:16:16 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:16:16 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH RESEND v5 14/25] drm/msm/dp: Mark the SST bridge disconnected
 when mst is active
Date: Mon, 29 Jun 2026 22:14:35 +0800
Message-ID: <20260629-msm-dp-mst-v5-14-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=1381;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=58ED0OzaID2aMTdkIIoG1uZJg33GpZvfm1KUdw++Gl0=;
 b=NMzV59zGTHfrWhtG10yK8tnZsbQ6SaBp+gphao9OrtwIPYCW0QlpNGrn/y6f3zNEATT90dzgn
 0Vg4fKmrE90B0wHxtd4foUZr+l5s33Gq+o59bEZmKv0aNlpldIYi6CP
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TCk0-PdXfGl3UuXmA9Rpl3PFHwB9n6dN
X-Proofpoint-ORIG-GUID: TCk0-PdXfGl3UuXmA9Rpl3PFHwB9n6dN
X-Authority-Analysis: v=2.4 cv=Ftk1OWrq c=1 sm=1 tr=0 ts=6a427e32 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ao9NmXljvuVdf-BuN7wA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX5UfbEOn4IXpn
 hUpYpOjJ8QlJO65jUBA3COHfbjefC10eoHHMDyZhX5JEHrW83+lYypy0+91GEP+t+hrwx4hTSk9
 djU+o8GJ/kX74wt8h6DLgbp+ff6b7EM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX2K6rjsznx2Ac
 cMXNEM+ynjowOSubAFBTukLlq6mPsCrBOi0GwAwpgrlCeSOkVr0ravCO/L+YN6ybPYBShg1SCC2
 t9AOagxfOwTBvAkb0aNvAPq/oBt+efcpofbg/Qm9TEeNCgvUUr6lsouU5s0OIy9aH8FsM8JWzQU
 t8eUpHuMNLqtAr3iPL9pdJjWjm6LY5LC82QSxvg5kzxUQ/Q3uiLUaIu0X2AgAO5Pa7fYn5ROG0k
 k9nX5WC+qPTploYJcOYJNrKZrEvcEjgIqMQ0CZQ0O+DR2AF7oIk8iN7orFYkE1saMyH7/6+LU0m
 6c9zmfmbbG9gAqlLLG2pLj8n/FPWgKQMF8g9C6lS8t449WkyIk+XPDL3r8GIc9crH7//CHxxiFu
 y6y4dVAzUaBHxCoEgDJ1KLSsyquY43NlLcptq78xBT9nKZkYsAUZGFq/FVV2jL0vmHJ8J5cMM5i
 0+jfpSBMIG6FUZayERw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290118
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
connector detection is handled by MST bridges. Skips detection for the
SST bridge when MST is active.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d0081ea9f5cd..5786e598a406 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -910,6 +910,9 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 
 	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
+	if (dp->mst_active)
+		return status;
+
 	guard(mutex)(&priv->plugged_lock);
 	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
 	if (ret) {
@@ -955,6 +958,10 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 			status = connector_status_disconnected;
 	}
 
+	/* skip for MST */
+	if (priv->max_stream > 1 && drm_dp_read_mst_cap(priv->aux, dpcd))
+		status = connector_status_disconnected;
+
 end:
 	/*
 	 * If we detected the DPRX, leave the controller on so that it doesn't

-- 
2.43.0

