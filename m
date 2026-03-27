Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4432010F2867
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF5610EEA3;
	Fri, 27 Mar 2026 19:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NUvIGGF/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C0E8okpX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A2B10EE9E
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:24 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2YNC1458359
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xj6ACPQOpTQOINhOtp1JGfkRWtIL62oMxihChN01Kss=; b=NUvIGGF/fFSFfHbJ
 jAZIblk2p0EvwFOI0ly8SUKeOG2uoo68pYZEhKGqTJWmQQt1nllDg4J1u5FlNVrT
 2VfC/pX/BJxgzZ1kQsCGfi31pY/bQVBs/ovs1bbzjIav37cZFB5x5MYUpn3XXJs5
 dvLt0AQ7dqcPKwA8ecqcN2YlRWftW5mHuLHJMEiG7yadBRXyxu1JAeFK1OATCmuK
 vfY50O+HWidlBrRHSSbEzpC0R/MPfllVLbQYkyeHy5xlUMRQuV3AzVVGRAVzguD9
 sYKE6oa67wzwPaaSSc20wRfGHb2TFC+xIMAKbHY31qdetvD8j5EQ+hoSd9PqDiql
 tuhF/Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5dd6m5yb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b34223670so54613301cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640903; x=1775245703;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xj6ACPQOpTQOINhOtp1JGfkRWtIL62oMxihChN01Kss=;
 b=C0E8okpXK+J9g5wSJadRqjkDhVFklINhm+HEXhU6HqFjPAZWq8NhYmvX3MDj30jMTu
 bQM3U2EIhhEVpKPtuOryUjzq6mm9hAawV/F5jTd64lSfc9f2UVeyyb13hei/TcGlJn6+
 rTIqNz+FXyDTKXF6g4p6MwXEIMwEGNDY7FkLADEkt2hIzL3rXlReCMWv1iQ2OXGdHL/6
 xQvlKwQZUMFXjW0opHzpZj7rNg51DuS14qoJURTjX/qWBKTPgs/hWr2Env/DftaaMzsb
 L9Q2tIiYHEiC0/SdxjNUa0ggLfNA4b93ugyH7oq9tBPyL1YMo0bXxFterf2GdQKv24zy
 MYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640903; x=1775245703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xj6ACPQOpTQOINhOtp1JGfkRWtIL62oMxihChN01Kss=;
 b=HkM8rwp7tgQds7HsfS1OWb5CfDW3x0ZvqN4TwcAyvopo844b9XciJO+mjzJPzfBycU
 A5osx5s/hYjF16Lm9VTplcBbpYV+yiWf+PGY6aCZ7GJDy8GDGDai0kz5FXylJy/JyijD
 rTFme3R5ObJ2KonEBnsA86Ek1r39aFAekqiGDykbFRzguGYvdy9Im39dw7NmAO8mF7rp
 opNzgxZh3LPG5MukxQs26yrDbVrk3A0e2GHZXHdGxbZTbQwSeg+f0UpGezuR3O22sPDz
 BkSPWPmX4x+tJKzaL6O9qjrxPbfKopSsSR8bDCPcpeyI9WtP4Z+90QsnNG8wnlVo7bqw
 RHuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSUlN0+Wu8yuXJrMWut9NoxQo8VCX2r6os99429uH8y4CZljsnvdgkmjpHc/uqjJ/r3y/BWpbbKbg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+p+X0V5sOEeI58MraDFlmZDxNmJEfqv9OCLxM9NtUdD/+8I51
 yFnttxPlw75TzWRZdAMobKtrn6AcIn6CT4vqnlH3z/SNMGlRIuAX3Iup0YBun3HCsca8ASIdv0o
 dGONZ8tLUDu2AaA2nOKOPpZ7jTS64NMWByNA9aj8V8cGv3DhC8nhK761Wp8xiGa4jBD/xZDw=
X-Gm-Gg: ATEYQzwafNg7BW5ZoemryijVfVv0IEV8eXBHsJ5nthztqySgRsuep7KA9X0KGnv9s5j
 cxYhjLwfcUGYY2jL7/EmkwHrPMXZHXHdN8YqTHXVTCkVhmjdUeOwz/DyDtmPLe9Dy+cvUgT5XPN
 hL0HKo5+dw4ohnEiFhNuesqpEUciGpn0sPxvyalhyLi4zZweTjKu2lNLRaoZN8hUMEPEPDQ8kum
 T6JWPPCfT6cs3HM4FSgWHSiBGO54ssaFTsTpY8R27vv1wJekRH4B/VM9+TmB9rcvGbnfWwzB6j2
 2F/hbzGg1Y+3hlRRFtLSnxxd+U4aFHcUAzGuTUDSRLqBh9kfrVAjvaipRhbSom29kFkbcwFhC8K
 r8YZr9WKckFOuZV4oR9AqSx5KGlO+Vnkm6O1Tr3Aidfs+Uc/ZXbjI8wkZnEXjObs3WxJ7elxf/D
 bF6fkrN85bH48LZw65zFbYMaDve1Xtn78U
X-Received: by 2002:ac8:7f8a:0:b0:506:6caf:3cab with SMTP id
 d75a77b69052e-50ba38533ccmr52007981cf.26.1774640903264; 
 Fri, 27 Mar 2026 12:48:23 -0700 (PDT)
X-Received: by 2002:ac8:7f8a:0:b0:506:6caf:3cab with SMTP id
 d75a77b69052e-50ba38533ccmr52007481cf.26.1774640902688; 
 Fri, 27 Mar 2026 12:48:22 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:48:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pengyu Luo <mitltlatltl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/msm/dsi: fix bits_per_pclk
Date: Fri, 27 Mar 2026 21:47:52 +0200
Message-ID: <177463970785.3488980.6066718261448635938.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307111250.105772-1-mitltlatltl@gmail.com>
References: <20260307111250.105772-1-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NenrFmD4 c=1 sm=1 tr=0 ts=69c6df08 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=e5mUnYsNAAAA:8
 a=EYcKVL8hNR3qEPlwxdYA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: c1tw7DD6BA5qVdLESZnQKZn1NPjDGZcT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX3j5uzMKKOmW4
 eVO9aEOV93EvI9c2D3f0I8uXJGb5CQGKS40cqR9pBsvJTjjQfb16YTxQ5ao9b2/AFYijxqdckJu
 xPoZSj9BJKvT808iASS9BcKyfVibIrARdDQaOf3T5dGr1dCUUrLwr2p8c5HA8IS9qAzqqh3HZ4x
 GkASLonUwTDwWAra3KTYfIflQQj1pzB+NUJkPBlyjhevsJosOOn/Vi6ho61pSJ7I2HL2MooZ+SR
 uvamEMlQmmWfiI29kGkgfMDB4+d3XhxbKL/r3ad7H1cB8xqEHWJMMD8RR6VohbSmHPjKo39HWwi
 b1zbNkzqyd0zSP+UnNptUDEJBQLUCaJwmy+6wflvpe51bCUp88x9gm7vlwtNidhuH5IFkDBpnOc
 oL+bRkt1S0YTyuNtvvJ4AFo+6iLT5l6HXKS1G23sJmuxjmHIG8rwP+GVkXtXLxovPoTyMX3e0On
 j0W8Yf5D6U0dzXQ5SZA==
X-Proofpoint-ORIG-GUID: c1tw7DD6BA5qVdLESZnQKZn1NPjDGZcT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270138
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

On Sat, 07 Mar 2026 19:12:48 +0800, Pengyu Luo wrote:
> mipi_dsi_pixel_format_to_bpp return dst bpp not src bpp, dst bpp may
> not be the uncompressed data size. use src bpc * 3 to get src bpp,
> this aligns with pclk rate calculation.

Applied to msm-next, thanks!

[1/2] drm/msm/dsi: fix bits_per_pclk
      https://gitlab.freedesktop.org/lumag/msm/-/commit/2d51cfb77daa
[2/2] drm/msm/dsi: fix hdisplay calculation for CMD mode panel
      https://gitlab.freedesktop.org/lumag/msm/-/commit/82159db4371f

Best regards,
-- 
With best wishes
Dmitry


