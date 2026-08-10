Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EADAC5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81D6810E60D;
	Mon, 10 Aug 2026 10:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="0Iirk1w7";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="M8gyTEwG";
	dkim-atps=neutral
Received: from flow-b5-smtp.messagingengine.com
 (flow-b5-smtp.messagingengine.com [202.12.124.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC5310E60D
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 10:47:28 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailflow.stl.internal (Postfix) with ESMTP id DC75D130024E;
 Mon, 10 Aug 2026 06:47:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 10 Aug 2026 06:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786358847; x=
 1786362447; bh=i1d8j3w63MewxTuNMV7zC0RSGykhvhg+gqyCJyLiHoA=; b=0
 Iirk1w7cDQxW8fGCM0zH2tLN9MREJS+iQ4rYA97Hc3EJioyxRdto9VNjKGOX7UDS
 53hk1i9BlfAeANcKM2WQd813Z9U4Z6IZ3t4OeeJXFPREQkNjA44vb4ZB3750XLUx
 5uVghWnf/6AR8MeccqTviR4ioJFqEiglwsdEFr5BVJhEjZ9Ox8wtztSqWCavNfet
 uiKKsBE3Tw4uiPhVy9kfuUJyYjkUJvyLID3/1DDQMt2tXuZJpb3VK7l8NwzlyojU
 nUPfd5RY8IykCOPzhEj038m48AZcW5+idNccobN33JiLbfSjKFqvlTxUer5Hi+4B
 hYtDQkgKGDEsqkfe9buxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786358847; x=1786362447; bh=i
 1d8j3w63MewxTuNMV7zC0RSGykhvhg+gqyCJyLiHoA=; b=M8gyTEwGBlQuQ7ul2
 eFBFRMtOqMP5tOm8nWgmEEn09AehUU6SfJjgvGQuKcG6vvI4C9SMAYDGeJ18qe6K
 pHR+moyrn7Ti+SedHje0Cd8r+C3TMn+8Jy9a6c3aioRb6JpQKybuRwVpHFeWWB/t
 eY3QhdGhRoCXKnbMms6aEgPJBlPGpDktT+mHZ4kZO3xAj0qLqF9PmEQBKEx94V0S
 t6ZyRXxjHkYW/TyC9GM+r4HDJ2fLiCN8NXfdBm5L0cN5KXvf/LnQmDe9j5RF6JR5
 V2zjOGlqqhPR17juGUvgFgd3rzajgrm0YK8KjL7I7dxkmom/CuSGqcDOGfPnt9WM
 ud60g==
X-ME-Sender: <xms:Pqx5auEHQ0UiPoXqqAPmwBxiG-lnDqPSHt9yhpLRAb0ERMlauVfp0w>
 <xme:Pqx5alv_dGrnXkM5GRzkUa6HWq2baHDRxG9V5ZGZf4Ww8_oGZ8MC1W6Jhmn8m7TMb
 uX9QlmYqOssT6ptyx_DYcQZz_ntPhYgfGR5OU93lLgKLk_KEBBtUBw>
X-ME-Received: <xmr:Pqx5akadEEBoM6rb8ZsNJYL9o0jVN3rbAd_ARDsvREjjdm1RLWPqARuh91zUiRwCkuG_JhBzkQ>
X-ME-Proxy-Cause: dmFkZTE5Nfr2TDzQINlxmlOGJApALjQbyPsZet3r/DZJh5EHasV90KzDNM73V+IHteFMkf
 /hzbqKWMBrt3JwlLyQuPJh1r5R7tWcyA12rMW7uK5cMLKXrl2rLCwHN1T0pb/9Y0RV1LFy
 NJD57/bMVQSD7eCINQ81fbqfUZjghmqvfPsfz0uuPS40S7lZ699MAmD/BGuo6Vj3j+Hifq
 dj/YtJEP2JIIcBJ2mtjpaDlOdHHiuhEUWQ9co/u/LwJWr3rI1NcToTxI2FEWlZxkbzXzwW
 7j63BaHAKJapGxxwTEwb4xnX+uBLErgXDYZjbV8A1D0VbRIqZnFLDL012ubqW2TRBmhjkW
 Cdz1HGRIsmDibrraVMrxcpy9maSQwwAFTsrjN9iBbhz0S/5XtwprurAEpbGTdXMCp3M77I
 EEvRYPwjHtsOGXGYE9g1XHFQLBqpdAwpLXnzge0b4ie3+HJ52FwkFiG1v6n8z+Wd/dwd1x
 Pjveda+Q/H0FTI3JPBDw1caj18oc1Rmmj3XtjvRh3if6rmqJAMa+Uod22zgNTw+pr2FyMv
 6mWyLsfibe5M5plfrf9Wk6tKeXa0yuD/ivPo+3Xr0YTx/c11d3RSoGL5geXb7HJaVzx0Fh
 PLaj4Tae1V0sXLB9N0ayWVV7t5SD6uYM3ojafcUND99+X+R5Rj2qUYph/F7g
X-ME-Proxy: <xmx:Pqx5al56VUqygWg-uXQLw5pYLPHI8aoiPk8EZSi7Qvza0YNLnzUojg>
 <xmx:Pqx5as-Y510AqP9FMhm4RXXqvZEKKOGU_ezQ8rfyOLbSVaYbhDGMsg>
 <xmx:Pqx5ahZWZH1AzsMBPn-tyznhk6KDxD4ztTZvnIIbSpnpPCR9R7Y6qA>
 <xmx:Pqx5al5ORnMk1K5FpYd96XoK5_K--kdNkEi-I26VaDDpNOlFS28lAg>
 <xmx:P6x5aoATVsDps-ZgZEUF25V2_BvSS86ZKJx67oT84H6lc4m66LTcXIjV>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 06:47:21 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: chaoyi.chen@rock-chips.com, royalnet026@gmail.com, heiko@sntech.de,
 tomeu@tomeuvizoso.net, robin.murphy@arm.com, diederik@cknow-tech.com
Cc: alchark@flipper.net, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [RFC PATCH v6 7/9] accel/rocket: add RK3576 NPU (RKNN) support
Date: Mon, 10 Aug 2026 22:47:18 +1200
Message-ID: <20260810104718.1214191-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com>
References: <20260806063413.350184-1-gahing@gahingwoo.com>
 <20260806063413.350184-8-gahing@gahingwoo.com>
 <20260807211629.1573228-1-gahing@gahingwoo.com>
 <4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com>
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

Hi Chaoyi,

Thank you, that settles it, and no apology needed for not reading the
series.

> For RK3576:
>
> - BIT[15:0] task_number
> - BIT[16] task_pp_en
> - BIT[17] task_count_clear
> - BIT[18] task_last_layer_clear

That matches the register trace bit for bit, and it is worth more than
the trace, because the trace could only say which word the vendor writes
and not what the bits in it are.

BIT[18] is new to me. I was setting it because the vendor's word had it
set and clearing it was not something I wanted to try blind. Now it can
be named rather than shipped as 0x7 << 16:

  #define PC_TASK_CON_TASK_NUMBER		GENMASK(15, 0)
  #define PC_TASK_CON_TASK_PP_EN		BIT(16)
  #define PC_TASK_CON_TASK_COUNT_CLEAR		BIT(17)
  #define PC_TASK_CON_TASK_LAST_LAYER_CLEAR	BIT(18)

with the RK3588 positions kept beside them, since the two differ only in
the width of the first field and that is exactly what made v1 through v6
wrong.

One question, if you have a moment. Is task_last_layer_clear meant to be
set on every submit, or only on the task that ends a layer? Setting it
unconditionally works on RK3576 here, but working and being right are
not the same thing, and I would rather not encode a guess in a driver
other people will copy from.

Thanks again,
Jiaxing
