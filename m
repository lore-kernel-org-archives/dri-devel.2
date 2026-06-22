Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10826CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 17:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7512B10E2FD;
	Mon, 22 Jun 2026 17:43:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NNQEgeXx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 128D510E7D5
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 17:43:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56311601F3
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 17:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1034F1F0155F
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782150213;
 bh=ZOvkxM7SoiYga4F3HI0NRlsezjpo0hLIkN4UO4HHxjU=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=NNQEgeXxyT/moB48MdHxby95e0FThhBV4uoT4VD31GCcJbCHyjhKKVbNIaZYqmGWk
 CD4uMaoAz372+XsGdZsTQnNC/jSE01hKULptfXo977iBXAHFSy+e9ynPmCyhRo91Kh
 AiKoxM5y6Al/Kl0EUskgOk94l5fAkKETSBJTG+u6ItJeLX14kcqvlni6HLPkVXq9B5
 leuvlefWWL5l/0cdVw9umOVS3zge7Q91XfTh3HKX07tl3/GySnTNs2vodU+O/Qg3TV
 VI/BwvlOiV6zgNS5KPwhh+tbpS+vxMN00VasovDIqVyTZ/jMwXtoCuw0kIrxcLeKjM
 YQAOzUAslyEHw==
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-3966c0d5ac9so47961321fa.2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 10:43:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ95g7YNeEkN4VQY+OhNxEOreuYyI//f6/J4l+eTd3cCW4EKe/klF9Wa7YX6odngI9BUtSgFvIj+u1E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySo5ObsfT9mi8iehp1caTqEehQUToVcmmPYKiq0N17osZc8qmv
 qpWdzXoUMGbsdlRwgdoin18uQjxOAGzXiyrXi75OWJMrc9+mm64Zjg9MEBH47w+54t2SkyXxuYE
 g60GNXHgTx/TgdE1elzh2FqujG7wAuF1s0wNExmymQA==
X-Received: by 2002:a05:651c:88b:b0:394:635:70b1 with SMTP id
 38308e7fff4ca-3998bc52fbemr41304291fa.3.1782150210743; Mon, 22 Jun 2026
 10:43:30 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 13:43:29 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 13:43:28 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-5-88c324a1b8d2@oss.qualcomm.com>
MIME-Version: 1.0
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-5-88c324a1b8d2@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 13:43:28 -0400
X-Gmail-Original-Message-ID: <CAMRc=MfSsLt8+CAh++8qo_=F=q5XRu6G3WGB=B2TZj8dTZydfg@mail.gmail.com>
X-Gm-Features: AVVi8CfRnQqz6Nh2M0v3z0C67LQjbAf_AXtOmIr-lp4acya5s7VimMoD1ExGxmc
Message-ID: <CAMRc=MfSsLt8+CAh++8qo_=F=q5XRu6G3WGB=B2TZj8dTZydfg@mail.gmail.com>
Subject: Re: [PATCH 05/23] powerpc/powermac: fix OF node refcount
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
 linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 stable@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, 
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
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Doug Berger <opendmb@gmail.com>, 
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
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

On Thu, 21 May 2026 10:36:28 +0200, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> said:
> Platform devices created with platform_device_alloc() call
> platform_device_release() when the last reference to the device's
> kobject is dropped. This function calls of_node_put() unconditionally.
> This works fine for devices created with platform_device_register_full()
> but users of the split approach (platform_device_alloc() +
> platform_device_add()) must bump the reference of the of_node they
> assign manually. Add the missing call to of_node_get().
>
> Cc: stable@vger.kernel.org
> Fixes: 81e5d8646ff6 ("i2c/powermac: Register i2c devices from device-tree")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  arch/powerpc/platforms/powermac/low_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
> index da72a30ab8657e6dc7e6f3437af612155783d8f9..973f58771d9636605ed5d3e91b45008543b584d3 100644
> --- a/arch/powerpc/platforms/powermac/low_i2c.c
> +++ b/arch/powerpc/platforms/powermac/low_i2c.c
> @@ -1471,7 +1471,7 @@ static int __init pmac_i2c_create_platform_devices(void)
>  		if (bus->platform_dev == NULL)
>  			return -ENOMEM;
>  		bus->platform_dev->dev.platform_data = bus;
> -		bus->platform_dev->dev.of_node = bus->busnode;
> +		bus->platform_dev->dev.of_node = of_node_get(bus->busnode);
>  		platform_device_add(bus->platform_dev);
>  	}
>
>
> --
> 2.47.3
>
>

Madhavan, can you please pick this up and send it upstream as a fix please?
Not having to carry it with the rest of the series will make things easier
for the next release.

Thanks,
Bartosz
