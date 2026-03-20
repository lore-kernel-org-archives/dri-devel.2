Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0D21099B28
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 18:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3E310EACB;
	Fri, 20 Mar 2026 18:15:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HgNFAUq0";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD2D10EB0A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 18:15:51 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-64caaacb9bcso1990678d50.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 11:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774030551; cv=none;
 d=google.com; s=arc-20240605;
 b=jh64S0P/0l+P9Twsz2hk/4iMUYdI+uprzGn1RzfrESMKdHYQVq4qzlo+eSUsMCbxlC
 gqAZB6r2LnegGJDJhycwOVmiOedbRAhXJUTvsL/0VVzT2Qj6nVq3Zpajzk7xjB8sOb05
 2S9fe4Be6ysa7HMiks/kTctefTEKVbTC32iAZ173Vxm34JkUvUkxdUN2wO6e3IiOFXTS
 rKL8yH/I+Cv6GdIV0nrooNzmYl8+5rVWmk+563Ls5VI+ABiAHHHhE0qcVX9zJd4Z5qJ2
 1zoEa38sg7IO1iF6+KJOakq4R/gn/snigvAIXAYe2vthoaGELBRDNqsZZ8KGlv/KTZU3
 I7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yqVOmyZ2Z9NpjvmKpf4W2/OoeWedoqj5iVulCJB7QGg=;
 fh=+fNQUrMqm8iJAP7YioTerZ+efMtPJWEJA18q+wkMlUk=;
 b=HKIogIITs/40+Kf+s45TBkYX1AeemeZcxrMmtNhKhyeN8Gl+uiV6A+fg4LPcGt+6Pw
 TE6S08hlYqjxhr51UBfmFRKnMIyiNLT6vVyq1+lU6z2T/xzo9xFTI7RH1GOgdg9VnvRk
 wXHbfnRoDiePp4519iOLObaMG8lCaSxAzkFPbisEY12TSGkWBcO5FLOSXSXGJhoiE0y8
 iONjIRbLf9Kg7Ti/Dlx9ezEadbTtm9XZ+QkLYx/ZEKDDpInQreUs858pOrubtmStV6Yp
 Dcr691BMHA8hASzEV1Wliskv5eFLoXGn/7J8zz5AEjhOoMWRifcqk2uYAC3y9uPyN7Kr
 NVag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774030551; x=1774635351; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqVOmyZ2Z9NpjvmKpf4W2/OoeWedoqj5iVulCJB7QGg=;
 b=HgNFAUq0Hgyiw4zqw3JgpV0k0nbDWJydu24VMfUWtYQna+PmQ6RaWNYT/uWn00NVAi
 soJwDvNOzhXjPxepn/j32sje7SpaG+PvCuTe82490IjW1mRurXGcEU2t1Tfx4bbY8bTv
 yObon8XLsqbwtWFCKC6z4IBMs2+zqYMHVrVfdm7JndzaopaWHlDf/2CgiOMS4XOJJ5+T
 aFJimKhyY9IcRVSx3fr37rzLUYzsk9QWoKU8PBLlts4rMODpi6S4L9clcKak8LddQf2l
 EhKypPRVIsoHOyncX80e9DgR/hdbxavjR1HXTZkguvE1e9h5O/zAy61uYwMfUM4W6g8m
 Mb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774030551; x=1774635351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yqVOmyZ2Z9NpjvmKpf4W2/OoeWedoqj5iVulCJB7QGg=;
 b=EBXFlo/yNiW4KHqN3cxwz+V3GzokxebnHOSVRP5JCeTEWfEPwItISucMEYA6SUlLYq
 2UVvWxjV456xf39QKNzv/4kaic5ChnJmbbzvT/NGcDsJD4/Q9a5Rvh8mEwWn/2+Scdxm
 maQ/rWUY9PIyqY3qsHXDh4EfCpbM4QKcYYTHw+2dIcLFnqdSU8SAwE4JbJgjyMU95eOW
 9hvaKaIt/42ZkwqgL5joyuGfKpqY7auuHTJL+ILJfSE+hYKkqs+FLjV0W7zyqTuUUJYY
 /ixFBa68AGMMiBfiIptXi3TMLSB2mmFhNqwiCfy2DhxnD+ILwwn7aDCSIZRpjLQADc40
 9qdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkKViZplRGcMoYSNnVCcnGBtCtGdciU/qT43Q1wZV1Yk5TeHDuZ8jnaFF1iE/WZ3moKWU3Bw9t0yM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznKLJmUC6UU7U8DHpbrlE3527d00/1gD2jicVZAFGtGcoDHOQs
 U/I8isNzP5Y2rUSRckQjep78GbL5DOHgRRBBI92u+Yxe6LAqn+KTcwWQH3MHAMiuY3bF6J0I05Z
 Kcxh3rFrsZuFcPKc6hiov4YoPvgWCduo=
X-Gm-Gg: ATEYQzyDKw2EQAAKaVG7awjXjcx4mwSnPcZxFgGx28dktMJHDAkZIxUjPWPrwqZguJU
 Ad6XsBuGdoAz1ZepZ2HB7+EfFOyx73fW/ZaKEOmSDZrdr21zGi1shPDxFBO2D8YTZHMaFH8W+tX
 tBMmvlkNl4hCeMc6gHt7x85MudwLAuYDh4gZWfhpwiO4eAB9z1LWpKjTM4FFntrQxy753ozJkmy
 lH5AsqHNxuA0lXUjZnevK0rzBLtvUNbl3lY+LV3Mz6LRPM4SJ0j7jqT8tP2h7AmwXXlwln8VLP+
 jIrr
X-Received: by 2002:a53:c052:0:10b0:64e:a220:295c with SMTP id
 956f58d0204a3-64eaa6de30amr3530515d50.23.1774030550487; Fri, 20 Mar 2026
 11:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-34-jim.cromie@gmail.com>
 <177402491455.6181.14143715499365255565.b4-review@b4>
In-Reply-To: <177402491455.6181.14143715499365255565.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 12:15:24 -0600
X-Gm-Features: AaiRm50oHJtX5DOcrlwYqkPT1yywLsHi6Mo-IWiyIyjkVSYXdjkPbyeG6tTGqzc
Message-ID: <CAJfuBxxJBPxG9uYp2XrKF4952ika8AitSUq=ExT0N+_VZqKEAg@mail.gmail.com>
Subject: Re: [PATCH v11 33/65] docs/dyndbg: add classmap info to howto
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

On Fri, Mar 20, 2026 at 10:42=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> On Fri, 13 Mar 2026 07:19:58 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Docume=
ntation/admin-guide/dynamic-debug-howto.rst
> > index 0a42b9de55ac..734be0b5fe9a 100644
> > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> > @@ -218,6 +211,25 @@ line
> > [ ... skip 13 lines ... ]
> > +
> > +.. note::
> > +
> > +    Unlike other keywords, classes are "name-to-change", not
> > +    "omitting-constraint-allows-change".  See Dynamic Debug Classmaps
> > +
>
> Why did you move the class description?
> Is there a way to add a link to _dyndbg-classmaps? (I don't know well the
> rst syntax)

I think I moved it to the bottom cuz its the latest keyword, and the
longest description.
(theyre not alphabetical, they could be, should they be ?)


>
> > @@ -395,3 +412,98 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``=
.
> > [ ... skip 45 lines ... ]
> > +DYNAMIC_DEBUG_CLASSMAP_DEFINE(clname,type,_base,classnames) - this map=
s
> > +classnames (a list of strings) onto class-ids consecutively, starting
> > +at _base.
> > +
> > +DYNAMIC_DEBUG_CLASSMAP_USE(clname) & _USE_(clname,_base) - modules
> > +call this to refer to the var _DEFINEd elsewhere (and exported).
>
> (if you reorder the patches to merge the "basic" stuff, don't forget to
> move the _USE_ and offset explaination in a second documentation patch)
>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
>
> --
> Louis Chauvet <louis.chauvet@bootlin.com>
