Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244C9FF4958
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 07:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 881FA10E4FD;
	Mon, 30 Mar 2026 07:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="UCJlryrb";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF77310E4FD
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:49:02 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-486fcc05b20so29659255e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774856941; x=1775461741;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=tUf2hbPu+VAmkpzo0Ox+s3NifzZbHOn/kfum96IvTTA=;
 b=UCJlryrb34U538KMuN9ZaizOwhx+h5nAsxmE97nTp0800eF5f0Up5+KgRYQz4D1506
 xtNmzWO+FWepiYTcrKsmSQrHjtJp2Vom1GL526QnoSa6MEVbPw+Lfe+DX9YRsyqt43HJ
 kQ4/TLUVoXB52Kz5M1W+OtTsoZZAVzPt1k+wR1lCtvLKAIUs46lCROLeKwBQmwFwAmd/
 ivFUTRuAZBWSSvLl4rI/RSxdu69J04pPMz4/inRseP05T1K5XYKHwHBsjJ3nbl/akjLi
 8vXs3pCVOC1NAqPy5XH5mxVlbtaIZq7jVKDM8CG0HPUhOl7OG/e9VA3uELrGZ0ZQ4pif
 sSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774856941; x=1775461741;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tUf2hbPu+VAmkpzo0Ox+s3NifzZbHOn/kfum96IvTTA=;
 b=QuhXZcRQnwhqu52cfOAKpqq9Fx3rNdm7DOIvw3ro1GfS+ovaYUj9D6obmySHfXcjtR
 mZoM1r8YsMWkXWO+vQ5tm5CLJGDxjA9mf0/XkAfa+ZbEXkR9NJTCjYHT2ol7zCvusqVR
 gO6zC+IgYUl8DY0FGr9kmTmBPhnO5WLXdePaRsmCslshWlRc6C6UV/8XvTkHEgrkk0Kq
 Sepm+TfLL8dQE3ujOmH5SV5Ffg7UFLRz2iU/XIoU2zYdabIbzyi9zXGUHDilSdbZ11wS
 q1Es1aVjVrZyaJEwBz7Yyg0DC/pKR0jiROED3NIBAQHmbDaqalfUUDGJLJpw0IYifwgZ
 LGjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC4QEoYjo9QNNpUbxOaT/eh9U31C2ASM6iZp1/yr5i4nMGJbFbIRPsTtiZXdLXrq7wJlmyfnPZrIg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz++tOqL3baU+o3kJpv6NDByGME8V/zndeC5J50DfnYsoqbydlx
 MetX40+ozYIdNX9WZ/1x19OkhFMGoxAaT5E4y65/lmaM9qzhrwBhZdLP89PjY0C+q0ajF9bZnnr
 XbKeng3Jd02jnkeP4OQ==
X-Received: from wmbd19.prod.google.com ([2002:a05:600c:58d3:b0:485:314d:637a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c5:b0:477:7af8:c8ad with SMTP id
 5b1f17b1804b1-487280a25c4mr203908425e9.31.1774856941203; 
 Mon, 30 Mar 2026 00:49:01 -0700 (PDT)
Date: Mon, 30 Mar 2026 07:49:00 +0000
In-Reply-To: <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
Mime-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
 <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
 <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
Message-ID: <acoq7E8NH-ihCq1K@google.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Brian Masney <bmasney@redhat.com>, Maxime Ripard <mripard@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 "Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>,
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, linux-clk@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, 
 Boqun Feng <boqun@kernel.org>
Content-Type: text/plain; charset="utf-8"
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

On Fri, Mar 27, 2026 at 04:00:17PM +0100, Miguel Ojeda wrote:
> On Fri, Mar 27, 2026 at 2:19=E2=80=AFPM Brian Masney <bmasney@redhat.com>=
 wrote:
> >
> > Stephen came on the list and started to merge this things this week. I
> > was going to collect up more patches for him if he wasn't around, and
> > intended to include this. However, since he's starting to collect
> > things, I'm not going to send him a clk pull today.
> >
> > It's up to you if you want to send this in via drm-rust or wait for Ste=
phen.
>=20
> I guess it depends if he plans to pick it up this cycle or not.
>=20
> If he doesn't, then it may be best to just go forward with your
> Acked-bys -- Danilo can pick it up if DRM needs it in their branch,
> otherwise I can pick it up.

The drm-rust-next branch has closed now that -rc6 is out. If we don't
hear from Stephen, do you mind picking it up Miguel?

Alice
