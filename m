Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF2606A329
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WD858LjN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA8C10E05A;
	Sun, 15 Nov 2026 22:44:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD2AE10E05A
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 22:44:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E00E618AA
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 22:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9A81F000C4
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 22:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794782674;
 bh=/6G/M/AT0gyJOgfB8EJx11GQl1a1nFgjs1t6sNM0uEw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=WD858LjNeviKlK3pSp+WCNm68NBP3MBYkBuMbCZ6zlxuftxsi+uDkoVsrUZCSmPcy
 VP8pkuB0guXcQH2MpRtA1PspbZ10S4SeWw4VtXx2GhP9wmIVbng64+y9ku4iFIl+2T
 kATA3vz717cNRjHbq5l3DPi4uJJ01NyTERCTvTH9qyNAR7Vp1Rt8xa7diOz4Cyk203
 f1tPmIqzEOQxWdkiVdbSPpMbBotZRT2jBPATuq/4tA8H3Sn3udyFuGTB8esnMoBG8z
 8zQsdCj76LmuvWVQOHJ38i9hdDB+FBScmoan2KVmnzKfb4BeA04PHQ141+DdCqvjs2
 g2lghZsCIJlcQ==
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-3adfc004920so30621471fa.3
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 14:44:34 -0800 (PST)
X-Gm-Message-State: APuU4Z8BBXu1/ymDAfqbUOoCazTMuuWtadTD29mpH9i52uZr/0eARmQL
 niuvbz9AwB8qK3t68lGxtvGVP/l3Ujy+3Uu1deClikhvRf4gz5k4moWhXxCUm75lrbzosJvKZxW
 SIdPUTks2G+EoW9JafLBv1gNfY4+QnFc=
X-Received: by 2002:a05:651c:418f:b0:3a7:6090:e0b3 with SMTP id
 38308e7fff4ca-3ae2b4e69b9mr24992451fa.20.1794782673464; Sun, 15 Nov 2026
 14:44:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115-ux500-drm-mcde-powerdomain-v1-1-afdc326cceb7@kernel.org>
 <sashiko-outbox-215719@kernel.org>
In-Reply-To: <sashiko-outbox-215719@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 15 Nov 2026 23:44:21 +0100
X-Gmail-Original-Message-ID: <CAD++jLmk3wX8jn60rgYPzbn+prWESh7DwGUmy5WRAxFsq-fdOg@mail.gmail.com>
X-Gm-Features: Aa3M54oX1H_4B1BZ85Nc9T7LS4auKWWeLkh57cDnNi9fqT55V3hlYKnQfTuLQz0
Message-ID: <CAD++jLmk3wX8jn60rgYPzbn+prWESh7DwGUmy5WRAxFsq-fdOg@mail.gmail.com>
Subject: Re: [PATCH] drm/mcde: Use power domain for display power
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 7:30=E2=80=AFPM <sashiko-bot@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] drm/mcde: TOCTOU race in mcde_clk_div_recalc_rate() [1]

I'm happy to work on this *SEPARATELY* and on top of this one
since this functional patch is important, I don't want to build up a
typical Sashiko-tail of patches after this one.

Yours,
Linus Walleij
