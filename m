Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DA5C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 03:38:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE7510F15B;
	Fri, 18 Sep 2026 03:38:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HshhdsMn";
	dkim-atps=neutral
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com
 [74.125.230.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3054510F15B
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:38:43 +0000 (UTC)
Received: by mail-qk2-f13.google.com with SMTP id
 af79cd13be357-93910c3e6b1so14833985a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789702722; cv=none;
 d=google.com; s=arc-20260327;
 b=JHosZdwIgmujHLM5Cc/N7ZVkBMKNmhxZTdck/VKeN0x1TSfEU6Aerzro75cYsojCv2
 rooF2fp0v9U5CUCASFbkMlP6PPqvDTmwzo1FTjBFHjinZ8KpcKOgFpGBTOEOt1DVA59K
 N8edOdd1tyBfsvsSfgo0AN9+zTmjI1xTqwB8/vXYW9x1QEB3T51hXkVFwG46Du7vqK5V
 N15N9qJN9W1TsgQ13u8c7qSPizHFMS8BmRVwFN+IzF+PowLTR1DKy/37BuhBJSNTNgoA
 6CVbgrumllCP+FdGDZUzrW2OFvQSp/T6doK+scM6M2McWRmKN9X4I3iMx8bfkwKejAeo
 2Xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4Ov6aFUtajD2x3CP751AsmHJB4mxaq0LPv9+FA/rt5c=;
 fh=wT1uCO/su3vA8EItN2h4IgXzje5i+a3acC5gADAebdw=;
 b=HlUwiZRFumFXZIekukTR2/s05NbyRuAMMKhFdYsLkl5Vwrqb3JX9/Zg58v6OAloEL3
 +B/IbmpD1zXAnupZu6qHGVInQLAf/4InlIvpvg5ocftyGAUw/bDXT9zvLmaEQwWplIMM
 1CCQ2NTZj+tyS4EYgFojF8hG9o54/XKhinRckeZSfqjeHx1ksLD9YaK0D7AZs06XjEH+
 /wuwhhaglyA75i+8T6HpNLLGj+sdWp9W9+qIQUcm4EpQaAaoh6YMztRkU0B6pBS/HR2P
 aI9csNYUcOurMX3se4d7aolYhQHT7rD/f5gVgjJolu3DF8sg+lKFGlTk0ttr06C9x3HB
 9mPg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789702722; x=1790307522; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4Ov6aFUtajD2x3CP751AsmHJB4mxaq0LPv9+FA/rt5c=;
 b=HshhdsMnQnbI61iXLhwzaHqvbjaV1ByLTmQtt1BEbNAjwZrVQ9/urrK1hZBbTsAjil
 d7p/wTu35yCqlciD1TvMTMf3qDrlbhTdrWHCUKRQTS4RM+oprwimOZaG84qfsLnOrZwr
 gBl4RKru7xKC3jIRM5RGeJWuXNSA9uWlKIuCgqg6oqfGb6qlMGe38/qqJ5HQM/cLlflZ
 rJnULzTs/99RUhVAZ1YIAuOarOxGey4TJHZICFFknKO1yoadKMVoVZorSGIdFMoMnCuE
 JHq6X5zevnuh5aoVKfiv0vgp6dFg3hoU2KjFTxRMeEsHnae+2qF+lS1LzCojf54nVR2U
 sWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789702722; x=1790307522;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4Ov6aFUtajD2x3CP751AsmHJB4mxaq0LPv9+FA/rt5c=;
 b=wADprTdw+vk67FQJ2ZdaUOKP5KRdvl++gWpXtKWriSfc9NVwsBVMHQVCsIHvD9KX/l
 H09QxRGHlZEqatd7/nawpKUZfYVcrdLjGlX/CRDI2x2iitmjz9iRDU6fVht3qHmE4IGz
 DPe2RgzUPz6C/SiHIumOqB93Do8Mz93ckeCyLQLniiGZFzbp9WGE2hGC1MqAF3iyP8Dj
 3lbOniukSL9l+1jrmmBsucb7UdMGO6pRcwhwz8UDPlb2iaDcLF9AbJUlZb1KhX+JSpT9
 +LzgA6q/z7ReL6PuNT3sb1ISAJ3hgoupSP44Y0r2febdoyFfFPLOrMfgrXJ8Q0/ug7AA
 GwqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLcHODsKt59CeTFe/52wRhYjT8QhHwneJmqbHIX2sqe93SY9xmTKEDN4U/R7CXAkorrO23YsbJ3gs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lgzHZJPdKzg5Op6/ZSc7QBAugkY28+SuQhYf1/khcG9gLbHdVM
 g1BYa9IM5t4eOWdWoU4MsKoyytmXj9klJw0JrGu8hLg6P4YJEy6aJVHJB9HCaN6jTxRQDex/tr5
 gEWRBSHRWn5NOLXFrW69XBahqMn5MIcc=
X-Gm-Gg: AYBFou2PiYMp33s5i5WJU5SW5WagIlIuUhh/FO3go1LZ9ygqJEwhv1caWbAgPaalHxC
 EEN5Ih2LO/1KZ2N0x1TY/Il5fX66T6abrVx4GU0Ctrcr6600mnajiTCwGh+ZcnESF9TS7A4EODn
 hg1whI+h/Zct+syVeWOyAqkA1zm9Age3T+B8HfrSZivJMpat0DwrsjyGvr4wsaZ02fdNjXBoySF
 oUQJ0O9KzImfpCeGiChXl1ZJO9OMTBNFfXzaA2hGoOjSEDYArChotBMGPAmgyhEHDDMUzM3LmC9
 XsINVRnAOsubXXrhBCXrO4MfmUcuGR2K9mzMuLhNUDAffrXMuyWnBbd1YgmVn7QCWhcq0psnK4Q
 C6FBqmovffu1UAznonii3IA0uLD1XCsp7TgBzZB0L
X-Received: by 2002:a05:620a:272a:b0:939:e129:c348 with SMTP id
 af79cd13be357-93bdbc1d9f4mr157765085a.20.1789702722054; Thu, 17 Sep 2026
 20:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-15-8dd5d4225d2e@nvidia.com>
In-Reply-To: <20260909-mmrebase-v1-15-8dd5d4225d2e@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 18 Sep 2026 13:38:30 +1000
X-Gm-Features: AcwNN1Wm1pTjO8Zn_ZHbQhmgXWGrtTW3gy9lIDVTkxKs3v48NgKYQAqx4Y5iLC8
Message-ID: <CAPM=9tweFRWWjCrkBKvR03BaRVs=N+-qw2ju0g-dgMj+S7Q=ZA@mail.gmail.com>
Subject: Re: [PATCH 15/16] gpu: nova-core: mm: Add BAR1 user interface
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Joel Fernandes <joelagnelf@nvidia.com>
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

On Wed, 9 Sept 2026 at 14:25, Eliot Courtney <ecourtney@nvidia.com> wrote:
>
> From: Joel Fernandes <joelagnelf@nvidia.com>
>
> Add the BAR1 user interface for CPU access to GPU virtual memory through
> the BAR1 aperture.
>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> [ecourtney: map BAR1 in NovaCore, borrow it in Gpu and BarUser, no Devres]
> [ecourtney: update for the VramAddress raw API and gsp_resources chipset]
> [ecourtney: drop the owned GpuMm, pass it mutably through map and release]
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---

BAR 1 and 2 need to be optionally detected and used. At least on SPARK
there is only BAR0.

I've been playing with John's branch on spark and had to rework this
code to make BAR 1 optional.

Dave.
