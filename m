Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05BA10A88C1
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD6C10E03D;
	Thu, 26 Mar 2026 15:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="SYwxEPku";
	dkim-atps=neutral
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6918410E03D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:14:16 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-7986fb839f5so10664257b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774538055; cv=none;
 d=google.com; s=arc-20240605;
 b=IyTlhSOB6M6D6zN/xZ0gVq86KGaDtnh9/2HLmvihKC5uL9/09ftjPoeqrpr+2+hZ10
 L3EMx6/hbIyGzDucTo8t24nKb8pm9KRv2KTr5dLQYg6zr3qNMP0onD5fq2Br9jC14R6P
 9gYtLXwj8cOqb9s01FD7IzptT74flU+oNUE0d81G0w1AM8hW3p9RToK8sRHpeYonjIJ3
 jgErhh5eHdpxX2OzLQLzmDifevNW2MQLbw7AkEZM3KJL35KGFLsive0Shw1RWKBu53rX
 1AojOwm96dRiN0y5HAxyPv7OnVGlWs0mJ9febv3wxGyqW5V1UKYueOUXFApNqN0If9ph
 Ck5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pj2+FxfTcRBqoT2SQULwN3tEDJah56AO+uRDZCQ5zjU=;
 fh=kvzkXJTYI0KsMvrfwPpyITVn9INo2Y2aCGxw/gmDySs=;
 b=Xtms5D2OuLNOygqHdYYgIFRm/YFiEd+uFf8LXk+lQ2JHWzTTinTr2BDDS6dB6mosLW
 al4vOMTKm3ZuXBysg+uSCIt/B0FEccfcEHDAPjtgBGscAulJbfukcesvCjUHl5cP+4gx
 hbWDTSDhRCm7LrUkaeNzBaN6fmzRkZsGr4lH86rc0Sk/aXj6hYGfLQIoKfbtA/QDhnSl
 q8CkRlBhviHYDggHWso/AxkseScP9smo4OakgDJWIDZL98RgZh0Ns3KfFT6AKgRVqXux
 zdTHRcoyJhSs44VOixR6ZEGrNTYA0PZrjU4TCT6nCExajf2sRRRrVtGHOSNrpFK6TNtR
 tH6g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1774538055; x=1775142855;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pj2+FxfTcRBqoT2SQULwN3tEDJah56AO+uRDZCQ5zjU=;
 b=SYwxEPkukxfueCzi/T5xNnclHyOLxB5GlFXPOXTh59eUuBsymi5BPCBora950WAo2I
 utheLR8yEhl3BQkLaVHqVql3t7rfwupZKcz8t8+1YNYj7H2x6rB+L2ziX2sHAKs1Bmbq
 4TpseRXaUNlg0NBhtRf89SZecqXJKQ/EuFMblBeHhrTogTVRpmsKxTzlUu3uGw1NxKAC
 c7PymDF2jFd9eT3Kxxpt7eQMc71/huPnnCxJSz66IDeCqTxinijIUa73NdJDcz+DUbVJ
 UmJGgcRZlz2BNLWfKvJ/qrGUfdMZOmla8xsiaSWQlD3ufirm2Qbt7PPhNz6urfDXYVIX
 7w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774538055; x=1775142855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pj2+FxfTcRBqoT2SQULwN3tEDJah56AO+uRDZCQ5zjU=;
 b=ptksQ3u6Zqe7z3BnIRqJKtlH1yVP/xpyAuXUZcXMzmCtFzt8mdscL0e3YWhXqex6Fu
 B83GqkbRtsoOYHvbkECP3m2Y2pZ5BJ9pAjOts1upwckZU+8IRZv9kHGE9UXqSh7sCspt
 As4/vva43Qa4nFDubiqvTvpVOE7sjPMLH13CUuWdiUMOi9Ww8cDwNzpzU7rAQdpo9J3b
 hM7I/7ZLpF2pF3U0mziH29vVTegFVW+4NYP4xk6ey/ncXVmHTSDHd44d+G4PNUnomzaC
 i5Ri7MRLZZM5aN0fH5+JREbNo9p/5kYNQBVadH93757nfVkS8OMIsyhdKsiiGSY6paQd
 22Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLTC8gyvWd6SFci34cB/yDGsljrsozj/eGFDR+ZkJ3p1+gDFUhznxBQY7+q2iIYM1WJTf7nronYyc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSfHaZAFsC4RkFvmaABqVTsvadG7JXdYrl5rLQ4jPcB0Hjz5ZA
 oqdoYj56ZmIAn/bexwfTdot2bGCAINPb/Om4Ou9x2692Mq2NzFhfkW73p6dMGhP/xPBeds3IQ2S
 1eH6m3nYQsloT43de/PMINQsBuiuQDZwDf5j+YmfV9A==
X-Gm-Gg: ATEYQzwWYMow+fysAVket8RqsKx9USUE9Erax0DBQYC767tgPPBKKt49PvD9+81bs7V
 gJG1CaskxvpsIC36v78SA4ZViaeoKZkzqYkdQVM8vJXXfgiX+OA+QBfDrJJZ9q+U0CkDR0dpp1y
 09W5hkU9ctmBMlmgxS1de0njKzOlIxrSIICveiPE3Mw243Z7t8vKnhZ979J4NTBTXFqkbmTLmvk
 Jh0PfV481BUcHtrbpNZ6J1FFWCs9qt6JQVtaiu4Rc9jV0kPBQK0nvdX1W0hR2avzWyelkDRe66/
 eyVR7PF1mmoS4SWG/WBQAwZgErwDothokXD3xPk=
X-Received: by 2002:a05:690c:4a07:b0:798:bbc8:bca9 with SMTP id
 00721157ae682-79acf614c6dmr87994147b3.31.1774538055191; Thu, 26 Mar 2026
 08:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260326-tc358762-fixes-v1-0-65f479227af5@ideasonboard.com>
 <20260326-tc358762-fixes-v1-5-65f479227af5@ideasonboard.com>
In-Reply-To: <20260326-tc358762-fixes-v1-5-65f479227af5@ideasonboard.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 26 Mar 2026 15:13:58 +0000
X-Gm-Features: AQROBzA0dmyZEFiQPKOYPoRj2TiD9EWFcVhaFa_ghOqP3UXCBCt5Yh7yBzp1SpM
Message-ID: <CAPY8ntDHqKEh9Ad9G7Fh6ygA5iAERFVMXaOw=gYYmrW+P_yAzQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] drm/bridge: tc358762: Drop SPICMR write
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Tomi

On Thu, 26 Mar 2026 at 13:13, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Drop write to SPICMR. It's unclear why the write is there, and it's
> mostly just writing zeroes to already zero fields (reset defaults).

What version of the datasheet are you working from? I have 1.41 from Nov 2013.

Offset 0x0450 bits 15:0 is register SPICTRL. All those bits do default to 0.
Offset 0x0450 bits 31:16 is register SPIRCMR, with clkmask in bits
25:16. The table says the default for that field is 0x3ff, but the
description says "0 (default) to 1023".

Changelog 1.17, July 2009 - "changed clkmask default to 'h3ff".

The SPI output of the chip isn't used on the Pi display, but it is in
DPI mode which defaults to sending commands out the port. I haven't
read the whole datasheet to work out the mechanism for sending SPI
commands to determine if it relevant at all.

  Dave

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/bridge/tc358762.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> index 053579591dba..52e2f3a73721 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -149,8 +149,6 @@ static int tc358762_init(struct tc358762 *ctx)
>         tc358762_write(ctx, PPI_D1S_ATMR, 0);
>         tc358762_write(ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
>
> -       tc358762_write(ctx, SPICMR, 0x00);
> -
>         lcdctrl = FIELD_PREP(LCDCTRL_PXLFORM, LCDCTRL_PXLFORM_RGB888) |
>                   LCDCTRL_DPI_EN;
>
>
> --
> 2.43.0
>
