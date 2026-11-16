Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B90606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=XIWWowur
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBD9210F10E;
	Mon, 16 Nov 2026 18:33:12 +0000 (UTC)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF0D10F10E
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 18:33:06 +0000 (UTC)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2ed1b9e8f43so17814025ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794853986; x=1795458786;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XYbRWAvMEdcEd3ZTDj/Xn5lvO6A6T/1r69W2qkfSX9E=;
 b=1xD4uygY0eNNd+eAmlXqoBqJdiiQT5jc3lFL5XYVRyfsfUC8jMu3PSkMSgMA0SK9Fv
 kGaOdbbOmrOR54ByftQNpaP5G5RmOxjbTeJVncWzF6f/iZJow6WSlzJyV3rk/mCPYtUa
 wp/6JLiDbsyqfKIk64M3fI/qvjrEU29DkDbY+a1xx4CSqk9tnAK6frfkHzB4Uz9JCzc3
 C4xxtErZhVSodsS1EtWPFoKQpDZPSAvAFVLoH5TM4+vusghTV1KG3ZhzgNMx658JlDID
 66khfZJ0RmmO3kIQfbJVoJT943QhJL/5E10YUPSrqZ+DwZYdSMQb2yYD3SK5EDyRyQrd
 CNMw==
X-Gm-Message-State: APuU4Z8rjB3UwyC4uDm4e6X86djQnL0i128csZSnkjdGiQm/s7j24ngy
 oypG75H1KR1VfCBJJ1izsz31rGKr9mI4XIG9Hb0Dn1gv6mtjhqMsMASEG9uU8/UbvxcGmA/iZJE
 xbH5hfgtQCHKlcqLnHUKF7m3krXPwFLmrvO6njYYFga00rjr/UNta1qYE4H7nPrp0A6i4HUJqYK
 nARatCSe2mAm7Q2+B3028RIJGawJ+M/T7ElnGgc3beH+v1ruDDhD4j4P/rELBRcpszi65qReWZF
 73sfRNfup706zGUkUoW
X-Gm-Gg: AZFdTZfuM1MgF1gFQ2TkqMMfL6WnR7tudC4uvkjpEYHK1lFjpUE7qaK78tvC9cg6U98
 ZuI4ntWs9ji/iLTMWwOunyf2W6n/QieX81X7vUxE70NmVVg/cJrYzOLebU4R9YzZ90u6KcYksDC
 W8yAEMqQRFsr1JdzmsPP3cAYP8FSTZ2SphGoUf03DqJ5H2vVKDMhNL4nE/Oo0vc/+NBBhdxZG0Q
 EtRJvC4aMvItiaWK2PyqQRTUmuwS9EkaosHFxy1DM3sZxlbqQEyvDYaR3zKY4c5ma3LvULi1hSj
 /+pLodxZq3w6zetT/YG4F8643QyQQZxTjYUU5i1gm0miAnPJMUZNmkWJCnsH5Bg5RByRMTguOvJ
 NZSMQ0oMDQTwkuDOmXWnx9+OOUWWT6nQCijeDpG8qNr2L03XNyU6tqLgMM4qNdheEGt8PKUEw2F
 cIAULJsjFB+X/Q3ChaNX8klGz28Eacw21u
X-Received: by 2002:a17:902:d486:b0:2e9:d0fd:639c with SMTP id
 d9443c01a7336-2ee0e0dfe13mr117710485ad.55.1794853985927; 
 Mon, 16 Nov 2026 10:33:05 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2efd7b41eaesm176115ad.46.2026.11.16.10.33.05
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 10:33:05 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3adef2bf843so1076571fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794853983; x=1795458783;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XYbRWAvMEdcEd3ZTDj/Xn5lvO6A6T/1r69W2qkfSX9E=;
 b=XIWWowur3e73kzVS06944BXWHb2j1AhVyAahOnoaebf3fNS0bdW0Y1P2Ch3+jdbXtv
 MiLDlOjq/OjoUKn9J242FoU7K24OD/AikwER1PGZhGWjj9hi1Ji4zGJmqIRxCYyyLKr3
 R4pqHX/8FlTlBp0q7Te2QV5JJKqB7wzRjlLuk=
X-Received: by 2002:a05:651c:a14c:b0:3ac:f9f5:c73 with SMTP id
 38308e7fff4ca-3ae5c91ecf7mr1026831fa.3.1794853983332; 
 Mon, 16 Nov 2026 10:33:03 -0800 (PST)
X-Received: by 2002:a05:651c:a14c:b0:3ac:f9f5:c73 with SMTP id
 38308e7fff4ca-3ae5c91ecf7mr1026751fa.3.1794853982784; Mon, 16 Nov 2026
 10:33:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-6-zack.rusin@broadcom.com>
 <DMMXFHCWWRFR.MUE8FPMJCZEG@broadcom.com>
In-Reply-To: <DMMXFHCWWRFR.MUE8FPMJCZEG@broadcom.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Mon, 16 Nov 2026 13:32:49 -0500
X-Gm-Features: AclHuK-YognnnPfthVoovXY8Sor7zip-YT-He6NNS9nIz7EvxYW6wOv54IxXPRs
Message-ID: <CABQX2QNoumTwtyYwPSGJ+jCfcFgfMue9ESNH+ch7_GmU_JT57w@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/vmwgfx: validate the framebuffer selected for
 cursor updates
To: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
 ian.forbes@broadcom.com, yunfeng.li.nb@gmail.com, tomas@slax.org, 
 stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000001fdd2a0660690254"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000001fdd2a0660690254
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 9:36=E2=80=AFPM Maaz Mombasawala
<maaz.mombasawala@broadcom.com> <maaz.mombasawala@broadcom.com> wrote:
>
> On Tue Oct 27, 2026 at 2:17 PM PDT, Zack Rusin wrote:
> > Cursor atomic checks select an update path and look up surfaces through
> > vps->uo. That object is copied from the previous plane state and is onl=
y
> > replaced with the new framebuffer's object in prepare_fb(). Switching
> > between snooped surfaces and buffer objects therefore applies the old
> > framebuffer's cursor limits to the new image.
> >
> > KMS clients can also submit a guest-backed surface without a backing BO=
.
> > The check accepts it, but the MOB update later copies from a NULL sourc=
e.
> > Zero-sized MOB images pass the check as well, then fail preparation whe=
n
> > mapping zero pages, so TEST_ONLY accepts a commit that cannot succeed.
> >
> > Resolve the user object directly from the selected framebuffer in both
> > validation and preparation. Apply the matching cursor limits, reject
> > zero dimensions and require a backing BO for GB-only and MOB images.
> > Recheck the backing BO in preparation before mapping it, while keeping
> > snooped surfaces independent of a BO mapping.
> >
> > Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> > ---
> >  drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 61 ++++++++++++++------
> >  1 file changed, 43 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu=
/drm/vmwgfx/vmwgfx_cursor_plane.c
> > index f0661e5effeb..9e8ea9e07f40 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> > @@ -89,10 +89,26 @@ vmw_cursor_plane_update_legacy(struct vmw_private *=
vmw,
> >       }
> >  }
> >
> > -static enum vmw_cursor_update_type
> > -vmw_cursor_update_type(struct vmw_private *vmw, struct vmw_plane_state=
 *vps)
> > +static struct vmw_user_object
> > +vmw_cursor_plane_user_object(struct drm_framebuffer *fb)
> >  {
> > -     struct vmw_surface *surface =3D vmw_user_object_surface(&vps->uo)=
;
> > +     struct vmw_user_object uo =3D { 0 };
> > +
> > +     if (!fb)
> > +             return uo;
> > +
> > +     if (vmw_framebuffer_to_vfb(fb)->bo)
> > +             uo.buffer =3D vmw_framebuffer_to_vfbd(fb)->buffer;
> > +     else
> > +             uo =3D vmw_framebuffer_to_vfbs(fb)->uo;
> > +
> > +     return uo;
> > +}
> > +
> > +static enum vmw_cursor_update_type
> > +vmw_cursor_update_type(struct vmw_private *vmw, struct vmw_user_object=
 *uo)
> > +{
> > +     struct vmw_surface *surface =3D vmw_user_object_surface(uo);
> >
> >       if (surface && surface->snooper.image)
> >               return VMW_CURSOR_UPDATE_LEGACY;
> > @@ -642,17 +658,10 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane =
*plane,
> >       if (!vmw_user_object_is_null(&vps->uo))
> >               vmw_user_object_unref(&vps->uo);
> >
> > -     if (fb) {
> > -             if (vmw_framebuffer_to_vfb(fb)->bo) {
> > -                     vps->uo.buffer =3D vmw_framebuffer_to_vfbd(fb)->b=
uffer;
> > -                     vps->uo.surface =3D NULL;
> > -             } else {
> > -                     memcpy(&vps->uo, &vmw_framebuffer_to_vfbs(fb)->uo=
, sizeof(vps->uo));
> > -             }
> > -             vmw_user_object_ref(&vps->uo);
> > -     }
> > +     vps->uo =3D vmw_cursor_plane_user_object(fb);
> > +     vmw_user_object_ref(&vps->uo);
>
> If fb =3D=3D NULL then uo =3D 0 and that would cause a null pointer deref=
erence in vmw_user_object_ref
> since it's not doing a null check over there.

vmw_cursor_plane_user_object returns a zeroed struct by value and we
pass &vps->uo, which is never NULL. vmw_user_object_ref() checks
uo->buffer and uo->surface before using them, so for an empty object
it's a no-op. vmw_du_plane_duplicate_state() already relies on that:
it calls vmw_user_object_ref(&vps->uo) unconditionally on states
without an fb.

> > -     vps->cursor.update_type =3D vmw_cursor_update_type(vmw, vps);
> > +     vps->cursor.update_type =3D vmw_cursor_update_type(vmw, &vps->uo)=
;
> >       switch (vps->cursor.update_type) {
> >       case VMW_CURSOR_UPDATE_LEGACY:
> >               surface =3D vmw_user_object_surface(&vps->uo);
> > @@ -662,6 +671,9 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *p=
lane,
> >       case VMW_CURSOR_UPDATE_GB_ONLY:
> >       case VMW_CURSOR_UPDATE_MOB: {
> >               bo =3D vmw_user_object_buffer(&vps->uo);
> > +             if (fb && !bo)
> > +                     return -EINVAL;
> > +
> >               if (bo) {
> >                       struct ttm_operation_ctx ctx =3D { false, false }=
;
> >                       size_t size =3D (size_t)new_state->crtc_w *
> > @@ -744,7 +756,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane =
*plane,
> >       int ret =3D 0;
> >       struct drm_crtc_state *crtc_state =3D NULL;
> >       struct vmw_surface *surface =3D NULL;
> > -     struct vmw_plane_state *vps =3D vmw_plane_state_to_vps(new_state)=
;
> > +     struct vmw_user_object uo;
> >       enum vmw_cursor_update_type update_type;
> >       struct drm_framebuffer *fb =3D new_state->fb;
> >
> > @@ -763,7 +775,21 @@ int vmw_cursor_plane_atomic_check(struct drm_plane=
 *plane,
> >       if (!fb)
> >               return 0;
> >
> > -     update_type =3D vmw_cursor_update_type(vmw, vps);
> > +     if (!new_state->crtc_w || !new_state->crtc_h) {
> > +             drm_dbg_kms(&vmw->drm,
> > +                         "Cursor dimensions (%u, %u) must be nonzero\n=
",
> > +                         new_state->crtc_w, new_state->crtc_h);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* The duplicated plane state's user object still belongs to the =
old FB. */
> > +     uo =3D vmw_cursor_plane_user_object(fb);
> > +     update_type =3D vmw_cursor_update_type(vmw, &uo);
> > +     if ((update_type =3D=3D VMW_CURSOR_UPDATE_GB_ONLY ||
> > +          update_type =3D=3D VMW_CURSOR_UPDATE_MOB) &&
> > +         !vmw_user_object_buffer(&uo))
> > +             return -EINVAL;
> > +
> >       if (update_type =3D=3D VMW_CURSOR_UPDATE_LEGACY) {
> >               if (new_state->crtc_w !=3D VMW_CURSOR_SNOOP_WIDTH ||
> >                   new_state->crtc_h !=3D VMW_CURSOR_SNOOP_HEIGHT) {
> > @@ -772,7 +798,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane =
*plane,
> >                                new_state->crtc_w, new_state->crtc_h);
> >                       return -EINVAL;
> >               }
> > -             surface =3D vmw_user_object_surface(&vps->uo);
> > +             surface =3D vmw_user_object_surface(&uo);
> >               if (!surface || !surface->snooper.image) {
> >                       drm_warn(&vmw->drm,
> >                                "surface not suitable for cursor\n");
> > @@ -789,8 +815,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane =
*plane,
> >                                        SVGA_CB_MAX_COMMAND_SIZE -
> >                                        sizeof(struct vmw_svga_fifo_cmd_=
define_cursor));
> >
> > -             if (!new_state->crtc_w || !new_state->crtc_h ||
> > -                 new_state->crtc_w > SVGA_MAX_CURSOR_CMD_DIMENSION ||
>
> Why remove these checks?

I moved, not removed them :)  the patch checks for zero width/height
right after the if (!fb) check, before picking the update type, so it
now covers every cursor type, including MOB cursors, which accepted
zero sizes before. The GB only copy became redundant.

z

--0000000000001fdd2a0660690254
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIAwc
5ev3yVpZiTud+7ZUYrJO7OO/IgHMFQzd6EkAEyiIMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTExNjE4MzMwM1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJlh9t2RIab7+1KNk2aL7ioltsZ4NJyAGIHbud6w
gr9Li1XLcORASOLtlagzkucpem4wXAIj7tr9Vfdr6mCWLH7Kgyj0BnAb8L+LJVE4qtZaOnYSbfJw
7b/JJOqVmhTpKbOHQEWX1CQBi6ZFv1haG19+7McALZBXuEIoXFo0K0iwJKmIxAU2OIqXda53AnU0
jrXWQlacWX4CZBBPhJfMMgX8hBxJooy/aFfUicRMFa+1q0MUrZ9+gtP2jGNrleRIValAM5LqMXl+
lkuibmEM4DRSCR21thCPKr1me7x2Lzsnh5A+P42cWlQCuDV8mYU8ZJwJKIRCIkyHqL9rn/XDYdQ=
--0000000000001fdd2a0660690254--
