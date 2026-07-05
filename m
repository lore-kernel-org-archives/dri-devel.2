Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A02BC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 07:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B1C10E15F;
	Sun,  5 Jul 2026 07:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n8RZMW6Z";
	dkim-atps=neutral
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 888A610E168
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 07:54:10 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7e6b554044fso1531006a34.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 00:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783238049; cv=none;
 d=google.com; s=arc-20260327;
 b=aSmEMv6XwkKq2RHItrmlLP4IeTuvudYLmtT/kBWtDLkw/5xNNECZIL0vf8YGOp0s6d
 nQPcBTl2n3kXYVMemgg5zUp1/4jtcD72sYugunftqyoJJQoVQqIOcGo9YdPhnzt4bP/V
 ODzdY9wKbzJllSZC2DCD2pNHhMXIaluJfxFb26VrfkdmQFEj9bSdvx+zAXna8FisJC52
 nM+Lb2NJT/ndbBjvKbr9N1qRokKLHUTCAel3ZOLsjOKWxgB/yDR2MBrkyk2PjzsyxHeM
 fAC7eYdaGHfH/I8XoiMcWR8I6shWN55bF23NUhKN/6LEtVsBCtcKVOwd0ScmeOTMEAS9
 zBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X6ie+zgxRlqbyAzxRIkAU4hEpl89kwbGUKktPQzzkS4=;
 fh=vc7Eewn6uqteLLRl51bOTsccbSVBXrE73B3JvEA4w6o=;
 b=pqlvCsBINN2nq43GeTcw1DhgX+UZu1M4eq9oDIXur16o5/kCY36UXqhu/ZXbaNcppS
 oAD5EjE7XAkEw0CcQapokNuO0t3IpFMs3iMexGtjq4VG63wZ3YeiwOEbPB4jVXY9uOlP
 dPD6E9wqbEt69HZoEx370j2mB8bmvIkfHFl9gQJKXt/hJzMMVDHOVueaV380VgPidesD
 zITAc2np2lpUOZiyMnGvKwoKuoqncJCdKIXMM9UUFfH3J1kpYMc9Svxyc/onmRbPPMC/
 bOePTEYr8LpOAkX+cB9w01zwai0hazQM3jHIRUcm4MTyFesqT22kV6coTW6Lo5Rc1R0M
 p+/A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783238049; x=1783842849; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X6ie+zgxRlqbyAzxRIkAU4hEpl89kwbGUKktPQzzkS4=;
 b=n8RZMW6ZtS8vwB+otNSNLDAnK/NqFOPuvm8TDv9eayRdr+iXj7idm16KRuYttTmSKU
 pEKk/D3VXeInnhlPAorJO7H1fMI0y2JyNDe9UT23ibDJg/HCw9M/kPaD9Af3khSXrR6f
 Li5LvmuQyH3zpTfPkbjCtP3DFjT7dZrwhoAfdobb26mQt/sRSKoF4jUWgFPVartGiEgm
 8lo3DNSEMdVbgjDAkd2AuT5/NPqoH6UvlfACoMdni0aG2JNVh5x6xmoUdKuVn/aflZUy
 +yyU4rPvIFh7VGDjgwCsJrL0BGvm+nVY697+P+/hf8LMInhvX+u1QHYT6ekmbSMViCSf
 vx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783238049; x=1783842849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6ie+zgxRlqbyAzxRIkAU4hEpl89kwbGUKktPQzzkS4=;
 b=gI1TVNnYty5SneK4xCzJpsE10RM1fefIjF6kIXBj/3gUjgjYCNipLxWkO2UtwJtCRU
 DaB8rJC/d9qZm7Uz6OqndJjajsv5+54JLQbs/p0lWIPA5alVqi3SHcgkUJsWxOzimYhe
 RrWK3zSHUNzMG91sW0a7vPxinsnyKmDZtNPtqqeG9w7u57QeyxetQGmqq/9XE6etakHY
 rBpG1U6ZzzzQa/ym00sjilykSMOFv0B/IJm9qmp43xXgpdAS+uiPrpCU92PgdjgehkCa
 s7maEhqFkbz3yYGmfyRpTFT0b4KRzSjwjln0wIfU+a3KrfpSmSACrXDQ6isXqQG8cxnA
 KxwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ826a9cKTeEM7KraTWbupIHxEkrzqKVXresn6i7JVKiE58G4i84FAAFEsK4ENyYgx/Xkjo9GQsSIZw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQsKg3+9QYg+v/CHoE9/c3k4b92pmgGk5ejxTk5JrnfED+IVxM
 14lVPs7zVLoLyqti2XR51axTU5H4vxjHEvPb3smcZh0/YY0Mp16deqq+DMHxAhIrf7Ip2HHFRCk
 3NsgTkCh6MqTW4wbqOp7bdkIB8ZBraH0=
X-Gm-Gg: AfdE7cmNQgPYXrCapPBCgr7Xdym0NVj8kSySy5BGdVr8tZL0nILnPcx0mKhKZhjZxsx
 F/hT0DDjp8cgolAR2IZ3ylBwh0hV2McYKkQcxNg8iyM8BYvz7x4aQUzfnrB7h9rHDdRRMZfKxuV
 q5U07WFa4fbi5nmUKOm3JOcsxSDYJXNLUFZOidhaINx3yN4jKaJnfaKiF1Tqim3iTnleE2Fo7tI
 Lq8ohhXPK70zeuuJ1nQbYvfo2RnfUrXDMOL92PMoL7ROhZsRHIfMd/khWZgtm2dHzV4U+XeUhl2
 11ukwZU5
X-Received: by 2002:a05:6830:c0b:b0:7eb:6891:c372 with SMTP id
 46e09a7af769-7eb7fd44f08mr3780839a34.13.1783238049452; Sun, 05 Jul 2026
 00:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260623-exynos-drm-simple-v2-0-a8d59678b7d2@gmail.com>
 <CAAQKjZN12OSBg+ch+xf+-uO6_Sbrtq-o8AkLdLA3mFQ_ubiLxA@mail.gmail.com>
In-Reply-To: <CAAQKjZN12OSBg+ch+xf+-uO6_Sbrtq-o8AkLdLA3mFQ_ubiLxA@mail.gmail.com>
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Sun, 5 Jul 2026 09:53:55 +0200
X-Gm-Features: AVVi8Cei8vAjqwK5-A1ihBt88FWQH6IBM5O7QlOt3ukYNuXYArJIbJae9dKPeOY
Message-ID: <CAJpoHp48cXPLrwvANAt_-D-jE=DcSyodAL=p36kQw3cGtQW_fw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/exynos: DRM encoder improvements for Exynos
 devices
To: Inki Dae <daeinki@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Inki,

> It looks like you may have forgotten to post the v2 patch. Could you
> please check?

I think they are here:
https://lore.kernel.org/all/20260623-exynos-drm-simple-v2-1-a8d59678b7d2@gmail.com/
https://lore.kernel.org/all/20260623-exynos-drm-simple-v2-2-a8d59678b7d2@gmail.com/

If I did something wrong tell me and I will re-send them.

Thanks,
Diogo
