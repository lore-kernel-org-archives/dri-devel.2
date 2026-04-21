Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD8CF8FA94
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 15:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8276410E8E1;
	Tue, 21 Apr 2026 15:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LJaIGwvn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ARs9NiWF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EEA410E8EB
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:39:10 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LD6x9P3574144
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3XNvd2Yokfo42OCMof3NU+m9TSn1ECI2U+G+NHt/7YM=; b=LJaIGwvnx6TH7WtW
 LJxnBBKdz7mLdF6J4l6xPSN+IHubfGyXiSJVHcksk7q2w+FQBP3xQnjgPDK8Enzu
 RI6c3j+qKPkOd34Yrjs7VUh2jIgSdKyWQoRdwP98ZHrNtsOz4rOweEr5e/VRDJfY
 Ow5qNxvIqu4hZe8sdinTENHv8j/VdLvya/P7wLlvAbHDfkHYoyuEHsKElNaVRZkW
 LV6KVteIxS1T6D89IgHPWNs2AdMz/OCRBktaeJHs9aP01c5+UxR6vKXG6DONZn8e
 28jUL0B4qP2CT1KFkdls4zLJFaZK6Rhr7mLwZ6kdQ1mHY8RpAdrasIDFsvK1lWb3
 ZQLfXA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp465j0b5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:39:10 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9539bc7e2d0so7404487241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776785949; x=1777390749;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3XNvd2Yokfo42OCMof3NU+m9TSn1ECI2U+G+NHt/7YM=;
 b=ARs9NiWF3ahuvHSrZmdwgWx33aO/9rqo1plkCdHYVreX8D7eN2wULRWj1MMDms0g7N
 LlpaAAEpjUO0ulVo5WxFVxq8o5HV/iHa0lA9DDN/3doJPOvaXgKHH8AiAZurOdDH3YJU
 IO4GRbqBq1IwjCweR6Z6XIDjqhUhmqojUrU0tS0kvv+FYbUfPyzT0XW2vVGEUNx9wguR
 cEAgg/NT8d7R6i60EIGLVSInPBf0RDqOx+RoXUfT04sy9OQr1ekzePG9HpzmEc9qZD4v
 41ZF6gYT1xJoeE0pN9vzDdUSJWZHUshoLnAj1BLyGZm2k9Wh9ZBEo6eCW+/DroQaVE1n
 qVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776785949; x=1777390749;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3XNvd2Yokfo42OCMof3NU+m9TSn1ECI2U+G+NHt/7YM=;
 b=l+YS1Oa1ZcIF39fAM/MfX81Y3cSSz0o2zBQm9adQ+tyyJRtFUqHKvJ5OkdPEzfgW0z
 npDTgvS5XFzkfY9S7CkVaShMqo8cELqaRg/Z6oFXFA4zq9t45hm9hQe08WXtyT0GWbZI
 RVKcr+rEXzZJQ5dxmUom983tCLBeM+gIAdRl2qcw4TifCUd1b6uIy3kEXBvgtSRaLwie
 YnOqrwXdS3wTVdfnF6MzLJQMe4GEfbxQ59ARZhS9m/X4ZnIQeVpUiJFLZLRDV/1WLx5G
 qSEx4bb8EZg/oJQGJFqdLbDHbD+7I9s+JBGmtGC2lHVQ30b94j37dQ/Ym2sZKNnl5Hcw
 PCyg==
X-Gm-Message-State: AOJu0Yycdl6u/TTawhXyXyMAUyMcPGC1WDy44hz3OMc9Mg1PGepIU1Jv
 ZYQvM+OB9cDwKa3JFCNSv0XI2egJSr+a9fhXC1fWi6yLdsYRiZBPZqSzp26/XkQMF8Q6CY09PFo
 VTdqk/E6kYLR2R0QTiT1jUFtwvE4vfbVxL50Gqx/WgscSbeGdr2lX1aF1hFipnEXEEe1y1I0=
X-Gm-Gg: AeBDieslHdZ6anMlkSWqvOc9Hdw2PtH/NdHQ9K2QRGK9eWjsITIgL9ZWPd86kwxXmOY
 l3CZ21B2T5ac4SCWp3JJhgqxVPz7Kb+n7YrReaAAIKgS2zBbsYAriYDEzeQNITWICV/mH9BqXQY
 orjFCXXrVtFllyL2C4lu3wJpp/oRdQegnbHU8nHQWDlEvAqmJI3niNkpQFtLYabUSzMJvor9Rae
 +DU3WLIoe0l+6kwnJgXtFWbHqlKNwZX+t0aszTLmOrFXjLq7sJAMDI2dw2czPoNmhbEufgigfuH
 e4q3/9biBaDLCFjp699vUr/y8WtNA1NqRYcuqskcbpIpm+bGDXr0bDkZYzhPYN2lK0u5hLulNLv
 fwJwZjTINVwQ2KyXRoLI9sAze8edLB5rdigUmppXDsZLfQg7OZU2oJSx4Y9RB0sdMHthVMx8KAj
 rTMBREe13TVXuLwHf5zj+i64n0heU6sZ2k3MzYIXNjJJwNlQ==
X-Received: by 2002:a05:6102:5a93:b0:602:8742:1fa with SMTP id
 ada2fe7eead31-616fc3bb2f8mr6819573137.9.1776785949025; 
 Tue, 21 Apr 2026 08:39:09 -0700 (PDT)
X-Received: by 2002:a05:6102:5a93:b0:602:8742:1fa with SMTP id
 ada2fe7eead31-616fc3bb2f8mr6819566137.9.1776785948590; 
 Tue, 21 Apr 2026 08:39:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb4f5035sm31023871fa.4.2026.04.21.08.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:39:07 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:39:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/13] drm/msm: Remove obsolete perf infrastructure
Message-ID: <puvvx2h2jnoxej42blcdx357uzx37ogwnqldcynklmm4acameg@4zvnrueodcon>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-2-robin.clark@oss.qualcomm.com>
 <sidcsgvqxddatwwflohsd6gjzm5ehbs4alwaejh3pnjnlhj7vm@nqxhdtxxxizs>
 <CACSVV01TK+iLiaCofFfPU2eeMGT5HX5iW0rf=m+gjojXsjrk8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV01TK+iLiaCofFfPU2eeMGT5HX5iW0rf=m+gjojXsjrk8Q@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1NSBTYWx0ZWRfX4PKsLt/IurUs
 +YQFJCRWNTJQtWJFbpTScBs7Y2lwndRmhhRo0mpE8dJcYPXSrN3wt5pmplUuWPFXteKxBDZYRUc
 A0Ba2rlcAabvwFfuEAHTmDnl3oVsxWRD3anoWr1LpMDTefjZh5uiT2LoS17CPhuJuI+emGD46yL
 SoKIsRGwldT4iL8Dnq8kj7gY0BgkyFG7WrlRbuU1lE2qDcm0hJtdtKY++BvQ9ESrfChcDFTSYxn
 hNuVCzizXoIieDVxvKtI4TDRyzhuVjikfpIdRV7SmrP3vC6O7jYG53yqrhoaiOOWHbhkxwkVyJl
 ck4bjodq6Bpfn7517QZ6YZeF+d37HNmD5k+e+nfafCSbH4gxDj0FjMSCJUnaThlnsQS+9stSZKH
 4248+bnk09slB1NXyEAf8OQd10iDlnx1vhdsIcmVWP3/GbSCHJrKHtdzgSiYEW1TfN5ZAqXBC88
 1R77zdBgRJGdxEvEHLw==
X-Proofpoint-ORIG-GUID: o26IKEebH-M2oKQsmX7dW0n4MJDnDplx
X-Authority-Analysis: v=2.4 cv=YOSvDxGx c=1 sm=1 tr=0 ts=69e79a1e cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=cnqLc2S548nY-WTIRJIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: o26IKEebH-M2oKQsmX7dW0n4MJDnDplx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210155
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

On Tue, Apr 21, 2026 at 06:07:20AM -0700, Rob Clark wrote:
> On Mon, Apr 20, 2026 at 4:49 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Mon, Apr 20, 2026 at 03:25:23PM -0700, Rob Clark wrote:
> > > Outside of a3xx, this was never really used.  And it low-key gets in the
> > > way of the new perfcntr support (or at least it is confusing to have two
> > > things called "perf").  So lets remove it.
> > >
> > > This drops the "perf" debugfs file.  But these days, nvtop is a better
> > > option.  (Plus perfetto for newer gens.)
> >
> > Would it be possible to resurrect "perf" later? It was really useful.
> 
> Nothing is impossible.. but I was having trouble naming things with
> both old and new perf stuff in parallel.

That why I wrote about resurrecting it later, once the new stuff is in.

BTW: do you plan to get perf counters for a3xx-a5xx back? I remember
that there was some issue with a2xx ABI.

> Is it really adding value
> over nvtop?

-- 
With best wishes
Dmitry
