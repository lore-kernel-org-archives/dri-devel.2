Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2A606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSouJfLI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A5C10F2A5;
	Mon,  9 Nov 2026 13:47:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2098210F2D7
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 13:47:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC0E540221;
 Mon,  9 Nov 2026 13:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B223D1F0089F;
 Mon,  9 Nov 2026 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794232053;
 bh=+5mMH+ae6U1FA4SCfDlLpoRaYWHjV9rRt4QtO/Ofeds=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VSouJfLIpck7CNeRnZ/L/Kkp0YXjbA/9IIuZSaiFuNW9voZYJ1+6nyvOgccdKGIVz
 HngNZh7yKwRqwl3CE+H0UZUoO9Dcuy43S0iRTf8lwKwUB4XUp+ZYAZqBpcLJdv4X86
 AOUxxmfe0xmQ209GIw7DO0Zfy/dn3mqxlrIM8ZSGlozCWHLbDvq8lR7nx5wT16t/M3
 H3tPUPFlJ0FbnmjwcVqi2JCkNsTZYXBhd/EQR/5xl9z4YPU71UmktyBKfGBXwRQn8E
 adplzbfW/kMWVuz9bBkqTn5tPLGM8f/zi4F6gW0VWenGK+jhf5wXCdVmvuO58E3HCt
 qf3myaB1SBGkQ==
Date: Mon, 9 Nov 2026 14:47:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 michal.simek@amd.com, deller@gmx.de, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, git@amd.com
Subject: Re: [PATCH 1/2] fbdev: xilinxfb: remove the driver
Message-ID: <20261109-jumping-dolphin-of-refinement-14df24@quoll>
References: <20261106170902.3656809-1-radhey.shyam.pandey@amd.com>
 <20261106170902.3656809-2-radhey.shyam.pandey@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106170902.3656809-2-radhey.shyam.pandey@amd.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 10:39:01PM +0530, Radhey Shyam Pandey wrote:
> Remove xilinx framebuffer soft IP driver. This IP core relies on Xilinx
> Platform Studio (XPS) and the ISE Design suite, both of which were
> discontinued by Xilinx years ago. Furthermore, modern AMD toolchains
> (Vivado Design Suite and Vitis) provide no support for the legacy PLB
> (Processor Local Bus) architecture used by these cores. As a result,
> no new hardware designs can be built using this IP.
> 
> Nothing in the tree document the driver compatible strings. Given the
> complete obsolescence of the supporting hardware development tools
> and the lack of upstream users, remove the dead driver.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---

You can include here defconfig update.

Best regards,
Krzysztof

