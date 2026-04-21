Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E116F94CB0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F7710E235;
	Tue, 21 Apr 2026 20:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bH7BWvrD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AvWyHHBx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA0E10E21C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 20:48:54 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIa8QF3083048
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 20:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=K84Km0y0mD2F2Fi/couOcnPy6rSeHjToADl1xZZVRyM=; b=bH
 7BWvrD2cxuNolAxRl4Ho+HcBbsxavc/eFUS6Wn2z7ahj5lzWaVsqihNXlGdXz7PA
 NV+IWpRcyFfUOZ2nY2HsliDQPYE7YHI+4UcalkNioXrI0BanYHAJgaCFbBopxcF1
 3WGgG0DD2OMQCwQM7MSrykLDfSRZpVqtcbge+zcSyMTmyKK3hdJnWPhCbsZm+fOx
 RQoFzSBu8UbkIg/5q1seZaTfqAc9WfvK4SJwYAIihnP4GDNxT+TzKqNS961C4A4K
 K5Hfc2KpC+/H0A4aJF4GSMplIDy96sV4vnAC/MSUrbWOxCjLnl/1j5l1FjQT/X3p
 Il1sur5BvBT8811BDENg==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenmgcda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 20:48:53 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-67a1e063795so10380828eaf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 13:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776804533; cv=none;
 d=google.com; s=arc-20240605;
 b=UwCfzkRsx2vw60f/lYI9nJH7SbeeYtsq7bwHdlPfje/UDeJ+ZD5VfqPvTk5R4fdbJD
 r7ZGC2pd+Mu7CvaSAKh4ztxIL0UTQCBfvb4oeuPEpWYkY17uN1WdO4TiM35pG4TdHoSR
 nlTIumRcO8BfB8OT6rvNMypd6ScvxxdsdmQfkJ04IW2Jk8o++mnqZHii2aK9O0Fkaldj
 V394ENQyyHGuL0y3pdU7OgjqXo7TdhUXhJdE54+9BM0zbSo8CruhS8QqIhYOIIKFBawv
 TnZoAOvsFWbVLn1cj/s03D4oSwwDsIrvwS5Q1Ac1hR3gfUYhehYTT1SAMC7RIoUMv5fl
 c4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=K84Km0y0mD2F2Fi/couOcnPy6rSeHjToADl1xZZVRyM=;
 fh=bu8whMtzU8LG2Z8xjIBuxSHfSX6N4PaRz0HerU4UGGE=;
 b=jSudzB/XM+dQAjqGYo9wl1Zcd4M73HLSvtCdGhN3DxHT9Q5/rHibMfykuQ78RlTj+R
 yNJ830o+aiicvhg1v/+I/ETq+GKubsW3jaHgFP8KjuW9+fS6+n1wxgmao/XnB0KMq+cf
 BIGLZBgA9zHLe0PNbucFQ8hW5BG2aQGqjMIPWsgdLNG2KKRzWoYpanYB8ho3WROXOZ6b
 br+j6KagoxYBad5uA5Ior7nNipobsT3yk/soBY5q3IH4aVbN5tyg1K5DEZlnvOJY0RJ8
 gnmGN3GKT6xvHdnsR86t+5+aFktp3A38FPzVLSoKace8Z0NzBuylE2hCZPwWlclytKan
 6j8Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776804533; x=1777409333;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=K84Km0y0mD2F2Fi/couOcnPy6rSeHjToADl1xZZVRyM=;
 b=AvWyHHBx+CVRd2yL+M00EK7LHUVr4V6xN63t4gYZy78De4DLesXeC6Ih91uBsZVlht
 apJZxHESuK3FE7XP4sirZGoy87V2zf9DQAe0BTG9gdyufp1rIVT5l7yaEZjEqc74Mxiu
 okjA92aKjRMCRZvowpjWb75dzXYnKBy41Bm8YNtJplFkhliCcFMbR90/TTcQiryuPXZH
 Vo3suoTz0Yx99m/af4ndkgfD7BH2AySusFDNxyMvGLhgzVZLQ+rBBPrgqT5KiiHukwsy
 q/p2mUDMzhleLdlZ4RUneFJQ1+t+tYBMGypQBEKQ0BNlC8SxgWq5w23dVOdpi0OgIcZq
 yRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776804533; x=1777409333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K84Km0y0mD2F2Fi/couOcnPy6rSeHjToADl1xZZVRyM=;
 b=gHw+5iMLvZUsyO/qIo5+DMiXbiXlBO/BLZf6AHh3WiXXxWNGccjAwSqN+c6/olikVX
 r3f8vo5vDbmMLbqOFJh0cMXx08TCEmQ4mY1xSKVtdhqeyRkJRfNfjvzmNks34gRzSY50
 VAcvFkyhIaGRvul3Wkm7/W4hss/HBT+75lv2Lc6A/NSLM672zCeSdN1GUqvbg+4DDOs7
 IbCW4xTcOh+gf+IEP898+CiN0uvfJEqaMXYTH0jFZJoHJkYHdBpKFEm+2rdRxePt0gry
 AhlbYSLy/IUQOcXUEJtGB+fFx/3QtVhS7daMSKkzdHiPzxUWv/inmFGDgoZgXydtWjJg
 zufw==
X-Gm-Message-State: AOJu0YzcnWyuQpAV2gSeuGIGJK5APGyGVnST/Rh0EevY3X2NYBoITfsw
 crZpLdaxC6jPUUFelvroV7MufLh8EkUePnKTkWOyqhJvZ/DNSuvXxeSQj8bM2K9oOxn9rj0W4Iu
 N5zmsiz1s4vRDfmGXzu6CVcJEqTHyW25POAOhNBOQT48lstNAdRjqkICi4XZhK5knzr+RGgwLjl
 aUDMkYufXSnWTT3sDl77+paWt7k3VnoDOZeelHwVLn1H26Hg==
X-Gm-Gg: AeBDietGJTKGh+Fy/eTgMSagRXCUIGbT8Dr9GXqzj+44H2yUYBvKp0oGFLaitweJd5w
 DBp5vGKgID3cjJRdNOLpvtgb4/0hr2Ndon/2ugsKKiQl1mJ+5J5D978RfMsW1RVV7IHRSgPYXvj
 2aEY6rNWDC2N3a63198fAoIUVrwn2vKAS49dUACHCM/DgQpaAMsaCkkVGrMJ83J6Ce3j83crh1C
 Auk5182gF4juGZHQx67Sq6O9Rb/TDpGDEUfFgKI4bBKEx3J
X-Received: by 2002:a05:6820:1c90:b0:694:99de:9989 with SMTP id
 006d021491bc7-69499de9bc9mr2087142eaf.32.1776804532537; 
 Tue, 21 Apr 2026 13:48:52 -0700 (PDT)
X-Received: by 2002:a05:6820:1c90:b0:694:99de:9989 with SMTP id
 006d021491bc7-69499de9bc9mr2087112eaf.32.1776804532128; Tue, 21 Apr 2026
 13:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-2-robin.clark@oss.qualcomm.com>
 <sidcsgvqxddatwwflohsd6gjzm5ehbs4alwaejh3pnjnlhj7vm@nqxhdtxxxizs>
 <CACSVV01TK+iLiaCofFfPU2eeMGT5HX5iW0rf=m+gjojXsjrk8Q@mail.gmail.com>
 <puvvx2h2jnoxej42blcdx357uzx37ogwnqldcynklmm4acameg@4zvnrueodcon>
In-Reply-To: <puvvx2h2jnoxej42blcdx357uzx37ogwnqldcynklmm4acameg@4zvnrueodcon>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 13:48:40 -0700
X-Gm-Features: AQROBzDFDQHwJaqNGHFr5d-xcCmq3Cpb_DY1TGCm5x6Ra0ytgXqTL1173n8uPzU
Message-ID: <CACSVV01D388voqDxmfOm_qhV3=H+F3YW2oUjzZT7MfKYwjapDQ@mail.gmail.com>
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
X-Proofpoint-GUID: EgfEbRPzRNYT0_oTOjgvSZ05r1RDOKp5
X-Proofpoint-ORIG-GUID: EgfEbRPzRNYT0_oTOjgvSZ05r1RDOKp5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIwNiBTYWx0ZWRfX/HqnQ8Mcc55x
 UzP5Bjk/ydLm6+uhm2OmSwXz25zZAMezo0eOKRMvunG5qSSkT9+IRvanEjDemZqXvm3UXoB7XDg
 UcC27eHGxipAXhqyxgezR4oqypiiH20mboU0PIxYbwtc8aAjJYEuyEHcaIDd9ovcRw8gzT3NH05
 E42t04J3fvRGkJR2I+okY3BvGxyn7bgaeaJP8WcNSaJKk8n4WLffNnHPHwdIv1BJIs0gBYNo9v+
 n3o+DRCpOFTPreCYjgxPFkFqIHVkBseOF12W4pATtgr58nza4hoj3BEmgzHEjHz6p4sl+fb+bVL
 33/4mWwMgxCY/AQpDt0ouVlpOHo3pTZZY6xosKqCIfEyWiO4WVyPcbbGFpjbx2/xXV2y1L7fmzJ
 qV+bhe4pC/HLsIWy+m12BtsH9/q2saYqRJoE7AJMUzyAdOODMgoC0bML8/EXOZ8hSkn8Rgd1p/W
 aZYaIKx65M9OiaxGFeg==
X-Authority-Analysis: v=2.4 cv=Xd65Co55 c=1 sm=1 tr=0 ts=69e7e2b5 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=VhXg9fDGKa6XFcNS5h4A:9 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604210206
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

On Tue, Apr 21, 2026 at 8:39=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Apr 21, 2026 at 06:07:20AM -0700, Rob Clark wrote:
> > On Mon, Apr 20, 2026 at 4:49=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > On Mon, Apr 20, 2026 at 03:25:23PM -0700, Rob Clark wrote:
> > > > Outside of a3xx, this was never really used.  And it low-key gets i=
n the
> > > > way of the new perfcntr support (or at least it is confusing to hav=
e two
> > > > things called "perf").  So lets remove it.
> > > >
> > > > This drops the "perf" debugfs file.  But these days, nvtop is a bet=
ter
> > > > option.  (Plus perfetto for newer gens.)
> > >
> > > Would it be possible to resurrect "perf" later? It was really useful.
> >
> > Nothing is impossible.. but I was having trouble naming things with
> > both old and new perf stuff in parallel.
>
> That why I wrote about resurrecting it later, once the new stuff is in.
>
> BTW: do you plan to get perf counters for a3xx-a5xx back? I remember
> that there was some issue with a2xx ABI.

So current state on userspace side is that only a3xx/a4xx are missing
perfcntr support..  although it looks like we know the countable
enums, so probably not hard[*]

In all cases, the existing userspace-only support will continue to
work.  The main reasons I omitted a2xx/a5xx on the kernel side are:

a) Not really sure how to do the Makefile bits.. since they wouldn't
be using a6xx.xml.  In meson I can use a table (2d-array):
    https://gitlab.freedesktop.org/robclark/mesa/-/blob/fd/generate-perfcnt=
rs/src/freedreno/registers/adreno/meson.build?ref_type=3Dheads#L20
b) No good setup to test
c) They don't have IFPC

They could ofc be added later.  The main urgency is a8xx, since I
don't want to add mesa perfcntr support without PERFCNTR_CONFIG (so
that we don't have an older-userspace, new-kernel permutation on
a8xx+).

I don't remember about a2xx ABI issue.. but a2xx perfcntr stuff was
added after I was already busy with later gens.

BR,
-R

[*] there are some counter groups that had some slightly different
config programming, like separate clear/enable regs.. which I haven't
dealt with yet.  For a6xx+ this only matters for some counter groups
(VBIF/GBIF, maybe GMU?) that userspace doesn't care as much about.
Idk if that was true for the earlier gens.  Eventually I'll add a6xx+
support for these counters, but there are a few other things to deal
with first.

> > Is it really adding value
> > over nvtop?
>
> --
> With best wishes
> Dmitry
