Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95313F54AA0
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE83410E6B7;
	Tue, 24 Mar 2026 13:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ahlLYRIN";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC69D10E6B8
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 13:21:13 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2c151551a6eso22117eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 06:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774358473; cv=none;
 d=google.com; s=arc-20240605;
 b=A1T2Mc1WBsAQs2yzpQFX4F2hz2eUp2ufrXyF/6fXZkNQIjFlceRN8P87/Nvz2W7phx
 QGuiDxzRIgLNkQE9VS8UfEuwP6zNyMn7LxRsqE1hM5pkeJy7ZQnB4nt3Q/JyDTYsE/gS
 o8ahx9pAPwdpHmL/7oDBF5vFd82kjR8EcG+DM1eaJTetpPDHZlelOUWVpehL0Cj6UeZY
 8y1ZCe2lyGZLVpp91Nd/uixHkRACdZQpNNrwpx1yVU2UuuNa31jQnIHgVYJCPJoNi6QS
 hkd8n2hvrW3yH1BGBv3RH0PJWCKjlhvXl0I1bSEjeauzBZlTbBQzgm7cvHoSL6DKy5BD
 YQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CutxZk0UywMMX9SEC6rWk5Mmx6PoN5/HmY4U6NLKJsA=;
 fh=pMiuNguW75IGYga0HiUq1CPZmKesGFhBs4kucZgZBM4=;
 b=kL+u3Qb1qBGgPi8xDaavFSFqBoa2G8+LRjxkfk3QXzp07dAbqMt5824rkJlCzrnSXZ
 cxtJbMf1+ONiUVWDyWTrQL2HTmtNpNyN9jHLr4OK4iQnREAuI8gybVlhEq3n+GZRbsxa
 f2Q1q4h/es7WkznIR4zdRo13owWt+5fS6MChXVW8MtTxjKaNoYzXA9/SggmGTtfbMYtZ
 iEMNMu7ST1qXWZ+q0w8w4DQUqsOTPEY3kZ0coRyucAhyLXNjGyA7UmyKNq+2v7NhKq9Y
 6OLfbcWa/nxKgzmiZJhDMdztZTgMisb2Ywr72huZeqmYlIJ+exhiGw6HIsRAoAaRsUco
 Xzxw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774358473; x=1774963273; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CutxZk0UywMMX9SEC6rWk5Mmx6PoN5/HmY4U6NLKJsA=;
 b=ahlLYRIN1ZudEmBhLHheNKZaz6xMm9fSFXZLIPOnmq0aOy1Dy5v5ZDKYgPM4HaN63t
 PR0GwN5qOEVzwcNYp3UFoTcLQ0TZQz99gKvk0LdIHRRt+tWDPcwcF95/+EPYhX4x0Egs
 3PN9gNMZ+ED6xdiu5cy9oDdC91JHKNZNi18D7/vwExhvAQi6pwlilb4f5RTJDXKvhOTu
 cbHnbDnUa5p2WnutNt3343bErxmb6gmihjwkfCCHfDrM0eWKbPXx35dATHTEKcPmSTCs
 BNgVFyoEhsMgDVIDYKtMfmOUMz/UTqdBb6/uQsszf6deKU9wohgmm3mOmM3ZlA44ttbM
 MPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774358473; x=1774963273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CutxZk0UywMMX9SEC6rWk5Mmx6PoN5/HmY4U6NLKJsA=;
 b=ERzK8jBo4cdDWhCS8rNvcSrPewOe4PA6QY64LycEBvLX70TtRM5WMdNMcvXhiO3Vck
 LqcO8so8wD4KXBVW07vL2Wkj+wLX8UvSsN3Lx/fM1TW8OkxAwbxCtPjmkHI+zKo/ZCin
 sT81L1OxXWq0tUKnGbCfAucZnsU6weaS17/SOv0tlNx4XsIoZjh9yIykxQJFyhLHdFa5
 rcZYM7JxuqklKd/szTx4B4nXLNMcKtbRnijipwHeAVQM0iDU/72+RCiJv+v1PC6fRJlT
 JmhYwgPRYQShsBOoMVmY/8WcZ2IBc8pIfbpnEi0is2Bbk1LLgt9Dp2Mywit3jnKOz55a
 +IUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB64AbrqnZZfYQNiXkXKQijFu+l6Mth7RjLh+2IFwD+SJxTy/5aHRyNR98MegZvbvCsMZTrMHYpqI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEUJSZI2FB5Xkbe7Ukg1i64UEon/5rmXDlEnam9tOpPkmC6kfB
 Fxi6ll6EudOiwA+x+L79+6OMdWp3U14VFjv9s6vmsD34F9Q33bnj8i+UZiqFHJJX/lOON08tP7j
 ej9smFGW7tzEEXOGlHXWRg4vNCkcm4Z4=
X-Gm-Gg: ATEYQzxL/hvrzKtEY7AgPKEyex0efamTGXszspnLZdmjg0NcCLAGDgMjmX5uRjUgzAn
 mgXUMdO0xCQzUf2/iUen74aniCSj+17WCdSzGhDlfDS50+ZbwVhYFSKtZT6fTM8xUR497aghTIy
 OkjfJ5+s1PIA/cb+UpYn0aoOzdnLVO8jQ56ZBe+ZZp3Abm7iLMxrMciKZnLeHG+xiQESS5H7Rbc
 nPzI5TxRcht0+CtYzaqmKpfckrinlJQv23dQd/jdQ1tf6tA3KYQ/4zBxZMzWneTiohA//GJl3E4
 5JfE//oeDER9IV8Clp2xy9xfAIkd8aAKXmd8LvhA1/t6cfoFj0GIeZvGd3RVytqMOsSXnQ==
X-Received: by 2002:a05:7022:6b81:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-12a726b5c4emr3201201c88.3.1774358472868; Tue, 24 Mar 2026
 06:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
In-Reply-To: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:21:01 -0400
X-Gm-Features: AaiRm53DpWv5pr0QiHY6HEkx6D6NV3ewBXmw1gn7c17yw41TFZ5-avxtdFneTm4
Message-ID: <CADnq5_OTKJCJf-szPfak1r04fawGhJ-9H=Uzvyh3dmTmP1KYLg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: Mario Kleiner <mario.kleiner.de@gmail.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, Aric Cyr <aric.cyr@amd.com>, 
 Anthony Koo <anthony.koo@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Krunoslav Kovac <krunoslav.kovac@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
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

+ Harry, Alex

On Sat, Mar 21, 2026 at 1:29=E2=80=AFAM Mario Kleiner
<mario.kleiner.de@gmail.com> wrote:
>
> Commit d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to
> round") degraded display of 12 bpc color precision output to 10 bpc sinks
> by switching 10 bpc output from dithering to "truncate to 10 bpc".
>
> I don't find the argumentation in that commit convincing, but the
> consequences highly unfortunate, especially for applications that
> require effective > 10 bpc precision output of > 10 bpc framebuffers.
>
> The argument wasn't something strong like "there are hardware design
> defects or limitations which require us to work around broken dithering
> to 10 bpc", or "there are some special use cases which do require
> truncation to 10 bpc", but essentially "at some point in the past we
> used truncation in Polaris/Vega times and it looks like it got
> inadvertently changed for Navi, so let's do that again". I couldn't find
> evidence for that in the git commit logs for this. The commit message als=
o
> acknowledges that using dithering "...makes some sense for FP16...
> ...but not for ARGB2101010 surfaces..."
>
> The problem with this is that it makes fp16 surfaces, and especially
> rgba16 fixed point surfaces, less useful. These are now well
> supported by Mesa 25.3 and later via OpenGL + EGL, Vulkan/WSI, and by
> OSS AMDVLK Vulkan/WSI/display, and also by GNOME 50 mutter under Wayland,
> and they used to provide more than 10 bpc effective precision at the
> output.
>
> Even for 8 or 10 bpc surfaces, the color pipeline behind the framebuffer,
> e.g., gamma tables, CTM, can be used for color correction and will
> benefit from an effective > 10 bpc output precision via dithering,
> retaining some precision that would get lost on the way through the
> pipeline, e.g., due to non-linear gamma functions.
>
> Scientific apps rely on this for > 10 bpc display precision. Truncating
> to 10 bpc, instead of dithering the pipeline internal 12 bpc precision
> down to 10 bpc, causes a serious loss of precision. This also creates the
> undesirable and slightly absurd situation that using a cheap monitor
> with only 8 bpc input and display panel will yield roughly 12 bpc
> precision via dithering from 12 -> 8 bpc, whereas investment into a
> more expensive monitor with 10 bpc input and native 10 bpc display will
> only yield 10 bpc, even if a fp16 or rgb16 framebuffer and/or a properly
> set up color pipeline (gamma tables, CTM's etc. with more than 10 bpc out
> precision) would allow effective 12 bpc precision output.
>
> Therefore this patch proposes reverting that commit and going back to
> dithering down to 10 bpc, consistent with the behaviour for 6 bpc or 8 bp=
c
> output.
>
> Successfully tested on AMD Polaris DCE 11.2 and Raven Ridge DCN 1.0 with
> a native 10 bpc capable monitor, outputting a RGBA16 unorm framebuffer an=
d
> measuring resulting color precision with a photometer. No apparent visual
> artifacts or problems were observed, and effective precision was measured
> to be 12 bpc again, as expected.
>
> Fixes: d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to =
round")
> Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Cc: stable@vger.kernel.org
> Cc: Aric Cyr <aric.cyr@amd.com>
> Cc: Anthony Koo <anthony.koo@amd.com>
> Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index c9fbb64d706a..29db5404c4a0 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -5056,7 +5056,7 @@ void resource_build_bit_depth_reduction_params(stru=
ct dc_stream_state *stream,
>                         option =3D DITHER_OPTION_SPATIAL8;
>                         break;
>                 case COLOR_DEPTH_101010:
> -                       option =3D DITHER_OPTION_TRUN10;
> +                       option =3D DITHER_OPTION_SPATIAL10;
>                         break;
>                 default:
>                         option =3D DITHER_OPTION_DISABLE;
> --
> 2.43.0
>
