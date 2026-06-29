Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEEDC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 932E510E92D;
	Mon, 29 Jun 2026 14:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XYtQv2uS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gIxH2mNH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01EBF10E660
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:43 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATDQA2647785
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p5iB5ejigL/1+7eiQKKge0TAmtZoQNU5D3awPHwLiWE=; b=XYtQv2uSmGPl+Zox
 y2VrjvA0N9uzmvVgMBzrZ79FtpuY0wFA4RvfwTGoPeS4c6DuQuC6vBx1SZ/D97II
 IAow8yBW9dEle6DTqNjTJIW90ZqkM8RFgoUPv6j9EMo0+nguGxCNwP8zPSChmhDe
 BAus4mR3yqOxbrYBf+zHhAd7mkwwVgnbCoRnZwnsnmPxS9q4ti1OmfOYB7TrQsfr
 WXpylbGQ4aox2BqqVNMrp80xpfayAR6lcKoJUFwVuBj4dnYamqvd3abv/ckj+pk5
 F3Bl4GsDTzXifw1yC+HvdjPmAKSdXv9pxvVp785hKt5szqiBvO6IB8fg83p54uxN
 zZCbqw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kyjhnx7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:42 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8dd6a429cb6so39902646d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742542; x=1783347342;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5iB5ejigL/1+7eiQKKge0TAmtZoQNU5D3awPHwLiWE=;
 b=gIxH2mNHNVWGS5k4uNs6pvEhsUSrUKTHneoeZMf34/FHr45V8/r6SwxNYk2GlLfdwD
 EhpE/ROBylbljpYL5eqheC4/joCZqU3TCo6p5Ne3e4TYpWbdW2007Ch+P539lXmPnAy1
 XJDok4/HkzLkG7U2HDmOfRk0WYAkfPJey2gDFxMz38C7iZ5oHmE4SR3Lvw4tFHpgwYlj
 aCWhz8ugDYd2FkVfkPsQPF50HOuTQQL/koBTV5MfgEBbDTyjKhyITYDsCi494JYhbOR5
 CPCUtfSN9xbfp+yGvcIkDA7OmljOVgb+scmlaj+38zPIROmnwUb1vh2+EZlf+7wxq4lJ
 Ycsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742542; x=1783347342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p5iB5ejigL/1+7eiQKKge0TAmtZoQNU5D3awPHwLiWE=;
 b=k1AR0saD9p6VJKXsevuUqQpZN9TXhZSlsGW/4n8GawBVc6glDuYF3eBdRUFwlA0Vwg
 BhvY+VfJGjS6lqRN/JJCiw6jD43e7aNN/TUVM58hWUB6o5WaQKE+0QT4KTwDDzGWz6EM
 fqHisgUmxwk6hWF3rFzCc0Wgv3T09B0mi/oEvN7RrogRbar5RrLMRZCMbpj8+DIhyXhd
 Onk7IGP9WPz03A5K29+AXDkNQQ5lxkqR36Nf8pXHksSYZmwl2rBwi/AQS8t5YgWGcCMy
 MT6ThKJgaiAM5dhvVBDnbLYZCzoisfccQrxhtAcVhuYoqGYN7pxvE9r92KQ6reEjfNCq
 mBfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+S51oB0KOuF5fBna7fHyBvDu90xP90Lo+AtS0qecf2cBw4WfjUMhtyzGGQOG2Ga5J9J0V/b8L/IrI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUjMmLKxjqlBPk56gHSsFeZX7gLJBbPRcS1sP75n2e9IVaykKm
 r4sLc7OP4NI6I+AkAG5ZsM3gMD57yoFs1sZ8DhwQwWYcAzSvz5iV/6G/O1eZPgAlPYRCde/90Yb
 GxKF8Shxx1NM6tSZJZKH96i5duNVWfpU1oyAL5Ib9UDfMr2ECiKNs9vYA9M7cMDKFjCQUAZA=
X-Gm-Gg: AfdE7clPTP+goL9iX4UxufXKVkEaqW4PfzharNpRdCKo5No/TLaIkFf3YbTzA2tIa3d
 r3d8Cy3awPYb6FDsShl6UXibQ0kvjLs2xWUysm0oWi9XCuQW+ZA9WlpJR6lwO7PXZjQ+imsBpLs
 RO8HC5JObgfEWkc0QHtcnOi8XUQB+yavZKUaH9tQd6w9+yR9I9Sd4q4uGxdLGoRU9917NOZIn5X
 cWqduIdOO6Wv/cmDmNWRU0nzqWaHnpYTCeVTLKkZKg5I/pzFC8OBxgF6XuNI+hdsrRv6afDwSSa
 0Av5t6qpdxiD6u/SAtQ7dPvPlzwgX9MG++d0j6cyggB6+DS+9XTlVa3EWVK25DM/zx6NjnB2Ot3
 nLncyDvip0WWDlk4MwIMr8MdlTh+fbKw2+d0DM7umaz9fU1rc/aVYRzqP0lWfJcH7nbHivg==
X-Received: by 2002:a05:620a:3198:b0:90e:2f56:2f0b with SMTP id
 af79cd13be357-9293b56debamr2574615885a.7.1782742542120; 
 Mon, 29 Jun 2026 07:15:42 -0700 (PDT)
X-Received: by 2002:a05:620a:3198:b0:90e:2f56:2f0b with SMTP id
 af79cd13be357-9293b56debamr2574571885a.7.1782742539230; 
 Mon, 29 Jun 2026 07:15:39 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:15:38 -0700 (PDT)
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
Subject: [PATCH RESEND v5 07/25] drm/msm/dp: no need to update tu calculation
 for mst
Date: Mon, 29 Jun 2026 22:14:28 +0800
Message-ID: <20260629-msm-dp-mst-v5-7-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=1019;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=hs6YElQtz09tmRSdX6C0+/uz+2FoQvn4lT6aOIb3i/U=;
 b=a0/B5qGVbImROKqW7HAWX/0q6e+2EsU+iQYHaYgGRbLSjyLKL1wAS6ZNeMvivfOwQYZD5CRZv
 YqT+xnlXAXZDfV6dXbQEG3MrFj1XcCUavtN7wRDrqnIJwjeES4qbhFC
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YfkWzU8a_OVLRSRSp1r7FHt1xlzIBUXT
X-Proofpoint-ORIG-GUID: YfkWzU8a_OVLRSRSp1r7FHt1xlzIBUXT
X-Authority-Analysis: v=2.4 cv=Ftk1OWrq c=1 sm=1 tr=0 ts=6a427e0e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Hn_uEZNTG89lqFF_qI8A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX/YYW4LM0lWRG
 VzyojsaKJH9oefH4fOMR/ZdKBSjpX3b0sg1VxQziJIsaJqFyBxQZ5hj4V6JDJQoyxR+Lf15RyBv
 i+i8VqyD24Jhr/E48dPk6kdw9oAPZ38=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX/uefaTT85L13
 jX36dSTqOWUH3kNR57nb7vz2g9Jqnr3tPYtHQS6uJ0aPE9VirkTcSwZUcc0Dx4OuDvPYhoyWiBv
 xdPv9q1/S1pUAPAdslDunfuDzoQRUhY6/oakv1JUupgOY5Qk8Qnimf1H5oU4dOf4Z38tqKtbty5
 cxh21FTRRADvBN9SKh+OrNmY7f2R8fRJMHDfGcirvdl4ht9QQGeb1I/n2vcCtP34gYIITuGcKSf
 B4x9+HJUtinmEw8+OhecMANMhtqCJZ1ECNy9Bn55uviDjhXyVoanYE968lCx3KP7yp8wWuv/yOV
 kIBzbNxme/bkA0Tn/HlrRjWMncAQWnVvDmSx3IEOb1iL2b/nO66C64ZZxAZgbcHSR6LO1vcns9A
 iwbUwFjWdY+gcoCC/rqF+y2S8gFbJyIIb8WrhxjHiTrbTQfOTrtrxKp+2hi304vl4ZPm7X2GhXK
 tPaSm/cKkgZJJXbuDXg==
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

