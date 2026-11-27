Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B432606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cYH2v8JY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 752D8112976;
	Fri, 27 Nov 2026 10:03:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 67155112976
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:03:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A8C41758;
 Fri, 27 Nov 2026 02:03:20 -0800 (PST)
Received: from [10.33.50.35] (e142021.arm.com [10.33.50.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 671123F86C;
 Fri, 27 Nov 2026 02:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795773802; bh=H8nZxnnDGCJuTHPvOjaWLW2hhq4iXdq3kr4GLdgMbYc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cYH2v8JYfSlKSm6ZU73aDFvRc7WlCVMeF0g3+UbC9kRZKGdzHWwTu6gHISmDJwJ6K
 VPEmR19SFFV0mQu2hCiL1pVSZ0H8xZZUlW21OAwqeV/XieQ/XSym4yfn7scqXB527u
 nzRhpfMl8pWJ47e+AirLLdt5xtQdGK4IeMuewj1U=
Message-ID: <18637573-d20f-4a58-9e63-6bf71b015cef@arm.com>
Date: Fri, 27 Nov 2026 10:03:18 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: dts: allwinner: sun60i-a733: Add simplefb HDMI
 support
To: Alastair D'Silva <alastair@d-silva.org>, Hans de Goede
 <hansg@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20261127080649.1982883-1-alastair@d-silva.org>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20261127080649.1982883-1-alastair@d-silva.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/27/26 09:06, Alastair D'Silva wrote:
> This series adds boot-time simplefb HDMI support for Allwinner A733
> (sun60i-a733). U-Boot enables DE3.5, TCON_TV0, and DW-HDMI2.0 and

Where does it do that and which U-Boot version does?
I don't think we really want simplefb in the mainline DTs any more, 
unless there is a big blocker or delay for proper Linux DE support (like 
there was back in the A64 days).
In Jernej's HDMI series he hints about A733 support being pretty 
straight-forward with the reworked H616 DE code, so chances are we see 
proper DE3.5 support in DRM rather sooner than later.

Cheers,
Andre

> updates the disabled /chosen/framebuffer-hdmi node. Linux keeps the
> display clocks and PCK-600 power domains active across boot.
> 
> Tested on Xunlong OrangePi 4 Pro, based on:
>    [PATCH 0/3] arm64: dts: allwinner: Add Xunlong OrangePi 4 Pro support
>    https://lore.kernel.org/r/20261125124407.4098345-1-alastair@d-silva.org
>    [PATCH] pmdomain: sunxi: pck600: Initialize pd->pck in probe
>    https://lore.kernel.org/r/20261127080625.1982574-1-alastair@d-silva.org
> 
> Alastair D'Silva (3):
>    dt-bindings: display: simple-framebuffer: Add Allwinner DE3.5 HDMI
>      pipeline
>    arm64: dts: allwinner: sun60i-a733: Add PCK-600 power domain
>      controller
>    arm64: dts: allwinner: sun60i-a733: Add simplefb HDMI node
> 
>   .../bindings/display/simple-framebuffer.yaml  |  1 +
>   .../arm64/boot/dts/allwinner/sun60i-a733.dtsi | 36 +++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> prerequisite-patch-id: 309a5a3ca5b216915907263dea7024263abf1d1c
> prerequisite-patch-id: 55e543b9854c7ae2fa86969233d05ccadd3792e9
> prerequisite-patch-id: cfcad85224e288ec2168e7f245b4a1c63e9a34a7

