Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331CD10ED675
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C15410E1A4;
	Fri, 27 Mar 2026 13:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="EoMTGkLr";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D5D10E1A4
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774617561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7lSs+njbRqVkVDMgsOfygnKLYu8xaGMK8nVUk8tZOs=;
 b=EoMTGkLriENDY3mzlMPhoQqr+e+3dqXYZX8UuuDMI/hVdBlVBsP2SUZga+L7dp2GbV3POg
 jvA+j4iboZqFL1+NcxluH8tzuSdGKZy53nqs/5XY+XDk9qpUHGYtdcza5I+EVpIoxpfswm
 epVI51v+70fA97whUr2DKrIfyh1FZpU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-leTd6WtOMkKQy2aK9rX5Fw-1; Fri, 27 Mar 2026 09:19:20 -0400
X-MC-Unique: leTd6WtOMkKQy2aK9rX5Fw-1
X-Mimecast-MFC-AGG-ID: leTd6WtOMkKQy2aK9rX5Fw_1774617559
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b938cb02038so241211766b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 06:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774617559; x=1775222359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O7lSs+njbRqVkVDMgsOfygnKLYu8xaGMK8nVUk8tZOs=;
 b=TGW8kLH2qReVl5jaKaHLCI5wDrtjRdilV5de1zWfdiqaAc8xmMtvpp51KsniYunHvi
 VvVna1FjAxNp+jYqneo5nr4Nku8wN7tzBzYU4o5kOcRhOh0oq0Y0nvDdEUZ4k0mITUWH
 jXhM2aZZUbU4r/kq2vgdsyKRwdMv2XpwVlWfnqhTK1xxCms+h28nkR0s2SRDcvXb/3N2
 tzGzI0sbEA7Cdf8FiHx7luMCM6k9Uly/8rQ956COpuFqtG4rB177xrRtzPrJLGSzOg1k
 ThSdUW5rDtc0gTj6lm1uvteRcTIoova2yLKuKFNHNIrUEm9M/qiSrYF9n7DwRCBKke+t
 5Ivw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyIfEr582IkQIZYSwAuYLFudEWWE3kbN9m6cjxiW3NqiZrcS+cO4LUwEmfwRdUOfDhhsxAWNtr+80=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVgCzyOrRzzJCwmaOIBGrrBwXuu3MtFialsgiF57etHDMRj96p
 aY5Pr1HJODcTXnCb1/IrVf1vvaHbPlDzDp3oXubB75uCJ+fI3QamW+T5p+4GJhX+3wfDVFH38+1
 TpddlVHyR4eojgLoE4ikj3uzGY/RlqfgV70NcRfsMgtzOpEJSYvkp/NwDiuX+HPEYylR/2AeNad
 jpfZKsUOW8aOjntVLC7X2aJ8U+JnYGL5LKqyuJckdfFEc3
X-Gm-Gg: ATEYQzyTITMR9CqXJ/trwhNwxaG3MZ4x5tk7Bi+yFSoqpWdchPs75Wmzf+pfeddk/rC
 wDi2eRdefmxzVpWmvb3fv/szFNNAMPPoGtUMM4Ty8Ocg0wm3wuH8Rno8vcRX8fjE/k/c+vi9MRD
 vGZvIzx+AShIwKb18/u+ygvTQFk3Z4aNJHsSsPol8xEuXqmN0p68k/b9Z29hMg+N43iiveDinLN
 I30jA==
X-Received: by 2002:a17:907:9808:b0:b94:82e:55e7 with SMTP id
 a640c23a62f3a-b9b522ae87bmr156857666b.25.1774617558601; 
 Fri, 27 Mar 2026 06:19:18 -0700 (PDT)
X-Received: by 2002:a17:907:9808:b0:b94:82e:55e7 with SMTP id
 a640c23a62f3a-b9b522ae87bmr156854566b.25.1774617558068; Fri, 27 Mar 2026
 06:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
 <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
In-Reply-To: <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 27 Mar 2026 09:19:06 -0400
X-Gm-Features: AQROBzBLIY29Yr2X6VCTB1TmB9iOUiQz4yOfIMWdESx0Gr_aeFF6e9jfGR2ISWk
Message-ID: <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Maxime Ripard <mripard@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
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
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KdNJ-yrAJhsedZ5ZyiR0uaWUBTvYrw8_0fKEbwciAoA_1774617559
X-Mimecast-Originator: redhat.com
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

Hi Danilo / Alice / Miguel,

On Sun, Mar 22, 2026 at 8:15=E2=80=AFPM Brian Masney <bmasney@redhat.com> w=
rote:
> On Sat, Mar 21, 2026 at 2:17=E2=80=AFPM Maxime Ripard <mripard@kernel.org=
> wrote:
> > On Fri, Mar 20, 2026 at 12:43:47PM +0100, Danilo Krummrich wrote:
> > > On Mon Feb 23, 2026 at 11:08 AM CET, Alice Ryhl wrote:
> > > > The Clk type is thread-safe, so let's mark it as thread-safe in the=
 type
> > > > system. This lets us get rid of hacks in drivers.
> > > >
> > > > For Stephen's clk tree.
> > > >
> > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > > ---
> > > > Changes in v5:
> > > > - Rebase on v7.0-rc1.
> > > > - Pick up Reviewed-by tags.
> > > > - Link to v4: https://lore.kernel.org/r/20260113-clk-send-sync-v4-0=
-712bc7d94a79@google.com
> > > >
> > > > Changes in v4:
> > > > - Pick up Reviewed-by tags.
> > > > - Link to v3: https://lore.kernel.org/r/20251218-clk-send-sync-v3-0=
-e48b2e2f1eac@google.com
> > > >
> > > > Changes in v3:
> > > > - Rebase on v6.19-rc1.
> > > > - Pick up tags.
> > > > - Add fix for pwm driver as well.
> > > > - Link to v2: https://lore.kernel.org/r/20251020-clk-send-sync-v2-0=
-44ab533ae084@google.com
> > > >
> > > > Changes in v2:
> > > > - Rebase on v6.18-rc1.
> > > > - Add patch to tyr driver.
> > > > - Link to v1: https://lore.kernel.org/r/20250904-clk-send-sync-v1-1=
-48d023320eb8@google.com
> > >
> > > Alice has resent this over the past three cycles, but it hasn't been =
picked up
> > > yet. Please let me know if there are any concerns -- otherwise, I pla=
n to take
> > > it through the drm-rust tree in a few days.
> >
> > Stephen hasn't really been active lately, but Brian (in Cc) has been
> > trying to pick up the patches falling through the cracks. It looks like
> > such a candidate to me.
>
> I'm planning to send another clk pull at the end of this week and I'll
> include this series.

Stephen came on the list and started to merge this things this week. I
was going to collect up more patches for him if he wasn't around, and
intended to include this. However, since he's starting to collect
things, I'm not going to send him a clk pull today.

It's up to you if you want to send this in via drm-rust or wait for Stephen=
.

Brian

