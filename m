Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D132F46C44
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C444610E1F7;
	Mon,  6 Apr 2026 14:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TEzMg6MM";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1384A10E1F7
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 14:34:48 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2bd5658b901so241504eec.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 07:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775486087; cv=none;
 d=google.com; s=arc-20240605;
 b=CDUHZfKdJn6p6bat8NilPzdfRx4H0c6tDFXBnpsyYQhxp89EWKBiHc1NeGsjXoFfM2
 SCGWCaU8OiJqpUZFZ3F7nnG8xzJ/4srZeybEp6x6owa2/XQ+MINsQ1dY0S2+/uzuo5gQ
 puez76Vijm6DjtS4xZJxYmlW9uLNeXscsvBzts6w//O0IXTY7olQEssVIaQWjhe2elIK
 6eW5JwuuBa0qBoLLfnLj9y3nnrLE3GPTsD3Oxqe9XxUfuNsu5FZP4RJMqZxgtLNWquIw
 XiSzcBbSBW0/9keJ3kA02Kz4oGuUdA81Cqwls9tzESnV1v1V+Nx+tc5cMkLHcggJZ1yC
 0YhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=txc1GgXszHVDSxiwgLcr3FoLM/49u5UMyHGBJqURxJA=;
 fh=xal9y+Ox2ATlPwHy6ZqYdNSK29asPnLDGUkw4HT2aW0=;
 b=WAvi+DKfg02Kqz1oOIie16wRWohAJ7TqAU+PsJbDXoXTaHJ1JCrHi//GUxuCtkPIY+
 oYFyY5WPNToktXTmOtOV9CX3mW57YGy9+UL55rNZrQuJeapIKI/qTSQJqLv9p7l6chOG
 Q2/Igir//RCuoMDOGqK88kDL0a2qmItoomEIe6UtNGjOfTu6SM5meiDFfzUWANAv4DEa
 79iYvl4TrI61mBE9Cy/kbVJkODP7AMTCQXQjQQG3cNcivmMxCo1w3pQzrWU/Xs5LBvPw
 rjgcmZ+1PPoFo2xCYPOCunyXp9nfPHKgD6ZgEz/BNBf+Ni4LTT5A/hUzjc79QmK04ouC
 bXJw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775486087; x=1776090887; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=txc1GgXszHVDSxiwgLcr3FoLM/49u5UMyHGBJqURxJA=;
 b=TEzMg6MM/cOH8LfpoiE4LbStPH47J1e+LFlw5y06iJ19h8bvArNmVCc61GVixjZrVB
 ikQU5U0WxTTXGdnpOrwV9Y7ChHidyDSt2cXHXCNWkkuNX+67BsVDzUAY+gdXhWJC5P8I
 g6KNnFwxCp6Ewx/r04N89BNXPJsByYt2XVqPltJvWRaRAbHwSMISwhvwXGlMaLHJbLBZ
 0Ct7/NlTykcL+X4n2brrX4flSTVhe4YYDwzxNoNE9T2FR1Fe+WvsBB8miUXzrP+cXEKz
 rW3VpZWcsT7Q3dHm9VVx9mXCh9vHSqA/uvhaa77zqjudzSQl2taXsvuwlp5Hw3fxu1vP
 OlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775486087; x=1776090887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=txc1GgXszHVDSxiwgLcr3FoLM/49u5UMyHGBJqURxJA=;
 b=Sgj1Z3Zi2i7A9sEZhEEJysLzHg1kTOhA/WUD8xocjwUQNHyGnfFe41hkjsEMKfAevc
 +xChXE9SHhCRZAq/Btgb3NkAsMFlZUyd36ETW6b7aLASbkdvrWg5qNzy2DswRdodfD69
 /L5zqDCdE72NF33mr5f7H89rF83fhCXPUYO+jF93U0uQnVDbiUt5GR3R7jGYh0tuH1gL
 b6s/ZEeLMvt3yd3K2d/UD3kyXqST/lrBQWgwTjx6/tQ8cS2qfo0y15QRY4hTN9HGuPnq
 PFNlPWSa18zKfpfni/1GTe1iwUOQFZa5WcErH5/K4ciObhzpWNZWxX2RM0d1/84FiKpE
 vTvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO5LYMNkE3fitMmP8jpn8QAHpHk/AxMtNZbWWsSHBLbjlXNADFUn/NelO1IL5UTJjaIuCs6uqoBmg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4Iuce5D4r6coa3IHXxZOybzQmW49QsNTCv8ud4jxq3TzFl6u1
 Q0a+Beva9QbmH6sJ+eWC5fxRuzKySXH1sz/7c2+GmZaUsSCwzWUP00QUnQtuVp7rLqis7AaAbVF
 f/RE0rH3vTJl+unH/xbDERLofZc/431k=
X-Gm-Gg: AeBDietT5au8tH6Akj8oi0opzNe2+rITqnIMQ97uF4Con5nxoEetLeCBTbFLWjlXvVM
 0TzsmZ2gHLG5zHqMVdkkRumKYfVVH33Fy5yv85TTbdGRZy4rdEL9R1Xd/REXuyKjhmWAP31CgvB
 EhRAspT4oFMmwP4i13wVartdQ5E2gwsl7w0UkiOa5saTbIJbmn2rVZEiR46sYzry4FaAWov0Xpf
 fYSD5iOyrX+PBxBK8sz2ET7gyxVp+NDzy2Ws+V5DJVouBwFFaqxZbYa21SDJLCQTXAIYiGgB9vN
 kN2pIntEHlqvgVoeAQHdP3q/fBXJVvTji2N7rZCrMNcZuak+rolXvX2y0LbXvLVLr1YclyjgjOd
 KONSLeSzn8n2Oyzj7qX0QHvM=
X-Received: by 2002:a05:7301:2f8b:b0:2c7:2cac:8162 with SMTP id
 5a478bee46e88-2cbfd5652c8mr2525685eec.5.1775486087120; Mon, 06 Apr 2026
 07:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <adO3fzHT81hnO2B4@sirena.org.uk>
In-Reply-To: <adO3fzHT81hnO2B4@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Apr 2026 16:34:34 +0200
X-Gm-Features: AQROBzCX_P08GU-8bqwxCda3woDdlNoD5iWxzaK9HD93KlyqVNZ07s90bW7xWu4
Message-ID: <CANiq72=On8c2zXqzkyyV7rHGu+r5peRzhJCFf1XLS6wjU-RktA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm tree with the rust tree
To: Mark Brown <broonie@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 Asahi Lina <lina+kernel@asahilina.net>, 
 Danilo Krummrich <dakr@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>
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

On Mon, Apr 6, 2026 at 3:39=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> I fixed it up (see below) and can carry the fix as necessary.

Looks good, thanks!

Cheers,
Miguel
