Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46576C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 23:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AFCA10E343;
	Tue,  8 Sep 2026 23:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QnRZI6nv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WOu/LJLT";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B945410EDE2
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 23:16:28 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Mg4wZ1274358
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 23:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5OpX0FvQVUkIQJtPqzVnZ/Nb
 Tsx2FqQIdJRRkVKt+og=; b=QnRZI6nvjSo5DsAESsy6xbYDktBxBT2IRdqnBI7X
 FCnj5oDNDyM/LJZns946y4evuRXzVWe+iXP+dgtfASwlaoTnsB7Uo4HOfjB4ja0M
 E2dSXKXzXj9whr/narRp2sCBn1GB++SBVDyRZ9kqlI2caj2uPtBUF+QNlTn3yxpU
 Mf/C/q0alRXIhMWsvH61poIu8Nq49W3EL0SQJbgdcZO/x8K57LklWwR5luwaSAw8
 KFdAFI78cw8Wws1d0Bk0EDNWh1lh7fwRxzXV0U8TFhyB8/2UMHXnh52+53/+EU0r
 muLhvJwdgjvL4solreMgpjZiq6ZleDqwQKJkeW6ExeorDw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqdw18ed-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 23:16:28 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-97ca6578487so3788734241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 16:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788909387; x=1789514187;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5OpX0FvQVUkIQJtPqzVnZ/NbTsx2FqQIdJRRkVKt+og=;
 b=WOu/LJLTfR3dlYg4W6aTB1QYzL8PGxXk1xhuU+mgIR/uJCyQqLxRiMReqv5siGAdzo
 8Qo5Dru+D0ETDWBBF889Vjg2+TyAYBsXnLRZXAfwQt1Tn3gTm6UXR7PPqe7awWU4s/l7
 wtlpBX0T/VBmdKpXL2hKY+OOC87vsa+ApADcsKvzLzIu4RZbmKVneeJEPeBLefomH8yX
 2gDyhnDoS1jd2o4Kvc9XAEGGBBOzDEdmakrkuS/aZNqIBEIx0RvtqpulGml2BEoOtZYr
 EqtgB8jEfGoBkoHmjgixPH1I8chX9qeN7c7cCDtm8xPXtxFGM9a3DA+T/wUhn/vagZdv
 /Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788909387; x=1789514187;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5OpX0FvQVUkIQJtPqzVnZ/NbTsx2FqQIdJRRkVKt+og=;
 b=KnG7FUMQR7zOEXJh/c8EPmzpGF3XmjCUmDOqFvvagQhCyaULFGLCNzfBG9C6YYMZBD
 G64F2N4RsCj0cJ7Ivqb+x2EWBbAA1+psLSxil37WHzBq7uOG6SguyWVuI3wfZDI21/LB
 Li4LuJN7vr9JwT9M0xmIuvmtoKGKZVIukYNUUly92PTpbF457OR27NHNm5FA6YTJ7wFs
 /1vBKg44d80HXiKQo3E3r0t86HTgsLpgyIBqWe9XbSgjkQGKJ+Kkl6sVYrY7vLSj2gZa
 BWhxrze0tUNuA1zFSD5KKhjC3yVa3WUDcYD05LyExanfrAQGwvkn4VRh4LKkYDBHTZ0b
 jDxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+S5ED8WLwdbiWKNQh2Y+wQ5vkO0phImvLbfw4AXlqBfuceKQ6aJo+IF7JjvJdzlyELuIFfoqbddY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nlvkx+zGL3/J4ouxx3IHXabU6C5aZh1QilJkF7PTczgmGnVHnI
 0YYSVvIL7PIVrUYluo/O+Kx9fOGjFlRsX0iUe4K33GQlQSCdpFh3u9etal+MWWlPZ3YubXkO0WW
 nfjnOERTjmBLg8mT9RIbQoK848vlci58KbpaJRUb58DRCykL9JzyObZi5RDNFlhKKLms2Pak=
X-Gm-Gg: AYBFou0I3/agKoCjYQsRi05+4XMkTSruMSc+7bd56+GX096QszOCRMwoyZvCoYxRgPa
 JyT0dyNGTLxlFdSZ95t0TsG44eR3WuZeaYA/bE6A7IB59WaKiSqjEgb9kzgI+woa5g4g9setqRr
 5KQt44UJli+3w8Smb8lOGpdnroZCkWuMEjQDuAab+XjrtmQWpTNs4VzNbGwsAow+WVb4K5Y0YwJ
 avr6OzcGOUzGy8jSAZECBAYp1+m17tDYiOwtIL01CJTybOAXpgPvPek4kpNSrpwkZIfbZfa6GrX
 OA4+QjvPOQP1O+CJTd3HwH/Mo3HjxIGryk5gdwls2nmCMuElh1RZHz3BboHhkqpNuDLhQdA9I3W
 ERO7DmfAq7seQ7OA3zi4NuKX1HzSovEYcObxuX7uaKvv0yra7f/UN2q/aTDigaO4BCoq1vwu4oH
 8mbDC08z5ZpUAW
X-Received: by 2002:a05:6102:5126:b0:785:5a17:739b with SMTP id
 ada2fe7eead31-78a4a4944femr15114464137.0.1788909386856; 
 Tue, 08 Sep 2026 16:16:26 -0700 (PDT)
X-Received: by 2002:a05:6102:5126:b0:785:5a17:739b with SMTP id
 ada2fe7eead31-78a4a4944femr15114434137.0.1788909386306; 
 Tue, 08 Sep 2026 16:16:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a3705ed75dsm39469231fa.40.2026.09.08.16.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 16:16:25 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:16:23 +0300
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
Message-ID: <ja2usiwasnu2x7lgx2xjsk57mew2nj7szn6ruqo6v7d2cpjcqe@xjpmxfkhxqkn>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-12-69a02e9090d4@oss.qualcomm.com>
 <hbrtbfpmcodd3nkaytihzki56232bws7ubbcth7ewwckwi5y6t@ft4ej4fr7duz>
 <3f644c83-ffd6-452d-aa81-1c13aaa397ac@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f644c83-ffd6-452d-aa81-1c13aaa397ac@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: hRPgRNTpGqSIpYuq-EC8NpOmYHC8tfe0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDI1NSBTYWx0ZWRfX1viM3FpAOkiV
 iK//V+wm62YVh57VaI3n3g+SX8AlUhXTTlG5cva59Nkx6n/w4zvk6nqTOytXvjwbJAt9S7qIdPH
 HGBAVghtSGQaTpejyAoiUZHmaTsoFMQ=
X-Proofpoint-GUID: hRPgRNTpGqSIpYuq-EC8NpOmYHC8tfe0
X-Authority-Analysis: v=2.4 cv=Bo2tB4X5 c=1 sm=1 tr=0 ts=6aa0974c cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=NJr1yQlnZ1qXxQj-jTwA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDI1NSBTYWx0ZWRfXzjZxFEA0TPg+
 mVgmElcGRKwVpvLiEhiuWxPNP/vzKvRVjFE1Yvn8uoeKgNBdY6cYcZvZRVll8MpZA6qY8chKSiq
 PLIj2/UJFhwAGAHlI0sPxR++gGcic5WCoypJPQ7GQRGqa5BQrsz48P/pE3292queR0XD7Ra/2qB
 SzncC94ZOzEhx7MafDU2uZKudtQ5kv5kxViGt3yh4+bMwIS8eYAUvLjVhCLHVy67rmRCieAyV4U
 HvqTMglGBTB/ELDxetHfMo/N+waNCByWEyDoZejzEneXiGPaHCf6LeqyCsQ+bWw5LvN8GS2Uahp
 2wpXBoBmdEUR+NQj6I6TauRfVYVJS+HMIJ4ZSs0Innyj6iWcjp5BDi5+xrhoTVrpYJNnJXEREy8
 yTLbIhfauf/FXQ+m4WEeZw3gKGqHXH5tG6HMD7vO9kKVlpJ9gKhgFVKGKr4NYPk9Nqj0Z/tgdFQ
 RJ8ghQhydzDUGnzmH0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080255
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

On Thu, Aug 20, 2026 at 02:05:01PM +0530, Ekansh Gupta wrote:
> On 18-08-2026 09:49, Dmitry Baryshkov wrote:
> > On Mon, Aug 17, 2026 at 10:17:47AM +0530, Ekansh Gupta wrote:
> >> Implement the FastRPC remote procedure call path, allowing user-space to
> >> invoke methods on the DSP via DRM_IOCTL_QDA_REMOTE_INVOKE.
> >>
> >> qda_fastrpc.c / qda_fastrpc.h
> >>   Implements the FastRPC protocol layer: argument marshalling
> >>   (qda_fastrpc_invoke_pack), response unmarshalling
> >>   (qda_fastrpc_invoke_unpack), and invocation context lifecycle
> >>   management. Each invocation allocates a qda_fastrpc_invoke_ctx which
> >>   tracks buffer descriptors, GEM objects, and the completion used to
> >>   synchronise with the DSP response.
> >>
> >>   Buffer arguments are identified by GEM handles. Userspace imports any
> >>   DMA-BUF fd to a GEM handle with DRM_IOCTL_PRIME_FD_TO_HANDLE before
> >>   invoking; the driver never accepts DMA-BUF fds directly. Each argument
> >>   is described by its GEM handle, the user virtual address of the data
> >>   and its length, from which the driver derives the offset within the
> >>   buffer and the page-aligned range to describe to the DSP. Packing
> >>   several arguments into one buffer, and any overlap handling, is left
> >>   to user space.
> >>
> >> qda_rpmsg.c
> >>   Implements qda_rpmsg_send_msg() which sends the wire-format
> >>   fastrpc_msg (embedded as the first member of qda_msg) directly via
> >>   rpmsg_send(), and qda_rpmsg_wait_for_rsp() which blocks on the context
> >>   completion. The RPMsg callback dispatches responses to waiting
> >>   contexts via the ctx_xa XArray.
> >>
> >> qda_ioctl.c
> >>   qda_ioctl_invoke() drives the full invocation lifecycle: it builds the
> >>   invocation context from the user-supplied arguments, packs the
> >>   arguments into the message buffer, sends the message to the DSP, waits
> >>   for the response, unpacks the output arguments back to user space and
> >>   releases the context.
> >>
> >> include/uapi/drm/qda_accel.h
> >>   Adds DRM_IOCTL_QDA_REMOTE_INVOKE with struct drm_qda_invoke_args and
> >>   the per-argument descriptor struct drm_qda_fastrpc_invoke_args.
> >>
> >> Assisted-by: Claude:claude-sonnet-5
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> ---
> >> Changes in v2:
> >> - Drop the DMA-BUF fd argument path. Buffer arguments are now identified
> >>   by GEM handles only; user space is responsible for importing fds to
> >>   GEM handles before invoking (Dmitry Baryshkov)
> >> - Leave argument packing and overlap handling to user space rather than
> >>   supporting several buffer-passing formats in the driver
> >>   (Dmitry Baryshkov)
> >> ---
> >>  drivers/accel/qda/Makefile      |   1 +
> >>  drivers/accel/qda/qda_drv.c     |   8 +
> >>  drivers/accel/qda/qda_drv.h     |   8 +
> >>  drivers/accel/qda/qda_fastrpc.c | 434 ++++++++++++++++++++++++++++++++++++++++
> >>  drivers/accel/qda/qda_fastrpc.h | 242 ++++++++++++++++++++++
> >>  drivers/accel/qda/qda_ioctl.c   |  83 ++++++++
> >>  drivers/accel/qda/qda_ioctl.h   |   1 +
> >>  drivers/accel/qda/qda_rpmsg.c   |  91 ++++++++-
> >>  drivers/accel/qda/qda_rpmsg.h   |  26 +++
> >>  include/uapi/drm/qda_accel.h    |  42 ++++
> >>  10 files changed, 934 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> >> index fb092e56d7f3..2d10420cd1ec 100644
> >> --- a/drivers/accel/qda/Makefile
> >> +++ b/drivers/accel/qda/Makefile
> >> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
> >>  qda-y := \
> >>  	qda_cb.o \
> >>  	qda_drv.o \
> >> +	qda_fastrpc.o \
> >>  	qda_gem.o \
> >>  	qda_ioctl.o \
> >>  	qda_memory_dma.o \
> >> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> >> index a68a07d0ae56..f925bbcfa6e9 100644
> >> --- a/drivers/accel/qda/qda_drv.c
> >> +++ b/drivers/accel/qda/qda_drv.c
> >> @@ -25,6 +25,8 @@ static int qda_open(struct drm_device *dev, struct drm_file *file)
> >>  
> >>  	qda_file_priv->pid = current->pid;
> >>  	qda_file_priv->qda_dev = qda_dev_from_drm(dev);
> >> +	qda_file_priv->remote_session_id =
> >> +		atomic_inc_return(&qda_file_priv->qda_dev->remote_session_id_counter);
> > 
> > What happens on the wraparound? What if some of those sessions are still
> > alive?
> collision would require 2^31 opens without close, is this reachable?
> Should I add a comment here? Or some how address this?>

Just address it in the driver, disallowing such collisions. If there is
a way for the counter to wrap, it will wrap once.

> >>  	file->driver_priv = qda_file_priv;
> >>  
> >>  	return 0;
> > 
> > [...]

> >> +
> >> +/**
> >> + * struct fastrpc_remote_buf - Remote buffer descriptor
> >> + */
> >> +struct fastrpc_remote_buf {
> >> +	/** @pv: Buffer pointer (user virtual address) */
> >> +	u64 pv;
> > 
> > pv would mean physical something. Also, where do you validate the user's
> > address? Where do we check that it's ok to access the buffer, that it's
> > not a garbage?
> this is inherited from fastrpc(same is also used on DSP firmware) but I
> can rename it to something more meaningful like addr/va. This `pv` is
> used for offset calculation which eventually gives address of the page
> carrying the buffer. I can add checks when this calculation is done to
> ensure the pv is in proper range of the buffer passed by user.>

Don't inherit bad names. Don't use 'user virtual address' unless you
really mean __user. In the latter case the address must go through
access_ok() checks.

> >> +	/** @len: Length of the buffer in bytes */
> >> +	u64 len;
> >> +};
> >> +
> >> +/**
> >> + * union fastrpc_remote_arg - Remote argument (buffer or DMA handle)
> >> + */
> >> +union fastrpc_remote_arg {
> >> +	/** @buf: Inline buffer descriptor */
> >> +	struct fastrpc_remote_buf buf;
> >> +	/** @dma: DMA-BUF handle descriptor */
> >> +	struct fastrpc_remote_dmahandle dma;
> >> +};
> >> +
> >> +/**
> >> + * struct fastrpc_phy_page - Physical page descriptor
> >> + */
> >> +struct fastrpc_phy_page {
> >> +	/** @addr: Physical (IOMMU) address of the page */
> >> +	u64 addr;
> >> +	/** @size: Size of the contiguous region in bytes */
> >> +	u64 size;
> >> +};
> >> +
> >> +/**
> >> + * struct fastrpc_invoke_buf - Invoke buffer descriptor
> >> + */
> >> +struct fastrpc_invoke_buf {
> >> +	/** @num: Number of contiguous physical regions */
> >> +	u32 num;
> >> +	/** @pgidx: Index into the physical page array */
> >> +	u32 pgidx;
> >> +};
> >> +
> >> +/**
> >> + * struct fastrpc_msg - FastRPC wire message for remote invocations
> >> + *
> >> + * Sent to the remote processor via RPMsg. This is the exact layout
> >> + * the DSP expects; do not reorder or add fields without DSP firmware
> >> + * coordination.
> > 
> > __packed?
> I'll check more on this.>
> >> + */
> >> +struct fastrpc_msg {
> >> +	/** @remote_session_id: Session identifier on the remote processor */
> >> +	int remote_session_id;
> > 
> > Is it int or u32?
> This is again from fastrpc where it's a mix of int and s32. I'll keep it
> the to actual s32 here in QDA.>

Thanks. Also please stop using fastrpc_ prefix in the QDA driver.

> >> +	/** @tid: Thread ID of the invoking thread */
> >> +	int tid;
> >> +	/** @ctx: Context identifier for matching request/response */
> >> +	u64 ctx;
> >> +	/** @handle: Handle of the remote method to invoke */
> >> +	u32 handle;
> >> +	/** @sc: Scalars value encoding in/out buffer counts */
> >> +	u32 sc;
> >> +	/** @addr: Physical address of the message payload buffer */
> >> +	u64 addr;
> >> +	/** @size: Size of the message payload in bytes */
> >> +	u64 size;
> >> +};
> >> +
> >> +/**
> >> + * struct qda_fastrpc_invoke_ctx - Remote procedure call invocation context
> >> + *
> >> + * Maintains all state for a single remote procedure call, including buffer
> >> + * management, synchronisation, and result handling.
> >> + */
> >> +struct qda_fastrpc_invoke_ctx {
> >> +	/** @node: List node for linking contexts in a queue */
> >> +	struct list_head node;
> >> +	/** @qdev: Device owning the XArray this context is registered in */
> >> +	struct qda_dev *qdev;
> >> +	/** @ctxid: Unique context identifier (XArray key shifted left by 4) */
> > 
> > Why is it shifted by 4? Why not by 3?
> I'll add the PD encoding comment here.>

So, why?

> >> +	u64 ctxid;
> >> +	/** @inbufs: Number of input buffers */
> >> +	int inbufs;
> >> +	/** @nscalars: Total number of scalar arguments */
> >> +	int nscalars;
> >> +	/** @nbufs: Total number of buffer arguments (inbufs + outbufs) */
> >> +	int nbufs;
> >> +	/** @pid: Process ID of the calling process */
> >> +	int pid;
> >> +	/** @retval: Status code reported by the DSP for this invocation */
> >> +	int retval;
> >> +	/** @remote_session_id: Session identifier on the remote processor */
> >> +	int remote_session_id;
> > 
> > is pid linked to remote_session_id?
> not really, remote_session_id is more of session specific, so in case of
> multi-session(same PID having multiple sessions) should have different
> remote_session_id.>

Then drop the pid, please. You already have a session here.

> >> +	/** @pd: Protection domain identifier encoded into the context ID */
> > 
> > If it's already encoded, why do you need it here?c
> it's stores so the packing step can use it, I'll document more on this.
> Or if I can have both msg->fastrpc.ctx and ctxid same, I'll check that
> also>
> >> +	int pd;
> >> +	/** @type: Invocation type (e.g. FASTRPC_RMID_INVOKE_DYNAMIC) */
> >> +	u32 type;
> > 
> > What other types can exist?
> I'll add all the types in document or just add FASTRPC_RMID_* and point
> to qda_fastrpc.h for more details.>

Do we really need to support those in the first iteration? I think you
should have heart it several times: get the minimal sensible driver in.
You can add all the features afterwards.

> >> +	/** @sc: Scalars value encoding in/out buffer counts */
> >> +	u32 sc;
> > 
> > Remove it and calculate from in/outbufs above?
> The source of sc is the auto-generated stub file which passes this to
> remote_handle_invoke() based on the method requested by the user. This
> as is as it is passed to DSP where this is used in auto-generated skel.
> 
> I think the other way around(in/outbufs from sc) would make more sense.>

ok

> >> +	/** @handle: Handle of the remote method being invoked */
> >> +	u32 handle;
> >> +	/** @metalen: Length of the FastRPC metadata header in bytes */
> >> +	size_t metalen;
> >> +	/** @pkt_size: Total payload size in bytes */
> >> +	u64 pkt_size;
> >> +	/** @aligned_pkt_size: Page-aligned payload size for GEM allocation */
> > 
> > ???
> I'll check and remove this.>
> >> +	u64 aligned_pkt_size;
> >> +	/** @list: Array of invoke buffer descriptors */
> >> +	struct fastrpc_invoke_buf *list;
> >> +	/** @pages: Array of physical page descriptors for all arguments */
> >> +	struct fastrpc_phy_page *pages;
> >> +	/** @input_pages: Array of physical page descriptors for input buffers */
> >> +	struct fastrpc_phy_page *input_pages;
> >> +	/** @work: Completion used to synchronise with the DSP response */
> >> +	struct completion work;
> >> +	/** @msg: Pointer to the QDA message structure for this invocation */
> >> +	struct qda_msg *msg;
> >> +	/** @rpra: Array of remote procedure arguments */
> >> +	union fastrpc_remote_arg *rpra;
> >> +	/** @gem_objs: Array of GEM objects imported for argument buffers */
> >> +	struct drm_gem_object **gem_objs;
> >> +	/** @args: Invoke argument descriptors */
> >> +	struct drm_qda_fastrpc_invoke_args *args;
> >> +	/** @refcount: Reference counter for context lifetime management */
> > 
> > What for?
> just to ensure that the context is not freed in case the
> wait_for_completion() is interrupted.>

If it's not _interruptible, it can't be interrupted. Or there should be
a better description of the reasons.

> >> +	struct kref refcount;
> >> +	/** @msg_gem_obj: GEM object backing the message payload buffer */
> >> +	struct qda_gem_obj *msg_gem_obj;
> >> +	/** @file_priv: DRM file private data */
> >> +	struct drm_file *file_priv;
> >> +	/**
> >> +	 * @req: Request buffer for the internal init/map/unmap calls.  Points
> >> +	 * into a kernel-owned GEM mapping tracked by @gem_objs, so it must
> >> +	 * never be freed directly.
> >> +	 */
> >> +	void *req;
> > 
> > Why do you need separate pointers here? Can't you be getting them from
> > msm_gem_obj?
> These are typed pointers into different offsets of the kernel GEM
> mapping. I could compute them each time from `msg_gem_obj->virt +
> offset`, but caching them avoids repetitive casting. Let me see if
> removing this looks cleaner.>

Calculate them when necessary. If you use them in a few places, they
don't need to be cached.

> >> +	/** @rsp: Response buffer, same lifetime rules as @req */
> >> +	void *rsp;
> >> +	/** @inbuf: Process-create input buffer, same lifetime rules as @req */
> >> +	void *inbuf;
> >> +};
> >> +
> >> @@ -84,6 +88,44 @@ struct drm_qda_gem_mmap_offset {
> >>  	__u32 pad;
> >>  };
> >>  
> >> +/**
> >> + * struct drm_qda_fastrpc_invoke_args - FastRPC invocation argument descriptor
> >> + * @ptr: Pointer to argument data (user virtual address)
> > 
> > Why do you need it? Is handle + length not enough? If you want, specify
> > offset inside the GEM BO.
> The user VA (`ptr`) is needed because userspace mmaps the GEM BO and
> then passes pointers into it to the DSP. The kernel derives the offset
> within the BO from the VMA (via `calculate_vma_offset()`).
> 
> I can check if just passing handle + offset + length works here but that
> might require some userspace change.

You are going to have a different userspace. It must pass only
handle+offset+length triplets. All the rest must go to the compatibility
layers.


-- 
With best wishes
Dmitry
