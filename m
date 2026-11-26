Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E052B606A327
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0VY7+XD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131BC10E2D3;
	Thu, 26 Nov 2026 12:47:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F3B510E2D3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:47:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF1284663E;
 Thu, 26 Nov 2026 12:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D721F000D0;
 Thu, 26 Nov 2026 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795697244;
 bh=q4oaVRG88t+rJ671yZUZBq0iKBzOxZgNztWtKYUJVTI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Z0VY7+XDTSGwCNFGY9Vo4wDSQRlh/DcTkHoq0uA68MVx8XxzkifE1qxOEUGbbeuLO
 BH6J9AxzdCEljo4uH0bHCasdJR+FlF7JeF7IJyZwQtA9P1UVFb4Im/q5Vl3wa2uCIT
 FRvg8X8zfykFpphpk9NnITVPR4NWv97L0nnN7Wb/mImjqwfCjcqd7R0JrdFbe7tPhe
 pWgqQ1O5+AQB9pc2FkU/G6Jw56nDY0FyHogp7TdzTD43uTFYoW1KpDKRke+9UICWwm
 Nx135+KNmoFylG3do5CAJz6JYa9vTDI2n9MuUc0Gl2KwDDYr2M9sLwSAM39Ur3lSgT
 NShKA0E4s989g==
Date: Thu, 26 Nov 2026 12:47:19 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>, Griffin Kroah-Hartman <griffin@kroah.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 mfd@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 4/4] mfd: aat2870: Add support for VIN and IN-LDO
 power supplies
Message-ID: <20261126124719.GJ38590@joneslee-macbookpro.roam.internal>
References: <20261115085826.89641-1-clamor95@gmail.com>
 <20261115085826.89641-5-clamor95@gmail.com>
 <20261126114728.GG38590@joneslee-macbookpro.roam.internal>
 <CAPVz0n138PXP88++q4QXiao-7=nzade=e_jAdfKK0_xsEyPtFg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n138PXP88++q4QXiao-7=nzade=e_jAdfKK0_xsEyPtFg@mail.gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026, Svyatoslav Ryhel wrote:

> чт, 26 лист. 2026 р. о 13:47 Lee Jones <lee@kernel.org> пише:
> >
> > On Sun, 15 Nov 2026, Svyatoslav Ryhel wrote:
> >
> > > The AAT2870 supports a dedicated main power supply input alongside parent
> > > power supply for its internal regulators.
> > >
> > > Add support for retrieving and managing these supply regulators
> > > (vin-supply and in-ldo-supply) using the regulator framework to ensure
> > > proper power supply dependencies and power-up sequencing.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/mfd/aat2870-core.c            | 5 +++++
> > >  drivers/regulator/aat2870-regulator.c | 1 +
> >
> > Is this a build dep?
> >
> 
> More a logical link, I can break it but it still will be part of this patch set.
> 
> > Would something that was working before, break?
> 
> Other way, it was broken (aat2870 may have a dedicated supply) and now
> it is fixed.

Great.  Split it and Mark and I will take them into our own subsystems.

Thanks.

-- 
Lee Jones
