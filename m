Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FF1606A321
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bz3+WK9v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7909C10FB02;
	Wed, 28 Oct 2026 09:50:31 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31C710FAF5
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:50:20 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so286993166b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793181019; cv=none;
 d=google.com; s=arc-20260327;
 b=lAhDMdPWrClsEpWVyp3shUZaA+ISxVss07Wey7jGZaB1NTOHqrKh1KtgZPDs3NVEsE
 XgjIt3+6oZM5H2YUfeZ3piujgcplfHXLrDSwtR4SIq9k3gzI2LdQhYARmsuaxrthjp5Y
 Mu5CH1YIYH5VJwAPah8v/iO8X6kuAwJdvLpeTzPEF2zS06TzfksvTdidmeqpqkFP9L/d
 UxVZkp/2Gq9rVBtCdJpLCqPunUVJw/BaY01wgJAhmLPLMH8pHzDof11QSEltqkpN7BmA
 qrqYCL2YMYqkXz0AUi+jl8sllOPXfOyv6UeciSLYhCzXfdJl4AR6zyeTwJO54p8Ua5kY
 c/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
 fh=1THa0PjrO+N+fkhtnO+F6P3T2QyqShI69Vu0iOfsIww=;
 b=HQmZvXBG+kSmB6HJOi0rCH/Q6UZyGH9ZLEIp/lStlir58ptL2btNRELuLk0tAlO9L2
 MqfOi4kMySnJNjXkOAL/X6mA740+T2PacZbuzCCTipQERZ3urqLZ8oAdp/XJGYTLBF+v
 HoL/mwppEiiPQRCy8Zp+s1WWLe72lRKpX+Uu3aShSnNUzelpx5laWQzQTEqXQgFbtUzY
 h37M1xBng4tkpLi41ru4SAXAX+uRqtUEcsFx0DU0S/mvsxgCvQ/u9IIlRWcQRiXOcbwt
 znRqwa7bkRzyyTJCEDZyM5BfiHkCIP8A5PSCeAQOnoThuydxfvTcMTiKm8DzCApRpLR9
 AzhA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793181019; x=1793785819; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
 b=Bz3+WK9vyGesa2exLO8XAnKJYqg8SZ6CJqaz8X6SDlrZvknyX+EoJESBClkEru2QRC
 cd9exExnGWZrfCmoGeN6vTRLEQe7gCpimIiaNs8nw2965xqqgBIfIr+luxXR9pXwtV/w
 kR5bRqgIEBMZwOqvfS8oY1g+XDyKYq3diHi4QWifoU+dhiZjEGIGpaX1ra37qYWrCVhl
 SpxA61OOphs1MIvEu6a6K8a02bM0mQhC0iRGYyG9OvABuv4ZB/Y0CGcRdcR7peSvYOwQ
 CO5mjIDZOq/Adp7OBTFX3dhfCyh0SwXF3kBSiRDl21E5VlWywYZC75SakzozEmw6fbin
 BU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793181019; x=1793785819;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
 b=SMpHFvIlTiDRvDt+R8fBGvh2wYX0RXcAkEFq1ywn7V7BFE46WiFNXo1NXBZAVcLzsP
 cwBE83DqN2cXCBgAbXK2eFsWIkn1RtJkXhMI7doQHH5IDPE9DpDmXm+FkuUqhcekDm/x
 tlTBwF5cn62Oep/2EIx52NJbYakZiRRn39we9Ep3OwLGuvQyShJkfOkgGYmrJG29qfTj
 +M9uTPbFn2F8bNemv5JyDEtAoFBb/7CIm79NflfWFo2hTIsCJuil3467LjLz5EWIyxiG
 0zcWi6dyEIzm+VrHsPKjUvCwMx19EDLtCl+mKa581nhex0ssBc+vnd8i7XpdlAf9YoGt
 173g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPrdLjdDZkyQhs+cnBoJqLpj3NFEu+KXQUxy4/PvLqZezp+Mp2Q3KhNKwKaSSlSJk4SLV5TQZXWX4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJvSKHf2Rfd4nAuOcWmqeUV8QFkUXwxwZECmOSpgGd+mceNJIcI
 3UnT5JtOVp1tNIGFHawUMV/krYajifu/BfuZxwc6R6rYr47RHwNeBYCXzn/8pQgZ+u88EloPngo
 XjthOfiusyszIZ9ZTV4vEiX/BmSCiwl4=
X-Gm-Gg: AYBFou0/PiLDxn9A7MYcQlWpF4igPydHOd9POGreaFjyOQIq/F9GZ+TaaMSrTQMHfuZ
 T12YeqiiUE7cJUAy9OnFIaYFekvU2W4ZtWiP4jE7e+V39BFRGZ+IwZazrYMFy46WIUTQTi3piK6
 HtlbVRWczKzX881Jt5/XQr65UkT3lGVvSp18qbCCUCuQfp2YEyL/SHm2jojpiEn46zuBebptGms
 dNwC671Uz1LjkHWbFe5IW69DrSIgU2WK1eTvt+m3d0loXiW2uYK75Bv1Q9NzTfCLMEWFXYlp10i
 +nriXJ1HULln8gXbkxGTOziPd8iQUGVxS2WfuLGnEnD3gneHNVvalCtDUoKBJUCsz3z53swsH8b
 1o42cEOZzMDn4cG7oPsB86kEw0x/BCefvivQFCCmQlTzQUxcDOPLpcvHvrT4sDSruDSkbZ3pPtr
 qWUW68Fxr22zl3A1W+uZjf0wBDyB73CYmZEe8EpTT48ZC+oJ67J5/HXEd0vvHVOF58uTr975fE5
 aqL/zQOpeJck3QRuQZBYYVP2NjgQpKy/MeIyd6xoohmBrw=
X-Received: by 2002:a17:907:86a9:b0:c48:a838:c17e with SMTP id
 a640c23a62f3a-c49a739f8dfmr484567766b.14.1793181019107; Wed, 28 Oct 2026
 02:50:19 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com>
 <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
In-Reply-To: <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:49:43 +0200
X-Gm-Features: AclHuK92we6zl1A1tCfKfYVeuXltUG4Bsfa-fRzr4orRkDVhJuYkTUAxt0MOtcM
Message-ID: <CAHp75VfR2i_PPZwSG2UPaxShU5L=FsSdEAT+0iUMDKAfugbRsQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm/i915: switch to __nonnull_args() macro
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 10:20=E2=80=AFAM Dmitry Ilvokhin <d@ilvokhin.com> w=
rote:
>
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
>
> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
> nonnull attribute usage across the tree and keep the attribute's quirks
> in one place rather than open-coded at every call site.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
