Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A640C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E682510F4B7;
	Thu,  2 Jul 2026 15:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lbQiMxaz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E27310F4AA
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:51:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21A8B40D56;
 Thu,  2 Jul 2026 15:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B85E1F000E9;
 Thu,  2 Jul 2026 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783007480;
 bh=BGqmxq2YKT75uEs34RuTcEtmv5NEzmCyZjVvAGYL7sM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lbQiMxazOvEStfHXVX0RjB3/hJKvru6uz9ayl7ooWC2epwOMrmzYgYomx0eAutIxg
 DwQfKgeanczazH2uMcqToe3XjLOrFmJiNhxXNgxYF6QNZ7Dm9QX2rijDs5SSoaiqEZ
 /9eAebNo3WyB3yVWYUIPQ8emltYcsNF7CX6bouJdAxKx1PHvrVV0BtypAkRd2kbrDd
 m3/sqru0IOMReNgOYhZrsJ4Bj8S3wwb0qZoV4aLcjnqI7VHl5TG5wHdpv66Xpo9Hxn
 VpxSQGZFG78BtfAoMO+DMCdb44fzvdX/Zi4foFSXARqbnhKZWpacXweROcSGcNqLjR
 pg5CKFCztwlKQ==
Date: Thu, 2 Jul 2026 16:51:13 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/11] regulator: db8500-prcmu: Remove EPOD regulators
Message-ID: <20260702155113.GW2108533@google.com>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
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

On Thu, 18 Jun 2026, Linus Walleij wrote:

> Remove the obsolete DB8500 PRCMU regulator drivers.
> 
> Drop the regulator build hooks now that EPODs are power domains.
> 
> Keep the MFD cell around because a later patch reuses it for a
> small compatibility regulator driver.
> 
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/mfd/db8500-prcmu.c             | 239 +---------------
>  drivers/regulator/Kconfig              |  12 -
>  drivers/regulator/Makefile             |   2 -
>  drivers/regulator/db8500-prcmu.c       | 501 ---------------------------------
>  drivers/regulator/dbx500-prcmu.c       | 155 ----------
>  drivers/regulator/dbx500-prcmu.h       |  55 ----
>  include/linux/regulator/db8500-prcmu.h |  38 ---
>  7 files changed, 1 insertion(+), 1001 deletions(-)

Any deps?

-- 
Lee Jones
