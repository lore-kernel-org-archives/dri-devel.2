Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA11CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3437113FB0;
	Thu,  4 Jun 2026 12:33:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fP9rNTi5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9367113FB0
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:33:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC9DB44615
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DFC1F00A03
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780576413;
 bh=5kiOPwwtw5er+j3pQh3lrbhA4I9B2m+C9oKB0UBWW9E=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=fP9rNTi5MtE7GCGm/x/LyhMZobzDw2BPjzDPFH8vu6A2Ihc1x0gZCGx/8KHtKr+NQ
 9VU8hrkHxq4QD3yOaMQhJxyg5QmB193Bl0ZPkoFOqK9aG4fqijPuyGUaShi+2Kcg6Q
 WNJyWoBtHQTw/ffnZhT2lBeH4E+j/daht+qed1ocXq5IaM7LCqk8LdZ6oiRSFoFWGH
 qVMkffhSF4xNFZpT0RuH0BP/QIMVy9iVKoOdwGpjFzetMPvPPN/kFu3cFOoETaSWHA
 xRtqHx+25lqBcSS+qwunrA10HLhbGycr55T5kf3P4VR83pcARAwuSQhBeLmDEXT+H3
 auAKRLtqmlw3w==
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-396775c2720so5609341fa.2
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 05:33:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ94c5Ya3RumEv5c1hHFJ2bYqTYdH4mf39yNVD/40Yw378jJENtyZ+Flqusva6N9ammnyi1VFOVSXI8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+S6aZoOojz3qdxuj5uAlLWD14JNAarbYnQBV+VOgMH/S52qks
 sGE7C1ZR3RW2WdMbWok1cGX/ZRx5KqmOxmVgpPEg9/UPCot/ueNjgSB/ovfWbNHZC/PweyDLd8d
 4CP8OI6V2AMy0R1uGjEdI3PzKT5fZ1GvQ5XLfHXgiJQ==
X-Received: by 2002:a05:6512:2256:b0:5aa:6bd0:b1e3 with SMTP id
 2adb3069b0e04-5aa7c038408mr3094935e87.8.1780576412192; Thu, 04 Jun 2026
 05:33:32 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 05:33:30 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 05:33:29 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ah9O15bMlAYgSlHx@ashevche-desk.local>
MIME-Version: 1.0
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-8-88c324a1b8d2@oss.qualcomm.com>
 <ah9O15bMlAYgSlHx@ashevche-desk.local>
Date: Thu, 4 Jun 2026 05:33:29 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeFxtwwXvOD7FLmbhjpraDKa2O7KdwMaUXM-mNj7Ob2ow@mail.gmail.com>
X-Gm-Features: AVHnY4L20t8vC6nB7rdbE5RCKEyJuG_U-L0VQ-6S9fbqED8WJ64Vn6Fpm8JRl-0
Message-ID: <CAMRc=MeFxtwwXvOD7FLmbhjpraDKa2O7KdwMaUXM-mNj7Ob2ow@mail.gmail.com>
Subject: Re: [PATCH 08/23] driver core: platform: provide
 platform_device_set_of_node_from_dev()
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
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
 linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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

On Tue, 2 Jun 2026 23:44:55 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Thu, May 21, 2026 at 10:36:31AM +0200, Bartosz Golaszewski wrote:
>> Provide a platform-specific variant of device_set_of_node_from_dev(). In
>> addition to bumping the reference count of the OF node being assigned,
>> it also assigns the fwnode of the platform device.
>
> Can we rather investigate the way how to make that of node reuse thingy
> (which is used solely by pin control) differently and then drop this confusing
> device_set_of_node_from_dev() call altogether?
>

Possibly but I can't do everything in a single series. Let's take it one step
at a time. The goal of this is to make software node handling for platform
devices more correct.

Bart
