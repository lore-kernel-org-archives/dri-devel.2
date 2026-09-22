Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39019C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E6510EC85;
	Tue, 22 Sep 2026 12:17:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hYeIFFE+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A26F610EC85
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 12:17:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4897D43E82
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 12:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF5C1F0089C
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 12:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790079434;
 bh=yTxnbSiAz/ON6hMopB3NB3+oXSxRjwZpBmdV0YxRmss=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=hYeIFFE+UckDo7eRQGCMqyMbVRk0RsKmaSBK5lJuoIsqZcU4u2weY4f8eh2+QWCtw
 GxJNLRlnyvRUiMLcF7eRXvVKb6VPHXGS+4vOXis/ljhS/LeYFKcRUupCaUPEKDrO6g
 zJdLOGTl6UL9HE6vYYgTy8Im8fR4v8kbFBx0l5FoZtEQ79qICjW45aDZe+/oRWiNbA
 938/bnQc0CJcBF1wqKYgaGXY96Gc3k7yYxrrUSmVvD2OlfSzjzEEB1MYxza5+H9+pk
 WvQ/AZzVZ/S1zGKcJ07O/Lzn3lGwEzmKVdvMKJhCOSE0fsuZ50VoG6A3u01yCkSDlx
 Q7zNNXyxspA4w==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f1e428so1383901e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:17:14 -0700 (PDT)
X-Gm-Message-State: AFuF++nRFJctEawbqPMbO61lRQPQOgvprA5hJ8DhxEYTHCciQUZLL9YP
 2KkMCPETe6C7mDprb+hCst8HaisPBj0O7E3EWv/0pnmz2XRf6NEmYF7ndSM4pefDsjm0JhN/glF
 qNazu4IFr/M3nbbkEUmNa7/zLas1vp4U=
X-Received: by 2002:a05:6512:3ca9:b0:5b8:9a95:e259 with SMTP id
 2adb3069b0e04-5b8d295e4afmr834266e87.27.1790079432863; Tue, 22 Sep 2026
 05:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-gemini-tve200-fix-v1-0-8be03ac2a8f7@kernel.org>
 <20260921-gemini-tve200-fix-v1-2-8be03ac2a8f7@kernel.org>
 <20260921092546.9F6EF1F000FF@smtp.kernel.org>
In-Reply-To: <20260921092546.9F6EF1F000FF@smtp.kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 22 Sep 2026 14:16:59 +0200
X-Gmail-Original-Message-ID: <CAD++jLnMvzC2wmWiLY1aVDHqG39ZiJv2FyCg4-V93APpjihpRQ@mail.gmail.com>
X-Gm-Features: AclHuK-bjk8vEyyJGB6e_jRIydjSMNUQ5bfkMux8cNhlhOVbt-7gvd6Cmxs_sAA
Message-ID: <CAD++jLnMvzC2wmWiLY1aVDHqG39ZiJv2FyCg4-V93APpjihpRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: gemini: Use a level-high interrupt for
 TVE200
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, 
 devicetree@vger.kernel.org, conor+dt@kernel.org
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

On Mon, Sep 21, 2026 at 11:25=E2=80=AFAM <sashiko-bot@kernel.org> wrote:

> [Severity: High]
> Does configuring this as a level-high interrupt break the driver's state
> machine logic in tve200_irq()?

Nope.

Tested on hardware.

Yours,
Linus Walleij
