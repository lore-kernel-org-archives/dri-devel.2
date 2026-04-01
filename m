Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B07FE7E351
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 185C010F437;
	Fri,  3 Apr 2026 08:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yxuTEj9v";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D24B10E292
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 17:33:31 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so69134585ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1775064811; x=1775669611;
 darn=lists.freedesktop.org; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wUGrmWIs1eqe1Uc4sRH3g6ZJwCj+Y/CkFLvTuPn+h5I=;
 b=yxuTEj9vr7iaY2Q/KU/OpHqQBiHItxIY0J8BwsWfe7M7MOmwFaN0zbkkyWKimYrphT
 JNCoYwtzBrhtboYnw2TCcvfao837IfKIovuUHZ2slliBD/nRv7wKue8IRHQUx4Sfuvs5
 D+wy0jsdhTZh98qqzcOx4twokn2KuU7eULG6ebI/zgLtUNIlBXLbxWDTQU0n9FmP/d+n
 Iu38GeeFdlWVfV02tv1xpK9j5E0P2LcY1bIPfP2VsI7i+9Fi8NydWS/CpQvbP3zJDota
 pXRfA0+KgFBB/kR0x2oXBX0zxDLqnn917UNw9+UgICm0YOKWCv9rGZitI15kMYTiA9Y3
 x87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775064811; x=1775669611;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wUGrmWIs1eqe1Uc4sRH3g6ZJwCj+Y/CkFLvTuPn+h5I=;
 b=ar2TsVwFFEL1PXxDPGgVU8XDuwDJ2y8Q8l5G9i2UXN1HigQk58kFbhdKC1dJLZpJPe
 EANcQOLEZrrzmAU99lnqIcK9UPFSKhGRj9pBlm3w3z4pWQJGBhUIZz9HbDthilDd99F1
 Piyj6Zq/sXngb1ksQKrKl3vu/OeSOjmKSDVKrBxwsOTFstEBoWOUlSqcsSAotHUmA3rH
 BA9cfuMYli8gG74EALt0Hm3SqLoNf0SEE0tTzB2ZMf4Tm+VL/bRkXW/qJGnnrutl+2Qk
 bDeURa3c/9B2vFEVzwxXSm89fI5kcraL7iEeC+lp2KnK0ypSwVydd2kEQoCspFO/NS/n
 c7Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUolinNDospblgCv9yfMW/cfGC/nfiqz3rstm+ZuTmMBgSzq67AQvmpCQAZa5C4rDnZdSB2lbJdZ8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1CPzOWRwSW5RNUzh1/W+wmHWM7gZ3EmA4lxKnQlZmodYqWZIr
 fdWWdygdHVmAI00GqMjeqzPtyCVk9Rf9Rm+XXKo1NJ5xvh8XXtEETln8NUKcxvTVGz4=
X-Gm-Gg: ATEYQzx1HZN4HUMTHOxPav+7+Yaxz/yIMJ2038JUFwUpaETQ+sVZWm9JuIT1BkfT+YT
 GI5Rr9v8sP/KMVbakfLfkc5LDt/y9cPSoRnC5QjwZRoJg2JuZX+kBvONtLeQXS1zKQE7bHx0Pm3
 OII5djH//a5UzeEAMY5P1zoRFtHiThaIbzMi0aFa7Iyr0bNop7Q5ohtzlQ7g1rHcgcITWoCgay/
 Vf0KaSeNBFZWm/6OxdzFTePxxE/V9jeCQBLLF8ftY7NGT/lVKzHyLTHz5nbFznZMh5pzEFbtyN2
 oy2Sl24Ck4NF/wblvKO4uJpbLh1vqjGZFtmr8SytSjlWjTv9xhSfa+VBxqImELgosbR/gYymNBv
 s2l2rEl+UbCJPJAMjSou2AteOl7BZIRqC5rtJ/uCAUXWCHQQ2YVWpDIGSWzeeecOHu0EsK447wn
 BpAHH6H5M88s75JDtpq4o=
X-Received: by 2002:a17:902:f54a:b0:2b0:6e12:bb21 with SMTP id
 d9443c01a7336-2b269d4af02mr44706185ad.41.1775064810785; 
 Wed, 01 Apr 2026 10:33:30 -0700 (PDT)
Received: from localhost ([97.126.187.42]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbca2sm2974705ad.73.2026.04.01.10.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 10:33:30 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, linux@armlinux.org.uk,
 aaro.koskinen@iki.fi, jmkrzyszt@gmail.com, tony@atomide.com,
 andreas@kemnade.info, rogerq@kernel.org, arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, soc@lists.linux.dev,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] arch/arm: Drop CONFIG_FIRMWARE_EDID from defconfig files
In-Reply-To: <20260401082533.214103-1-tzimmermann@suse.de>
References: <20260401082533.214103-1-tzimmermann@suse.de>
Date: Wed, 01 Apr 2026 10:33:29 -0700
Message-ID: <7hcy0ivb4m.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

> CONFIG_FIRMWARE_EDID=y depends on X86 or EFI_GENERIC_STUB. Neither is
> true here, so drop the lines from the defconfig files.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/configs/davinci_all_defconfig | 1 -
>  arch/arm/configs/omap1_defconfig       | 1 -
>  arch/arm/configs/omap2plus_defconfig   | 1 -

For omap*_defconfig:

Acked-by: Kevin Hilman (TI) <khilman@baylibre.com>

Kevin
