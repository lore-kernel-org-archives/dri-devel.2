Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B791C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D0DE10E71D;
	Mon, 31 Aug 2026 08:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iK4jtk5v";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pd348Ikd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 251FF10E726
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:28 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xJ162460293
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iVWiYFGWOQh6WJuSIdom7McLyivYPD7fTLAp4LYIpOU=; b=iK4jtk5v7X0+qTL4
 CCYTmROkm3EQdK6xNoZRZJ1NQTbGQDkCRJhbgbdxtfPpXw82hs2AR2n03vfN6vRF
 F2lbxfb2ephDV1+TbHp1+skoFdkRenINL/Zj4ntnXvyM9T0m9x0vpMmNxGj4pMFV
 igyqjdCcKgtbLC/cjO93Cpd+NvkqevYF4UV7LZYJopW2+gVbCYEtHpHqre/ZInaV
 AopZjgHFndtk1GRcr/kArobxZu49hJWMZIDVma4C9xup/ANq7eSFqIEv+KN0u+iN
 JtYK+fl/T6prasjQZZqzvp9UHvSOY0YAesZAvTD8XrSMnQzPwc0yghHbksG8NbyV
 fKu0SQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd556r71y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9393ac4961fso69407485a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164307; x=1788769107;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iVWiYFGWOQh6WJuSIdom7McLyivYPD7fTLAp4LYIpOU=;
 b=Pd348IkddCEj2lbG0ue1lDxSlg3b89T4FeqTYLajNXGPyBPsiZLAHuc3aUHGKOgUqS
 b2SRja0XBUHLiLvsoE6sn8Re3fl+b7kQAxbCjbWcQDNdjJoo6BqOuC8+fWvPLUq8jE/G
 FVJLb8+jcG7VkhKpKAVxWl94irdzDqeNbb1fTK+FtPEVLNQh0CzPJJYmegUzW0sojtiN
 bOhqF/dueHLupkM2gpIom9bVLPXb2Jm33UQp5s8CM9r7JkB4pYqqv9oqzwMLBVj4mmdr
 VX/n2+7xqjA9MTm2JDfTzjZmNuXl/QZV3aVxQezrec5w5OyzKVqEQ3UWy/KVoSlIpfQI
 ZjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164307; x=1788769107;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iVWiYFGWOQh6WJuSIdom7McLyivYPD7fTLAp4LYIpOU=;
 b=iupUEf+pOgBDRCT6tSyicCKjlmCWHrUg1lIpFofzmAa3hsr/dDkC/ShnGmywYVci6u
 iSTk+ebby8fCAi71tNdQoWRCdQcpOeJABCtFLjgrJXqyXsBuNc6oUAhTUONdgBmd+jlc
 pJ+1N8Ojh7KVKjZVlWsGMqExKBVe6iH3wb8eG9Wl921K0ByjVqMUdt4tzJKwMeI6FX8Q
 jSMblc3RILTCy5EO9De8LlzTrm+JC1wOE/zN0oV3g5IGwg3bwOBG9fYKwf1mHnmV1LfO
 0oKgetQmIuK8L3sYVgu4naDpEYJS9GxE8cSIJYBwIvCkpiful1t/Vg02nI/mH5lZgYhZ
 gIvg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3saa/LpWamVSY1A6A5etm2kEwmLVPfxM5awrtkn6A79+7kzIb78ocbWPPHa5aLPODWJJc7pyqm5U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n5MhiJukicrJbqCXFG1B7l4XIe0GMQaJjNVbQ9swISXIkb3Ej7
 u9mu6Kj30Onbz9mNSEJndWwdDS3kxzag2sILmClUEcnxbNQmT2fJ6J4TmmdHuiNzql8PvPKogZ3
 zdLlrW045hmghpYmsQ4VwRAZq1ipE3BXMeYXhVgNRV6l/lBEcwgHgpFy0RMSwwOg52FkJNz4=
X-Gm-Gg: AR+sD11DB3n//pUeNg48DQMOj0+30eBD2vC80sfd62zA7j0lFutdXkNmOqYKRIR4RXM
 nqgxNt6+XoeOuzZOYkXpxcfROM4lQjHFIxPo/pqU8Vo3666nHPCT1P92Ovee/70Uqiv084KpAF9
 v4QkxcYbFx1GriL9KHLahOOP+d8EbrX0ma23IPfyAEPaQpsLrw0n7gH/AwMLm5bqtSXzoOqMmCo
 vWOKEv/0FPCEmfnwhcRKJkCTsfUU9MxUXkcyQh4SBV1jOsPSJ9ukybS7Ys1iy4JMTN86xpAfaE2
 QOsowamGZXnHisBObX/jqUg+OI+Jm0I6lUf4tgAmDj4sEmbr107VgRqfVZKD8sdoflTNT4pmHkQ
 0maoBBaHBqQRPyEW2J2frjgxanmpgMewzpiXCeB9D6nOIPYZRXdeoZgcjQF8atUw=
X-Received: by 2002:a05:620a:46aa:b0:939:d06:e746 with SMTP id
 af79cd13be357-939138ae1e2mr2716262285a.26.1788164306543; 
 Mon, 31 Aug 2026 01:18:26 -0700 (PDT)
X-Received: by 2002:a05:620a:46aa:b0:939:d06:e746 with SMTP id
 af79cd13be357-939138ae1e2mr2716259685a.26.1788164306126; 
 Mon, 31 Aug 2026 01:18:26 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:18:25 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:27 +0800
Subject: [PATCH v6 10/29] drm/msm/dp: no need to update tu calculation for mst
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-10-c91d35d6fb9e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=1019;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=5ZzC8/kHjYiASM/nz9B0eCAoNtT2xRTSonPMA7SeVao=;
 b=RBUgxkcHswp787SMBPL5yQ6RVd5haNBgPRB9t0rJDVtETIjrkFFgqa573EgUZFXPV82HMRE08
 ToGv8xwoUtaDPwEfmbEro9BFGob4VJenOoNZF9S1krDWHYsW3N/c50d
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX+PvfCxNFmKZk
 w6EJ4Ld4Pjy1ivDddcqgXiSs65mrGj9aauxEAXzaPMfjdiACSIMDRRfTwGBzGSTbxN3L+0PNSb+
 JZxdIQkS6ubT0SpLtsfCz8hAPsML+k8=
X-Authority-Analysis: v=2.4 cv=O7sJeh9W c=1 sm=1 tr=0 ts=6a9538d3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Hn_uEZNTG89lqFF_qI8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: W_o1hJN3FOjqaQSDoMXvxpzmn8PFPv-T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXypF2xRHTkL9F
 Y1HWVzxOfbravQIOzK6hz4xvbg/ULBKAK/eNz5ROyl/PYxapAr6+4MKn7lERKcRBLeC6u+d85X+
 wOtLR9E+qwC6H/tcOljNOqqJp4UQCXavDDZSPALxh0U3iBWW6n0vNFBu1jbr+XqlZvWtCK+W5Nc
 cB1g8tAjkVWY0oi26e12LgxotePx7tkutzuXT/Nf5SYOFYw87v2T9y5iuTY0JWAcKgRyKXLhmjn
 vSwDYaaw7tUetFPLHH49pGpNVitAY/OJ+YQSCbmNAgzBavhaIlmm9l/IYW7GVFPZQKsxwZTmGD5
 sf2W4Dh+j2w0SjSO7N86ZWuj7bUoVjmM2/ivajPF+NAOP9mtWJIzEK9SBtoEaEzJDqRAyLTSx7+
 ZPCUk7LTWOJfPxxNcvxkX5VImRTW1nnaOA/FZLa+tmie1ePH0hqU1tWdL47HKQFJbrStjsMxMDN
 T9aqEjjyIHyD/ZsSxEw==
X-Proofpoint-GUID: W_o1hJN3FOjqaQSDoMXvxpzmn8PFPv-T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
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
index cd6ae0d5372c..77506e840883 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2703,7 +2703,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_panel_clear_dsc_dto(panel);
 
-	msm_dp_ctrl_setup_tr_unit(ctrl, panel);
+	if (!ctrl->mst_active)
+		msm_dp_ctrl_setup_tr_unit(ctrl, panel);
 
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 

-- 
2.43.0

