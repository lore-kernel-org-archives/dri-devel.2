Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41714C88E41
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 546A910E342;
	Fri, 11 Sep 2026 05:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bh8D6MBV";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B5D610E342
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 05:15:19 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 70E2356F;
 Fri, 11 Sep 2026 07:13:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1789103620;
 bh=mNvK2nGWSIPSFBvQJrCQfPiov5C3onxjL7tMNQOn6lQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bh8D6MBV1QvoMShMreXzDhl3bx8r80k1+oE78KwJdvYquTBq5mEDcyruKwDkW4FJr
 uGbgQUbyRqwLKCaJWHaLdHk1l10UlqQow30ryWpgSPDN0nLL2uni9dhQZYk6SU9tTL
 DG5DZoid4GHU6DuOsbQmHo86dJlV0nqIRHpV2cfw=
Message-ID: <0b93117c-7ce4-4fe6-a896-34e4fa6fcfb0@ideasonboard.com>
Date: Fri, 11 Sep 2026 08:15:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/rcar-du: dsi: Implement DSI command TX using AXI
 memory access
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260910182003.31612-1-marek.vasut+renesas@mailbox.org>
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260910182003.31612-1-marek.vasut+renesas@mailbox.org>
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

On 10/09/2026 21:19, Marek Vasut wrote:
> Currently, the driver supports register access mode for DSI command
> transfer, which limits both TX and RX to only 16 Bytes long packets.
> Implement support for DSI command TX using AXI memory access mode,
> which extends the packet transfer length up to 128 Bytes long in LP
> and 1024 Bytes long in HS. Support for DSI command RX using the AXI
> access mode is not implemented due to missing test hardware.
> 
> The implementation allocates a DMAble 4k page. In case the command
> transfer is longer than 16 Bytes, the payload is copied into the
> page and sent out using the AXI access mode, otherwise the register
> access mode is used.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: David Airlie <airlied@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: - Use dma_set_mask_and_coherent() to set up global DMA mask and
>        drop GFP_DMA32 from dma_alloc_coherent() gfp flags.
>      - Fix DMA memory leak in missing fail path in rcar_mipi_dsi_probe()
>        and move dma_alloc_coherent() almost to the end of the probe
>        function, so as much as possible of the probe function is devm
>        managed.
>      - Unregister DSI host first, then free the DMA page
> V3: - Limit transfer to 1024 Bytes
> ---
>   .../gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c   | 50 ++++++++++++++++---
>   1 file changed, 42 insertions(+), 8 deletions(-)
Reviewed-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>

  Tomi

