Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79838C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD0D910E200;
	Tue, 15 Sep 2026 14:12:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T+AgKdn1";
	dkim-atps=neutral
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com
 [74.125.226.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B1510E200
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:12:53 +0000 (UTC)
Received: by mail-ua2-f12.google.com with SMTP id
 a1e0cc1a2514c-982a76f0cebso74604241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789481572; cv=none;
 d=google.com; s=arc-20260327;
 b=Jjpmjrw1Zg8It2BhKr1OtwzsZ2Ci2A25PcDkKp2YYGvm6sJkCRmqnBgbZ7KC2pl4GB
 dBsPOOBaPlBGaIoqxE7W2o1+c5tAIgTtVsti4ghrV8Bh5ytPYsY2m5O1mgfND9ZNioR/
 ByjHxZCr62ecwJOr+kgexmK+7OLELoN9vXwHeGMbIiowbYyQMpsXStuWRe9wwrdmaOer
 hG4sDJdapeiUU01UTFFT/jdwVsgq7hijgpMXlk237EYK+8HmpVn6TAfOq7YxeIeuD5MA
 B2r7ZN9+ndqXIMU2l/S20OY6H5Nv2AsMqswVKo5RnWzSsn2ToxjyOijzk1E8VLFbKL6Z
 JfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=i7cn65EbAp0IbKb7n2Q/NZmcE6NpExnNj+DKsdNyhwk=;
 fh=va8WSSI5pEAzQYAoEPxRxVcSz9WuybWsauMGpLqZdjY=;
 b=mxYoRlm+Oh0o0qPZiSFlPx5prz08hxLoZs/D1YS8caWKOWaedr95U2eqm4jLG8/zeg
 v32zEEfahERyaEhKUa5Uff/Jjb4K8BpqPLQ1/Gj7Hgn/WBbp5q2iP5OIl/yARsjBdLmt
 Y54vEPOKlC/C216tQGVzyNXmwM4DLYhwLIlGa02lpYCbFZBU286kdTZAuRo62sk3Lyes
 w2sl4IMoX5ZUAI9ltmfGxbWct4m6abQUwjnjZXNzy7AgCSUqG1Ye1QfyNl8PECL7QKdZ
 FE0xnw6cFiJv77IQKwOFpp4ucAaT8XEKVVzr/sR/qsvYp0wKfre8H6ul9/SGYTHEkVPS
 K3+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789481572; x=1790086372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i7cn65EbAp0IbKb7n2Q/NZmcE6NpExnNj+DKsdNyhwk=;
 b=T+AgKdn1AIXXYJgYyBtaGwMXBFvVpBIzhJd05eSEtIqh5dRTK0nJpHcsaSe316738F
 r9jeEkvS50bc/b5VtEUaaei+a2rLlWLwFaRA63EJTEhD2BpvQSv8mNxblAorSlB97Ruj
 0OpP40C/GncwVFZo5MeiB+FTUQ07TQ1YrumuaLHxSs++SfxKV/z1T/igZlMuq2bWDF/m
 gdAa2FS16dTrEgCX46ac9E4d6QKjpHuDGpAiF1bRSEHGYt7QiCywc0al/GNOF1oXSY9Y
 2uZv2q9Y0evKsXQl27hnOOBpQbLzba3wIlpIowPoQVGhGJnwDZ5O/7MkNEGn1rVk0mdb
 6YEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789481572; x=1790086372;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i7cn65EbAp0IbKb7n2Q/NZmcE6NpExnNj+DKsdNyhwk=;
 b=M6HYfD1UKDaBoHP8GUx7EfczCwLOs3EtlqFp9qDUXJE6YDsgnu1RAk8OUpJlMEaj+q
 flRT9N1/BWkG/yRntqIRTqx6NGjqZE00cQ7MnhDFGjNMZy8AMm7dXSzR+ljSAWQ2dErz
 15T59+SBZ2oz6/KRFxckiNP4YZlwDB7/BCSs1o9DrNHq8+nkXKY5+JOdqUuiyqOrXpBb
 IMctmuYCOTX5ydDsG95ptwJ1tmd/VhirxhrjUNDjFOA0s59puC5xRMt/xdNw1yc971c4
 GiHTS9j0Nxo0zmBrg3l15fXmjnhk1+kcovQ+5/rf+rLhzRXWzn2q7XVG9DNdGpUEKw1g
 dKng==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFkH5fzMeb3dc91I+R1vK8GNi8ejo0v3/Px3eeh3yt++JEpaCOJotY3LOMBJFCr0FKP0E61PVQev4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n5WT+h5Vj8UsJqXHbOrZAccTGRm83hvkyMoMWGFdfldgB5E7IB
 w3KrHfYVVCrp/DevWi1+X5bHPaLjOjiN2NWWlDKR2iDezTFisL2tWxrS0mqN2URGz9c2/ayvjzm
 VNRuebYOS/qm/JOCB4ncUUiYkn1wBtTY=
X-Gm-Gg: AYBFou3M3zUpNMGN0IOFmF7VasRd+0wY9kuATxBfxZocD9/pZQRrMFcinK0FZDwj1E0
 bcQ8o7F8RZZqBOpphjaHiO+5ldAdibzHxeOR+RjytwjfM0xB+8RqqliVdyDqYjZNYw0g76wfiOR
 s7gDFJcaHar8aq4pqGKvPkWCQMtNOiYptPiMcb+vwxTttS9JHmnlbZ2MHJDIUaxQgskNsX2ih0w
 fm7fdCSh1T92njyqX3tIWutu5tBbV/5XpzeC/HeEmGR1Ueq0wlfO+x7jp/wuLjY/MrMte+yfy4b
 MHjVeRzdeuDPF11/q6FkN95nFYVxyM10luwL9pFFESNjMdXYoyY6+kR9DwRNWEw7WwdmVKR0OZ3
 eAEyohoim5brlpFnnGwtdQnWjrqnV4+/a+qW8hDYaHQ==
X-Received: by 2002:a05:6102:c54:b0:786:d38d:f7c2 with SMTP id
 ada2fe7eead31-79b5b676f93mr2335600137.1.1789481572122; Tue, 15 Sep 2026
 07:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260914143303.90614-1-Dmitry.Chumachenko@cyberprotect.ru>
 <CYYPR12MB8729B5365277A22CAF0E3481B0BA2@CYYPR12MB8729.namprd12.prod.outlook.com>
In-Reply-To: <CYYPR12MB8729B5365277A22CAF0E3481B0BA2@CYYPR12MB8729.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 10:12:37 -0400
X-Gm-Features: AcwNN1WacDhZlbvZYTvJ0gfbBPuwD2uIMCbwq3aGupmgwVj9oiTKkaVVd5BP55s
Message-ID: <CADnq5_MKk5eQnZDTMepVtnAgEjWy84M_3ZPDkELyC5onnsAb2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: check ras and obj before dereference
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Cc: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
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

Applied.  Thanks!

Alex

On Mon, Sep 14, 2026 at 11:15=E2=80=AFPM Zhou1, Tao <Tao.Zhou1@amd.com> wro=
te:
>
> AMD General
>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
>
> > -----Original Message-----
> > From: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
> > Sent: Monday, September 14, 2026 10:33 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: Koenig, Christian <Christian.Koenig@amd.com>; David Airlie <airlied=
@linux.ie>;
> > Daniel Vetter <daniel@ffwll.ch>; Zhang, Hawking <Hawking.Zhang@amd.com>=
;
> > Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; dri-
> > devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; lvc-
> > project@linuxtesting.org; Dmitriy Chumachenko
> > <Dmitry.Chumachenko@cyberprotect.ru>
> > Subject: [PATCH] drm/amdgpu: check ras and obj before dereference
> >
> > [Some people who received this message don't often get email from
> > dmitry.chumachenko@cyberprotect.ru. Learn why this is important at
> > https://aka.ms/LearnAboutSenderIdentification ]
> >
> > nbio_v7_9_handle_ras_controller_intr_no_bifring() dereferences ras and =
obj without
> > checking either for NULL. Both amdgpu_ras_get_context() and
> > amdgpu_ras_find_obj() can return NULL, e.g. during the window between
> > adev->nbio.ras being set (early in amdgpu_ras_init(), by design, to
> > enable the fatal-error interrupt as soon as possible) and the PCIE_BIF =
ras object
> > actually being created in RAS late_init. Any interrupt in that window c=
rashes in hard-
> > IRQ context.
> >
> > This is analogous to commit d190b459b2a4 ("drm/amdgpu: the warning
> > dereferencing obj for nbio_v7_4"), which fixed the same issue in the
> > nbio_v7_4 handler.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Fixes: 7692e1ee2446 ("drm/amdgpu: add RAS fatal error handler for NBIO =
v7.9")
> > Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> > b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> > index 8e401f8b2a05..2b3a1b9f8efc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> > @@ -518,7 +518,7 @@ static void
> > nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
> >                                                 RAS_CNTLR_INTERRUPT_CLE=
AR, 1);
> >                 WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL,
> > bif_doorbell_intr_cntl);
> >
> > -               if (!ras->disable_ras_err_cnt_harvest) {
> > +               if (ras && !ras->disable_ras_err_cnt_harvest && obj) {
> >                         /*
> >                          * clear error status after ras_controller_intr
> >                          * according to hw team and count ue number
> > --
> > 2.49.0
>
