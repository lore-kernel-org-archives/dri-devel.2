Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450F4C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A5610E2AB;
	Tue,  8 Sep 2026 15:09:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CYl+nrSq";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D782110E120
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:09:29 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b1a806664so604846a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788880169; cv=none;
 d=google.com; s=arc-20260327;
 b=s3ZFzJqRTHYiWTqah6r+G8JBbw29dCLRII3t8OpG/Ufxx9hf1cSv+lPC6c6+z3FO5K
 z9OP0KIc+GlkZAyyOPYdaxOZyPFIWqCey8j4+sfeWusXzkB46LNnqabjTixg7ky6qWsk
 zI/Zs19vlmWO5uiyPaDb1ehm4KcDrTpneg8bUntLH+TUnx7dmjhMzDfMe4wGxdXSBRSa
 34oHoQdUEZN1UyntIzKyL77Zqa49Spjn3Cg7qznojaiBvcWcGugm9/srorNQpEPp7puM
 dcQfKhAC2sLq4L2KefQru7xBHau+mCC5yJm8I0Spw/MKD6Fx/c7mEXDVc+j/39yIHSD3
 I9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7VyQi/ZkPUG+zy3skQVlnP5ix8MZF/MBT4Cn4vahwwM=;
 fh=IK9P5FH6khLwqA9tEpHnKGx0mDKrQ/K8yYaQY90AZOI=;
 b=p86aK4EEpcp9uZLatyNV5jdJZzjye+slO1ReA6wXN8yBbEbbeRX9FUv4MN6llQH3P/
 Ng08o7V694PD5CduuJIPGAESRCixnTf3WHQlRtBbvNrLuK7KEau9caiPBEByawxp1BIn
 HR18BDREMkEFVRLfPe18I2AEmHmWXCxoU0WHRP3QNFsz/y+NclwiwXXEsK/VFklOOjki
 z5FcwR5k5b+JpYRUv4HYn5vLvLK9wmgust+gC4Q6DMr+k1QLj1I+ADI5gp2GxUDokMp5
 Sc6dxH3x9ItjABM1jShb3b+iotvw+RQMywgY9ZPJ98A2cPm2qcUaFDzVw5QciUCiccf6
 Fzkg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788880169; x=1789484969; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7VyQi/ZkPUG+zy3skQVlnP5ix8MZF/MBT4Cn4vahwwM=;
 b=CYl+nrSq05o756UA2dtWaY4XCe6mD28ga1u9IuWwgcm2I0CDgqVqwiQHWUpNVL0Xd8
 w/nia+N86d6xAItpJNKTCiBztcYF2+GunS0dQ/Ou0RnaP55GGX997p8cvcaRf2heYI9S
 MnM5Vn2HPTdRgtE0WFBItG1hemM/dknGovgZstDnNLMzrWpFuAIhC+SQ7bksMK8bztd5
 ToXvDzzu1RlYGlUxvQ4DxH3lAUt7WFBi2Fjh76Uk1jAF2d/knEKOQQMFDvpl23iwTRai
 SUUHvnPUM0ho8frslCTecntBtadFuZ9+a+CP3iFCw9cXCynwcV+lDoqTT/aqVr05qDjj
 qeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788880169; x=1789484969;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7VyQi/ZkPUG+zy3skQVlnP5ix8MZF/MBT4Cn4vahwwM=;
 b=nvey1THqGrNLXxNONf9aj+RkVtcHrZdrkMiqe+QZJ++Br/ZejiA93epqLplRHUcRAS
 KxBOmQXwv7Pfg/syz2FPL5cpoShTFQt5GAsY77z62uxTVeQZgYeEB9G7dWhuWDFcR68E
 /EEV/riJffSl8SkFrGPDcwoz0YrkkBJEtxeIq1lOI90h5HHnQ3Z7owKAalBfXgdK2VWz
 l3/83Tmk3gzrOff5CN3D14krBsxM2np7+CBedX5PDEGY68+2aK3R62jFFL0g6Ck9IUZ5
 Fb77eVK6OHVWryxzJN/Bwlh0cAUXyti6HBGcUKigy56wmR+uTCexQgc7/OE3syqT8Hfe
 dSYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+hUxvG6nqqQYtMiBvUDD4Qa9WvkUwBMUAvYxzUhahoamNh3N+bqWX7OqT9ceAP0VNU5koNejIEww=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mq1WuZ8jTwHWpBYRjva4Yqa9j+oD/CHXcyfEg6+GihuQw35iq6
 cldv1+hZJ178FHwknGsc7otNpm3wyvuG698e/OUCIPFl7IVAcxS6mYAAA4RsdD12J1dlbR5ghJw
 ls18cmpiJQ4norXE+j7mCQHJZevl1EeM=
X-Gm-Gg: AYBFou0QlvzeIaRKWalLqzs9WWl9xyLHea6FXmHOnhRwwyPakhjvAgLmgYZB6pHfizm
 srOwKkN7WkKkoEH59ceXe/JPAoCvAdPJ5fd506OjDeWqBYaU9J1CWSuP4exHq2Bj6ZCKdCdtDrC
 5XjJzehuZ/bTfWRBtN5n3PCZmwpIiRij8vkFcKdshZeDAfqOInY+d8AdueiTGQrimX6yNFh1hx8
 PLVFGVG2iwf/BtqA/2GugHaMcbL71yKCoRFq2l/JKjQlMZAIiMQPX7UQYaAfWfdUo4gqXY9TWWP
 N6YFaVFlwL/XSHobNaQ6T1cv/LaG79TdsjcXn+m3ZSWyNZd9HgBPGata2qBzJ7ukjEqM+Fi2quT
 c
X-Received: by 2002:a17:90b:3ccf:b0:39b:34ef:3b24 with SMTP id
 98e67ed59e1d1-39b3d5aaa70mr21302626a91.1.1788880169185; Tue, 08 Sep 2026
 08:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
 <CACu1E7GGdxTOsn+MRDT+7Guhjs-DDkZVx0Yet=RTxgQ4CNCKhw@mail.gmail.com>
 <CACSVV00BtmA0CotRucd8jG=cQLQw0YmLKEkTOV70qHBx=sG0sA@mail.gmail.com>
 <fl5uoffoh3gyod3f6jxgze33ut4jj4ttmgivtyoa5oykbt2aqp@rkktjz4yh4ll>
 <CACSVV03ShOw8D8d-5gDPYdzH3_Hp7EMz2CdfA3x08pCKAtw57g@mail.gmail.com>
In-Reply-To: <CACSVV03ShOw8D8d-5gDPYdzH3_Hp7EMz2CdfA3x08pCKAtw57g@mail.gmail.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 8 Sep 2026 11:09:17 -0400
X-Gm-Features: AcwNN1UlPD6ctgDPf5NWumSwcQmlkV-egtOEnEpVqtiYB2PLdBiSmUTMS3asYaU
Message-ID: <CACu1E7H9KsUU=dV+iwQPOOX62+V8S5xstFf2LXhzeE7oSb3V4A@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: keep the GPU timestamp monotonic across
 power collapse
To: rob.clark@oss.qualcomm.com
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 8, 2026 at 10:51=E2=80=AFAM Rob Clark <rob.clark@oss.qualcomm.c=
om> wrote:
>
> On Tue, Sep 8, 2026 at 4:41=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Mon, Sep 07, 2026 at 04:20:43PM -0700, Rob Clark wrote:
> > > On Thu, Aug 27, 2026 at 9:07=E2=80=AFPM Connor Abbott <cwabbott0@gmai=
l.com> wrote:
> > > >
> > > > On Thu, Aug 27, 2026 at 7:13=E2=80=AFPM Dmitry Baryshkov
> > > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > >
> > > > > The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU =
power
> > > > > domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts =
from
> > > > > zero whenever the GPU is powered up again and the timestamp repor=
ted to
> > > > > userspace jumps backwards. On an a702 six reads three seconds apa=
rt all
> > > > > land in the 500..1200 tick range, stepping backwards twice, and o=
n an
> > > > > a530 the OpenCL device timer conformance test fails because
> > > > > clGetDeviceAndHostTimer() returns an end time below the start tim=
e.
> > > > >
> > > > > Save the counter in the suspend path of the affected generations,=
 while
> > > > > the GPU is still powered, and add the accumulated ticks to the va=
lue
> > > > > reported to userspace.
> > > >
> > > > This is useless because the entire point of clGetDeviceAndHostTimer=
()
> > > > (and the similar thing in Vulkan) is to match what the GPU itself
> > > > returns, and now you've broken that by adding an offset.
> > >
> > > Just to clarify, the timestamp needs to match what UMD reads directly
> > > from hw in various different ways (timestamp queries, shader_clock,
> > > etc)..
> > >
> > > If we can _restore_ the value (ie. write the hw reg) on resume, that
> > > would be ok.. but it doesn't look possible.
> >
> > Yes, a quick check shows that all relevant registers are write-ignore.
> >
> > > Otherwise I guess we need
> > > some scheme where an offset value is stored in memory somewhere, and
> > > some coordination with userspace to add the offset in various
> > > different paths.  But the kernel shouldn't be adding the offset to
> > > what it returns to userspace itself.
> >
> > Ack, thanks for the explanation. I tried to match what kgsl was doing.
> > It reads the GPU timers directly from the GPU, but for the CPU timers i=
t
> > reads the value from KGSL driver which accumulates the offset.
> >
> > If I understand you correctly, we need to export the offset to the
> > userspace via some extra page (like vdso) and let Mesa read it. Correct=
?
>
> Yeah, it doesn't look like there is an existing GPU_READONLY && !APRIV
> BO we could re-use, so I think we need to create a new global (TTBR1)
> "vdso" BO which is read-only to the GPU but otherwise accessible to
> IB1+, along w/ MSM_PARAM_VDSO for UMD to query the address of this BO.
> (And update msm_mapping test in igt to validate that it is read-only.)
>
> (I'm not married to the name "vdso" but not creative enough this
> morning to think of something better)
>
> I'm a bit curious if kgsl handles this differently.. maybe there is
> something I'm missing.  But somehow timestamps need to agree between
> what is read on the GPU and what is read on CPU.
>
> BR,
> -R

I think the kgsl timestamp offset stuff was only added for the new
A750+ CX GMU counter which is not read-only. We do need to port that
over to drm/msm. If the offset is applied for older GPUs, it's
probably another case of kgsl not bothering to keep support for older
GPUs in newer branches.

Connor

>
>
> > --
> > With best wishes
> > Dmitry
