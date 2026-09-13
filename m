Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03573C88E6B
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D5D310E9E9;
	Sun, 13 Sep 2026 20:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lucidmail.xyz header.i=@lucidmail.xyz header.b="eEvel8x6";
	dkim-atps=neutral
Received: from mail.lucidmail.xyz (mail.lucidmail.xyz [78.46.175.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B156610E083
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 00:09:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 937CC177C8E; Sun, 13 Sep 2026 02:09:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucidmail.xyz;
 s=dkim; t=1789258152; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=g1SJpuk9beZ2StLFbVA4VBFQ5UeY6DCQDVvTcvW/XAw=;
 b=eEvel8x6NYBU4Jh1KYPluCW21VwrWK0dnDz2mxyUDQWRRgboBbSkIb/D4Vu+qXzWRqqXyY
 0ctUqNjm9EkIR2llyHby3fwYeVJ3ImJcIx83kI4KyUJNiisVLW2b5kb5RrBPbnv4g/hiE2
 nb9dEkdiu6GIprqZbz9RHGld8o7sWd0/QY7YJz7U/OmWAthqqU5Ym0e6Xj+DRQA9tG8SKD
 JdT51q3uzTS8DLqVRTXL2tkWTXu34VYTbxW0Cdo4pKE2TBsrg57GypdOecOrXc3CohXu9X
 CzkrbBUTFzASkVaQ+QYvA++7C9ScHPK/7m0fnH5j0HoHZkEQlPyeNbmt040SUQ==
From: leow149 <leow149@lucidmail.xyz>
To: andre.przywara@arm.com
Cc: leow149 <leow149@lucidmail.xyz>, dri-devel@lists.freedesktop.org,
 linux-sunxi@lists.linux.dev, wens@kernel.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, mripard@kernel.org, paulk@sys-base.io,
 parthiban@linumiz.com
Subject: Re: [RFC PATCH v7] arm64: allwinner: add TrimUI Smart Pro (A133)
 board support
Date: Sun, 13 Sep 2026 02:08:31 +0200
Message-ID: <20260913000831.111980-1-leow149@lucidmail.xyz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913013955.0fbc4acd@ryzen.lan>
References: <20260912222429.107809-1-leow149@lucidmail.xyz>
 <20260912230131.109229-1-leow149@lucidmail.xyz>
 <20260913013955.0fbc4acd@ryzen.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

Hi Andre,

Fair enough on both counts. I'll slow down and stop reposting every time
sashiko replies, and I'll split this into a real series instead of one
RFC blob.

On the overlap: found it, it's Parthiban Nallathambi's "Add support for
A100/A133 display" series from dri-devel back in Dec 2024
(20241227-a133-display-support-v1-0-13b52f71fb14@linumiz.com). Looks like
you already reviewed a couple of patches in it. It adds
allwinner,sun50i-a100-de2-mixer-0, allwinner,sun50i-a100-tcon-top and
allwinner,sun50i-a100-display-engine, which is the same DE2 mixer and
TCON-TOP hardware my board's DSI path goes through.

Compared my mixer0 config against his sun50i_a100_mixer0_cfg field by
field. Everything matched except mod_rate: mine was 297000000, his was
300000000. Mine was wrong, just copy-pasted from the existing A64 config
and never actually rechecked for A133. My own register dump off real
hardware reads 300MHz for both de0 and de1, so his number was right and
I've fixed mine to match. So that was a useful find, thanks for the push
to go look.

That series hasn't moved since Dec 2024 though, no v2 anywhere I could
find and it's not in mainline, so I don't want to build directly on top
of it. For now I've kept my own a133 compatibles, just with the numbers
fixed and a comment pointing at his series for anyone else who runs into
the same thing.

You mentioned on that series that you'd rather see a fallback to an
existing compatible than a new one unless there's a proven reason not to.
Given his stuff isn't merged, what do you want me to do here - keep my
own a133 compatibles as-is, try to get his series revived and build on
that instead, or something else?

Cc'ing Parthiban so he knows there's a second board sitting on the same
hardware.

leow149
