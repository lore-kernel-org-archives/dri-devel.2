Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84627606A32F
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2GtedTK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A82AE10E180;
	Tue,  3 Nov 2026 17:10:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA9F10E189
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 17:10:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E818601FF;
 Tue,  3 Nov 2026 17:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841171F000C1;
 Tue,  3 Nov 2026 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793725807;
 bh=4yXF2qH2dZlH5NaZeOXrAhyY/aCMSbLE9DiPJAinWiM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=H2GtedTKni4UU2EY3qobMS0Dg3+Qmas82D0rV3NG1oUmo/Ml8rDNYcCcm0B0ET+Yp
 9SCFdcnz4ahrGyyNSCy9b16+wLKDB+Gj4iVSBMsQFv5KW95uzWSOSxkwyDlbif19V+
 ZO09Z7FBbVo/mZpUvU807tA1ga8DQw5UgYbs1RyYaMZDI0mc45lBdybYIoOx67hGdu
 NIuyZczUueXbJoZQFi3Gw3+zxdgfZBwoMyjRIBqzddkNHAq1ZN6xjWy2ZHYwhHuWsd
 lOvsHMTguvX2mYrABptuiCFjUf9QaiywEvoTmtZJJqivuMh2WT0E5HclqIBPMl2V95
 w4QhY8zlKUGMg==
Date: Tue, 3 Nov 2026 17:10:01 +0000
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
Message-ID: <auoVaaZjcnRTj1S9@aspen.lan>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
 <20261102-6768-ktd3137-v1-1-b5b4f903c56e@protonmail.com>
 <aunqGVkX7-Y61iDA@aspen.lan>
 <_kyk4j6fx0PX5QqVrjAIGH-5fzUhj-fKhD8YT4F734mCOnQCDXui6wQB77AOka69_gblWOJN2SxzC5OSrH1lXiQeciLfVnWuPHS0JfaMKD4=@protonmail.com>
 <aunyu4ToQ0T3b2Mj@aspen.lan>
 <CmvbeteAqxtpenZUmJ4dqRvXYjjDzTTDevRB4NUlN0WGLOUk0jwzt2C3ZtuZ3Eb2UwBDEPUWpu9biU1OOhKGWQITolX96cFXolBTMgSyh1c=@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CmvbeteAqxtpenZUmJ4dqRvXYjjDzTTDevRB4NUlN0WGLOUk0jwzt2C3ZtuZ3Eb2UwBDEPUWpu9biU1OOhKGWQITolX96cFXolBTMgSyh1c=@protonmail.com>
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

On Tue, Nov 03, 2026 at 03:21:45PM +0000, Roman Vivchar wrote:
> On Tuesday, November 3rd, 2026 at 4:42 PM, Daniel Thompson <danielt@kernel.org> wrote:
>
> > On Tue, Nov 03, 2026 at 02:34:02PM +0000, Roman Vivchar wrote:
> > > Hi Daniel,
> > >
> > > On Tuesday, November 3rd, 2026 at 4:05 PM, Daniel Thompson <danielt@kernel.org> wrote:
> > > > On Mon, Nov 02, 2026 at 09:58:48PM +0200, Roman Vivchar via B4 Relay wrote:
> > > > > +  led-max-microamp:
> > > > > +    minimum: 5000
> > > > > +    maximum: 29800
> > > > > +    default: 20200
> > > > > +
> > > > > +  vin-supply: true
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - vin-supply
> > > >
> > > > Why is vin-supply required?
> > > >
> > >
> > > The chip cannot function without VIN power supply. Even if it's on the
> > > always-on power rail on certain board, there's always a chance it might be
> > > accidentally left disabled on the other. It's better to document supply in
> > > the bindings as far as I understand.
> >
> > You haven't just documented the binding, you have also made the property
> > mandatory by adding it to required.
> >
> > So what I am asking is why is this property listed as required. You
> > didn't implement the driver in a way that makes the supply mandatory.
>
> Not sure I follow.
>
> In the driver I've used devm_regulator_get_enable(), rather than _optional(),
> since my understanding is that the non-optional helper is a standard kernel
> API for required supplies (with regulator core warning and fallback to dummy
> regulator in case DT omits it).

That dummy fallback essentially makes it optional. On a board with an
always-on supply then there is no need to include vin-supply in the
DTB. The driver will work just fine without it.


> Do you suggest dropping vin-supply from required: ? On my board it's connected
> to an always-on supply, though I can't tell about others. I can proceed with
> this if the DT maintainers are okay with that.

Given your answers then, yes, vin-supply should not be in the required:
list (e.g. we don't want DT validation to fail for a DT that does not
include a vin-supply).


Daniel.
