Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA7ACD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 16:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC2B10E5DB;
	Mon, 18 May 2026 16:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OlJ9MC1i";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jt37auVm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D212D10E5DB
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:36:02 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IEnX4A2975772
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=fMHaYLlIWH4bkOXc2c6LHvGX6/Fg7TqcuV/WmKlcnTg=; b=Ol
 J9MC1idfoToplDgkxeYhRWzyN/WKwd72Oyha3dtzxfhqgfn7r2HfsCRm8+W+daVI
 VHN9EkAL/5T6NSOPThHid0mxw9nLn32xiilbhR6YRulaupc3BniLHTQA1vWPEDWC
 b7UU9UbjHUoCADIB8Jwv8rfVNLfwxU8zKTU7tr/EislZ/fHeX510bqyfbThurn+w
 hXahX2rs7KJaFftHBre0ULgNK146twpp4Trkl1b3egcf5n3XVpPiL8781zzbwTlq
 SxZkSmQ0lud4IU3K/sdx4xHUWIRwggOHV18crg45mPZULNVy92KDEB24i67R5d/N
 +r0xTd6B9BS479Krspow==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e84v48dfj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:36:02 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-482c48d6e6aso4850778b6e.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779122161; cv=none;
 d=google.com; s=arc-20240605;
 b=LBGQUOeAx/kuY8yd7s0lxiGNhFwA2mfOJH/Bt2CSEsnt/KG3w4Zvh2AMXdH6WpeA+F
 e/CDjQTDUlmLYhufnCXzMXDhvXqm7Q31IExqGI7AaHc3cJAwUJPScWIp5tMt36amKpJm
 /hgg7SXyrMdSX3xGKBRO18+wFPDnexrNB9Ij1A4ehBXlbkFGRj/nqgBG1NWVcfsbIfOW
 PWti3Oo6PpxtUSDFBef0WvbavMzwLkVFvWZxfi1ZJMBiwqcVgu2WOMQEn2nRkJ669Kws
 KngubQTanepO44zNSg7PVJHY5SlZlwG00kDXrAfirJzvCjsuAa1EjAwMPHzNVzquY5q1
 oHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=fMHaYLlIWH4bkOXc2c6LHvGX6/Fg7TqcuV/WmKlcnTg=;
 fh=8wQgUiAin97coTPer45uteZW8gQ1x3r2mST0ER0+CPs=;
 b=YHw9LJI36YvCPBgRAXgS7MID7Z/3v9bCOhSpZlKSBLB13e9SlwVR3egYVG7ZFOtCUd
 gZXcJhwHLqaHz8rLkNmcdjXHrzjhU2V3hNjlUyHnaJc3dsqjHYc5XPej2PChgPe815hS
 3UA0PJO3PAOd+rrQl+ipcXhuiN17t9Z5CpgPFooXF7gFDufgn5iFB61CuZqRHMk3BrKb
 891WOMzDJE38b++bQlCZoMvRhr3FSEAAUlJAlw26t/s1Q0dHNNrvh7zXLny03j1Lqgni
 i4VJUeUf4Sctvah+Qa59iUexLgVuXUrbzCFDhaZqhlWx4GxyM+TZ8q/HaCba5tyyuVMY
 VbbA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779122161; x=1779726961;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fMHaYLlIWH4bkOXc2c6LHvGX6/Fg7TqcuV/WmKlcnTg=;
 b=jt37auVmZzpGPkIEHpyAhSxL858CqAwysMgtP3GgktNTGszkN9x/cMqn/AtYeifLHa
 OKI7Y+mhmiM9WZOkIEN6wuvH/mzWqS9kbTC4TW2FhSmnwyKkHa5b+PWkeC7NV8wNrfCm
 51+yhOqVJrtnjQiGd8kH2hPuYuQG2ycq7nsQwquQhg6GT/s+0sV+rU8rcyuDzvRKCK9B
 FlxBzWA9Y7reOkum7LCllYxjL1S/PulCJeD3otWCAM3UK/Ac8sDLRG3eyfY/Wlt5POoD
 Y/phVNC5DnF5qHoDklUeqrJ9hkzvhEu0n8BDXLaX47BrK4prjuAv1NMS09Yo/kqLJ9Dy
 jktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779122161; x=1779726961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fMHaYLlIWH4bkOXc2c6LHvGX6/Fg7TqcuV/WmKlcnTg=;
 b=qlcD6wZT35qg97seqZUeW7YToMGKV6UBBYwuxNNpjCpis84UutcRJ56Ryxz2yiZx7+
 CiDyU4IQWWW94KGEd6vABEEHsDGi1PSQSu7FDZUClkaTpw+GzwB7gFDLXQqJNm7V6N7f
 AFP9jjH3+pUaOUV+5LVHLSd3SR60zXNYjJ1J6x0jHeBgoyaH0XnmOKHIte55B8j4Ny23
 MDpOjyaNEvnKp0eHzvl3o67FID+mq0MLsl/tlV5LzlWUp1mAK7i6HiJ2U21Ig0tMnh7h
 BKxR4/tLCwgWciAKd/z0+vvjFun9mXfAqYO6XrUq/NlJTmi13HqDYLXlREjRuC0olizO
 nEHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Tjft9yg82UTBhHorl9a1aAaE7HC58NgxDNPs67Zk/+dOnYw5Xza+NYATOBN623e4SeNNBx1iRcSw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyG8tr2HYsmDa20BkXryPubM/xAG/SqgnLrNb43hIZEshbdgBwZ
 gLL6UOo6U+XB51zTpbm+VEAPZ58mVVLgcJ/payXS9oH2LRJd5jEWHVOxsaK6ctl5+jVADHk/f9K
 ips0iGV05rPOZjpiyiu+QApe2zuHiJiCyb5X5uqQkF6zJAYNWfWHoP5cbv40N5pGx4myOvZ6wM5
 9qGLyaL1TZha62NhT0W3Xw/zzh2d3gUp4JWcrvcf1L0f/prg==
X-Gm-Gg: Acq92OH7b3NwzIeKNfqHG7/Tbmc/KJ7js+M8Ol8V5IVEK5+6Diq7A6WvldWZzwg98Ae
 TBkAcr2lIcldv0g7oF+G7AiG75ZAe1QkO+DyPM6lri4ZsiGbx/VIqOt8GXHwPdmlWlQKTV+B07L
 HHVvdAZcakeQFgPW2ZRgeVhT+LcEoqDUc4fNRCC1WGg5NIpT1QkC8oeF7/0UvOdhReEOFF9lyD+
 RaX4rBkH57OdBZcLj7rSdAr10niRPIjTMwwTA==
X-Received: by 2002:a05:6808:1a07:b0:479:eb19:6e69 with SMTP id
 5614622812f47-482e55afc8dmr10176728b6e.6.1779122161295; 
 Mon, 18 May 2026 09:36:01 -0700 (PDT)
X-Received: by 2002:a05:6808:1a07:b0:479:eb19:6e69 with SMTP id
 5614622812f47-482e55afc8dmr10176698b6e.6.1779122160739; Mon, 18 May 2026
 09:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
 <20260514134052.361771-14-robin.clark@oss.qualcomm.com>
 <836c9b33-4215-4e20-96d8-a8dc29ac6dde@oss.qualcomm.com>
 <CACSVV02DsSv7T4nDhmLSbNYigGNz4r1jmx3T=uXyg__=2CvE-Q@mail.gmail.com>
In-Reply-To: <CACSVV02DsSv7T4nDhmLSbNYigGNz4r1jmx3T=uXyg__=2CvE-Q@mail.gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 18 May 2026 09:35:49 -0700
X-Gm-Features: AVHnY4Ibv5YCsZv7nnVEfMUb1bLEhV8RNCxoVyk5jxUc5scYh9H_dXVrl3yMZPc
Message-ID: <CACSVV03f3GAjekAaL6kT9bD3B9suQ4DkQQqVNr97x=OMgqa=fg@mail.gmail.com>
Subject: Re: [PATCH v6 13/16] drm/msm: Add PERFCNTR_CONFIG ioctl
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=VJPtWdPX c=1 sm=1 tr=0 ts=6a0b3ff2 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=M8SrLyCKTCxg5gAENbMA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: Zx_rF7E_KeQfRShzTfDm4jDMuDir0OeT
X-Proofpoint-GUID: Zx_rF7E_KeQfRShzTfDm4jDMuDir0OeT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2MyBTYWx0ZWRfX16DQPrAtVJjL
 DSv9ecDAcFO6id2/tmnwa84OdluQL5sEFEBK1aZ0EkKS1DeaBOagHzYeBdq7fw/5cZGaGmPlN2I
 pBsbEFn230l2AdW826ncSL+4hTU9WHAnY4Q87llRDEArbehqTwmLx3V2szcXRRdKtuQiMwjbNXP
 aEubobYEMOvhXMXRZ2wxBtduSIvjuidEknxYc6cFrmcEOFDOGcnrcTAFGmgU5lAYgxAaI/iheAU
 gmG2NTmSo/kESCB0Unn5YIKe4d6RNJJw33bus87p1sDOOU+BKb9DxliJWEL0T3YllNhj6OcMbXE
 cwSqpAehsM3YgofRaC68/6zrNrnwfkQEmN5MHsE1F6fkNa8o/prFVGXoZWBC9Gt8ekiiq0AvkPx
 UGJUauuLEV79q11yQbjxU6uBDnK4rUKhcVW2uE6Z2h2mh0R3jNNPKIQm53j1Tbbpi4n/H6F+Bkj
 qHSRPSO1Rsket435//w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180163
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

On Mon, May 18, 2026 at 6:46=E2=80=AFAM Rob Clark <rob.clark@oss.qualcomm.c=
om> wrote:
>
> On Sun, May 17, 2026 at 3:54=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualc=
omm.com> wrote:
> >
> > On 5/14/2026 7:10 PM, Rob Clark wrote:
> > > Add new UABI and implementation of PERFCNTR_CONFIG ioctl.
> > >
> > > A bit more work is required to configure the pwrup_reglist for the GM=
U
> > > to restore SELect regs on exist of IFPC, before we can stop disabling
> > > IFPC while global counter collection.  This will follow in a later
> > > commit, but will be transparent to userspace.
> > >
> > > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > > Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> > > ---
> > >  drivers/gpu/drm/msm/msm_drv.c      |   1 +
> > >  drivers/gpu/drm/msm/msm_drv.h      |   2 +
> > >  drivers/gpu/drm/msm/msm_gpu.h      |   3 +
> > >  drivers/gpu/drm/msm/msm_perfcntr.c | 516 +++++++++++++++++++++++++++=
++
> > >  drivers/gpu/drm/msm/msm_perfcntr.h |  51 +++
> > >  include/uapi/drm/msm_drm.h         |  48 +++
> > >  6 files changed, 621 insertions(+)
> > >
>
> [snip]
>
> > > diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm=
/msm_perfcntr.c
> > > index 04407260a4e1..d6716ce0657a 100644
> > > --- a/drivers/gpu/drm/msm/msm_perfcntr.c
> > > +++ b/drivers/gpu/drm/msm/msm_perfcntr.c
>
> [snip]
>
> > > +static ssize_t
> > > +msm_perfcntrs_stream_read(struct file *file, char __user *buf,
> > > +                       size_t count, loff_t *ppos)
> > > +{
> > > +     struct msm_perfcntr_stream *stream =3D file->private_data;
> > > +     int ret;
> > > +
> > > +     if (!(file->f_flags & O_NONBLOCK)) {
> > > +             ret =3D wait_event_interruptible(stream->poll_wq,
> > > +                                            fifo_count(stream) > 0);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     guard(mutex)(&stream->read_lock);
> > > +
> > > +     struct circ_buf *fifo =3D &stream->fifo;
> > > +     const char *fptr =3D &fifo->buf[fifo->tail];
> > > +
> > > +     /*
> > > +      * Note that smp_load_acquire() is not strictly required
> > > +      * as CIRC_CNT_TO_END() does not access the head more than
> > > +      * once.
> > > +      */
> > > +     count =3D min_t(size_t, count, fifo_count_to_end(stream));
> >
> > We need smp_load_acquire() to ensure all prior writes from the producer
> > side are visible before the 'head' is read.
>
> circular-buffer.rst documents the case that smp_load_acquired() is not
> needed.  Maybe that is assuming TSO?  But I think even without TSO
> address and data dependencies should be maintained, so this should
> still be true on arm64?

Ok, I think ordering is only maintained within a single core.  So
probably the circular-buffer.rst docs are making too stong of an
assumption about x86/TSO..

> We've been using the same in a couple other places in msm, fwiw.
>
> > > +     if (copy_to_user(buf, fptr, count))
> > > +             return -EFAULT;
> > > +
> > > +     smp_store_release(&fifo->tail, (fifo->tail + count) & (stream->=
fifo_size - 1));
> > > +     *ppos +=3D count;
> > > +
> > > +     return count;
> > > +}
>
> [snip]
>
> > > +int
> > > +msm_ioctl_perfcntr_config(struct drm_device *dev, void *data, struct=
 drm_file *file)
> > > +{
> > > +     struct msm_drm_private *priv =3D dev->dev_private;
> > > +     const struct drm_msm_perfcntr_config *args =3D data;
> > > +     struct msm_context *ctx =3D file->driver_priv;
> > > +     struct msm_gpu *gpu =3D priv->gpu;
> > > +     int stream_fd =3D 0;
> > > +
> > > +     if (!gpu || !gpu->num_perfcntr_groups)
> > > +             return -ENXIO;
> > > +
> > > +     struct msm_perfcntr_state *perfcntrs =3D gpu->perfcntrs;
> > > +
> > > +     /*
> > > +      * Validate args that don't require locks/power first:
> > > +      */
> > > +
> > > +     if (args->flags & ~MSM_PERFCNTR_FLAGS)
> > > +             return UERR(EINVAL, dev, "invalid flags");
> > > +
> > > +     if (args->nr_groups && !args->group_stride)
> > > +             return UERR(EINVAL, dev, "invalid group_stride");
> > > +
> > > +     if (args->flags & MSM_PERFCNTR_STREAM) {
> > > +             if (!perfmon_capable())
> > > +                     return UERR(EPERM, dev, "invalid permissions");
> > > +             if (!args->nr_groups)
> > > +                     return UERR(EINVAL, dev, "invalid nr_groups");
> > > +             if (!args->period)
> > > +                     return UERR(EINVAL, dev, "invalid sampling peri=
od");
> > > +     } else {
> > > +             if (args->period)
> > > +                     return UERR(EINVAL, dev, "sampling period not a=
llowed");
> > > +             if (args->bufsz_shift)
> > > +                     return UERR(EINVAL, dev, "sample buf size not a=
llowed");
> > > +     }
> > > +
> > > +     if (args->nr_groups && !args->groups)
> > > +             return UERR(EINVAL, dev, "no groups");
> > > +
> > > +     /*
> > > +      * To avoid iterating over the groups multiple times, allocate =
and setup
> > > +      * both a ctx and global stream object.  Only one of the two wi=
ll be
> > > +      * kept in the end.
> > > +      */
> > > +
> > > +     struct msm_perfcntr_context_state *perfctx __free(kfree) =3D kz=
alloc(
> > > +             struct_size(perfctx, reserved_counters, gpu->num_perfcn=
tr_groups),
> > > +             GFP_KERNEL);
> > > +     if (!perfctx)
> > > +             return -ENOMEM;
> > > +
> > > +     struct msm_perfcntr_stream *stream __free(kfree) =3D
> > > +                     kzalloc(sizeof(*stream), GFP_KERNEL);
> >
> > How about using GFP_KERNEL_ACCOUNT everywhere in the ioctl path to
> > account the allocated memory to the process?
>
> Maybe the circular buffer itself should be?  But the size is bounded,
> and I don't see much other use in drm..
>
> > > +     if (!stream)
> > > +             return -ENOMEM;
> > > +
> > > +     uint32_t *group_idx __free(kfree) =3D
> > > +             kcalloc(args->nr_groups, sizeof(uint32_t), GFP_KERNEL);
> > > +     if (!group_idx)
> > > +             return -ENOMEM;
> > > +
> > > +     stream->gpu =3D gpu;
> > > +     stream->sample_period_ns =3D args->period;
> > > +     stream->nr_groups =3D args->nr_groups;
> > > +     stream->fifo_size =3D 1 << args->bufsz_shift;
> > > +
> > > +     mutex_init(&stream->read_lock);
> > > +
> > > +     guard(mutex)(&gpu->perfcntr_lock);
> > > +
> > > +     if (args->flags & MSM_PERFCNTR_STREAM) {
> > > +             if (perfcntrs->stream)
> > > +                     return UERR(EBUSY, dev, "perfcntr stream alread=
y open");
> > > +     }
> > > +
> > > +     size_t bufsz =3D 16;  /* header size includes seqno and 64b tim=
estamp: */
> > > +     int ret =3D 0;
> > > +
> > > +     for (unsigned i =3D 0; i < args->nr_groups; i++) {
> > > +             struct drm_msm_perfcntr_group g =3D {0};
> > > +             void __user *userptr =3D
> > > +                     u64_to_user_ptr(args->groups + (i * args->group=
_stride));
> > > +
> > > +             if (copy_from_user(&g, userptr, args->group_stride))
> >
> > use copy_struct_from_user?
>
> I think this would cause a new userspace on old kernel to fail,
> instead of simply ignoring new fields added at the end of the struct.
> Which for better or worse is different from how drm_ioctl() works.
>
> >
> > > +                     return -EFAULT;
> > > +
> > > +             if (g.pad)
> > > +                     return UERR(EINVAL, dev, "groups[%d]: invalid p=
ad", i);
> > > +
> > > +             int idx =3D get_group_idx(gpu, g.group_name, sizeof(g.g=
roup_name));
> > > +
> > > +             if (idx < 0)
> > > +                     return UERR(EINVAL, dev, "groups[%d]: unknown g=
roup", i);
> > > +
> > > +             if (g.nr_countables > gpu->perfcntr_groups[idx].num_cou=
nters)
> > > +                     return UERR(EINVAL, dev, "groups[%d]: too many =
counters", i);
> > > +
> > > +             if (args->flags & MSM_PERFCNTR_STREAM) {
> > > +                     if (g.nr_countables && !g.countables)
> > > +                             return UERR(EINVAL, dev, "groups[%d]: n=
o countables", i);
> > > +             } else {
> > > +                     if (g.countables)
> > > +                             return UERR(EINVAL, dev, "groups[%d]: c=
ountables should be NULL", i);
> > > +             }
> > > +
> > > +             int avail_counters =3D get_available_counters(gpu, idx,=
 args->flags);
> > > +             if (g.nr_countables > avail_counters) {
> > > +                     /*
> > > +                      * Defer error return until we process all grou=
ps, in
> > > +                      * case there are other E2BIG groups:
> > > +                      */
> > > +                     ret =3D UERR(E2BIG, dev, "groups[%d]: too few c=
ounters available", i);
> > > +
> > > +                     if (args->flags & MSM_PERFCNTR_UPDATE) {
> > > +                             /* Let userspace know how many counters=
 are actually avail: */
> > > +                             g.nr_countables =3D avail_counters;
> > > +                             if (copy_to_user(userptr, &g, args->gro=
up_stride))
> > > +                                     return -EFAULT;
> > > +                     }
> > > +             }
> > > +
> > > +             group_idx[i] =3D idx;
> > > +             perfctx->reserved_counters[idx] =3D g.nr_countables;
> > > +
> > > +             if (args->flags & MSM_PERFCNTR_STREAM) {
> > > +                     perfcntrs->groups[idx]->allocated_counters =3D =
g.nr_countables;
> > > +
> > > +                     size_t sz =3D sizeof(uint32_t) * g.nr_countable=
s;
> > > +                     void __user *userptr =3D u64_to_user_ptr(g.coun=
tables);
> > > +
> > > +                     if (copy_from_user(perfcntrs->groups[idx]->coun=
tables, userptr, sz))
> > > +                             return -EFAULT;
> > > +
> > > +                     /* Samples are 64b per countable: */
> > > +                     bufsz +=3D 2 * sz;
> > > +             }
> > > +     }
> > > +
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if (args->flags & MSM_PERFCNTR_STREAM) {
> > > +             /*
> > > +              * Validate requested buffer size is large enough for a=
t least
> > > +              * a single sample period.
> > > +              *
> > > +              * Note the circ_buf implementation needs to be 1 byte =
larger
> > > +              * than max it can hold (see CIRC_SPACE()).
> > > +              */
> > > +             if (stream->fifo_size <=3D bufsz)
> > > +                     return UERR(EINVAL, dev, "required buffer size:=
 %zu", bufsz);
> > > +
> > > +             if (stream->fifo_size > SZ_128M)
> > > +                     return UERR(EINVAL, dev, "buffer size too big (=
>128M): %zu", bufsz);
> > > +
> > > +             /* There aren't enough counters to hit this limit: */
> > > +             WARN_ON(bufsz > SZ_128M);
> > > +
> > > +             stream->period_size =3D bufsz;
> > > +
> > > +             void *buf __free(kfree) =3D
> > > +                     kmalloc(1 << args->bufsz_shift, GFP_KERNEL);
> > > +             if (!buf)
> > > +                     return -ENOMEM;
> > > +
> > > +             stream_fd =3D anon_inode_getfd("[msm_perfcntrs]", &stre=
am_fops, stream, 0);
> >
> > This call makes the fd visible to the userspace immediately. So better
> > to move it after all initializations. Ie, after
> > msm_perfcntr_resume_locked().
>
> Hmm, but this doesn't play too nicely with cleanup.h stuff, because
> the no_free_ptr() stuff must come after the last point of failure.
>
> But I think instead we can use get_unused_fd_flags() + fd_install() to
> defer exposing the fd.. I'll try this.

Turns out FD_PREPARE()/fd_publish() work well for this

BR,
-R

> BR,
> -R
>
> >
> > > +             if (stream_fd < 0)
> > > +                     return stream_fd;
> > > +
> > > +             INIT_WORK(&stream->sel_work, sel_worker);
> > > +             kthread_init_work(&stream->sample_work, sample_worker);
> > > +             init_waitqueue_head(&stream->poll_wq);
> > > +             hrtimer_setup(&stream->sample_timer, sample_timer,
> > > +                           CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > > +
> > > +             stream->sel_fence =3D ++perfcntrs->sel_seqno;
> > > +             stream->group_idx =3D no_free_ptr(group_idx);
> > > +             stream->fifo.buf =3D no_free_ptr(buf);
> > > +             perfcntrs->stream =3D no_free_ptr(stream);
> > > +
> > > +             msm_perfcntr_resume_locked(perfcntrs->stream);
> > > +     } else {
> > > +             kfree(ctx->perfctx);
> > > +             ctx->perfctx =3D no_free_ptr(perfctx);
> > > +     }
> > > +
> > > +     return stream_fd;
> > > +}
> > > +
> > >  /**
> > >   * msm_perfcntr_group_idx - map idx of perfcntr group to group_idx
> > >   * @stream: The global perfcntr stream
