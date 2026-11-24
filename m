Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC9606A334
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QcNPhok0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5FB10F43D;
	Tue, 24 Nov 2026 10:16:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6050310F45A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:16:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AC63A623B7;
 Tue, 24 Nov 2026 10:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2822E1F000D1;
 Tue, 24 Nov 2026 10:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795515383;
 bh=hRTYbVxH7J+lJac8XhNn2sckvxgxZzpplzUO+1zmfn8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QcNPhok0qT5VzYisnbcJFE38ff+mpXBLbYjyhZH4Oha3KzQIxyW4pJxhl+MK5K6YT
 LDvPvFfVCSzJgSnt2croabeqyGgCxDZXKSBZdntD13+eSUqD4CJ315Z8a5D4myH1KX
 BDJX2bolnpjvZM3sKTL0zYsx2KY/6j6kaRVGvG62E5Ro1VrzGod2/1xC8XkFcPGtuP
 ayNRRW4VLND7yp6yICmxr73srUnlcHwJlAd7KLHF9TsPr4T+upqd9Ed16+4JnF1j7H
 lBTQfStGk9bM1Y3re6J4MSf6IBckzlA8G25ZufeshhOL9iN/tluD5/1/B7j1LZLf7X
 KFOOHUGBjyizQ==
Message-ID: <sashiko-outbox-230954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/13] drm/panel-simple: Fix
 powertip,ph800480t013-idf02 timings
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261124-tc358762-fixes-v6-13-bd38fed6460f@ideasonboard.com>
References: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
 <20261124-tc358762-fixes-v6-13-bd38fed6460f@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 10:16:22 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/panel-simple: missing Fixes trailer for
  powertip_ph800480t013_idf02_mode
--

commit d967fdfb642d04ae3d7d8cb2c114aaddead32d30
Author: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

> drm/panel-simple: Fix powertip,ph800480t013-idf02 timings
>
> The powertip,ph800480t013-idf02 panel was added to panel-simple, and
> with the tc358762 driver, enabled the use of RaspberryPi 7" DSI display.
>
> I have been testing the RaspberryPi 7" DSI display module with TI's
> BeagleY-AI, and I can't get a good image with the current panel timings.
>
> It's been quite difficult to figure out exactly what are the issues.
> Possibly RPi DSI TX and TI DSI TX have their own quirks which affect
> this also. However, now that the tc358762 driver has been fixed wrt. the
> signal timings it sends, this patch makes the panel work fine on
> BeagleY-AI.
>
> Fix the timings according to the datasheet:
>
> - hsw + hbp must equal to 46. This was correct in the timings, but the
>   hsw was very tight, and at least Cadence DSI has trouble with such
>   short hsync. Increase hsw to the middle of the hsw range from the
>   datasheet, and decrease hbp accordingly.
> - vsw + vbp must equal to 23. This was 24, resulting in slight shift in
>   the image.
> - The upstream timings seemed to aim for 50 fps, but this is a normal 60
>   fps panel, so adjust the timings to get 60 fps. As there's no strict
>   rule what numbers to pick here, I used the "typical" values from panel
>   datasheet for pclk, hfp and vfp. However, vfp of 23 instead of the
>   datasheet's 22 give us a closer match to 60 fps, so I used that.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[Severity: Low]
Since this fixes the display timings in powertip_ph800480t013_idf02_mode,
should this include:

  Fixes: d69de69f2be1 ("drm/panel: simple: Add Powertip PH800480T013 panel")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-tc358762-f=
ixes-v6-0-bd38fed6460f@ideasonboard.com?part=3D13
