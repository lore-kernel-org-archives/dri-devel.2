Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB79C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D06D810E12C;
	Fri, 10 Jul 2026 14:09:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kgmiif0J";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DE389316;
 Fri, 10 Jul 2026 14:09:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D4C2460051;
 Fri, 10 Jul 2026 14:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7411F000E9;
 Fri, 10 Jul 2026 14:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1783692593;
 bh=h1xi3IKQjbdJ53JCv2L+jzRlcSu7ApiSTvfpodjcvtk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kgmiif0JKq2HSeSzJ7OofwRSlUD94iS3uEV1tKQ943E0Dw5HJBa/NodJ+UjhAlKNH
 FGbXFGZ+JEAXY3Dr+tF4ssnWwH8WP2JApHQJxCeAynEVTGBtdWPwSFCDmJ7/fOYkFW
 Kncg2+p1T/D/wvPa/3glV7KVkw5wq6sn17XSngyM=
Date: Fri, 10 Jul 2026 16:09:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Srinivas Kandagatla <srini@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Peter Chen <peter.chen@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 driver-core@lists.linux.dev, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, mfd@lists.linux.dev,
 stable@vger.kernel.org, Manuel Ebner <manuelebner@mailbox.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v3 00/20] driver core: count references of the platform
 device's fwnode, not OF node
Message-ID: <2026071001-limelight-stoppable-d7cb@gregkh>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
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

On Mon, Jul 06, 2026 at 02:44:12PM +0200, Bartosz Golaszewski wrote:
> Platform device core provides helper interfaces for dealing with
> dynamically created platform devices. Most users should use
> platform_device_register_full() which encapsulates most of the
> operations but some modules will want to use the split approach of
> calling platform_device_alloc() + platform_device_add() separately for
> various reasons.
> 
> With many platform devices now using dynamic software nodes as their
> primary firmware nodes and with the platform device interface being
> extended to also better cover the use-cases of secondary software nodes,
> I believe it makes sense to switch to counting the references of all
> kinds of firmware nodes.
> 
> To that end, I identified all users of platform_device_alloc() that also
> assign dev.of_node or dev.fwnode manually. I noticed five cases where
> the references are not increased as they should (patches 1-5 fix these
> users) and provided three new functions in platform_device.h that now
> become the preferred interfaces for assigning firmware nodes to dynamic
> platform devices (in line with platform_device_add_data(),
> platform_device_add_resources(), etc.). The bulk of the patches in this
> series are small driver conversions to port all users to going through
> the new functions that now encapsulate the refcount logic. With that
> done, the final patch seamlessly switches to counting the references of
> all firmware node types.
> 
> This effort is prerequisite of removing platform_device_release_full()
> and unifying the release path for dynamic platform devices using
> unmanaged software nodes.
> 
> Merging strategy: The entire series should go through the driver core
> tree, possibly with an immutable branch provided to solve any potential
> conflicts though these are rather unlikely.

I've added this to the driver-core-testing branch now, thanks!

greg k-h
