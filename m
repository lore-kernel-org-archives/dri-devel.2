Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984E260A3802
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HPiulKq7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984C210E104;
	Fri, 23 Oct 2026 20:01:26 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D27F10E26F
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 20:01:20 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-194d0c31715so2288c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792785680; cv=none;
 d=google.com; s=arc-20260327;
 b=szhCoXODVBvQJOH0RvTrjPwG3wTifRLoJDMcNx0mgiLxZ6jQOve/dK8xiE5iAP52gQ
 UpcwuyVHLRkFxMKRfOAKat/FCJ2LPnX4M+a2On2SSElZHII5v0rpXQS1dNPWHB3VS0Kw
 tJ2XwAlI/HOIndbTFL82NIsdiJQReESPmNZg2HjfzumwtaTJzQZyndXrUG4zQBbA0dB5
 uYSYdM3XM+SyV6bONPBFqVvP5sGA070NB4gxZoudOxccB9TJMrp7eAIm8aNh8LwU0H1d
 2Xgo31K0GyzKPC6FAAqar6Ro9dpGdmQhE5qUJ1zPxBJBGXln7l/RumK+BzrQQISozuuA
 PuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=R6P232PvLRYTH0fZdfO+3AJcU5WVHpT1tzKpJhoLyzQ=;
 fh=UQxyah0DdRHbSFcMGhpMXT2qQzDq64C6+pqgjUi/aYg=;
 b=b13zY9CGjPV2PE9xKFVRB8mJE+SIFwnlW37jNuwx+vG9zhJntJGz5ORYcD+oqwYRkI
 04wZr+TyRDNBgIohfiZSwVW+I0S/+lKl4cpTXaP274mM/pCTyap5NtZtwDNOPUsS0i3u
 7GXZs4qYMu9xKkqyg+agQ9QS5TiiME3C4CjzcWNK8SWVXB2ePizwCPakk0wxf68yM62X
 OXQGGlmbCUfee46Zi6UBmCXDyfXdaOp4C6ZYFsSs4KueHJygZs2rw68BqLU6R83MT+N1
 IC4D+t5Ytg01ETALjeZRnu21OWQm9GxzFtDS/PIFHaPK88DuO6PCaYqDsfwDmwyYvwaa
 9hMQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792785680; x=1793390480;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R6P232PvLRYTH0fZdfO+3AJcU5WVHpT1tzKpJhoLyzQ=;
 b=HPiulKq7wysrb4cakFERae6fEajr3qC//SHm784iXUJdUlD2/NlJEUryoZLhVwOL51
 X/WtiRLNvP3EcBThB1wNbJzeX3Y+3von2sUhwKdupZHh/snHMD+Pl2e0Hr8/p2Y8aPEr
 lO51nBcnIm1GLVp4N1Wbt9z30yFpi0+kvzevnsoKZaD7c15Iq06+wDka5GYVV7fr3J48
 7KiSlByXA74YIMJC6TjQd/xd+tPox2H+81WU0iJCbTxVxM9jX+a30GdWuCDOO4o8dJhN
 jyP/poB61uj5VBwh7o29nd5N3AyFlpIZwOzNYdq+e5r9DUBeePBLp5qMG146SHG9I0s9
 BmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792785680; x=1793390480;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R6P232PvLRYTH0fZdfO+3AJcU5WVHpT1tzKpJhoLyzQ=;
 b=M8AeTq8JRa6TjQn6nGQ1oz8fHX8DJ8Pv9wTEEeONbsXyDgjc+r7QABoXdRFLDLsLxT
 jwOFKk7qH4WqfySsrNC1rr0hpLcXm01irSoNTGeLfFuid4XLc4XcRaEFTOX4TZfikYj+
 eZcgOFGc7xMxdjp1XaT70nu+6PnQaD8ammofdtOXlEECyxn/UHShSCOpwk8Ps0M7DDO9
 8mBNKEPAEuCCUGj/4JR+5nueHxvDx/exwZubcSa+swhCAjYBuqQENyI8D43Xw73y/PX7
 3cYHFZQKN9oInsPzAV5Qq9FftamEms2U13G+hTfvjLfktG+uV+K3QdIDWiRRDxJvcBnX
 qkUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzy+ZCm+ibBRfqMa4qz0srBDhoKygPdUtStr6fAySyNdXpPRWFKG7vdSqo79yOLCKnHvztSENp9Lg0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI1V4nF69ndcWwzMdgmsTwpU85C4vzFDdnNO31jxxyxRxvBd265
 wAdYMdCJL4Ds+jcPwsap/j9lYyO3Z1DWI2OPU8mFYHgML9ZdNTkAfstZG0U01Gxwu1zIWfa6v2s
 RVjsSKMHz5D01k7Ql/pUdMW0PfekZXK1tmac3lqoA
X-Gm-Gg: AYBFou3EsgjOKJ2LiujdX389DFM+m9OqTQJX6fnED3IvCqbqk7jp3uoGA5BQsa+Tm1X
 tgfYmfWt189ibk6S6iighqRSsXKA0MpUvcx/fi5G+DY/nnohp3o5ujhzI8UeKaLJJ5DzmSJWXKy
 jA7XTjm1I1oqogFJvXD5L12o0h/Z4UtPhZIahIkBj7AUjUU075OlUmyndlfauhl5ZuDYIb0cFt4
 cXr66/qAQ/BDUuKVRXCH3gN3s95xudE3NY6nhRLBgoQRdBMcX2WTi+PCAQVyPtfxilksw9PC0sK
 qqweP0rqaXlpQbLmv4vmDVcs46P4oj+gVcJeARI41nPvVYLVJW0BozKle91Nwp/f/U8IaeiV+Vs
 eaAU1klX4JCFw41O+oFo98ZtS6gx1R7NAV9Pa
X-Received: by 2002:a05:7022:4587:b0:184:6afb:b26c with SMTP id
 a92af1059eb24-1993fe82542mr15165c88.18.1792785679160; Fri, 23 Oct 2026
 13:01:19 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com>
 <20261020121858.3b9107c5@kernel.org>
 <CAHS8izPwWT+vbgAe49m5vXsRxT3unbfjLTkVZBScgAPdQTo2dQ@mail.gmail.com>
 <20261021132304.23e0a4e7@kernel.org>
 <CAHS8izN_N25mm9vALax+P+W45gyxVoMbZoTXW3r6nPC2Z0A7JQ@mail.gmail.com>
 <20261022181911.5d19ff13@kernel.org>
In-Reply-To: <20261022181911.5d19ff13@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 Oct 2026 13:01:04 -0700
X-Gm-Features: AclHuK-uP7Gir6yY-QN4sOQ103425f3gALMoJmdo_Tw66r7N7gb2W22rdmAKl0w
Message-ID: <CAHS8izOTLYU=5sfJvpwB57Bp3tJ=xt7Gwws5xCVqABFw4T3WUA@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
 Stanislav Fomichev <sdf@fomichev.me>, Taehee Yoo <ap420073@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, 
 Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 6:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 22 Oct 2026 08:41:43 -0700 Mina Almasry wrote:
> > On Wed, Oct 21, 2026 at 1:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Tue, 20 Oct 2026 23:17:34 -0700 Mina Almasry wrote:
> > > > But on the other hand the test coverage is nice, and maybe one day =
if
> > > > we add enough devmem support in netdevsim we'll be able to fuzz the
> > > > data path or something. Is there a way to get the best of both worl=
ds?
> > > > Like put a comment on top of netdevsim that this is test simulator
> > > > device and any missing functionality and/or bugs in it should be
> > > > medium criticality max or something? Or is it too much trouble and =
I
> > > > should drop the netdevsim support and tests?
> > >
> > > I already strip Fixes tags and apply the patches to net-next.
> > > But it's still a burden. If you're signing up to fix the issues /
> > > review the slop we can try.
> >
> > I'm more than happy to help but I'm not sure what you have
> > specifically in mind. What I was going to do is put a comment/readme
> > in drivers/net/netdevsim with a note to sashiko and LLMs, "this is a
> > netdev simulator, used for testing; do not call out missing or
> > incomplete functionality as bugs." And then hope that the LLMs and
> > sashiko pick the directive. If not, I can tell patch submitters to
> > ignore sashiko code review bug findings in netdevsim. Is that
> > sufficient, or do you need something else from me?
>
> No, the fact that it's a test harness only impacts whether fixes
> got to net & stable, not whether bugs need to be fixed.

Ack, I meant like if the bots start to consider missing/incomplete
functionality as 'bugs' when it's actually missing from netdevsim on
purpose because we don't need it for testing.

> I was expecting you to keep an eye on the list and review any fixes
> that come, basically.
>

OK, I'll add netdevsim to my email filters for patches to review and
see how it goes.

--=20
Thanks,
Mina
