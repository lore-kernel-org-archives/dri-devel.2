Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0010CD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 12:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3021E10F58B;
	Fri, 22 May 2026 12:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ohkY18Z0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PttqrRQa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 392E310F58C
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 12:02:20 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M9p19i312901
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 12:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=nD/+j47ehtNUQ8oIwVeJc0d2
 qj5C600OVqEc0s7ltxQ=; b=ohkY18Z0WezjbpkdT78t2TuKtVLmjZyFnnUyDgDo
 tngXsI/TaofkXV0ySgyE9z6qu1+tHj6EM2SJ2Vh2nr8rOKZDshm4nAb3TO5sD5aQ
 2HN9dFcUd/eTSrdBuKP9Vyqc+LCUjQbV2E0ub+3GWCAomY3YqxMtccjTP8tB0uER
 7cWDpDE+kEKafq757ATvM/dKs52z1f5OBKkU4muub5lJqcOTuiYAop/L/30woMdK
 rEi7KGO4zA9GwiCgF/7fcGtCxBdIalPeC/d1ZqlfWsjNqSe6jXyqCEPS/1KGmGui
 DdYqy8HY/5JkL4KjmlCYlWjZxPZe385QU6Ew9WdIo9mm0Q==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea8833p7u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 12:02:19 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7dcc9e6b772so21066494a34.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 05:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779451339; x=1780056139;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nD/+j47ehtNUQ8oIwVeJc0d2qj5C600OVqEc0s7ltxQ=;
 b=PttqrRQa/OgsjloaiclztpstTFAOWswfRnzz6tikGQz2Y2UN+0hX8eO3Nqwhbl3Qs2
 yxhTcQu5DdZ5CFL7x+3Qbf244S3Mr8Sm0ljKzDs/fzosoGFa51FlzHotaA4+TgKXnJPv
 Mccs6oRn162XAO3yytDmmL12nopbSOdsNTrZ822o/bh1N9MUPo5mL9LpwiwVnwyOJlH8
 1nuNSb4hoGHWpAS/ptHk969I1mgGXM7R5jPGsQmdk2dlsXpxjLzsfP/tkXUJqc+JoaOD
 PoJkRlZTLDK0T1xjRT8b6hPgqJoQlYwd5ml28N4jCxoG+CfQcBBJfQ/dvmc8AIsCdc9h
 h4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779451339; x=1780056139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nD/+j47ehtNUQ8oIwVeJc0d2qj5C600OVqEc0s7ltxQ=;
 b=kiqYoY7/Ep/gQMZ8wDeLySUj7wUonlFjdqYEKeZqcBhMi6wBHJG3oKTEJxRZOSm9u9
 cBCh074ICQBQCmscqEV390bMYWxXhNf3np4TpGrmGVMSHv9rJcRAQASGjbmeamJDt/TW
 346K4bsAE5r0/gSH6IFNyc4SV4oLBRgBELrdQAKBoa60wRzivVyfq00Qp8s8qlshOJWC
 aP/IBjmqhHam8GZcMn7hylAKQN3UGAHeESibjLIVwa1LHZkROhgjr9X5YUY0GZAUi+8N
 WjzuipmpuE4ya5GQBx1A0+UwTYSNh0TXn2euF7p8eylkTTn4dILQVsKAuHtWXxCo1H64
 cOyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ90dKWP/ss6ly5TQJaPZWer1JyUqUP0FTfC6WlsntpPnX7SeF00ufyEWQ5ug9E8DxGfRF6an9CvPlU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyD2h4oItyTyxI73QqO0dVdaUhaSjgx1lhhAT5qPXbSU5e6NIDE
 iaERLGhrqhOWedyKuqsWhzG1nUhdNX8SJ1IwYWtgzV6DiwpCzuvufpn+e5lWz2mIiel0k/leaoh
 txTC6nrgK27AnDouFz621idD0yLnrvud/dsPBdwse+4qdLwB7N/nGuJpT5qQuiheRaxVnZyU=
X-Gm-Gg: Acq92OGi7U9RRbraXlwGtKEQhyZPQ6nKGmhKo6wHkVqnHXi18PRhXhjhwW9TftLdrqF
 p3tHzbxXvTxQ4BCIop5V0jYW4pVfyKYwhD/lq63wVXgPAuYaXKK2cV2dY5fU86XAi7zPnlwGfkO
 cnaULFq3ERXx7iGj0jgfYcZds9CYHtPgFh7TmcpQCd+raEvvFbkQ2dD1+O8rwkUBjHz1C5gGsrO
 AmZQ1VR+3sVYWpYKrfDFiOtx0RKfszNTS1gVwqRNVQVjHqUhoaJtL8hjtX7STsuhfdzufkvPEwL
 AH5oWFX7LE5Kv+1EC8GntXtMP/TEJYb8Nx6waFrIY9G8/jpNEQBfv9s8zuQES2wwhuDOHFHb7A1
 UMiWr+HN7vM1LsemZZk4u63ILzgVqxoHSx/CZXghXWACUat7DgZ4e8jFbVr3jjgcBJ/fZblhRhd
 uQ+ZleztxbQGkYViiCPHpm2E2doZQ+ZCmY4pI=
X-Received: by 2002:a9d:6a50:0:b0:7de:cf3f:1b3d with SMTP id
 46e09a7af769-7e5ea37d7c9mr2854543a34.7.1779451338596; 
 Fri, 22 May 2026 05:02:18 -0700 (PDT)
X-Received: by 2002:a9d:6a50:0:b0:7de:cf3f:1b3d with SMTP id
 46e09a7af769-7e5ea37d7c9mr2854502a34.7.1779451338149; 
 Fri, 22 May 2026 05:02:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cb37ebsm386472e87.14.2026.05.22.05.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 05:02:16 -0700 (PDT)
Date: Fri, 22 May 2026 15:02:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/10] drm/msm/dp: clear EDID on display unplug
Message-ID: <kpx6hqics3odr66whpatyr4q3onj3sbm3bmoesr27u4up5wrcd@irdyyavhfvo5>
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-10-0c8450737d64@oss.qualcomm.com>
 <93327e80-c4fa-464c-90d2-26a7b08b2ea9@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93327e80-c4fa-464c-90d2-26a7b08b2ea9@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEyMCBTYWx0ZWRfX+GyyDc+eBYQb
 FzsCAQa/3GWo3LI0eSbYn2GMAnJnE7j8GJSh1wWoL//0wR9t/8FbCR/sOULSNCZZT6ZE9IiWtBK
 Cm0n/y8oOUbCDawi3jwzM0jA+Gm6+2nnRB8XfvufinehtLHj4Wz3lraq6hzf2vJwQqqE0sA8xST
 kdZFZIBkSJn1/laC3Z29tzidcPIhB4fpzexQ2Ef4kZIS45OpxDtnqXc4/Ek5zJmI5cI+NjpQHcF
 9jBkAJ+9W5NHf3jN6ZW7+nqfovbDGMKWfAgp7btXe3pWSEOGZqEwIZ7iWTjnLk4qEbfkCmzDpBJ
 J13bQSuj7w6Jl8pEC+qKKDQhmizGUzkndlWMhs2X5t1VslK1VCv62AEF4m8rza4Vy1LOcW0Gs/u
 EH8zUpcgW7kKFOUkZgmtHG8CPw7KUYn6vezN+V/4c71g1evxJd7OVUnfzS7o+4LYkOgBirJHGXn
 /Yz6BDm4+X+B1ppBq3Q==
X-Proofpoint-GUID: xETi7Z7uVmYhBgWQIHTx75JXfTS9LDTU
X-Proofpoint-ORIG-GUID: xETi7Z7uVmYhBgWQIHTx75JXfTS9LDTU
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=6a1045cb cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Age3Ohp2d5d3-k_hZ18A:9 a=CjuIK1q_8ugA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220120
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

On Fri, May 22, 2026 at 01:49:50PM +0200, Konrad Dybcio wrote:
> On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
> > Currently the driver only updates the EDID when it detects a connected
> > monitor, which results in the connector still listing outdated modes
> > even after the display is unplugged. Set connector's EDID to NULL on
> > unplug to clear the list of modes.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/dp/dp_display.c | 4 ++++
> >  drivers/gpu/drm/msm/dp/dp_panel.c   | 8 ++++++++
> >  drivers/gpu/drm/msm/dp/dp_panel.h   | 2 ++
> >  3 files changed, 14 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > index 0a38957ea901..5c6a24ec140d 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -447,6 +447,10 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
> >  		return 0;
> >  	}
> >  
> > +	/* Don't forget modes for eDP */
> > +	if (!dp->msm_dp_display.is_edp)
> > +		msm_dp_panel_unplugged(dp->panel, dp->msm_dp_display.connector);
> 
> Is there a change some ""funny"" panels decide to output a new EDID blob
> after a "proper"/custom reset sequence (e.g. to remove limitations
> presented to the DPTX at the UEFI display init stage?)

The panels don't know if it is a UEFI init or a normal reset. EDID
changes require a long HPD pulse anyway.

-- 
With best wishes
Dmitry
