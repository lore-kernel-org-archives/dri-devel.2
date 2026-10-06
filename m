Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DCACA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 10:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8F8510F281;
	Tue,  6 Oct 2026 10:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dD0cwu0N";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B7F110F281
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 10:30:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14E7A60234
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 10:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BD11F00898
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 10:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791282653;
 bh=5ZaN40cf3gaPYVrOntAep/0sU9jdzMlSTIwHDqydOaY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=dD0cwu0NaDmzI6FDzUr53SqL2l2laUa5BRdUfSDXpMeJulyDsNvKsVevM17EV3FEd
 UnKpbzoEAi1KOzIDEnEX7hQZBVO5C3K16NnV0NfEVsa75lDW43NjtZdYPMUCx8kT6T
 V8dDmhAxtndAcxWds7MxUMrjuRmmQvQuryZPTJHIBHYHLkXZGXoeemLfEexl0uadYO
 x7OD+ttM+AOxtRzH0yQD4Mh6ONR7x4isxees6zA9pEdZ9XuqQ8uB2KiPLHPnoUTkJP
 jQfDo++ybon7Jrf/vh/St2hPwor3pVNafuKsj1hcHTvtBSXNJsk2YgzKp/i53Om+GZ
 xpXvOTPX/BvJQ==
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-3a6313cb899so3199481fa.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 03:30:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBx0Vyqz/abK6vSmQHJ3KtqiULME1rCeNDefEHP7KqbJuvc8x2TQtGVuZGh6brcDv2jftyfltOHVfRA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJTpt+Xso4wEbCnJZKt7gDLzr6oe5NGDHf+7d+lI33ZAyvQki7E
 UVhQsIPSMlYYneCJVUEdXJixlFORG2xWYD2S2oQgpEQoWPx+OaaNOHPiPMTZwuUpQpAmIUbFEi7
 jQ4JJMJN3t0q8Gv5na/QmGSOZMr2aGKo=
X-Received: by 2002:a2e:9fca:0:b0:3a9:969e:98a6 with SMTP id
 38308e7fff4ca-3a99af67db3mr1737921fa.25.1791282652577; Tue, 06 Oct 2026
 03:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 6 Oct 2026 12:30:40 +0200
X-Gmail-Original-Message-ID: <CAD++jL=gFt9kKZH9T-m8B_pbwRvzc35tTrMn5V238d3528DpUg@mail.gmail.com>
X-Gm-Features: AclHuK_AtwEo8WT_r25jczYf_hFshziwzfIIOr6vEXjFvPYUcVAgc5OmT1Oo8GM
Message-ID: <CAD++jL=gFt9kKZH9T-m8B_pbwRvzc35tTrMn5V238d3528DpUg@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] pmdomain: st: ux500: Implement ux500 power
 domains
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Frank Li <Frank.Li@nxp.com>, 
 Frank Li <Frank.li@oss.nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Mark Brown <broonie@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@kernel.org>, Lee Jones <lee@kernel.org>
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

Hi Ulf,

On Mon, Sep 21, 2026 at 12:48=E2=80=AFAM Linus Walleij <linusw@kernel.org> =
wrote:

> This series pays off technical debt from the beginning of the device
> tree for ARM initiative in the early 2010s.

I have so many fixes series that need to land for v7.4 that this is
mostly targeted at v7.4 at this point.

However:

> Linus Walleij (18):
>       dt-bindings: power: Convert Ux500 PM domains to schema
>       dt-bindings: arm: ux500: Drop NR_DOMAINS
>       dt-bindings: arm: Add the actual power domains on U8500

What do you think about applying these three patches to the
PM domain tree as a starter for v7.4 if it's not too late?

They are reviewed by binding maintainers and should be
uncontroversial and will make it possible to avoid trouble when
merging more stuff later.

Yours,
Linus Walleij
