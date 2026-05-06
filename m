Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E50CD3427
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 01:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AC510E4C0;
	Wed,  6 May 2026 01:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T6BuRyxC";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7511210E4BE
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 01:42:26 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8ef2118b478so587137285a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 18:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778031745; cv=none;
 d=google.com; s=arc-20240605;
 b=NbBcPrRonrQarIa3/JhiHtn0xIu/0+8fZk9is7p5lP8kXg5xWZp4OgNCxtc896s3LF
 G83/FvzE3XQ/ZNG+E5UE1M53ubrOKdbB+yyPo2Zi0znRegegSBVkFrU6pZ0R0M+sgRbV
 gE63R/vZSfqlPyYwjZfLEyCnmo9AID5B4M0gZjtI2pUfLOVS6qHJ+cRsM9jkviSRd/og
 PQivWJLNOtEtFHeOXS9wOzPIAxcfZ8eaIacy4KtMxKpFSp1vxFmEoCC5yoy5wVG/ZYdO
 u0YBjqXgchH8IQbYeU2BSvxgmWdJkk4AHCgrICKOsP6hotapaMhcrfjrABo21AFK+ErC
 vpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EN3POji8Ptv8pq9FbWY1N6uNRjXtcQOLJtybMOZu3UA=;
 fh=VQUGu/V9GuLWJlFSAkbpdxyqhzrV1gwedBxnYKsiDoA=;
 b=exZp+dKs/vo6DhoRXJclQGpjDaXCgKNAm0RzYdQ+F07jPNe9hXggtzRf7JIgU6pdnj
 GTBvzb2wP19yea8nfsdKRCeG64+0hDoUGxrusLzcyH6qpqVZ9TCh8QFrc+/qMqyIr+0T
 pMm/Z0hFS2MD6nonQV2kBZB+0VRFSbZZbhflllLJKmaxEpdmfy6Xlsb48Nzs9XzjXf8+
 NzqIT2eLyo+DkDtI2sjd6vD+ybvp0GQ5lqILoJiE7s2iO9tyfj7fbtKrKkoan0a6HJSr
 IvtOkTVAjICs372o5OBhSaiWOxxwT+tFM/203w9goPI9IUtYjLz5/kW5AMf4WX9EV89/
 6IzQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778031745; x=1778636545; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EN3POji8Ptv8pq9FbWY1N6uNRjXtcQOLJtybMOZu3UA=;
 b=T6BuRyxCgtkqnPrxwymxZunOs3Z7e4P7XatenSTt0c2+lGfOZVS5afar5btJFtyQEl
 v3JQHGM1AViu7c/VO1JP9+eJnQ5jWjesJ/wBQ0LlJAg7oAb8pcZt8ygyRKdL86jM5Ez5
 jJeSR5QZKGEnpzCkoLvcnQlXCLKT0dFz2YWOPUoxUxRCldYpMCHzdue/3piCQCwfm3OR
 1e6N/CiFMEWGLQSzAZXG8magwN8HXdkL5a0zRsGCFx+MBwrUecFw+ob6ap9c1BPlNZUw
 rUlukJmJxekLIX77qMoqhqRI9VLVWnxzLJXKtsnJTrSk3lQeINYXTjO2eL4sov7ebCIE
 eymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778031745; x=1778636545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EN3POji8Ptv8pq9FbWY1N6uNRjXtcQOLJtybMOZu3UA=;
 b=DQS5AkZIHA/h34ZojoJ8pa/XIJmH/krscRqs3ElVli+ildJHaUBppG3BNQPG6NefZA
 6NdxonCzAVZHy63DMsIP+Z0kHQoCJk0muYbNJo7XAiA84K5IK5JeaOcK9A5eJntADtgQ
 slqTd+Ao/88ynzW4wcly5ba+xbzUvwmntB44Mn8vi/P+P3p6VDIK4dUUkFrayQ90O0JF
 Sx69Bohafr1XxGbKPtCm3SJAUoloLdHkBhhIxTt3i6faFlVa5bOPiqmrAmeF7GIr6ks9
 t3Nn6QKPEppIe7mW9nePQzxPKkz8bLzLusfeTIxhcsfammqeuzCN4OqOXTDTcNydKuUw
 wi0g==
X-Gm-Message-State: AOJu0YydiRGW1KOU4eyGIGgw+UzIz7x6l93x/QrnAAV7+UdoiOc9yuw1
 YwTdforCIz0NWL1Zj1pIf2g/rqTxetxEirw9QT7r3dAycPjwI92mWfJqPW5EMahuQX7MoKFP9el
 hPSElXLRfblIQUUkAtFys6uWch36cBOs=
X-Gm-Gg: AeBDieusFnaPzTvCpqndNfSjct3JZg0I831YF0aRDepwGI6Y7R+oUkWSTCEiF0ZdkXp
 GGR5WhlRC6Tar25goNFCfDFdbXmGclQKCakKVpcoAZnVenxoK7lMvpi7/I0cuDB6Ny4Sjxk66j6
 O3qC6gjV4ELTwkpPUOfhULvS1NESPzuqg9j5VJ7xyn0tOKG/oQVYD8UoHBp9R4egkCSIE57r6ce
 Evo03LPe12lDpyIIZth79EC1fSe9ijmyWE9QR/Ix+5v6wNK0BUW9nJ3wt92G8H4q7VX/p0GzgYW
 Gveq0uATyt6AzGPwbOiV6AsXlh3R4rBdow+ycf7e3L+zl+pnfkay9H89qM7JQtpVEyFpFiukEQb
 sNg==
X-Received: by 2002:a05:620a:4594:b0:8f8:8860:fb8b with SMTP id
 af79cd13be357-904d69d9e87mr244631885a.52.1778031745287; Tue, 05 May 2026
 18:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <c36e7dfb-cf62-4d21-a3b1-f54cb43e0832@infradead.org>
In-Reply-To: <c36e7dfb-cf62-4d21-a3b1-f54cb43e0832@infradead.org>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 6 May 2026 11:42:13 +1000
X-Gm-Features: AVHnY4J4iD5smXrIpAMHJFcsa01tqBk4AJ9BDVgb7geE_sA9sedvb_-AQbfyQag
Message-ID: <CAPM=9txXGY7Pv7ge-x3roA422c=Ycefc7Ens20dEiHuKrKR=3g@mail.gmail.com>
Subject: Re: does DRM_GPUSVM require hugepages?
To: Randy Dunlap <rdunlap@infradead.org>,
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Simona Vetter <simona@ffwll.ch>, 
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 linux-next <linux-next@vger.kernel.org>
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

On Sun, 3 May 2026 at 10:03, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> In linux-next-20260430, I'm seeing build errors on some ARCHes when
> DRM_XE=m (probably just "is set") but HAVE_ARCH_TRANSPARENT_HUGEPAGE
> is not set (not selected) by the ARCH.

I'm seeing this locally on my arm32 builds, Matthew, Thomas?

Dave.

>
> Does drm_gpusvm.c require hugepages?
> Or possibly DRM_XE needs some kind of restriction?
>
> I see build failures on ARCH=alpha, ARCH=openrisc, ARCH=mips (32-bit
> or 64-bit), and ARCH=arm (without ARM_LPAE set).
>
> Example:
> ../drivers/gpu/drm/drm_gpusvm.c: In function 'drm_gpusvm_get_pages':
> ./../include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_361' declared with attribute error: BUILD_BUG failed
>   699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                             ^
> ./../include/linux/compiler_types.h:680:25: note: in definition of macro '__compiletime_assert'
>   680 |                         prefix ## suffix();                             \
>       |                         ^~~~~~
> ./../include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
>   699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
>    40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:60:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>    60 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>       |                     ^~~~~~~~~~~~~~~~
> ../include/linux/huge_mm.h:113:28: note: in expansion of macro 'BUILD_BUG'
>   113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>       |                            ^~~~~~~~~
> ../include/linux/huge_mm.h:120:35: note: in expansion of macro 'HPAGE_PMD_SHIFT'
>   120 | #define HPAGE_PMD_SIZE  ((1UL) << HPAGE_PMD_SHIFT)
>       |                                   ^~~~~~~~~~~~~~~
> ../drivers/gpu/drm/drm_gpusvm.c:1560:52: note: in expansion of macro 'HPAGE_PMD_SIZE'
>  1560 |                                                    HPAGE_PMD_SIZE ?
>       |                                                    ^~~~~~~~~~~~~~
> make[6]: *** [../scripts/Makefile.build:289: drivers/gpu/drm/drm_gpusvm.o] Error 1
>
> where include/linux/huge_mm.h:113: says:
>
> #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
> #define HPAGE_PMD_SHIFT PMD_SHIFT
> #define HPAGE_PUD_SHIFT PUD_SHIFT
> #else
> #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; }) <<<<<<<<<<<<<<<<<< line 113
> #define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
> #endif
>
> --
> ~Randy
>
