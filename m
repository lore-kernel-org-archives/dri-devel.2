Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD94BF46458
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 12:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E2010E505;
	Mon, 16 Mar 2026 12:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HrIPuqZY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E7810E505
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 12:16:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C4E5860008;
 Mon, 16 Mar 2026 12:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2F9C19421;
 Mon, 16 Mar 2026 12:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773663367;
 bh=SrpGwU7qrBLflsSEF7JnYoUZan3t/CY9j9+fProo7sk=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
 b=HrIPuqZYfyTJ3andYiQHAdrtH8kzZiFG88qcY+ELNkubu62Llcr9ZVZFNtt8v0qcq
 RdlmnW5kd13VgRJROzamTV4kVbEOpBIN+ie8hG23WgnPFaq2M2pEySYvGTIDGFajnv
 BISB0DucckMfUh2TwOndhUCxeX7Wf3kFg019VZh0n/11vzhJQGPdpt0KAmiM1cDOwA
 BrclieRQpNlS4YqrCF0pnU+kIy73105BFaog7ON9k+sQc0U0Hb5YJMCaQ5d7Fcmtdt
 1G4Tf2gFbEIRrnK2lLUQxC9gqZGisd9Cy1tZbo0b0+WdIy72WidvN/EsnZvU8Zp09H
 OSkKh82p8nEOw==
Message-ID: <86d314a03d1597390adb850789501cb9@kernel.org>
Date: Mon, 16 Mar 2026 12:16:04 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Subject: Re: [PATCH v7 1/5] clk: bcm: rpi: Manage clock rate in
 prepare/unprepare callbacks
In-Reply-To: <20260312-v3d-power-management-v7-1-9f006a1d4c55@igalia.com>
References: <20260312-v3d-power-management-v7-1-9f006a1d4c55@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, "Broadcom
 internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>, "Chema
 Casanova" <jmcasanova@igalia.com>,
 "Dave Stevenson" <dave.stevenson@raspberrypi.com>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>,
 "Iago Toral Quiroga" <itoral@igalia.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Melissa Wen" <mwen@igalia.com>, "Michael
 Turquette" <mturquette@baylibre.com>,
 "Nicolas Saenz Julienne" <nsaenz@kernel.org>, "Philipp
 Zabel" <p.zabel@pengutronix.de>, "Stefan Wahren" <wahrenst@gmx.net>, "Stephen
 Boyd" <sboyd@kernel.org>
Content-Transfer-Encoding: quoted-printable
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

On Thu, 12 Mar 2026 18:34:23 -0300, Ma=C3=ADra Canal wrote:
> On current firmware versions, RPI_FIRMWARE_SET_CLOCK_STATE doesn't
> actually power off the clock. To achieve meaningful power savings, the
> clock rate must be set to the minimum before disabling. This might be
> fixed in future firmware releases.
>=20
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
