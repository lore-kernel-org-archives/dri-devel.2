Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469F1CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9166610E11B;
	Thu,  7 May 2026 10:25:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TqKvcUrv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z5HroGGU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2006510E1FC
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 10:25:11 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647AGtRQ879589
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 10:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=UQDRk0q0QWS/zSxYXlfjEJKx
 TwFS4cm8rZqdd13L8PI=; b=TqKvcUrvvYRFAKjai4nvZ0mwySIHdw+sZVi4WNvA
 9IvTmHK4Gng8FnCm8xB6hlozlcCI/j+fPNnfvAg7grdakjcQujb7Piy6hu9APGTW
 1k31Q/YOfaPs2/maSHgmlSmoYJq5xmdP8wo8wdBcd5wn5tV03zAFZWg1sTvlUmd0
 0t45lEeqljgZWTF00P4U+3F1Bx4WPk8qO4Zap4STtGh8FfncPL3ZSVRFhbBUrrHu
 q+pMlVXJGQvqsYYQTQObsmczf+tO0x9wSj3KzjeH8BDiSMNrHwNmPy6TixwnZ3IS
 jTmr1a9p5+1Qj7kaYesmB7RbY4Wu5yTgq0had4L/v/H8dA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kdq1c2f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 10:25:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d6bf346adso11152941cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778149509; x=1778754309;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UQDRk0q0QWS/zSxYXlfjEJKxTwFS4cm8rZqdd13L8PI=;
 b=Z5HroGGU0HcCb2kD4Sth4BnfVsWpqw/0Er3UWky4EBtdS1AsVpUZnqvjQzbFIJLbpt
 BeiGr4aGrCCJl9jBuwxTHvhWKuVO8AsQmeoWZ3tUnOQIJAfwFnkmFQAKoqjDo8NBlmgJ
 7kB5MKkDVQjXap+vucQIljuur3DC1ajxXI5HpZKdlYfb79nwdyLUoK/BuPdD7qIxujaq
 rsAgJjWPSjJWtBNfqdg46OqIQU00OoQQYbGdpG74AQOvXNR2Vce9UJ7pBgsDngt1zir6
 05UrtZtukdivUEnx2kwDfE7I7PTc2fPlC71IvdPeuG7ynUIMCODoriWXqNZ4toymxMrm
 kf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778149509; x=1778754309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQDRk0q0QWS/zSxYXlfjEJKxTwFS4cm8rZqdd13L8PI=;
 b=Ap36g+94pQffwP+cDvmI0hZfDHKlcuNgo/lOSNNFKHlpcUhZsal/L4ZP4Wi0AtNyjW
 G3nP0TqJYfqbIZd1zsleefM1gUc5Zppjut4ZQjhAXzNmeV21EfN7o2DkdPDblzgnsIUd
 w7fRbzHh4RlvQeFQ8slbf5J8TixZj1eoxKMavzfnjndd+Ue/ZLo332L8ucPqTWmG+EC+
 r4nroGYU9GRbJ86zq3hZEcblEeD3dBXP8zcO4rBtrxZ7j2oIrifYoygTiluOh0LG5qMx
 /1jPULLkpOYZ5jY+XaujUHDmtbJB9UCbV6zc+HeFi9BNdAT33KnGHf2hYnoMO+97x5DL
 WpQQ==
X-Gm-Message-State: AOJu0Yzu8u35km+yeje4L6je5oP/jb58lyxhO6M2/+MoWs9a/H/PFY8D
 Ov2O3PYqYhBZYMI7OWxOrD8xyCoCI0Z1VXOmz/sQytxooTxRFeP3CdcmzyCjlMMueMPZqLxNv5d
 z7H2ViUULUzyQkSqxFmu8oKysRXPSe+KYG9PDjgw6JCSEuCmJpp6mGk0jllBNzTc/VgerVHw=
X-Gm-Gg: AeBDieuz0DiQD91TyR3tu+jQJjuFF5gg6K0/LcNZpr6yPQ6igL+xV+b5UG6EXzRcmAY
 62BcA5KUFqf4zsLeKChSckvRyHwOdBBptidKyYOJi/j8dwNQJGdMjZyWrSIFgJN9HwGWhLOST8X
 OUM9UQzubK+AEKI3/vI5NOeGcrlohWd5skz5ngjbANMo243tei7GfzYXhC6Mh5ELUWgHmqYCFI1
 6FPCpeFuTdACwwF/ZDI1VxhnJynzLX7dsH1g3s76Xu0i71Yq2thIUHa5oohGHBTWJ5BZA3ffVvK
 HVWkPT1b4Qi14DdaTv2qbyu9tm764UuxHcGs6amb+rqDd53JHgUyZXwU/QpgtFgQG9+tkBo3CGo
 CnsgzJ/Q7pMZuO/bftpAYwRwDk4JU83cQIk86wLwGKNCHkZu5c0gBY40lUej2VJ3P+iKz8sRxbG
 jM59WvGKU59Jvbai9S6FWEY20l3gOKwNBOKB9+SWk1Xmakkg==
X-Received: by 2002:a05:622a:558f:b0:510:4174:5086 with SMTP id
 d75a77b69052e-51461fa02e0mr94750401cf.28.1778149509608; 
 Thu, 07 May 2026 03:25:09 -0700 (PDT)
X-Received: by 2002:a05:622a:558f:b0:510:4174:5086 with SMTP id
 d75a77b69052e-51461fa02e0mr94750041cf.28.1778149509121; 
 Thu, 07 May 2026 03:25:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a86c7a1698sm4123047e87.3.2026.05.07.03.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 03:25:06 -0700 (PDT)
Date: Thu, 7 May 2026 13:25:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/16] drm/msm/registers: Add perfcntr json
Message-ID: <aigfthmrjytktawlxi42zsq5rgvhwus7saqdusjv22wodn7fuv@5chrjknkz3tr>
References: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
 <20260506171127.133572-6-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506171127.133572-6-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=P6IKQCAu c=1 sm=1 tr=0 ts=69fc6886 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=e5mUnYsNAAAA:8
 a=EUspDBNiAAAA:8 a=thqBxEDTGtn9z525fxIA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: Ybw5LQTY-4YcJRwZalYsUPLa0FIYbQWN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEwMyBTYWx0ZWRfX0ZRRoFFXCTDg
 Jng9GXjBwFBEvGTimD5DSVulg+cDiEfZik0fJLSjeKbLFnPNyZ5MYpXwcldPSr4cIxVdLPOZGZU
 Pqs5oUAF7aiu6SfIBZYvyK2Ky8vDqoTvu2aZNiw3RdJIVPiCbOrVf/Xt/qCDGCvSy7v6fVeeib0
 CBE2DdQhUlHNlJPtS1fd0h6qoXnGAUFxQ8GV+W3+vkicNUDKXnn8H4Jcm9Gm9YEWOa8zhYAxSa0
 Nda9XPwtEXtBJ2+P16YsNBK4AhBd0Ky7umqOYT+CabDTJA9thyBPXOxJgFgjZ5SD/6o+DfMucw+
 Stjp6iF73GmX9Z/Gj2tB2QwbhWPZYUrDHXbXD5AplStHHxHUaKsUzEGeVhl5koDBXTMGkErJkyd
 G61ChHguDoK1vIazCLUWCPjXWhUhXIwmCSCsjNjtLOHiFBQ9NNEBDwURDlN9CtR4CJO/D26U3Pf
 xNTn3s0bkDRZzxwdoUQ==
X-Proofpoint-GUID: Ybw5LQTY-4YcJRwZalYsUPLa0FIYbQWN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070103
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

On Wed, May 06, 2026 at 10:10:29AM -0700, Rob Clark wrote:
> Pull in perfcntr json and wire up generation of perfcntr tables.
> 
> Sync from https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40522
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Makefile                  |  25 +-
>  drivers/gpu/drm/msm/msm_perfcntr.h            |  48 ++++
>  .../msm/registers/adreno/a2xx_perfcntrs.json  | 109 ++++++++
>  .../msm/registers/adreno/a5xx_perfcntrs.json  | 128 ++++++++++
>  .../msm/registers/adreno/a6xx_perfcntrs.json  | 105 ++++++++
>  .../msm/registers/adreno/a7xx_perfcntrs.json  | 228 +++++++++++++++++
>  .../msm/registers/adreno/a8xx_perfcntrs.json  | 240 ++++++++++++++++++
>  7 files changed, 882 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.h
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a2xx_perfcntrs.json
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a5xx_perfcntrs.json
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
>  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index ce00cfb0a875..337634e7e247 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -176,6 +176,11 @@ quiet_cmd_headergen = GENHDR  $@
>        cmd_headergen = mkdir -p $(obj)/generated && $(PYTHON3) $(src)/registers/gen_header.py \
>  		      $(headergen-opts) --rnn $(src)/registers --xml $< c-defines > $@
>  
> +# TODO how to do this for a2xx/a5xx which have different .xml arg?

Nit: the comment is now obsolete. Other than that:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> +quiet_cmd_headergen_json = GENHDRJSN  $@
> +      cmd_headergen_json = mkdir -p $(obj)/generated && $(PYTHON3) $(src)/registers/gen_header.py \
> +		      $(headergen-opts) --rnn $(src)/registers --xml $(filter %.xml,$^) perfcntrs --json $< > $@
> +

-- 
With best wishes
Dmitry
