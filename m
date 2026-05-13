Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B129BCD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1709489E69;
	Wed, 13 May 2026 07:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DVRLNIvx";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCAC389E69
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 07:56:00 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 32B4B229;
 Wed, 13 May 2026 09:55:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778658951;
 bh=yjpuKSIX9YhnkTy1kB78nxXlSk9S5Nh1vV9uFqCDb9c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DVRLNIvxPqnTZ7FvjL5QwvJKO3lBxL/u+sqBneD59K22/nO1+vb+X6JyR6IocHVmr
 J/KmCvkfVtRrcF9GEt3ICI12sCWQ6op0O80tt4wFPnO5S0RqjBGdDklCkijl2TGEHh
 aVIzBBfuBlBXBNQXUhJHBcByTM6FKS+8/gmdxNhg=
Message-ID: <af7006a6-6048-42c9-8771-4687a51cc245@ideasonboard.com>
Date: Wed, 13 May 2026 10:55:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] dt-bindings: mfd: syscon: Add
 ti,am625-dss-dpi0-clk-ctrl compatible
To: Rob Herring <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Louis Chauvet
 <louis.chauvet@bootlin.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
 <20260420-beagley-ai-display-v1-3-f628543dfd14@ideasonboard.com>
 <20260505193538.GA3785056-robh@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260505193538.GA3785056-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 05/05/2026 22:35, Rob Herring wrote:
> On Mon, Apr 20, 2026 at 03:54:10PM +0300, Tomi Valkeinen wrote:
>> The DPI output pipeline in K3 SoCs contains the display subsystem (DSS)
>> which produces the in-SoC parallel video signal, and a DPI block which
>> adjusts the signal to the external MIPI DPI output.
>>
>> The DSS IP has registers to configure whether the data and sync signals
>> are driven on rising or falling clock edge, and on some SoCs these are
>> automatically conveyed to the DPI block which needs that configuration
>> to properly output the MIPI DPI signal.
>>
>> However, on some SoCs the DPI block configuration has to be done
>> manually, using an extra register outside the DSS, DPI0_CLK_CTRL in
>> MAIN_CTRL_MMR_CFG0 block, which controls the DPI block's behavior. Note
>> that while the register is named "CLK_CTRL", it's not really related to
>> clocks, but the sync and data signals.
>>
>> Currently the DPI0_CLK_CTRL is never written, so it's always 0, meaning
>> the data and sync are always driven on a rising clock edge regardless of
>> the DSS configuration.
>>
>> DPI0_CLK_CTRL register seems to be an independent "quirk" register,
>> inside MAIN_CTRL_MMR_CFG0 block, which contains general purpose system
>> registers. The registers surrounding DPI0_CLK_CTRL seem to be controlled
>> by the system firmware or linux clock drivers. So, it is just this
>> single register we can map, and we can't create a syscon node for the
>> whole (or big parts of) MAIN_CTRL_MMR_CFG0.
>>
>> I see two options to handle the register:
>>
>> 1) We could add that single register to the DSS binding as a new reg
>>     block. That feels wrong, as it's not a DSS register.
>> 2) Add it as a syscon node, which can then be used by tidss driver.
>>     It is a bit silly to create a syscon node for a single 32-bit
>>     register, though.
> 
> Is it really 1 register and nothing else in that h/w block? That's quite
> unusual.
It is just this one register that the DSS driver is interested in, and 
that register is surrounded by registers used by other, unrelated, 
drivers or the system firmware.

This has been discussed in some older threads, and to summarize:

The Soc has a so called CTRL_MMR (control memory-mapped-registers) area 
at 0x100000, size 0x20000. It's a dumping ground for all kinds of system 
integration registers. In the current binding, this has been just a 
simple-bus, containing some sub-nodes (shortened version):

main_conf: bus@100000 {
	compatible = "simple-bus";
	reg = <0x00 0x00100000 0x00 0x20000>;

	phy_gmii_sel: phy@4044 {
		compatible = "ti,am654-phy-gmii-sel";
	};

	audio_refclk0: clock-controller@82e0 {
		compatible = "ti,am62-audio-refclk";
	};

	dss_oldi_io_ctrl: dss-oldi-io-ctrl@8600 {
		compatible = "ti,am625-dss-oldi-io-ctrl", "syscon";
	};
};

There already was the dss-oldi-io-ctrl, so this new 
am625-dss-dpi0-clk-ctrl was added the same way as we needed a syscon.

After some testing, changing the whole main_conf to a syscon seems to 
work ok, even if inside it there are devices mapping parts of the same 
memory area (although I'm not sure how to test all those devices). I 
originally thought mapping the same memory area from two different 
driers would immediately fail.

So, instead of adding a new special syscon node for this single 
register, as done in this patch, I think we can just make the whole 
main_conf a syscon, and point to it from the display subsystem node:

	ti,dpi-io-ctrl = <&main_conf>;

Then the driver would need to access the register with offset 0x8300. 
But I'm a bit reluctant to add such a SoC-integration related offset to 
the driver. Even if the register would stay the same from SoC model to 
another, the offset could change. So, we could, in the display subsystem 
node, do:

	ti,dpi-io-ctrl = <&main_conf 0x8300>;

The driver can use syscon_regmap_lookup_by_phandle_args() and thus get 
the offset from the dts. I think this works ok, so I'll make that change 
for v2 unless someone has better ideas.

  Tomi

