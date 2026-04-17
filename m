Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E99BF43699
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9158C10E2A5;
	Fri, 17 Apr 2026 12:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qpea8p9e";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A62E10E2A5
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 12:21:21 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2d99367957eso26941eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 05:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776428480; cv=none;
 d=google.com; s=arc-20240605;
 b=XkSSnUNk5gaIs7SuyLDMuVAAw85IF3SeZlVpGP1MjVUvNGsi0w74zNVHqAlIlxLVYX
 66MCwbGRJ56Byb61gF7Qv0MQwvbgGy/eWD+LH8dWaVf5+vruCT3dUnzV7H4pn0xG4IhQ
 K9aUEJmG594lYVMKUP3SyYzrZI/j5emUDmJhs+lCLWwp4WeLZFdg7o/oYtTjwk2uyIov
 6L92YrcIdVc7P3J2CItPrFiaHSIYZHyWPSA3xL/fF52Feo44A39MjB36rJ60w56KdJZe
 n8MGTsWxh04vLj8e1QUiQg0yU+xPQgBJuCG04pds4xx2R/ku/WmHwKOE/tV0MZEBoCHK
 zUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rl+p+AaNveQQn7NLxvMrIdc/G5AP3TAJtJkZcc0GLPE=;
 fh=zHNEIBZYGV5eEYeFvwCMFR9yTv8xvVDJJJvu4lQgOsE=;
 b=OtiKhT/p2d6fSKTzO2KX7NQ/fGJSQGdMjsXaKAEZ90GUi1zrM+EDoPh7mz0d7TVPha
 rbdV054ExAmTuBMIa4K9/pW5sTzVwIvq7x5/KyklDAG8UlHYaZoLg/FOX+9mb/awrAo5
 tADZkoHoheCssGy9kSC90EC57vNDNG22krrdnr8V2uG9eB7tJ3cTr7SERtOzS9GAi/30
 m0pGPybR6bSwCw1UBGFaOCdYYPFM6y43955pY8Zc1paroPjy3ZO7DoHKsYtO6T58a1Fb
 Un431ZO4NTx9NYX9iM1ltMIstxDNrJOJEPH1SNhz1x9/ifa4ArQdEv7as5l+ezZiPQ8y
 4Cdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776428480; x=1777033280; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rl+p+AaNveQQn7NLxvMrIdc/G5AP3TAJtJkZcc0GLPE=;
 b=Qpea8p9eRO0ySI8hqD+abD1pqyzTWhN/JxXU7cg4uF/Q+VnAMzLtGUBSn022SXIhuI
 EqTIDw/vaf7+Bs7u10wFB7MDWAh0pp88TV3nlUsw9wRU1JtUpIgxMW1sBqPPC6+IQxPt
 BQh+kEKOYj/zoyfTjOHu0T6D8R8rPSY2S9KBNq9Yr5+59rUTl8ESHj0Y1Du2cpmXKZ9i
 3F7MX/TMeFDhZ70v17lg3aU5Z2rR1prfJv+BI3DA0YRojX3do+8oS15UZWAAzKx81Mcj
 xAScND8wmQn1pRWFRZCTif/GGV7fB0bbVXUEdWJuTbLvbtWRPtH4ckW4wkdsvdXtkV9m
 oWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776428480; x=1777033280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rl+p+AaNveQQn7NLxvMrIdc/G5AP3TAJtJkZcc0GLPE=;
 b=jxEbhn64193z9iUZasIlqWzhTcbD9nu+uszGS9PLw7Ul6TfFAKjdaBUAXU8yxYFOgX
 JrC4v0Xr78eYQo0lN/BEtVSPdB/PTP1yI7aKVbduTTwn0rkOIH4gnmgpJvXjOzJ52SlN
 mN4V1telxjvLeShB3r2iXa5Av4B1IQbYDmKB0kjUJa+tizBRzUlRCtd0sd+2tVANtBGg
 fGNJX3Nvsykw7/URFy6gafB+vfTB4X21+uiaU84eIEKWoZ0pov28uF5QraVlIOq+NM/s
 B5xly7qMP9SrRFsL2jRyw6kJaOXhrpiEk4cop6DhbVm99SrrFzy0/ITFDnJCEoaqw4qy
 aPSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/sAjmhDI6/JWuWjaSDQjCDu0f9rp4NiSlVqK0rp5hdcECCy/Vj+rFXwkPRtF3tff7Exxnb4Buf6Fc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwY6Nnn5soxkWnjxZSeNRzg2ODIsp2Ywp24DlV6mlmY0xO+oEae
 xJvX6k+FfZK/vr6kPSoi+slQ97B30h9AuJsrvSArKUiCanxGAEmNhKw8QilbXvynNsNIIyAOQd8
 boCYJBTvKbRVMSteHZXu8Y6vBADycrVk=
X-Gm-Gg: AeBDievhEO03yiNBCuhK128Y6xtaqEidKYRXj7VpziP6ZU3vUhLyuX+wnvkFpxtdf11
 Kow5YASaawq+jnZkHvt1O2NzQsEj3Iv8NpH67hXDDDR1yqtS23Gkuz6Oq9GNh1J2/H2jOkSn6oC
 ko40fiu3lGnsmBE0BQ1wjmOsiKBYLpe/gTszvK1vomcmfgbs3UtNNl4H5RE6PNzsnf2TXWkA/eI
 DukakMF/kNQkdDwDX3+jiIjJ3oE0NxUHBhj95BeeW9nkalyurw4KuTWNtEVvhta6+dyV0Gyb6o6
 6xfLGYe4NTsWDfshCyUTTF/6cfhuskGPWPZMRHqfey7+sLD6qpkfqwCSeQT2W6TiBlEEUn+H3IN
 8393XO/j3Nl5AA5dABFwJG8Ob4wGkV022jQ==
X-Received: by 2002:a05:7300:d70b:b0:2d4:62f0:b2e1 with SMTP id
 5a478bee46e88-2e452bb2b57mr527795eec.0.1776428480348; Fri, 17 Apr 2026
 05:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
 <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
 <CANiq72k0FXcekxs=E+xLe3=wyu+KHr4yM0wLj1VgtgTUb_K4MQ@mail.gmail.com>
 <DHVEWDBHYKQF.XBXZ704CMXCF@kernel.org>
In-Reply-To: <DHVEWDBHYKQF.XBXZ704CMXCF@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 17 Apr 2026 14:21:08 +0200
X-Gm-Features: AQROBzBxmAoyKatwLVEj-ovr7OXihWaqmDt3TqAdX7jALMUhbTGV97pdxOBe1oM
Message-ID: <CANiq72mNP4J_czVo25d1yRdWxBNFKaT9OPOC7k5EDzZ9YmdEww@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
To: Danilo Krummrich <dakr@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
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

On Fri, Apr 17, 2026 at 2:00=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> This all builds on the assumption that we don't have a process in place t=
hat
> covers this.

It builds on what happens today. From what I saw, Mark merges
`drm-rust-next`, which is why I mentioned it, i.e. to help prevent
something unexpected around `linux-next`.

If the branches going into `linux-next` change, then great!

Cheers,
Miguel
