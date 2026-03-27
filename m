Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC4910F285E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E00D10EEDC;
	Fri, 27 Mar 2026 17:28:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NfOfyk9E";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7828610EEDC
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:28:15 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-127337e3870so174951c88.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774632495; cv=none;
 d=google.com; s=arc-20240605;
 b=KojNKaoTIP8WcAvaNCgqMTQVKYL4/Uf/Z72axOQ7ZrTXR2mdzTG1gdVoh+zQnDj/xq
 aD3df/PYG0piShfvttyyINz1wNI3PtzM4NTwyqwm/PERBE9cZRUUOQAqjHzbIqZe5kLp
 DzCug2DQTDqXPqYJWDQJfkrYuQ/kcjIv+/l3KUuq/FYcYpfIfGcaRPgE1yHOqOYm1wov
 1f6nhZg3Ibs1w1092A4FHsNgeGLhv/yB/a95XwXxtvH126Emf97ILVB604eBN76EN0DY
 dyuN5SycotEndkQWpSpg/tpBWxxQK8l6T1B1LQpz8+vBlJTFaPYaAl+RD42oAnyNfp05
 t7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Fl/30Pozrrpem/yafXqH62BWdDU+A3/vTaR/fO+0gHw=;
 fh=usCJwJi0VAMCRuBQZBI4/Ce8m7urzf2eKVqMnMdqULg=;
 b=QREyZADbJzXe4uyCfm2oUsgR0dNmJyJl0ykHCMfWILv2c/IOflyWldo236wg47785I
 3V2u2RjPIb0SvdGQO1wNvUITaiFeZ6bMp0mDkTxrCOppjpa/GNdoslxTrRDhRERP4DAB
 4r9yhtAfTjcMXZ1LJXWMo/6eJKpKnrOWOwEA885aPHY9ZiuWHnw0OaELbBcJbwl9UhM5
 t5OHhEyPHYip/5F3R/daa0OyQ3cE8+k4DgGtghlLrjeenDH2jGtHdDDZPOWTFqfVLxPC
 PDJvU4XTW7HF3rb9IrQ09W+/zZ7adg3a7bxFyuFEIqoSn4OqCgc+HqaITUr9xGFBjc+A
 QnBA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774632495; x=1775237295; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fl/30Pozrrpem/yafXqH62BWdDU+A3/vTaR/fO+0gHw=;
 b=NfOfyk9E6JhPCtjMuSZK97RA/OA6kcU2Ftyq85HcJYQEKKHvPfeOyNfONM3e+4UDgr
 NWoEeu3qFEkYfrNsry7F/rFXVBQelYddU5Ts7xp/zbmurAQa+DljxtLQsuDwKXutpopA
 q5/OOEhQPV/c0JHtOjlaIduTi20xxugYGp7u1jNzj+ZlV6w81iNiy0KPCZ+eBZEtYhGH
 06bE3oDxIx82qb8wGyKYF2a7jCf0zq4dKk9kdyAdfBNYKACySmXxoP5v3vucvMARefui
 fniDGqHzflQeBqwQo8V3wGBKOCtyyls7rmZXisxG1rnUkw09T8gqjEe6NcFy4thymXjI
 v3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774632495; x=1775237295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fl/30Pozrrpem/yafXqH62BWdDU+A3/vTaR/fO+0gHw=;
 b=D3DdGF/CB7tU3LWEzwuzz+5B6bILS8i104gm1Wv9aYy/fo573tzDLZ9zX5mierGMes
 8Mp+7xZefYrWujbEbzcAGRUaKVoGeg2QZ9HsuZ533oASiDJcAHi9SoFYJ10lRVrdLFSX
 ZHeFmKg/AoMVRopJ+7Bwhs3khwFPClPhjwY4wml989aCN+z+OPWreYFD6tn/TOjxJSmU
 nXZPbGs8biH1veVj8ibOhL1RDZH/edYsxhebojArTSCp4TEky0S05cE7KuHwZgYGjbRd
 th23fgWB9Dqdah1RtQL7HHPPpBG1St2SKpJKAxZ+UCyJ8DuFuHo8kuxAu0lJ7T+FagOU
 u3SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5cBWDxmV3u/XGEWHWC7CXs7wSz+5FR0TwkcyDsE7rAgHc+D7fthqiEa4nyRiUB8suL5ZE+3BF+7E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdqAlyPdgRrJsiZCMYuyfBCQeaQ9qU8ypJsIbqnJRO8TOswJEB
 m7ivATo64/gBQnPjlA/mLTNZ7fLHpu7naiP/kcU71HCbkc/MFiAHpnxPlqWIEvKO7jhBoDe0Ycb
 VSrGI5wwi5Ay9MIitBws7f/Dm5xrat6s=
X-Gm-Gg: ATEYQzyM38jIUhQrr6arkcC7Lp7q36xXnN86+hdnyt5vdCVu4eCS8n8EdCtkUnkOuGG
 3gPWyQXhsXSsH/MmLV1ujyXkkN8xFt8i2IaM/ITMVGDOgAVuQXHe47OHxpTKrD0GfBWw88iJG2c
 eIXtIqBiAuh/rIBf3FAC8djDiXn2bHCxNFUZOHIyq5icAuWhFFhrnyfessK8346g7bP+l4sHtBd
 MD5dJThhcTKCdjDz9fe5t2bITR9KTsWNSlRbajA0wuXt3aG7DoLDz+SCCjAO35wpozoQblNOOa9
 G5gW/D65fMIeSv1Vjlj7yrbYpTmINIxE9CD/Of877e1KKm+UsgBUDCwA66dfjwDFSuY763muzjF
 i+VPzLAg37BcZxuEtrg/aiiHnAnsTaiFqmQ==
X-Received: by 2002:a05:7300:2309:b0:2be:681:91b2 with SMTP id
 5a478bee46e88-2c185f4e132mr930663eec.6.1774632494589; Fri, 27 Mar 2026
 10:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
 <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
 <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
 <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com>
In-Reply-To: <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Mar 2026 18:28:02 +0100
X-Gm-Features: AQROBzB_RVTF4XlQkJ9XF8lid9aR8wXF5WiHOT3rgHJbDAOKcJRtKWbfa3x37CM
Message-ID: <CANiq72ktmUFsdpBUKnU-OvTj7rE5iZKFucubL_1bF1Ws_KYXcg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Brian Masney <bmasney@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Michael Turquette <mturquette@baylibre.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-pwm@vger.kernel.org, Boqun Feng <boqun@kernel.org>
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

On Fri, Mar 27, 2026 at 4:17=E2=80=AFPM Brian Masney <bmasney@redhat.com> w=
rote:
>
> I am not a clk maintainer, so I can't leave an Acked-by for you to
> pick this up unfortunately. I've been quite active in the clk
> subsystem though the last 6 months or so.

In that case, I could take your Acked-by as an active contributor of
clk if you are willing to provide it, i.e. with the "# Suffix"
notation I introduced a year ago:

  https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked=
-by-cc-and-co-developed-by

  cd9123eeb224 ("docs: submitting-patches: clarify Acked-by and
introduce "# Suffix"")

i.e. Acked-bys can nowadays be provided by other stakeholders apart
from maintainers, e.g. people with domain knowledge, userspace
reviewers of uAPI patches, key users and so on.

Especially so since you offered to be a co-maintainer long term, so I
think having your Acked-by is way better that having no tag at all :)

Cheers,
Miguel
