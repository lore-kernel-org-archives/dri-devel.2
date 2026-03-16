Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61C0F013C4
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 169C510E30B;
	Mon, 16 Mar 2026 07:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pk6mJv2V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 751BC10E30B
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 07:43:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C741600CB;
 Mon, 16 Mar 2026 07:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC32C19421;
 Mon, 16 Mar 2026 07:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773647029;
 bh=fjF5nSUgO5mXuV+61RA/Pt5kKV9oNBnb3Ixg69mjzf4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pk6mJv2V01hlV5iUWtqxex4dcaX3ZlgNb3XbKbZtAoiRLk8lSdx7w95yuQeLCJ/3+
 wUdtP4xgcAEYJtL0ahTEv5lNP1neJp8wSpyGRQvhOTJJ7lnSJ8mKywAFcpEcH9/N1+
 D8uh6GD4hiKWhPZ0KHZ7MpLmSHa31IqLIu03h7GB1BjUWTeqlaEaryZvTwiROg28Bf
 UiPeI+nOD/lLl0G9drxBQB8qPm7mDamL9v6eJdFpgl8kHmmiSR059DsMFOuRaUitW/
 8DqxlWaBIdG4Dk4aHI76AguhGoSiHf8DCvujCvyzWkVSV0xn76yZoiMRMGywUiyVPP
 5PNlfHTfnXBqQ==
Date: Mon, 16 Mar 2026 08:43:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drm/panel: Add Himax HX83121A panel driver
Message-ID: <20260316-accomplished-cicada-of-contentment-1cbcc6@quoll>
References: <20260315144536.515032-1-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260315144536.515032-1-mitltlatltl@gmail.com>
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

On Sun, Mar 15, 2026 at 10:45:34PM +0800, Pengyu Luo wrote:
> Add a driver for panels using the Himax HX83121A Display Driver IC,
> including support for the BOE/CSOT PPC357DB1-4, found in HUAWEI
> Matebook E Go series (Gaokun2/3).
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
> base-commit: d517cb8cea012f43b069617fc8179b45404f8018
> ---
> Changes in v3:
> - remove '|' from description (Krzysztof)
> - drop description for reset-gpios (Krzysztof)

You made multuple other changes effectively breaking your binding, so it
does not even pass tests.

Best regards,
Krzysztof

