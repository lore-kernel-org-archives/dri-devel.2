Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011AB606A32C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=utuLtguc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB3B10E377;
	Tue,  3 Nov 2026 02:06:02 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD5810E377
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 02:05:56 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-91b8306b9f8so63922486d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 18:05:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793671555; cv=none;
 d=google.com; s=arc-20260327;
 b=AxsHxjhhmO9w7uUGmeH+D6oOqBhlMZ8kOL/KSqqarBt4N2zSvWZrqLSV/qXR07VGPL
 ZnhsOxW35iSr40L82m04tH7KLLmngXEDNj3YdwVZCUi0Jwsq2wD+zz5N3DFstQVFjdcY
 oCzMYygaQk8xei3h/lIEigoe6UDa5ByOvl7Cm2kyPntEdgjGVByYINvjGrUiAh/5TNfK
 IhAdRN4ukWRksqkrQntCR7G135k6y/Z9B43RmMWfj+p5yRpAmbOh+pketn7BnIKIfozt
 ppqTETR9K97LQRsVGovXzZANfV65ZB43TysRG9E3GJqAP4TNZ+Yzbxugq9l27l+uwWOU
 tXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xKtYIIN3BdzhbeJocKMQ0P/NsPFcFnFc8kTjqddwAE8=;
 fh=sOrjKUUQb6Awt+wz2alQyr9lEOtadNjh+wyIDsohJ2M=;
 b=YqQkexu/pg0jFi0oKdy6tCeZ6dc6WEfmwLR0HWOZiA6sN5+a3aYPI1IO75ehpAhiFa
 d+cG7+nsqdkmzpqFoygTxAcRLk/0R0sy0GkmkvyJx55Ujd4Ho+xrGm3X1pHFW3vhVL43
 FFakPgREpgN9IPxaqIoT74S/44xiDXlzvevtd0/moAE/VEb65Js4e1Dj+oa8kBLMLPaO
 4jQiX7cM6JkTEnckLOF3Yz1uEGg2IDX8+RmYkMLOU+1k7hWAKXFOQ9io3xnoVHjz73TO
 TjkGxQ9aF33yGEcWdtKJ+YHccIiN/EzJubRBtqXTUxqWWk8/Bz+/+e2A4wKM8k1IUbVe
 sp5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793671555; x=1794276355; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xKtYIIN3BdzhbeJocKMQ0P/NsPFcFnFc8kTjqddwAE8=;
 b=utuLtguch6k4B5ADXGi4oYvYffy3ddDEGnVOh+RvXG8IHVm/y2pd3kyRDrFjJLXQ/U
 p+W09PwihpdfBWjRNpemU1WXcQ1Z5R/rO6FghWZoGM8AQaKaSQAtfD0t4rBCh8KITYN2
 +PCDApwre9PuVz4UZNlIY+CLzyR5hajM7z+I+bYqQlCrZCTCfL3z3bRd2gZPcA4O2BdA
 fXJAGZYGeI+EBPV4o5zfv55zlwH8b6ktTwBlCrnM8SlaJUsyBQ+dwUj/ou03qWnDNJwK
 3vD9Tezu1+qJEOgo+z/rpATfx1aFvYkfTHkl57e7aWXVHTQhzkFGTFJl/+wCsHeJP3mf
 Nhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793671555; x=1794276355;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xKtYIIN3BdzhbeJocKMQ0P/NsPFcFnFc8kTjqddwAE8=;
 b=ZsgRb+Gw8hhyvJQ83tCeRCTEiQbOic+Mb8SYF6/qg/8c/RFBpTUrs2sgH1IkLDG5pI
 O1VIjGP99fiu803pYaHQg3b34d4dyAKa8w9ufvzTWB6ehaBaccp5h/hKiBJF68D+14c2
 Dba/pVERTvmp1Vzv50jWuuXaSZZSBHgphxo4Fvy5cRr63sRIANfHJmKRXe2STb1+dYYs
 TRpM6kgMYltZkd1GEDpvUTEyts6JK6ois77aAMRnhkk8st2f3yDLSRaXqXFgoW7h9wLr
 qLj2CzuiPiTVjS9wgApe9XjEvzxj5YniPdSd1a669QURa7OQN8nGRbPeO8tOWUCDhq5u
 uxDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz96b4CDUZXxCCg+2rLd1EoK8khpg1XtJyLDS0mOTpp1KP62CpKJ4evZu08Wkrp3HwoJF3JUtSkO+I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+AkTvS1ygQVXlRsIePp+6Oln+DZ1H82nx+zNhv+DLuU+x6XH/r
 AxPsi2oxaI44R0d8O3YE711jrOjw34JwHNteJ0Yxce6fzQ55BvF+pVFECYAn8chKTmy9t9iCD+o
 tOZ9z3WBojbMKgupokE/fM42ga1aJZrs=
X-Gm-Gg: AYBFou0gMcOr32ImaSTKCRDtF4x/rYlvjRuLKtyTTcf9Q1NG6K4esG559O3lUiWJlZm
 EQAppkc9NiYf6gVlZ8kWs+eGAUUi9ujQmfk3X8wlApvFiyp79iIhYBVE0mJ+Djhj/P1vCDehahp
 OGkWkPlEC9eGDs7MKpBHUP6bxsz8H/DQu1pdpzyyME99CW1fVwlgx3ehf9Q4aJ2qo/rQZiidyIA
 8jyJRhsG2a9FQt52jBYMoDImCx4cbM0e+SaewrAshg9AQ2yOAzMQ9BaJP2MTxpaDul7abaO46nq
 TFHU4CI4CDY0vJBlCO4UaySwyXHP7L08kCDW5/b/OACAx37kMeS0C+oV8NSD9gPcFINm6129mA0
 GiDOSzv8X5LT+zV5BSR8dAB9WPsirrnB7j93euYPcaGPX0RcxFpgOFFTxMSzHkPYzJEAcpsOOg4
 U5GXFTikJ3xZkkjCCj4wQLJA==
X-Received: by 2002:a05:6214:2585:b0:91c:797f:1210 with SMTP id
 6a1803df08f44-91ca4c0357cmr191765166d6.55.1793671555066; Mon, 02 Nov 2026
 18:05:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <aujZcJBUyQ7iX_PM@intel.com> <DMKY979I29AF.BS1DF5YAZMOY@kernel.org>
 <aujikV14tF6K1Xqw@intel.com> <DMKZR0YZV1CX.DWVK9V47GR1J@kernel.org>
In-Reply-To: <DMKZR0YZV1CX.DWVK9V47GR1J@kernel.org>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 3 Nov 2026 12:05:43 +1000
X-Gm-Features: AclHuK-th49m9XmX-PUcR9ZjKn7qxL8uGhLaTwwMvc5LLC23wgVb4nKn4SKl7JM
Message-ID: <CAPM=9tww=CJdxzvfUvLwQ6V4uoszg8JrB1XCAcp15upM-xPvSg@mail.gmail.com>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
To: Danilo Krummrich <dakr@kernel.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, 
 linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 06:01, Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Mon Nov 2, 2026 at 8:20 PM CET, Rodrigo Vivi wrote:
> > not exactly... The per-tree check goes away and there's one global rule:
> > the driver -next branches are left out from Linus' -rc6 until -rc1.
> > But this is the cutoff the drm-rust docs already describe and used by everyone
> > anyway.
>
> As a general rule that's correct, but in practice we have been leaving -next
> open for a bit longer (with the last PR at -rc7, depending on what's contained),
> as it sometimes helps with cross-tree coordination for interactions with other
> trees while we're still ramping up Rust infrastructure throughout the kernel.

It might be time to pull back to -rc6 though, we could just keep the
rust tree in -next separate,

It shouldn't cause any extra conflicts, but I'd rather not keep all
the -next trees in -next once
we merge this, otherwise we may end up with trees getting ahead of the
next cycle again.

>
> For a late PR that leaves a gap for stuff landing in -next and only ever hitting
> linux-next *after* it has been merged in drm/drm-next. Exposure to linux-next
> should however be a prerequisite for making it into drm/drm-next.
>
> So, I think maintainers would have to commit to strictly close with -rc6 to
> avoid such a situation.
>
> > IOW, when you fast-forward drm-rust-next-fixes at your cutoff, that content stays
> > in linux-next whenever you do it. The only difference is that drm-rust-next
> > itself stops at -rc6, not when you fast-forward.
>
> Sure, but that'd mean -next PR a few days after -rc6 would need to originate
> from -next-fixes in order to get linux-next exposure. Thus, with this approach
> it just boils down to "no flexibility on this".
>
> Can't we just keep the per-tree for-linux-next branches and just merge them into
> tip/for-linux-next?

I'm not sure need to have that complexity for everyone, but if we need
to keep the rust tree as an extra then I'm fine with that for now,
until it stabilises.

But it seems that we already have confusion about what was going into
next after rc6 so this will lock that down and keep it clearer.

Dave.
