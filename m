Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD965C5CFC1
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 01:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA0610E10C;
	Sat, 15 Aug 2026 01:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l3viutBT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8609410E10C
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 01:52:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3587740420;
 Sat, 15 Aug 2026 01:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB381F000E9;
 Sat, 15 Aug 2026 01:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786758739;
 bh=3O3WrexwJC1IwCK2ZQDYE1WLv4B9LI47oY9B0YdvWyw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=l3viutBTGOxBM9hejZ+sNjtf+k6yxO8Rgs62sbYI9MiafqaaJi4UngmHLUwnBvLeQ
 mm/s39JBkjFwpDpXd/GSvSmH1ioyJYqHUMWy1AFlC4Gzo2lupvCGEZR84M/us8RZV6
 Pf5n0SQrIh94ga8Pf6pg4To/dh31u51GVTS09AfBW+J831NjjTBCWqFITw5tsHmzsD
 MjO0Zvmb2T8qJOnHUSAEyFyWRHXYZhCGGeNLntKYrl/E+EGZcBawsVjFa6H3QezZUe
 Oy8CdZRrXiRZXe+P/ndfqXf2y2YmIxZP3eN+V7WWDxtEWrEKvxf0Eb9NbTOQp4TTeX
 nEsXrtmZY/nBg==
Date: Sat, 15 Aug 2026 02:52:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
Message-ID: <20260815025203.2618cf8f@jic23-huawei>
In-Reply-To: <20260731113632.158440-5-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
 <20260731113632.158440-5-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 31 Jul 2026 14:36:22 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Instead of passing the entire lm3533 core data structure, only pass the
> regmap and the light sensor presence flag to child devices.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> #for-iio
(I didn't read the rest on this one)
