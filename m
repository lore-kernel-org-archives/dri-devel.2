Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F20606A327
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4uHgzXP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C36210E0CE;
	Wed, 25 Nov 2026 10:27:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF6D10E0CE
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:27:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84B30455EB
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E571F000D8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795602420;
 bh=usb6Z06Hk8KYQV8odRZafo7lcqGHFhPDFCx6kFOexg8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=O4uHgzXPpddrs5gBqi8u9B2aC0SyE1KCf5EIAftXmQf0Yz2Bd+cgo1AM8A56/XQ9b
 QsOVezx8SE9qn+lvrJWJL1PlTp4gI/ODzeAfNUdCBjt4Yzly+8YEdh5lAto1BeiBtW
 /7CFZIny7BW8SPGrIJQECs6/L+Gmln25txeh1jerNuB2R5ZuT5WsODPt16jq9ZSXN1
 TAdyxky7rcl0q80azCDqg0LQDzoEB1/CSIuA4WL/UAjvZTNT3qWM2GLj5N0aZvZz1R
 L8ZFxRiK9+1MKiLQyRnSM6v7F5pPkCH2LHiOaGB1sMe/Gxk8SHMRpzsNCp05SnHtNB
 EfR1nLIQmF2Pg==
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5c1465bbbdaso4795007e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:26:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErEmX54SMokqq0kehk4rhG4s8TJ5xqUoHmAy0DiQDjU06hGLfA29QOAWfBwJYDc9rAT3qnAMKlMbKdw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9F5Dg4nQZh41jXqNKhj7JD4lVrp2C9mXY05naj0cKMWFF3jvNj
 0/10lsXmm6n8iG1f3fqfEfhJfLHtXbfuk2D7/yvfBuquP1FRkTxO9PC4Ku1NARsQMqbZIaYV9eF
 Kl1KAVlH/quFgjqhweF5Q6ESoLZYUqSU=
X-Received: by 2002:a05:6512:104d:b0:5c1:5a83:2fd7 with SMTP id
 2adb3069b0e04-5c1bc907072mr5199313e87.66.1795602418769; Wed, 25 Nov 2026
 02:26:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
In-Reply-To: <20261015142552.4128028-1-ryan.roberts@arm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 25 Nov 2026 11:26:46 +0100
X-Gmail-Original-Message-ID: <CAD++jLm6VvPYB5UQS8Zm73pYifr7Oi=xX3S4Wt5c3WE7uMv+fQ@mail.gmail.com>
X-Gm-Features: Aa3M54rtYXT0tNMww-_rAs-DbnpD3x58pzG3L6crqferpf2a4MJ3rhFXSlspZ40
Message-ID: <CAD++jLm6VvPYB5UQS8Zm73pYifr7Oi=xX3S4Wt5c3WE7uMv+fQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/15] Arm Core Local Accelerator Driver
To: Ryan Roberts <ryan.roberts@arm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oupton@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@nvidia.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Ryan, Jean-Philippe,

regarding this patch set I looked into historical precursors and
ongoing developments that could benefit from the same infrastructure.

1. Apple AMX: there is no ongoing effort for this accelerator but it
exists in all Apple silicon. This accelerator appears to be synchronous
using extended instructions and is just "some different SVE" and would
be handled the same way as these.

2. The PowerPC Cell SPU (Playstation 3)

This is more interesting: the Cell has accelerator cores that execute
entire litte programs (shaders?) on behalf of the CPU. These are
however not poilled like the CLA, but signal completion using a
mailbox interrupt. The accelerators are

What is interesting with the SPU is that it communicates by creating
a custom filesystem (spufs) mounted at /spu, so this is apparently
another design venue to consider.

I think Arnd Bergmann has worked extensively on the SPU so he will
likely be able to provide input on lessons learned, do's and dont's
when it comes to this and other accelerators.

My superficial appraisal is that the CLA is probably executing smaller
jobs, snippets of work rather than entire little programs/shaders like
the SPU does, so it is conceptually different, but may provide
additional ideas anyway. Arnd?

Yours,
Linus Walleij
