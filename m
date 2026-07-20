Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6421BC44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 22:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFB3510E22D;
	Mon, 20 Jul 2026 22:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DeW804jo";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8B110E203
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 22:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784585422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f43Tg6R34NEaIQ/FSdL+0yQV4MQEKKFGnTxvz0PSSI4=;
 b=DeW804joQ482wCCRZiGbHxAoWdUVBp8EintlfF8KsKZS98jQRcuJjDqE6SWQxBr+NVhiTB
 X/85mYsdAJj9bfGmijjaffTu3Zg54nesxpdlHZg42PUF14EmxsjUpWly8S6dEYKwiwf7Od
 F85c18ucrkuSCyna3EEWxUoORu1yeC4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-7Pc7eNdoN1id180VNOAZWA-1; Mon, 20 Jul 2026 18:10:21 -0400
X-MC-Unique: 7Pc7eNdoN1id180VNOAZWA-1
X-Mimecast-MFC-AGG-ID: 7Pc7eNdoN1id180VNOAZWA_1784585421
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ea75996387so112592046d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784585421; x=1785190221;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ap8TB1t8MVKfU1KnGjOWiKZymcp8eb6PIIp5l59xk5Y=;
 b=qpLAU6x1fbL7VUiml7Nd8qLjspILaqYmzOUeXAZ0GabiTMfkz0wrN5/mQ9ablzlvBr
 iPD8+Kz2rVGVavPQbKf2urD/h7dvDWbeKNCHQJiDmsEZG8Qz3H4sfNq6EFUVNMOF0hI+
 xUE1Y729X6OWDlVaqvsGAs/e1v3k2AQjad5CAYojLRspS+p44SLfTAvuyXmSv7EtDU2h
 J+2qHleuXDIdkM0uc0WlA6biCXXR8VpxbUnWF+Q/2QUgSSV1kGhdbWddhTrm2ELIq8hz
 vGD9LMz6qB8Iy5cV7kPdZ1zgZW2kPA5/FIOk+F7lM1nKoWu3Oq/6kLNmwbLLBbxeAmZz
 LL+w==
X-Gm-Message-State: AOJu0YwG8KncS3QHXA8gIalgVqHXstMpkmI07QWbggi5pziJX+d4yva7
 cOkh7f1IlfdXxfEdmM/FVR4GvJ/q5FGVCGECYgKEBON+dE/VhAAOAtQdOVGWg4BNCsHsz20iJu9
 H4HFcLINxUurElt6RM5RI7ogDu8ekJxgGENHDv5t4kPfm5m9f9uC8vEbAKno0jQtctHYrHQ==
X-Gm-Gg: AR+sD13Nxc99ZuR4xx3AslLVq1JMRh6uzBkpwNRwx6CNJIPFb1kZ/vfBz+AKahZTDGf
 c4WrNX4ieM9RVscUc7GhjkAJPqIuTeyOYJZdHWgna48dcHpfPzE7n/zUuZA5ezrHroK9p4ppeE8
 O+1B8J5NkgS68BoJqM02NyIpwNLkmNLsjZUCNCfTXbIyhRc79bPzkIrhS2QNAv5oOViNbGABeZm
 3YRVz6VaAWl22GpGCUeWdPoL5tx2Ji9OlnA7cPS855a15MM+t906mBtitawZ8a3q+Ht2H3uTP1N
 YKeSTFOP79vwh0hRjzZyYHXJ9yuTEUVRzGw7YJZ91BU0RdANbaHZXEPDV+z1i7LMM+jTKJuA
X-Received: by 2002:a05:6214:2589:b0:8ef:295c:3acc with SMTP id
 6a1803df08f44-907783ddec8mr173179826d6.56.1784585420733; 
 Mon, 20 Jul 2026 15:10:20 -0700 (PDT)
X-Received: by 2002:a05:6214:2589:b0:8ef:295c:3acc with SMTP id
 6a1803df08f44-907783ddec8mr173179296d6.56.1784585420125; 
 Mon, 20 Jul 2026 15:10:20 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907786f9de0sm101030296d6.40.2026.07.20.15.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 15:10:19 -0700 (PDT)
Message-ID: <50172752298fe6881b747a21a07a9ab1a1742ecf.camel@redhat.com>
Subject: Re: [PATCH v3 2/3] drm/nouveau/kms/nv50-: Introduce
 nv50_wndw_default_state()
From: lyude@redhat.com
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Date: Mon, 20 Jul 2026 18:10:18 -0400
In-Reply-To: <20260720220633.0A6851F000E9@smtp.kernel.org>
References: <20260720215058.398210-1-lyude@redhat.com>
 <20260720215058.398210-3-lyude@redhat.com>
 <20260720220633.0A6851F000E9@smtp.kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ahtEt3kVpKAZ3FKx5SlYb55DTBXWlx2Of2XSDmXX-7M_1784585421
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

On Mon, 2026-07-20 at 22:06 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [High] Unconditional dereference of `wndw->plane.state` which may
> be NULL if the initial state allocation fails.
> --
>=20
> --- Patch [2]: [PATCH v3 2/3] drm/nouveau/kms/nv50-: Introduce
> nv50_wndw_default_state() ---
> commit 2d2dcbda94d37e6b985a1775b04d636840fd94c1
> Author: Lyude Paul <lyude@redhat.com>
>=20
> drm/nouveau/kms/nv50-: Introduce nv50_wndw_default_state()
>=20
> This commit introduces nv50_wndw_default_state() to ensure the
> initial
> atomic state for a window always starts with a supported value in
> pixel_blend_mode. It hooks this function into
> nv50_display_read_hw_state()
> to enforce a valid blend mode value during driver startup.
>=20
> > diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> > b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> > index 2635458d52acc..dfa1ba45acd99 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
>=20
> [ ... ]
>=20
> > +/*
> > + * Setup defaults for the atomic wndw state
> > + */
> > +void
> > +nv50_wndw_default_state(struct nv50_wndw *wndw)
> > +{
> > +=09struct nv50_wndw_atom *armw =3D nv50_wndw_atom(wndw-
> > >plane.state);
> > +=09const unsigned int blend_modes =3D wndw->func->blend_modes;
> > +
> > +=09drm_modeset_lock_assert_held(&wndw->plane.mutex);
> > +
> > +=09/* Ensure the plane's atomic state didn't default to a
> > pixel_blend_mode we don't support */
> > +=09if (blend_modes && (!(BIT(armw->state.pixel_blend_mode) &
> > blend_modes))) {
>=20
> [Severity: High]
> Could this dereference a NULL pointer if memory allocation fails
> during
> drm_mode_config_reset()?
>=20
> If plane state allocation fails in the plane's reset hook, wndw-
> >plane.state
> is left as NULL. When nv50_display_read_hw_state() subsequently calls
> this
> function, armw will evaluate to NULL, leading to a fault when
> accessing
> armw->state.pixel_blend_mode.

there we go. I got worried when it had been a while since sashiko last
hallucinated :).

(there is absolutely no way we could be in the function described if
that allocation failed, and additionally this function has nothing to
do with drm_mode_config_reset())

>=20
> > +=09=09if (blend_modes & BIT(DRM_MODE_BLEND_COVERAGE))
> > +=09=09=09armw->state.pixel_blend_mode =3D
> > DRM_MODE_BLEND_COVERAGE;
> > +=09=09else if (blend_modes &
> > BIT(DRM_MODE_BLEND_PREMULTI))
> > +=09=09=09armw->state.pixel_blend_mode =3D
> > DRM_MODE_BLEND_PREMULTI;
> > +=09=09else if (blend_modes &
> > BIT(DRM_MODE_BLEND_PIXEL_NONE))
> > +=09=09=09armw->state.pixel_blend_mode =3D
> > DRM_MODE_BLEND_PIXEL_NONE;
> > +=09}
> > +}

