Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D7606A31D
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjQioaSI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C31910E8BB;
	Sun, 15 Nov 2026 12:09:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B874010E8BB
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 12:09:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CA8E41790;
 Sun, 15 Nov 2026 12:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F731F000C4;
 Sun, 15 Nov 2026 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794744592;
 bh=b4p9wV2tpTy8te3nY3YNbgd551xiWngtyJF9zg8GUbI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=kjQioaSIpqKriLrPr7CHHViM9z1V9W+JXYEgp/R4VvntcOwHi2zZLaxf1BI8JFVhQ
 gu53ZmMEWBAogezb8DCRimozgXN8fyiYkdvz9JuuFA5a/ks2bh4FceKOFtNzGpqfrH
 /6mQqdNbko4VpJtpDzX5XE+y3xDZ4kssbxFsxqyTIaaKHVPdSUVZG8uor+lur1zzXQ
 7doWLP7VOu8a965Sd2nFww/c6d5cASvz99EDRgBCWbQ72c7txgQz4g61ytcVgrp11k
 2f4d3ucSinmZAARo+zBaycMvE+BJkpLISrATCs21yp/bsCuydefsjzJwaFBMe15mTR
 gJxwKhsm8dymg==
From: Chen-Yu Tsai <wens@kernel.org>
To: Samuel Holland <samuel@sholland.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, bmasney+clk@redhat.com, 
 jbrunet+clk@baylibre.com, sboyd@kernel.org, 
 Andre Przywara <andre.przywara@arm.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org
In-Reply-To: <20261115061102.229680-1-jernej.skrabec@gmail.com>
References: <20261115061102.229680-1-jernej.skrabec@gmail.com>
Subject: Re: (subset) [PATCH v3 0/8] drm/sun4i: update DE33 support
Message-Id: <179474458919.3130971.11295267069000925576.b4-ty@kernel.org>
Date: Sun, 15 Nov 2026 20:09:49 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 15 Nov 2026 07:10:54 +0100, Jernej Skrabec wrote:
> This is second series out of tree which aims at properly introducing
> support for H616 Display Engine 3.3. Previous series [1] reorganized
> driver so proper DE33 support can be easily implemented.
> 
> H616 DE33 support was actually introduced a while back, but it was done
> without fully understanding hardware design. Issue with existing binding
> is that it considers planes as resource which is hardwired to each mixer
> as it was done on older Display Engine generations (DE3 and lower). That
> is not the case anymore. This series introduces new driver for planes
> management, which allows doing proper plane assignments.
> 
> [...]

Applied to sunxi/clk-for-7.5 in sunxi, thanks!

[1/8] clk: sunxi-ng: de2: Fix Display Engine 3.3 definitions
      https://git.kernel.org/sunxi/linux/c/c6d21e8bb03e
[2/8] clk: sunxi-ng: de2: Export register regmap for DE33
      https://git.kernel.org/sunxi/linux/c/63a29fbb4ecd

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

