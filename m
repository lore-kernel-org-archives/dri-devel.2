Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FBDC5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 04:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9A5110E9D7;
	Tue, 18 Aug 2026 04:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A/nJ+geS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R8T7wdXd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F9510E9DF
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:19:18 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I3Fwx43833590
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=v+sOCyeEK/eOHBMwBNAZ6cZ6
 OwkONsgIike3kC34EUA=; b=A/nJ+geS2ZxWqaw++hSmRI+9qO0Kd4EL7OfemTHh
 zH4kvWzu7P+nQvwW2XhnVHMh53O6Vfm2To+va3NbRNg4xfZC6O1fJq97u3nho3zx
 UHsaG1mT4fRr/J4o27NKIjIbAjDxXBE5w5bSjn+9tOhcGfUeUwG2oSNJAXeWfmmK
 L049Qc7wRemT9baBeIugoQ0Mx4tvTrXeBKNHdKZTJW8CG8gcAUVZ3OLaUn506Ffy
 6s4+FscB8OFqDqRHnz3VJQf48PU/sZSD/ak5fLtxoWSth0lQkQuY+aW74Ib8QS4s
 ZH/DTXL1G2RsxMEaJ8s+ywb6oT9zUTcTmu2pP2i8507eLA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fba866t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:19:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso69403591cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787026757; x=1787631557;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v+sOCyeEK/eOHBMwBNAZ6cZ6OwkONsgIike3kC34EUA=;
 b=R8T7wdXddIUuQ+PeKhciRrsBcRYf3ZQX4oC63+YFd5spvMEAa8WRvs49T7SQ/Ln+uh
 QZq/1WcAcdpgqH8tz84rLAXhSfK2z/egEHRPqqoUyti3uH9N3uGfA40wdRncvmY4Dt/r
 g5NQZpOv32TwbIbj882a1+O4sGU6bedW3twTpf1euAHOtL9q+WeH6OZW6xwCjv8Qhxk1
 fX2Ed0qIklN0BoKse+Hi5ge8NrWAzCNqmi7UVPFUDHnBJvmqsl4l8WfZT0PIMv5etOYY
 a7ZcsdxGlOCe85/80B9PVJvia8XArcYgeBzZ1TB+mFt4uLBie4WdjfBZemR99Pw6wrjE
 cDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787026757; x=1787631557;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v+sOCyeEK/eOHBMwBNAZ6cZ6OwkONsgIike3kC34EUA=;
 b=Y1cgK3uHXOB5vKsH+zrpWZLh1BEGvZ2BIx3VwVN/gbHCnM6W9MIj6InTNpkd27dcRp
 dvvrSwNyBX1v0l+KM4YM00ygg1zuhLp5JcKfK2gI+6i7I9D67w1tvqMQYrR9jVKOG8CE
 Hqbm+1cAbXcnpuxDjUbCdetZFSkfChN9iG6ERvcM2a8txLIgcuAx3/cbdBpQYBkEqarw
 paLXkcF3oDnSobVvBDBNaMcLfzJJTcVOneZYWa0dWJgeaLyJIWzP77k5NCWLTY7SPMyb
 X9JKn8zjGXC8lBgas/Q7yXDWAaF2xZkopMnhJnBn61wUZAokdSqWo8H7tU6j0HCeI1Y1
 0eWw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiC13U+GdvyhsbD3clNhsaeYIV+j+Kq6UCu325xEsOV4xo3VKGQ+9wPtn5R3K6f4PlC0s4Er1tnyM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzq4eXEDUbq7TwhZDXV3KFAbg/T6KqucCeKhv6ZHD+3qKPdrkaT
 G8nhVaXX4cFnnCL+Z/7/psgUER4r1Br9GlIgFQCQlqtj0g0wDTYTTCD4HZU52eVmX7bgN4gBzt4
 JkUg1RzQnPsb3HpXLyJaV3JvqiRjel8zYqhJbMFOtJnIKeT+2oWof6d5D1A1i5UlJvfD5K2xuHo
 3503ESVZTI
X-Gm-Gg: AR+sD11Q7QYTff8EIaD8C8F11P9sQLNps/lv4fmL1kV8fvbQtb1az8o0nY9PGkXczQ3
 rs1j8B48vS8A0IzgINSdUruJlYANkCGf8O1+tB17KRtSDb57ofd04NuuY7S+Qjka7+dZMpmcadm
 q4/1qd5MBRPAZ6lgnb6nOEhr6GsFvEmPnRu4bDpQ+rYGnNK1nDj1o81CIZwSt+agvHkqElXWwLT
 at+eBPg28HmF5Ri4A41DM5yXsODz4W7CtuhzlfVsS2mFWIBFcTiiibWnU2Av1FonPdHud2AYVgf
 r8CWCl83nPnBxAisiYA9Ck4F3Shj4RpgESSaOXDjTiVRL3DqmDLHGRcgFJur49b/To0Ush/6J1H
 mYf6PHS/nHA0vUhsxTOFnRewNQbQcHCeCZXUOPhUdmQRBgkpN7zkfwFVYIvsvzQGz+ep7cB6FVU
 +Ybqzwx0d3FA1+
X-Received: by 2002:a05:622a:1a88:b0:51c:51e:661c with SMTP id
 d75a77b69052e-52d8543f3c0mr316094541cf.25.1787026756297; 
 Mon, 17 Aug 2026 21:19:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1a88:b0:51c:51e:661c with SMTP id
 d75a77b69052e-52d8543f3c0mr316094001cf.25.1787026755544; 
 Mon, 17 Aug 2026 21:19:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46d00b886sm875564e87.64.2026.08.17.21.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 21:19:13 -0700 (PDT)
Date: Tue, 18 Aug 2026 07:19:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 12/15] accel/qda: Add FastRPC invocation support
Message-ID: <hbrtbfpmcodd3nkaytihzki56232bws7ubbcth7ewwckwi5y6t@ft4ej4fr7duz>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-12-69a02e9090d4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-qda-v2-v2-12-69a02e9090d4@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyOSBTYWx0ZWRfX9E89rFF28RMX
 TwW84lWDd1r9wxPRTHbPZ8EGluWm8QL1xrQmj5dz6UDm4mAbnpzuc69hnG4NfEd9X2vFT83fq0z
 W7Fdqx4fwCUe8DSR8BVL1/ktdWWzHvE=
X-Authority-Analysis: v=2.4 cv=VsITxe2n c=1 sm=1 tr=0 ts=6a83dd45 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=nHb0V-aiwfVndVR9hscA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 70ytuifObMkCYhZWv0Tx959jB7PvBl1j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyOSBTYWx0ZWRfXxtcj64UQvuu7
 ciLcDSkZQnRWyXMPcxxEyLWW3gHKkzirgJUs6+7W0nvtsnBdysDBh8nuH7OZ4CiYgiyI8JPP2yL
 hf0FKMfZgGlTKvS6wG9fSd1xvTdFr/eXuP2os2+I9Co/ZevtHUpilVSYnCi9TF87LdwIZfNl071
 dOImQgqrP7+kVLb+EeZKYB31wJwdzT028VWjH9rDj6Z9G+c3ATOqSyQlf50CCG4ypiCPXW5Yo90
 p8sRyzhrg4TbiPGT1B1e4DcFgg/u5ruwRfxY/gy3XHa+6tXtlYjokDRuBOaIYP35/oxTVjsSoDu
 x/A57JWr7c+s8dE246w4/tos0WsaJY9OEoZndc0TEyihPAMkG9DjFEwxTVMH0vbEKf4gz34fZCd
 aROForojRRCUCAs5m29UCqrGC9MNVFId+vJtCSGqzx2ZVcXdpzOcry3G03rMsgxQAokkmddkclL
 gFisj1sezuJWVDDcPww==
X-Proofpoint-GUID: 70ytuifObMkCYhZWv0Tx959jB7PvBl1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180029
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

On Mon, Aug 17, 2026 at 10:17:47AM +0530, Ekansh Gupta wrote:
> Implement the FastRPC remote procedure call path, allowing user-space to
> invoke methods on the DSP via DRM_IOCTL_QDA_REMOTE_INVOKE.
> 
> qda_fastrpc.c / qda_fastrpc.h
>   Implements the FastRPC protocol layer: argument marshalling
>   (qda_fastrpc_invoke_pack), response unmarshalling
>   (qda_fastrpc_invoke_unpack), and invocation context lifecycle
>   management. Each invocation allocates a qda_fastrpc_invoke_ctx which
>   tracks buffer descriptors, GEM objects, and the completion used to
>   synchronise with the DSP response.
> 
>   Buffer arguments are identified by GEM handles. Userspace imports any
>   DMA-BUF fd to a GEM handle with DRM_IOCTL_PRIME_FD_TO_HANDLE before
>   invoking; the driver never accepts DMA-BUF fds directly. Each argument
>   is described by its GEM handle, the user virtual address of the data
>   and its length, from which the driver derives the offset within the
>   buffer and the page-aligned range to describe to the DSP. Packing
>   several arguments into one buffer, and any overlap handling, is left
>   to user space.
> 
> qda_rpmsg.c
>   Implements qda_rpmsg_send_msg() which sends the wire-format
>   fastrpc_msg (embedded as the first member of qda_msg) directly via
>   rpmsg_send(), and qda_rpmsg_wait_for_rsp() which blocks on the context
>   completion. The RPMsg callback dispatches responses to waiting
>   contexts via the ctx_xa XArray.
> 
> qda_ioctl.c
>   qda_ioctl_invoke() drives the full invocation lifecycle: it builds the
>   invocation context from the user-supplied arguments, packs the
>   arguments into the message buffer, sends the message to the DSP, waits
>   for the response, unpacks the output arguments back to user space and
>   releases the context.
> 
> include/uapi/drm/qda_accel.h
>   Adds DRM_IOCTL_QDA_REMOTE_INVOKE with struct drm_qda_invoke_args and
>   the per-argument descriptor struct drm_qda_fastrpc_invoke_args.
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
> Changes in v2:
> - Drop the DMA-BUF fd argument path. Buffer arguments are now identified
>   by GEM handles only; user space is responsible for importing fds to
>   GEM handles before invoking (Dmitry Baryshkov)
> - Leave argument packing and overlap handling to user space rather than
>   supporting several buffer-passing formats in the driver
>   (Dmitry Baryshkov)
> ---
>  drivers/accel/qda/Makefile      |   1 +
>  drivers/accel/qda/qda_drv.c     |   8 +
>  drivers/accel/qda/qda_drv.h     |   8 +
>  drivers/accel/qda/qda_fastrpc.c | 434 ++++++++++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_fastrpc.h | 242 ++++++++++++++++++++++
>  drivers/accel/qda/qda_ioctl.c   |  83 ++++++++
>  drivers/accel/qda/qda_ioctl.h   |   1 +
>  drivers/accel/qda/qda_rpmsg.c   |  91 ++++++++-
>  drivers/accel/qda/qda_rpmsg.h   |  26 +++
>  include/uapi/drm/qda_accel.h    |  42 ++++
>  10 files changed, 934 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> index fb092e56d7f3..2d10420cd1ec 100644
> --- a/drivers/accel/qda/Makefile
> +++ b/drivers/accel/qda/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>  qda-y := \
>  	qda_cb.o \
>  	qda_drv.o \
> +	qda_fastrpc.o \
>  	qda_gem.o \
>  	qda_ioctl.o \
>  	qda_memory_dma.o \
> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index a68a07d0ae56..f925bbcfa6e9 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -25,6 +25,8 @@ static int qda_open(struct drm_device *dev, struct drm_file *file)
>  
>  	qda_file_priv->pid = current->pid;
>  	qda_file_priv->qda_dev = qda_dev_from_drm(dev);
> +	qda_file_priv->remote_session_id =
> +		atomic_inc_return(&qda_file_priv->qda_dev->remote_session_id_counter);

What happens on the wraparound? What if some of those sessions are still
alive?

>  	file->driver_priv = qda_file_priv;
>  
>  	return 0;

[...]

> +
> +/*
> + * The driver only accepts GEM handles from user space; userspace imports
> + * DMA-BUF fds with DRM_IOCTL_PRIME_FD_TO_HANDLE before issuing any ioctl that
> + * carries a buffer reference.

What else can it accept?

> + *
> + * The caller owns the returned reference and must drop it with
> + * drm_gem_object_put().
> + */
> +static int get_gem_obj_from_handle(struct qda_fastrpc_invoke_ctx *ctx, u32 handle,
> +				   struct drm_gem_object **gem_obj)
> +{
> +	*gem_obj = drm_gem_object_lookup(ctx->file_priv, handle);
> +	if (!*gem_obj)
> +		return -ENOENT;
> +
> +	return 0;
> +}
> +
> +static void setup_pages_from_gem_obj(struct qda_gem_obj *qda_gem_obj,
> +				     struct fastrpc_phy_page *pages)
> +{
> +	pages->addr = qda_gem_obj->dma_addr;
> +	pages->size = qda_gem_obj->size;
> +}
> +
> +static u64 calculate_vma_offset(u64 user_ptr)
> +{
> +	struct vm_area_struct *vma;
> +	u64 vma_offset = 0;
> +
> +	mmap_read_lock(current->mm);
> +	vma = find_vma(current->mm, user_ptr);
> +	if (vma)
> +		vma_offset = (user_ptr & PAGE_MASK) - vma->vm_start;
> +	mmap_read_unlock(current->mm);
> +
> +	return vma_offset;
> +}
> +
> +static u64 calculate_page_aligned_size(u64 ptr, u64 len)
> +{
> +	u64 pg_start = (ptr & PAGE_MASK) >> PAGE_SHIFT;
> +	u64 pg_end = ((ptr + len - 1) & PAGE_MASK) >> PAGE_SHIFT;
> +
> +	return (pg_end - pg_start + 1) * PAGE_SIZE;
> +}
> +
> +static struct fastrpc_invoke_buf *fastrpc_invoke_buf_start(union fastrpc_remote_arg *pra, int len)
> +{
> +	return (struct fastrpc_invoke_buf *)(&pra[len]);

Ugh. Is it not start + len * sizeof(union fastrpc_remote_arg)? Can't you
just write it at the caller site?

> +}
> +
> +static struct fastrpc_phy_page *fastrpc_phy_page_start(struct fastrpc_invoke_buf *buf, int len)
> +{
> +	return (struct fastrpc_phy_page *)(&buf[len]);
> +}
> +
> +static size_t fastrpc_get_meta_size(struct qda_fastrpc_invoke_ctx *ctx)
> +{
> +	return (sizeof(struct fastrpc_remote_buf) +

Just one buffer?

> +		sizeof(struct fastrpc_invoke_buf) +
> +		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
> +		sizeof(u64) * FASTRPC_MAX_HANDLELIST +
> +		sizeof(u32) * FASTRPC_MAX_CRCLIST;
> +}
> +
> +/**
> + * qda_fastrpc_cleanup_handlelist() - Release DMA handles the DSP no longer needs
> + * @ctx: Invocation context whose response buffer contains the handle list
> + *
> + * The DSP signals handle release by writing GEM handles into the handle list
> + * region of the response buffer. Walk the list and close each handle, which
> + * drops the GEM reference and tears down the IOMMU mapping. This must be called
> + * after dma_rmb() has made the DSP's writes visible.
> + */
> +void qda_fastrpc_cleanup_handlelist(struct qda_fastrpc_invoke_ctx *ctx)
> +{
> +	u64 *handlelist;
> +	int i;
> +
> +	handlelist = (u64 *)(ctx->pages + ctx->nscalars);
> +	for (i = 0; i < FASTRPC_MAX_HANDLELIST; i++) {
> +		if (!handlelist[i])
> +			break;
> +		drm_gem_handle_delete(ctx->file_priv, (u32)handlelist[i]);
> +	}
> +}
> +
> +/**
> + * qda_fastrpc_context_free() - Release an invocation context
> + * @ref: Reference counter embedded in the context
> + *
> + * Called when the last reference is dropped, which may be either the caller
> + * that issued the invocation or the response callback. The context is removed
> + * from the lookup table here so that a late response can never find a context
> + * that is already being destroyed.
> + *
> + * ctx->req, ctx->rsp, ctx->inbuf and ctx->input_pages point into kernel-owned
> + * GEM mappings and are released along with ctx->gem_objs[].
> + */
> +void qda_fastrpc_context_free(struct kref *ref)
> +{
> +	struct qda_fastrpc_invoke_ctx *ctx;
> +	int i;
> +
> +	ctx = container_of(ref, struct qda_fastrpc_invoke_ctx, refcount);
> +
> +	xa_erase(&ctx->qdev->ctx_xa, ctx->ctxid >> 4);
> +
> +	if (ctx->gem_objs) {
> +		for (i = 0; i < ctx->nscalars; ++i) {
> +			if (ctx->gem_objs[i])
> +				drm_gem_object_put(ctx->gem_objs[i]);
> +		}
> +		kfree(ctx->gem_objs);
> +	}
> +
> +	if (ctx->msg_gem_obj)
> +		drm_gem_object_put(&ctx->msg_gem_obj->base);
> +
> +	kfree(ctx->args);
> +	kfree(ctx);
> +}
> +
> +/**
> + * qda_fastrpc_flush_pending() - Fail every outstanding invocation
> + * @qdev: Device whose contexts should be flushed
> + *
> + * Called when the remote processor goes away. The DSP will never answer the
> + * in-flight invocations, so this stands in for the response callback: it wakes
> + * each waiter with an error and drops the reference the send path took for that
> + * callback. The waiter then tears the context down, releasing the GEM objects
> + * it pinned.
> + *
> + * Must run after drm_dev_unplug() has drained qda_rpmsg_cb(), so the real
> + * callback can no longer run and this is the only path completing a context.
> + */
> +void qda_fastrpc_flush_pending(struct qda_dev *qdev)
> +{
> +	struct qda_fastrpc_invoke_ctx *ctx;
> +	unsigned long idx;
> +
> +	xa_for_each(&qdev->ctx_xa, idx, ctx) {
> +		ctx->retval = -EPIPE;
> +		complete(&ctx->work);
> +		kref_put(&ctx->refcount, qda_fastrpc_context_free);
> +	}
> +}
> +
> +/**
> + * qda_fastrpc_context_alloc() - Allocate a FastRPC invocation context
> + * @qdev: Device whose lookup table the context is registered in
> + *
> + * Return: Pointer to the new context, or ERR_PTR on failure
> + */
> +struct qda_fastrpc_invoke_ctx *qda_fastrpc_context_alloc(struct qda_dev *qdev)
> +{
> +	struct qda_fastrpc_invoke_ctx *ctx;
> +	int ret;
> +	u32 id;
> +
> +	ctx = kzalloc_obj(*ctx);
> +	if (!ctx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&ctx->node);
> +	init_completion(&ctx->work);
> +	kref_init(&ctx->refcount);
> +	ctx->qdev = qdev;
> +	ctx->retval = -1;
> +	ctx->pid = current->pid;
> +
> +	ret = xa_alloc(&qdev->ctx_xa, &id, ctx, xa_limit_32b, GFP_KERNEL);
> +	if (ret) {
> +		kfree(ctx);
> +		return ERR_PTR(ret);
> +	}
> +	ctx->ctxid = id << 4;
> +
> +	return ctx;
> +}
> +
> +/*
> + * Resolve the physical address of an in/out buffer argument.  The buffer is
> + * backed either by a kernel-owned GEM object already recorded in
> + * ctx->gem_objs[i], or by a user-supplied GEM handle in ctx->args[i].handle.
> + */
> +static int process_msg_buffer(struct qda_fastrpc_invoke_ctx *ctx, int i,
> +			      union fastrpc_remote_arg *rpra,
> +			      struct fastrpc_phy_page *pages)
> +{
> +	u64 len = ctx->args[i].length;
> +	struct qda_gem_obj *qda_gem_obj;
> +
> +	rpra[i].buf.pv = ctx->args[i].ptr;
> +
> +	if (ctx->gem_objs[i]) {
> +		u64 unaligned_addr, offset;
> +
> +		qda_gem_obj = to_qda_gem_obj(ctx->gem_objs[i]);
> +		offset = ctx->args[i].ptr - (u64)(uintptr_t)qda_gem_obj->virt;
> +
> +		unaligned_addr = qda_gem_obj->dma_addr + offset;
> +		pages[i].addr = unaligned_addr & PAGE_MASK;
> +		pages[i].size = calculate_page_aligned_size(unaligned_addr, len);
> +	} else if (ctx->args[i].handle) {
> +		struct drm_gem_object *gem_obj;
> +		int err;
> +
> +		err = get_gem_obj_from_handle(ctx, ctx->args[i].handle, &gem_obj);
> +		if (err)
> +			return err;
> +
> +		ctx->gem_objs[i] = gem_obj;
> +		qda_gem_obj = to_qda_gem_obj(gem_obj);
> +
> +		pages[i].addr = qda_gem_obj->dma_addr +
> +				calculate_vma_offset(ctx->args[i].ptr);
> +		pages[i].size = calculate_page_aligned_size(ctx->args[i].ptr, len);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Resolve a DMA-handle argument.  The kernel needs the physical page
> + * descriptor, while the DSP identifies the buffer by its GEM handle.
> + */
> +static int process_dma_handle(struct qda_fastrpc_invoke_ctx *ctx, int i,
> +			      union fastrpc_remote_arg *rpra,
> +			      struct fastrpc_phy_page *pages)
> +{
> +	struct drm_gem_object *gem_obj;
> +	int err;
> +
> +	if (!ctx->args[i].handle) {
> +		rpra[i].buf.pv = ctx->args[i].ptr;
> +		rpra[i].buf.len = ctx->args[i].length;
> +		return 0;
> +	}
> +
> +	err = get_gem_obj_from_handle(ctx, ctx->args[i].handle, &gem_obj);
> +	if (err)
> +		return err;
> +
> +	ctx->gem_objs[i] = gem_obj;
> +	setup_pages_from_gem_obj(to_qda_gem_obj(gem_obj), &pages[i]);
> +
> +	/* The DSP-facing offset and length fields are 32-bit by wire format */
> +	rpra[i].dma.handle = ctx->args[i].handle;
> +	rpra[i].dma.len = (u32)ctx->args[i].length;
> +	rpra[i].dma.offset = (u32)ctx->args[i].ptr;
> +
> +	return 0;
> +}
> +
> +/**
> + * qda_fastrpc_get_header_size() - Compute the FastRPC message header size
> + * @ctx: FastRPC invocation context
> + *
> + * Also caches the intermediate metadata and packet sizes in @ctx for the
> + * subsequent pack step.
> + *
> + * Return: Page-aligned size of the message payload buffer in bytes
> + */
> +size_t qda_fastrpc_get_header_size(struct qda_fastrpc_invoke_ctx *ctx)
> +{
> +	ctx->inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
> +	ctx->metalen = fastrpc_get_meta_size(ctx);
> +	ctx->pkt_size = ALIGN(ctx->metalen, FASTRPC_ALIGN);
> +	ctx->aligned_pkt_size = PAGE_ALIGN(ctx->pkt_size);
> +
> +	return ctx->aligned_pkt_size;
> +}
> +
> +static int qda_fastrpc_get_args(struct qda_fastrpc_invoke_ctx *ctx)
> +{
> +	struct fastrpc_invoke_buf *list;
> +	struct fastrpc_phy_page *pages;
> +	union fastrpc_remote_arg *rpra;
> +	int i, err;
> +
> +	ctx->msg->buf = ctx->msg_gem_obj->virt;
> +	ctx->msg->phys = ctx->msg_gem_obj->dma_addr;
> +	memset(ctx->msg->buf, 0, ctx->aligned_pkt_size);
> +
> +	rpra = ctx->msg->buf;
> +	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
> +	pages = fastrpc_phy_page_start(list, ctx->nscalars);
> +	ctx->rpra = rpra;
> +	ctx->list = list;
> +	ctx->pages = pages;
> +
> +	for (i = 0; i < ctx->nbufs; ++i) {
> +		rpra[i].buf.pv = 0;
> +		rpra[i].buf.len = ctx->args[i].length;
> +		list[i].num = ctx->args[i].length ? 1 : 0;
> +		list[i].pgidx = i;
> +
> +		if (!ctx->args[i].length)
> +			continue;
> +
> +		err = process_msg_buffer(ctx, i, rpra, pages);
> +		if (err)
> +			return err;
> +	}
> +
> +	for (i = ctx->nbufs; i < ctx->nscalars; ++i) {
> +		list[i].num = ctx->args[i].length ? 1 : 0;
> +		list[i].pgidx = i;
> +
> +		err = process_dma_handle(ctx, i, rpra, pages);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * qda_fastrpc_invoke_pack() - Pack an invocation context into a QDA message
> + * @ctx: FastRPC invocation context
> + * @msg: QDA message to fill in
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_fastrpc_invoke_pack(struct qda_fastrpc_invoke_ctx *ctx, struct qda_msg *msg)
> +{
> +	int err;
> +
> +	ctx->msg = msg;
> +
> +	err = qda_fastrpc_get_args(ctx);
> +	if (err)
> +		return err;
> +
> +	/* Ensure the payload is visible to the DSP before the doorbell */
> +	dma_wmb();
> +
> +	if (ctx->handle == FASTRPC_INIT_HANDLE)
> +		msg->fastrpc.remote_session_id = 0;
> +	else
> +		msg->fastrpc.remote_session_id = ctx->remote_session_id;
> +
> +	msg->fastrpc.tid = ctx->pid;
> +	msg->fastrpc.ctx = ctx->ctxid | ctx->pd;
> +	msg->fastrpc.handle = ctx->handle;
> +	msg->fastrpc.sc = ctx->sc;
> +	msg->fastrpc.addr = msg->phys;
> +	msg->fastrpc.size = roundup(ctx->pkt_size, PAGE_SIZE);
> +	msg->fastrpc_ctx = ctx;
> +	msg->file_priv = ctx->file_priv;
> +
> +	return 0;
> +}
> +
> +/*
> + * INVOKE_DYNAMIC: the argument descriptors are supplied by user space, which
> + * is also responsible for having imported every buffer to a GEM handle.
> + */
> +static int qda_fastrpc_prepare_args_invoke(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
> +{
> +	struct drm_qda_invoke_args *invoke_args = argp;
> +	struct drm_qda_fastrpc_invoke_args *args;
> +	u32 nscalars;
> +
> +	ctx->handle = invoke_args->handle;
> +	ctx->sc = invoke_args->sc;
> +
> +	nscalars = REMOTE_SCALARS_LENGTH(ctx->sc);
> +	if (!nscalars)
> +		return 0;
> +
> +	args = kzalloc_objs(*args, nscalars);
> +	if (!args)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(args, u64_to_user_ptr(invoke_args->args),
> +			   nscalars * sizeof(*args))) {
> +		kfree(args);
> +		return -EFAULT;
> +	}
> +
> +	ctx->args = args;
> +
> +	return 0;
> +}
> +
> +/**
> + * qda_fastrpc_prepare_args() - Prepare arguments for a FastRPC invocation
> + * @ctx: FastRPC invocation context
> + * @argp: Kernel-side ioctl argument buffer owned by the DRM core
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_fastrpc_prepare_args(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
> +{
> +	int err;
> +
> +	switch (ctx->type) {
> +	case FASTRPC_RMID_INVOKE_DYNAMIC:
> +		err = qda_fastrpc_prepare_args_invoke(ctx, argp);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (err)
> +		return err;
> +
> +	ctx->nscalars = REMOTE_SCALARS_LENGTH(ctx->sc);
> +	ctx->nbufs = REMOTE_SCALARS_INBUFS(ctx->sc) + REMOTE_SCALARS_OUTBUFS(ctx->sc);
> +
> +	if (ctx->nscalars && !ctx->gem_objs) {
> +		ctx->gem_objs = kzalloc_objs(*ctx->gem_objs, ctx->nscalars);
> +		if (!ctx->gem_objs)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/accel/qda/qda_fastrpc.h b/drivers/accel/qda/qda_fastrpc.h
> new file mode 100644
> index 000000000000..a25818923a6e
> --- /dev/null
> +++ b/drivers/accel/qda/qda_fastrpc.h
> @@ -0,0 +1,242 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QDA_FASTRPC_H__
> +#define __QDA_FASTRPC_H__
> +
> +#include <linux/completion.h>
> +#include <linux/kref.h>
> +#include <linux/list.h>
> +#include <linux/types.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_file.h>
> +#include <drm/qda_accel.h>
> +
> +struct qda_dev;
> +struct qda_gem_obj;
> +struct qda_msg;
> +
> +/*
> + * FastRPC scalar extraction macros
> + *
> + * These macros extract different fields from the scalar value that describes
> + * the arguments passed in a FastRPC invocation.
> + */
> +#define REMOTE_SCALARS_INBUFS(sc)	(((sc) >> 16) & 0x0ff)
> +#define REMOTE_SCALARS_OUTBUFS(sc)	(((sc) >> 8) & 0x0ff)
> +#define REMOTE_SCALARS_INHANDLES(sc)	(((sc) >> 4) & 0x0f)
> +#define REMOTE_SCALARS_OUTHANDLES(sc)	((sc) & 0x0f)
> +#define REMOTE_SCALARS_LENGTH(sc)	(REMOTE_SCALARS_INBUFS(sc) +   \
> +					 REMOTE_SCALARS_OUTBUFS(sc) +  \
> +					 REMOTE_SCALARS_INHANDLES(sc) + \
> +					 REMOTE_SCALARS_OUTHANDLES(sc))
> +
> +/* FastRPC configuration constants */
> +#define FASTRPC_ALIGN		128		/* Alignment requirement */
> +#define FASTRPC_MAX_HANDLELIST	16		/* Maximum handles the DSP can release */
> +#define FASTRPC_MAX_CRCLIST	64		/* Maximum CRC list entries */
> +
> +/*
> + * FastRPC scalar construction macros
> + *
> + * These macros build the scalar value that describes the arguments
> + * for a FastRPC invocation.
> + */
> +#define FASTRPC_BUILD_SCALARS(attr, method, in, out, oin, oout)		\
> +				(((attr & 0x07) << 29) |		\
> +				((method & 0x1f) << 24) |		\
> +				((in & 0xff) << 16) |			\
> +				((out & 0xff) <<  8) |			\
> +				((oin & 0x0f) <<  4) |			\
> +				(oout & 0x0f))
> +
> +#define FASTRPC_SCALARS(method, in, out) \
> +		FASTRPC_BUILD_SCALARS(0, method, in, out, 0, 0)
> +
> +/**
> + * struct fastrpc_remote_dmahandle - Remote DMA handle descriptor
> + */
> +struct fastrpc_remote_dmahandle {
> +	/** @handle: Handle of the buffer */
> +	s32 handle;
> +	/** @offset: Byte offset within the buffer object */
> +	u32 offset;
> +	/** @len: Length of the region in bytes */
> +	u32 len;
> +};
> +
> +/**
> + * struct fastrpc_remote_buf - Remote buffer descriptor
> + */
> +struct fastrpc_remote_buf {
> +	/** @pv: Buffer pointer (user virtual address) */
> +	u64 pv;

pv would mean physical something. Also, where do you validate the user's
address? Where do we check that it's ok to access the buffer, that it's
not a garbage?

> +	/** @len: Length of the buffer in bytes */
> +	u64 len;
> +};
> +
> +/**
> + * union fastrpc_remote_arg - Remote argument (buffer or DMA handle)
> + */
> +union fastrpc_remote_arg {
> +	/** @buf: Inline buffer descriptor */
> +	struct fastrpc_remote_buf buf;
> +	/** @dma: DMA-BUF handle descriptor */
> +	struct fastrpc_remote_dmahandle dma;
> +};
> +
> +/**
> + * struct fastrpc_phy_page - Physical page descriptor
> + */
> +struct fastrpc_phy_page {
> +	/** @addr: Physical (IOMMU) address of the page */
> +	u64 addr;
> +	/** @size: Size of the contiguous region in bytes */
> +	u64 size;
> +};
> +
> +/**
> + * struct fastrpc_invoke_buf - Invoke buffer descriptor
> + */
> +struct fastrpc_invoke_buf {
> +	/** @num: Number of contiguous physical regions */
> +	u32 num;
> +	/** @pgidx: Index into the physical page array */
> +	u32 pgidx;
> +};
> +
> +/**
> + * struct fastrpc_msg - FastRPC wire message for remote invocations
> + *
> + * Sent to the remote processor via RPMsg. This is the exact layout
> + * the DSP expects; do not reorder or add fields without DSP firmware
> + * coordination.

__packed?

> + */
> +struct fastrpc_msg {
> +	/** @remote_session_id: Session identifier on the remote processor */
> +	int remote_session_id;

Is it int or u32?

> +	/** @tid: Thread ID of the invoking thread */
> +	int tid;
> +	/** @ctx: Context identifier for matching request/response */
> +	u64 ctx;
> +	/** @handle: Handle of the remote method to invoke */
> +	u32 handle;
> +	/** @sc: Scalars value encoding in/out buffer counts */
> +	u32 sc;
> +	/** @addr: Physical address of the message payload buffer */
> +	u64 addr;
> +	/** @size: Size of the message payload in bytes */
> +	u64 size;
> +};
> +
> +/**
> + * struct qda_fastrpc_invoke_ctx - Remote procedure call invocation context
> + *
> + * Maintains all state for a single remote procedure call, including buffer
> + * management, synchronisation, and result handling.
> + */
> +struct qda_fastrpc_invoke_ctx {
> +	/** @node: List node for linking contexts in a queue */
> +	struct list_head node;
> +	/** @qdev: Device owning the XArray this context is registered in */
> +	struct qda_dev *qdev;
> +	/** @ctxid: Unique context identifier (XArray key shifted left by 4) */

Why is it shifted by 4? Why not by 3?

> +	u64 ctxid;
> +	/** @inbufs: Number of input buffers */
> +	int inbufs;
> +	/** @nscalars: Total number of scalar arguments */
> +	int nscalars;
> +	/** @nbufs: Total number of buffer arguments (inbufs + outbufs) */
> +	int nbufs;
> +	/** @pid: Process ID of the calling process */
> +	int pid;
> +	/** @retval: Status code reported by the DSP for this invocation */
> +	int retval;
> +	/** @remote_session_id: Session identifier on the remote processor */
> +	int remote_session_id;

is pid linked to remote_session_id?

> +	/** @pd: Protection domain identifier encoded into the context ID */

If it's already encoded, why do you need it here?c

> +	int pd;
> +	/** @type: Invocation type (e.g. FASTRPC_RMID_INVOKE_DYNAMIC) */
> +	u32 type;

What other types can exist?

> +	/** @sc: Scalars value encoding in/out buffer counts */
> +	u32 sc;

Remove it and calculate from in/outbufs above?

> +	/** @handle: Handle of the remote method being invoked */
> +	u32 handle;
> +	/** @metalen: Length of the FastRPC metadata header in bytes */
> +	size_t metalen;
> +	/** @pkt_size: Total payload size in bytes */
> +	u64 pkt_size;
> +	/** @aligned_pkt_size: Page-aligned payload size for GEM allocation */

???

> +	u64 aligned_pkt_size;
> +	/** @list: Array of invoke buffer descriptors */
> +	struct fastrpc_invoke_buf *list;
> +	/** @pages: Array of physical page descriptors for all arguments */
> +	struct fastrpc_phy_page *pages;
> +	/** @input_pages: Array of physical page descriptors for input buffers */
> +	struct fastrpc_phy_page *input_pages;
> +	/** @work: Completion used to synchronise with the DSP response */
> +	struct completion work;
> +	/** @msg: Pointer to the QDA message structure for this invocation */
> +	struct qda_msg *msg;
> +	/** @rpra: Array of remote procedure arguments */
> +	union fastrpc_remote_arg *rpra;
> +	/** @gem_objs: Array of GEM objects imported for argument buffers */
> +	struct drm_gem_object **gem_objs;
> +	/** @args: Invoke argument descriptors */
> +	struct drm_qda_fastrpc_invoke_args *args;
> +	/** @refcount: Reference counter for context lifetime management */

What for?

> +	struct kref refcount;
> +	/** @msg_gem_obj: GEM object backing the message payload buffer */
> +	struct qda_gem_obj *msg_gem_obj;
> +	/** @file_priv: DRM file private data */
> +	struct drm_file *file_priv;
> +	/**
> +	 * @req: Request buffer for the internal init/map/unmap calls.  Points
> +	 * into a kernel-owned GEM mapping tracked by @gem_objs, so it must
> +	 * never be freed directly.
> +	 */
> +	void *req;

Why do you need separate pointers here? Can't you be getting them from
msm_gem_obj?

> +	/** @rsp: Response buffer, same lifetime rules as @req */
> +	void *rsp;
> +	/** @inbuf: Process-create input buffer, same lifetime rules as @req */
> +	void *inbuf;
> +};
> +
> +/**
> + * struct qda_msg - FastRPC message with kernel-internal bookkeeping
> + */
> +struct qda_msg {
> +	/**
> +	 * @fastrpc: Wire-format message sent to the DSP via RPMsg.
> +	 * Must be the first member.
> +	 */
> +	struct fastrpc_msg fastrpc;
> +	/** @buf: Kernel virtual address of the payload buffer */
> +	void *buf;
> +	/** @phys: Physical/DMA address of the payload buffer */
> +	u64 phys;
> +	/** @ret: Return value from the remote processor */
> +	int ret;
> +	/** @fastrpc_ctx: Back-pointer to the owning invocation context */
> +	struct qda_fastrpc_invoke_ctx *fastrpc_ctx;
> +	/** @file_priv: DRM file private data for GEM object lookup */
> +	struct drm_file *file_priv;
> +};
> +
> +/* Remote Method ID table - identifies initialization and control operations */
> +#define FASTRPC_RMID_INVOKE_DYNAMIC	0xFFFFFFFFU	/* Dynamic method invocation */
> +
> +/* Common handle for initialization operations */
> +#define FASTRPC_INIT_HANDLE		0x1
> +
> +void qda_fastrpc_context_free(struct kref *ref);
> +void qda_fastrpc_cleanup_handlelist(struct qda_fastrpc_invoke_ctx *ctx);
> +void qda_fastrpc_flush_pending(struct qda_dev *qdev);
> +struct qda_fastrpc_invoke_ctx *qda_fastrpc_context_alloc(struct qda_dev *qdev);
> +int qda_fastrpc_prepare_args(struct qda_fastrpc_invoke_ctx *ctx, void *argp);
> +size_t qda_fastrpc_get_header_size(struct qda_fastrpc_invoke_ctx *ctx);
> +int qda_fastrpc_invoke_pack(struct qda_fastrpc_invoke_ctx *ctx, struct qda_msg *msg);
> +
> +#endif /* __QDA_FASTRPC_H__ */
> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
> index f65325c80a12..b7ee4899ba74 100644
> --- a/drivers/accel/qda/qda_ioctl.c
> +++ b/drivers/accel/qda/qda_ioctl.c
> @@ -1,10 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  // Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>  #include <drm/drm_ioctl.h>
> +#include <drm/drm_print.h>
>  #include <drm/qda_accel.h>
>  #include "qda_drv.h"
> +#include "qda_fastrpc.h"
>  #include "qda_gem.h"
>  #include "qda_ioctl.h"
> +#include "qda_rpmsg.h"
>  
>  /**
>   * qda_ioctl_query() - Query DSP device information
> @@ -83,3 +86,83 @@ int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_fil
>  
>  	return drm_gem_dumb_map_offset(file_priv, dev, args->handle, &args->offset);
>  }
> +
> +static int qda_fastrpc_invoke(u32 type, struct drm_device *dev, void *data,
> +			      struct drm_file *file_priv)
> +{
> +	struct qda_file_priv *qda_file_priv = file_priv->driver_priv;
> +	struct qda_dev *qdev = qda_file_priv->qda_dev;
> +	struct qda_fastrpc_invoke_ctx *ctx;
> +	struct drm_gem_object *gem_obj;
> +	struct qda_msg msg;
> +	size_t hdr_size;
> +	int err;
> +
> +	ctx = qda_fastrpc_context_alloc(qdev);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	ctx->type = type;
> +	ctx->file_priv = file_priv;
> +	ctx->remote_session_id = qda_file_priv->remote_session_id;
> +
> +	err = qda_fastrpc_prepare_args(ctx, data);
> +	if (err)
> +		goto err_context_free;
> +
> +	hdr_size = qda_fastrpc_get_header_size(ctx);
> +
> +	gem_obj = qda_gem_create_object(dev, qdev->iommu_mgr, hdr_size, file_priv);
> +	if (IS_ERR(gem_obj)) {
> +		err = PTR_ERR(gem_obj);
> +		goto err_context_free;
> +	}
> +
> +	ctx->msg_gem_obj = to_qda_gem_obj(gem_obj);
> +
> +	err = qda_fastrpc_invoke_pack(ctx, &msg);
> +	if (err)
> +		goto err_context_free;
> +
> +	err = qda_rpmsg_send_msg(qdev, &msg);
> +	if (err)
> +		goto err_context_free;
> +
> +	err = qda_rpmsg_wait_for_rsp(ctx);
> +	if (err)
> +		goto err_context_free;
> +
> +	/* Ensure the results written by the DSP are visible before reading */
> +	dma_rmb();
> +
> +	err = ctx->retval;
> +	if (err) {
> +		drm_dbg_driver(dev, "DSP returned status 0x%x for type %u\n",
> +			       ctx->retval, type);
> +		goto err_context_free;
> +	}
> +
> +	qda_fastrpc_cleanup_handlelist(ctx);
> +
> +	kref_put(&ctx->refcount, qda_fastrpc_context_free);
> +
> +	return 0;
> +
> +err_context_free:
> +	kref_put(&ctx->refcount, qda_fastrpc_context_free);
> +
> +	return err;
> +}
> +
> +/**
> + * qda_ioctl_invoke() - Perform a dynamic FastRPC method invocation
> + * @dev: DRM device structure
> + * @data: User-space data (struct qda_invoke_args)
> + * @file_priv: DRM file private data
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_ioctl_invoke(struct drm_device *dev, void *data, struct drm_file *file_priv)
> +{
> +	return qda_fastrpc_invoke(FASTRPC_RMID_INVOKE_DYNAMIC, dev, data, file_priv);
> +}
> diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
> index d1cbbfb6d965..3bb9cfd98370 100644
> --- a/drivers/accel/qda/qda_ioctl.h
> +++ b/drivers/accel/qda/qda_ioctl.h
> @@ -11,5 +11,6 @@
>  int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv);
>  int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv);
>  int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv);
> +int qda_ioctl_invoke(struct drm_device *dev, void *data, struct drm_file *file_priv);
>  
>  #endif /* __QDA_IOCTL_H__ */
> diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
> index 64bf503106d9..7a5e0d3e20ca 100644
> --- a/drivers/accel/qda/qda_rpmsg.c
> +++ b/drivers/accel/qda/qda_rpmsg.c
> @@ -1,12 +1,17 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  // Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#include <linux/completion.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/rpmsg.h>
> +#include <linux/sched.h>
> +#include <linux/wait.h>
>  #include <drm/drm_print.h>
>  
>  #include "qda_cb.h"
>  #include "qda_drv.h"
> +#include "qda_fastrpc.h"
> +#include "qda_rpmsg.h"
>  
>  static struct qda_dev *qda_rpmsg_alloc_and_init_qdev(struct rpmsg_device *rpdev)
>  {
> @@ -23,11 +28,92 @@ static struct qda_dev *qda_rpmsg_alloc_and_init_qdev(struct rpmsg_device *rpdev)
>  	return qdev;
>  }
>  
> +/**
> + * qda_rpmsg_send_msg() - Send a packed invocation to the remote processor
> + * @qdev: QDA device structure
> + * @msg: Packed message to send
> + *
> + * Takes a reference on the invocation context on behalf of the response
> + * callback, which keeps the context alive until the DSP has replied.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_rpmsg_send_msg(struct qda_dev *qdev, struct qda_msg *msg)
> +{
> +	struct qda_fastrpc_invoke_ctx *ctx = msg->fastrpc_ctx;
> +	int ret, idx;
> +
> +	if (!drm_dev_enter(&qdev->drm_dev, &idx))
> +		return -ENODEV;
> +
> +	if (!qdev->rpdev) {
> +		ret = -ENODEV;
> +		goto out_exit;
> +	}
> +
> +	kref_get(&ctx->refcount);
> +
> +	ret = rpmsg_send(qdev->rpdev->ept, &msg->fastrpc, sizeof(msg->fastrpc));
> +	if (ret) {
> +		drm_err_ratelimited(&qdev->drm_dev, "Failed to send rpmsg: %d\n", ret);
> +		kref_put(&ctx->refcount, qda_fastrpc_context_free);
> +	}
> +
> +out_exit:
> +	drm_dev_exit(idx);
> +
> +	return ret;
> +}
> +
> +/**
> + * qda_rpmsg_wait_for_rsp() - Wait for the DSP to answer an invocation
> + * @ctx: FastRPC invocation context
> + *
> + * Return: 0 once the response arrived, or -ERESTARTSYS if a signal
> + * interrupted the wait
> + */
> +int qda_rpmsg_wait_for_rsp(struct qda_fastrpc_invoke_ctx *ctx)
> +{
> +	return wait_for_completion_interruptible(&ctx->work);
> +}
> +
>  static int qda_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
>  			void *priv, u32 src)
>  {
> -	/* Placeholder: responses will be dispatched here */
> -	return 0;
> +	struct qda_dev *qdev = dev_get_drvdata(&rpdev->dev);
> +	struct qda_invoke_rsp *resp_msg = data;
> +	struct qda_fastrpc_invoke_ctx *ctx;
> +	int ret = 0, idx;
> +
> +	if (!qdev)
> +		return -ENODEV;
> +
> +	if (!drm_dev_enter(&qdev->drm_dev, &idx))
> +		return -ENODEV;
> +
> +	if (len < sizeof(*resp_msg)) {
> +		ret = -EINVAL;
> +		goto out_exit;
> +	}
> +
> +	ctx = xa_load(&qdev->ctx_xa, resp_msg->ctx >> 4);
> +	if (!ctx) {
> +		drm_dbg_driver(&qdev->drm_dev, "No context matches response 0x%llx\n",
> +			       resp_msg->ctx);
> +		ret = -ENOENT;
> +		goto out_exit;
> +	}
> +
> +	ctx->retval = resp_msg->retval;
> +	complete(&ctx->work);
> +
> +	/* Release the reference taken by qda_rpmsg_send_msg() */
> +	kref_put(&ctx->refcount, qda_fastrpc_context_free);
> +
> +out_exit:
> +	drm_dev_exit(idx);
> +
> +	return ret;
>  }
>  
>  static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
> @@ -41,6 +127,7 @@ static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
>  	 */
>  	drm_dev_unplug(&qdev->drm_dev);
>  	qdev->rpdev = NULL;
> +	qda_fastrpc_flush_pending(qdev);
>  	qda_cb_unpopulate(qdev);
>  	qda_deinit_device(qdev);
>  }
> diff --git a/drivers/accel/qda/qda_rpmsg.h b/drivers/accel/qda/qda_rpmsg.h
> new file mode 100644
> index 000000000000..a70f4a80808d
> --- /dev/null
> +++ b/drivers/accel/qda/qda_rpmsg.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QDA_RPMSG_H__
> +#define __QDA_RPMSG_H__
> +
> +#include "qda_drv.h"
> +#include "qda_fastrpc.h"
> +
> +/**
> + * struct qda_invoke_rsp - Response structure for FastRPC invocations
> + */
> +struct qda_invoke_rsp {
> +	/** @ctx: Invoke caller context for matching request/response */
> +	u64 ctx;
> +	/** @retval: Return value from the remote invocation */
> +	int retval;
> +};
> +
> +/* RPMsg transport layer functions */
> +int qda_rpmsg_send_msg(struct qda_dev *qdev, struct qda_msg *msg);
> +int qda_rpmsg_wait_for_rsp(struct qda_fastrpc_invoke_ctx *ctx);
> +
> +#endif /* __QDA_RPMSG_H__ */
> diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
> index 1d699f00e7be..5cf0fec1d91c 100644
> --- a/include/uapi/drm/qda_accel.h
> +++ b/include/uapi/drm/qda_accel.h
> @@ -21,6 +21,8 @@ extern "C" {
>  #define DRM_QDA_QUERY		0x00
>  #define DRM_QDA_GEM_CREATE		0x01
>  #define DRM_QDA_GEM_MMAP_OFFSET	0x02
> +/* Command numbers 0x03-0x06 reserved for INIT_ATTACH, INIT_CREATE, MAP, MUNMAP */

WHY?

> +#define DRM_QDA_REMOTE_INVOKE			0x07
>  
>  /*
>   * QDA IOCTL definitions
> @@ -35,6 +37,8 @@ extern "C" {
>  					  struct drm_qda_gem_create)
>  #define DRM_IOCTL_QDA_GEM_MMAP_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_MMAP_OFFSET, \
>  					  struct drm_qda_gem_mmap_offset)
> +#define DRM_IOCTL_QDA_REMOTE_INVOKE	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_INVOKE, \
> +					  struct drm_qda_invoke_args)
>  
>  /* Query type definitions for drm_qda_query */
>  #define QDA_QUERY_DSP_NAME	1
> @@ -84,6 +88,44 @@ struct drm_qda_gem_mmap_offset {
>  	__u32 pad;
>  };
>  
> +/**
> + * struct drm_qda_fastrpc_invoke_args - FastRPC invocation argument descriptor
> + * @ptr: Pointer to argument data (user virtual address)

Why do you need it? Is handle + length not enough? If you want, specify
offset inside the GEM BO.

> + * @length: Length of the argument data in bytes
> + * @handle: GEM handle for buffer arguments; 0 for scalar arguments
> + * @attr: Argument attributes and flags
> + *
> + * This structure describes a single argument passed to a FastRPC invocation.
> + * Arguments can be either scalar values or buffer references (via GEM handle).
> + * Userspace must import any DMA-BUF fd to a GEM handle before populating
> + * this field; the driver never accepts DMA-BUF fds directly.
> + */
> +struct drm_qda_fastrpc_invoke_args {
> +	__u64 ptr;
> +	__u64 length;
> +	__u32 handle;
> +	__u32 attr;
> +};
> +
> +/**
> + * struct drm_qda_invoke_args - Dynamic FastRPC invocation parameters
> + * @handle: Remote handle to invoke on the DSP
> + * @sc: FastRPC scalars value encoding the number of in/out buffers
> + * @args: User-space pointer to array of drm_qda_fastrpc_invoke_args descriptors;
> + *        the handle field in each entry must be a GEM handle (or 0 for
> + *        inline scalar buffers). Userspace must import DMA-BUF fds to GEM

What is inline scalar buffer? I think, we agreed that everything is a
GEM BO.

> + *        handles before passing them here.

I'd say this is useless. It adds no information. If the driver only
accepts GEM handles, why do you need to speak about DMA BUFs here?

> + *
> + * This structure is used with DRM_IOCTL_QDA_REMOTE_INVOKE to perform a
> + * dynamic remote procedure call on the DSP. The args pointer must reference
> + * an array of REMOTE_SCALARS_LENGTH(sc) drm_qda_fastrpc_invoke_args entries.

And how does the user know, what is REMOTE_SCALARS_LENGTH? Define it
here, please (and start with QDA).

> + */
> +struct drm_qda_invoke_args {
> +	__u32 handle;
> +	__u32 sc;

Can we place sc with __u8 inargs, __u8 outargs? Then there is no need to
play with the bytes and talk about REMOTE_SCALARS_LENGTH.

> +	__u64 args;

__u64 inargs, __u64 outargs?

> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
