Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83808F8A160
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C342710E830;
	Thu, 16 Apr 2026 11:26:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YQti7CYW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FaFY9+Te";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE7910E830
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 11:26:34 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G6JNR71668219
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 11:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=GKL3L0XkFJrjV8Cp1bcdi/Q3
 KrqtkofJoOm2RAC2cTw=; b=YQti7CYW/gJaJXc0L7SXwUciwn71kiIwWBJm6YMY
 pWR1fgdL3yD+aolzlOAaRPTBi3PCPibERW/ixrAQ242XdDFWqmlA5prE7uuGqYEB
 nJ25D8Ia/5EOtOzERKxWVFE6M+DLVYVAYfuFwLbYUEI2u89WzyVvYqyAAnpDppiq
 dMV5BHpP4YTMK+btFmxcvNNN3fI/nR/z71BlH0d70p4IhJLTOGYivZKIgq2952Xf
 B/nIDquXavphms25JnbYVG16Ta5pg/n+q/A06qDhcSr0yBaMINc6zb+jtTlXtxKh
 RrAyEOPm4LbIUhlzWM67KWz7ipnSi8LnNEjPBtprscMU9g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djtd91467-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 11:26:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d63962d83so189376341cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776338793; x=1776943593;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GKL3L0XkFJrjV8Cp1bcdi/Q3KrqtkofJoOm2RAC2cTw=;
 b=FaFY9+Teu8pgUsMk87RxDdQd4dabycb7ExPbbEsSyemi0pR7WsJyWnbsw58AvLZaLy
 kTdqKNsyXqB+v6RflT7aThr0hh2tSZeoRYyCAAjYzebdhm5N07GI2LqjENRKZ0o0j1o0
 CBk2tLpn3i1zAZjYkVDZJ7Vz5xma3UFv68biHsumm3byMl/ZQj5hKf7ORthCCj0468j0
 ns9b0QVmininmwiGkHTTamtdRLzLjE6xiAGCSGT/0xPPtNkXuba5MOIHW/f5ZlmqFVzC
 GkAkW4wjoWut1HeATK9mtgTL/8RjUvdRL9mO48dPxFqgwzMlYYgEfhAthd+xj3mUbnul
 ysww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776338793; x=1776943593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKL3L0XkFJrjV8Cp1bcdi/Q3KrqtkofJoOm2RAC2cTw=;
 b=qpKc54gGvlIQ0jK87w4BgdWXVDt7AMbsKFRnOKnepNn39OxAb6Dz++tDXQfonzIiAY
 wBXwO0D7EnIkja5mVJjyPrE1zKtswSeuSOpynAtRcojHe4iu3JDJAimBWd+r1gNtCNQ+
 M5MzjRwbsrT6cdOFEoTr80RL7xOnjVscBIajGs0u5Y3HjwPQkKPqnJ5JLUNMgTiWNl1Q
 rSbonJ1DqSt5gHMwq9zkOPxM/P5w9PaAPNupQ5gprr86k5KjJpd0JHx+AeS6eJgEgCSd
 4JNWrgVS44AhopYbh0UQsW3UlzWidPsoMc/hng5tuVzfrmxzYT5vguqZMDAHoj0rTI4D
 gjQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ88l8YPnHAo22Tf94qpNjf03aeLDSqdUK3M7DzmYG8hJAs41mGVMRm1vjM+a0VhhUd8Y/PQ9e1jSPY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1W+B+r6F8reNow+L67mGifxEdrMlNb65xWDqW3iWyrHhqBVGG
 5TZi2rYGT3Osj/FX061uz23c/+a1q7hIElFVCOwTkl4WApGLwD24nR4DrrfvZqQshm40jO/ibxA
 jaX6DHbCcjmxUudMi22yjGP27Z4Uy7DPC05L0qwzBHlsbTw+88lG92crTpuvO9EAaSe8RJo4=
X-Gm-Gg: AeBDietbM3d1BcMY8rmY9eafcOTU33aQA6RT+XSzyzf4dbIaL5xX3PfyqCXmmhEI6Vw
 8T5RY4VDdfy3PhxXyxzD839322aVUwO8JZHCCMRTSmjnFhlhSc8oCrMpat2tF/wHMqZ1gYk/nd5
 hFTU2OtejK3reY2yMQtj67PIJ2rFb/uacpxhTb+7SMJJsd7MKuare719fUvY7sjvilM6ePOvsZ0
 8jMJZNDI4B0nxGByMPlxht8sj303nyokuGEPwzb80B972OJL2EOdRfuXojr4xsIRaC1Qaw712jY
 EIdPtAGUTaPTkQKABWzHh3lVnjdkZzgwu1zHkqk5ypXvsamkiiViy5cvK8InL5sml9gcLio+Lwr
 unpJS8210ORIkzf0VjaonBE+4jIbuIMQI3d+b8Xi57UZ6XMY5oo+ZBlT+5LJ3EN0kLDpJ+h89jD
 cNychQoZHnV9vMYSqwj67GKLTFWQbJ1yWB/S/t+bpztXLZQg==
X-Received: by 2002:ac8:5889:0:b0:50d:a8f5:1bff with SMTP id
 d75a77b69052e-50dd5b30fb6mr376511711cf.9.1776338793075; 
 Thu, 16 Apr 2026 04:26:33 -0700 (PDT)
X-Received: by 2002:ac8:5889:0:b0:50d:a8f5:1bff with SMTP id
 d75a77b69052e-50dd5b30fb6mr376511431cf.9.1776338792630; 
 Thu, 16 Apr 2026 04:26:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a40a272852sm1220326e87.10.2026.04.16.04.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:26:31 -0700 (PDT)
Date: Thu, 16 Apr 2026 14:26:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com,
 quic_chennak@quicinc.com
Subject: Re: [PATCH v4 3/4] misc: fastrpc: Allocate entire reserved memory
 for Audio PD in probe
Message-ID: <czcgifek5luglduvk25u3d2kltwis56333icdvol2vh7dvhgta@3qfddjrsvmte>
References: <20260409062617.1182-1-jianping.li@oss.qualcomm.com>
 <20260409062617.1182-4-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409062617.1182-4-jianping.li@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEwOCBTYWx0ZWRfXy5bbUmweyPb6
 gPM41bdyYEPYwdlHTprY9KwSI7owy/sTi9AgJwjfmdfApTWhQ6ko66y4f9UoBttHKuOGfNuMSfN
 EUpi541FvLkyms6ytYP9V89w1yOwx7HwO2QHZaHo05q3UrqahXGlDycJ4+EMeAQs+AW0QOeKnK6
 HbBMxGOJb67qvFMVKzYzFgUvQ5u2riGGSSqHKtDgmD/+Mkw6B1K60TGqDDj77yutNiVFZI5VNXx
 cVOJceNdosrRhqamcEG76iY2JMw9nRMCXWL296XLImcdoBch1vaUTg7puugrS6EeUDYZtOgmwlF
 9SGOowDg7IRxosZl/TP3XtT3BpW3Tvoq+kMkcC+7zZ6MDrzXAeGcLbhdTQHh8H70seFQbBFM+nM
 NyiZjTsDIgbfqLkFcj9WIM7OBoeW9pva4Xbtz2LIVxs3nuLac71iCbR95S3nDihdeDQRCMkzUYp
 864S2CvaV/Y0oNOq+nw==
X-Authority-Analysis: v=2.4 cv=avuCzyZV c=1 sm=1 tr=0 ts=69e0c769 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=qAkFtAADdWEuSrs4xykA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: bswemHu0JZN8KyZvdArENSAuR-1Rx0mI
X-Proofpoint-ORIG-GUID: bswemHu0JZN8KyZvdArENSAuR-1Rx0mI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160108
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

On Thu, Apr 09, 2026 at 02:26:16PM +0800, Jianping Li wrote:
> Allocating and freeing Audio PD memory from userspace is unsafe because
> the kernel cannot reliably determine when the DSP has finished using the
> memory. Userspace may free buffers while they are still in use by the DSP,
> and remote free requests cannot be safely trusted.
> 
> Allocate the entire Audio PD reserved-memory region upfront during rpmsg
> probe and tie its lifetime to the rpmsg channel. This avoids userspace-
> controlled alloc/free and ensures memory is reclaimed only when the DSP
> shuts down.
> 
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 104 +++++++++++++++++++++--------------------
>  1 file changed, 53 insertions(+), 51 deletions(-)
> 

This patch applies neither to linux-next nor to the 7.0 branch. What was
the base for this series?

-- 
With best wishes
Dmitry
