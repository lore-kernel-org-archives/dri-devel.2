Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A106F532C0
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 00:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A6E10E57F;
	Tue, 24 Mar 2026 00:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XiBE9ov2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE40510E57F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 00:23:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5C8F5440D0;
 Tue, 24 Mar 2026 00:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AD0C4CEF7;
 Tue, 24 Mar 2026 00:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774311787;
 bh=SC2ww4mJ1qgAoxcGEzXEXyqlY9RVISGD9yN/EftWNec=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=XiBE9ov29yNU6/5B0AfnbLcDPQksTDNLH5ePaqtdeaf9acTNUq4HJtSOjqowCOO9k
 Vjvg1LuO+quqYVXrHvBmEDeG/dxOt3DzDCpdWgDxIaMFXfyerCoVCRiwL3vPRmXt39
 09a1ddyF9GLZXIgCkhiSOXw1//FPNpfnob68SQ/SNSSeJ71K54zKrRUGwVb5Kz2mFS
 AtJoboE6Gc8wyo2e1pIypreefHYD7wEwSuJhvTEVugzS2/hMm9DYGxkGS2GPdCXfij
 /LkFnsqVVA+ZrqRoDf2T8TYQphhKH7mbuTORDbQ1HjQWWq8rwbdgub4mDiSjml1NUY
 3D5qgLTHeVCnw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260312-v3d-power-management-v7-1-9f006a1d4c55@igalia.com>
References: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
 <20260312-v3d-power-management-v7-1-9f006a1d4c55@igalia.com>
Subject: Re: [PATCH v7 1/5] clk: bcm: rpi: Manage clock rate in
 prepare/unprepare callbacks
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 kernel-dev@igalia.com, =?utf-8?q?Ma=C3=ADra?= Canal <mcanal@igalia.com>
To: Chema Casanova <jmcasanova@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Iago Toral Quiroga <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 =?utf-8?q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Michael Turquette <mturquette@baylibre.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Stefan Wahren <wahrenst@gmx.net>
Date: Mon, 23 Mar 2026 17:23:04 -0700
Message-ID: <177431178481.5403.10860855444629990495@lazor>
User-Agent: alot/0.12
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

Quoting Ma=C3=ADra Canal (2026-03-12 14:34:23)
> On current firmware versions, RPI_FIRMWARE_SET_CLOCK_STATE doesn't
> actually power off the clock. To achieve meaningful power savings, the
> clock rate must be set to the minimum before disabling. This might be
> fixed in future firmware releases.
>=20
> Rather than pushing rate management to clock consumers, handle it
> directly in the clock framework's prepare/unprepare callbacks. In
> unprepare, set the rate to the minimum before disabling the clock.
> In prepare, for clocks marked with `maximize` (currently v3d),
> restore the rate to the maximum after enabling.
>=20
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
