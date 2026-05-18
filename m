Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB48FCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 13:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A2A10E5AE;
	Mon, 18 May 2026 13:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BnYS7rU3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gsqpkk2J";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C6B10E5AE
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:46:16 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IAolrC2082390
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=dxfhEg8QEY/Fwu3v3gUctioan1qabjbHVVxxH9aJwkA=; b=Bn
 YS7rU3q4PcCR8njXHqZ1p0V86V+Xx+f7z7Fsl5ZbMU10XkS0JK8+36HP7sEktqrw
 IimnN5lQ3H4fztquVb6SlxYSNqylAJ6zoGxHH7zz4KuHIYGUOzFfDPDQ6+i+7Dhj
 8DEx7er7E54rWS63+SOj5qhSUYE7AXPJwkfNM9mLmRP29Dyekd0r66Or8fE1vfGT
 g3PnLShMeeCAdq1RHitfFXSfMA/CdwWfkPYP/6Z1tswlXhh0JIyefqbGzzLNaHGA
 x0iI3MNTf9u9wrFS+kGBQh7Bgr6olP7c9TrfH4BE/m11WbdoL3J1ctypDPAF5fpM
 1VVLxlvsI28AV04+L4dg==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81ch8p55-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:46:15 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-40f25e55f20so3726592fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 06:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779111975; cv=none;
 d=google.com; s=arc-20240605;
 b=faAJIoEWwZp6bqUF6ZFmZqS/aMifZDLOy17BKx9EQn8PKTK4b95tOAQcJQBl4UX8zA
 ssHAaU/ZOmUV5tP734bKpPFNpiDg0+N1nGw42L0UPyAzoHrE5PR/NfgMIUYuUM8a5juB
 s2dyyiN0Z0cBnd+zBUDaLxkJoR+HxnoHWAgZY9S6avcE2vddVd7HiSyl5eCyucuuMONE
 bzONW1ZCLJZA6SIuOlZ8OTqO/R3O/9/0QfAxO3whuqvI/jC8pU9zcws98v8ObUFVJlZ2
 Xp2E81jEA3bajW3Zeh8c9CvFUXgQOWeESm0IqNZlqx0DaTLPP/F3AOqh0v/bo8T/VXKK
 7JJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=dxfhEg8QEY/Fwu3v3gUctioan1qabjbHVVxxH9aJwkA=;
 fh=IeKSm0kmMtkKl0UhDXQOwcSJ+xbDQ33fmtaNU+UDMro=;
 b=E8F33+1gHwFYLJuLVQqgt0PICMxU2C25V0TuLZ3AXA0UTurNxXkWCnFOL/LdrJvkZR
 tIV2ivwXoHxQ4vwyukN39ayr88SsheWqh9K55gtBaj6IeRLUUfAkE6OfyLvFST9+3v5k
 B4iqDVzinGDJxOZ1MgfpAUAqYsRHEBQ0OP4mzlsTfK5JQw9k9UoMUUdOW7tt5FIe+wxk
 uB8/gBHTjmVuxWQqWwAXlRbDCtQGp6M72DkUcCUX5J9s4CZvX81+oqPi13iCUHbhoOAT
 +FfBsWz22Nf61xt3mKKe0ly06WHx/Haff/sebTprRXuKpsoomBAoQ9z12vWeKZx+ZXH1
 H25w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779111975; x=1779716775;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dxfhEg8QEY/Fwu3v3gUctioan1qabjbHVVxxH9aJwkA=;
 b=Gsqpkk2JHQp93NCNpGQoRKOUm6ToN2Kx1Y+LhvLa+VuDZxcyCv/SI1PN1H8S/byQpk
 WQwkR1F/tfTqIe5tXo8OuiiwDIm6yEsywFfXg91Z+nsb59+REidPYYKEA19XeKjPHh/g
 rVohK9edb6/KIyis5FThvMnI3HYP9icaUpoyuu3jdZghELxFvcfudepf+Gloz7pmsje9
 cAlPbzTnC+hLhW4eIkg2jTgnZSHRyCWtgLF2/CtJFFu99BUg4K7obcHTkK8UDPqp53CY
 xVWi73siq4kuZeJRZH65mOMLIlImE9GENd340ZuatpFE24XjaJ1Jlsrz3cQrYDajn9Ou
 YGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779111975; x=1779716775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dxfhEg8QEY/Fwu3v3gUctioan1qabjbHVVxxH9aJwkA=;
 b=BQYNUJWJLItjjkXEO8eCDBeb++K6kMbz8a8dtUreFbJt7IrstYJqBfoWhOSs8fLt3w
 KOMIDKGbrmtZ27sXuHWv4rvMBJbwMf7U+mr/MSFTIAtHbNEPWzt0HlElaMUGHT4ivZOj
 cfWAdsNKrwqhtSXJMi//+lrsql9qC0ehzIAEHGd7nkr+0edXzffs/YJI2SF6Vh5DeG8D
 z+PXpyW76qoxrV8S95cSgBGeHxENnpSIeDH6y67RHsOdUsQLflLUkcMS4rCTb+L4k31U
 GF1Fs0RDgA6tSRprrL5FB3aPHA/+3O9qAU7NQp4/PnLpZRDL2LsSak9diQUhQD4IKS45
 kuIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lLr3cqssM+jG72P32hZ2C0hFGiReHvgjeQJQutaPi8+ijaQwvNelS7RXyjVv3dYoVLbYi8JFpN7s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEUyNfAOB3AZQ//38BkXqaFLzjWQ9MdTtBHxwPci0tZ7hXaWed
 1BeSMXjyZ/XF8Xck943EzU28UxOiJq9DW9kw0lY/HP1BzZ7ul8lglccW33TNAK4smtFMjaYN2Im
 YwIoq73QP8e2zA0Uwr3BKCrH1RZ4zK7zIdnM7FLY5B7+a5CUhd+YLuB4qdRJlnx0vSRhIlmywjc
 uniKs4eN2C2pIqMfTpYjpHY15zGHrxbXJm16RTjtBD+tXIww==
X-Gm-Gg: Acq92OGNfT8UKhE2ZpW0pNWxf9tKMoYyrD1eXfHvwWRYpcDQNEniHbgexltUEspy3ep
 toLQu9Q0NePhKgB/yfLOi8EhiAdCaENx5VNDTaDICezMBReDDPdKQWF2E5eIpJXqjVbWl2I7gkb
 RHCXnCF7qiWUV585bIqNxDZyle5QzW5cQB5FDBSt2PKiaCKpUd2XFr3hRh0a9spgQPjH8TBhBlI
 w1bIjeHlm6gFDFkSoAEGHlZnnxar42ZauRRCw==
X-Received: by 2002:a05:6808:e407:b0:479:eb19:6e6b with SMTP id
 5614622812f47-482e5609a80mr7140913b6e.15.1779111974842; 
 Mon, 18 May 2026 06:46:14 -0700 (PDT)
X-Received: by 2002:a05:6808:e407:b0:479:eb19:6e6b with SMTP id
 5614622812f47-482e5609a80mr7140893b6e.15.1779111974260; Mon, 18 May 2026
 06:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
 <20260514134052.361771-14-robin.clark@oss.qualcomm.com>
 <836c9b33-4215-4e20-96d8-a8dc29ac6dde@oss.qualcomm.com>
In-Reply-To: <836c9b33-4215-4e20-96d8-a8dc29ac6dde@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 18 May 2026 06:46:03 -0700
X-Gm-Features: AVHnY4Kx6Z34rmVOGqn4E3nAuvg8tVMVODwKTTweDpCUiwHCp600_xIUyUY2Gdc
Message-ID: <CACSVV02DsSv7T4nDhmLSbNYigGNz4r1jmx3T=uXyg__=2CvE-Q@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=a4MAM0SF c=1 sm=1 tr=0 ts=6a0b1827 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=6gC5UxSr3Lh0YhTRHQ4A:9 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNCBTYWx0ZWRfX8NwzsdKhIbv9
 XtCj0+X3hSx7IoXXa6MRyrU2BtLPNXgntqBUT8wzvlkwO5DM4I3btvYtq+AOru6Dlojt22oW96X
 9KOIr5FMSBhOicCwU/2WSonvYLTS72jHrRLCR4gguWuXDFdUOcoM6t5wda7ChaHn7fStBw7NWgm
 H5b3epIzps4x9xmZAODiitjUulys21H26nDMOSDdb/1SL2vJ0uDEcxTKjM1fYW9UGEJpLIXMWfo
 6j9KLzkxwWeqvdHI5nj3cWojxFbRRRtTmg4NyEVcKqqENHrs9UZo73bP1GwqjT380b6mPs9dJ11
 0TTfCjgP2b5pSjGcu7uTrQH8/9Ucl3mYznkGPDVKghZF50PM4rPqMouC+COdAVKY8krg2AcskLb
 8dXv5rcSTQoEmfQ4F/J/As7TIHTorF9S1i67bQUwmr4ntTSc4UmgOrP07uot8hvHaV0EH7zhmHQ
 ROQ5ntHrGT1havFqJMQ==
X-Proofpoint-ORIG-GUID: NYKN6xO4P_QLlNqfgtw3hBhJxTssaKG_
X-Proofpoint-GUID: NYKN6xO4P_QLlNqfgtw3hBhJxTssaKG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180134
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

On Sun, May 17, 2026 at 3:54=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> On 5/14/2026 7:10 PM, Rob Clark wrote:
> > Add new UABI and implementation of PERFCNTR_CONFIG ioctl.
> >
> > A bit more work is required to configure the pwrup_reglist for the GMU
> > to restore SELect regs on exist of IFPC, before we can stop disabling
> > IFPC while global counter collection.  This will follow in a later
> > commit, but will be transparent to userspace.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> > ---
> >  drivers/gpu/drm/msm/msm_drv.c      |   1 +
> >  drivers/gpu/drm/msm/msm_drv.h      |   2 +
> >  drivers/gpu/drm/msm/msm_gpu.h      |   3 +
> >  drivers/gpu/drm/msm/msm_perfcntr.c | 516 +++++++++++++++++++++++++++++
> >  drivers/gpu/drm/msm/msm_perfcntr.h |  51 +++
> >  include/uapi/drm/msm_drm.h         |  48 +++
> >  6 files changed, 621 insertions(+)
> >

[snip]

> > diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/m=
sm_perfcntr.c
> > index 04407260a4e1..d6716ce0657a 100644
> > --- a/drivers/gpu/drm/msm/msm_perfcntr.c
> > +++ b/drivers/gpu/drm/msm/msm_perfcntr.c

[snip]

> > +static ssize_t
> > +msm_perfcntrs_stream_read(struct file *file, char __user *buf,
> > +                       size_t count, loff_t *ppos)
> > +{
> > +     struct msm_perfcntr_stream *stream =3D file->private_data;
> > +     int ret;
> > +
> > +     if (!(file->f_flags & O_NONBLOCK)) {
> > +             ret =3D wait_event_interruptible(stream->poll_wq,
> > +                                            fifo_count(stream) > 0);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     guard(mutex)(&stream->read_lock);
> > +
> > +     struct circ_buf *fifo =3D &stream->fifo;
> > +     const char *fptr =3D &fifo->buf[fifo->tail];
> > +
> > +     /*
> > +      * Note that smp_load_acquire() is not strictly required
> > +      * as CIRC_CNT_TO_END() does not access the head more than
> > +      * once.
> > +      */
> > +     count =3D min_t(size_t, count, fifo_count_to_end(stream));
>
> We need smp_load_acquire() to ensure all prior writes from the producer
> side are visible before the 'head' is read.

circular-buffer.rst documents the case that smp_load_acquired() is not
needed.  Maybe that is assuming TSO?  But I think even without TSO
address and data dependencies should be maintained, so this should
still be true on arm64?

We've been using the same in a couple other places in msm, fwiw.

> > +     if (copy_to_user(buf, fptr, count))
> > +             return -EFAULT;
> > +
> > +     smp_store_release(&fifo->tail, (fifo->tail + count) & (stream->fi=
fo_size - 1));
> > +     *ppos +=3D count;
> > +
> > +     return count;
> > +}

[snip]

> > +int
> > +msm_ioctl_perfcntr_config(struct drm_device *dev, void *data, struct d=
rm_file *file)
> > +{
> > +     struct msm_drm_private *priv =3D dev->dev_private;
> > +     const struct drm_msm_perfcntr_config *args =3D data;
> > +     struct msm_context *ctx =3D file->driver_priv;
> > +     struct msm_gpu *gpu =3D priv->gpu;
> > +     int stream_fd =3D 0;
> > +
> > +     if (!gpu || !gpu->num_perfcntr_groups)
> > +             return -ENXIO;
> > +
> > +     struct msm_perfcntr_state *perfcntrs =3D gpu->perfcntrs;
> > +
> > +     /*
> > +      * Validate args that don't require locks/power first:
> > +      */
> > +
> > +     if (args->flags & ~MSM_PERFCNTR_FLAGS)
> > +             return UERR(EINVAL, dev, "invalid flags");
> > +
> > +     if (args->nr_groups && !args->group_stride)
> > +             return UERR(EINVAL, dev, "invalid group_stride");
> > +
> > +     if (args->flags & MSM_PERFCNTR_STREAM) {
> > +             if (!perfmon_capable())
> > +                     return UERR(EPERM, dev, "invalid permissions");
> > +             if (!args->nr_groups)
> > +                     return UERR(EINVAL, dev, "invalid nr_groups");
> > +             if (!args->period)
> > +                     return UERR(EINVAL, dev, "invalid sampling period=
");
> > +     } else {
> > +             if (args->period)
> > +                     return UERR(EINVAL, dev, "sampling period not all=
owed");
> > +             if (args->bufsz_shift)
> > +                     return UERR(EINVAL, dev, "sample buf size not all=
owed");
> > +     }
> > +
> > +     if (args->nr_groups && !args->groups)
> > +             return UERR(EINVAL, dev, "no groups");
> > +
> > +     /*
> > +      * To avoid iterating over the groups multiple times, allocate an=
d setup
> > +      * both a ctx and global stream object.  Only one of the two will=
 be
> > +      * kept in the end.
> > +      */
> > +
> > +     struct msm_perfcntr_context_state *perfctx __free(kfree) =3D kzal=
loc(
> > +             struct_size(perfctx, reserved_counters, gpu->num_perfcntr=
_groups),
> > +             GFP_KERNEL);
> > +     if (!perfctx)
> > +             return -ENOMEM;
> > +
> > +     struct msm_perfcntr_stream *stream __free(kfree) =3D
> > +                     kzalloc(sizeof(*stream), GFP_KERNEL);
>
> How about using GFP_KERNEL_ACCOUNT everywhere in the ioctl path to
> account the allocated memory to the process?

Maybe the circular buffer itself should be?  But the size is bounded,
and I don't see much other use in drm..

> > +     if (!stream)
> > +             return -ENOMEM;
> > +
> > +     uint32_t *group_idx __free(kfree) =3D
> > +             kcalloc(args->nr_groups, sizeof(uint32_t), GFP_KERNEL);
> > +     if (!group_idx)
> > +             return -ENOMEM;
> > +
> > +     stream->gpu =3D gpu;
> > +     stream->sample_period_ns =3D args->period;
> > +     stream->nr_groups =3D args->nr_groups;
> > +     stream->fifo_size =3D 1 << args->bufsz_shift;
> > +
> > +     mutex_init(&stream->read_lock);
> > +
> > +     guard(mutex)(&gpu->perfcntr_lock);
> > +
> > +     if (args->flags & MSM_PERFCNTR_STREAM) {
> > +             if (perfcntrs->stream)
> > +                     return UERR(EBUSY, dev, "perfcntr stream already =
open");
> > +     }
> > +
> > +     size_t bufsz =3D 16;  /* header size includes seqno and 64b times=
tamp: */
> > +     int ret =3D 0;
> > +
> > +     for (unsigned i =3D 0; i < args->nr_groups; i++) {
> > +             struct drm_msm_perfcntr_group g =3D {0};
> > +             void __user *userptr =3D
> > +                     u64_to_user_ptr(args->groups + (i * args->group_s=
tride));
> > +
> > +             if (copy_from_user(&g, userptr, args->group_stride))
>
> use copy_struct_from_user?

I think this would cause a new userspace on old kernel to fail,
instead of simply ignoring new fields added at the end of the struct.
Which for better or worse is different from how drm_ioctl() works.

>
> > +                     return -EFAULT;
> > +
> > +             if (g.pad)
> > +                     return UERR(EINVAL, dev, "groups[%d]: invalid pad=
", i);
> > +
> > +             int idx =3D get_group_idx(gpu, g.group_name, sizeof(g.gro=
up_name));
> > +
> > +             if (idx < 0)
> > +                     return UERR(EINVAL, dev, "groups[%d]: unknown gro=
up", i);
> > +
> > +             if (g.nr_countables > gpu->perfcntr_groups[idx].num_count=
ers)
> > +                     return UERR(EINVAL, dev, "groups[%d]: too many co=
unters", i);
> > +
> > +             if (args->flags & MSM_PERFCNTR_STREAM) {
> > +                     if (g.nr_countables && !g.countables)
> > +                             return UERR(EINVAL, dev, "groups[%d]: no =
countables", i);
> > +             } else {
> > +                     if (g.countables)
> > +                             return UERR(EINVAL, dev, "groups[%d]: cou=
ntables should be NULL", i);
> > +             }
> > +
> > +             int avail_counters =3D get_available_counters(gpu, idx, a=
rgs->flags);
> > +             if (g.nr_countables > avail_counters) {
> > +                     /*
> > +                      * Defer error return until we process all groups=
, in
> > +                      * case there are other E2BIG groups:
> > +                      */
> > +                     ret =3D UERR(E2BIG, dev, "groups[%d]: too few cou=
nters available", i);
> > +
> > +                     if (args->flags & MSM_PERFCNTR_UPDATE) {
> > +                             /* Let userspace know how many counters a=
re actually avail: */
> > +                             g.nr_countables =3D avail_counters;
> > +                             if (copy_to_user(userptr, &g, args->group=
_stride))
> > +                                     return -EFAULT;
> > +                     }
> > +             }
> > +
> > +             group_idx[i] =3D idx;
> > +             perfctx->reserved_counters[idx] =3D g.nr_countables;
> > +
> > +             if (args->flags & MSM_PERFCNTR_STREAM) {
> > +                     perfcntrs->groups[idx]->allocated_counters =3D g.=
nr_countables;
> > +
> > +                     size_t sz =3D sizeof(uint32_t) * g.nr_countables;
> > +                     void __user *userptr =3D u64_to_user_ptr(g.counta=
bles);
> > +
> > +                     if (copy_from_user(perfcntrs->groups[idx]->counta=
bles, userptr, sz))
> > +                             return -EFAULT;
> > +
> > +                     /* Samples are 64b per countable: */
> > +                     bufsz +=3D 2 * sz;
> > +             }
> > +     }
> > +
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (args->flags & MSM_PERFCNTR_STREAM) {
> > +             /*
> > +              * Validate requested buffer size is large enough for at =
least
> > +              * a single sample period.
> > +              *
> > +              * Note the circ_buf implementation needs to be 1 byte la=
rger
> > +              * than max it can hold (see CIRC_SPACE()).
> > +              */
> > +             if (stream->fifo_size <=3D bufsz)
> > +                     return UERR(EINVAL, dev, "required buffer size: %=
zu", bufsz);
> > +
> > +             if (stream->fifo_size > SZ_128M)
> > +                     return UERR(EINVAL, dev, "buffer size too big (>1=
28M): %zu", bufsz);
> > +
> > +             /* There aren't enough counters to hit this limit: */
> > +             WARN_ON(bufsz > SZ_128M);
> > +
> > +             stream->period_size =3D bufsz;
> > +
> > +             void *buf __free(kfree) =3D
> > +                     kmalloc(1 << args->bufsz_shift, GFP_KERNEL);
> > +             if (!buf)
> > +                     return -ENOMEM;
> > +
> > +             stream_fd =3D anon_inode_getfd("[msm_perfcntrs]", &stream=
_fops, stream, 0);
>
> This call makes the fd visible to the userspace immediately. So better
> to move it after all initializations. Ie, after
> msm_perfcntr_resume_locked().

Hmm, but this doesn't play too nicely with cleanup.h stuff, because
the no_free_ptr() stuff must come after the last point of failure.

But I think instead we can use get_unused_fd_flags() + fd_install() to
defer exposing the fd.. I'll try this.

BR,
-R

>
> > +             if (stream_fd < 0)
> > +                     return stream_fd;
> > +
> > +             INIT_WORK(&stream->sel_work, sel_worker);
> > +             kthread_init_work(&stream->sample_work, sample_worker);
> > +             init_waitqueue_head(&stream->poll_wq);
> > +             hrtimer_setup(&stream->sample_timer, sample_timer,
> > +                           CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +
> > +             stream->sel_fence =3D ++perfcntrs->sel_seqno;
> > +             stream->group_idx =3D no_free_ptr(group_idx);
> > +             stream->fifo.buf =3D no_free_ptr(buf);
> > +             perfcntrs->stream =3D no_free_ptr(stream);
> > +
> > +             msm_perfcntr_resume_locked(perfcntrs->stream);
> > +     } else {
> > +             kfree(ctx->perfctx);
> > +             ctx->perfctx =3D no_free_ptr(perfctx);
> > +     }
> > +
> > +     return stream_fd;
> > +}
> > +
> >  /**
> >   * msm_perfcntr_group_idx - map idx of perfcntr group to group_idx
> >   * @stream: The global perfcntr stream
