Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC2606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5ZDMOWE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E666010E1D1;
	Fri, 20 Nov 2026 09:25:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ABF310E02F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:25:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 688E16156B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E791F000C6
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795166712;
 bh=8SzIHclfGO7rIjAKlxWY7h5C1tqRdUP4RNaZqN79MuM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=B5ZDMOWEHdnhh2/umOUmDyebT2Q50s1hgR4xDpum/5dqqoMqtjXVEdU8aCG9sLmQA
 7A6AoINlMkFawC02saPlGU/UG/hx+Ve8Q49Ae/eZlx2izAu6qkxYbT8PBExCep30Qc
 cIKFHKeYrow0KilYBJXAu05Oo1CIxqWoGzdcAB4xOFdSnA5ipUK+6pmAZZGQKczT57
 5U5FYX0g1tEu7APgsdhwFuInYTVpzswscUD4Z8Qs45W2nDr1nbveiYtNzYB4TrppYV
 8pctZ+ScqMMKXovSWloMW7pcezlqSREFM6P5p3mvobzMNRf9HWvMu2KMDKw0zP2X5m
 a5xa8vTyeJJhw==
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5c1a947b4adso526836e87.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 01:25:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErHjOf63zNSloZiRTFUo52kc5sKO+HVGlABbxipJmwDJfb8YggDL7s8xf8d3qphpt5mkFP7BIsFEP88=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/d80hJp35cOeISE32t3ly+xwSTjQ7fO4teXE7RaqhJG0UHn8CV
 LIhe+6XyySeF2zlz9YvnfcTAJloZepGzEOg+BPbFuyX0Zktp1/SWKzpWam8EZRGvRilNH0GdOX7
 bCmsXtxtaaCIavpuo29p7AiezmGwIwRw=
X-Received: by 2002:a05:6512:3e26:b0:5bf:dfb9:33db with SMTP id
 2adb3069b0e04-5c1bc894b28mr761513e87.38.1795166710840; Fri, 20 Nov 2026
 01:25:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
In-Reply-To: <20261015142552.4128028-1-ryan.roberts@arm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 20 Nov 2026 10:24:58 +0100
X-Gmail-Original-Message-ID: <CAD++jLnXQHkYvCO4raM8enm2NNwU5WDNE4cFhvcVUnUZVHMPLA@mail.gmail.com>
X-Gm-Features: Aa3M54qJyeIPO-XfHd9glHLeVqDiREjcacNXijYh3kod1cJY-VZmSyNAF3F7zP0
Message-ID: <CAD++jLnXQHkYvCO4raM8enm2NNwU5WDNE4cFhvcVUnUZVHMPLA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/15] Arm Core Local Accelerator Driver
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oupton@kernel.org>, 
 Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
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

Hi Ryan,

please keep me on CC for future series for an SoC perspective
on this.

On Thu, Oct 15, 2026 at 4:26=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:

> * The location of the driver: although most accelerators will likely be c=
ompute
>   ones, CLA is a generic MMIO interface that could handle any kind of
>   accelerator. It's currently implemented as a misc driver. accel is anot=
her
>   potential option, but given the current SVA approach, we would not use =
any of
>   the services (memory-management or otherwise) that accel provides.

Given the extremely ARM64-specific nature of the accelerator it has a
lot to do with arch/arm64 but then again it is a platform device + driver
associated with the cores and we don't want platform device drivers
under arch/*, so it kind of falls between the chairs.

My spontaneous placement would be to put this in drivers/soc/arm/*
what do you think about this option?

The argument would be that this is arm-specific, we do not expect
the code to be reused by other archs, and it is used on some specific
ARM SoCs, so it goes under drivers/soc/arm.

If a very similar feature arrives on other archs which use very similar
code we may have to rethink this but for now I believe this is the best
option.

Yours,
Linus Walleij
