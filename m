Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4F2103A9A1
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 900CE10E6B1;
	Wed, 25 Mar 2026 02:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ght6Y8kO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4158F10E6B1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:49:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6AD1D6013C;
 Wed, 25 Mar 2026 02:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB5BC2BCB5;
 Wed, 25 Mar 2026 02:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774406947;
 bh=AMlrKIWE1KM4Yad6QSZWMlcL+MvR+08LGf01fWoQDYo=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=ght6Y8kOUfC/XhylkChbjn7EyL/6UF0fwadCVcpSo6Xcef8SICFwJAqK1saq9sW5b
 ux6z2CK2Zf+D+p4sKBbjxw5EbTTJyzIM4bIwDM8KlPA9vm0DZvqIZW5pl1GiLlNs/I
 gc5JPQkPBQ40hCBnszgS0CcZU6kPGgEmX3SViBFKgyLrCeSSe+ZfnNVMW+Tscj9MGu
 T1XOr1rUWH3Tiwolds7eWcK//AB927onwFMlxI9SrvuPW4as18ihlbo3DyR+efGzT3
 l9uEUzasvSHRXRvvCJUxoKRePILko/TU5ZsVE3oyMRw1Or2dPAQYIkGV6BkdWowB19
 N+uUfYVLjkNdA==
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
Date: Tue, 24 Mar 2026 19:06:48 -0700
Message-ID: <177440440896.5403.6955660705156176314@localhost.localdomain>
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

Applied to clk-next
