Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A7260774E8
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIrwSz4v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A7210EECC;
	Mon, 19 Oct 2026 16:03:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E65710EEE8
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:02:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B67E1405F7;
 Mon, 19 Oct 2026 16:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4A71F000C4;
 Mon, 19 Oct 2026 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792425777;
 bh=ITJ8yIetg35lCIRQBlcQOGRfAvXF3Ts1ep0THPstLTU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QIrwSz4vn8mYlEUtvQk7ZPC24EVxgFOevfn8YAVykkO9cCap95TYD5/0qMmMsM1RW
 ORfyaoU8MTdrUmBaE8WhFSSlsEq5HpPLshRlyTP+1vqr81klDrsahnWqeWqEfeGrF4
 VLrI1BRsqtNyZ4Qm/YRRNtauanRzElPipysv6vwJIyuiRboHdmWOMm2+9LZ56g/Cln
 8jm3Z6Z+JWZZv9ucaluFh4gu8AowCmZvodm1tlGBu2fv5xNKZHRSlplEXSxLxWXBUB
 uvUd6MF3UXRScMYVJgD1lS1jWQkrYMn5AwGNo7d/tGiIyQJor0Zb83LKpScEKCdLjk
 jSwvxr/C0FJSg==
Date: Mon, 19 Oct 2026 17:02:52 +0100
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 mfd@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 2/4] mfd: aat2870: Derive brightness steps from max
 current
Message-ID: <20261019160252.GF2663669@google.com>
References: <20261013180933.487013-1-clamor95@gmail.com>
 <20261013180933.487013-3-clamor95@gmail.com>
 <179198332384.839288.13126529382772558553@kernel.org>
 <CAPVz0n14BhmK4P-tqnt6AMrAh=W-HPoBbP0ztdOrRd_JocRSqQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n14BhmK4P-tqnt6AMrAh=W-HPoBbP0ztdOrRd_JocRSqQ@mail.gmail.com>
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026, Svyatoslav Ryhel wrote:

> пн, 19 жовт. 2026 р. о 17:44 Lee Jones <lee@kernel.org> пише:
> >
> > Wrong subject line.
> >
> 
> What do you mean by "Wrong subject line"? Specify.

Backlight != MFD

> > Please review, explain or fix the Sashiko review(s).
> > If this is a set, this request includes the other patches too.
> >
> > > The AAT2870 allows only 32 steps of brightness, with this amount defined
> > > by the maximum supported current. Remove the need for max_brightness by
> > > calculating the allowed number of steps from the maximum current.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/video/backlight/aat2870_bl.c | 30 ++++++++++------------------
> > >  1 file changed, 10 insertions(+), 20 deletions(-)

[...]

-- 
Lee Jones
