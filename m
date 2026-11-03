Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5F1606D838
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+C9b1g9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9471B10E0AB;
	Tue,  3 Nov 2026 14:42:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 490CB10F617
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:42:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8DD8860008;
 Tue,  3 Nov 2026 14:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4AD1F000C1;
 Tue,  3 Nov 2026 14:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793716929;
 bh=XMbRjeXjK8HpPncDUdoXbZIVfAoatGdmgR/tQAmDQc4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=R+C9b1g9x1xIC4nQ7+4q4VaAGG0Q/QOC+5KBaa2cPTIuBhOZqwkBQJU/tuLr4fFyc
 TkjMcDB3+pkAStkno+5k62DzD+IEPrI3MCiVhGvUSauhctT+jnCNnniKCic+GcdpTK
 VC+qDYygRD+ltAT8ojIuV7m3kGChkSQJCTLu9aYk9x7qaDKB98t1bFdxrVxltkRURw
 /CkWEYrqfIMrp4KXhoWcBkqgoCNs/AhrfdoixdmoMUYXYfZ2c4d2/+KmY2vnft+bIK
 i1jBobQJhZdqvwEJnukp6b9PFFFVwyxmoAXhPwi3MN+T1y0pxYqov3vmWyg4Z2+r75
 4PQfhwSsGGX3g==
Date: Tue, 3 Nov 2026 14:42:03 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: add Kinetic KTD3137
Message-ID: <aunyu4ToQ0T3b2Mj@aspen.lan>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
 <20261102-6768-ktd3137-v1-1-b5b4f903c56e@protonmail.com>
 <aunqGVkX7-Y61iDA@aspen.lan>
 <_kyk4j6fx0PX5QqVrjAIGH-5fzUhj-fKhD8YT4F734mCOnQCDXui6wQB77AOka69_gblWOJN2SxzC5OSrH1lXiQeciLfVnWuPHS0JfaMKD4=@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <_kyk4j6fx0PX5QqVrjAIGH-5fzUhj-fKhD8YT4F734mCOnQCDXui6wQB77AOka69_gblWOJN2SxzC5OSrH1lXiQeciLfVnWuPHS0JfaMKD4=@protonmail.com>
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

On Tue, Nov 03, 2026 at 02:34:02PM +0000, Roman Vivchar wrote:
> Hi Daniel,
>
> On Tuesday, November 3rd, 2026 at 4:05 PM, Daniel Thompson <danielt@kernel.org> wrote:
> > On Mon, Nov 02, 2026 at 09:58:48PM +0200, Roman Vivchar via B4 Relay wrote:
> > > +  led-max-microamp:
> > > +    minimum: 5000
> > > +    maximum: 29800
> > > +    default: 20200
> > > +
> > > +  vin-supply: true
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - vin-supply
> >
> > Why is vin-supply required?
> >
>
> The chip cannot function without VIN power supply. Even if it's on the
> always-on power rail on certain board, there's always a chance it might be
> accidentally left disabled on the other. It's better to document supply in
> the bindings as far as I understand.

You haven't just documented the binding, you have also made the property
mandatory by adding it to required.

So what I am asking is why is this property listed as required. You
didn't implement the driver in a way that makes the supply mandatory.


Daniel.
