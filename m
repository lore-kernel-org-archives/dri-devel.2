Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E864D606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W0+8HsvH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6164E10F186;
	Mon, 26 Oct 2026 22:25:43 +0000 (UTC)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC97310F186
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 22:25:37 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-679a2297c55so4268998d50.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793053537; cv=none;
 d=google.com; s=arc-20260327;
 b=VvHKJASZVGSAtVbC5/Mfb0TFj3WFFNBtMCA4Dh5agsYQcRULmg/IAIaW+rf9BmygwT
 Mg+nAgNk1aUmic5UjArBxCmaO0aAwJuKANHR4p2XHoiUj3+X5gTpOKCMFtvfci10rr58
 CjeHG1zUHH9wiyy4e0vzslloz2Rz17u/y6P2LaV/YAnCsYrJT1whAZxpl2MMbmHdrUxa
 sExi/3QQn7F8E/GLh9yeOJUsK57rkbd3o2UgJvPsV7DSOMGVVULVjmgNlmixsUsmYxh4
 OgONXGDeoFXkkdjtcke11LsgNWLua8Ul4UgmgtZWxXS1AGzOfTPlljyyQxm97evKBhWp
 Yo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cGAzUHcm0sGgQA1n2QKAQBWci/eVii3nOBq4rFQatG4=;
 fh=XfhyecUYoTNV0rYTAYeEpEFw4UXejmuP1fNS0R2QiRk=;
 b=PVAatRDPC6R5PDxC5oTzGUE4j9NQhSyMpDRcumsDIAvtL8zsy/Q4wxiQx71dyPax25
 dPshsdq++cJAx93vmzfmqxht/BfTZvfJqHpZxkbLFpGpegGNPo9aGen7gaPGQ495zGvQ
 I6EjCshOlwH9Aj4wWrffl5TFq8pL+uWDjdxYQ0G1UctvzgKXc1KzLEPu5/9kFE60/Wa9
 6u9SdvtgUK/fglHFSTeTaX+skpSggOmXQogiRDH7ix4adI91XoFjKnhng5l9pgr1Sdg+
 5Qiu7NCWB7CMZ+DBndFCrFTVtxO8Np5GFDVJLV3KrVyCAEMeRJeGBx3XLYcqLwtb2dvT
 brEw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793053537; x=1793658337; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cGAzUHcm0sGgQA1n2QKAQBWci/eVii3nOBq4rFQatG4=;
 b=W0+8HsvHyVDI7ofmSKFZN59ErvxNKykvBTUvZUSzNgexybgiPAUbqN6psMwYBa6Ai5
 mP281XRUOkJufh2gip/U6AT38eUOPVpFgrruShPbkfIiH7Uek1LQL3wlJ+FFYcAQlJAe
 0xg3IOtEE7s6553JS08V7/PLvYOds7GXg1UOojbvXVBC3pLrUDL/Tm4sUQQreuKgP9hc
 czQDGIv9ddkJm7qXaqSLY5bXFfzaXW2yZFJLNCif2ffhWUTlr/EYtyHV56XWpvz28DTC
 dq3A5JpUrE6FgbLERP4n/y6Bf5tSBnvLejT0P6Hw0FZYS12A5K9YRjv4wPH+1UmkJg6d
 J5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793053537; x=1793658337;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cGAzUHcm0sGgQA1n2QKAQBWci/eVii3nOBq4rFQatG4=;
 b=Ou7tnz4Op6xLfvTTfvZ2YXXuip4F7Rxvi3e/MxMQCfXvstnl0pX/TLD2BuaB8GiPSR
 XujFj0EA4zPV05nIcstt6SX3Ff5Ne79JsqvHWCAmNzd2/NjKtbioNDZBksymDs5UJO3f
 Mgv6viA2IDR+YocX92qnVatRB2nNtcqP3vHS7CNNLSUP6DerPsPrWJGQjhfBeQvBLQb0
 2dSj+mUb+nEW4PCIIkLdQXRLmDNsVkhEs9TzbFZ0I2jcs5D6C9TV3oZ1dIozX6mJiOQF
 ptMKMAhcPN3kx1b/htf3r4EKwv1E5O9rTfPXaDP9SZ/MKsQJEB4XV7VSGXxORtad520e
 FOhw==
X-Forwarded-Encrypted: i=1;
 AKwUvByyAkXbibshh+Nf7C1ocJ+PHD1cnE1oK8qkA/d6Q+nWZmqIXepkpjo9BSeAOo5AUDVTIL/u0Oy0PZU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI2j5fDKzcISHVGtM8S9YiK2Ocyq7if1bsjyeSZgsOSD9YjeVEa
 qkKXWbXm/Iv5foqZxW2Q3LqAHzBgkUXJ8gnVfnabfVCebvvhaZaAGsAsbTj9CNLqDDqcXY1Ahon
 9yPLptp5FEfe0c6ruFyONCAzbbYLd5WI=
X-Gm-Gg: AYBFou0APb2Ylkx4RRNLUN+PvLnUWAUMcBqbmQVsPuo1iawav9+qvLu4ybEmUbCMBKN
 ovuBz30mnHZVWykaWUQP+SWc4wbsTDdW2XRJXx6cKJfVux8A4tFaOAnFRyqOegyDvMiRn3+AEno
 j6YlCXsJb4laorw4ruo5qWZKz72HJkeZGJRHltHHfavftVvfEq9WDThfpv57FC5YEqz4jxC9fEO
 6cGCk/Suy0zOUOzMqNWTlN+SLsJazqYF3IsM4LtaS2qvPueiNQ4qkCAaXJnNFY9qTRg6WpBTTcr
 zZz10SfNYMZigGA/XCCqkGK6ulPb7dONhnRbIUJJmxC8xis3WUGOUKZhFNLQEID9KFgyQI77e7O
 2mkR1w1RVeb+2DDhNDEV2CZ8+D+xsuXRq5XUMFP8RaOSRUTAdtu0QfJEVSb2B+7Y/29plMvdhh1
 X2dS2h9mRDJJU31Mn2B8zfhqAm7ffN/kEj8e5N
X-Received: by 2002:a05:690e:12c6:b0:679:ac3:9752 with SMTP id
 956f58d0204a3-67a4519489cmr5899753d50.13.1793053536512; Mon, 26 Oct 2026
 15:25:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-32-3c8cc5725def@gmail.com>
 <sashiko-outbox-170731@kernel.org>
In-Reply-To: <sashiko-outbox-170731@kernel.org>
From: jim.cromie@gmail.com
Date: Mon, 26 Oct 2026 16:25:09 -0600
X-Gm-Features: AclHuK8oPmCxBxu3r6O0jmjf6VGp1ZvogtAuE50408WWPep9paf2BtUZbw8FvSg
Message-ID: <CAJfuBxysCwTo9PZpgvjz+=ciTAAmJtOBAbE55_D_yhk+XuvCFw@mail.gmail.com>
Subject: Re: [PATCH v12 32/40] docs/dyndbg: add classmap info to howto
To: sashiko-reviews@lists.linux.dev
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
 Nicolas Schier <nsc@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 13, 2026 at 8:37=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Low] docs/dyndbg: incorrect signature for DYNAMIC_DEBUG_CLASSMAP_PARAM
> - [Low] docs/dyndbg: commit message count mismatch for API macros
> --
>
> commit 28be193f6b722396acbf0216c1b36e74ba099d0b
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> docs/dyndbg: add classmap info to howto
>
> Describes the dynamic debug classmaps API and macro usage in the howto
> documentation.
>
> > Describe the 3 API macros providing dynamic_debug's classmaps
> >
> > DYNAMIC_DEBUG_CLASSMAP_DEFINE - create & export a classmap
> > DYNAMIC_DEBUG_CLASSMAP_USE    - refer to exported map
> > DYNAMIC_DEBUG_CLASSMAP_PARAM  - bind control param to the classmap
> > DYNAMIC_DEBUG_CLASSMAP_PARAM_REF + use module's storage - __drm_debug
>
> [Severity: Low]
> This isn't a bug, but the commit message states it will describe 3 API ma=
cros
> while actually listing and describing 4 of them. Should this count be upd=
ated
> to match the list?
>
> > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Docume=
ntation/admin-guide/dynamic-debug-howto.rst
> > index a8962ab22aaf0..f5b1470a4b881 100644
> > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> [ ... ]
> > +Dynamic Debug Classmap API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > +
> > +DYNAMIC_DEBUG_CLASSMAP_DEFINE(clname,type,_base,classnames) - this map=
s
> > +classnames (a list of strings) onto class-ids consecutively, starting
> > +at _base.
> > +
> > +DYNAMIC_DEBUG_CLASSMAP_USE(clname) & _USE_(clname,_base) - modules
> > +call this to refer to the var _DEFINEd elsewhere (and exported).
> > +
> > +DYNAMIC_DEBUG_CLASSMAP_PARAM(clname) - creates the sysfs/kparam,
> > +maps/exposes bits 0..N as class-names.
>
> [Severity: Low]
> Does DYNAMIC_DEBUG_CLASSMAP_PARAM only take one argument here?
>
> The kernel macro defined in include/linux/dynamic_debug.h requires three
> arguments: _name, _var, and _flags. Could this discrepancy mislead develo=
pers
> attempting to use the API?
>

fixed in v13

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-=
part2-clean-v12-0-3c8cc5725def@gmail.com?part=3D32
