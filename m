Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD9FC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA5BE10E40D;
	Mon, 24 Aug 2026 15:08:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fgy0aiJT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O82Nv49i";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4601A10E40D
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:08:01 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OCv5Cd2006677
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=Hyle+U8D28MC5G69uxudHerMnPCZoLVIe9KmF6dXIWY=; b=Fg
 y0aiJTpQixkyZPO2b2itaeD3NUAs8YOuMxrQsMwRWBVti1gbwm8Vr3MXZKRyI+tK
 i9ILfA6NvJl3KHdavmTVMMPtGLGQXXVUpuFzH+pKpxygR/yzDqtTBR+Yzg6G5gBG
 QlyKLbt+yUDPdTg49mBgMCfC7IsnD9poLmlSexGfLoPKkV2FVSrfXIRUd5jdd1aj
 2LQ6S05wqOhojN17K68WK2Ow0FOYD6ThnIcDQtjbJ+lpT2nUuhH282VnLj2jXuR8
 PqBdLyG6vpLrfBFqtmwdch6YQCGYBfCNP7QQ+p8WU7DD12GfYr6pdScNVovDHPvg
 WOagOogdwgfm6bL+8gsA==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kv799xa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:08:00 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-448bb8bcf38so11007621fac.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787584079; cv=none;
 d=google.com; s=arc-20260327;
 b=dc9JUlao9nMLDEnD+8ceYk+XxMwmB3SONXeC9wWs/MtHUuJVJ3rkz0D0CrHVGS2hP6
 2skna4Mi7JEwFHAIAnlo3WWGGdV7tp4l3a8LWldHWtS0isSfrdX7tIIzg+LzScwGHXSy
 647IbIj+tAgCoU3t0M/B353oyO0ZpFWcxDfef0SUtFTxLPXIrvTb5l8p970/ruKUUy+8
 J+g2C1o0UmaGpXupH6V1x05JxW60khQdP57ynhs0xzAJhta5O2ys+bEszAGSs9FQ8PJj
 A3v6PpW1qNAFY0rduMfcXJohSawo1pUxlOhhMN3dX2SMkilDOhm5hN//o8JOGOfeTaqQ
 QpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Hyle+U8D28MC5G69uxudHerMnPCZoLVIe9KmF6dXIWY=;
 fh=nWQ1UrFKTux/oxasSB14snJ/gO3djaAprO5wXk/a4sg=;
 b=PFkJSJflV6gR90tSDmP8Hmvzv272W7ZQQTtZVtLaEzbvvUOF9aEJvUf9TsTYparDeA
 k1qOP73amXfeUp9JMltQIwmXh8nOa6bxFkOvaOKv0tWdNtfXcmnGkA6KPB2ql53WXzxR
 GK1i9PQbwdP7MAjgWckLtmJaPQb1cct15DaK91EOIPQCO+clcLKHkvIBJGUIXzD7vfNL
 ubWOAbNJFckhYGgpJrJHsFVk9jRNcyP8oV1pLiRwlYW952NS6XWNb9MTXQVR1pu7g52e
 +1zG6U5ixVCbB36shMOKllvus/1oNaAFQTLqL5BvpqvpnDMJghXi1fhs6aGMXBMKqxZh
 gh2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787584079; x=1788188879;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Hyle+U8D28MC5G69uxudHerMnPCZoLVIe9KmF6dXIWY=;
 b=O82Nv49iVysgHkQzth4MrqTVBPg0PtNGAt14Kr6av98Svr9VE1sTM48A2HqDCdf7W5
 LJt82k3sK9zxBK0Ay0roSopYVM3y+LNLfs91SJaMsO2ot8uJGIQhSTGn8W5FyVku3Bhu
 2exkf9eB9sWS8MV+g0+1T8Of1mRmkKgmb4mugQ5UGZEXL1OvRDOYM0OSpnGB26dzOFsk
 uct9MjtQx3nQE9vKO/KVa3WigD35D2zt6et4kTqQSud/xwXSRAp5WlsKzyWk7foYPflO
 hNMu1Q9PioEWNsqrtkcHdaTc9ZjJQUDoDNchmMEW6WpVv7XhJ3pscrnEbSq+jJOzYUpW
 zWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787584079; x=1788188879;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hyle+U8D28MC5G69uxudHerMnPCZoLVIe9KmF6dXIWY=;
 b=ONRY1i1xDFy31fHJYYTfQ6b9TlbzlpFAZFSHSIdoSu0qzydCj/lYEThAKI3Tm+m+tp
 BFMCaZ9tfjy8wXT3l8HDjKnWJ7a+W5WkxzoFTZfVwxfjebKu4h5MJIKAultm5jOZQwTe
 iuEwbRyz0W8/JFZLhIBT0j5jXOeLazIqqyxDF94DmOgSIREUB0Fa+blvRlkCpP9CBK+P
 8nmdF4kW76NerxJcbCXiUUKnHS+z4ukRwKikzsmydFMjwy9ii2vEqykGUFHQzyQwW8ue
 /R30jQfGewEi5Q2/DZU+trcNwI0jvzOj6yCeYOpSOZhG9aGlJLnx1lCvy3rLlhCKLEuu
 aj8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXEp8ra6a56OApkax4dMXcQWxNq0NLEkkgyoxd5wvZPm0jK1M69B7gVXOq0V7/FGtLX9hkkLtI6Bk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nD9J5x/sGXQ2BTl3uX1vPCPYBiairTS3rDeYFUN8qfm4JByWgE
 N8kIe/Yuh+tzi7wc3GlwAGa+BMY7DfvdYsoXbDzS4yq2jbAPqQd0RM6OTbEH/pt8d5+af5djJkZ
 NYfvD4WnsFybhIK72Cb90QIb61jtIrDaYiedIyOMY48C0orHcJy3vAq/uRRfGTgbblFWlVQA9m9
 igf0Zu5S8hcU4+FaBqHxC1uBbcxo3TU74tJcuGi8G+u2bzxQ==
X-Gm-Gg: AR+sD13F1kL4rpvjPvXNF5Zqlm/DyieBaWSaZnEvZP5Qn0J3G4VnzGX+Lfj6vnvrb5H
 XCKODav/71nw3fvJeNIu7atFxIcRU/jDMCqu9bQQ5KSWeOshurLgwfKO8wN2kgcAynDE2OZzJ0A
 de4JCGxc3pdURDv8Zl4RjE95799SM7d60A/nNalol3zy/y13oX+xpyYnHI
X-Received: by 2002:a05:6870:b017:b0:430:7c2:9a30 with SMTP id
 586e51a60fabf-463514647d1mr23964540fac.15.1787584078949; 
 Mon, 24 Aug 2026 08:07:58 -0700 (PDT)
X-Received: by 2002:a05:6870:b017:b0:430:7c2:9a30 with SMTP id
 586e51a60fabf-463514647d1mr23964465fac.15.1787584078339; Mon, 24 Aug 2026
 08:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
 <7030a8f8-f320-4b09-b2de-2c8e897409f8@amd.com>
In-Reply-To: <7030a8f8-f320-4b09-b2de-2c8e897409f8@amd.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 08:07:45 -0700
X-Gm-Features: AcwNN1VFbqhhiJLvWH1NFcU6NtrCPGMII3xv7bbLUyQcFEp8F3pgy2kkKFrRtdE
Message-ID: <CACSVV00MubttbkVJgMommPMorf67yqn7D1kfwpxVUZ0t-6au8Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] accel/qda: Add DMA-backed GEM objects and memory
 manager integration
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Cfg4Irrl c=1 sm=1 tr=0 ts=6a8c5e50 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=zd2uoN0lAAAA:8 a=EUspDBNiAAAA:8
 a=ABG8zexEJSlfSB4JGioA:9 a=Me1utG3SuDqcFyGJ:21 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNyBTYWx0ZWRfX2/s3lE9DMs8I
 W6Pu5VB9fjrodEedree8aRfaTicZ3fTz9RMYruFtXlz+82U1C62y9UdfrkB7OGgGCmEEqkjN5N1
 rWS7tcMmZ24Hy3xTvZ4GUbk6v1LaKCo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNyBTYWx0ZWRfX+2VPhX1vYpOy
 NqzbRyWHCR7HQSm5pycVEhWVY1ICB3ms/oGCLM/6GuAGNmTPByHnCxXDFadLI8m0JyKYxN/isp7
 AWk4HIOWXHh+CChaxYsoDGn5vuxUPS/njDAyiII78oTJpUhZntY6z+2ucSbn9Cx5w4ceghcnRb5
 cdI4tSLTPowgGry9qcSAcdkNGUnQoyDSf1T3/1Q0zNVBHBIQWogsY0OnEuMmz2LelTLqBDqzNqa
 1RNYgPfbvSpPpeLHk+Ajz0nbQGq9CQBbgYlvgQxZm61s8kYBiqBMWBFWh0satw4raSjfk1jnZdp
 hOd2u7YXEP8UZyolkZX+AvlZmN+99rb/QLIqfUQZ7zo6U7bX22IP5kr0mncfw+Qwmf4VSXWQgbl
 XCOU21/mJRwcnlPUjLZTg0uSP2krpNEF9+9Ifan9TaDL2y+e1ttkA5WIf/trc/qsa/8Hmi/O2yB
 c3ElRr/QFRoVifO2yJA==
X-Proofpoint-ORIG-GUID: sVnwb9vSZ5CRfE4uBYd77GgHMDEzJtAg
X-Proofpoint-GUID: sVnwb9vSZ5CRfE4uBYd77GgHMDEzJtAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240127
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

On Mon, Aug 24, 2026 at 7:31=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 8/17/26 06:47, Ekansh Gupta wrote:
> > Introduce DMA-coherent buffer management for the QDA driver, wiring
> > together the GEM subsystem, the IOMMU memory manager, and a DMA
> > allocation backend.
> >
> > qda_gem.c / qda_gem.h
> >   Implements the GEM object lifecycle for QDA buffers. Each buffer is
> >   represented by a qda_gem_obj which embeds a drm_gem_object and
> >   carries the kernel virtual address, DMA address, and a pointer to
> >   the IOMMU device that performed the allocation. The .free callback
> >   delegates to the memory manager, and the .mmap callback uses
> >   dma_mmap_coherent() via the DMA backend.
> >
> > qda_memory_dma.c / qda_memory_dma.h
> >   DMA coherent allocation backend. qda_dma_alloc() calls
> >   dma_alloc_coherent() on the CB device and encodes the stream ID
> >   (SID) in the upper 32 bits of the returned DMA address, following
> >   the Qualcomm FastRPC convention for IOMMU address space tagging.
> >   qda_dma_free() strips the SID prefix before calling
> >   dma_free_coherent().
> >
> > qda_memory_manager.c
> >   Adds process-to-device assignment: each DRM file (process) is
> >   assigned one IOMMU context bank device for the lifetime of the
> >   session. qda_memory_manager_assign_device() first checks whether
> >   the process already has a device (reusing it with a refcount
> >   increment), then falls back to claiming an unassigned device.
> >   qda_memory_manager_alloc() and qda_memory_manager_free() delegate
> >   to the DMA backend after resolving the correct CB device for the
> >   calling process.
>
> Oh, stuff like that is usually a pretty big NO-GO now.
>
> AMD has made the same mistake with KFD and it resulted in a massive chaos=
.
>
> The DRM file is the driver context your process uses and even if there ar=
e multiple DRM files for the same PID you should absolute *NOT* share anyth=
ing between them.
>
> The general rule of thumb is to not attach anything to the process using =
the DRM file descriptor.

A couple other things to keep in mind:

1. drm device fd can be passed across processes
2. virtgpu/virglrenderer drm native ctx is a single process that opens
the drm device file N times on behalf of N guest userspace processes.

All that to say, Christian is right here.. drm_file is your context,
pgtables should be attached to the drm_file (potentially via
drm_gpuvm.. which you perhaps want to use).

BR,
-R

> Regards,
> Christian.
>
> >
> > qda_drv.c / qda_drv.h
> >   qda_file_priv gains an assigned_iommu_dev pointer and a pid field.
> >   The .postclose callback decrements the IOMMU device refcount and
> >   clears the process assignment when the last reference is dropped.
> >
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > - Adapt to the dynamically-sized device array introduced in patch 07
> >   (kcalloc'd from DT node count, replaces fixed QDA_IOMMU_DEVICES_MAX)
> > - Protect register/unregister with the process_assignment_lock mutex so
> >   the device-assignment and device-registration paths are serialised
> > - No functional changes requested by reviewers on this patch
> > ---
> >  drivers/accel/qda/Makefile             |   2 +
> >  drivers/accel/qda/qda_drv.c            |   4 +
> >  drivers/accel/qda/qda_drv.h            |   4 +
> >  drivers/accel/qda/qda_gem.c            | 134 ++++++++++++++++++
> >  drivers/accel/qda/qda_gem.h            |  52 +++++++
> >  drivers/accel/qda/qda_memory_dma.c     |  82 +++++++++++
> >  drivers/accel/qda/qda_memory_dma.h     |  17 +++
> >  drivers/accel/qda/qda_memory_manager.c | 239 +++++++++++++++++++++++++=
+++++++-
> >  drivers/accel/qda/qda_memory_manager.h |  30 +++++
> >  9 files changed, 559 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> > index b658dad35fee..a46ddceecfc5 100644
> > --- a/drivers/accel/qda/Makefile
> > +++ b/drivers/accel/qda/Makefile
> > @@ -8,7 +8,9 @@ obj-$(CONFIG_DRM_ACCEL_QDA)   :=3D qda.o
> >  qda-y :=3D \
> >       qda_cb.o \
> >       qda_drv.o \
> > +     qda_gem.o \
> >       qda_ioctl.o \
> > +     qda_memory_dma.o \
> >       qda_memory_manager.o \
> >       qda_rpmsg.o
> >
> > diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> > index e1fd8bfa12d7..2b14dab95507 100644
> > --- a/drivers/accel/qda/qda_drv.c
> > +++ b/drivers/accel/qda/qda_drv.c
> > @@ -21,6 +21,7 @@ static int qda_open(struct drm_device *dev, struct dr=
m_file *file)
> >       if (!qda_file_priv)
> >               return -ENOMEM;
> >
> > +     qda_file_priv->pid =3D current->pid;
> >       qda_file_priv->qda_dev =3D qda_dev_from_drm(dev);
> >       file->driver_priv =3D qda_file_priv;
> >
> > @@ -31,6 +32,9 @@ static void qda_postclose(struct drm_device *dev, str=
uct drm_file *file)
> >  {
> >       struct qda_file_priv *qda_file_priv =3D file->driver_priv;
> >
> > +     if (qda_file_priv->assigned_iommu_dev)
> > +             qda_memory_manager_release_device(qda_file_priv->assigned=
_iommu_dev);
> > +
> >       kfree(qda_file_priv);
> >       file->driver_priv =3D NULL;
> >  }
> > diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
> > index 690a833d732b..2fe58f3efec0 100644
> > --- a/drivers/accel/qda/qda_drv.h
> > +++ b/drivers/accel/qda/qda_drv.h
> > @@ -24,6 +24,10 @@
> >  struct qda_file_priv {
> >       /** @qda_dev: Back-pointer to device structure */
> >       struct qda_dev *qda_dev;
> > +     /** @assigned_iommu_dev: IOMMU device assigned to this process */
> > +     struct qda_iommu_device *assigned_iommu_dev;
> > +     /** @pid: Process ID for tracking */
> > +     pid_t pid;
> >  };
> >
> >  /**
> > diff --git a/drivers/accel/qda/qda_gem.c b/drivers/accel/qda/qda_gem.c
> > new file mode 100644
> > index 000000000000..66e78013a726
> > --- /dev/null
> > +++ b/drivers/accel/qda/qda_gem.c
> > @@ -0,0 +1,134 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > +#include <drm/drm_gem.h>
> > +#include <drm/drm_prime.h>
> > +#include <drm/drm_print.h>
> > +#include <linux/slab.h>
> > +#include <linux/dma-mapping.h>
> > +#include "qda_drv.h"
> > +#include "qda_gem.h"
> > +#include "qda_memory_manager.h"
> > +#include "qda_memory_dma.h"
> > +
> > +/**
> > + * qda_gem_free_object() - Free a GEM object and its associated resour=
ces
> > + * @gem_obj: DRM GEM object to free
> > + */
> > +void qda_gem_free_object(struct drm_gem_object *gem_obj)
> > +{
> > +     struct qda_gem_obj *qda_gem_obj =3D to_qda_gem_obj(gem_obj);
> > +     struct qda_dev *qdev =3D qda_dev_from_drm(gem_obj->dev);
> > +
> > +     if (qda_gem_obj->virt && qdev->iommu_mgr)
> > +             qda_memory_manager_free(qdev->iommu_mgr, qda_gem_obj);
> > +
> > +     drm_gem_object_release(gem_obj);
> > +     kfree(qda_gem_obj);
> > +}
> > +
> > +/**
> > + * qda_gem_mmap_obj() - Map a GEM object into userspace
> > + * @drm_obj: DRM GEM object to map
> > + * @vma: Virtual memory area to map into
> > + *
> > + * Return: 0 on success, negative error code on failure
> > + */
> > +int qda_gem_mmap_obj(struct drm_gem_object *drm_obj, struct vm_area_st=
ruct *vma)
> > +{
> > +     struct qda_gem_obj *qda_gem_obj =3D to_qda_gem_obj(drm_obj);
> > +     int ret;
> > +
> > +     /* The fake offset is only used to find the object, not to index =
it */
> > +     vma->vm_pgoff =3D 0;
> > +
> > +     ret =3D qda_dma_mmap(qda_gem_obj, vma);
> > +     if (ret)
> > +             return ret;
> > +
> > +     vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct drm_gem_object_funcs qda_gem_object_funcs =3D {
> > +     .free =3D qda_gem_free_object,
> > +     .mmap =3D qda_gem_mmap_obj,
> > +};
> > +
> > +/**
> > + * qda_gem_alloc_object() - Allocate a new QDA GEM object
> > + * @drm_dev: DRM device
> > + * @aligned_size: Size of the object in bytes (must be page-aligned)
> > + *
> > + * Return: Pointer to the new GEM object, or ERR_PTR on failure
> > + */
> > +struct qda_gem_obj *qda_gem_alloc_object(struct drm_device *drm_dev, s=
ize_t aligned_size)
> > +{
> > +     struct qda_gem_obj *qda_gem_obj;
> > +     int ret;
> > +
> > +     qda_gem_obj =3D kzalloc_obj(*qda_gem_obj);
> > +     if (!qda_gem_obj)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     ret =3D drm_gem_object_init(drm_dev, &qda_gem_obj->base, aligned_=
size);
> > +     if (ret) {
> > +             kfree(qda_gem_obj);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> > +     qda_gem_obj->base.funcs =3D &qda_gem_object_funcs;
> > +     qda_gem_obj->size =3D aligned_size;
> > +
> > +     return qda_gem_obj;
> > +}
> > +
> > +void qda_gem_cleanup_object(struct qda_gem_obj *qda_gem_obj)
> > +{
> > +     drm_gem_object_release(&qda_gem_obj->base);
> > +     kfree(qda_gem_obj);
> > +}
> > +
> > +int qda_gem_create_handle(struct drm_file *file_priv, struct drm_gem_o=
bject *gem_obj, u32 *handle)
> > +{
> > +     int ret;
> > +
> > +     ret =3D drm_gem_handle_create(file_priv, gem_obj, handle);
> > +     drm_gem_object_put(gem_obj);
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * qda_gem_create_object() - Allocate and initialize a GEM object with=
 DMA backing
> > + * @drm_dev: DRM device
> > + * @iommu_mgr: Memory manager to use for DMA allocation
> > + * @size: Requested size in bytes
> > + * @file_priv: DRM file private data for process association
> > + *
> > + * Return: Pointer to the base DRM GEM object on success, ERR_PTR on f=
ailure
> > + */
> > +struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_de=
v,
> > +                                          struct qda_memory_manager *i=
ommu_mgr, size_t size,
> > +                                          struct drm_file *file_priv)
> > +{
> > +     struct qda_gem_obj *qda_gem_obj;
> > +     size_t aligned_size;
> > +     int ret;
> > +
> > +     aligned_size =3D PAGE_ALIGN(size);
> > +     if (!aligned_size)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     qda_gem_obj =3D qda_gem_alloc_object(drm_dev, aligned_size);
> > +     if (IS_ERR(qda_gem_obj))
> > +             return ERR_CAST(qda_gem_obj);
> > +
> > +     ret =3D qda_memory_manager_alloc(iommu_mgr, qda_gem_obj, file_pri=
v);
> > +     if (ret) {
> > +             qda_gem_cleanup_object(qda_gem_obj);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> > +     return &qda_gem_obj->base;
> > +}
> > diff --git a/drivers/accel/qda/qda_gem.h b/drivers/accel/qda/qda_gem.h
> > new file mode 100644
> > index 000000000000..afd7c9b49549
> > --- /dev/null
> > +++ b/drivers/accel/qda/qda_gem.h
> > @@ -0,0 +1,52 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +#ifndef __QDA_GEM_H__
> > +#define __QDA_GEM_H__
> > +
> > +#include <linux/dma-mapping.h>
> > +#include <drm/drm_device.h>
> > +#include <drm/drm_gem.h>
> > +#include "qda_memory_manager.h"
> > +
> > +/**
> > + * struct qda_gem_obj - QDA GEM buffer object
> > + *
> > + * Represents a GEM buffer object that can be allocated by the driver
> > + * or imported from another driver via DMA-BUF.
> > + */
> > +struct qda_gem_obj {
> > +     /** @base: DRM GEM object base =E2=80=94 must be first member */
> > +     struct drm_gem_object base;
> > +     /** @iommu_dev: IOMMU context bank device that performed the allo=
cation */
> > +     struct qda_iommu_device *iommu_dev;
> > +     /** @virt: Kernel virtual address of the allocated DMA memory */
> > +     void *virt;
> > +     /** @dma_addr: DMA address (with SID encoded in upper 32 bits) */
> > +     dma_addr_t dma_addr;
> > +     /** @size: Size of the buffer in bytes */
> > +     size_t size;
> > +};
> > +
> > +/**
> > + * to_qda_gem_obj - Cast a drm_gem_object pointer to qda_gem_obj
> > + * @gem_obj: Pointer to the embedded drm_gem_object
> > + */
> > +#define to_qda_gem_obj(gem_obj) container_of(gem_obj, struct qda_gem_o=
bj, base)
> > +
> > +/* GEM object lifecycle */
> > +struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_de=
v,
> > +                                          struct qda_memory_manager *i=
ommu_mgr,
> > +                                          size_t size, struct drm_file=
 *file_priv);
> > +void qda_gem_free_object(struct drm_gem_object *gem_obj);
> > +int qda_gem_mmap_obj(struct drm_gem_object *gem_obj, struct vm_area_st=
ruct *vma);
> > +
> > +/* Internal helpers (also used by PRIME import) */
> > +struct qda_gem_obj *qda_gem_alloc_object(struct drm_device *drm_dev, s=
ize_t aligned_size);
> > +void qda_gem_cleanup_object(struct qda_gem_obj *qda_gem_obj);
> > +
> > +/* Utility functions */
> > +int qda_gem_create_handle(struct drm_file *file_priv, struct drm_gem_o=
bject *gem_obj, u32 *handle);
> > +
> > +#endif /* __QDA_GEM_H__ */
> > diff --git a/drivers/accel/qda/qda_memory_dma.c b/drivers/accel/qda/qda=
_memory_dma.c
> > new file mode 100644
> > index 000000000000..7072ed8edf0b
> > --- /dev/null
> > +++ b/drivers/accel/qda/qda_memory_dma.c
> > @@ -0,0 +1,82 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > +#include <linux/slab.h>
> > +#include <linux/dma-mapping.h>
> > +#include "qda_drv.h"
> > +#include "qda_gem.h"
> > +#include "qda_memory_dma.h"
> > +
> > +/*
> > + * The DSP identifies the IOMMU context bank from the upper bits of th=
e address,
> > + * so the stream ID is folded into every address handed to it. The DMA=
 API only
> > + * ever sees the plain 32-bit address, which is why the context bank d=
evices are
> > + * created with a 32-bit DMA mask.
> > + */
> > +static dma_addr_t get_actual_dma_addr(struct qda_gem_obj *gem_obj)
> > +{
> > +     return gem_obj->dma_addr - ((u64)gem_obj->iommu_dev->sid << 32);
> > +}
> > +
> > +static void setup_gem_object(struct qda_gem_obj *gem_obj, void *virt,
> > +                          dma_addr_t dma_addr, struct qda_iommu_device=
 *iommu_dev)
> > +{
> > +     gem_obj->virt =3D virt;
> > +     gem_obj->dma_addr =3D dma_addr;
> > +     gem_obj->iommu_dev =3D iommu_dev;
> > +}
> > +
> > +static void cleanup_gem_object_fields(struct qda_gem_obj *gem_obj)
> > +{
> > +     gem_obj->virt =3D NULL;
> > +     gem_obj->dma_addr =3D 0;
> > +     gem_obj->iommu_dev =3D NULL;
> > +}
> > +
> > +/**
> > + * qda_dma_alloc() - Allocate DMA coherent memory for a GEM object
> > + * @iommu_dev: Pointer to the QDA IOMMU device structure
> > + * @gem_obj: Pointer to GEM object to allocate memory for
> > + * @size: Size of memory to allocate in bytes
> > + *
> > + * Return: 0 on success, negative error code on failure
> > + */
> > +int qda_dma_alloc(struct qda_iommu_device *iommu_dev,
> > +               struct qda_gem_obj *gem_obj, size_t size)
> > +{
> > +     dma_addr_t dma_addr;
> > +     void *virt;
> > +
> > +     virt =3D dma_alloc_coherent(iommu_dev->dev, size, &dma_addr, GFP_=
KERNEL);
> > +     if (!virt)
> > +             return -ENOMEM;
> > +
> > +     dma_addr +=3D ((u64)iommu_dev->sid << 32);
> > +     setup_gem_object(gem_obj, virt, dma_addr, iommu_dev);
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * qda_dma_free() - Free DMA coherent memory for a GEM object
> > + * @gem_obj: Pointer to GEM object to free memory for
> > + */
> > +void qda_dma_free(struct qda_gem_obj *gem_obj)
> > +{
> > +     dma_free_coherent(gem_obj->iommu_dev->dev, gem_obj->size,
> > +                       gem_obj->virt, get_actual_dma_addr(gem_obj));
> > +
> > +     cleanup_gem_object_fields(gem_obj);
> > +}
> > +
> > +/**
> > + * qda_dma_mmap() - Map DMA memory into userspace
> > + * @gem_obj: Pointer to GEM object containing DMA memory
> > + * @vma: Virtual memory area to map into
> > + *
> > + * Return: 0 on success, negative error code on failure
> > + */
> > +int qda_dma_mmap(struct qda_gem_obj *gem_obj, struct vm_area_struct *v=
ma)
> > +{
> > +     return dma_mmap_coherent(gem_obj->iommu_dev->dev, vma, gem_obj->v=
irt,
> > +                              get_actual_dma_addr(gem_obj), gem_obj->s=
ize);
> > +}
> > diff --git a/drivers/accel/qda/qda_memory_dma.h b/drivers/accel/qda/qda=
_memory_dma.h
> > new file mode 100644
> > index 000000000000..99352a99dc33
> > --- /dev/null
> > +++ b/drivers/accel/qda/qda_memory_dma.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#ifndef __QDA_MEMORY_DMA_H__
> > +#define __QDA_MEMORY_DMA_H__
> > +
> > +#include <linux/dma-mapping.h>
> > +#include "qda_memory_manager.h"
> > +
> > +int qda_dma_alloc(struct qda_iommu_device *iommu_dev,
> > +               struct qda_gem_obj *gem_obj, size_t size);
> > +void qda_dma_free(struct qda_gem_obj *gem_obj);
> > +int qda_dma_mmap(struct qda_gem_obj *gem_obj, struct vm_area_struct *v=
ma);
> > +
> > +#endif /* __QDA_MEMORY_DMA_H__ */
> > diff --git a/drivers/accel/qda/qda_memory_manager.c b/drivers/accel/qda=
/qda_memory_manager.c
> > index b1a80ee77c35..d47c7419e11d 100644
> > --- a/drivers/accel/qda/qda_memory_manager.c
> > +++ b/drivers/accel/qda/qda_memory_manager.c
> > @@ -1,14 +1,26 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  // Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> >
> > +#include <linux/refcount.h>
> >  #include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <drm/drm_file.h>
> > +#include <drm/drm_print.h>
> >  #include "qda_drv.h"
> > +#include "qda_gem.h"
> >  #include "qda_memory_manager.h"
> > +#include "qda_memory_dma.h"
> > +
> > +static void iommu_device_free(struct kref *ref)
> > +{
> > +     kfree(container_of(ref, struct qda_iommu_device, ref));
> > +}
> >
> >  static void cleanup_all_memory_devices(struct qda_memory_manager *mem_=
mgr)
> >  {
> >       int i;
> >
> > +     mutex_lock(&mem_mgr->process_assignment_lock);
> >       for (i =3D 0; i < mem_mgr->num_devices; i++) {
> >               struct qda_iommu_device *iommu_dev =3D mem_mgr->devices[i=
];
> >
> > @@ -16,9 +28,215 @@ static void cleanup_all_memory_devices(struct qda_m=
emory_manager *mem_mgr)
> >                       continue;
> >
> >               mem_mgr->devices[i] =3D NULL;
> > -             kfree(iommu_dev);
> > +             kref_put(&iommu_dev->ref, iommu_device_free);
> >       }
> >       mem_mgr->num_devices =3D 0;
> > +     mutex_unlock(&mem_mgr->process_assignment_lock);
> > +}
> > +
> > +static void init_iommu_device_fields(struct qda_iommu_device *iommu_de=
v)
> > +{
> > +     spin_lock_init(&iommu_dev->lock);
> > +     refcount_set(&iommu_dev->users, 0);
> > +     kref_init(&iommu_dev->ref);
> > +     iommu_dev->assigned_pid =3D 0;
> > +     iommu_dev->assigned_file_priv =3D NULL;
> > +}
> > +
> > +static struct qda_iommu_device *find_device_for_pid(struct qda_memory_=
manager *mem_mgr,
> > +                                                 pid_t pid)
> > +{
> > +     struct qda_iommu_device *found_dev =3D NULL;
> > +     unsigned long flags;
> > +     int i;
> > +
> > +     for (i =3D 0; i < mem_mgr->num_devices; i++) {
> > +             struct qda_iommu_device *iommu_dev =3D mem_mgr->devices[i=
];
> > +
> > +             if (!iommu_dev)
> > +                     continue;
> > +
> > +             spin_lock_irqsave(&iommu_dev->lock, flags);
> > +             if (iommu_dev->assigned_pid =3D=3D pid) {
> > +                     found_dev =3D iommu_dev;
> > +                     refcount_inc(&found_dev->users);
> > +                     kref_get(&found_dev->ref);
> > +                     spin_unlock_irqrestore(&iommu_dev->lock, flags);
> > +                     break;
> > +             }
> > +             spin_unlock_irqrestore(&iommu_dev->lock, flags);
> > +     }
> > +
> > +     return found_dev;
> > +}
> > +
> > +static struct qda_iommu_device *assign_available_device_to_pid(struct =
qda_memory_manager *mem_mgr,
> > +                                                            pid_t pid,
> > +                                                            struct drm=
_file *file_priv)
> > +{
> > +     struct qda_iommu_device *selected_dev =3D NULL;
> > +     unsigned long flags;
> > +     int i;
> > +
> > +     for (i =3D 0; i < mem_mgr->num_devices; i++) {
> > +             struct qda_iommu_device *iommu_dev =3D mem_mgr->devices[i=
];
> > +
> > +             if (!iommu_dev)
> > +                     continue;
> > +
> > +             spin_lock_irqsave(&iommu_dev->lock, flags);
> > +             if (iommu_dev->assigned_pid =3D=3D 0) {
> > +                     iommu_dev->assigned_pid =3D pid;
> > +                     iommu_dev->assigned_file_priv =3D file_priv;
> > +                     selected_dev =3D iommu_dev;
> > +                     refcount_set(&selected_dev->users, 1);
> > +                     kref_get(&selected_dev->ref);
> > +                     spin_unlock_irqrestore(&iommu_dev->lock, flags);
> > +                     break;
> > +             }
> > +             spin_unlock_irqrestore(&iommu_dev->lock, flags);
> > +     }
> > +
> > +     return selected_dev;
> > +}
> > +
> > +static struct qda_iommu_device *get_process_iommu_device(struct qda_me=
mory_manager *mem_mgr,
> > +                                                      struct drm_file =
*file_priv)
> > +{
> > +     struct qda_file_priv *qda_priv;
> > +
> > +     if (!file_priv || !file_priv->driver_priv)
> > +             return NULL;
> > +
> > +     qda_priv =3D (struct qda_file_priv *)file_priv->driver_priv;
> > +     return qda_priv->assigned_iommu_dev;
> > +}
> > +
> > +/**
> > + * qda_memory_manager_assign_device() - Assign an IOMMU device to a pr=
ocess
> > + * @mem_mgr: Pointer to memory manager
> > + * @file_priv: DRM file private data for process association
> > + *
> > + * On success the caller owns a reference on the device and must relea=
se it
> > + * with qda_memory_manager_release_device().
> > + *
> > + * Return: 0 on success, negative error code on failure
> > + */
> > +int qda_memory_manager_assign_device(struct qda_memory_manager *mem_mg=
r,
> > +                                  struct drm_file *file_priv)
> > +{
> > +     struct qda_file_priv *qda_priv;
> > +     struct qda_iommu_device *selected_dev =3D NULL;
> > +     int ret =3D 0;
> > +     pid_t current_pid;
> > +
> > +     if (!file_priv || !file_priv->driver_priv)
> > +             return -EINVAL;
> > +
> > +     qda_priv =3D (struct qda_file_priv *)file_priv->driver_priv;
> > +     current_pid =3D qda_priv->pid;
> > +
> > +     mutex_lock(&mem_mgr->process_assignment_lock);
> > +
> > +     if (qda_priv->assigned_iommu_dev) {
> > +             ret =3D 0;
> > +             goto unlock_and_return;
> > +     }
> > +
> > +     selected_dev =3D find_device_for_pid(mem_mgr, current_pid);
> > +
> > +     if (selected_dev) {
> > +             qda_priv->assigned_iommu_dev =3D selected_dev;
> > +             goto unlock_and_return;
> > +     }
> > +
> > +     selected_dev =3D assign_available_device_to_pid(mem_mgr, current_=
pid, file_priv);
> > +
> > +     if (!selected_dev) {
> > +             drm_dbg_driver(file_priv->minor->dev, "No context bank av=
ailable for PID %d\n",
> > +                            current_pid);
> > +             ret =3D -EBUSY;
> > +             goto unlock_and_return;
> > +     }
> > +
> > +     qda_priv->assigned_iommu_dev =3D selected_dev;
> > +
> > +unlock_and_return:
> > +     mutex_unlock(&mem_mgr->process_assignment_lock);
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * qda_memory_manager_release_device() - Release a process assignment
> > + * @iommu_dev: Device previously obtained from qda_memory_manager_assi=
gn_device()
> > + *
> > + * Drops the caller's reference. Once the last process using the devic=
e is
> > + * gone the assignment is cleared so the device can serve another proc=
ess.
> > + */
> > +void qda_memory_manager_release_device(struct qda_iommu_device *iommu_=
dev)
> > +{
> > +     unsigned long flags;
> > +
> > +     if (refcount_dec_and_test(&iommu_dev->users)) {
> > +             spin_lock_irqsave(&iommu_dev->lock, flags);
> > +             iommu_dev->assigned_pid =3D 0;
> > +             iommu_dev->assigned_file_priv =3D NULL;
> > +             spin_unlock_irqrestore(&iommu_dev->lock, flags);
> > +     }
> > +
> > +     kref_put(&iommu_dev->ref, iommu_device_free);
> > +}
> > +
> > +static struct qda_iommu_device *get_or_assign_iommu_device(struct qda_=
memory_manager *mem_mgr,
> > +                                                        struct drm_fil=
e *file_priv)
> > +{
> > +     struct qda_iommu_device *iommu_dev;
> > +     int ret;
> > +
> > +     iommu_dev =3D get_process_iommu_device(mem_mgr, file_priv);
> > +     if (iommu_dev)
> > +             return iommu_dev;
> > +
> > +     ret =3D qda_memory_manager_assign_device(mem_mgr, file_priv);
> > +     if (ret)
> > +             return NULL;
> > +
> > +     iommu_dev =3D get_process_iommu_device(mem_mgr, file_priv);
> > +     if (iommu_dev)
> > +             return iommu_dev;
> > +
> > +     return NULL;
> > +}
> > +
> > +/**
> > + * qda_memory_manager_alloc() - Allocate memory for a GEM object
> > + * @mem_mgr: Pointer to memory manager
> > + * @gem_obj: Pointer to GEM object to allocate memory for
> > + * @file_priv: DRM file private data for process association
> > + *
> > + * Return: 0 on success, negative error code on failure
> > + */
> > +int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr, struc=
t qda_gem_obj *gem_obj,
> > +                          struct drm_file *file_priv)
> > +{
> > +     struct qda_iommu_device *selected_dev;
> > +
> > +     selected_dev =3D get_or_assign_iommu_device(mem_mgr, file_priv);
> > +     if (!selected_dev)
> > +             return -EBUSY;
> > +
> > +     return qda_dma_alloc(selected_dev, gem_obj, gem_obj->size);
> > +}
> > +
> > +/**
> > + * qda_memory_manager_free() - Free memory for a GEM object
> > + * @mem_mgr: Pointer to memory manager
> > + * @gem_obj: Pointer to GEM object to free memory for
> > + */
> > +void qda_memory_manager_free(struct qda_memory_manager *mem_mgr, struc=
t qda_gem_obj *gem_obj)
> > +{
> > +     qda_dma_free(gem_obj);
> >  }
> >
> >  /**
> > @@ -31,13 +249,21 @@ static void cleanup_all_memory_devices(struct qda_=
memory_manager *mem_mgr)
> >  int qda_memory_manager_register_device(struct qda_memory_manager *mem_=
mgr,
> >                                      struct qda_iommu_device *iommu_dev=
)
> >  {
> > -     if (mem_mgr->num_devices >=3D mem_mgr->max_devices)
> > -             return -ENOSPC;
> > +     int ret =3D 0;
> >
> > +     mutex_lock(&mem_mgr->process_assignment_lock);
> > +     if (mem_mgr->num_devices >=3D mem_mgr->max_devices) {
> > +             ret =3D -ENOSPC;
> > +             goto out;
> > +     }
> > +
> > +     init_iommu_device_fields(iommu_dev);
> >       iommu_dev->id =3D mem_mgr->num_devices;
> >       mem_mgr->devices[mem_mgr->num_devices++] =3D iommu_dev;
> >
> > -     return 0;
> > +out:
> > +     mutex_unlock(&mem_mgr->process_assignment_lock);
> > +     return ret;
> >  }
> >
> >  /**
> > @@ -52,14 +278,16 @@ void qda_memory_manager_unregister_device(struct q=
da_memory_manager *mem_mgr,
> >  {
> >       int i;
> >
> > +     mutex_lock(&mem_mgr->process_assignment_lock);
> >       for (i =3D 0; i < mem_mgr->num_devices; i++) {
> >               if (mem_mgr->devices[i] =3D=3D iommu_dev) {
> >                       mem_mgr->devices[i] =3D NULL;
> >                       break;
> >               }
> >       }
> > +     mutex_unlock(&mem_mgr->process_assignment_lock);
> >
> > -     kfree(iommu_dev);
> > +     kref_put(&iommu_dev->ref, iommu_device_free);
> >  }
> >
> >  /**
> > @@ -80,6 +308,7 @@ int qda_memory_manager_init(struct qda_memory_manage=
r *mem_mgr, int max_devices)
> >
> >       mem_mgr->num_devices =3D 0;
> >       mem_mgr->max_devices =3D max_devices;
> > +     mutex_init(&mem_mgr->process_assignment_lock);
> >
> >       return 0;
> >  }
> > diff --git a/drivers/accel/qda/qda_memory_manager.h b/drivers/accel/qda=
/qda_memory_manager.h
> > index 7e38c8a18284..0949c0c213f6 100644
> > --- a/drivers/accel/qda/qda_memory_manager.h
> > +++ b/drivers/accel/qda/qda_memory_manager.h
> > @@ -7,25 +7,44 @@
> >  #define __QDA_MEMORY_MANAGER_H__
> >
> >  #include <linux/device.h>
> > +#include <linux/kref.h>
> > +#include <linux/mutex.h>
> > +#include <linux/refcount.h>
> > +#include <linux/spinlock.h>
> > +#include <drm/drm_file.h>
> >
> >  /* Forward declarations */
> >  struct qda_dev;
> > +struct qda_gem_obj;
> >
> >  /**
> >   * struct qda_iommu_device - IOMMU device instance for memory manageme=
nt
> >   *
> >   * Represents a single IOMMU-enabled device managed by the memory mana=
ger.
> >   * Each device can be assigned to a specific process session.
> > + *
> > + * The object outlives its registration: open files keep a reference t=
hrough
> > + * @ref, so a device can be unregistered while a process still holds i=
t.
> >   */
> >  struct qda_iommu_device {
> >       /** @dev: Pointer to the underlying device */
> >       struct device *dev;
> >       /** @qdev: Back-pointer to the parent QDA device */
> >       struct qda_dev *qdev;
> > +     /** @assigned_file_priv: DRM file private data for the assigned p=
rocess */
> > +     struct drm_file *assigned_file_priv;
> >       /** @id: Unique identifier assigned by the memory manager */
> >       u32 id;
> >       /** @sid: Stream ID for IOMMU transactions */
> >       u32 sid;
> > +     /** @assigned_pid: Process ID of the process assigned to this dev=
ice */
> > +     pid_t assigned_pid;
> > +     /** @users: Number of open files sharing this device */
> > +     refcount_t users;
> > +     /** @ref: Reference count controlling when the object is freed */
> > +     struct kref ref;
> > +     /** @lock: Spinlock protecting concurrent access to device */
> > +     spinlock_t lock;
> >  };
> >
> >  /**
> > @@ -42,6 +61,8 @@ struct qda_memory_manager {
> >       int num_devices;
> >       /** @max_devices: Capacity of the @devices array */
> >       int max_devices;
> > +     /** @process_assignment_lock: Mutex protecting process-to-device =
assignments */
> > +     struct mutex process_assignment_lock;
> >  };
> >
> >  int qda_memory_manager_init(struct qda_memory_manager *mem_mgr, int ma=
x_devices);
> > @@ -51,5 +72,14 @@ int qda_memory_manager_register_device(struct qda_me=
mory_manager *mem_mgr,
> >                                      struct qda_iommu_device *iommu_dev=
);
> >  void qda_memory_manager_unregister_device(struct qda_memory_manager *m=
em_mgr,
> >                                         struct qda_iommu_device *iommu_=
dev);
> > +int qda_memory_manager_assign_device(struct qda_memory_manager *mem_mg=
r,
> > +                                  struct drm_file *file_priv);
> > +void qda_memory_manager_release_device(struct qda_iommu_device *iommu_=
dev);
> > +
> > +int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr,
> > +                          struct qda_gem_obj *gem_obj,
> > +                          struct drm_file *file_priv);
> > +void qda_memory_manager_free(struct qda_memory_manager *mem_mgr,
> > +                          struct qda_gem_obj *gem_obj);
> >
> >  #endif /* __QDA_MEMORY_MANAGER_H__ */
> >
>
