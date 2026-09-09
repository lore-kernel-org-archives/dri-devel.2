Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1ED6C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0320210F12E;
	Wed,  9 Sep 2026 12:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pR9u8nLK";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71BFE10F12E
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 12:48:26 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485843116d2so477529f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788958105; x=1789562905; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ktTcKvzi+Dmn6xaiXbKoHfLb8FntlzV6x0/ox6k4ynw=;
 b=pR9u8nLKe4BuwVTFCCpOCUkY2Yu9wF+BtbT4neQppG/8le/AjsIziqTEcklFZElp+1
 rAC/PSS2aaADc7bd10mmvztztwQGN40rT2ttZwrLS65SIk2c5MkrhKT1ZSXdQ5ANPLRh
 q/hYmPrqLHFVQLUa7ShEEXb6loT0RZZBUykRK6lxCLb6n32a/T5wSdPDPlW5IJEr//fp
 leHb9/NTT3ZqfZHAewCi5fMHHJFwJGiHcL444uAvWRZORpb7V4z66fTCywDeakvsr4N8
 lQ4pEs2Cvo81UcSMy2E8Y2mQNRKtemJaxvcyuupUvI21Zdv4wX5yuAOklPd02aCmj5go
 Glug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788958105; x=1789562905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ktTcKvzi+Dmn6xaiXbKoHfLb8FntlzV6x0/ox6k4ynw=;
 b=O44SM0NbpIrbPGmoJ5nS6FyGHyTBkJXBaBVTC49uBtOh/AF+rgSsOw0BHe2IB4YTma
 jGKsCHFk6qeKBvGJklBrljVlepJTKRJGv/aHSCEbhw47vbz1cyLi8pKyWgSJ7bQ0zfTx
 LC+/njZdcmI1EJqFNht+GXCrhAZo13p0EAVbJjWM+wMNunD++ld4lh22xUhq+tTHeNk2
 VluhilS4kyhF+uldYkWGieas9aFcFZqmCfIEIYl2AoOiYTVzQ1X+TB7MzrFOcClQR2dz
 q09T0HqRblFw+gL+OyKgtzIK2Vh88ssvXNeSZmY6lhKygiIuBIspbZdoDC4FvSx5UFRv
 EA5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCNsc+Tr0wh3ag6X71YsUPyQTXUIzp77+/w6rhik9zx8XWvldrva/q5AykjhxufysFpKTJ6GZY2y8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lzJN4B9xxghD4VS254nm6iMgN4Jp3KJ18cL6cDqBy117uLwYI6
 wcUVDMPOcT0qj/ODkUTjgyp3hPV1Jj/ydUKTcBx7GAJnwNpCYxxQDPPo
X-Gm-Gg: AYBFou3DEsQg8XJyAsEWdzv/K4J2ZRCQsKgKiYczrlfrYAAJ6YVFj5wg2I9p66l7Lmw
 2cVQ82+gGdErBng0NDXRwrFf4svVK2iLikrqIlP8KQI0Z6eKbN8z8rpVZNvzYuPUB9iEqmfrOgx
 2CErA4dNvbAzHfxLJzOpEAhWQ29vhRj+KZi8MvEWyWHK9/hr7xPUm++KL9qNblv32eo17nLN5jn
 D7bt+a3Lozxs2rsLShi3IyvtMn+lK82P68SqtSMeBSTWN/1ggaxQxmpya2uEG4h3zP9ydcWkqOO
 oawRxizbCZIE0krefWXaFeZ7bXp1kn4rTxA7MCLtmwrFkzkKwrwznRKXyDMp5eVFz2t4U8oj8a8
 npaa8B+6hAiLxqt1oUIVN9toQ+qN2bfEluGMi4B0TgiGv0QdHagFoHLRJDnGIg4SzrJGSyF/zc8
 5f8oKV2Eb4IDauWF9vsAA4kDUNaXT0kR3pRslPupVd5naDbG6sncyQpYrNrbG+eWbbshIBZZNdT
 VBG3DzgfkI47l12TvwBbg/XTXDR2X1bI1ZEZ2ZE1qTI6Sjse5D2daZ0R5WnTOmeVY9i9Gcdlrtz
 xlo=
X-Received: by 2002:a5d:5e0a:0:b0:484:3310:f393 with SMTP id
 ffacd0b85a97d-485908001bdmr27918574f8f.5.1788958104422; 
 Wed, 09 Sep 2026 05:48:24 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B836900E58FC5516AABB3E4.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:6900:e58f:c551:6aab:b3e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883a9b49sm36853890f8f.17.2026.09.09.05.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 05:48:24 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v9 05/13] dt-bindings: npu: rockchip: add rockchip,
 rk3576-rknn-core
Date: Wed,  9 Sep 2026 14:48:04 +0200
Message-ID: <20260909124806.14525-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112208.952061-1-gahing@gahingwoo.com>
References: <20260903112208.952061-1-gahing@gahingwoo.com>
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

Hi Jiaxing,

I finally ran reserved0-build.py. Three things back, one of them a bug
in the script.

First, it works: pointed at your geom corpus it produces the full
report, 415 lines, no warnings. Thank you for writing it in a way that
runs anywhere - only numpy, and the parts that need your files skip
themselves cleanly.

Second, the bug. Point it one directory higher, at a corpus that also
contains files outside the geometry set, and it dies:

  File "reserved0-build.py", line 431, in dump
    % (o["off"], o["v"], o["RESERVED_0"],
  KeyError: 'v'

The cause is small and I think you will spot it faster than I can
describe it. read_ops() gives an undecoded dispatch a short dict -
dict(off=off, undecoded=True), no "v", no "RESERVED_0". Everywhere else
you are careful about that: the good/bad split, the row groups, the
per-file value sets, and the "mixed" comprehension itself all filter on
"if not o['undecoded']". dump() is the one place that walks f["ops"]
straight through, so the first undecoded dispatch in a dumped file
raises.

It needs a corpus where a file has both more than one RESERVED_0 and at
least one undecoded dispatch. In mine that is exactly one file out of
thirteen: chain, with 2 undecoded dispatches out of 26. It lands in
"others", so dump(others[0]) hits it. Skipping undecoded ops in dump(),
or printing them as a short "undecoded" line, is all it takes.

Third, the corpus I owe you. I have not collected it yet, and I do not
want to give you a date I am not sure of. To be precise about where it
stands: every .rknn on this disk is still yours - 103 files, and all
103 declare the same build string, 2.3.2 (@2025-04-03T08:26:16). So the
axis I offered to test, whether 34/66 <-> 0x4044 survives a different
toolkit version, is still untested. It is on my list, behind the DVFS
series review.

One more thing, unrelated to the script, from your earlier mail: the
/dev/accel/accel2 you saw after two rebind cycles is the same thing I
hit on RK3588, where the minor walked 1 -> 10 over ten cycles and only
rmmod reset it. I traced it in the source afterwards: rocket_device_init()
allocates the DRM device with devm on the shared rknn platform device,
which is only unregistered at module removal, so each unbind leaves a
drm_device alive holding its minor.

You do not need a new patch for it - it is already written and waiting:

  [PATCH v2 1/2] accel/rocket: release the shared device's devres on teardown
  https://lore.kernel.org/all/20260731064933.12548-2-royalnet026@gmail.com/

That series has your Reviewed-by on 2/2 already. If you rebind on RK3576
often, that patch is worth carrying locally in the meantime.

Thanks again for the script.

Igor
