Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECE1C88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FAA10E1F2;
	Fri, 11 Sep 2026 18:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DhblACw3";
	dkim-atps=neutral
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4128C10E1F2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 18:21:06 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-671061b015eso1382042d50.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789150865; cv=none;
 d=google.com; s=arc-20260327;
 b=dSx1t0Q7r02sVGJDwGRPOqkQwz002vFCMfvrZPP5obO5ciOVdwjnaPqJTYGRKRPuSG
 LfALIKO21zNsWtsl0X7JbCxinD01VSICFSoQNeec+/DaM8jkJVeERtM8O+/YA9wuiVdB
 NTSAtHNbSY9soUIBcrldBpSMJFR4qbFAASPb91V8WZ6ZruijuhK+UkE2Nz8ng0WzrSMx
 dHOTN+Gq5NjE7hbzyHLKCKrch9SKneNvsGcL9T9f9bR5nwW8ldBYcxXZT3n5Hmanv496
 XUZIfVSLjySV4WHf9q4l6BLszQaWB+iiUcBANS57E8yEhKBRT8/lKF0SmjQPc++UHGMX
 S/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0PfkoOh/05AN64bzT3WIDHrUSVJxMax1VSqub7HGYzA=;
 fh=pyeEyXOLAgbLuMZHwZj7MlxIQLiwLCQinoFo7xNBOpk=;
 b=mmbuTyFSLFcTHTfrnyHfMpWntYVAcSy4qzXHG8nXt5RrwLXkI1A2a/4amfaSp6SlFM
 zl4U1WahR7SXhbSYd62wKHe1KzVWkERlUobEqUBhYL2qfWVkog8Dq15QG0cCHZtDwIvF
 BP46EWXoh6mRYWUT+vGs0TzApJnYaVdZfNv1H3/2Wg+YYrJ2daszMczfGZV6mlBHIPuW
 pRLxlgfbIJJGYqrj647Nzv8QsA7ZKo+0Hu9aslyde1coc62CTEf6u5AubOR9u74vaBYa
 piI3dlSAJfNu0GQlUD+fP9YAcQ2xvgtqWRDdlV+GvFmAO4IsbFKESmzBIzJ058wHugTK
 xL2g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789150865; x=1789755665; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0PfkoOh/05AN64bzT3WIDHrUSVJxMax1VSqub7HGYzA=;
 b=DhblACw3N4hu6d+eyBcsh1Xu4x3xq7o1tmQ2UG1ip8yQ82MoIP+C9o7KKnFkPfj7+F
 9V/7nZVPyQmhhky0l/F+oCS6QuKsYDxn8nuQwqLPXbh1pAnBZa6QlW3jZo4WcowbPVsW
 v66WO7s9uxtTN/60hkor86GW1PSRaOtHVImA0Q8kEafbMAxSCb+wo5v3ZyynZJ+njKie
 f4DvafoOo0w5K+1eqIjwhJ1jbxkauJY/T8t4+qRMyH95dXQTjIfRJE/0TCxNK34ptLqJ
 NGgMYLAyoQ8uC2mqIVb/9a0Jpe6U4y1+/j/7yfJxRSgbVdziw1a5puSDipiUBa79JNt7
 Bv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789150865; x=1789755665;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0PfkoOh/05AN64bzT3WIDHrUSVJxMax1VSqub7HGYzA=;
 b=ReyVTXwT/SdC4k0BsSgSiV2JARZqWPXST2AFzfQJ4CvNCcO8f+0ekaDw6chiknfW8D
 Gnm7Qe9+Y8Icw28BsUe2nnYUP3UeivRpCEg1AicsM747FlxBpQXRHTvuPUvWiA7VpUxZ
 LS9BXp5hFkjQj6UjgMGV+elW35n3gilGffptktIGlXnvs18TzKO/np1ldcAy764c0pt5
 tR1kWq5XT4aBvDyfEcCPVIRXHnNtiFhqHcehT5fxlKCz/gBX1vkekypEeDn0QcConf4Q
 dVtIvu0UwN5F+MKogvNEcAXZqLl3ylhdnZnQLjfySPYGyl8uV/xWgb7MAyLwQZo0reUU
 l1Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBybprh0rc7bHI4QRbB0apkXnT3PZ0IIilKYwfTWr+ZLogX7Y7nC6dvGabnIa/4HLui79+76dBIz/H4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lMxk+B9hFIne1FrhTnw2oroyZVs8tWpWfhqok92r8UX2+g4emy
 1U0b1r8zWSAkC+j65LZ6wxxMB65CVlRq/EjLwCxtEHw9Gl7tI/dKVm+e7oc23KpLHKAVA2oPALi
 yPvSeSoPSqBTRPAmbx6g7uYljFAlQxlc=
X-Gm-Gg: AYBFou21x0YV0m/uCH/AxvRiqlVznehB5f+CD17GBIOnlpuui+0NHRor1xOQydRZhCo
 XWfXzA8mIngCw+TlkKEmOBgpfA6rXbgqa5eAHQT6LEaylqrsOoO1jYkKf7CvBuagXpX4InABq3L
 jLHrLDMyHmQ6ZrWifXP4Fy0z2pasqPvDoOMFmBUf2LnrWUIcYYLaOBRp4tyaTAuwoUMDzGgYgQ0
 pt77BhNtGHjoBZ2y4DFfzxKKXGt7e7I51gTIJJOOfjxlCE/guHgtc41QSWFQ1/UJo0xZH20fzXa
 ejNF9I1XAeEaVIVgn92A2CICUpqXSw+ipiIbb17v5dsqseb3hgBCKO79+eUMjHkIlLkmTFlPczo
 Wpjo8vP1oMdW9O5EoPp+sj5NvG8c8qfmXzw==
X-Received: by 2002:a05:690e:450f:20b0:66f:c1bc:c072 with SMTP id
 956f58d0204a3-671246c1531mr1637688d50.58.1789150864802; Fri, 11 Sep 2026
 11:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-15-3a3f621f4a10@gmail.com>
 <20260909-primitive-nano-hound-8ee2aa@l-nschier-aarch64>
In-Reply-To: <20260909-primitive-nano-hound-8ee2aa@l-nschier-aarch64>
From: jim.cromie@gmail.com
Date: Fri, 11 Sep 2026 12:20:38 -0600
X-Gm-Features: AcwNN1UJu3AgSAwYav9ulJp2R_HPP-fzpsFCD13LL3sQevEBQ_irSbDy0UqSCw8
Message-ID: <CAJfuBxx0VFCS820JLqawLdcpb49Nj-=xnSYdg6ytOub6NidM4A@mail.gmail.com>
Subject: Re: [PATCH v9 15/39] kbuild,
 dyndbg: Clean up builtin module-name ambiguities
To: Nicolas Schier <n.schier@fritz.com>
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org
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

On Wed, Sep 9, 2026 at 9:50=E2=80=AFAM Nicolas Schier <n.schier@fritz.com> =
wrote:
>
> On Tue, Sep 08, 2026 at 06:55:11PM -0600, Jim Cromie via B4 Relay wrote:
> [...]
>
> > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Docume=
ntation/admin-guide/dynamic-debug-howto.rst
> > index 9c2f096ed1d8..99bbae37d34e 100644
> > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> [...]
> > @@ -161,17 +161,21 @@ file
> >       file kernel/freezer.c   # ie column 1 of control file
> >       file drivers/usb/*      # all callsites under it
> >       file inode.c:start_*    # parse :tail as a func (above)
> > -     file inode.c:1-100      # parse :tail as a line-range (above)
> > +     file inode.c:1-100      # parse :tail as a line-range (below)
> >
> >  module
> > -    The given string is compared against the module name
> > -    of each callsite.  The module name is the string as
> > -    seen in ``lsmod``, i.e. without the directory or the ``.ko``
> > -    suffix and with ``-`` changed to ``_``.  Examples::
> > -
> > -     module sunrpc
> > -     module nfsd
> > -     module drm*     # both drm, drm_kms_helper
> > +    The query string is compared against the subsystem module name of
> > +    each callsite, as shown in the control file, or its simple name.
> > +    The simple module name is the string as seen in ``lsmod``,
> > +    i.e. without the directory or the ``.ko`` suffix and with ``-``
> > +    changed to ``_``.
> > +    Examples::
> > +
> > +        module nfsd        # simple modname (as from lsmod)
> > +     module init/main   # subsystem modname (as in control file)
> > +     module */main      # any subsystem ending in main
> > +        module main     # simple modname, selects same as above
> > +     module drm*        # both drm, drm_kms_helper
>
> The five lines above have mixed indentation, please switch them all to
> one tab (no spaces).
>

thanks, will fix.

>
> [...]
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 0a4fdd8bd975..e129c4d10ed8 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -23,6 +23,32 @@ modname_flags  =3D -DKBUILD_MODNAME=3D$(call name-fi=
x,$(modname)) \
> >                -D__KBUILD_MODNAME=3D$(call name-fix-token,$(modname))
> >  modfile_flags  =3D -DKBUILD_MODFILE=3D$(call stringify,$(modfile))
> >
> > +# Dynamic debug subsystem modname with clean heuristic and override su=
pport
> > +dd_modname_override =3D $(strip $(firstword $(DD_MODNAME_$(target-stem=
).o) \
> > +                                       $(DD_MODNAME)))
> > +dd_obj :=3D $(strip $(filter-out .,\
> > +             $(patsubst drivers/%,%,\
> > +             $(patsubst arch/$(SRCARCH)/%,%,\
> > +             $(patsubst arch/%/,%,$(obj))))))
>
> May it become problematic if there is a conflict with
>
>   arch/sh/drivers/dma/*
>   arch/sh/drivers/pci/*
>
> vs.
>
>   drivers/dma/*
>   drivers/pci/*
>
> ?

2 questions here really -
- what should happen ?   strip arch/sh/ and then also drivers ?
- what will happen - I will play with the expressions to find out.


>
>
> > +dd_modname_default =3D $(strip $(if $(filter $(notdir $(obj)),$(__modn=
ame)),\
> > +                      $(__modname),\
> > +                      $(if $(filter main core common util init snapsho=
t \
> > +                                    process,$(__modname)),\
> > +                          $(dd_obj),\
> > +                          $(if $(word 2,$(__modname)),\
> > +                              $(dd_obj),\
> > +                              $(if $(dd_obj),$(dd_obj),$(__modname))))=
))
>
> This looks quite complex.  I _think_ this should be equivalent, but
> perhaps a bit more simple to maintenance:
>
> dd_modname_default =3D \
>     $(or \
>         $(filter $(notdir obj), $(__modname)), \
>         $(filter-out main core common util init snapshot process, $(__mod=
name)), \
>         $(dd_obj)))
>
> (Removed $(strip) and the last $(__modname) fallback as both are already
> in definition of 'dd_modname'.)
>
> What do you think?

it does read better.  I will try it too.





> > +dd_modname =3D $(strip $(or $(dd_modname_override),\
> > +                       $(dd_modname_default),\
> > +                       $(__modname)))
> > +dd-name-subst =3D $(subst $(comma),_,$(subst -,_,$(strip $1)))
> > +dd-name-fix-token =3D $(subst $(space),_,$(call dd-name-subst,$1))
> > +dd_tok =3D $(call dd-name-fix-token,$(dd_modname))
> > +dd_modname_flags =3D $(if $(dd_modname),\
> > +     -DKBUILD_DD_MODNAME=3D$(call stringify,$(dd_tok)))
> > +
> > +modfile_flags +=3D $(dd_modname_flags)
>
> dd-name-subst and dd-name-fix-token are not needed, dd_modname_flags is
> used only once and can be folded:
>
>
> dd_tok =3D $(call name-fix,$(subst $(space),_,$(dd_modname)))
>
> modfile_flags +=3D $(if (dd_modname), -DKBUILD_DD_MODNAME=3D$(dd_tok))
>

yes, this all looks cleaner and more comprehensible. thanks.

>

>
>
> --
> Nicolas
