Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F38CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D4110E9BA;
	Tue, 16 Jun 2026 09:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F88UFqux";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD0A10E9BA
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:51:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A3A3D4378D
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD911F00ADE
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781603507;
 bh=rKN6Dquf9JjEmoiOojbev5G9ca2XqPvpxKtiKVWHsuA=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=F88UFquxP6GLTDnZndksxQH93yb7LMcZiAKfOmWMrZWnPbMsihpEeRj3B3ypIx14N
 epvt/Fduq7ggo+VV9WejL+g7Sr8uUgpEwhUghrJOHV2dDu2cJpMGZAwcafnTN6Kwbp
 a15VxT0oN1UFkqIjBTBPuz+ANyeGrSPc9cwc/Ba8wgMItVhAx1/RhWdSYi9MNN5EZL
 /pngyeY6RoI0nwh7Z3R16ElAujbM26xlreosWrdgb2Uz0O09Yj8qqnp6vFlSetlLKF
 BXjILI+uuZq84yMv33tltQiFi5KpHo5Cw4g55Nz/0ylLV1OUjYGEAN3Ht6BNupLR3T
 h4rEOtybtCu8w==
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-3965eab14cfso34245001fa.0
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 02:51:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+GkghVLRIXrx5yy9/CBDzEeTpNaw6S1Os7Y/Y3BR/1Qcl0XwLAr6mjbZRnha25m04ole3zil/FUdA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywd1ilPHmJoQY6Ide8+2UtHs+CPOymgyitpA1wIVsmQwcC5DkZ7
 8VApwtmlodhKdNifrs0nriadNPTFLmjL0s/m3jRbxKNkwT64S2NEGILw6hKkxQWFcCxd59pB63e
 9Ii4g2zX+X97j11xYzwTPz9ES2DRj+6bZVEZkCAmEWw==
X-Received: by 2002:ac2:5597:0:b0:5aa:6aac:3f7f with SMTP id
 2adb3069b0e04-5ad4277bed7mr670959e87.22.1781603505619; Tue, 16 Jun 2026
 02:51:45 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 05:51:44 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 05:51:43 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ajEcDq0S067wMFaK@black.igk.intel.com>
MIME-Version: 1.0
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-7-88c324a1b8d2@oss.qualcomm.com>
 <ah9OIVyrHEhcMHzN@ashevche-desk.local>
 <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
 <ajEcDq0S067wMFaK@black.igk.intel.com>
Date: Tue, 16 Jun 2026 05:51:43 -0400
X-Gmail-Original-Message-ID: <CAMRc=MfY3k4a9KdPE-4pmMUEH4KADYaO8ZY+Md9sMzgFr0-s9A@mail.gmail.com>
X-Gm-Features: AVVi8Ccfi9fNZx5anc5Hh9w27iqbKs4Mv-ef0kQk9lnbNaF9SR74KH4RoJVGW8U
Message-ID: <CAMRc=MfY3k4a9KdPE-4pmMUEH4KADYaO8ZY+Md9sMzgFr0-s9A@mail.gmail.com>
Subject: Re: [PATCH 07/23] driver core: platform: provide
 platform_device_set_fwnode()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>, 
 Thierry Reding <thierry.reding@avionic-design.de>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, 
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Ulf Hansson <ulfh@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, 
 Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, driver-core@lists.linux.dev, 
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-i2c@vger.kernel.org, iommu@lists.linux.dev, linux-pm@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-usb@vger.kernel.org, linux-mips@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 16 Jun 2026 11:49:02 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Thu, Jun 04, 2026 at 05:32:27AM -0700, Bartosz Golaszewski wrote:
>> On Tue, 2 Jun 2026 23:41:53 +0200, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> said:
>> > On Thu, May 21, 2026 at 10:36:30AM +0200, Bartosz Golaszewski wrote:
>> >> Provide a helper function encapsulating the logic of assigning firmware
>> >> nodes to platform devices created with platform_device_alloc(). Make the
>> >> kerneldoc state that this is the proper interface for assigning firmware
>> >> nodes to dynamically allocated platform devices. This will allow us to
>> >> switch to counting the references of the device's firmware nodes in the
>> >> future, not only the OF nodes.
>> >
>> > But why different for of_node and fwnode to begin with?!
>>
>> I'm not following. What are you suggesting?
>
> After re-reading of this thread, I think I'm suggesting the same what you have
> in plans to do in the future as you put it as "This will allow us to switch to
> counting the references of the device's firmware nodes in the future, not only
> the OF nodes."
>
> // Offtopic
> I haven't heard from you for more than a month on this:
> https://lore.kernel.org/r/af18zdP5HF3_P9Vo@black.igk.intel.com
> Anything should I do? Please, answer to that thread.
>

Eek, sorry, must have flown under the radar.

I'll pull it now, I will do a second PR for this merge window anyway.

Bart
