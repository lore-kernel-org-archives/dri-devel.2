Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BDCC44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1752310E125;
	Mon, 20 Jul 2026 19:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qr//C2Xn";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF1E10E1D5
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:54:57 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so2854033f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784559295; x=1785164095; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:autocrypt:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XnoNJySGi2Izzd1ger7ulGeh5cfeHWBXigWAMR6/Z+4=;
 b=qr//C2Xn/lmWYblajWTXrr0xCOq9bUtXDQ669X34yS3Bh/mhpbE5apaM7rovZudXcN
 xu+3BW7ndFiRrywe+pXAwiOnyXyvU3/R9bP+sFSXcGOWie9lKLO9+nC86rbdP86Xpe34
 Fys4eMxAf1/h9NcdxcRHbe2AbQG0p6wnplsieml+rLBWz9Vr1Mhxq7lfRE5icUhGz2om
 NGO5U3dDHZWRgMTzPqCbV70avitPzRXwyVLtVfnddQ1lPLe/4IEGT07YuoxIxpBC04Iv
 MMXhp3J5rmWMoLQKRgGtDqEVUUs5RZ4kFvyEdzSA5K61d577VXNqcl+lYmqRqz/ZgfsS
 6lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784559295; x=1785164095;
 h=content-type:content-transfer-encoding:autocrypt:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XnoNJySGi2Izzd1ger7ulGeh5cfeHWBXigWAMR6/Z+4=;
 b=gkthzsBngx7JpVUvVJKTVavEOdmC1mbAI6H57GUm8kJAxMFb5Ydn8c23lBDhTBkCcj
 nt+lWEMfDPolI+CJ0Gti280kmjyj0sMVW7Wiqlj3kCldr3agVQz/kxckZEiOYjVa4Err
 edzR0VonOmgqUcc8sBHRL9ZFFgCW2DwBvdRisRi9hH9raBogmuPUosh5tDh92Fr2i8Ud
 Fipo92SSGNEwJtKc9xOgaI+PK7ZbgNczgtp2tSWGI+d7YHgMWC2EAemB6wFer45rp8Rw
 0DBBo3rAKp9vweYV5HLMif84zyqgzEC3fh3wa0PqRriSQSMvfApuyohGgM5aCQYdhLPw
 OHxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhhThxfL1WtwNsBncZsNfoCFLHOGtCAFBFhIFh2N6OIcA9fwTP4jzNrCmBUoHuAwekxK/n13cqQY8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIEPZV59ya5loK7DoWTHwWBZiXvCwA8LNT0ZSKbpAQWM1NGClB
 oUUhVoztCb/vejEEfsz3i+E1aDLZNgXypvgl5fOpQqvDHMwK6SwRwNZF
X-Gm-Gg: AR+sD1045eu1nOu7ysBi3yCcEfsSu9rYhcBvqj2AXEItDsNFi6T09qe01QwEEe5dWCR
 /5tIPc79z6QIpJJom1wiuKGGi7k5c2kc+xlAp7dqnwLKKVqcDmYRoW6FXLAJfNR4Lnz9Kba9ccX
 wk7t4S+X/C1jeLxpzI7eInc8XLba6GaRiwEDcSRR5FCQxhThZDJ+TLegK5KMMnxE8cAqCZJRq1F
 RJ1waRcpR5EnAw0crkIZPIFF8HIRh/2/T8q/tiam/lOwbg/3ZTMPKOKd8GtLOlRpHbrEzgano30
 GFjtHssaoLIBnhzFuG+XbdZSAGJdyyMVKBgg52Dup1VBX6a67wFvZwA8l5eGSSa2yVAksTRkBaO
 TQT3IWFu5AwG0orCMfa3mhw8nq4ETVABXuSGbbvZ7LERTQnk/u/PHBrZaqXk161IEMkpfqgIPXq
 y9eLcWXmI4erBhxeHHXg==
X-Received: by 2002:a05:6000:46d0:b0:47e:81aa:3822 with SMTP id
 ffacd0b85a97d-47f6232c96fmr10331792f8f.42.1784559295439; 
 Mon, 20 Jul 2026 07:54:55 -0700 (PDT)
Received: from radijator.localnet ([93.140.52.191])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edcf8dsm33115875f8f.27.2026.07.20.07.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:54:54 -0700 (PDT)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <dujemihanovic32@gmail.com>
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
 Julian Braha <julianbraha@gmail.com>
Cc: rdunlap@infradead.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH] backlight: ktd2801: fix unmet dependency on GPIOLIB
Date: Mon, 20 Jul 2026 16:54:53 +0200
Message-ID: <-BogvF49T5iTuPtucSB0VA@gmail.com>
In-Reply-To: <20260719024902.151710-1-julianbraha@gmail.com>
References: <20260719024902.151710-1-julianbraha@gmail.com>
MIME-Version: 1.0
Autocrypt: addr=dujemihanovic32@gmail.com; keydata=
 mDMEabRVUBYJKwYBBAHaRw8BAQdAG5VJBpoPRIGQml4+E2LcPdyVtnXRuuqoD1BsHxRjNQ60KER
 1amUgTWloYW5vdmnEhyA8ZHVqZUBkdWplbWloYW5vdmljLnh5ej6ImQQTFgoAQRYhBJvUYwF2kA
 idqo3CZidfVEs7G0eSBQJptFVQAhsDBQkFo5qABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAA
 AoJECdfVEs7G0eStq0A/1SDcm8Bkq1JV+GTGMC8qE1QzCFvnoJuZqtUuQRCkd31AP9Mbc3pmg1K
 JDxgPl17/CQohZ98dbUVffmdQpJJLLMsArgzBGm0VXYWCSsGAQQB2kcPAQEHQH8nnS6QNfgpc1Y
 tqU80DWMWMsDPEGJ7yZ9Nf90mPEEQiPUEGBYKACYWIQSb1GMBdpAInaqNwmYnX1RLOxtHkgUCab
 RVdgIbAgUJBaOagACBCRAnX1RLOxtHknYgBBkWCgAdFiEEA6Ue0g5lV5FAcj1ivjIt18NZWcUFA
 mm0VXYACgkQvjIt18NZWcUyDwEA5OK1WRFN4/psOq/bS6Wuh5ysy0CyXIydqIwDJDdAFukA+wfc
 lr1qyAbEX0FHVunCl+sxv/ymvjsup85rAH+a2j8HA7gBAIolabvAIUTUfCQNCu5MUt482b2EC8K
 40xl/6HT43dunAQCqxwRLI2k0xmTdia2AZwqbbMvqWonOLWtdZwWvodgjBLg4BGm0VaASCisGAQ
 QBl1UBBQEBB0CoqkQL2R15WHRvj3RlkxjW3pPpZVUOHyfhEX+Q9PhTcwMBCAeIfgQYFgoAJhYhB
 JvUYwF2kAidqo3CZidfVEs7G0eSBQJptFWgAhsMBQkFo5qAAAoJECdfVEs7G0eSnB0A/3oyRxS5
 cUJMNnM1+4UkRahmU5/42NfVOxIL5d5oaW13AQD617LpOfnCuZR3U0vHLOW5vrnFtdvi32N5zLD
 9wyShC7gzBGm0VbYWCSsGAQQB2kcPAQEHQPRL1mWe9nIhjicyAqqEN80IXEF0NeKSFFpN8n75b2
 YIiH4EGBYKACYWIQSb1GMBdpAInaqNwmYnX1RLOxtHkgUCabRVtgIbIAUJBaOagAAKCRAnX1RLO
 xtHktyGAQCJPD6JsQhQZEB8ciZrJz+hnonsJp+KZZQQGEK/KsLHEgD/ePz/x0pQdI/DcJd/5Qge
 +IJGd+jyv4zyevPxipVbyAo=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Mon, 20 Jul 2026 19:03:49 +0000
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

On Sunday, 19 July 2026 04:49:02 Central European Summer Time Julian Braha=
=20
wrote:
> LEDS_EXPRESSWIRE depends on GPIOLIB, so its selector, BACKLIGHT_KTD2801
> also needs to ensure GPIOLIB is enabled. Otherwise:
>=20
> WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
>   Depends on [n]: NEW_LEDS [=3Dn] && GPIOLIB [=3Dn]
>   Selected by [y]:
>   - BACKLIGHT_KTD2801 [=3Dy] && HAS_IOMEM [=3Dy] && BACKLIGHT_CLASS_DEVIC=
E [=3Dy]
>=20
> This unmet dependency was found by kconfirm, a static analysis tool for
> Kconfig.
>=20
> Fixes: d95963e309bc ("backlight: ktd2801: Depend on GPIOLIB")
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Acked-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>

Regards,
=2D-
Duje


