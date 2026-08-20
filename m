Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B078EC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 07:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233CC10E15C;
	Thu, 20 Aug 2026 07:24:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="nCsclQCS";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="h6OFz9jm";
	dkim-atps=neutral
Received: from flow-a3-smtp.messagingengine.com
 (flow-a3-smtp.messagingengine.com [103.168.172.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2E210E15C
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 07:24:51 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id 30DA11380197;
 Thu, 20 Aug 2026 03:24:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 20 Aug 2026 03:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1787210691; x=
 1787214291; bh=iAf1ACnM1ncQUFOBFpR9E5JElTy7xf+f9PkOTb2pGGk=; b=n
 CsclQCSj/QO1bJOH5evD9Hb9c4H2BnHGWIlkWLDCfvSKcphKIdMuHxeb8VDN53/P
 iVsI07okdas4HEV8CtpGeTpMRaB9z/AnQ2FMRDUmAu7Wrd5kqR1sIzlYOk3hOmis
 rhbq8eZf+urp3e/Q9Ef9+vWJQYwcmB7JxrHMUBhawEuHWyUO4GocCkpHn62p03Ms
 FfNZT/8UBGrUxAtc1em5zUzPc0W6nZsTFwmXggqL9cLMpSUlc0aOBhLEBkXJ0BtI
 BoaojUa1AHj23lD6PeS1PuQl2+BLY0GYq5PcESLeIgQEwAkNpAZJUKJDuzTGG6Nx
 8INYym9hyXcf/zkANbDGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1787210691; x=1787214291; bh=i
 Af1ACnM1ncQUFOBFpR9E5JElTy7xf+f9PkOTb2pGGk=; b=h6OFz9jm8dVYdKzuQ
 0/6esg16MX5TUXCxzfNuj4xBQW10ZC0mzW8BZOL+90GaTpAq4z/AvJ7Zgzgr+bMZ
 oQfftL2t76rGeavTQgJ7DYVYPwkVD/YVHOmzzedTcyKbUTT9aoQeItFkCp+xjjQT
 kIyNQdoQgkakW6fvOORYXDLE6ZzmH7klwDxPltmGHt3C4TPFuQwCgKJCIXCyguUn
 t+/eeUfx8L1GMBbSiN9wwRDg7O5IKM191fwVSxJONeU5yU3SSc3SwUYHEV3vAd8C
 aDS/eAAgxA+S+mZE9Bvv9VcgBHjFaPLp2uaku/ZWVTi76qafrwp44IvTBf9z1jmw
 4hXtQ==
X-ME-Sender: <xms:wquGaqiVjiY7v9VO0vawKFZGQ3akKJT5luHTqRNPlWY1iIRIDtBHmw>
 <xme:wquGajO5fO4n2QJvQ8RsXBR6nG8ddSkeObIIKwEzzngza2IKbEcaKhy12mlQZJcS-
 AD7aIi7prvxQe37pecEg9brGe2wusTQDJkpHTeq0RUUj69YWk1OQ5h1>
X-ME-Received: <xmr:wquGatpu_RdzNeuzon9K_ZNGi9KrVAdsbreaG5XRdKRUT_CWRL0QDAtVvofo6YNS4Og1vRBSnQ>
X-ME-Proxy-Cause: dmFkZTGY0AHF/D0zqb7XoROdgVLZ/Hmr/VvGjkt4gtfadBqSwDDs/Mz7eEdmFVtLhFE5Dt
 MS6J9ZEJes4QLVwohUaTaz8iIpSzG+1WuQ0LVS5td2D/B6lqFnAMMrrzTtuVO2sKXghVO9
 NJjxQYxDBjaENyEGi7hQR+UgUzkdNmldzu9pEJ6wTicaIwGMpXbdJ59KDJV9djftyoLdnr
 sNaZKJkaEXBBAnfktlNY2H6qRdBV/Cwc2AP4RQZl/aDbP/6HQqJhaCv9omJ/POXEmsLefM
 FAMTpA3ftdCZ10lSdDmyJa25kNKwQEr+w+7/AfyhCYcnlVHdbu+Vt0FydwGISwfkaA/tMr
 MCWeetluMqCQ+6tc4OmkFVrHHrk8Guw0V1a942bJpg+o25Nw42bPvW/bV4P1QgK86IGLbj
 Tx1uJ1mdPRu1NA3lXF2xEQ6guxHDMkLb/dhW1hm6yW2uiLviGP4ki6HhVTAfMhPTSeo6T1
 Xzw4t31NLyzOgX1pwPwDE03L1oSvUz4v+G1TDe2M1nMYcirf1haYM+OojfKtzJ7sh2WQgR
 dpCvRuwH9NgI2O9/Rr2ylKU76wgMfnJxSQXeM5EHbq4tf6lDgrXrY9/JT6YuI5Yl2Mr5mv
 X7/UQKXTEMQapT1vbBPeV/U9W05m0KHpcxiDLiwwKX0/oxJfWupNgIsgQ/Bw
X-ME-Proxy: <xmx:wquGat6U8If98Y5wE6CsotmS9vALdlPpxXSjWDFYCHJzZfTnOEDccQ>
 <xmx:wquGajgaJb9AgTdQ5cKO5kgvJNT2SmwBN_oGvoFgt-m1oyISL9drHw>
 <xmx:wquGar5M32pqMhSEziBwD03Pt2CCQIIk-5Ak62XBgNDUIUJRK7e5EQ>
 <xmx:wquGagF8-XK2Ia86ZK5eo8mu1vYOapPjK2JW9HX1XHhM2LZ04rWCGQ>
 <xmx:w6uGapELifY1Xqgh4iXrm7QRojJ-XLt5fsDZurMuL4x-W5DJVqb-Xbva>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 03:24:47 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: u.kleine-koenig@baylibre.com
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, royalnet026@gmail.com,
 chaoyi.chen@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 10/12] accel/rocket: add RK3576 NPU (RKNN) support
Date: Thu, 20 Aug 2026 22:16:29 +1200
Message-ID: <20260820101629.752877-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aoQdns-GHS3fg5BJ@monoceros>
References: <aoQdns-GHS3fg5BJ@monoceros>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Uwe,

This changes in v9, thank you. rocket_drv.h will include <linux/device-id/of.h>
instead, and nothing in the driver needed anything else out of
mod_devicetable.h.

I had not looked at what that header drags in. Checked after your mail, and on
this build the narrow one is all the file needs for struct of_device_id, so
dropping to it costs nothing here.

v9 is not posted yet, so please read that as what it will contain and not as
done. I am holding it so v8 can collect more review rather than reset the
thread. I said on v7 that I would put things this way round, after telling a
reviewer something was fixed and then sending the next version without it.

Regards,
Jiaxing
