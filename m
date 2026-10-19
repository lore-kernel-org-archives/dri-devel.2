Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F55606C179
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EdB6yR8k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D45310EC4E;
	Mon, 19 Oct 2026 16:02:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A54010EC4E
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:02:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6824560D99;
 Mon, 19 Oct 2026 16:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B596D1F000CC;
 Mon, 19 Oct 2026 16:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792425729;
 bh=T3OoZrJmi4UHul4Ly0uuZfTsyT/nHjsTbt0mJe/Vio4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EdB6yR8kJC4sXU4MNUh4QIbYaP5Wd0PFI3iddBSVOq8fOboeNm4Hlw8vly2KDYW9t
 OJX+sV9a5FjLS7GpSTVlI8YOOXD5wmADM5R57HaoW2paGhJS91TMYGn6YYLt5tBtSQ
 Jar41G4wElLe3Ur5wEEvmxuw/2ryGazJ3eL0oH2X3pERF/MAqAX8A97fopNy3/6IF2
 GufucKqBmwGszQaWpCX9w4ruH6/bVYnFisaTgRQg0fKOblz2fJ5mlSzX0cazClD6PR
 RzVKLHmP4/Zke+BzWuW4yGVcH2V8McuZqIg9YdEvXWXH8vOfcYvINEwQm+LkMgjseh
 SeMCaa64EuW+w==
Date: Mon, 19 Oct 2026 17:02:02 +0100
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 mfd@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Document Skyworks AAT2870
Message-ID: <20261019160202.GE2663669@google.com>
References: <20261013180933.487013-1-clamor95@gmail.com>
 <20261013180933.487013-2-clamor95@gmail.com>
 <179198322819.839288.5272985130898382430@kernel.org>
 <CAPVz0n08bXQrujADdgQwuLu10JNjOrjBq-zNS6agSBGLLWt0OQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n08bXQrujADdgQwuLu10JNjOrjBq-zNS6agSBGLLWt0OQ@mail.gmail.com>
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

> пн, 19 жовт. 2026 р. о 17:52 Lee Jones <lee@kernel.org> пише:
> >
> > Wrong subject line.
> >
> 
> What do you mean by "Wrong subject line"? Specify.

This is a LEDs patch, but you have incorrectly tagged it as `mfd:`.
Honestly, I would have thought it would have been obvious, hence the
lack of further explanation.

> > > Document Skyworks AAT2870 LED Backlight Driver and Multiple LDO Lighting
> > > Management Unit.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../bindings/leds/skyworks,aat2870.yaml       | 124 ++++++++++++++++++
> > >  1 file changed, 124 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml
> >
> > [...]
> >
> > --
> > Lee Jones

-- 
Lee Jones
