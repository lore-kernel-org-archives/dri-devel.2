Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58899F557E9
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 09:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C003610E481;
	Mon, 20 Apr 2026 09:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k38VP0c5";
	dkim-atps=neutral
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B4A10E488
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 09:05:40 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-651c366f7efso2872234d50.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 02:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776675939; cv=none;
 d=google.com; s=arc-20240605;
 b=OWKC6ATrTzfmSonZO/xCDPfoL45tXhgwTqaq0k/aq4WID4NhUNLev4D9z41kIN1DOj
 qezQYEUIg4tfEcxCcdZmhWG2Qv2cX4jylwNQCueleQpR2/SaJ/RNRaOxHHKl+8QNCSJa
 jJ8BsVEWPl9rRbKhY2ST3ZgX24uDL6524lnJNSkKGUY16XxDXLPCqY4c4p6VCqlXqZ3G
 jq52zW+US4b+wHxNGixSNhixBURrz3s5kBUNbsP2CLHUXhibaP38RsdCDrCbnL06qOGz
 kGembpfBQ/f7PHc7QX2XdaX+XTyeV1JFJw65o8j/gaUZpr/gZTwfx399rcuTSzF6N7cR
 Wkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5egZAP/oNduQWeGQjV2YZI+IrIA6g6E/EegiGcc0lT0=;
 fh=9g1EhFPkEDmx4qyh0ljV5IGNHzLdCw0cOi2aYD1os8s=;
 b=RbgyCFQv6Q7zLW48WDSQ9lgwfVJs4Ia5FqzvZvey17xS6pJlZz4CknCfgEOE07fsy6
 ClP720H9/EqnbEgdKfwyIV7hSbBUFzpZKOIL+by5KKQo8UMdayG9A6KkDH9OfB0eQVD1
 jLRexSCh3a0H2DzNHsA6LoMQA8XltZg4X80v7+eEnHzNeoITyjFxULCB95NpYkPRtKOQ
 nV+WcDl7zgBnpW97X9tBor7X+RfCZQz2E8azDjAQuzCNJWd8R9jWTqLPc3XyGbO9UuIO
 PbKaKGl4AP+7VwtnYSdLkVVoZSd6Xz1S6WR4GNHL0ZJZqS5yqyYRxOvHB1hYr127IWm6
 UooA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776675939; x=1777280739; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5egZAP/oNduQWeGQjV2YZI+IrIA6g6E/EegiGcc0lT0=;
 b=k38VP0c5FCsEIQ+IVAlz3TrZeED5WNb7Yac9Wcs4djfiUlUo9wRdrxXKoJT3XHBCJ0
 MtuBoFpiV503rBtQ+L8+zVj36/m0T1JU/Y8/IvkPq+iKV185ZDpVOHDVVvpTF2OgDKT1
 x8r3f8X2bLFr5ht5wcKVyvQ6Sp2kzaeIBL2xJo2h5Uc4Eo2kdfCreWMLbTp94tXhiLQb
 wsfCKxLXKapFN7RmuATE6LmGtqzzhqslNth24xhOB4YpBW2B456ljQBu44FzsSeTSVDN
 y8PW0lFnYq6Ubs6tW3zKn9nD4Yz0wj77K4FzpG3vc6RKuRUkR33t88wxTkiUzZGiCKlc
 nfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776675939; x=1777280739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5egZAP/oNduQWeGQjV2YZI+IrIA6g6E/EegiGcc0lT0=;
 b=Xwot1qpWL2x9s6ArkYd25T7b0MiwrFYydH4H9XchFikOI+20rHBYa/XSyadEejUxV/
 7u2RsezYgr1yU43uYX6K59Ty9hcj1uARsfLI3FkD4+uAoPkcjgvSkdU3oYNkrPSMx4dt
 tS1mHt9kVg27b+ftWS4OFnq13+o2TLsrfCx/hex2HpMtKisw5+3UQy41S9BEIup41dok
 eZydvRJRipNLjGz7BREeMH61Hzw8Be6cRIFyv1BKsoeKym3BaYMJHHDbQiNDzZCUXuDG
 2ncniYnEM6EmEQrfL/JlOvWerge7Mqu/7a4TS3VnTDGy9rFK4DQKlOSBEjZuK+Prej+l
 PuNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YQHlaq63YqK/sb1M0GDRCWI75hvHl+k1iuWumERMS5cl0zDaUs8JdC7OXJubCVMHJ4V+yHs3il7E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwI/ts13iCGcFHmESY8A4HpPYy2fmw4mFO/0EUNj/OS+/L7zdnR
 1KFqh1YQf7pu37V7m7oRhRexeTPuwDN3PPds6/T/uzAfygraQy7qvcS0UpKa/mdwJJRsLsz1pcq
 lKx6Ka3fWxf7/kmVYWvy7q01FgpeHVyo=
X-Gm-Gg: AeBDietC+sCcSfav+/gnJDbvCMsK8BCKSUpxQs0I/c2sQ0ca4N0GjiZjMjz0MZ1z9qW
 +sYwHWsHMzrjdPM5vMY5XsilVTxRBG8ctZ4M1O1u2YJjGEXQlm5V9w4smvNYttN1Q5i/k2pPpjH
 RUJnpZxv+FSQ1Gie0qjEBW2MtcU27tsQvqTQqukueTe/94VJqPG6KanEGEHgyXJxEf9N78ccAQY
 Oqv2dQS9Sbr85FEnafcAB5ZIDA8UjDfX5KQupInyLpgyuqBtUtcdwoFDbzeCeZTS1NEEDq+KUZg
 jTFTTmZJ9x1hhNAW7fl82CL4FpoEJ/E=
X-Received: by 2002:a05:690e:e8b:b0:654:1261:8b57 with SMTP id
 956f58d0204a3-654126195a1mr7903049d50.6.1776675939331; Mon, 20 Apr 2026
 02:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260413141328.2954939-1-lgs201920130244@gmail.com>
 <q6Ni253ETr-zY8OZRWnm4g@nvidia.com>
In-Reply-To: <q6Ni253ETr-zY8OZRWnm4g@nvidia.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 20 Apr 2026 17:05:28 +0800
X-Gm-Features: AQROBzCv0ouH9dGitvJnxiCUbB4xuHu4ZEpCCDhZWL301SP8_3uH_VxP4dq4Cy8
Message-ID: <CANUHTR9khFiwfyAWFKBuzM5opBRLtuOPTWNZyuaoP_Rxmxk+1g@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: host1x: Fix device reference leak in device_add()
 error path
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Vamsee Vardhan Thummala <vthummala@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 stable@vger.kernel.org
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

Hi Mikko,

Thanks for reviewing.

On Mon, 20 Apr 2026 at 15:19, Mikko Perttunen <mperttunen@nvidia.com> wrote:
>
> Unrelated ..
>
Sorry about the unrelated change in drivers/firmware/edd.c. It was
included by mistake due to my carelessness when doing git add.

> This isn't a leak -- if device_add fails, the device is still on the
> device list, though in a "stuck" state, and will get cleaned up through
> host1x_device_del.
>
You're right. I misunderstood this path: if device_add() fails here,
the device remains on host1x->devices and can still be cleaned up
later via host1x_device_del(), so this is not a real leak.

I'll drop this host1x change.

Best regards,
Guangshuo
