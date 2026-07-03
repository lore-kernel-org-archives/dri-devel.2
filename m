Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061DBC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA4310F6BC;
	Fri,  3 Jul 2026 08:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IWoGWMat";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987C310F6BC
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:01:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4493F440CB;
 Fri,  3 Jul 2026 08:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54A01F00A3F;
 Fri,  3 Jul 2026 08:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783065715;
 bh=tHSR40BSJEjXogpbgoRNtUmX9ocgOZObmswLHfCZhCU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IWoGWMatctxsGF7rx3pcK3h70bTxMvKI4xxdFq2pZl2iEmeX4Lb6ciDsWkRQqh+qc
 uiGJjJGa4Hxfkx9vfzqNx8vWkpdSG00Ijk4ygHeJdDgOLnukNYBvNskJq9cfMH7484
 zar9xU+ypVOy0uqu/A7z+VldSXyTdb2WM7csWVwu8vqkSKGd1qY0BBsj7RI1Yg3S3N
 38+vIeglQjWQ16eAPq1n0IQzKHV4el5ecFmJXl/QzQp13UGy4yN++Zm0NuofGj3i6j
 gAxTEI9qBiU4xZKDtpaGKaD0I9k5nel+PXWphEvN87I3xFPxp6tWOa71gnlKw1PK9G
 6UtNPiJAGUQhw==
Date: Fri, 3 Jul 2026 09:01:49 +0100
From: Lee Jones <lee@kernel.org>
To: Junjie Cao <junjie.cao@linux.dev>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 caojunjie650@gmail.com
Subject: Re: [PATCH] MAINTAINERS: update my email address for the AW99706
 backlight driver
Message-ID: <20260703080149.GF2108533@google.com>
References: <20260701133533.32585-1-junjie.cao@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701133533.32585-1-junjie.cao@linux.dev>
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

On Wed, 01 Jul 2026, Junjie Cao wrote:

> Switch my maintainer entry for the Awinic AW99706 WLED backlight
> driver from my personal Gmail address to junjie.cao@linux.dev.
> 
> Update both MAINTAINERS and the device-tree binding maintainers field.
> 
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
> ---
>  .../devicetree/bindings/leds/backlight/awinic,aw99706.yaml      | 2 +-
>  MAINTAINERS                                                     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Doesn't apply.  Please rebase onto -next or for-leds-next.

-- 
Lee Jones
