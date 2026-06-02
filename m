Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE83CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F07D10F15A;
	Tue,  2 Jun 2026 13:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lEJI2xOF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA7010F15A
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 13:49:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D669C6008A;
 Tue,  2 Jun 2026 13:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDAC1F00893;
 Tue,  2 Jun 2026 13:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780408189;
 bh=nh6orATTER2LQH2juaJU4rl+QXg92RNv3CyQNlwKgn4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lEJI2xOFqnRLERO0ZNuHUIYwJdVwH4ta5GeKsFF/KGRoqlfx1++HpzfKt3943x7La
 4M6EpxKIbvVnno7qCZCfmPK2G4dr3IrnyJ0M8HLwam3nKmSDSKGvXeO5l2ehjCk8fa
 r3sJcldIWcfMsunLNyb4/rPmQCFmBO3Cz+STMIXWzuMrHbOfDlg9+6REQT7yHijXpA
 84YdOWoDOWzpyxHoHzFqfpZQ2mumgjpBlRlaZQWjdOBJJQaKVgJzArS7JZn+5TZLfA
 1rMFjj7QAt5/Gt41bxHIUUEoZEt94Ggf8DdYzXLdjLHocRzYev9+tIc0XTTodAAOls
 dfOuWDXGhWssg==
Date: Tue, 2 Jun 2026 14:49:43 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 05/11] mfd: lm3533: Convert to use OF bindings
Message-ID: <ah7fd6hEtcTb5URS@aspen.lan>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-6-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601151831.76350-6-clamor95@gmail.com>
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

On Mon, Jun 01, 2026 at 06:18:25PM +0300, Svyatoslav Ryhel wrote:
> Since there are no users of this driver via platform data, remove the
> platform data support and switch to using Device Tree bindings.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for backlight


Daniel.
