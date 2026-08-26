Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41998C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3241E10ECCA;
	Wed, 26 Aug 2026 12:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LAp0OtKR";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A8E10ECCA
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 12:45:42 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-384caf7b168so109134a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 05:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787748341; cv=none;
 d=google.com; s=arc-20260327;
 b=dCYzwwBAtiAMSYmbhSdWVz3UzM9uIpr37TyJSCnPTumPUQh2D8UVUwmFmDblG/DLxV
 4hCHEB5F3+uXcvE7grfivDq7jW6kuNevvKVfMnNHyzfyvAii+wzGM3zZ0WtWy41EyV+Y
 z0HxcRBQ6NUvFxFGPCVqTBMGMvx5uqVDGAzT6/Ch+5ZYq9n2S9QydxTE4n7llgVgxxcM
 lJ6gS27SWEcvMsD4BqERyL1+wNKB4zPetlfNacRuMCK7zKKFPm+TUAUT8lhK/eKLdLLc
 +F/KpPZkl3eqUruQekL/C98t2Tj06htb9ryBQm6GmBpnTmIm3iOa1pT0vgKXdePHLomH
 EczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Rehlg9L9OKEDKVNBASHXFjO/8t99DdcLutVFyfw9+WY=;
 fh=Hsn2texf4pWwwpZPPQ8W9H49PzlpYI8ZwUSh3o22cUM=;
 b=A7gSXHABxx0o2cF2DBgqljNwi7we/q41gToBAqrjiAYUUVyBR1y345PH2/DYjMauFg
 8OJ0BuwLE74jIJ7rQY51lScZ1m0mLlSPGYDN6clhOPyQCQ+zFFk43WqgzzkPywj2Mr75
 mdEKiDh6vHIaKCQHGekZzjb2P8hu8+JBATSn+4/OzmACpkFNZb3BJZ1y2vO0/GvUbQyj
 WrRShfs3Rrg+Zf1D/S+h/azQZi6H87AL5BLCk+XKeEgc0do+OoNtb3RfJ+mBmi0KxAi0
 1OkLGuIRi04U+b1ZwWWosHWstJrJriGHJ8p/O+afTgl6XWeUvPbMDuqIfi2d9Ilk6IGG
 XOcA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787748341; x=1788353141; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Rehlg9L9OKEDKVNBASHXFjO/8t99DdcLutVFyfw9+WY=;
 b=LAp0OtKRTbgDx4X7banDbBQYMupkKuIbY/OkiDj7zOWCaQ/pcEPrWz9N9++Wab5HYL
 g5LZ26U58+WTeEZjhY+k9Aokr4Dy0AIUJfHMUdIpyhdz9/kAenIgjADuxIhV/1oAZzOQ
 gLjOuD6BDJAKNQiqPWYXofsaOQHBXcfWvBrLmH1ZpUgnrGlKa0q/EDG+a2reLDkIZ7dQ
 /ZFhebd/PG2BD3pi7tZv4QPs+NMSmtqIE6n9nqobT/Oh+7RCqA+4yoLr96DJOcXTJaCM
 6DE1TB4KVmVfoPs0ATb8ASYsTlraVP0pYfcLixbfTzod2p7FyT0nvh+b8oZ6pzC6kIXO
 tNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787748341; x=1788353141;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rehlg9L9OKEDKVNBASHXFjO/8t99DdcLutVFyfw9+WY=;
 b=R3nVIJ3eh3EuegMkrsM5OSrXdHrYYEzGNsqaZWmt5pL/a78J5JYcv9EUuKtjbxF7fj
 Cl9Jd2/3EBrTWnDKHDcZjpushuUOeg7lHIErVWAHC4oL78WrfX5/fYX6HxGRl1qIAcPd
 VV1iVPgksT6JcVrkjkDffN9dOG7UdfCqxQdIqQijeJdU/sPjQwqxgS1kcWemflS0BakV
 jQ/nI6muQspryWV43ANdvMKjMjG4dgIYS5HRQVOwGrX7ivBygK+9LO5kXrDdhScf4p5j
 x2x5SDdYRW0txCCSFZBlM/dLccJ7qmvl36q9kC548JB06tHyKKG5eDEQ2zk/lE1Ot7WU
 ez1A==
X-Forwarded-Encrypted: i=1;
 AHgh+RollDLiJLyQIV/uZFrQdfdIN8x/2TTGyGujCgYIAkeaqd0QRuoqIxLAycfKBGYFKHTXKz5Anm6T8yY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k+sfp6Xm5+DRG8VKgD0fcde7doeSqT3T3Rl1zSgt6m/XGgpYH+
 qVbYW+6olu6tHJtM2q2cJsttlLyQXzc5gn248J4FShd23ApkTrY/BJitQsJ65ozhpETC246SSUF
 6WwDrFWTmSApbyTzy7irjGpt0g16lyFQ=
X-Gm-Gg: AR+sD106nERXZqCKSgngB2NmaIhNPzY//I1xaEUD/ozD0OAtbPCCJZx+F1mXFUIAAOw
 yfMDrIhAUY2kqtZL4VzEDkGA3HX1VDtiAqFW2q2aAJ/Z/e58zdFD9rQPXFwStyvfgRrsbpB7nAd
 pirU/4tnfoGu5H5nETb0oUHafyVUTH0X522OFItEJVOQ28Bxe2Hp3eoEAJ57AqdDdQsgzVO9dGH
 /1JpIvexgmjuDsLkmKDKceUCvs6h5mZ4wKKpeGUGPO+zkbRp77LuAptYOIHLhUyLduD42pl9tsX
 LdX7F9F9LXoHMnQqLFZ2WB7ruwaSOkrxCPX8WjS3p31USoJnZ3gdrNAKVeXbKVxroAtBZrL7p78
 L6SjOqJk9SDBB/uO37cQcOn8/L/aYfLWtJ/rShqjX4g==
X-Received: by 2002:a17:90b:288e:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-3966d45e721mr6855576a91.3.1787748341497; Wed, 26 Aug 2026
 05:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260815180033.8958-1-linux@treblig.org>
 <CADnq5_PgZx7aDGFD5pPQ=1MvF9_N_omVojNiDQFHjs0Tqasv+A@mail.gmail.com>
 <2026082644-monetize-tingling-0abd@gregkh>
In-Reply-To: <2026082644-monetize-tingling-0abd@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Aug 2026 08:45:29 -0400
X-Gm-Features: AcwNN1Wi4qRmt7UZywPFb9Mu4Qo0qCm21_O_0_7g9jDgE2jJYcKlwMDKSsD2hGE
Message-ID: <CADnq5_N0AxaDZswgEQ7BEcKw8mF2hnSbAQp-w9U2Fy-MaEw8Rg@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/amdgpu: Remove is_idle method
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux@treblig.org, alexander.deucher@amd.com, christian.koenig@amd.com, 
 harry.wentland@amd.com, sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Wed, Aug 26, 2026 at 6:21=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Aug 17, 2026 at 11:27:41AM -0400, Alex Deucher wrote:
> > Applied.  Thanks.
>
> Any hints on where this was applied and if it will get to Linus "soon"?

It will show up in drm-next after the merge window closes. 7.4 material.

Alex

>
> thanks,
>
> greg k-h
