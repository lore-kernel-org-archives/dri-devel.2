Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60ADC44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F126B10F012;
	Wed, 15 Jul 2026 12:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MkqZkC3B";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90FB10F012
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784117292;
 bh=MGZa8VlkBjkjYZ/2EkhuLhPBfqYxL/FmRhYPWex3eW0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MkqZkC3BKxtRSD0O8Sg9nltF562E/q0SuQoi7L+MEYt8RmXjXEE2ltcUPIa4pj2CI
 VJE8A7rae/bgbT6BTyl+4zwenzwNFd3Ig/UdSUM20mXnNmZXUXjVl+8R1jGffUNn+Y
 iP13PLRgCavwjjivKu2Y/8CBzBUkbqRd3+dhTTfjCZwD/oAM/gkvh2EY5hCBAecMds
 r9vPcRklHWK8GwYkX8jYiqiOWUF4mnJSzEH9LTXTlVzbPo14mP601kMku0dxNP+OlV
 DznmbZkhB40OxTScerSthJHTkple8rGJuYQ7n0ZiwkZqvTMZ3qxPqXnmrQlFTGIW7P
 Q5Sc+u5iHdDsA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 460BE17E095B;
 Wed, 15 Jul 2026 14:08:12 +0200 (CEST)
Message-ID: <4f54dbb3-3e37-4219-bc54-d5f79dce0295@collabora.com>
Date: Wed, 15 Jul 2026 14:08:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/11] drm/mediatek: Implement Display Stream
 Compression support
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20260715114916.19690-1-angelogioacchino.delregno@collabora.com>
 <20260715114916.19690-3-angelogioacchino.delregno@collabora.com>
 <20260715120219.B11FD1F000E9@smtp.kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260715120219.B11FD1F000E9@smtp.kernel.org>
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

On 7/15/26 14:02, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential issue(s) to consider:
> - [High] Hardware Initialization Bypass due to skipped array element in DDP component loop.
> - [High] DSC configuration is written after the component is started, causing pipeline corruption.
> - [High] State leak of `dsc_config_done` breaks non-DSC display modes.
> - [High] DSI clock lane timing register `DSI_HSTX_CKL_WC` is destroyed by being overwritten with the pixel payload word count.
> - [High] Hardcoded 2x multiplier for DSC slice count results in incorrect DSI payload word count.
> - [High] Bandwidth calculations use uncompressed bits-per-pixel (bpp), falsely rejecting valid DSC modes and misconfiguring PHY clocks.
> - [Medium] Uninitialized variable `slice_chunk_size` is used for hardware configuration during DSI power-on.
> --
The same replies that I gave to Sashiko in v4 also apply to v5.

In short: Sashiko doesn't understand how the hardware works, so it throws random
issues.
