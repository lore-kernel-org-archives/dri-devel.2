Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2027C10F2853
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC0C10E10F;
	Fri, 27 Mar 2026 16:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GjcwLQmg";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E57A210E10F
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774630480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AA7FXil+Trih5c1d9kWVytFuGXphEJXf1NURtb9SB3E=;
 b=GjcwLQmgjRaQNWkNJw2n4LWTxpzoMFftaRlHuOoCw5EB+vSUMl2Sn8W45GpY1TGYpqXbPR
 BQaapf8qL0zwLarFwdoV2UqV1Lw+uZnlHhtBZ83YSy/QS7sPsgFJzRnvNkOYdtG94Tx2+4
 ufAvI0d3nDVSO4mxplDr4edyuBRwoHA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-9SwGG1wLNRyX7-kmtp9DNg-1; Fri, 27 Mar 2026 12:54:37 -0400
X-MC-Unique: 9SwGG1wLNRyX7-kmtp9DNg-1
X-Mimecast-MFC-AGG-ID: 9SwGG1wLNRyX7-kmtp9DNg_1774630476
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b934e96af9dso332609766b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630476; x=1775235276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AA7FXil+Trih5c1d9kWVytFuGXphEJXf1NURtb9SB3E=;
 b=LlyKgRYQ+L2r4FQWqgo/qbRi1sbm4r1FoHergSOVRIdFH2QyZcHc2QNXcBfImCs6oh
 XiQxvVdEaBiKSNEz835VvL2VKKHJDxpCp6f3ylX1OChu5j7Ybz8td8YEjWTbdzxc2Tbj
 ZGPd4lMt/WAeHCKmmY2ujdEU2QD9ieE5XoDA4VH5dz/mWIUaaEUZt3+htfVntzIuUC54
 8Bmu5xTnbvpj2x36esguuaAeIpsj6H+ox0BzYkSHQGEqv/T9op6YLepj3Df77PuaXHgM
 zxxL9olQFGaTvP9L4LoA9XaScoOAcSC4JGIUu8GRnc0Q+VWMc/uCCKroHKM11W3miysh
 J9pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGlRnasudoGleAXoYQxSsbXI4A9LBQvF3cEOtzote3kje4ICZaIFp3SuHF9fRo9yxv3Xe21/kWguA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz684R3G12c2JbUnhZvu5ZcUoVq8KalSxNH1hXIMq/kZGZLlZ8c
 owpNPgzYFpPNlDc06bkTb1FiQjB8ASWrmfCM89bMsKCKWDkI+xLn8FjUy8uba4Tdka5g8VPKB4C
 TtHxtWg0UtfbeGpMRfeGa+I812YhSCe9lVCeRRP3NK0AFaHD3T+fVeqoZhHzI/f4KL0bpF+XUHP
 xeScW/CxgJ4rrfGjzvH2fL3sA0cuX/BnaW4XyfqXCt3zfP
X-Gm-Gg: ATEYQzyF8k8H+ydtVMCGy1/c/mNc5D7DKvigh0jId0IlwAXAU42fZQwo9cdrFnPGzzd
 Mdccnu47p3jvABN1+IB9jcb/nD98D+SqicAAoZVa2w7AIvMe5EHFdSZZT8dztYY1T+E133Ybg3k
 Owqesp0ot+ZrDUMmAdyWrAKa/xepCq8jrSOJdWJlTSm7qtLIJrn8BXbqD8+LtdnXbdWVTZLqNYL
 eqbsw==
X-Received: by 2002:a17:907:c294:b0:b96:e11e:97a3 with SMTP id
 a640c23a62f3a-b9b509438cdmr207733466b.51.1774630476006; 
 Fri, 27 Mar 2026 09:54:36 -0700 (PDT)
X-Received: by 2002:a17:907:c294:b0:b96:e11e:97a3 with SMTP id
 a640c23a62f3a-b9b509438cdmr207731766b.51.1774630475513; Fri, 27 Mar 2026
 09:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
 <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
 <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
 <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com>
 <DHDOH1FXTIZT.1QKZIPZ73YNLI@kernel.org>
In-Reply-To: <DHDOH1FXTIZT.1QKZIPZ73YNLI@kernel.org>
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 27 Mar 2026 12:54:24 -0400
X-Gm-Features: AQROBzBbM13XF9Lw32GUQ1TlyrNM8BNb-Fkj0IVXkv6U0HfbzJXabBJAUaFVI5s
Message-ID: <CABx5tqJho=k88A1L0neVeaiYCXpLsc7UjzGSgAug73ZC_amYag@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
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
X-Mimecast-MFC-PROC-ID: kGEqpJLlJOb2mGv3HW-dj1d11pryfGDn-T0NcFOwEAE_1774630476
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

On Fri, Mar 27, 2026 at 11:42=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
> On Fri Mar 27, 2026 at 4:17 PM CET, Brian Masney wrote:
> > I am not a clk maintainer, so I can't leave an Acked-by for you to
> > pick this up unfortunately. I've been quite active in the clk
> > subsystem though the last 6 months or so.
>
> I'm not involved in the CLK subsystem, but maybe it would be a good chanc=
e to
> offer stepping up as co-maintainer (also given that Michael seems to be i=
nactive
> for a couple of years now). :)

I mentioned to Stephen at the last LPC in Tokyo that I am interested
in becoming a clk co-maintainer. I've sent him some git pulls for some
of my work the last few development cycles, and he's pulled them. For
this development cycle, I collected up some patches from others that I
feel are ready, however I didn't hear back from Stephen yet:

https://lore.kernel.org/linux-clk/abLV9vjYxXsKciHW@redhat.com/

He separately pulled some of that work via the posted patches into
clk-next this week. I don't know if there was something he didn't like
in my git pull.

To be honest, I initially helped with reviews trying to free up time
for him to give feedback about my work to address some long-standing
issues related to clk scaling that affect DRM and sound:

https://lore.kernel.org/linux-clk/20260323-clk-scaling-v7-0-8e7193dc9405@re=
dhat.com/
The kunit tests in patch 2 and 4 clearly show the issues. (I'm working
on some fixes to this series right now based on feedback from
Sashiko.)

I've become more interested in the clk subsystem as I learn more about
it. There are other improvements that I am willing to make to the clk
subsystem, however the current situation has been quite challenging to
be honest. I will help with the linux-clk subsystem for the long term
if there is the possibility of me eventually becoming a co-maintainer.
Stephen can have veto power over what goes in.

Brian

