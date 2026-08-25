Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F660C5DF9C
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 00:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB2210E189;
	Tue, 25 Aug 2026 00:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="du+f6jXU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA5B310E189
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 00:36:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D7F16011F;
 Tue, 25 Aug 2026 00:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914DC1F000E9;
 Tue, 25 Aug 2026 00:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787618203;
 bh=Ab1UodHqZ0psLkPHCdL1OHmoVYc553o8DprxmCFPjIM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=du+f6jXUdQG6lbmi9rUqAwNBEn93JpEo+J78Nrmhi+NekoRRV2o2o3NCV5BuD47oF
 6pz2/z77qdb2q5duCsWSMK79pm8V+VrPQxl50FIv6Ya3/X+KqWlt1z7wTvTkEJ10uu
 1rfqQQ2HR3usiQWOH2eMB4uDWNL//zyp0CFjhoJyw1v7JdQo/xkqi2uMzA8YwckP3l
 aXU8naTTAUusmf5cfATQz1iCnZSzyEeKAEcsUlPoD08KGOcwk/GE+n+LjtBg+cGvav
 BgECvw08tMGh4THaI2LcFm3Vomj7tiaq5U7x3b5cHr7J8UmgBSg+qUB9+fOs/WIquX
 sXPLhOXJSZoHg==
Date: Mon, 24 Aug 2026 19:36:39 -0500
From: Rob Herring <robh@kernel.org>
To: Tomeu Vizoso <tomeu.vizoso@gmail.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@nxp.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel: ethosu: Don't read the U65 rounding mode as a
 storage mode
Message-ID: <20260825003639.GE50486-robh@kernel.org>
References: <20260824152612.751007-1-tomeu@tomeuvizoso.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824152612.751007-1-tomeu@tomeuvizoso.net>
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

On Mon, Aug 24, 2026 at 05:26:11PM +0200, Tomeu Vizoso wrote:
> Bits 15:14 of NPU_SET_{IFM,OFM}_PRECISION select the activation storage
> mode on U85 only. On U65 the same field holds the rounding mode, and the
> command stream parser has read it as a storage mode since the driver was
> added.
> 
> That went unnoticed while unknown values fell through the switch, but
> now that they are rejected, every U65 command stream that asks for
> natural rounding (2) fails CMDSTREAM_BO_CREATE with -EINVAL. Mesa emits
> it for average pooling, concatenation, split, unpack, strided slice, LUT
> and argmax, which is 72 failures of the Teflon test suite on an i.MX93.
> Truncating rounding (1) is misread as well: it picks the two-tile
> address path and computes a bogus feature map size from tile bases the
> command stream never set.
> 
> Read the field as a storage mode only on the hardware where it is one.
> 
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Fixes: 6b7e0066294d ("accel: ethosu: Handle U85 internal chaining buffer")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> ---
>  drivers/accel/ethosu/ethosu_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

I guess I failed to update the i.MX93 kernel with my fix. Sorry about 
that.

Rob
