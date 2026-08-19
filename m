Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BB5C5DF7D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1836010ED05;
	Wed, 19 Aug 2026 00:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eLAENzfw";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DBA10ED05
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 00:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787098263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6PkDd0UmCahKdu3JZanls061LW3iQXGbXeZcNXkwJrg=;
 b=eLAENzfwRDsdIknmQ2jR4tBW1JrV9HDWJw4zTG9nlvcmLqeuEXsyv4Jim/puIxOP3wjnAx
 wED8kqIhFiU0akf/LrXM5ZvZSSZX2ItTOMCgxZtb++7CtBNbr7ynNscndxaNhh4u8yUEYZ
 ry8OdMD0ekUQSfLKeUyoYPYFjtn5vfo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-vFDyGnzoMZODMyslD6YjEQ-1; Tue, 18 Aug 2026 20:11:02 -0400
X-MC-Unique: vFDyGnzoMZODMyslD6YjEQ-1
X-Mimecast-MFC-AGG-ID: vFDyGnzoMZODMyslD6YjEQ_1787098262
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8eac2620cb0so6176406d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 17:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787098262; x=1787703062;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3meVETvNh0oF+MgWc75MBOQm9AMx1Iu8D1AK3Y3rmHY=;
 b=S6PBPPvMX+9XkH6nFSBZ9EcnUSEfRHSWQprdHfIFTXb4LyqnBUsDsBGLYbmpbs8DFY
 eZjTp8ROF4ygdTjzjPCiZZSFyauKEmynKnlCkj1znyZyZfEvhRcquNSwNqh3DWU1RL4s
 6ve4vUOBX0i7z+9TE7BUmkLAro8Wq/JudaY/oUZTDdUdpXUCyBhfpJrJh5ZS0towwigf
 kdj90IZsLr8pslUsXGS8Ej8yu433gBWfFxAnuz/Ke6dQ2eKTreGrE1zwljOVBF3ihxrJ
 X3hqyV7OYzP0ktbN/EG3Udk9+vq+PopTNkqufMoj6cHfPJsRa59HZIXWiZ1Abt+714ny
 9knQ==
X-Gm-Message-State: AOJu0Ywe6h6U89zTKStZkt8i7NTjZoQ3kAEl/vN5yGSpcM62jd+ktbZN
 sPSwiAOcjGTF4BzFUKqKV1cwWEJ5nZyHHerwC0dndk55+j6ncQhn/LbcBrKT2qaYnKmSoNjrEQ6
 K2uo5rmnAZpF8g8akwWBZJh0I2PTYt3Tbu2By0y21Z+Y3Y/Mv+W6FgsgZtoWL8Gg6uKNF9zON7h
 tHwtJRgxAT/AxfxE+HG73U2qlqhMxRgdH1fVPv+rgs2m+FjjQW/A==
X-Gm-Gg: AR+sD11Wr6XzzwK6Y2h4CX3QADS6AELgrDN4wTeaEuK8bFfwmPx85vlf++OZ2h8ktRC
 /LyJxYQnkCx9ijd809PkOhuyOSYAaCSDgow/Q2MgAg9GPwXznalnneQHqNI34lxdTeTL9LQE7Ct
 IJGjrczovteZiHIjYjV5HNPKwyePgNjlM9A5/z4rEHyVEJUZPQI8fnuGp4dASecbCsdZTZpkG8t
 t3xnXdSQhw8Rao2K9/Ck3bq86B9t3l9oLSYo4HT2BrTRWfKR7GBhZqLgFp9dVFCMugozSHZnhSy
 gHzJCXUI0gOCiZXIs8+hvLYjF7gTo1dXu+DZJC/4lfUEGCVNozm94sVd+IoV7sgxcy7cT+mc
X-Received: by 2002:a05:6214:4186:b0:8fd:d5a7:f970 with SMTP id
 6a1803df08f44-90c5e6cc420mr7993656d6.11.1787098261608; 
 Tue, 18 Aug 2026 17:11:01 -0700 (PDT)
X-Received: by 2002:a05:6214:4186:b0:8fd:d5a7:f970 with SMTP id
 6a1803df08f44-90c5e6cc420mr7993056d6.11.1787098261046; 
 Tue, 18 Aug 2026 17:11:01 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2911a5sm1572226d6.30.2026.08.18.17.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 17:10:59 -0700 (PDT)
Message-ID: <ff6ff03c9150d84c02042f6d810cab9b0c9db51b.camel@redhat.com>
Subject: Re: [PATCH 4/6] drm/nouveau/kms/nv50-: Stop using nv_encoder->crtc
 in nv50_disp_atomic_commit_core()
From: lyude@redhat.com
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Marek Czernohous <mczernohous@gmail.com>
Cc: Marek Czernohous <marek@czernohous.de>, Faith Ekstrand	
 <faith.ekstrand@collabora.com>, Dave Airlie <airlied@redhat.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Kees Cook	 <kees@kernel.org>, Marco Crivellari
 <marco.crivellari@suse.com>, Simona Vetter	 <simona@ffwll.ch>, Ben Skeggs
 <bskeggs@redhat.com>, David Airlie	 <airlied@gmail.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maxime Ripard	 <mripard@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Jani Nikula	 <jani.nikula@intel.com>, James
 Jones <jajones@nvidia.com>
Date: Tue, 18 Aug 2026 20:10:58 -0400
In-Reply-To: <20260818235637.1738055-5-lyude@redhat.com>
References: <20260818235637.1738055-1-lyude@redhat.com>
 <20260818235637.1738055-5-lyude@redhat.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pU--5GYKcrRhSzVXeKAnQxjzab99uX6dGRd52pEtD98_1787098262
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

This is wrong and I only just noticed it before getting ready to finish
up work - whether we need to use the new or old state depends on if
we're enabling or disabling - otherwise we'll end up with an unexpected
!nv_crtc

Will send a respin of this tomorrow

On Tue, 2026-08-18 at 19:48 -0400, Lyude Paul wrote:
> Another leftover spot where we still use nv_encoder->crtc. Get rid of
> it
> and do the right thing: get the currently assigned CRTC from the new
> atomic
> state.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reported-by: Marek Czernohous <marek@czernohous.de>
> ---
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/disp.c | 8 ++++++--
> =C2=A01 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index f19820dc055ae..63d554e97fb62 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -2171,10 +2171,14 @@ nv50_disp_atomic_commit_core(struct
> drm_atomic_commit *state, u32 *interlock)
> =C2=A0=09list_for_each_entry(outp, &atom->outp, head) {
> =C2=A0=09=09if (outp->encoder->encoder_type !=3D
> DRM_MODE_ENCODER_DPMST) {
> =C2=A0=09=09=09struct nouveau_encoder *nv_encoder =3D
> nouveau_encoder(outp->encoder);
> +=09=09=09struct nouveau_crtc *nv_crtc =3D
> nv50_outp_get_new_crtc(state, nv_encoder);
> +
> +=09=09=09if (drm_WARN_ON(drm->dev, !nv_crtc))
> +=09=09=09=09continue;
> =C2=A0
> =C2=A0=09=09=09if (outp->enabled) {
> -=09=09=09=09nv50_audio_enable(outp->encoder,
> nouveau_crtc(nv_encoder->crtc),
> -=09=09=09=09=09=09=C2=A0 nv_encoder->conn,
> NULL, NULL);
> +=09=09=09=09nv50_audio_enable(outp->encoder,
> nv_crtc, nv_encoder->conn, NULL,
> +=09=09=09=09=09=09=C2=A0 NULL);
> =C2=A0=09=09=09=09outp->enabled =3D outp->disabled =3D
> false;
> =C2=A0=09=09=09} else {
> =C2=A0=09=09=09=09if (outp->disabled) {

