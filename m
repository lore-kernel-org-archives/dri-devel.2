Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03256EA719B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 13:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 487D910E3D2;
	Sun, 19 Apr 2026 13:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFOd3KzE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dfDh9Gqh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B02D10E3D2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 13:19:39 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63INeJi73728218
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 13:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=EFEbVjsG/sMNcfIwunoNEXRA
 cnnBUNfXQiMwhzLe2YE=; b=IFOd3KzE874deenjw2eZtlDu7eCGbbk0c2MXRDTo
 M+h8nADAOTLqMlIhsR/MqkA4wQV7jioIpSIfJ2C3pVF6hSffstVXa49Hc+DtnQ/n
 C9b4Alci0El6FRhr/Q2vSkxBWCql55mPi5u+c/410YsE6UwRyeInykyGMzYTTxMq
 hoLNIGDE2+GaiO2oRe9PR+R6FYIlffcLt+6Qa9uPJ1ZzT8+na8jizVj5Upq/3z3q
 UqqriJvd6o6aUKiE0xv5QA7OsztDnrzbfYhKtRS2tAj5FhFYetz37PHAO43jDEo5
 U0sGiYc2BmIhjA/Aj7OrkxgvXqmp11kz8uIhgsWDkn5Lbw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm21ujhjt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 13:19:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-358e95e81aeso4949470a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 06:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776604777; cv=none;
 d=google.com; s=arc-20240605;
 b=BtWx19AEGEtLWbecxBMPlfUGPDNav+WmhyIy9D/5a+PVBEJRnYLzRZA+Ea9Q3I+c7w
 1cGNX7jwJz8HnksnEwyzjA6gO25hjOxDDW0AvqJHTN/s5BCdJZXNQhnFIBM+sZsjDgqK
 x9Cr+aCnm8VGa57y/yysfjLKqA0deSpC31xMHOK3Zmeo4rDJna0//dyoygW4eHoQM2Fy
 Svfe+FuCTdcXNHCytFyDMfWU143h9GmA1ZThdJg/xpJaYWLbY4th+SodYjnUUlzNHHAz
 8fjX9t+lXbhKO8omwOH45oc0UxdtYfVFgzZrgVVVTIBS2mD1D1yT4vi7YpOsKbC3Q7r6
 7EIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EFEbVjsG/sMNcfIwunoNEXRAcnnBUNfXQiMwhzLe2YE=;
 fh=PxwWAXbc8h8rZU6aPTn6SLzdAIwk3B6JWpw0olr853o=;
 b=gmhVcHwxrfRbcnHeoq3UEj/Iulw5SibyVyYxHTUzvBAcTAk1At6QMG85W6iVOAVrZb
 ppUbuHcfkU/o4ep8S/tJWXhazfXIh588T3QNhRq0wi9C+kiHRdKxsyN+RO+OZhJF4ouw
 LUxA5FAAqVC0zqfhOARZSgwAfRVkhx5UNGiLTmMl213LldeZeUF7l02HQqiEUl66nhgT
 oX6ZD57eRgR+3pGAdP5sY4DuovelUiFo/7F5ffH2NrWGPTsJTiH3kkwEvrRFIVufdAEV
 dYcDxsZm4wU9lKY+VWXxaxkhOvtbHzbv6XjwMZFxxNQJlVHVjLKBeVM9qfRYQ04f0sV0
 BDtA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776604777; x=1777209577;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EFEbVjsG/sMNcfIwunoNEXRAcnnBUNfXQiMwhzLe2YE=;
 b=dfDh9Gqh/m/LjohdvThq1TW7fksU1Y6zZDM1tC2AZwXXcu9mFtK79up8exgyecl50J
 i2VWCjE0x/oOGQZzp4Lm6s2h/++/e0TdoXrVRXR5dpMZcyaIixTEOJU2qoSjC9esH4vy
 EiZowEbVmrSUVmU6p0mLuKhZkAWWV0tU9WRtV/6ZWYKqYaldh1cUQJs2e5bq0+DdELzS
 p93cJYJ8LdYxcyCFIV2PNfhYZpSDLeFVbUTwIa9Mm2yDzqeK0cEkVk9/la9ECgNJ1+Sf
 DZAN6QNOMCcmTDunn4dltZM48y3SFFQCH4HDPUyl4oBa87vZ0izV9eiINSnhSb5Kywdt
 zJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776604777; x=1777209577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EFEbVjsG/sMNcfIwunoNEXRAcnnBUNfXQiMwhzLe2YE=;
 b=hsOtFcL3mnD3iedeNhQT8U50DdQfLMAlSftSGaF33nx0pG3bKWUXa/vx5WSZuZ09Eh
 AYsyTAZYFlnfezqFnnQMhO2wySiiziffl9bjlUSKSmkn7bgKi1/vivTOeEMZR2TDZdSZ
 dbR+twn0rnkr3ylTjHexixfTjNiedbpseZTkoO6ISbEqqngjIHQJuOxzDuTy919JA5fE
 z7Cy9Uad/PPRKL/gx2k7BaU4ChVWMJCN/OVWLubxoX5FyUEMDtXnsuCJ7qUpNsoX3zYE
 KjLIWS74lpFKlBKV/q4lRJqnDQR4zjwcfUAMI5VOoiFvOsVbh5HqAlkpMpFLbbNgRgfG
 +xhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mOITcFBIuiwAUGD+CaESC/yGmHUWWl5I4oboXdPcu78lvIp+7qnh1NB8QOp1a2G3F2/lAdkcP60A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAEBb/QObB4ikffKdD6KoDM/ibJXHJzl0jzgSVm3nQeyuIaHhk
 rQXqwUmacf8vPO+XsnaIlHD0fgmhH4SmpJEH8zcNglOyEGl3boSKar0EHTpELY9NbjNpZFo3JS/
 XPCTFbU/AYZwyPcv9QD8ov+1TF/uHIG0O+3EmY5s0l2IfTz7hX3T9UEXWKanMtuuBA19cb0wTby
 Vw5bHRhgo7jardWi5hX0bUrxDrBSUuG7KXUtbbATN53FhFSA==
X-Gm-Gg: AeBDieuIUrtopA4HnqU/hITkphp3B7iMJnuCDzVQrXzBgIPtS8Xx41/LmvF4KO8YU7A
 FemJrsfp+2a9EdRbwLVlts2mWVW1oOu0spTg+yYc1CRzKYSODdtvtXH4Jd7BlpfdKeNEDCJ+Zka
 pvSMT1Ze9lGDYyEuWLAcRGcgbPZh3YKPHR0T2Fxx6J29u6ENt3SlFEyC611N6fOBYlNEdrG2ei/
 574IDBoI/rfgS0HwGUwNYxkFRNPOzM9fDSOAIAQGhWz43mx
X-Received: by 2002:a17:90b:3c8d:b0:35f:9ab2:a5b4 with SMTP id
 98e67ed59e1d1-361403adbc4mr11438349a91.6.1776604777239; 
 Sun, 19 Apr 2026 06:19:37 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8d:b0:35f:9ab2:a5b4 with SMTP id
 98e67ed59e1d1-361403adbc4mr11438313a91.6.1776604776685; Sun, 19 Apr 2026
 06:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260409062617.1182-1-jianping.li@oss.qualcomm.com>
 <20260409062617.1182-4-jianping.li@oss.qualcomm.com>
 <7rfiwbbunlbzmhdjvsfqccltdx7cveahbgg2rk6kkom2jesta4@nnbas4vn63we>
 <cf0b6133-e15b-49fa-b9ba-e67ac8bcf7d3@oss.qualcomm.com>
In-Reply-To: <cf0b6133-e15b-49fa-b9ba-e67ac8bcf7d3@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 19 Apr 2026 16:19:28 +0300
X-Gm-Features: AQROBzDfOe8tb6TbtxiKgC32SYzBneFn6Kn0xUJ3H9EoPJSBro1xveaZtfSBPb0
Message-ID: <CAO9ioeXavdTExdMgz1By5G0OY9qt-81p2dbD482GWsfQy2XM2Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, quic_chennak@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE0MSBTYWx0ZWRfX61jjnx2sHH3e
 BXpMGo4zrCGrcsC4fgkkz0TBo8+WrgecZPZdeMwXjBrBzfg94BZgNpuE63gqopuzTfSVUJyaVID
 CzkbzxFPAwpQlvH6BckTcWqj8ksK19Dqsx1lzzQPfxlCad6eNRDB98N9AXyKE3jx+GmpfuskQZV
 KGe6z9cSYnqCFKr/5bphwVyNrqPas4FJZ/Qp0EbyPf1ZfQoTEDJp5y57kIEKNVbX9Q3rqOYgMwO
 B0yVL8PtX8DxLmhCYHCpXtps4ws2TgAtRFq/2f5f9WQ4EARq4QWBVfVMXrZJY7GvGTmJXml3FpP
 JDkIThfQq+mromPtI061Y8VC5ZSF/WszAh480Q6t8YeABCExtE+NucxmZeOgxLNC9Hzc8sUGh7Y
 pwyulazlAPVMkb3oVfmihvtKAP0XhYwLdbVmO4fEZBkcNU2NftXINrFrxp8AFwARaVuwRUg2OOH
 IRIEB5X3ocD8Ls0kvYQ==
X-Proofpoint-GUID: w7xwebIPhnW10vLZcEH9FbzqXs27xiTo
X-Proofpoint-ORIG-GUID: w7xwebIPhnW10vLZcEH9FbzqXs27xiTo
X-Authority-Analysis: v=2.4 cv=WK1PmHsR c=1 sm=1 tr=0 ts=69e4d66a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=PyPOkw-T4lfDyJblViMA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_04,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190141
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

On Sun, 19 Apr 2026 at 13:06, Jianping Li <jianping.li@oss.qualcomm.com> wrote:
>
>
> On 4/18/2026 2:31 AM, Dmitry Baryshkov wrote:
> > On Thu, Apr 09, 2026 at 02:26:16PM +0800, Jianping Li wrote:
> >> Allocating and freeing Audio PD memory from userspace is unsafe because
> >> the kernel cannot reliably determine when the DSP has finished using the
> >> memory. Userspace may free buffers while they are still in use by the DSP,
> >> and remote free requests cannot be safely trusted.
> >>
> >> Allocate the entire Audio PD reserved-memory region upfront during rpmsg
> >> probe and tie its lifetime to the rpmsg channel. This avoids userspace-
> >> controlled alloc/free and ensures memory is reclaimed only when the DSP
> >> shuts down.
> >>
> >> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> >> ---
> >>   drivers/misc/fastrpc.c | 104 +++++++++++++++++++++--------------------
> >>   1 file changed, 53 insertions(+), 51 deletions(-)
> >>
> >> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> >> index 148085c3b61a..a67ae991c0b0 100644
> >> --- a/drivers/misc/fastrpc.c
> >> +++ b/drivers/misc/fastrpc.c
> >> @@ -276,6 +276,8 @@ struct fastrpc_channel_ctx {
> >>      struct kref refcount;
> >>      /* Flag if dsp attributes are cached */
> >>      bool valid_attributes;
> >> +    /* Flag if audio PD init mem was allocated */
> >> +    bool audio_init_mem;
> >>      u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
> >>      struct fastrpc_device *secure_fdevice;
> >>      struct fastrpc_device *fdevice;
> >> @@ -1295,15 +1297,16 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
> >>      struct fastrpc_init_create_static init;
> >>      struct fastrpc_invoke_args *args;
> >>      struct fastrpc_phy_page pages[1];
> >> +    struct fastrpc_channel_ctx *cctx = fl->cctx;
> > What was the base for this series? It doesn't apply to linux-next. The
> > code here is different.
>
> This series is based on the patch submitted last month. I will redo the next version of
> the patch based on the latest linux-next submission.

Please switch to b4 and use `b4 prep --edit-deps` to specify base
commit and dependencies.

>
> Thanks,
> Jianping.
>
> >
> >>      char *name;
> >>      int err;
> >> -    bool scm_done = false;
> >>      struct {
> >>              int client_id;
> >>              u32 namelen;
> >>              u32 pageslen;
> > This struct is way bigger.
>
> In the fastrpc_init_create_static_process function, the
> inbuf structure has only three members; it only becomes bigger in the
> fastrpc_init_create_process function.
>
> >
> >>      } inbuf;
> >>      u32 sc;
> >> +    unsigned long flags;
> >>
> >>      args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
> >>      if (!args)



-- 
With best wishes
Dmitry
