Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E837CD4F48
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 15:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98B910E4DF;
	Sat, 16 May 2026 15:25:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CqIhJgqZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aIuNd3ya";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 754A910E4C0
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:27 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64GF2S6q1254603
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WX1w94r/QaasPpQANeeI0L0VSU8y7Cky6BlJL4HBZNc=; b=CqIhJgqZI9rPdB6r
 oIgtww6GX7bMRomjaA8N1kYcZs8iW77PgXkYVTSlHYtfbrbjicQj4ec6XIrrK0+G
 /BoDfTBHJf+eg6BmB+BXSIXj8ijfb4WRbYWSrfrYMNikW6P+1bs0tO9ZJx5Zn5O1
 MwQAdWBgu+yDfO06GKjW+2E04JyMWS6j2rd245twIlchQE4e/9TEbm4s961NRscn
 RPScDQyd2zkJaN2lmRXnjoC9OI0QfsSu+zbiye6qHtLqMgrE+6NQmvS+kj5v/Hhr
 UakF6k0ydlcPAmTVzForqmwy5+siPoXBo+H0FOxun3NRKi2DD/7ymkhubZ1w5zih
 TkRf1g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6tvcg15r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51650041428so21483211cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778945126; x=1779549926;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WX1w94r/QaasPpQANeeI0L0VSU8y7Cky6BlJL4HBZNc=;
 b=aIuNd3yaEVBjM7Zo3Op4DQXqfToHhft32ueOC8d9rpgsteovl1NpkwWDMlVCWpnoVN
 XjVNcHOZuHTiKBd09sNf5yR4Vx2npjGJPOysjkYt0t6NW+nlIGGuzkqFjrf2p4KX91IF
 VADyUK+qBdm2zdR7pYf7ABeg7stBmHXZHI5kAAJtiVbzMouADMJ3BGWqMGC4y1wWk/Jj
 PzAkF+URzsPN/2/EqpI+PN70M20aEXzObD6ple/adyW2bxR9zunbn7RxqrGFkXwotGkQ
 eeZPIbMBtLRYucYpXy4PDdUak2rNTrbBtMEtnQdaUNDPQipTDFUx1+EVpxe+6ZuLilaT
 9GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778945126; x=1779549926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WX1w94r/QaasPpQANeeI0L0VSU8y7Cky6BlJL4HBZNc=;
 b=jE4tD07I9O1CeSBFmPenVAG0Dp6ybfKLp/8JV/XltxOZBc8/vbdAO2dBixrJYkl6oo
 3Es7smSd6FD3Q43vgGWpt5dkP8GYYp+mHc04rKPDeP6xKGNLgCLRyPucljRWK4fIQ1S5
 E0aTc1B/NXudJz1mV+Lezr195tAwkw89TCH3FsZuUjqN0YlH1LaPfZu4nEhOWUOW/bVc
 aQV14ww7fUS6msY5NnZdlcXjxbURp2zVh7rx6soZRKlpsMcrl+EqWewd1dNT5oXDB7+3
 xblKGss7OAEOx5BV63sybza/TCQPCSBDL2LYsgCj3u1jadT48g90iweG6f5BxRk1pwrn
 socQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/IMk7hEkA3rIPlzo/BTmzOELIlYZCMTJ4OWP1Z3Jzp2wNl2B7lpxE+Rv0p+wr9ysNBghjDe/JVhi0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4KNhEAHHm/XUXXLo/ymCzGHf1grzdEqCExeR29n5nMmPfzhV2
 Ei2Ni6OaGvv7Z1AscprgqoFa5I+6SYhYsQJGbNXYuY4gHQn95X9++BJnJfmq01HVPHhLuTnruzI
 8RTyyc+7XU7qL1CPDu+rSEJ8b4q/ofXWKeX4vzx0FP+qEexOdbb4lClaPmDuR4eVCrXu8wao=
X-Gm-Gg: Acq92OH7jEJLFaMnd1GAYHPiUzgL5roYgUHgpOACd4AIyMJVLf0FIK9UgV4bFnxZCia
 rQ1BpiHSgughuwRKarEAYedyC5FS+9S79Zd8Ls3K9reclir0+gM8hTcI8Gt/7iiOtkRdxAbr6Se
 kdgr8mDRvBI1fgen9T917ld5uOHUyWKSkntF87ISS8IYXu27M6j1QTU6gfKIrtsFIXzQ36g0vWM
 7oV1FN0bZf8eU8YoXTPIfe115Tpx2ajnnBTX6uI3QaBB+s88OYNIsKSdnO9yLjvxJ5aRb6HM7NU
 SRwb8IhL0HEzsukav7gFt5LQy9h1KEzO0fzFOBWi4l3mTX0icK1AxiO/pwjOGRNchE/8oyEHVi5
 rbE22SXYqRuxPmzEe7PIIlwomMTQXf02caINwCQkvv+srmX6/2v6c6THCcV9IyV7HBQs5te3vcf
 Zp5SipLBcO2KA23Bi4Y9eQVtMkR47vsbnufhk=
X-Received: by 2002:a05:622a:8e1c:b0:516:508b:bf4d with SMTP id
 d75a77b69052e-5165a276f74mr81299121cf.56.1778945126000; 
 Sat, 16 May 2026 08:25:26 -0700 (PDT)
X-Received: by 2002:a05:622a:8e1c:b0:516:508b:bf4d with SMTP id
 d75a77b69052e-5165a276f74mr81298701cf.56.1778945125537; 
 Sat, 16 May 2026 08:25:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164cd939sm2057972e87.70.2026.05.16.08.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 08:25:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: fix UV scanlines calculation for YUV UBWC
 formats
Date: Sat, 16 May 2026 18:25:17 +0300
Message-ID: <177894506981.2448625.3862253591759722502.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414-topic-sm8x50-msm-dpu1-formats-qc10c-v1-1-0b62325b9030@linaro.org>
References: <20260414-topic-sm8x50-msm-dpu1-formats-qc10c-v1-1-0b62325b9030@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RoexfhfXlgnD_KQMB9_n82_Es93-Jm2O
X-Authority-Analysis: v=2.4 cv=UIDt2ify c=1 sm=1 tr=0 ts=6a088c66 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=e5mUnYsNAAAA:8
 a=bg9aKFcPh1BOHeFtNEAA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: RoexfhfXlgnD_KQMB9_n82_Es93-Jm2O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE1MiBTYWx0ZWRfX//iH4hkuIBkN
 09ICt7ZnAaXmHrL7x/JPZqaJHzg/uHZ8X8UgQGQakyccyFPwGAAeW81o4/dR7DjoSmXl63dIFtu
 +4zk26ZTv20eC5NjhzWUk3gpNuRQRtAtUGjLhPnQdM+j0XyCAz3wzZ6HahDVi09HkNmH1yR5tGL
 4jr6cDd7moQjZpwbqUWbC53btpJu2zlOd9BJTPemH04NbF1rtdCB9c4II6jcFv2gdTfnycwto9s
 xEoqU2BvxKgPCORSISkk8Zv+Uo/OXb0jCxpNVNutC9SoPqQW9golcJa8oRkLEuD2koxBnuZJmc2
 505WATbxqUtF6qzBTSNzuzoBUb1j8nfe2f1SvoCr+UZYeeE93lIBgUhfSl/5RIoZNaoe4ldrtpf
 PJlJGhPl3lPunXMibxgr0l71zlmpefllO2SuEaiUOfeXryF8N4jClWG0tr5ajMurssNSOH52xDg
 UlMDGC+e5EuuN4Wo07w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605160152
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

On Tue, 14 Apr 2026 17:14:30 +0200, Neil Armstrong wrote:
> The UV scanlines is calculated with (height + 1) / 2 unlike
> the Y scanlines, add back the correct scanlines calculation
> for UBWC YUV formats.

Applied to msm-fixes, thanks!

[1/1] drm/msm/dpu: fix UV scanlines calculation for YUV UBWC formats
      https://gitlab.freedesktop.org/lumag/msm/-/commit/933430f1709b

Best regards,
-- 
With best wishes
Dmitry


