Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507DCC53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B777F10E6B7;
	Mon, 27 Jul 2026 17:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IWmHOS8C";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 003B910E6A7
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785174889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrgkY1jQpK3iCUNdvMeIPJZAEEHnxvkl2Yl/lDzedUo=;
 b=IWmHOS8CzGr1zFc6H9g0oBoymDo+kHwguUfM1u3v7TP4E3sCwNgRqM48+Hl1soTX6bAa6P
 m0Pyidr2SdFiPN6VWtbInqnnfXMMIEmTFTDUmNh+3hQ3ZSWxLLkC1cMKnzoxvGo6yO9OF+
 VrVMsWP3N5yKbhFwCnggZvY9QhbKY6Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-fCG1ZYECPPy8NzLN1trBFg-1; Mon, 27 Jul 2026 13:54:47 -0400
X-MC-Unique: fCG1ZYECPPy8NzLN1trBFg-1
X-Mimecast-MFC-AGG-ID: fCG1ZYECPPy8NzLN1trBFg_1785174887
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-907c59bd73bso58136466d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 10:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785174887; x=1785779687;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U3hTRi91CNq2ftIlTw2qCUxBc3lKuCHq2yzoU+61UwA=;
 b=auuj5U4JTl0eS2CiMklkxJD/iixXRZCXHXb/0rs0hA6RAITITvOgDS/wsKE19yUnGV
 8n/mscu5STIPRBDKllMEVABAe+MUaAbH5nuj2wWIZoSc2h307sKQGUQS18hLeg4kbpkI
 hJqWqjdedWm18TYfTyMVHmSbEn0AFDlxq6bSPlhTo2yKclTq2TNLsNXWX9G8z9QQpzds
 i4wiZW03xiFUC6v0YHrVX5ai+nfmHiqm7c+SyUB7mckqS2fceoirooVmqd8Gx6waOFGd
 /XlR4yQov5AS4blYSYYHDYdUHvb+7WtC4O7I13ybfrTxbjtHt0Vh2JynoF+t2uhgWZJp
 lF2A==
X-Gm-Message-State: AOJu0YygotdN4kwlMxQa7wub1t4U6c/2HR1h5jfIAfKI6e+hSCLtBYlo
 9azwhyLF3Jr9j7t5HRGyHOc6qYUOt/H4K1RYlwjOElZPMQzN8cTPhL5dwMhEGcsv6TV3twX3tI0
 oy/MbpLHqFUZx2fqSpLsBDfbA4RLeW2vl8WNEZwidDdiRGlP4+MzPuAdBErXNmhSuvpd5uHb6UU
 QhNlqqhdp0XTHGV+VYONX/htHfSLE4WdSYvvPdU8lf0LYl5S6UIQ==
X-Gm-Gg: AR+sD11jifD4sIvR1t6vrVVMJShJRw2U8I2yMvrdt3wAbol5UuUdfE4PDzJkXHKDnpt
 yXyOUDHUb6J6VSap+XCz/nQFe3deFWUw4KlCxzZie0oaSPIBsTfvy/vKWFqyjzvJumrv3zHznNU
 noCpK8/S2NOCTTXs0j6N93QXJCDbxbTbuWiGh81FpRYoZ4Bzv+UxRgulS8DhAnBe2gqA1yIOJiQ
 uqt+yGaB+im9dppqi8i08O2PpukaTHJGnfTetvBjqwo55SboeRNXvh+En2KeK6JFSxlC8psCbHv
 ku/BTLlsoxnwfHje+A8eqMOOzCNBblOks4baL7WLz8fgFxSNPhc9SOFbAhXEKS/JIgMltNtx
X-Received: by 2002:a0c:f202:0:b0:8fd:6dc5:94a with SMTP id
 6a1803df08f44-907ec8d84a7mr125962466d6.63.1785174887304; 
 Mon, 27 Jul 2026 10:54:47 -0700 (PDT)
X-Received: by 2002:a0c:f202:0:b0:8fd:6dc5:94a with SMTP id
 6a1803df08f44-907ec8d84a7mr125962086d6.63.1785174886773; 
 Mon, 27 Jul 2026 10:54:46 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e8694197sm70197646d6.24.2026.07.27.10.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 10:54:45 -0700 (PDT)
Message-ID: <4c953dda5ca7ab96fc419f99f1e0019768ea05a0.camel@redhat.com>
Subject: Re: [PATCH v4 2/3] drm/nouveau/gsp/r570: Set GcOff = 1 in fbsr
From: lyude@redhat.com
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Timur Tabi <ttabi@nvidia.com>, Dave Airlie	
 <airlied@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Ben Skeggs
 <bskeggs@nvidia.com>, Kees Cook <kees@kernel.org>,  Simona Vetter
 <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  Maxime Ripard <mripard@kernel.org>, Mel Henning
 <mhenning@darkrefraction.com>, Danilo Krummrich	 <dakr@kernel.org>
Date: Mon, 27 Jul 2026 13:54:43 -0400
In-Reply-To: <20260727175246.642071-3-lyude@redhat.com>
References: <20260727175246.642071-1-lyude@redhat.com>
 <20260727175246.642071-3-lyude@redhat.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Trzz9aji1OoEe0af7KZWMt6hq_WI0jNn-cZttrrmp8_1785174887
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

aaaaand I completely forgot to change this from a 1 to 0 in the patch
title ._.

Reviewers - I will make sure this gets fixed before pushing it upstream

On Mon, 2026-07-27 at 13:47 -0400, Lyude Paul wrote:
> Previously, it looked as if we were able to fix suspend/resume on
> some
> desktops by setting Gcoff based on whether or not we were entering
> runtime
> PM. This was a mistake though - the only time suspend/resume would
> end up
> actually working was if Gcoff =3D 0.
>=20
> It seems like it's likely the main reason for this is the FBSR GcOff
> argument actually controls GSP's behavior with regards to which
> buffers it
> decides to save across suspend/resume. When GcOff =3D 1, RM reserved
> regions
> are saved unless they are marked as LOST_ON_SUSPEND, and RM channel-
> context
> and kernel-client buffers are also saved -including- when they are
> LOST_ON_SUSPEND. This means with GcOff =3D 1, we end up having GSP save
> and
> restore buffers that actually need to be reinitialized on resume -
> causing
> the failures we're setting.
>=20
> In the long term, we do want to have GcOff =3D 1 as there are still a
> handful
> of edge cases around broken runtime PM that I've seen on laptops -
> and I
> have a strong guess that actually properly implementing the required
> bits
> for enabling GcOff will probably address a number of those issues.
> For now
> though, disabling GcOff results in runtime PM being dramatically more
> stable then it was before.
>=20
> Thanks to John Hubbard from Nvidia for providing some background on
> what
> these options do in the GSP firmware do!
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
> Cc: <stable@vger.kernel.org> # v6.16+
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> index 2945d5b4e5707..af5aa5065c3dd 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> @@ -81,7 +81,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct
> sg_table *sgt, u64 size)
> =C2=A0=09ctrl->hClient =3D gsp->internal.client.object.handle;
> =C2=A0=09ctrl->hSysMem =3D memlist.handle;
> =C2=A0=09ctrl->sysmemAddrOfSuspendResumeData =3D gsp->sr.meta.addr;
> -=09ctrl->bEnteringGcoffState =3D 1;
> +=09ctrl->bEnteringGcoffState =3D 0;
> =C2=A0
> =C2=A0=09ret =3D nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice,
> ctrl);
> =C2=A0=09if (ret)

