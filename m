Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F702C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A7BF886A4;
	Mon, 17 Aug 2026 08:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="Paaws1Dy";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="fusojT3A";
	dkim-atps=neutral
Received: from flow-a5-smtp.messagingengine.com
 (flow-a5-smtp.messagingengine.com [103.168.172.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB272886A4
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:31:35 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id F17191380143;
 Mon, 17 Aug 2026 04:31:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 17 Aug 2026 04:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1786955494; x=
 1786959094; bh=kj9UPD7yNU1rZZL7clJ6XwnELwdTPhFdY55NIi4wXmo=; b=P
 aaws1DygV6CWPsT1yFuHmNr83IcgjVFY4tw6UsuWXJ10IboxcKYEHhiPdmub196i
 ZRLNwJUSh8pt4TDsIYZRbMaC0Q99dK4NxLv1iwvtMh/fmXSRHVdVjtgWnfVkHDD4
 rvDwvPaLRIABQ5TtcjXqJ9rYbk9h+VsHVAE7op5etzF9jB5vh25pjALQHpluStmK
 bkcwZ/lQjOH2FJ0qwFIWt1Y8m0LUGggQRkLMr0D+EUfprc2MUo/YEWZ7aoR83WB1
 5HHh1V3/0fZnBs7aH5m6095ra3cASmDqu6YsAMIA8JY6kfcQq1SUozMuRi15jMGs
 SmX/oO03WThSFbliKrymA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786955494; x=1786959094; bh=k
 j9UPD7yNU1rZZL7clJ6XwnELwdTPhFdY55NIi4wXmo=; b=fusojT3AbeEoLiPbg
 FLFOmF8zEwo96m/weet8nKzJyRvnM38kSuBqPzg7ECqeSIR6boAwgVcaBd86ud5T
 a4jt29rb7R3Y94qFVUR5WGJOmGkBpbVjhTkf6WKtv/jenLZMuDFq4Jbb92/8gzLD
 hASefWv8mDADa+BUKsiXNnnRUc7AO/VydbeqTjlrilkbB8m3PhfKJbnA5fmmKSFZ
 IMj7z1mROBqlPvKORPuiDOSmCt2GoAsgImZrbtiDJ3gq41qFjGYEoXu0jSaRGaqr
 m4Q1dZe1LtwWe9rpfnC33pg6sG3s8CLTsMQn93+5m2ipsencgOOZ3o/3DdBaBc3w
 D078g==
X-ME-Sender: <xms:5caCaj3Knhc7S12quhG9dCJdItmqlvkm_zj1TcdZf8lHydMNcFrtIg>
 <xme:5caCaqT6_NDNjFsm1TT2XyIkxw4C9jCHglC-AgDiV7B8hMlvnS143-lZX0JIrKcYH
 DoaV7yHGAImJR5c6iQ_leF8uxyJOPuxwlsGLIRrCzyAGFYTXkWINg7r>
X-ME-Received: <xmr:5caCavfRkBWuY-wD9o2GjGN4dqOgJLkTlysp0cfUMlpm82J0J0tt3wtkmNrSR07PxG5T29lNUA>
X-ME-Proxy-Cause: dmFkZTGlNFCMXBhh0Xuz13lLCPT1t5X10ZDK1t62HPqVbkp7Dk4pJngkT1MnhUQxOP8CBI
 4Bww0yxB4Y+GycYYQ/Y7IrgOz9b/R/OsK5/UGU0LRv9/gimevfWVw8daqMdv+ION89QSgI
 7s+zEFikrZPNx8xF19L11DeSbGzHrSaxR/TZSxJKcKRrdQZP00IgaOhCzh0paQccyuUEtf
 2aKpu16E3ur/j753HClRzVnnvutPLto7r+KpP98IaiP2XVEFFj4Tk1xWJTf4Cqn+P1w2vU
 SCEgsD3w6LJgJzhtuyjGaPlX/83O1ieb2n8w/ROZXZy+7jlI1TxEktInD61673lvBgJkR2
 IhnZWTGA2wDU5qv9AXMyIXaCXEsC4pH0XzhjEU+A646uGzg9I9l491pxhJ5bZTz0Xy+OMA
 39mt8uQOc6y0QRnv6YV2PsJ/EGdA9FhU3+OBTVJbhD7dGYnaaPiqssJQWFik5iyUneb2wf
 hmlTQE4fxuBC8IZfNT/N0IDnFD/QV0XKSEUFXh9xo5hsmNnJEj86mOlovn0N/rXxaIyLta
 9cDr67UATUOXLmsgbSBPQsvNj62l6wEoZWXNcVtHhqeWQXU7JlelgEzW8721nsZ3SWri0U
 ck1TzFuhWY3g9JHWGxVws2DxVv6DFDn9IIa2t9Rb9T38dqvIUr1UUsqHhnaA
X-ME-Proxy: <xmx:5caCajfWeW8AqWCzv1IQ8ExKG4Qjzab_mKuPgXnckUelnDKX43pnjA>
 <xmx:5caCah3jVxF5N6An0rH8xxJdnhhaLTlSRrmGcpsstkNBHZj6NnC4oQ>
 <xmx:5caCaj-UGNSkdzbFFAez5V5cQYcQApfPjwm1fJzgc9PkO0j_8DgbWQ>
 <xmx:5caCau7Thn8zArVn3YylDAOsV9WClJrPdYApZiE-rjWUcpBHyVk4pg>
 <xmx:5saCagFXsRUYpeT7IdJdCoUrDroJY46akElxp0Q0lGvuqnDB5pDBC7j0>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 04:31:28 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, chaoyi.chen@rock-chips.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Mon, 17 Aug 2026 20:31:26 +1200
Message-ID: <20260817083126.984173-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEWPSH7ETfw2TDjUfOvcVtDm19FC43x2vP=Lh7m+XPOGptnPWA@mail.gmail.com>
References: <CAEWPSH7ETfw2TDjUfOvcVtDm19FC43x2vP=Lh7m+XPOGptnPWA@mail.gmail.com>
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

Hi Igor,

That is the measurement I could not make from here, and between your row and one
of mine the question is answered.

The control you propose is not one I can run in that form. Upstream Mesa has no
RK3576 path, so its encoder emits the RK3588 register layout, and this SoC does
not share that layout at the same offsets. I would not expect the result to be a
convolution at all, and I have not run it to find out.

What I can run is the vendor userspace, which is the same trade the other way
around, same silicon and an entirely different stack. Five models, output tensor
read as int8, the NPU interrupt count advancing by exactly one per run so
each of them reached the hardware.

  model    zero point   values below it            sitting exactly on it
  a_lin       17          2478 of 4096    60.50%      32
  a_lin2     -14          2420 of 4096    59.08%      41
  g_cal       -8        108564 of 204800  53.01%    2551
  pq_oc        0         62720 of 128576  48.78%    3136
  w_160        0        236287 of 409600  57.69%    2877

g_cal is conv2d-cal's geometry exactly, 16 input channels to 128 output over an
80x80 surface, 5x5 at stride 2. pq_oc and w_160 carry conv2d-cal's zero point
exactly, 0 in int8 being the 128 my tables report in uint8. So the geometry and
the zero point are each covered by a model that does not clamp. The counts
sitting on the zero point are 0.7 to 2.4 percent of the surface, which is close
to what you measured on the other side and close to what the distribution gives.

The grid now reads

  RK3576, vendor userspace     does not clamp
  RK3588, upstream Mesa        does not clamp, your run
  RK3576, my Mesa              clamps

The first and third rows are the same silicon. So the clamp is mine, and there
is no hardware behaviour left for me to appeal to. Your third control is the one
that makes your row carry weight, since fifteen channels off by one is something
a delegate falling back to the CPU could not produce.

I have not found it yet. The register stream is byte identical to the vendor's
at this geometry apart from addresses, the requantisation, the pad value and the
padding. A, B and C swapped one at a time from the vendor's records each leave
the floor where it is. The weight buffer is the last thing I have not compared.

The 88 and 120 sweep is queued for the next time the board is flashed, and I
will send what it says either way.

Jiaxing
