Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A42CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00DC10EA6A;
	Wed, 17 Jun 2026 16:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="vPUPKVn8";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F1510EA6A
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 16:11:34 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5aa68cd8dd3so5550398e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 09:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781712692; cv=none;
 d=google.com; s=arc-20240605;
 b=lOk77LK1WerqeZl5ZrCKenWlj1eaJSg3f7Biu/I3wpcPcyc/WOsjl7obxMw8aCfzSz
 P11Ys1GlFEtNDoqa2scFObI4l4+IumZifEhwLu/+fOx/zyx9P/tiqN7gUg5QplJj1S86
 1GMC5DDQht00h0zDO355IYbXtj1JbZyu2Xad+8SoMmTUQo9/G11lm+Efc91d3IGbLGrw
 +uytLkfx1jYgIyhIs3KWNjrjrZ2pL80DxzJ0+GbwqP3ThAbIdpTiTUBNDEaTxW82Tve9
 YBND86Xo4/lI+hjPr6o7KBnodDsv6PJwsWG6ZwRRm71PsFy2xNNsVRrwODKhMIUo87WZ
 RVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FbxtiExNeytqptLECamj8nZU2Ih1BDy/tMyWy90tgSo=;
 fh=LcsjgsZ6NxNtdjjdr6OFe6qnYgtiX9keNaln77zzX0E=;
 b=YxMwIT2mJWGciIWp4slxNfDUcPmMJ1zBfUkEf39Qba7vgPlOrwb7UFxtVp17wsa6tX
 kJR81Wb/J8rIp0+59zFP3admDt8az6fOnQbga45jqRrTsssXB0pAC2uMy75wnCJL0aGN
 5fYT9ylLD544UaCd+R6XXTckRRjjZikYdqwkJIm35s7LQjVItRUFJkGjLho1HftnZ/gi
 16mVe4unitARkUHvd9LXggpVVq+WuXA3a/JoEYTa7VIrs5FestZIHwmHsQRkv55QBq2k
 YqtuTBfyic7C1I0kvMTayOH7xwH5VsTRUMVvI0r+mUbBm3ye6CXkIwRssKIBmxoti7vL
 prdw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1781712692; x=1782317492;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FbxtiExNeytqptLECamj8nZU2Ih1BDy/tMyWy90tgSo=;
 b=vPUPKVn88LoAgH7fTkMh9hLz2LKmOct+LeSFuQmJikfEt2xEkcn0hU5RBgI7UlH96x
 hplUjN1iH/7GFn07WR1FHo6F0cDdpmKg4DIpDM3mIIhJqbgJutwAWfMw3kLIV+Vcux7W
 T9fOiQh8T1vwtfmrcGPBphzsa7QzB+RhV9isDT7zkb3Kc2elqZvw7bs+R4TCbnS/nD9O
 ytIPeX+xuYqtawEgyYtI6/0vTGbZnhw7Z5AhqDEuoNX/IKD/GmqjO/OWChR2SYQWPPum
 d9p8pkEPEeuhn+BDPJ8KSRAqczZm6jIxmPqupfp7ZFMIWC8q5Krt2EX0arWioRchDDY3
 n98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781712692; x=1782317492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FbxtiExNeytqptLECamj8nZU2Ih1BDy/tMyWy90tgSo=;
 b=ZzqnCfpoAom8OswEv41tm1OvkhRYFIi5Pb5RjMql5OGcCvISwJoJACh9V+5HltXgW+
 7T1IQcHtAGFnpHZD7SS1XytL+h/STgZkL8cMfIuv4I1A3Gj/819BFV7aYBtXWz30gco+
 QuuKNCSBnf36qp5LPv1MlY0Y/yT5hFLBbx6cNLWosvqgVgDyz5CNdMAP1DOQsGaKSTWC
 zmFpFdCbL2gdKFwKEOk6BARmqoar4xYQmieK1HNstpexg/SPqTbmeSiitdnrfW9thASO
 aEBed9aYG1q0VQHnl9e5tEyi8tnktpoR5PPX2bS+LPpA87KQuGFRrbWpEsN0bpqS0Ck1
 PLnA==
X-Gm-Message-State: AOJu0YwkZy5pPDcroea/ersoQu3maJ0V379jZuMAmHAtMUUGMNn5+TqR
 QqAv/p5+9t5oWv5d5blttUsdMBvT+j4d3jtRGpC3lh4GgKzIIBEvQt18ggG/l8FH9wIvxFOIDcO
 etqbwh7ionVhlZVLGiluAtuM+qyMb+36t95s8Lrzk
X-Gm-Gg: AfdE7cm7bYF3hdtFa48xtVDuhinSByWwTATFJe0U7SEuTgKUdQs5G3Ckfu3rLyMYLe9
 xZjM9jkUrVyKsYquP74yLhqRH49RsZviZNCodN/8DEjFIwM1nT//dP3aZEgEd3WPxwzPkB+Wg67
 5qGM2KpNN7Quh7l+9Wop8GMr3lQIzSFJ5EmVJh/2mNkWvWdltejBDMHQPT+czzF+SY2Makd3HLK
 CmP7JIaTvNP4abTbYy8bYgikeTu6jdfOPrXClNj+Bx38JZjAJkH+z/+8WwvqJx4TPPYH0sDn8Sn
 KpIAqKqW3xsfT1eQiTtkZZhEPLJFOZKZExJelBs+NpQxfcHJe6TayUrsEmcKMfg=
X-Received: by 2002:a05:6512:3996:b0:5a8:fbe0:bc6d with SMTP id
 2adb3069b0e04-5ad46fb251fmr1391131e87.14.1781712692345; Wed, 17 Jun 2026
 09:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <DJBG3H7N9GS9.7AMMRJIHGHRN@kernel.org>
In-Reply-To: <DJBG3H7N9GS9.7AMMRJIHGHRN@kernel.org>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Wed, 17 Jun 2026 17:11:00 +0100
X-Gm-Features: AVVi8CcFcDGHqaaugW-mrwYkGbb9_qzTBzMSO4VInBVPGc8VnUEcJQgMKOxUIiM
Message-ID: <CAHbf0-E8hm=C7QaegTop3aSZLw13AyPZ00hjsd=vcsSm8xFdAA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] drm/vino: DisplayLink DL3 dock driver (RFC,
 help wanted)
To: Danilo Krummrich <dakr@kernel.org>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 rust-for-linux@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lyude Paul <lyude@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001e940c06547550e8"
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

--0000000000001e940c06547550e8
Content-Type: text/plain; charset="UTF-8"

Thanks, I'll check it out.

On Wed, 17 Jun 2026, 16:55 Danilo Krummrich, <dakr@kernel.org> wrote:

> (Cc: Lyude)
>
> On Wed Jun 17, 2026 at 5:12 PM CEST, Mike Lothian wrote:
> > Vino is a clean-room, in-kernel Rust DRM driver for DisplayLink DL3 USB
> > docks (Dell Universal Dock D6000, 17e9:6006), a native replacement for
> > the out-of-tree EVDI module plus the proprietary DisplayLinkManager
> > userspace daemon.
>
> Interesting project!
>
> > It is built on the in-tree Rust USB, crypto and DRM/KMS bindings, which
> are
> > posted as their own prerequisite series;
>
> The KMS series you refer to is really just including the C headers for
> bindgen,
> while the driver messes with all C KMS APIs directly.
>
> Lyude already works on proper KMS infrastructure for Rust; can you please
> work
> with her to get your driver reworked to use the safe infrastructure?
>
> Also, I recommend looking at this series [1], which should very much
> simplify
> dealing with device resources.
>
> Thanks,
> Danilo
>
> [1]
> https://lore.kernel.org/dri-devel/20260603011711.2077361-1-dakr@kernel.org/
>

--0000000000001e940c06547550e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks, I&#39;ll check it out.=C2=A0</div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, 17 Jun 2026, 16:55 Danilo Krummrich, &lt;<a href=3D"mailto:dakr@k=
ernel.org">dakr@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">(Cc: Lyude)<br>
<br>
On Wed Jun 17, 2026 at 5:12 PM CEST, Mike Lothian wrote:<br>
&gt; Vino is a clean-room, in-kernel Rust DRM driver for DisplayLink DL3 US=
B<br>
&gt; docks (Dell Universal Dock D6000, 17e9:6006), a native replacement for=
<br>
&gt; the out-of-tree EVDI module plus the proprietary DisplayLinkManager<br=
>
&gt; userspace daemon.<br>
<br>
Interesting project!<br>
<br>
&gt; It is built on the in-tree Rust USB, crypto and DRM/KMS bindings, whic=
h are<br>
&gt; posted as their own prerequisite series;<br>
<br>
The KMS series you refer to is really just including the C headers for bind=
gen,<br>
while the driver messes with all C KMS APIs directly.<br>
<br>
Lyude already works on proper KMS infrastructure for Rust; can you please w=
ork<br>
with her to get your driver reworked to use the safe infrastructure?<br>
<br>
Also, I recommend looking at this series [1], which should very much simpli=
fy<br>
dealing with device resources.<br>
<br>
Thanks,<br>
Danilo<br>
<br>
[1] <a href=3D"https://lore.kernel.org/dri-devel/20260603011711.2077361-1-d=
akr@kernel.org/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lo=
re.kernel.org/dri-devel/20260603011711.2077361-1-dakr@kernel.org/</a><br>
</blockquote></div>

--0000000000001e940c06547550e8--
