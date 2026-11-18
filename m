Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A45606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omuiVZJh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD92210ECB3;
	Wed, 18 Nov 2026 21:13:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E1410EC89
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:13:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7BC8940973;
 Wed, 18 Nov 2026 21:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C421F000C4;
 Wed, 18 Nov 2026 21:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795036418;
 bh=lstpkAIMdhIw+8kIInQTbIFSQvVqWAgkCSm9ri4rJmg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=omuiVZJhZM6x9teRUwaSK7YbBaY600rkORp2u2GDqoekPAKmsJ6G8Ka5+5mq4vFxP
 jn0IR2UqCzS2BP99PhVTj3jIMgzRQ7Grt8rTmBlqCQQAhsOOMUDMK0LiLGsTXZfNKY
 fZlV2NHg271oRxu5Fy+E0DuJKRXX7iluhp50der5q2Jp8llNkQrsjUmWGxvGkkFdiS
 Eg6BdLRyIYAd8YjHQjSC4Z1PM7yQwpKA8kmkHQXjcl1ky5JNj4QqhKr+irC3PiyBtc
 IWWZLuGbMwRAFhvkn42J1QNYYMEFMCCa12btmQz34oKbia9o9Mwn2dZgrRKe3Iph9T
 LkketrxYjMRGg==
Date: Wed, 18 Nov 2026 15:13:36 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: airlied@gmail.com, jbrunet+clk@baylibre.com,
 Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
 Chen-Yu Tsai <wens@kernel.org>, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 bmasney+clk@redhat.com, simona@ffwll.ch, linux-clk@vger.kernel.org,
 tzimmermann@suse.de, sboyd@kernel.org,
 Andre Przywara <andre.przywara@arm.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
 krzk+dt@kernel.org
Subject: Re: [PATCH v3 7/8] dt-bindings: display: allwinner: Split H616 DE33
 layer reg space
Message-ID: <179503641576.1032413.14291544816555567669.robh@kernel.org>
References: <20261115061102.229680-1-jernej.skrabec@gmail.com>
 <20261115061102.229680-8-jernej.skrabec@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115061102.229680-8-jernej.skrabec@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sun, 15 Nov 2026 07:11:01 +0100, Jernej Skrabec wrote:
> As it turns out, current H616 DE33 binding was written based on
> incomplete understanding of DE33 design. Namely, planes are shared
> resource and not tied to specific mixer, which was the case for previous
> generations of Display Engine (DE3 and earlier).
> 
> This means that current DE33 binding doesn't properly reflect HW and
> using it would mean that second mixer (used for second display output)
> can't be supported.
> 
> Remove layer register space, which will be represented with additional
> node, and replace it with phandle, which will point to that new, shared
> node. That way, all mixers can share same layers.
> 
> This change is intentionally not backward compatible and the old binding
> will not be supported by the driver, for the following reasons:
> 
> - It can't describe the hardware. Plane register space is shared
>   between all mixers, but the old binding puts it in the mixer node, so
>   only one mixer can ever claim it. The second mixer can't be supported
>   with the old binding at all. It also has no way to reference plane to
>   mixer mapping registers, which live in display clocks register space.
> 
> - Supporting it would mean keeping a second, mixer-local plane
>   management path in the driver, with hardcoded plane mapping, which
>   doesn't match the hardware and which can't be tested, since nothing
>   uses it.
> 
> - It was never used. Upstream H616 DT has no Display Engine nodes and
>   the rest of H616 display pipeline (TCON, HDMI, PHY) is not supported
>   upstream yet, so the old binding never produced a working display.
>   Vendor BSP kernels use a completely different DT structure and no
>   other known DT consumer (U-Boot, *BSD, Zephyr, TF-A, ...) implements
>   H616 display support. Only out of tree WIP patches used it and those
>   are updated together with the kernel.
> 
> The driver will print an error, asking to update the device tree, when
> the old binding is detected.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  .../display/allwinner,sun8i-a83t-de2-mixer.yaml  | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

