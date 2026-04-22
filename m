Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBAFF9EDD9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E52B10E0BD;
	Wed, 22 Apr 2026 14:13:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BisgEYBY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RR3DIjb1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1774F10E0BD
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 14:13:52 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MAEWJp976184
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 14:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=bywIrjYAD8hJ/KhIAamlaAGv7hCjyo+6YSetWuvA6bg=; b=Bi
 sgEYBYoORaLG2UREwtJmRVwIb8pFARss5l0mUaEvIkaoFEL0ZIDuSXKGV9pQzRYj
 fF8GSW+ioLF49SXcQUvE1YH8GYvgw6SJlFxGRTrSTVgPBEEr0zs/d54AGrksVrLm
 i3uPKy2fsZyNgmSaBkihDEKe3JjcnN3/XM49ecPwHqmC3nzoa9IQ9QBut2r6fpuB
 TqAPH8hEWg37To8WJeCGoNhJAOMjeopBfBZ30eXSudD0ONM14xRyvaqasmpJZy/Z
 MLC+21LnmvONXi/2tkt/iD3gQ7wqJdPm5gihJ53BRCOWHKcdDhfiMjlExfRSxvc7
 NJIR2htIuViM0FQctjfg==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenebtk2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 14:13:51 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-42322062cf3so6361278fac.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 07:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776867231; cv=none;
 d=google.com; s=arc-20240605;
 b=Jf5FlcFCPFTthdCbQMQ24roW1QEM/HoECX6B3dtk1zQ9TXhYV/vGULgc79iVIRx6VL
 2K1PYjvC4fsLo0vLVJ1F7B6KDZ1DFmpFdxg82JLC3y/epigHNRmwvMDahQx0yEMtpcnF
 0Rl1vG73bmfruXMT/DRM/Xm8Hu8SGIPuXiy+gnTT7yILgt+k6rPGaFMbvu+0ouiV67sr
 jWH96nkA8ez31Magz4B5Kbu/j26vv964GoFvisO2yQiHxMTiJ0tVTG5OpPo2VXe8WQWE
 o2jyHpP7k/bQNBMszTOMmRFowL2dmXU6+m1ze1hYdqj0t7Nse2dfOdCx1WQsEvv0MAeV
 qsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=bywIrjYAD8hJ/KhIAamlaAGv7hCjyo+6YSetWuvA6bg=;
 fh=X3DsWfqXTD8UV0Q4imD0xfjR6AVgAY+ZNFO2vS0s1kU=;
 b=JoV/+c6/Ew7eKv2DoArQfByXTtqTHCk8Bl0bNf8ZIBM/heW5ZHMaWMMKtEWHIviGx5
 hhgZGNpAGiB7VNzlGoxGdvlhDvh/FturdwPT+Sa4mQ69UNEEfqbEvqtGOP1bkorOKnXV
 +QgucABOfSEaCAddR+MkCDACHWNvXDZtSlCQIjXWTXb/SmtzCnmOGCThgRkfw6VcU/eR
 xu6RSq0IrMnnEnbG+R8SoxefAtiFEGUKfrsHftRLuPfybMkwgDPcuDmEQ3fnP6IaQWUb
 SWPIJRCGeW2ODoz3dI0sJCdWlBfL2OC0u8v2aFKzp79OUrd9s4oqYTqhhuilQsvsq5Cj
 0zFg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776867231; x=1777472031;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bywIrjYAD8hJ/KhIAamlaAGv7hCjyo+6YSetWuvA6bg=;
 b=RR3DIjb1nwyC6++bRGvsU/7SdriReLO+f5zHbwIunU+EndJ3I45tng97TFWdyVgcHM
 eu+abljMzohBPYXiCzGeiZnhMM0uGOFUT6x5wjy9tHjJIBAx9OvUH7+B9y48SCCMCXkb
 T1pG8FfNW8+9QpgtORarYrqLUTXFqEo68Fm0Sx3hX3oX6WNwvvA0LOj+XOxLjxetii/v
 OEQJeDvfAdOC1RLlutWyr8HchrU75WKaVn9pGchJk+Qf6qyTc0OW52742tKtnSab3ras
 5vVAlQReyUom1XBKsQq5lfAbGG5GAtcqnGp8aQggxUNsTUL1yGlgHZWht+0D1mKie+6X
 7PJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776867231; x=1777472031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bywIrjYAD8hJ/KhIAamlaAGv7hCjyo+6YSetWuvA6bg=;
 b=TgRzoe13kZAv43W4XH5cwphgS/CYjGZOX7hk2MrYchI0R3mjC7rkKlpZvI9gZn4QMP
 p6ZRChrQaX+JCsOgoYxgMmHr1cWOSR8UFvBCM6zaR+Gp/7nepJH5Q9tzNtBfFHVRM1ZN
 X6ZL5ad8p7BPJ1OLbw/F6YYrImG4C9RJ/V8JEcY61OgQqP3AJJOCsbk3ybrSMjYy0cpy
 fR3YJImm8ScqylV7RS/1fwEMDlSrPx+sH0KFEsNUxlKisuWBCYbFDE7GFEbnok2AGzrQ
 kKe9xgPwBSLv/UnHywloroVDI29JQpB9htAB0usXzmL7X6gzNc0LnPlrj5Bh5yqLHhER
 ZN+A==
X-Gm-Message-State: AOJu0Yz5RR7olnjS0VGGfdCFj/MOIPe+wolZdSdVTz/hlUfGKTq8Y+wn
 o3xuPn58ckVkgDhnyqMJNZrpsn+EQnXUOuuaVBhVLddRe612Nq6THVXQHHhcdXHJUNgAqxNANqM
 cfTVrn3r4yzPhtsJLSY8EaNRCfdKjwasm0rTkIuwpuI0ZI6xQb9lJU00iW439ZFdbO/4T2SC21O
 6b8pB7eBdqg/+weGgF7uTrRvsEnekwn4TIFdRTdZGdsQGWXw==
X-Gm-Gg: AeBDievMxR24RMmcibfvPeCwiDi5EC6oURX0An6sBzwCmhLsBl/SKo/ezsiO3QUeEqB
 nO3QoUZeJVZiMBE9azobd+FVTpCu/Q3cnJuf6MQk3Brs3R42FRIywtCBWt24u+GfMRV6a5uhTvn
 nnc7Hfb25IhsQoyLkUZf9u0fSHNdrChnzLCAHY3yzel6e6nXC6e3pwndg6mzarylKElnvUXMlM+
 K2LzSmWYJe8iTtR1ePJvzvlEWoosMOBvGmBx/8TPijOfihG
X-Received: by 2002:a05:6870:2155:b0:42c:12b4:37cc with SMTP id
 586e51a60fabf-42c12b43a35mr6673335fac.36.1776867230743; 
 Wed, 22 Apr 2026 07:13:50 -0700 (PDT)
X-Received: by 2002:a05:6870:2155:b0:42c:12b4:37cc with SMTP id
 586e51a60fabf-42c12b43a35mr6673314fac.36.1776867230386; Wed, 22 Apr 2026
 07:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-10-robin.clark@oss.qualcomm.com>
 <wfarxotu3lb64ncqmohysmyrdsneg7lgvq7kldcuntshtciob6@nej7bduzff4w>
In-Reply-To: <wfarxotu3lb64ncqmohysmyrdsneg7lgvq7kldcuntshtciob6@nej7bduzff4w>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 07:13:38 -0700
X-Gm-Features: AQROBzAu-fRTbmbSLiq3Y4iwzoXmrrYlIvDXXLyPf-5MPPV1EIVVwBhinppkxVQ
Message-ID: <CACSVV01AUx=1L0BpWQiECbPo1B+PBb9HoQDghUt+CoRuX084ew@mail.gmail.com>
Subject: Re: [PATCH 09/13] drm/msm: Add per-context perfcntr state
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzNyBTYWx0ZWRfXzIcXH3xxDsKI
 /lZA8OvRwS6o2NixI5jduDLwDGQ/migq1/psLdDd2LnfsH01SOM65pwrlJ8DKVe9wov9rkfU4zG
 1FShDonzCVaD8RmBrChgR2JrtgP3AaQNVS9VeDyG7frFqElLdAHTCG5/+JQ+b1cGNw78AKiwyep
 1SsFgUtsNAu2464Ur/eOO7ZmYnJf+5tAagPVJe06+KKlDjh1o4ZKSpFeAcS4FqhlISNquV0WFp1
 iV6neyuSJSW1NRahFe94ZJAM6NLlY+ug2sJRHF1zodoreB+UHOgfI3Ged1W5CROSWDOvGzCHy9s
 422hnYLwUmLhhEEhQZ9xLLf67ebX2WFV5UHtXOM28tA6DrcJTZnztM+bTNed4v6psQApnipqdTx
 KoOgQKM0VYeeHScOThVI/nS2n5QF1QrGXRmG3s8gIwUQhqhsBdo99QEosOeU3i0NeH7DlR5CcwR
 7ynIb3Z+rpgTT5+0tYg==
X-Proofpoint-GUID: yYegXXLeNdTDcJbmsZJ0EdPMfHFQO21q
X-Proofpoint-ORIG-GUID: yYegXXLeNdTDcJbmsZJ0EdPMfHFQO21q
X-Authority-Analysis: v=2.4 cv=RoT16imK c=1 sm=1 tr=0 ts=69e8d79f cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=STtiYm4I-wbpJ57UIjUA:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220137
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

On Tue, Apr 21, 2026 at 8:37=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Mon, Apr 20, 2026 at 03:25:31PM -0700, Rob Clark wrote:
> > The upcoming PERFCNTR_CONFIG ioctl will allow for both global counter
> > collection, and per-context counter reservation for local (ie. within
> > a single GEM_SUBMIT ioctl) counter collection.
> >
> > Any number of contexts can reserve the same counters, but we will need
> > to ensure that counters reserved for local counter collection do not
> > conflict with counters used for global counter collection.
> >
> > So add tracking for per-context local counter reservations.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
>
> >
> > +struct msm_perfcntr_context_state {
> > +     /**
> > +      * @reserved_counters:
> > +      *
> > +      * The number of reserved counters indexed by perfcntr group.
> > +      */
> > +     unsigned reserved_counters[];
> > +};
>
> Fails here (Debian, trixie, gcc 14.2) with:
>
> In file included from drivers/gpu/drm/msm/generated/a6xx_perfcntrs.json.c=
:7:
> ./drivers/gpu/drm/msm/msm_perfcntr.h:130:18: error: flexible array member=
 in a struct with no named members
>   130 |         unsigned reserved_counters[];
>       |                  ^~~~~~~~~~~~~~~~~

ugg... gcc 15.2.1 seems ok with this.  I guess we could just add a dummy fi=
eld..

BR,
-R

> > +
> >  extern const struct msm_perfcntr_group a6xx_perfcntr_groups[];
> >  extern const unsigned a6xx_num_perfcntr_groups;
> >
>
> --
> With best wishes
> Dmitry
