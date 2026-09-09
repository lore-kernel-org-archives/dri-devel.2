Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045D8C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4688E10E1DB;
	Wed,  9 Sep 2026 20:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TLPP84Yu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C3210E1DB
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 20:22:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EDAFB600CB;
 Wed,  9 Sep 2026 20:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A45C1F000FF;
 Wed,  9 Sep 2026 20:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788985327;
 bh=f/vJPlc8T6fJJB4nW5dL7YWbom6WiGDZ7/U7PJNU6os=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=TLPP84YufN1whr58C8OJQj//nWquWekWtxF/1nO+DqVq6jZ53jv1Nd3U3EKan3kYw
 sCwTxwwNrvvTyjjcMp/HESKcXwI47hhDyYDWeDoSYHSAoxR6nSdMe7NQR9OpUHGukC
 4siCRGAksSIkHpdePBeTKpGQilHStBLbSlDbUcjxQHjKkB7wULUzp6eo1W1H2u8NDG
 8RfK+x9aw9vuKTjIi5qXR1SKT4Mvy19glMGFj+KhI0Xxe5rgSNQLvisIqtel8E08RA
 g/qmCQORapsfi00DlUodn+GVeS6Q3+W2HHzbXoWXhr9xo01/k0FJW2dpnOzsbxthNu
 o/z1slXURvOlg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailfauth.ams.internal (Postfix) with ESMTP id 1B2F1198003A;
 Wed,  9 Sep 2026 16:22:05 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
 by ams-compute-02.internal (MEProxy); Wed, 09 Sep 2026 16:22:05 -0400
X-ME-Sender: <xms:6r-handXz_o_C5DukWnEOfr4NLQn7c61KNre1FdUV0-TlZfBGhG9lg>
 <xme:6r-haoD7H8K6PlEE6wyLuwHbjFmQRgdO0R46IZOUCp-UUXMp3R6i54OrAxl_lriYU
 nbdfiLWg8PbYTmaQkiy9miT2q5r227w8ICANPKka4bFXNziY8boCOU>
X-ME-Proxy-Cause: dmFkZTGOPtYz0YGef1KbspNp4wTPdGdk1T/H9qyyC2M/T06oJAVCV4BqA2OF/poQX871Yt
 rk5p+hkaLTG4dMeFglwUkLNSxt+mUz9o0Ng0nlkD8CaDrF03PFrN572A1KJi6IpaQ3K5Cc
 kJ0QAMtHkUz73asFAT0vYmeWZI2AMRi+55uTCOzPNIbdUShXXNPe4zAwxvl2Hiw7KHTC7u
 vtBXDEs+zLHFPqZcnLz5Poo7kKx8eGHXSq0NkOHrzIbr6S4NbNMRIReJL5e4gCF9DM8OMC
 CuTPI4Kc8oiHl9F/Aklk2oddw6LJOSIz0J5VUwKZSs97CZQi/t5ENn2m6o/PCUdSEHvxtz
 b7KyWErK9fVop7OSL4coHmMjTr74TaqnqmYzGPdYEFfxDsZUbp/IR3O2OG3Y8+sXufCn3y
 qfxMEZOLhvcmGBegrfv7nuTItkaVdX66Knrypo7JQMGtRu52GQqSeRlfpV94wEKTBY3KNd
 xMeHtPdnwe58UkfH08GxhAlK6wo3jcPQlYGROQ0tRIx8KS7yLfeI9jOT6zeUUSK2D3Tysb
 ujIyyY5iJjmRIBU+G0/rqFUmu2bg/gBZG0QwYkQQHaPKxB4RllUroB6kWU+MMdInTGIRbN
 DLpdo2cCfbeQNA1vDTWyYRuKEtShuQ+Xt16kOmEyxXfDdv/0zAARwxXguaFw
X-ME-Proxy: <xmx:7b-hao98DweUafzIKUW1PqUMQJbMtYex6kRnS13CmfzvX6-bBx0wuQ>
 <xmx:7b-hatBM1m69H0ALdWWObIttuSMLllpPTiPC18GS4B8qhD_QamccWw>
 <xmx:7b-havo296ND2cVaHy9kOISLZieXsWZW_5kNv1o9iRXIT_Dtt9hx_g>
 <xmx:7b-halnDY6-h-CEgypR5Y3zZ6iS1CZqy2MQRzxMVsJFkLs6rvQsLKA>
 <xmx:7b-haiW_6VXvtdc_Xg46AkkjNR10hmYi6kiNEVBYFEmgGPZsy8vCJQ0R>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id 7CDA632A007B; Wed,  9 Sep 2026 16:22:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AmJ_Nx877FLk
Date: Wed, 09 Sep 2026 22:21:19 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: mfd@lists.linux.dev, linux-hwmon@vger.kernel.org, media-ci@linuxtv.org,
 "Rob Herring" <robh@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 linux-leds@vger.kernel.org,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 devicetree@vger.kernel.org, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-watchdog@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-input@vger.kernel.org,
 "Lee Jones" <lee@kernel.org>
Message-Id: <ef6f3053-3455-449e-9e25-f35ebef63598@app.fastmail.com>
In-Reply-To: <20260909133709.139231F00A3A@smtp.kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-6-arnd@kernel.org>
 <20260909133709.139231F00A3A@smtp.kernel.org>
Subject: Re: [PATCH 05/14] mfd: remove unused adp5520 driver
Content-Type: text/plain
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

On Wed, Sep 9, 2026, at 15:37, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Should the corresponding block for the _dim attributes also be removed?
>
> Further down in this file, under the documentation for the _dim attributes,
> there is another block describing the sysfs nodes for the ADP5520 driver:
>
> 		For ADP5520 and ADP5501, <ambient light zone> can be:
>
> 		===========  ================================================
> 		Ambient      sysfs entry
> 		light zone
> 		===========  ================================================
> 		daylight     /sys/class/backlight/<backlight>/daylight_dim
> 		office       /sys/class/backlight/<backlight>/office_dim
> 		dark         /sys/class/backlight/<backlight>/dark_dim
> 		===========  ================================================
>
> Leaving this block behind orphans the documentation for hardware that is no
> longer supported.

Fixed now.

       Arnd
