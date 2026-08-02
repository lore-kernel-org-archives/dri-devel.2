Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E425C55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 16:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7564910E26E;
	Sun,  2 Aug 2026 16:28:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oMLKWi74";
	dkim-atps=neutral
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839F510E26E
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 16:28:10 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-39c908d6cb6so28352531fa.1
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 09:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785688089; cv=none;
 d=google.com; s=arc-20260327;
 b=eqD9Fzt+afsRfJOaO06IjN1sAl4CZwvzFHW6esUib2yGfBNWr7+CBRsUsa0MQXTr03
 o6KJJb4dWiHxSn6IV8J1sO3Sw0M3/eGWHQjgQlKAdD2zWQxj4zdcqtA9UOMdwRNO74QX
 HecCwsQt2SitPMGNrmuabSOL9XWRStlzUhYtk++LAazpUklpktaFW+etP4vYTiF+J0NC
 AJtCl/1l2iTbkRKrQZlWNPCt88Gfa1ufXE8wSj7mg2E4dPv2Bvc8Dn6cWh9u2U0k0m20
 cMp6B4Hl0DpdlZl82JXsT2Kn799ZJkfvekvgICHFFRhukincv/weJPYV55i4vXG9JlO3
 mpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3RRoxVdVTUCeu24UcHj/mykL3ggbS5JKaLspYh6bYnw=;
 fh=aE+wBCudF/gOybGiYNdGNsCMc8GX1x+3JHzzIbThrC8=;
 b=WSTCCTcbY86mz+ie0IoBg/iTOyqu4rz/2RRC6n3mlx/yUQR3DRFARa+0qJ6Jd0fAvP
 YOvyHRmdL0Z63Eukus4vXfTA3OxFJ6WI+9AXU9ROhSvv02iHMBiUAE3qSJmsUctgATy0
 JZtW6kerOCQbgjye7J3OAeCAitW2WVVlKOVW212LHlWfEYMaKxwH3iSxSxwwbYzgHkec
 Ni9XTrRXKQL4/q4C4035FAP8IH15y+PgecH5OZEmZG+Tu5KTN8PTc7tzWkYWRMuh7NhT
 shc1BKhrk1e6MMJqILMrLsn8gV7ia9fctqb6LvBpu75qkpebka1ez4C/3JLMeci8pmOa
 ru0Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785688089; x=1786292889; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3RRoxVdVTUCeu24UcHj/mykL3ggbS5JKaLspYh6bYnw=;
 b=oMLKWi74NQK/a1iZ5nt/lNAFStNOyUhSThQaF0++AVXOE4bZK0zRQzwdegpaEIPgB+
 xxwp0ub+EQRCr2YCuL59tSZBz610aB2zJzJg3ndIMJBtUPkBO7XY6Gk1VwEIjGgh8vwz
 fTnciLgSs+aStZc3T1fbdMJ6U4cLBGWS0TK3UegzS2nxZDfe7r7LBrF4it1pfAiLP7lk
 te8irMlIWv3V/JFBXmVzR6dd/NwRQNYGDMRiG1HudCRknSVc7nHcnV1DySvxMH1l3M4u
 bEWKSVe9+CfWgpOzPaf/+u+Mz6nfm5ge4j53a75UDj8tTGNgdCxXBb5oKzEWDzk2ByLZ
 onKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785688089; x=1786292889;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3RRoxVdVTUCeu24UcHj/mykL3ggbS5JKaLspYh6bYnw=;
 b=XyzMaFQMwnNmiz3KEg6PYm625xcwfZ8nxiprFlEWk3t780ZHIfaZZbXTZ5rtD49r3p
 4oMJOSYojohzyfBlAMBoUXoriemfoq9YHYw/w/pygEiasu13l8sYOn4XjzxGfAHLhKkj
 LIpzIzTAMtxMgBOV6bL80JQVR9I0UcQ+cPrch5xipxqXkCqYhgl8vmE+ZBG954ogIDnB
 20xcH62VfneC6+aM68E88J0tSIt8ntb5i3qW2Of6/OisA0lmdRnF4js4jCyaVr8C8txH
 jNIxfTJdxRLXH6UFT9VdCL5heQ2kTlpwtXGpp1wQXhDmSkFz9UTKNLc3mscB5b5VhZYc
 5h6A==
X-Gm-Message-State: AOJu0Yznq1AXGsz5j7QIE6f5KejL9UfdOuv7DyJ09Eah1oMVYlI2dIEW
 23hGKWKNwUcrz08UPLiiB0j52A7onnhkgeiXirQCLdue7+svKrxPqkL991M+g/hlIi1BIwyRFDT
 PP3+lDPp/7xIPq6yzz4PzTEAB9s0vxL4ASqRkygU03g==
X-Gm-Gg: AR+sD12Dzl4dfmVLUUY/axXpKuEfkZaH4/H3Mojf6uy8zZHP2MdvSLiD4+qTLse0Y7J
 IBVnnJnRB3VuWt8i+9ul8haMT9XdKUwXXJgu4568jUFcOhrTTMWCs93FKxQ2/G/4KgDpysWBL3Y
 S4sAOXo5U0Y4sUujsVnizfaWxONSHRN5hPZ2QWwl3512KZEGBY8Sh1dPK+/XjnjPlSzmr1HaLKu
 MpWw5yBDutMvFwdjhGBbfsHVkMjy1kjxPo1vxfSuKEH3MWhZ90p5N4Le/t013n2URZiuXpEJr1g
 We4R1qjJDF9sjGUaQ7F8dFedmGrbC92preX+aaB2qdPeMiQQGtOoJK8c7eZRW2nIBV5bcVRkmUa
 17ip8iYNJFibnLUNm2vMKT/kCYE6MMTvdJwitauki7kd4yETwUzK/uVpWXp0oAS4=
X-Received: by 2002:a05:651c:1602:b0:39a:e3c7:662c with SMTP id
 38308e7fff4ca-39f86404782mr12959971fa.22.1785688088313; Sun, 02 Aug 2026
 09:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260730173643.256052-1-kieweg.leander@gmail.com>
 <20260730173643.256052-3-kieweg.leander@gmail.com>
 <20260731-manipulative-taipan-of-symmetry-e20afa@quoll>
In-Reply-To: <20260731-manipulative-taipan-of-symmetry-e20afa@quoll>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Sun, 2 Aug 2026 18:27:55 +0200
X-Gm-Features: AUfX_myB0eIYVLJOrv7htov5uvEh6mjN4ZOlZvZ62FG5euIGbXECqK5Pr7tL988
Message-ID: <CAMwcS0gOXUZ5nd851feCGaBx3EWJ8Tjo8wKhGicSKaeX24gpdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/glanda: Add initial DRM driver for GlandaGPU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, u.kleine-koenig@baylibre.com
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

> Drop. Kernel does not print such messages. It pollutes dmesg even
> without actual hardware.

Thanks, all of this makes sense. I'll drop the info/debug messages on
the success paths (probe, remove, init, exit), remove the redundant
"end of table" comments, and fix the indentation on the
of_match_table line for v3.

Best regards,
Leander
