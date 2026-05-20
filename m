Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08951CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56DA310E9E8;
	Wed, 20 May 2026 16:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dthFy/UE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LSP9+0Nr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5301410E7B8
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:14:06 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KCe7ih316969
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nJWr4d/UJwOuBkw57btM1kifrp9/06KHmdp3Lnxi7oQ=; b=dthFy/UEHpzakFtH
 lNkA/rB7iPUMjh4FX8Lgi1oBeqrTYZT9t9Kj58yoK4rs0hzmgxnxm47nnWRrhbln
 IkAmp6QW5CvnrJUDJX5PF3T9HVrJf64ccDyT8o3FNee6yVDltOtL+3pTpQusysf1
 QcVkjeaHnyqbc97lw+zB+RYhqGA/mhVt4MkmL20k5VXIYHErdhtf3jX+6+nw+QIJ
 8Kun7kHtwSafWQ4oaUNVqpDA4TxBvKDmBUUhxLnzJnVib8LQztR6hppftIbVoLGR
 d1ypg88kcf01svr6JsgelXLzOuP6O85JQrBxUEaJ5rNE+VNry9TJ7YTiuqZOcE9G
 Vb7Gbw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9d5qrw24-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:14:05 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-95862466f3cso1497936241.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779293645; x=1779898445;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJWr4d/UJwOuBkw57btM1kifrp9/06KHmdp3Lnxi7oQ=;
 b=LSP9+0NrjPxt92Mqs4WkkSXBOYhMm121qrWVknR6Yu1K1+M2G9V4/cMgkn/LZjC2gK
 qBYuTEJ5Zbp8rYKkf3pANT6v7b7CgsuCytvVMaXeht/bpOZO5oucPyrDW2OjLdnvffVG
 8cladpNEtakZN0TW0YnINVFpb9N+UcaS7Uytd2VYJ+TyDn9lryLMD1EFeG1BOtmCvx4A
 tQwUa/TbIDb29Vk56SltEhK7hnvB83bMXaVVhb7C7/petMo48h0VwxFpb7Wh16aIiCu1
 wdwsji5wPOG89Tv9JOxKuV5iAslWmz9CtuSeAcSXlEbEWNTGCSQHyNDd6iBTQ0IIhkVT
 pgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779293645; x=1779898445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nJWr4d/UJwOuBkw57btM1kifrp9/06KHmdp3Lnxi7oQ=;
 b=kY8KDhXSG67zqs4HDFKEGkbWY2DSJplCoEYl8ioXk5ztVwaFZUY7fL4SUyRRpQt8Qo
 pT5dKqR3BMQOuGuXrHIynUIRafkPsRsW2flgKqbkdoEPlD9kaK9LVR1LHyG69wFDPNp/
 w2An4paF+Xdb25ZfAhONoAo3YOtPbOc+mbDFfsHCtdJc9u3EgQ/h+5OFHtQQcu1iFnth
 RnU4yrRxr1DPB3xeFmoNE0H958cvd9cMnGv7AMeXLCXWUUs2pCsahBVhrs2FvmT6novL
 g242IKTp+hfQcfUMSJIC55tGQJCPU5HessTc0C3MHljyR0iMFIymg4P5PD5FDOQRyja4
 agKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yEE8rbZ6v9+koh64YZuKW3VF2IQoldZcLo6cwD3QeEdqX0LiIMpPJvX6MBqERXQXZysbyS6FU2gk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmT9tJX07eWils3M76y2iyKC9d/6z4WfREkvbjYLqDaZQNRhPM
 ZKHl6h+SCzZAxKh0ptooa15YFzorTKrkhudG0ZRsxFeiOWspS0bm+aW8q1QnUkTA/E+ccQ2Aah/
 fQDgNsO+BJqkJEsUe4AF//t8pOJTBcHNzqj/p7FRHa9tKl0t4QE2SV4zITKQ7cAqFZtkHdeA=
X-Gm-Gg: Acq92OF6ABCR3GaJGcrfHr2hkmRiMrggOXayoTxSUPW2YrAEzwR7f2AXjAp0TqMBQuz
 NX5MuHc7WVe8YYXbpJUxI4vLxVp3UEfJqILHwFSaLmdnzk9d4qfCVwvrML39555wBnFlrFDgJY2
 +qXqYr44rpL8ZKMOL+0pNj3CCZwqwyf/CoYlE2bOGBDt+7LDKHPExiQdIXZg4H9p/7Jvs4BhPwP
 IhKvdkco9jzB+1NTh0+XzIfflBZ3f9ZvMGCQyDtc9JWrDrG0sIhr9g5kxIx5fgekQRrN5j6DB8k
 pHR/YL+hqdwVKXuCdjQjXETCys1N7mBiDWF5CZbeGr6RJ8aEAD7/dFAUZe+qej7O26i2NTUSgrj
 xhVK1Yc/X56zsneP+0QLYOQpGOSZ8dF55MYcTjKmUF4ma8Q4JwTeWu+7WVCU9q6jF87SA4GH+yp
 TtFduZB5ojWJlbHQ0Utw2JwR6Vp1WZc5IwNz0=
X-Received: by 2002:a05:6122:2a02:b0:56a:fff5:b4d6 with SMTP id
 71dfb90a1353d-5760be71006mr13132790e0c.4.1779293644577; 
 Wed, 20 May 2026 09:14:04 -0700 (PDT)
X-Received: by 2002:a05:6122:2a02:b0:56a:fff5:b4d6 with SMTP id
 71dfb90a1353d-5760be71006mr13132721e0c.4.1779293644004; 
 Wed, 20 May 2026 09:14:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f11b492sm5002534e87.26.2026.05.20.09.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:14:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] drm/msm/dp: Drop the HPD state machine
Date: Wed, 20 May 2026 19:14:01 +0300
Message-ID: <177929363016.2602176.14011964854996996197.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NyBTYWx0ZWRfX7f/wDb6Mg12w
 dE5nr4eDuWDtYATdtbDNBvNbXzlDp+qHcNSAAVeH4ByPssnS2dXT/kjB/urupFVXC4YHUnUp4Fc
 N/czX0ajHljff94eRLjKkz5Byy8bkYWfJFHG9MDtPEO6/BheSlW8A+6tfnXiLmnWP/Xsy2BJ7c5
 +N0suNapL3+Y0/qgFHPuPIMVGRaPmcHfLEDY9mekulJn591pZNEguLhBA3YNHTnEg3MWmKfRUrJ
 3vHVm8vXTfCMCTVZdXCWn+XF91qf+yQ6zw/AM681u5gb9RTdhNe8SC3y+MQdZf4yUuSZNRZiP3r
 FXyUsQzJw6MIM8Px2OySqsROZQW0nes41CfnK3GYBoq+wMg3zMiOM9dNwGprDarv2JrsVEZwalt
 C2KZs4qiYeqlabe7ywOOSmv8a2g5KjqbBs2NhrZ3t2x5gyh306r8zY0rY7T/bAcDzpNn9JLWwFg
 JXgS8PMeWvMLxDZit9g==
X-Authority-Analysis: v=2.4 cv=QshuG1yd c=1 sm=1 tr=0 ts=6a0dddcd cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8
 a=ycOf3ZaJPtScUYPjLqUA:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: 4uLr2G8MtJq2z7-QwzyZmmmsI-RSv1Bq
X-Proofpoint-ORIG-GUID: 4uLr2G8MtJq2z7-QwzyZmmmsI-RSv1Bq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200157
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

On Sat, 14 Mar 2026 03:09:04 +0200, Dmitry Baryshkov wrote:
> Currently, all HPD interrupt handling must go through the HPD state
> machine.
> 
> This has caused many issues where the DRM framework assumes that DP is
> in one state while the state machine is stuck in another state.
> 
> As discussed here [1], this series:
> 
> [...]

Applied to msm-next, thanks!

[01/10] drm/msm/dp: fix HPD state status bit shift value
        https://gitlab.freedesktop.org/lumag/msm/-/commit/f660158ca081
[02/10] drm/msm/dp: Fix the ISR_* enum values
        https://gitlab.freedesktop.org/lumag/msm/-/commit/586a722ad5ff
[03/10] drm/msm/dp: Read DPCD and sink count in bridge detect()
        https://gitlab.freedesktop.org/lumag/msm/-/commit/41a285d9cd64
[04/10] drm/msm/dp: Move link training to atomic_enable()
        https://gitlab.freedesktop.org/lumag/msm/-/commit/69c1cc0142d0
[05/10] drm/msm/dp: Drop EV_USER_NOTIFICATION
        https://gitlab.freedesktop.org/lumag/msm/-/commit/d9d6f9db8698
[06/10] drm/msm/dp: drop event data
        https://gitlab.freedesktop.org/lumag/msm/-/commit/b845eff570d1
[07/10] drm/msm/dp: rework HPD handling
        https://gitlab.freedesktop.org/lumag/msm/-/commit/53797c712360
[08/10] drm/msm/dp: Add sink_count to debug logs
        https://gitlab.freedesktop.org/lumag/msm/-/commit/eaf929349829
[09/10] drm/msm/dp: turn link_ready into plugged
        https://gitlab.freedesktop.org/lumag/msm/-/commit/7c6ce8c98d51
[10/10] drm/msm/dp: clear EDID on display unplug
        https://gitlab.freedesktop.org/lumag/msm/-/commit/af904c787d68

Best regards,
-- 
With best wishes
Dmitry


