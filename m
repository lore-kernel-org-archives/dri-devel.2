Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CB3FF8875
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 23:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2514D10E04C;
	Tue, 28 Apr 2026 23:35:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T9/3iO2d";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A47B10E04C
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 23:35:54 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ad9516a653so60839115ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 16:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777419354; cv=none;
 d=google.com; s=arc-20240605;
 b=j0pN8PHa0SzwFJS5c1lfoo+x2wXbg7gE8E944/9Jqu/BKgv9lngGxBpqXgg5F7l7Z2
 UoBIdsDy4wo6z2Cc6jZ6GOf5uCCskUbywIWp0NQPTeDCUjRdscEbfRumcVB21KLuRxwf
 /lx91zavp+l++7dtz76+L66J3n3D5SF9oUQqFd301aDTz+d5ZuTosS84fTLOQcUR53rM
 ikGH3Zr/yFQbZRyZmm0ieQS1goMV3bRnjt6OGM/fKu7AelIx0Au3vS0dJzFaV9JGaM5l
 xW32B58kzZ7RRpuXhPLTvd/3PSo0l6tkBfCLJlQOibv5zmL7ynp3kIr0NKBd6ROL6F18
 vDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0db33wYSB/VKxNPenizKPNWOjqB/3saiIIrw++PQlmA=;
 fh=1i5uhU20or+zJ+ylPMr7qbveWGq1Ze2wgf5QsOLpa8Y=;
 b=Vw5GzdLGPSNWd3ge5YuVITqfD9eHcL9ej7fygQXE0IGz6y59e9k2OrbqPmBB+m3lvh
 +3aztXW6YrssOat882qp6MuocgVLm8iwAO995nSN0t1S8NYXzuGxmkAmGmn0UQv9wC0n
 y47T4o/13iaSChgJYr8fx5f5Dt0F14cKUDxYapQ5F0bIcB3hJaY+Mhka1KmhRrPjDBJ/
 8zmguFNZfUWhG2v7JFba17IIWX/kSfauhRvvfbvPTPe5uMo5AoWE5ZnlKOWMoIpAzAJE
 3Sztdvr9CXSesOWZlWzXtRKrgLGGYy6MLyrIIIoRGV2scC5vG3+LiV/4k2rJvxknI5NH
 FFrA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777419354; x=1778024154; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0db33wYSB/VKxNPenizKPNWOjqB/3saiIIrw++PQlmA=;
 b=T9/3iO2dS5AqZo1Y+kFVgAPGUCk2i1RuGSnlDfltUmzV69DscLFh1Clr4kboMxMxl8
 iv+kGfyrLTMjIAPp45qRqaQI1+jo5ojyro/2MkphRkflRbOvhxt9f/cJLpax0VUgOCIg
 JVFWGr/WZT5uLBkyRl8PSd5p2TAWPnSKnn+pQ7k5QVnSIGb/CNTc5LQQ7CrMXABuLZao
 a15S/maw0FlZQPJh6/4klu0NYDzrRR9U05TePMgEOmpiBwbMJ0y7O7bYo2e6uaMKlz9o
 iK2UUthy5T4Ugu3ettnaPWRd/nc1y9HFg7XdDUDU17Ty6zETNgTvJ/ETNaeOpWSTGePY
 V6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777419354; x=1778024154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0db33wYSB/VKxNPenizKPNWOjqB/3saiIIrw++PQlmA=;
 b=WdzixOqGwxfbTls/xijZ0uuvUrBPwSaPGZdfxeSv2TMpO0RlcuyGkU2u0ZSaBEuMXX
 lZC5t7Ux2Jr7jytAyK9DkArV7OCuR9iixARQDinKSrW9iyTMvIrYIqArt+prhu49zxsd
 6TflVChmoQ+g6UT4Aiw4IVgruvXH9sowgdD40DUqB9uB/Pyj5BUNIA0tdVzME/EdeUq9
 kpsGG5HLM+cPpXvA5J3XaJc26xTYskNN2I05ZV3Rlkz3Dw/EXz7y7+IfvbUss//3jG4j
 bRBxU3Wh2huABFCRmi5nasbcgSnQiXuYcpA8COrFj/JW1ZwuGayNxeDmG5i3OeXFnB+p
 BoMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YCfROkNZ+Pwan8o632Bu7JamEO+Yn/3KTYRbXrdeMLtR75KcrMrckJf0dbmrHCgu3xg2CYlnhm5Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOuOj5/v/vSJR9oxkfglM125NSYTT8emh3A4RVFk8iXhyD1Te2
 sP3kKI21dep+21hryyBDnpWse2CFAZjqRsnl6pYoXob+ZKA+X+2z6gXirOb3PgcehcaCyD64coh
 pkIpW2q/SmmM8DiQRZQsa7SmHXCOuUrQ=
X-Gm-Gg: AeBDiesevcUnm67bOlvatcCmM9r7Tstt+zagvY/L7cVD9vOdFwpmBkK7YtR+oNz36nl
 pmS5k08TI2Lg+7U2U3ScikArp5IFFqK6fVg0IZ62DS9/TDbAo04UYIt09AkFmM5tufCdSa2AmaJ
 SQNHBgb8UQ5EuwYom1smR9Q+1BKjigqoqSMXs7CyFdPuuMwrRDyuKAOud4hqLhUv05JRGBADdPI
 QdNwNr5Dm+ARwsZsaPKTrBDN5Y46pAbxldnkjp/sz/QeJ4t4qR6MOKjNR9YpCczpBC86oEjWPgs
 +Ac4QHvz8uixFNzIcm14uRzqxvX0zOe+o58Bf9rGCJ4g3odzjFs=
X-Received: by 2002:a17:903:1c5:b0:2b2:4b4e:e4d8 with SMTP id
 d9443c01a7336-2b98730ca87mr13536075ad.4.1777419353607; Tue, 28 Apr 2026
 16:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org>
 <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-2-0caade5fdb32@linaro.org>
In-Reply-To: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-2-0caade5fdb32@linaro.org>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Wed, 29 Apr 2026 08:35:41 +0900
X-Gm-Features: AVHnY4IUG0aEhSqiUeS0javv0LFZ7gitoer-tm54oLakxbwVeIPwDa7HUcbCYTI
Message-ID: <CAKbEznvPAYFUt-ykH7rCQwMFUq6N68B9x7Dd97WRDm3Mvj34fw@mail.gmail.com>
Subject: Re: [PATCH 2/2] backlight: Add SY7758 6-channel High Efficiency LED
 Driver support
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>
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

Hi,

> +
> +static int sy7758_probe(struct i2c_client *client)
> +{

> +
> +       /* try read and check device id */
> +       ret = regmap_read(sydev->regmap, REG_DEV_ID, &dev_id);
> +       if (ret < 0)
> +               return dev_err_probe(dev, -EPROBE_DEFER,
> +                                    "failed to read device id\n");

regmap_read() seems it can return errors other than -EPROBE_DEFER
(like -EINVAL,), and hardcoding -EPROBE_DEFER here might drop the
actual error.
And maybe would keep retrying probe forever

How about this?
> +               return dev_err_probe(dev, ret, "failed to read device id\n");


-- 
Thanks,
Gyeyoung
