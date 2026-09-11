Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75369C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EFFD10F58A;
	Fri, 11 Sep 2026 12:28:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="mBHXKstg";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="PI9cm4GT";
	dkim-atps=neutral
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2826410F595
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 12:28:39 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 5C2341D000D4;
 Fri, 11 Sep 2026 08:28:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 11 Sep 2026 08:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1789129718; x=1789216118; bh=AxIoCKz1yyOSLbMtsd8JqYfnrAUlEyRE
 EcynxoQinI8=; b=mBHXKstgOIb+9zqZmdPcgW8QZPm+Seyc4JfIavD+XgGiPapr
 +WOkKpJjqaPNRo1JmzcSLDTyEKJeV3n45CgY4AjIHQ4ReGb/557dEDHnf/1/nnV7
 IEA4MUin8DiA5yN+PEb2W3mPsDESCWvOEHhGJ4Yp0biyP7osfRO7SaBbUPVELNIU
 GCad5QeDUPJQ5xgqlNp94sa0ZwVIhbIYgrhpN5u1uV3x9PCwyiymIykF4XEPmPKv
 TfWic/xYwgGNDf1BEsgGPPKb35B0DtEQNfgXJoSHwQhs3DO7VA+PmZoD0rkH2pXk
 Ip0Ec21t7ooiQGaJrFWyhiPr0VCToRKoP5UoXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789129718; x=
 1789216118; bh=AxIoCKz1yyOSLbMtsd8JqYfnrAUlEyREEcynxoQinI8=; b=P
 I9cm4GT7H9gZOXsfmAmWHYj6tNwLL71dk6vRUh2++NJF6n/Hh+RVYmXQWwYnhLq0
 +/E8HtB3/VYCJy0zPSvcn7olOGjWZFFFbZDF4gwhi0OCwsbqYKdkP0CfoWNuAFun
 uqNLj47ORyuX6jTrSp/5sdS0FThLpzBx7glL+SYmuvD5exPrWDoCpxQcR0JQCRkY
 AdpE0MjhPdSHDEYpNjFznOAPjEQGLUMVtHZYR37PNB1ihscXStLiRK4qY+NSzd2H
 uwAUOhYSr2p+m5LWctClYukJA1XSL3HRXjbcRGnwUCit2mG0uKwNgUzRmz2RXQ2P
 JNi+0p7KYkSIMsrkleuXA==
X-ME-Sender: <xms:9fOjatP6ixP8qs3NDLmUvvpdv7iMfOAdfQa9EoNnsJFlns1hq2onow>
 <xme:9fOjatEajX-efmgtR9-OzNw2baMiMah9wwPEaumcmUwz2GjR80xBmcCPnP5Qzrf2Y
 FrNm-F6T0oj3vy1Ez9lP1TjaIiq-MhNvj9qPbmlFK2c_M-j9WLXfHAl>
X-ME-Received: <xmr:9fOjarSK1A-dhFEPgNt-LAlfXrt-8Za1gxAd3n2vU7OcLwDwOZprug58s48nCWVG8BcW_fRAFA>
X-ME-Proxy-Cause: dmFkZTEC7DY9vvYQjeiSkR25MRA1DOJZ3ovd8QcyXQQdSSrFDKPjvfnOr0rOFxEvcnz2AX
 CDeub2noA69X+cISN1KvI0M3SDAZzQPTMr08OL5oiufzteTfHMPFycuW96aLnwnK0j7G7g
 mhScvUblXhIENvh9mXFfECZpuytodTmEs9SJjhKWG/9dRq7QdYR/GQmKirMQRPNSTReuON
 wPSKXxLB8CZnInNY+74Kl2R3HUxBC0cRXn8D5ZGRmzG7GJompv4OJmIffcK9WhJjq6+JAn
 jlXT1woR9/J9ItM+WRyO6pDrrtp4dVXt1Nov8FtCwmYITPSj6TBtTeiKswl77PFcGhSfoV
 M5Mo6LviwFO1+3qCSkFPqy+9IFlvTHhNK8Dziq2xcdH3AfQHh22bjetXq7wCGHPQf7lvjr
 PKJfzBq5pTRuUpG9Tn+/dOVBSb4VsUBt8aqs6L+BP38D5M+JPNyuiBM/XDFB+Stm1Kz2al
 lyVRxLPHvWnKHDM0dp85j3TXBxHmcQHa4r4/Z19//X2NcWsVGaxXXnSsyEnJYidSbHQQeH
 Fkl5ttYHz2HQZaIz4zl2xitISQen9JPZJnUPz8PVPo2ut9oI0t4DrK6HF4+skoq2gE3sQV
 821rgf20ZA7twEQiJXUTaI9yrlio+020kvHZB6LhmOXv8nfHYQifsgL8Qfgg
X-ME-Proxy: <xmx:9fOjaqsORv4yFg15fCdOkPsGcWuKZJ1p9zcbITSHox2VolsyyXpHZw>
 <xmx:9fOjajIiF_xGPO69p0SHPgEw9SXZGvK4JY4EDDYwDJfMd-NIP0_N0A>
 <xmx:9fOjavnVbUnfr32S_sPeW4lKFffeaQTn4bOL9ztP8R4EWrKQAbCOVw>
 <xmx:9fOjasJAewU8cY3ntNL7jfdOVy25QzJQQBRjK47yqXvirh4Z4-wXOQ>
 <xmx:9vOjanjDHmCaBKpNihM5Za0Mqfn3Tge7jydt-tm1fulrIJ3TLx6fypJV>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 08:28:36 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v10 00/13] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Sat, 12 Sep 2026 00:28:32 +1200
Message-ID: <20260911122832.1364839-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831040804.24111-1-gahing@gahingwoo.com>
References: <20260831040804.24111-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi Igor,

A correction to what this cover said about your differential run, and to
what I said to you about it on 27 August.

The cover said a job had signalled completion with its output buffer
never written, all 48 channels 0x80, and that across 102 induced resets
in nine runs it appeared only on the arm without 1/13 and 2/13. None of
that is what you reported.

Your table is 12 + 8 + 12 + 13 = 45 resets, two passes per kernel, and
you wrote that the race did not manifest in the 45 on either kernel,
with the oracle 48/48 on both arms. The 0x80 is ours: on RK3576 a fresh
shmem BO is zeroed and teflon's readback adds 0x80, so an output buffer
that was never written reads back as a uniform 128. I carried our own
signature onto your RK3588 run, which never reported it.

The patch text is the part that was right, and it is the only form of
your result I will use: 45 induced resets across three cores, the domain
dropping every time with no MMU message on either kernel, so this is not
rocket-wide. You were careful to say your protocol could not settle
whether a genuinely hung block behaves differently. I turned a bounding
result into a reproduction.

Jiaxing
