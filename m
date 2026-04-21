Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7EAF8FA6F
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 13:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE21110EC81;
	Tue, 21 Apr 2026 13:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b6xissAX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cf4Bn7Jz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BADC010EC7C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 13:07:34 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L9XVYj3164717
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 13:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=+m9d470AcBWT3RX7HkoLibpXjEoZwApzxhEhxK9DY1I=; b=b6
 xissAX6chkcXQB/h/iR3jOYV8PVRk57uEqtHaOhRJDhGX7ZvVXk32VobOhPMQxWK
 DZCtoeJRm0OMhXTKR3yu0EQmCGq7nzA9B0Wi/ZBsnad4wigZEVfsAToJbzUG0uRt
 nSLBZ7XUaVAApje2ysL4XKkzUA08d+kNWKk9dAf5Ii+8c7E1BQ3D0K0JRpIh2gTk
 JnZSf7VDRxcykazriFHu8tsjWLLay4415w+pJs8XE7dVBYXZID8sLoGDQRlc0VAB
 HLaGQOI4bkI90xItZsVuKN36Bq3BDbU8q2dxJVRQ9sj62MGjbwgZBM0NaPbc7uOw
 x3k8v41Cq0MCat2gLrSA==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp6q80qd6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 13:07:32 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6853c2438b9so7514414eaf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 06:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776776852; cv=none;
 d=google.com; s=arc-20240605;
 b=elOTcgLe/WjXKEnPlcQUyQSZmnPXCO43v4q86WME215tMghC1mUiU8JjQE2YW4NZ6e
 A8qf9+6NJl5nKBjuqtTyXyp8SLblicly+xfC0yTEQGHXBhGb/B6moMd2uEl1MLNeCQHi
 IbLFIpT4IlAoP2oBeG/Eps4anQ+ut0l7VgeaM4VR2IfRTTPCsbNLmMpBmJ3VEMDC/nLl
 hRTzPVnHzytl5FwGN4phj+1uRyFX1E+3NSHkxJyqSD9gy40ROlxqv7zqRdB+D2/liYcF
 jwCa588FAgAYCD5bK951a2v5U3vSUpwmw+umqpkLpM14tUHuHhwhOmNWXAngaZIBx0C1
 yTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=+m9d470AcBWT3RX7HkoLibpXjEoZwApzxhEhxK9DY1I=;
 fh=bu8whMtzU8LG2Z8xjIBuxSHfSX6N4PaRz0HerU4UGGE=;
 b=hrE+zFKB2lkiCUCDCDbRKV+9CZTT6odQVBVQsntvl8OJ9T5EQfDqv4k97KMySQrX5L
 /v+ZzIGdUyJASZPhOgMrfS79lUYEl/oxsniP3/NkZSWwhD5gUkg/hTWScPpUjNDWM7vz
 vqC8lgDyUobP1pKNwOuupWkbwQEmPPMhcbD91tl7ttcWwg0VBxrL7Cvn8NCI9E0Tj9FM
 Sakr/LuZq7WhmbiIJAzgW2IKA4lZFr1l7Z6xa5NL7WkU6SZdY1+emPQyt4EKdbe+YFTq
 Q1TmnvD3FrGEVyE7L8PU4YUn41toY6IE9PzHDGzxLheilFHLw3RTLOFRhUD7cfaUK5gv
 hp5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776776852; x=1777381652;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+m9d470AcBWT3RX7HkoLibpXjEoZwApzxhEhxK9DY1I=;
 b=cf4Bn7JzplVmo0BtOiRhnBALDGMsZoaQFOSASYN5VKxvFvHWAYVCieeNJ8Qf00U0La
 Xp5B+VBUEL/EqhGsas88ph8PF3ACcDJ8KPmfm0dT9Gn0f8j2UwXXnskBs+F5lfCXyDd4
 qBuKi5nbzHZbTYZs5lgmBQY+cgMrw3OGgaFM/VbrlNaXY5T4imglTuyZuduCZU7rf3z+
 VMmMpm8iOMIaffc3usSAVrEovbHl9v0LDidmU0+KGk1fq5WKxJT7kSyzfPgZ1IdVn+bS
 VTAqjMyylaRa5wQUrFl7+S//K17yowF6Sm+Crx7sSZc0bgk/0R2tDpGoG9XscW3nKeZk
 NDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776852; x=1777381652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+m9d470AcBWT3RX7HkoLibpXjEoZwApzxhEhxK9DY1I=;
 b=sKnsghlTbb2YOjhZX1EaA6FfE7oS4tlZnyS2GieGXqPwsWVlyijMV+xUc6U+z/l6+t
 fSrrMVrlpkLbnGgdgsO8Q/33h7clZrUWMBDSHSxld/S6J0Ubj9LDF8pXpwDu7uR9ZZqA
 cMSxeraDE1W0JMwhTOFrewRkwfcwHqnBUrGpZF068yaGbczHvnUCQ9FQLdtjUSrEG0wl
 p76V1SowZ81+hcGCT99JzZRXelcKgXtj9FiMXl1OuXrzrWAKeVg1y/du3TlRFP9XgYDM
 r1WN6MTZoaXG/VPwLCUoEf8Kf1Yw/4sS5RyGdFY8TZIvRMrrpL2D2uMpmcVNLDTHYW3s
 TzjQ==
X-Gm-Message-State: AOJu0YyEHmswbthiRKZRBBX31I19M83azd6Oovc/QQ9idYnemS9E2Uc8
 d8SzWZ0Ws4wSDr5MW9QbypovrMdfGrDTPLvOm2eCKrL8ekuUPG9h0nmR+a20Ia1Nq9R7vsMzow/
 J5F26KSWBKw5HTQfbz8HnzHEmEM8cyTpYukTCFnUiHFwvRm5HNsSx7VJsy5y+I/DxeZEXvSc6U2
 lzIELtYwWyyMuMJUv5zT6ziftMBVEdvtiUdkIyblHqWoh3ng==
X-Gm-Gg: AeBDieu39iBCbV91txnnujmh/4WMFj0hy5ah6Ku2Xt0KGau1FGKpn1MJGdSNFYGn7bn
 qSpRnldfHd7g7trxv5/Xt2jn5K+1EGwsmP5Oyj2LaSZp6GEB7VYExUFyf1GUs3Z6Gdz+69d8My/
 biAcd3RDEDg45fgKcgSDohPcK3MCDdQsK1Ot9wLykUfnjnU1kF0/AnnBQTfR/LuqNMoXsj9cxNv
 BAuM8rKnrdv8B/qgYk4oTcQKRgI1AxFKH3anADkxoEX516m
X-Received: by 2002:a05:6820:98a:b0:68a:24af:ac51 with SMTP id
 006d021491bc7-69462f31c45mr10520654eaf.55.1776776851744; 
 Tue, 21 Apr 2026 06:07:31 -0700 (PDT)
X-Received: by 2002:a05:6820:98a:b0:68a:24af:ac51 with SMTP id
 006d021491bc7-69462f31c45mr10520637eaf.55.1776776851292; Tue, 21 Apr 2026
 06:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-2-robin.clark@oss.qualcomm.com>
 <sidcsgvqxddatwwflohsd6gjzm5ehbs4alwaejh3pnjnlhj7vm@nqxhdtxxxizs>
In-Reply-To: <sidcsgvqxddatwwflohsd6gjzm5ehbs4alwaejh3pnjnlhj7vm@nqxhdtxxxizs>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 06:07:20 -0700
X-Gm-Features: AQROBzBCyjkFKVyWldLavMg98hNhLDQoe0JaPLwFFjw1Q5YUaiV57PzOYApag30
Message-ID: <CACSVV01TK+iLiaCofFfPU2eeMGT5HX5iW0rf=m+gjojXsjrk8Q@mail.gmail.com>
Subject: Re: [PATCH 01/13] drm/msm: Remove obsolete perf infrastructure
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEzMCBTYWx0ZWRfX78v1X3jvoAIp
 0kzCGuilZ99EKe1uWxh7i4mAoSLVYBm2rrBYwPCxfoGStqBDt2KLdcVEXD41pGeODfKl5Ceiljx
 ubcmBrQKd6N33JPFMz9g71afJ5Xh+SGrno8nAwyesTN+K28v4UwzzLtcmo1AASXkKEb1+BbDqM5
 tXZyDP1vuPF9QHGwmrqKB8Nr0tSfgrAH+hBpfE8LnbHmRysY+pX6Daq3iKbvFkHwfN0fsGCWZcO
 RyGIIf0y04gKrvS9PAUWggfGniV636GXBML0iYQZrE+CjDrxB/xL6MKCpQLN9AeYSNSf4EHpU5X
 lnBDkGgoM/NGQavAhh05vtfGf+2yZWf5HH4R+gKoh5Cm/ebv1PMd7aiT9tPf1kMzdxJQ1ycaUiy
 Fv4/hZVb30Cuf7fATe960XWaIMXD/VX2A3PC0L4+sXfphK+um4eUtpf56YwLV7sX1uUpzYtmYrX
 yxW/M+ONFfcoZUh4plA==
X-Proofpoint-ORIG-GUID: 9SQYzMlj1PY0xXK0zFILDUQjmDLeCIGV
X-Authority-Analysis: v=2.4 cv=eOYjSnp1 c=1 sm=1 tr=0 ts=69e77694 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=jFF1PNiZaEqFOHtC3HQA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-GUID: 9SQYzMlj1PY0xXK0zFILDUQjmDLeCIGV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210130
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, Apr 20, 2026 at 4:49=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Mon, Apr 20, 2026 at 03:25:23PM -0700, Rob Clark wrote:
> > Outside of a3xx, this was never really used.  And it low-key gets in th=
e
> > way of the new perfcntr support (or at least it is confusing to have tw=
o
> > things called "perf").  So lets remove it.
> >
> > This drops the "perf" debugfs file.  But these days, nvtop is a better
> > option.  (Plus perfetto for newer gens.)
>
> Would it be possible to resurrect "perf" later? It was really useful.

Nothing is impossible.. but I was having trouble naming things with
both old and new perf stuff in parallel.  Is it really adding value
over nvtop?

BR,
-R

> Other than that,
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/Makefile          |   1 -
> >  drivers/gpu/drm/msm/adreno/a2xx_gpu.c |   7 -
> >  drivers/gpu/drm/msm/adreno/a3xx_gpu.c |  16 --
> >  drivers/gpu/drm/msm/adreno/a4xx_gpu.c |   3 -
> >  drivers/gpu/drm/msm/msm_debugfs.c     |   6 -
> >  drivers/gpu/drm/msm/msm_drv.c         |   1 -
> >  drivers/gpu/drm/msm/msm_drv.h         |   5 -
> >  drivers/gpu/drm/msm/msm_gpu.c         | 107 ------------
> >  drivers/gpu/drm/msm/msm_gpu.h         |  31 ----
> >  drivers/gpu/drm/msm/msm_perf.c        | 235 --------------------------
> >  10 files changed, 412 deletions(-)
> >  delete mode 100644 drivers/gpu/drm/msm/msm_perf.c
> >
>
> --
> With best wishes
> Dmitry
