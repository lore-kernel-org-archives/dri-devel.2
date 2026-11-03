Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF14606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=e/28QZrj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C2010E0D5;
	Wed,  4 Nov 2026 08:58:50 +0000 (UTC)
X-Greylist: delayed 2862 seconds by postgrey-1.36 at gabe;
 Tue, 03 Nov 2026 15:21:53 UTC
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2064410F661
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1793719309; x=1793978509;
 bh=JoLc0tLRW6eAwNOg58s4xMBjrC0q7X6tzQl25fCbdZg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=e/28QZrjOVQRoLqSTslqXIOvOiffP9NFF9pzkflb8rM6KNng9cu7YsTrP7Hmjmckx
 A8rniU86IInlwkzctFBhYYxblnhG1PeBhahyBspgcGZvcuc5rKFrMXo48ppMXt1QiI
 v6vHmZFOw8c5mvkVOrJlUOMXO1rhasrR3acwgsxzJawwuzYK8O00ALWaD2bTFgy2xA
 q1BPXK0/z2CU3w6oV/b8IPu9ofsaVA75HnTttUUQ6vqIcuI+MeeBFJMupFvtDdGImx
 TdaelalJ0ki7FaYssw2y8qnxvM0hHQe4AALXVKMzGDmcl2cFBe+tW4el2xHEErQkQm
 oSjZiklzPL24w==
Date: Tue, 03 Nov 2026 15:21:45 +0000
To: Daniel Thompson <danielt@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: add Kinetic KTD3137
Message-ID: <CmvbeteAqxtpenZUmJ4dqRvXYjjDzTTDevRB4NUlN0WGLOUk0jwzt2C3ZtuZ3Eb2UwBDEPUWpu9biU1OOhKGWQITolX96cFXolBTMgSyh1c=@protonmail.com>
In-Reply-To: <aunyu4ToQ0T3b2Mj@aspen.lan>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
 <20261102-6768-ktd3137-v1-1-b5b4f903c56e@protonmail.com>
 <aunqGVkX7-Y61iDA@aspen.lan>
 <_kyk4j6fx0PX5QqVrjAIGH-5fzUhj-fKhD8YT4F734mCOnQCDXui6wQB77AOka69_gblWOJN2SxzC5OSrH1lXiQeciLfVnWuPHS0JfaMKD4=@protonmail.com>
 <aunyu4ToQ0T3b2Mj@aspen.lan>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 2545d42f3fa76bf9b85c028d11f510898844a499
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tuesday, November 3rd, 2026 at 4:42 PM, Daniel Thompson <danielt@kernel.=
org> wrote:

> On Tue, Nov 03, 2026 at 02:34:02PM +0000, Roman Vivchar wrote:
> > Hi Daniel,
> >
> > On Tuesday, November 3rd, 2026 at 4:05 PM, Daniel Thompson <danielt@ker=
nel.org> wrote:
> > > On Mon, Nov 02, 2026 at 09:58:48PM +0200, Roman Vivchar via B4 Relay =
wrote:
> > > > +  led-max-microamp:
> > > > +    minimum: 5000
> > > > +    maximum: 29800
> > > > +    default: 20200
> > > > +
> > > > +  vin-supply: true
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - vin-supply
> > >
> > > Why is vin-supply required?
> > >
> >
> > The chip cannot function without VIN power supply. Even if it's on the
> > always-on power rail on certain board, there's always a chance it might=
 be
> > accidentally left disabled on the other. It's better to document supply=
 in
> > the bindings as far as I understand.
>
> You haven't just documented the binding, you have also made the property
> mandatory by adding it to required.
>
> So what I am asking is why is this property listed as required. You
> didn't implement the driver in a way that makes the supply mandatory.

Not sure I follow.

In the driver I've used devm_regulator_get_enable(), rather than _optional(=
),
since my understanding is that the non-optional helper is a standard kernel
API for required supplies (with regulator core warning and fallback to dumm=
y
regulator in case DT omits it).

Do you suggest dropping vin-supply from required: ? On my board it's connec=
ted
to an always-on supply, though I can't tell about others. I can proceed wit=
h
this if the DT maintainers are okay with that.

>
> Daniel.
>
