Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C5606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aVaGFt8l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36517112C2A;
	Fri,  6 Nov 2026 09:18:42 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85BAA10E939
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 06:05:05 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3b0b6cae44aso37510a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 22:05:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793858705; cv=none;
 d=google.com; s=arc-20260327;
 b=Ir1Z0qcHZbeP4DvNd3B0Zo+84Y/d4DI2FyTtzUkBNBbAqhblcD0OcEgAZKGnrXxmgS
 8Tx8SdbgkitmKU61PxgDUZ/0D27UD6dXIA2nP78ybZgzL08V15YrljeGme9C5ImCVpuC
 ebrtI3C/hjvwEa9XfeM+5gDXsgdxwkv+3KX7WSBRWvDuczE/JmeuacB8lOv6YhwPzK3G
 0tf58DWCxLzR3Ofwl5fJnFZeUMkwKtgTJWFzIs1WP8m/Ia0ANDtPzyAspSoQdhVsp+O2
 Y6vuPD/j6PmZPyxE0PqW5m8LvIpVw8MhTtGkAoQEYmMRg8ecIIgBpbOsF+Anrlsi0a2x
 ZRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6CvS81jcXvcMzjusuBb3temDMl3RUTwUEKg0ZWsbrIA=;
 fh=68zBdO96n7zxoerMyfrKVuq+vW13PNBRdRC54BauIWs=;
 b=GeZCUnX7QV3eSru+B4ZmLzsalCp1pWl6UFL7E5cab4ch3DM6BPl98Vyzmiuz+yAqIn
 SwGVO8ZYYQmC5MSG7zVIeHn7JSS2Q0k9PrPhd0aaDLa1cwWnaDSbvUhOey3f6MU4AzkU
 jPFVO5NEYYWk1eKtBJPeqDGqI4xAr8iVk0ywtCzcGQRFpFekMphj9oBd/8JxmeXSCtlY
 JT5GzAZOVRNSRUWzR6B1BpqW3Lyczs4ejVA5u7ZXqKiK2aN09oTgoA8g24ein3dusxF9
 y+p514615w+oe9BKy+WQgLfeN+gPUk3RWVRJ9Y8VS9vii/i2RAV6IUg9avXvSjWKCbx0
 CunQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793858705; x=1794463505; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6CvS81jcXvcMzjusuBb3temDMl3RUTwUEKg0ZWsbrIA=;
 b=aVaGFt8lGuTDc3ZKQMPDU1HIZlKpmvll980XiqHn3VKuTWg3LvlAT4QM6GzGilXJPE
 yCpZX/Frtfd04WFCpJIPyl8TFR309povbUXoWQYZEgYfpKAhKFFw+Xc2ZsesojuZnlIJ
 yw1cEfYdp/U891u60UuaCK6MFck7Ivzh+I0qojCS7ieWOotkB0UEJWUYQjlzuzwesTbg
 lu4kgwA1HdPFc+bcRfLOfdIKb6Hz4UnqJUtJ8oMqbeLmhURlOx6+koKVDHDfH7rWlzGr
 9MlOgr5wXutRhjX1xtCSudKFeLD2h7vbf+Ia8QWMDAYLiIBLW/wm3l3RU+I11qNRfaba
 3Zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793858705; x=1794463505;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6CvS81jcXvcMzjusuBb3temDMl3RUTwUEKg0ZWsbrIA=;
 b=TcEiVVcaoNFxZEruV+e3dd8RJ8bDIGS7jjTK3GqhGAHqXkKvxvtC/jJesOkJ9HzGzB
 GJ35WsFQMX7fZ0ZvcE+32ypcAVH57wid0c7IcclsO/HWWaj4mEnADtzvMS8QH6iGNvLa
 Rgi5BegRpfKBJvJQV7v/yjycmi6if9vngkgNpSe+GzbKxcX7zo7G396moTsGvOZpi5+z
 MoFyB9KE6+h4jw++ccEl9vmvX5jxm/FCfF/dxM9Eun5Fs1Z4g/dCyRJbIEwJAEzsarY3
 sfKG4V+8M/zLY1p5Fq5OOOqTTzQBZ7JeRDZ6KArAOKkgbnz9GKTbQhx1Ci60tsXiKt7F
 /e7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3OUt1p/LYR+k/jT5ENBut1V2LRYU7xc/YwrIHOFFpVFyXrNbt36KQxAgFd01fWIh7yta2Vo6Vqbg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9yx/UNyKkowu/TMiIjFfcUE6PO+L8umXOH3E9tZww4L07fG/jf
 ULyuPP/9U+Xmf7lpgZYQ1jiD+txclDLYY8MM5Ztgh1Ngds4K7axF5jn+TMl1mUx3zG0lRP9Uq9l
 7/2eEmCSnuM10kT/U2lO+LhsQ3aSgta8=
X-Gm-Gg: AYBFou1cyQlSnH52oLNG66l/LFgtDx6Mg/8VlYBtZTpDn4OHmd2k/W1m0WjLG7W2z9j
 Ve2r7YjSv9FCQWX1PSjKzMnG9n1EymvtKFycHupi92px3cnG17XQoDAENIzspi4t4k7U4ctCdNC
 84bC5XG9A7W9lx9KJ+zQ2+G1S9VvrKEm7OgZbCOjh6QKK/O6ebg60HbUV/NZOUcCqpuNpcrnE9Q
 aV3R9tWOw+HKsgC5WvC1vpaxGYo/HanS9f+ex/6Ctopf9GrfhxtszGJD6P81pEHrI32/fpN/gD2
 onrECo4a9ZiCnPti9cImrD8HN4d8u1h1wywF4pceh/LoTCc6uDpzCYl2qaQ9ViykwL08cTgyArE
 tTnreDXQAen6keXKm7IgZczfNtaEk1goi8yc+mQ==
X-Received: by 2002:a17:90b:1dc9:b0:3ac:9e76:aa96 with SMTP id
 98e67ed59e1d1-3ae897c3585mr26038759a91.3.1793858704906; Wed, 04 Nov 2026
 22:05:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104073311.1617823-1-lui2012qwq@gmail.com>
 <20261104073311.1617823-2-lui2012qwq@gmail.com> <autMrRaeVWRtBlMP@intel.com>
In-Reply-To: <autMrRaeVWRtBlMP@intel.com>
From: Chengyu Liu <lui2012qwq@gmail.com>
Date: Thu, 5 Nov 2026 14:04:49 +0800
X-Gm-Features: AclHuK8ozyuxeuE45nFShHA9M9CtlCzBTDmn85bOzlVMDFkVYC2_DYt8S7C3UEg
Message-ID: <CAE=Q7=542V6Sf06r_WvGb4Hw0VrPK0vV=yU1OmoW6yhSiD4jEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] i915/gt: tolerate ERR_PTR pd in gen6_ppgtt teardown
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
 rodrigo.vivi@intel.com, tursulin@ursulin.net, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026, Ville Syrjala wrote:
> The correct fix would be to not assign the error pointer into
> ppgtt->base.pd in the first place. [...] one should always use a
> local variable first, and only assign the final pointer after having
> checked that the pointer is valid.

Agreed, that's cleaner.  v2 does exactly that: gen6_alloc_top_pd()'s
result goes into a local first and ppgtt->base.pd is only assigned
after validation, so the field can never hold an error pointer.  On
the failure path it stays NULL, and gen6_ppgtt_free_pd() now bails out
on a NULL pd (the cleanup path is reached with nothing assigned).

(gen6_alloc_top_pd() itself uses the assign-then-clear pattern for
ppgtt->vma you described; this patch doesn't touch that site.)

Chengyu

On Wed, Nov 4, 2026 at 11:18=E2=80=AFPM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Wed, Nov 04, 2026 at 03:33:10PM +0800, Chengyu Liu wrote:
> > gen6_ppgtt_create() stores the result of gen6_alloc_top_pd() into
> > ppgtt->base.pd and, on failure, jumps to err_put with the ERR_PTR still
> > in the field.  i915_vm_put() runs vm->cleanup =3D gen6_ppgtt_cleanup(),
> > which calls gen6_ppgtt_free_pd(), where gen6_for_all_pdes() immediately
> > dereferences pd - with an ERR_PTR that is an invalid dereference and a
> > crash (in the async release worker).  The free_pd() right after is only
> > guarded against NULL, not ERR_PTR.
> >
> > Bail out of gen6_ppgtt_free_pd() for an invalid pd and skip free_pd()
> > likewise, so an allocation failure under memory pressure stays a plain
> > -ENOMEM instead of an oops.
>
> The correct fix would be to not assign the error pointer
> into ppgtt->base.pd in the first place.
>
> Looks like a somwhat common bad pattern in this code that
> received pointers are assigned directly into their final
> location, and if the pointer is an error then the pointer is
> cleared. IMO one should never do that because it's very easy
> to forget the clearing part. Instead one should always use
> local variable first, and only assign the final pointer after
> having checked that the pointer is valid.
>
> >
> > Found by static analysis.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c b/drivers/gpu/drm/i91=
5/gt/gen6_ppgtt.c
> > index 438cd4724a..72a9ad4642 100644
> > --- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> > +++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> > @@ -259,6 +259,9 @@ static void gen6_ppgtt_free_pd(struct gen6_ppgtt *p=
pgtt)
> >       struct i915_page_table *pt;
> >       u32 pde;
> >
> > +     if (IS_ERR_OR_NULL(pd))
> > +             return;
> > +
> >       gen6_for_all_pdes(pt, pd, pde)
> >               if (pt)
> >                       free_pt(&ppgtt->base.vm, pt);
> > @@ -271,7 +274,7 @@ static void gen6_ppgtt_cleanup(struct i915_address_=
space *vm)
> >       gen6_ppgtt_free_pd(ppgtt);
> >       free_scratch(vm);
> >
> > -     if (ppgtt->base.pd)
> > +     if (!IS_ERR_OR_NULL(ppgtt->base.pd))
> >               free_pd(&ppgtt->base.vm, ppgtt->base.pd);
> >
> >       mutex_destroy(&ppgtt->flush);
> > --
> > 2.25.1
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
