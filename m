Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DF2CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 349E710EDE7;
	Mon,  8 Jun 2026 07:05:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bTmx1VLK";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3588B10EDED
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:05:35 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-304f8e80b7eso264447eec.3
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 00:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780902334; cv=none;
 d=google.com; s=arc-20240605;
 b=VtTb/WrsKyJcOUVmDFGDqWk7MyE0JpkBDk5OOtbZNJRoHNXT/ovp/lNoUB7WgmESZk
 bD74dzyWOBJZB6IRmQK8ZQoOMhO95SoeJvSTsbbaMmn4fYS3vwsKgej7JRhjkleojrAV
 KxiS6l95P3h/HKi+I7NPG9bOtMUcdtfOAQ6RzVIPPhKj9OafN6cLFpwD3VqbLgao+HEz
 C9t8fdmWu9Rd6cOLTeVaeyQZTAwa6jbYyqFu17GF48SxCh3RSJd8jlkFNb53Wr8F30Dx
 kFfZU/K/feRwT+wEAgx6fqmy2vgj92do7tR3kU05sOTG6XlKlrFv7dh1gZViM5mT1r7w
 eZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9qA/8KwvDeFQOrwe6QRAt2Mp2y/gEjBhT+fubAMXObg=;
 fh=rEP+TqOwvhvz5/GLz4IdXpG+myGTz8BEYkUFQdhuelE=;
 b=f/0xiDsAwg8dzJVz0OM1xzZfsgtjHm8HOFjQJciZUVcCLT9eQ6KpEW3N0ngM2TO02Y
 uq56JwLaf67+J/FbnOOdqVVGEggJ6yTMaPtySjbUYShZWXDBu7wB2ORqZdnOy1SeDNi8
 X1FEJ92UTmO2s4OiFEInn9lXg3fuIQLel2PoAsUhc7Kt9Xiu2oGcQik/D+3HW/KRxCLZ
 DnXM8403UEvnL4I6v2LJXk4o6ut6CPHbnLNFpeZxtycBQNR8L0cPHQ8G0nSlgDOYQzBR
 oLzDPpRV52Ii534DO1CKYR1gfvpHIJrQUUu9n3Y3YglJlMIyfgRDQjgvZE3y9MG2o4Ax
 5jHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780902334; x=1781507134; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qA/8KwvDeFQOrwe6QRAt2Mp2y/gEjBhT+fubAMXObg=;
 b=bTmx1VLKbFO1IU6KUGmA/9RBJbjfUbAW2fTmP5Yi0qXRTMwO6tX0PSmmcLhfYf3/A7
 Iu3WElHh9Bv0WITPMCtvPa+RQGdShtOzW0YK4SelZ3TKVrjELelUo281jwVPspK53vIY
 DSQWgCsqYBvbFcZq5DwlDDcxi6aCEWr/taP2qeb5SbTvLRCJAvijt77KgykQ8W+bY+OM
 lWhx/5rItBUr5VHQ1opqgQrV0DWMokRNHZg7abYdt/Gx83tl+5svwam06cHnSrQL8UPU
 0HsVO1bumQyfmviITNfVYo2j8XrWy86aoRfOG807FcRtVIw4kLxnU/yWJep56Ad4G+yB
 6Z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780902334; x=1781507134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9qA/8KwvDeFQOrwe6QRAt2Mp2y/gEjBhT+fubAMXObg=;
 b=G2y3P72OFkOY/Npo8mF7d2ex0a9zOWb7Rxi+WGwhN8KNLi4ihYkV4XPuQpoCAdrus8
 DM65ihLi1UhI3RkOfail26F3/L76bx5rnRErlUrilEZ4UiIB0MJEeFP1Np4RERIdVpH/
 6oV703sXu6pVRqwSWiaDtzBQL4Jb7mxnb980jQT8GGPt7O4l5JrYXRXGMW6llnYL8NX5
 wv8hmFmlC/sBaxCoVO2Fn/2MVkOup+5BZLR4ejmpwKI6utVrAIee5QApm4t3OKG4Nt57
 CXvhKaKHWPmz3PHF6bJCPRnAQEolcHtkci/Iu7YuI/h8oogJ0zDv5jvGHKqHXoK3jI6g
 VLpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tIbyZMyU1bOnxNpE+2ElTDsSR+UB1OMbcNk99wbd8EWx2wPRoUVKn8D1rW0hK3mx33zX2sGlQfOY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0O07m9azXQKt3Q/3zHU7yWsxGfXsbmisNJvVQ1e/l2RIFDQdM
 a+R5mGOs53zXpth85NjKA1JXc3M5p5V+ciR3Ulk8xSQ1TsPRVtUMzsIJmfj1cRpBJqBX7txA0XP
 F+I/uhZ478M0zMx/oDsC1SkCUHG2tsr0=
X-Gm-Gg: Acq92OF2SAvF1jd3d1ZQ4ySamHMXff5DpnZ2WngBEWnifTCbAZu8hn1NWk4nGKqjyEb
 CnCitKt5PIbaxc8LrchbLk4lC0HO3yfB8WgIdfC4JHLeBWb7RL8vKm5xG0KS1ltMKNSWymlAX3s
 /eb/rv6Osefbzo3tUPHmatRoWnPyBdCsa3dJGOw55xirHufEZquavy3JenEz413I5/7TJ700/E7
 2Z+y71WUyhg6MqTDlDiM7wQb3H0cFGMk/ntgxCV0a5J1RzvhtaU1UGwElwUzcKc8ThvBaOHgvko
 n4+8lHRbOY3zIqgJcv15LoKY5ddBLSj81qjhsOCYhYs9NvK+CVsLnykSTlwN+/gR0Ngco1h+YNM
 kgoaTtCs18ursbzWMx5AwKat3lDolgCfhLGrpuUvVr1BI
X-Received: by 2002:a05:693c:3945:b0:2da:a813:a629 with SMTP id
 5a478bee46e88-3077b223afdmr3473571eec.2.1780902334313; Mon, 08 Jun 2026
 00:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260605-nova-exports-v4-0-e948c287407c@nvidia.com>
 <20260605-nova-exports-v4-1-e948c287407c@nvidia.com>
In-Reply-To: <20260605-nova-exports-v4-1-e948c287407c@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Jun 2026 09:05:19 +0200
X-Gm-Features: AVVi8CeF1bmJ1otTtbNunaCFacq0cljAH1ygtuYHCVlQ1ktOIpRSg0gpBxWAiuo
Message-ID: <CANiq72=ceH60sCPs7UWDXQiV8GLznjDWsCKFa6k8O4exFEkW1g@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] rust: inline some init methods
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
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

On Fri, Jun 5, 2026 at 10:32=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> These methods should be inlined for optimization reasons. Failure to do
> so can also produce symbol names larger than what `modpost` or `objtool`
> can handle.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Applied to `rust-next` (just this one) -- thanks everyone!

Cheers,
Miguel
