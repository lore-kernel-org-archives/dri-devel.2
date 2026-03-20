Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C1F1099B2C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 17:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95FD010EB0F;
	Fri, 20 Mar 2026 17:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jOZ5g/GN";
	dkim-atps=neutral
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com
 [74.125.224.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A5210EB0F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 17:26:19 +0000 (UTC)
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso2406682d50.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 10:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774027579; cv=none;
 d=google.com; s=arc-20240605;
 b=gnNn+a/jerEed4Ya/rjVv9e/2V8/srA4HQezRQ8ALbuiQxjdIsFNMOaGJcOcqxeDJO
 poOimra2xO7Yt/KTPr40gdk19eWk1n5VSFjG/DdCOkVI01jSRBFiKeQmSppOyAAE7c/S
 uoTHmA1u63Q5CAk3FeHuVMjNvtJtKm2U7D6cSrhGEE8gUVXeQB7rUy2jyoc+FyASrFgP
 3NCQ18Slc7Rfa5Jp0rc8F+EGTYXSxx+k9L2xykNLAFyDeMUVFuEEwJsdfmvJwSiO9n+d
 k0OwBp+dTDEW191bloaOYBSkfTXdSBqdS/L/0SSDpHYoITB8fmaSaVc3HDjBEPQyHlOV
 1jwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Tj3p8eyqsxs0jrqaosm095XCJBb6sVTFmtKJ+h8XxqE=;
 fh=3yKFh0w/nezuwThG5XXuFYcWZHK5rL9NMDRCWoAbGno=;
 b=BfW1gKZ1ug1DUBkP9/obcjwtf57I9Vk09+gr4C6yBDU/0N74EeCRgl/FNdTenqpUUA
 9nELwlJKGGM9wVuvdW+ap822aeptEEYg9JfiYBzalvxD8WeOIEmA7ywBBRXs0Sroj3J5
 oUJx5eK9W3nA6bfI/VjqIxqtYx+RgFGBq+Kd4qj//31jOg9dZOkC9QCOM97tykmYPtlj
 YIgBJW699ukTza9h+SGhCS0wTQDXCJpAwe03rs2E0w4f7d4z0R3kjX0gBoFP/soqFiEj
 E1F6GJ50aUlX/hl3uFTLn8RzM2OYoXMnmQZ1l96b1HN/GRe7abtmFV1SxAoADVmanbgT
 RkUQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774027579; x=1774632379; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tj3p8eyqsxs0jrqaosm095XCJBb6sVTFmtKJ+h8XxqE=;
 b=jOZ5g/GNpWjiPQn6fcUx6KHfCZmbLNDvmaIIfNDWYqBst4A/Hm1MOIpKJ6Y1cdFP43
 4cZ+y6hyacc6tVquPGlhlIpS00gUy610LH6OTWE4sa1vf7oJRWDJdDuv6XDydeFLb1um
 +xWAWZ9Quj6DEsXC2wTJkzTDZ9qerrZRzD27n5XEEXcFLQTIlEkFaXB24t+wlwsMttuC
 qLW9B9RIhvNxqh7IFMNiuJzOW0myTmSR/NJt0wU/rS4N3hPgo/yl5ZYoEHzTRugpwRZM
 rwfK9aEVFkWH6B8Xu8r0qcNnEQd291q3hg+J9tC1s7u/2LrqpiZhdRLkxOADE8HZDnzD
 93JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774027579; x=1774632379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tj3p8eyqsxs0jrqaosm095XCJBb6sVTFmtKJ+h8XxqE=;
 b=oR5v4YUl3jWOZO5SWmlRwnhYSYXmalo27s9QFLsu9Zrl/qJ+MZLmta729mE9JunmJV
 zWwOXUqLlTqCMJpzmtFEhZQzRC6KXjv4wrBWBsJaLJiIpYnW26aOIDw8hR7qhp/92A3A
 pCRD6Xp9CS/Af14ENjw5I0BYiw2SAn+Nkyv5PPlcVkIgz4eBKiXTOqig/8brghdpVWy6
 5ThUMny0AvnEwjeS8/+y0XgGyayaLd6Opb7tcspYuRdMafpMlnj6VBIETP6lXhHxRMyx
 U/HKiFPZR3Ga03tOxbpPYQdzUBE/ZwQ7a6QNOYEU6NMHWZnWHMNKartZYmmz3fvZfHfB
 IUuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTK31OVf/c+ZLJrhfvF1tBTYCf2YxgG6BGLaBDP5SwMZufbOyKH/DYAkuZHaKmsQrJR+F+1b9B1SA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtQeMNn39/hS2SiSFBs+hku8BAjzzzsL6MGGSJCjVPSkLbjAaV
 Vvel9YeZdNn3DUZozA0uzHyLLuEPxum/fpUOEN07Ucp9vhadjaAgu46FHMRxDAxDLaeGrMH5ZTd
 kBn6xzbdD1YvILiIWLr7SdCvHA7kL5MM=
X-Gm-Gg: ATEYQzzDei5MZxX78qYnQUt1Ji0KIZWaK76innK9tGbFLBfjYw5NZTKPythMl7SaJpq
 kS+rkyimQ+IwD2BA5OrAuxtZlSEWLDKK2LRS1y798Wm6U29SHVNAeya2nF5ttOi95h2fJEltnUe
 pDbp8EcaYvj5sAh+60i4BnOdJLRj3M85OpRnlB8OkfVed71/eaxagmXNShSS4oAIIakMAZYwN6U
 khrOc9O3B6neGN9WvyzIjralv4swjrnw63UIopOKvuqwG8oq6mD4EH3/B3jRDiSQCnHsPmYk5AI
 z/Vw
X-Received: by 2002:a53:b6c5:0:b0:64c:9aa7:549d with SMTP id
 956f58d0204a3-64eaa78df37mr3443072d50.38.1774027578377; Fri, 20 Mar 2026
 10:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-2-jim.cromie@gmail.com>
 <177402491426.6181.12855763650074831089.b4-review@b4>
In-Reply-To: <177402491426.6181.12855763650074831089.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 11:25:51 -0600
X-Gm-Features: AaiRm52mzW6EX86AA5Jjc_AE9pPFD7jbLjCUGPg_V9Sh6yOZDr0TEo5Rj5JOx1Q
Message-ID: <CAJfuBxzYUdM=HJ1yc=bTCHuRfPSznRZCPdfq_hfJSW7zxk4pEg@mail.gmail.com>
Subject: Re: [PATCH v11 01/65] dyndbg: fix NULL ptr on i386 due to section
 alignment
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org, mripard@kernel.org, tzimmermann@suse.de, 
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com, christian.koenig@amd.com, 
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
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

On Fri, Mar 20, 2026 at 10:41=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> On Fri, 13 Mar 2026 07:19:26 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > [...]
> > smaller alignments, *and* scripts/sorttable.c does not tolerate the
> > added ALIGN(8) padding.
> >

More specifically, it counts records in 2 sections, and insists
they're the same count,
and there's no slop/extra space.  the align(8) broke that last constraint.

> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202601211325.7e1f336-lkp@intel.c=
om
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>
> comments may be wrong.


in v12, I found a way to use the makefile to conditionally include a "heade=
r"
file which invokes DYNAMIC_DEBUG_CLASSMAP_USE().

In doing this, I encountered some lost sections (lacking a KEEP in modules)
which I fixed by reusing the codetag.lds.h model, to make dyndbg.lds.h,
which reuses the (now separated out) BOUNDED_SECTION* macros,
and contains MOD_DYNDBG_SECTIONS(). which scripts/module.lds.S invokes.
So, those comments are now obsolete.


>
> >
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index eeb070f330bd..a2ba7e3d9994 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -212,11 +212,13 @@
> > [ ... skip 7 lines ... ]
> >
> >  #define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)   \
> > +     . =3D ALIGN(8);                                                  =
 \
> >       _label_##_BEGIN_ =3D .;                                          =
 \
> >       KEEP(*(_sec_))                                                  \
> >       _label_##_END_ =3D .;
>
> This affects a lot of existing BOUNDED_SECTION_BY. I agree that it is
> not a big issue (most of them already have ALIGN(8) or ALIGN(32), but
> some have ALIGN(4) or just not aligned at all). I think this can increase
> the size of the kernel in other places.
>
> What do you think about a new macro or a
> BOUNDED_SECTION_BY_ALIGNED(sec,label,align) with explicit aligement?

Thats not crazy, but Im not sure its justified by the 6 lines that the
_ALIGNED() variant would save.  It does add some modest complexity to
the macros.


>
> > @@ -867,15 +869,21 @@
> > [ ... skip 15 lines ... ]
> >       . =3D ALIGN(2);                                                  =
 \
> >       .orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {             \
> > -             BOUNDED_SECTION_BY(.orc_unwind, _orc_unwind)            \
> > +             __start_orc_unwind =3D .;                                =
 \
> > +             KEEP(*(.orc_unwind))                                    \
> > +             __stop_orc_unwind =3D .;                                 =
 \
>
> You already noticed an issue here for example, and you had to manually
> expand the macro to "disable" the align. This is error-prone, I think it =
is
> better to keep BOUNDED_SECTION_BY here.
>

I'll look at it - there is a stack of 3-4 macros that would need adjusting.

> Note: I don't understand well linker scripts and all the implications, my
>
> Note: I don't understand well linker scripts and all the implications, my
>
> --
> Louis Chauvet <louis.chauvet@bootlin.com>

thanks Louis,
Jim
