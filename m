Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AC31094489
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 16:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC1B10E26F;
	Sat, 21 Mar 2026 16:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="uKdagoi2";
	dkim-atps=neutral
Received: from mail-106104.protonmail.ch (mail-106104.protonmail.ch
 [79.135.106.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA8FB10E04A
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 16:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1774109734; x=1774368934;
 bh=QotTHgm5szfDydHr9RZe/Pmi7UIj/OMAipB3hOHJLmw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=uKdagoi2L9q735o9uBLUbe0p9IWsDjPM59Lh+XCNGXygsYF1FJY8D/cM343QnBvMP
 2S1IgoGYX/UPdcZcJEdRwT7HspcHAZxGg5vRP9jC164LzPwyWuo7LdSE3UIXUhXZmW
 /AbSqNvQ1+5dx+VQqZNRTO5WqTFiNK7AR7/alVFwjTf3nnRTkCk8XBo8A7NfBJUtXs
 byKWK8K1DgTke2SI08LPhdsCEww7qja7UknjAMgGkIfiA6MgXBDnvvRua6Li5WvcIb
 nnxORmWAPuJLUoCX43jSELPFsbkuC0fSDr8+nyJLI7IpH1Tfrol47qppo4mA6XmHMF
 zzK2OxKFWJYQQ==
Date: Sat, 21 Mar 2026 16:15:29 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>
From: cristian_ci <cristian_ci@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: display: panel: Add Novatek NT35532
 LCD DSI
Message-ID: <JPvrBL0VElAnSybKBmlSXQbxGuYnospMhh-e3w4Ug5_6boEWzayNwLUDvCJPlz5IH5JAjciiMhdTBEOiTwJ7e0cbuZW7DV7r55qka0VmhBc=@protonmail.com>
In-Reply-To: <9bb6e4ac-c7f2-4f1d-aff0-70eefec810a2@kernel.org>
References: <20260318-rimob-new-features-v2-0-c1bf8917449e@protonmail.com>
 <20260318-rimob-new-features-v2-1-c1bf8917449e@protonmail.com>
 <20260319-amorphous-pastoral-turtle-851af9@quoll>
 <oMTrCB7euJojLz1EUHDhHCq071GQWD0g7-sqwahA62CnM-sVw08UCNhKdgHX2NrEN3H8iRhc0suejuq5JZ39UA2nEfKhRq9qwYJWSxCrAtc=@protonmail.com>
 <9bb6e4ac-c7f2-4f1d-aff0-70eefec810a2@kernel.org>
Feedback-ID: 27475468:user:proton
X-Pm-Message-ID: c3476e88b1fb925ce3150479b96fa7d10da5ebb6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Saturday, March 21st, 2026 at 10:56, Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:

> On 20/03/2026 23:32, cristian_ci wrote:
> > On Thursday, March 19th, 2026 at 10:09, Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >
> >> On Wed, Mar 18, 2026 at 11:28:09PM +0100, Cristian Cozzolino wrote:
> >>> +  avdd-supply:
> >>> +    description: positive boost supply regulator
> >>> +
> >>> +  avee-supply:
> >>> +    description: negative boost supply regulator
> >>> +
> >>> +  vci-supply:
> >>> +    description: regulator that supplies the analog voltage
> >>> +
> >>> +  vddam-supply:
> >>> +    description: power supply for MIPI interface
> >>> +
> >>> +  vddi-supply:
> >>> +    description: regulator that supplies the I/O voltage
> >>> +
> >>> +  port: true
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - reset-gpios
> >>> +  - avdd-supply
> >>> +  - avee-supply
> >>> +  - vci-supply
> >>
> >> Only VDDI is required according to datasheet (see page 11 and page 16)=
.
> >
> > Just to be sure, are you mentioning the part saying there are multiple
> > power modes (2-1PWR, 2-2PWR, 3=C3=A9WR and 4PWR) related to NT35532?
> >
> >> Others are needed only in specific configurations, which I would ignor=
e
> >> for the simplicity of the binding. Drop these three.
> >>
> >> Previous discussion point was about this - write bindings based on
> >> datasheet, since it is available.
> >
> > I've removed avdd, avee and vci supplies from 'required' properties
> > and I've also tested the new bindings (just for completeness). Now,
> > I'm going to reintroduce again the issue already raised previously
> > (for which I received no replies in v1): should I submit a v3
> > series including my new changes or I've to stick with v2 here, in
> > order to address review concerns about binding, first?
> >
>=20
> I don't understand the question. This is v2, right? So I asked to make
> changes to it, thus you should submit v3 after receiving some more
> review for example.

I've submitted v3 of patch series considering that, apart dt-bindings, I=20
think I've addressed reviews for the rest of patches, during these last=20
days.

> Best regards,
> Krzysztof
> 
