Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDABC982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C7D10E13A;
	Wed, 16 Sep 2026 23:52:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GrOnomwf";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F5710E13A
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 23:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789602756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XxveY0gK9JFrEbJosmnsDKRmBotP9lpgucyith6XnGI=;
 b=GrOnomwfMeSOPMSm8v97+2SGQiRXjgabOBY/I9UtNK16Yf8L3yIQaJ49o5lo9Yaq6IxkDn
 ah1m4XQjMSXdWfemprxwIcNjyM/dX/1m2oN/f7Nj5rbNJ0ZLb7b/X7i1PsWPy7omEov9XF
 hJht9LXswCmA2R2dZam9FTPlXbI0sFg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-xmaD8STHM8KU_jld16M7IQ-1; Wed, 16 Sep 2026 19:52:34 -0400
X-MC-Unique: xmaD8STHM8KU_jld16M7IQ-1
X-Mimecast-MFC-AGG-ID: xmaD8STHM8KU_jld16M7IQ_1789602754
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90e87478402so7498256d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789602754; x=1790207554;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XxveY0gK9JFrEbJosmnsDKRmBotP9lpgucyith6XnGI=;
 b=xMblqyH2CJ/t8XF1R+iUD31JK96iLD3AJdUdyGw59CSvMpJTDQL/Dn1rp8Gk3LrCAG
 +cNqpHUSnnEg2K732f+BUoeWDHfBfsVzz/qeCgd1QuwHrDUiBCAPVdmFvje8z5T8Z3dh
 fzynA9GvrbUzSmE5gKlzcYsbgz9SrS0gREVV5B7Spx9cNVjsdl+zAeLxh1lqB3Tm7ONA
 +vu8RJAFY+C4a7RIaQTRKwZmCkHFJzVAISK6ty4y2PyFNVzE+fNnWzZTlkzuMZoTbrpd
 BXQu83lUO5cPw4Wah2f0w9tSWNAuRdDorIAmiwMPiFakbwwjRCyHQKEbJSzMUKoeA1EM
 H+7g==
X-Gm-Message-State: AFuF++l40hskQKaJ8miof1RPDNMNTHq9Gwlb/c/tx3yTc38T5qKKejLI
 G9j5PqoX0n5C0dS/QncoRHNRZzD8B2uy6yupw/qMtEb4cHLJhjZ3gs+Mv2Lm+I2cLhokAGkcclM
 B2pwD4Sv//HzzbM1pcJY6pyAEhGIS/EqvQ4slaBUw71nHEyX3254ByS0GbNtzVcuzjcAF5ZUD+y
 87wSCYjMeicgl4aoQTQZTFY6jEBsbSqooh1AzsQskVb486
X-Gm-Gg: AYBFou1N6e/BVPpcqujB7QY7PdAkXz+sscN1W7CLIQFeZGpenxo+c/+FGjNcPi66Gtd
 w2wgR8dvEsKXK3L+/aDXodSBduYHJ4AbrQTL1ttyamgqv9k/aBWf02zZTrotlWwcKdqeIS3ntEX
 CEzrAfNAf6HeQoraTaPG52HvKpoWpK2Jv1sOJVjh7BptxtAEuhDzu2BCytQiST1bZVmmCBvSN9b
 XSHaRk6eonTebq7
X-Received: by 2002:a05:6214:cc7:b0:912:c32:f67d with SMTP id
 6a1803df08f44-9123d71d88bmr87785906d6.5.1789602754232; 
 Wed, 16 Sep 2026 16:52:34 -0700 (PDT)
X-Received: by 2002:a05:6214:cc7:b0:912:c32:f67d with SMTP id
 6a1803df08f44-9123d71d88bmr87785576d6.5.1789602753822; Wed, 16 Sep 2026
 16:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260916223358.507351-1-lyude@redhat.com>
 <20260916223358.507351-4-lyude@redhat.com>
In-Reply-To: <20260916223358.507351-4-lyude@redhat.com>
From: David Airlie <airlied@redhat.com>
Date: Thu, 17 Sep 2026 09:52:20 +1000
X-Gm-Features: AcwNN1Vhn0Q92zF9XK_q_kVcWg67HkJPIJKmLIMdoKKm-T5YZ3FSW1jZ1gt4KBo
Message-ID: <CAMwc25o+rVLRvHPqmurPJtPnqHupx4SNz=ZSrStwKm+GEejFng@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] drm/nouveau/gsp/r570: Add comp mode workaround
 from issue #3172217
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Timur Tabi <ttabi@nvidia.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Kees Cook <kees@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
 Mel Henning <mhenning@darkrefraction.com>,
 Hongling Zeng <zenghongling@kylinos.cn>, 
 Danilo Krummrich <dakr@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wDIUqQn1SlAbhntspDjwHY_QrkiqGTFCoA-Ulw0QicE_1789602754
X-Mimecast-Originator: redhat.com
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

On Thu, Sep 17, 2026 at 8:35=E2=80=AFAM Lyude Paul <lyude@redhat.com> wrote=
:
>
> One of the things that OpenRM does right before initiating fbsr is apply =
a
> special workaround (nvidia issue #3172217) which temporarily disables raw
> compression mode on the GPU. It is later re-enabled after resuming with
> fbsr completes.
>
> Since we don't currently save the compbit backing with fbsr, this shouldn=
't
> currently make any functional difference in the suspend/resume process. B=
ut
> it will be required for implementing support for saving and restoring
> compbit backings from the GPU.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> ---
> V2:
> * Fix gsp object mismatch in r570_memsys_enable_raw_comp_mode()
> * Clarify debug message a bit in r570_memsys_enable_raw_comp_mode()
> V3:
> * Enable raw mode before rescheduling FIFO channels
>
>  .../nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c    | 48 +++++++++++++++++++
>  .../nvkm/subdev/gsp/rm/r570/nvrm/fbsr.h       |  6 +++
>  2 files changed, 54 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> index af5aa5065c3dd..fe618a94461dc 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> @@ -26,6 +26,35 @@ r570_fbsr_suspend_channels(struct nvkm_gsp *gsp, bool =
suspend)
>         return nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl)=
;
>  }
>
> +static int
> +r570_memsys_enable_raw_comp_mode(struct nvkm_gsp *gsp, bool enable)
> +{
> +       NV2080_CTRL_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE_PARAMS *=
ctrl;
> +       int ret;
> +
> +       ctrl =3D nvkm_gsp_rm_ctrl_get(&gsp->internal.device.object,
> +                                   NV2080_CTRL_CMD_INTERNAL_MEMSYS_PROGR=
AM_RAW_COMPRESSION_MODE,
> +                                   sizeof(*ctrl));

I think all 2080 need to be on gsp->internal.device.subdevice

Dave.

