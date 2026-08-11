Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C625DC5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D844B10E0CA;
	Tue, 11 Aug 2026 14:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="akfbdIHv";
	dkim-atps=neutral
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1307910E0CA
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:26:30 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-39f91ba1ef7so19187361fa.3
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 07:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786458388; cv=none;
 d=google.com; s=arc-20260327;
 b=N097JRbMnAq/F4hiNZn0xLyq9KIP8irjVIRVacmUcGdJSf4sdt71Z9mQXbptoB7p+5
 xPa0BhrydMWZIRh8Jq5vjcBrutli+Ks/cvyATNgLdZR1v5yIEti7zDDDENggeclkmrSW
 FESrZP5j6zHn6x6RnMm8gf4/Lv+iYewkTpMawvxFb/mxs8iGe7bRY5vdgEJ0dwgTD04V
 BwUIWCuG/385T/4IF6zTUF285ZFnz/rhhxBDoFsNPUuLx0Titz/CKCsa6OsRYxf8OPxH
 eSy4lO0qOF6d2LtJO3u6M5dUy6WTGDB64RtvT1DS/qQfGodctzbgObDBXW61VDRh+YXT
 JmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HFsuYiD0eDbBDQjlEIXUzN7jglq6/iPth7nr4XtXjzg=;
 fh=aE+wBCudF/gOybGiYNdGNsCMc8GX1x+3JHzzIbThrC8=;
 b=F80191T9o1pa2XzB2fZjVKdCHPgomoPqxwvS5oqHOu4S5aaL0PyYozLcVGvnSYlxgB
 FdAHsuD539iiI/7O3EoelY9pCuyXbTI+CJQVEkeH3RrG8bbmKMkNwVg6mXD561ykG/Ys
 +OC1fH2A7HvbI2JC3iHXwfcvZEL6cPxXuGzooJ8+gXohUCsvphXwDGD/azmLMnoWi4TU
 x9XAicRbWwqKItnfY7XfGgmfn3ZFxeurVP2VjZDEIjg/0i1ayFwYSBhcKVfzF0r3Lalw
 sk3bI1lGP3zo4S3y79tUwTJyjagFlDcCyicnYOks+DGxEkap+aX6p8k0z5166bt3NWOO
 k1GQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458388; x=1787063188; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HFsuYiD0eDbBDQjlEIXUzN7jglq6/iPth7nr4XtXjzg=;
 b=akfbdIHvrC9sZT0wz/hvJreQT4rfPQY2g2xFDpnTmIY4+KopS5+LXsBoMawpqI6czH
 mCQbUKzoljUrw9GUFomhIK5g6GJERaQ7F4mCgsDg4jXdlHCsLeX48Z8fLNmpCK8Z6iLJ
 JBk/fV8tO/CmivvQx0eXbxglVOi2GTuYzBTxLlqA3bOx6ryueYkHfwDXx3jdvJ8P6CvZ
 mzSYolmJqgw/qyU0WqMyoX8AlDLB9dRq48qGTGC4hkcl6Wgqk6M+z9NZZXqzuL4FAG1U
 05EF/756p2Mp1ZE1KmAlgndfH98m/kIptURjIRrHKjHQ/p4ynN1bRc3TuE3bHO4d5fb1
 YTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458388; x=1787063188;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HFsuYiD0eDbBDQjlEIXUzN7jglq6/iPth7nr4XtXjzg=;
 b=FRL2mgYm7tPIvoGUAwKSQnlxfgYC1tULjC3NuXEYmAErfTmrYFCOg2BvcYPnya+fwP
 9daoLMuZ9foa1BG1mDE5ml7UumB6VjRby0XG6Z2wdGqOsDFck0nbcsYAHv7ZqnuoWMuN
 4w4ZT9o9Ceqx1hro/Lp3JrKUw5ALjFx8nMFT2OPW1bbYfiDALqE0opEQbtahqJMq0/sH
 gS3/xhjsj/IdU9ElXo6NxPzKbv5l8f/JsciNaX1JFqnm6whEpqjXLW1XamHgIHHXFICO
 vvRulaLHGSYorLy43dtSfnIZKIdeZc2GN1CvW76CV2vKwsQd+p9L0QTWKk7jQGfLLIT3
 32Yw==
X-Gm-Message-State: AOJu0YxAlTP11Lzus9eb98pJfEa76/nlOr8RFOk2nleZTGY3StmxXOuK
 rAkyimvRNkGVzOAQYO84ZDDmr9HxfPxBn9OdoxmM1Ffve5ETA4VzHeaiQdOzYe/gbUHNVClcqcB
 +AFKD8y052uRoQiiATdI6DqyYpQJ7rlM=
X-Gm-Gg: AR+sD11jrTHcQ9Sh3RRmVTIKiykqKB7ily+n/NKpizRbgr8ZAsGxbf76w3aoMUsQX56
 PoYAmiy8ZBPiWpPZP4LRRtcUnDkyBlK9KbqVwluWfgzzdswTEloFDyETjy2P7DgEHYjKZUGJVQm
 oL4CZDez5cGWDB+6BgaxFsm6tAn3cIuhkSELX4a7b8fFgCD0GvDJTuaMvWivRWwPWqgaDfg+v9k
 ddfzduNxg6PaZrrfY8BbbgAMpChgXzsWVeiJNxX8TxdSN9kxDjX3B+GdkMhFKzGEw7IC1ytwrqs
 68raSsx5/t9Oc+5zS3gFPyxWjEOvxc6yYY/q2Do8LRbW7JuSgrzQ4CEHzBOOCxbq06GBqnJGbi6
 ozN2gynIwlwhqkISx5LE61a2Ym6dnewFrO+n0A1GU+ZdUqkDx35sM8O8mDH/1Rs5b
X-Received: by 2002:a05:651c:1503:b0:39d:93e8:801b with SMTP id
 38308e7fff4ca-3a0f8d9088bmr4687721fa.22.1786458387881; Tue, 11 Aug 2026
 07:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260730173643.256052-1-kieweg.leander@gmail.com>
 <20260730173643.256052-2-kieweg.leander@gmail.com>
 <20260731-petrel-of-fascinating-finesse-cd10ae@quoll>
 <CAMwcS0hupV50NEOX1Fsi_tzRYXBecaummjAm=CFHO7xOT1uUXw@mail.gmail.com>
 <c5f760db-2235-44c1-899c-b6ac023b3233@kernel.org>
 <CAMwcS0jTwpigztHBTLv_sgFNLK0ERHDMzMGsBdi7josLHw56-g@mail.gmail.com>
 <f3fbdc3b-6ae8-422f-a161-8936ffd82abb@kernel.org>
In-Reply-To: <f3fbdc3b-6ae8-422f-a161-8936ffd82abb@kernel.org>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Tue, 11 Aug 2026 16:26:16 +0200
X-Gm-Features: AUfX_mzIwlYwfI--6_3lWtHQX0aoa-u49OuWteOKOtIxMK3649W4Ay3R76dJT3g
Message-ID: <CAMwcS0jUNcVwMkpxSjToyqgVEPqeScz4WLHLQAtKL-VMNXxgqg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: Add GlandaGPU binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, u.kleine-koenig@baylibre.com
Content-Type: text/plain; charset="UTF-8"
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

> I am fine with small projects, till we do not have surge of them because
> anyone clones some project and vibe-codes new soft-core.
>
> Projects run on your personal github, without any organization, do not
> get their own vendor prefix. Why? Because then you come with another
> project and want one more prefix... Personal vendor prefix would be
> fine, but different thing: this repo for your design was created a few
> months ago, with one contributor and ~70 commits. This means it is very
> new, without users.

Makes sense. I'll go with a personal vendor prefix instead, e.g.
"kieweg,gpu-1.0". I'd reuse that for any future project instead of
asking for a new prefix.

> What is the benefit of having it in Linux kernel for the community? Who
> needs this, outside of you?

Honestly, no one, probably. I built this because I wanted to learn,
not because anyone was asking for it. I actually asked about this
exact concern during the RFC review, whether being a hobby/non
commercial project could be a dealbreaker for mainline. Thomas
Zimmermann's reply at the time was:

  We already have a driver for a RasPi-based USB display that
  someone made in their spare time. So being a hobbyist project is
  not a problem per se.

I don't want to pretend there's a bigger community need than there
actually is. If that's not enough for mainline, I understand.

Best regards,
Leander
