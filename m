Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471E3F8D75C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 19:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A37DD10EA99;
	Fri, 17 Apr 2026 19:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IljC20xI";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FE710EA9A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 19:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776455157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyF/IwexmA4DSB1w6L4ViBDKOIzXHAQn3+2YDMuup0k=;
 b=IljC20xIYWYrN4dSdX9mrhR2AR7c+JVguMMJTqcl3ArWzc26k2lUIqdOvft/kLOb++3D8i
 upk7jlC55qFcyanZw3/BkwKl8pxJD6oEaIY4VIBDUA8E2l+wcbR8KhbvP+hx6OfrAPC6t6
 AIraucfRShjK9vTWpOtC1K46KGVeZQA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-pN7vz_jQOoSbEbTKCzXi-Q-1; Fri, 17 Apr 2026 15:45:55 -0400
X-MC-Unique: pN7vz_jQOoSbEbTKCzXi-Q-1
X-Mimecast-MFC-AGG-ID: pN7vz_jQOoSbEbTKCzXi-Q_1776455155
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d812c898cso30343131cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 12:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776455155; x=1777059955;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JyF/IwexmA4DSB1w6L4ViBDKOIzXHAQn3+2YDMuup0k=;
 b=RuNVwbtRvniAEIFDiMjfCaMa1pT+szZxA5eWYoT/jByMAKIw/HN9TJliNoh/lnDSom
 jYldcDnKTBRiGB1gSZQSiA1KJBYbdcglLrNh0P+kbefEOmA0ki9nuGxRfxeMUmpfl7PH
 gZKfPXEo+vZ/rTzBRS1PLpkjktvYiICL+CLjWri/IVOTRWvolYd8uOgRHHPmbKoz4lAt
 Ulotl8GNQPZxfgp5TEWyEoRl4nJfTnX8iqqZp75mm9FAMNRjvH2ar0qLhSf3a/bPy916
 2LPdOmsUOUuswIDmJCTXRlSlNv6my1AuMUSl4tRRVpJIQKPMD2FACGLVX2rm6jpitGwd
 9jkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+jwZVoVOKubu6v1q0OOPjo6rZr40N5dNrJPHK0JPyglp0Sl++vMH8QXneI46aREpvQGXWW2CmRHE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3LLfAK7rS6CKLemVcO4XUQsWj4qJnsbA5JSSEeJVG6RkxCIt9
 hEN328BbyzoVb65dLCmhB/wAOWDAb/9mDKRM+S8vcKScbpup4JxM9ryaUY+zM4xRswo/T+W5D4A
 LVPpMGgo9lmRS1lJ+RUEkqOKTBCmOOB8/II0PUXA3fKF/32YxPOS/sdxHir5NB+qgCYFrfg==
X-Gm-Gg: AeBDietDdlewAP23Oe2EjFzdTAMx65CwJIdBIm2qVg+rJKYdY4qZr+2VB+H87fxS0Gd
 iBu478/3sp9D4wU+/95+gNObgz8MB5zzgQmad3BiEN3iaf4mf/NMEnX2zpNK9PPYFKCkazZI7v8
 GAWrI7aqKxS9/HteJEAC9DWnCPvarBbAhgVpdwG5X4MNfHZ683TlUhSvfsEwnrKi4Kem1sUey2o
 EDf9wwm+CgmHa/fM4ITumrO2YN2d9bRXFj2m+FlWACLpudQA7DmnE4bUyeRJU8MQ5maIo0i3G6I
 PjtM66XPmOtBJSUjh2a4wdzsbVBL0cloP6wv3gzcr12E70kZCJkwAB9DE2asMv7z6iQnVmghbDp
 1nnWwAUPLxt0ghoO7WKr90thITggS
X-Received: by 2002:a05:622a:1189:b0:50d:84a7:72d0 with SMTP id
 d75a77b69052e-50e36e9c0c7mr60319561cf.36.1776455155153; 
 Fri, 17 Apr 2026 12:45:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1189:b0:50d:84a7:72d0 with SMTP id
 d75a77b69052e-50e36e9c0c7mr60319041cf.36.1776455154662; 
 Fri, 17 Apr 2026 12:45:54 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae97347sm18023616d6.41.2026.04.17.12.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 12:45:54 -0700 (PDT)
Message-ID: <34695156e1db9195eee105bcfd89b554b6ad32cd.camel@redhat.com>
Subject: Re: [PATCH v10 4/5] rust: drm: gem: Introduce shmem::SGTable
From: lyude@redhat.com
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: nouveau@lists.freedesktop.org, Gary Guo <gary@garyguo.net>, Daniel
 Almeida	 <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 Matthew Maurer <mmaurer@google.com>,  FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 christian.koenig@amd.com, Asahi Lina <lina@asahilina.net>, Miguel Ojeda	
 <ojeda@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Simona Vetter
 <simona@ffwll.ch>, Alice Ryhl <aliceryhl@google.com>, Boqun Feng	
 <boqun@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Krishna Ketan
 Rai	 <prafulrai522@gmail.com>, linux-media@vger.kernel.org, Shankari Anand	
 <shankari.ak0208@gmail.com>, David Airlie <airlied@gmail.com>, Benno Lossin
 <lossin@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 linaro-mm-sig@lists.linaro.org, Asahi Lina <lina+kernel@asahilina.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@vger.kernel.org
Date: Fri, 17 Apr 2026 15:45:52 -0400
In-Reply-To: <ba9d6fbd12a42d95e6349e232111d5e72e88e1d3.camel@redhat.com>
References: <20260409001559.622026-1-lyude@redhat.com>
 <20260409001559.622026-5-lyude@redhat.com>
 <DHPBAVQHIM11.XVBHOWYFRITF@nvidia.com>
 <ba9d6fbd12a42d95e6349e232111d5e72e88e1d3.camel@redhat.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1BxOQheM02H0mM1s-2bdE4mYhGUX3dN_8jEEqhfGd0Q_1776455155
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

...realized the moment I sent this I meant to say labeled block
expressions, but also I realized I won't need those either anyhow :).

On Fri, 2026-04-17 at 15:44 -0400, lyude@redhat.com wrote:
> Just so it doesn't come as a surprise in the next respin - I don't
> really see a reasonable way of using get_or_insert_with() here
> (though
> I had no idea this was a thing!). However - I can get rid of all of
> the
> ret =3D statements and also clean up the indenting a little bit with
> block expressions as I forgot those exist.
>=20
> On Fri, 2026-04-10 at 16:55 +0900, Alexandre Courbot wrote:
> >=20
> > nit: let's use `let ret =3D if let Some(sgt_res) ...` to avoid the
> > multiple `ret =3D `statements?
> >=20
> > Or maybe even better, you might be able to use
> > `Option::get_or_insert_with`.

