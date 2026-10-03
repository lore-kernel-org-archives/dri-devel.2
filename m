Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907E5CA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 10:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B083910E3C3;
	Sat,  3 Oct 2026 10:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fFbNmxlM";
	dkim-atps=neutral
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D839210E7C9
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 10:55:48 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-677bf06de21so258153d50.3
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 03:55:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791024947; cv=none;
 d=google.com; s=arc-20260327;
 b=nM9KU0640Tf2nLiQjeAWfoAFNHSr0dAUjYfHuHvBVJIEresJSYA5Kbhzen66PyUO8q
 whqeV4rkjpFd/S3pu6hyATitmiKTKbKTMzWPD+4Q6mJS8JYNc9LF2hzb5MoGCVCOGL6s
 /x+HmhpQGHNL/Pq+PEBzYBIGztF6uutQ8eZc+Oz7qWfrFR74UiW4dCmNlbXXxoHVlK2H
 DG72P00hwj3zCRT9dHAhUAWTNf3WcUpPcM0VkV2A1tolbfXY76hCIJjvES1pihKMV4YL
 4Z8zv2iNJeMr1OIyAsu238fRlqVYR/0Eu3XosWNYtjWwueLt4kFNgSiNbdhzq+Uq7QKK
 QVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5Hoplvp4zRZKaEo+Yo3JBF1Ab6jSR1XjM/Ch3k4K9FY=;
 fh=i4Y4ijT6AFAU26nVXC6FCRdLg4c/FKawhnMjBD2fPzo=;
 b=aT2j75Q4B/T4Iyb7BVf7xzafbpe3YspIyD3iO5gQI54Y7tueDh5Jkc2kjy+BM/GYpd
 vKapQtdXXfr2egwiuvta6PW3lxxOL2yKUVbib5W/NcHqy7SQvkEEXCCJCN7IRQYGq22P
 qteo0797uEg/ncu+UtS7pd/R3SoDpzgdynW5rjhlj91r5ppfA02t5O0kmf9zES85qDI0
 YtluCvviLR6heGHco6NeekbcTGHkHBZalJh3g/ht7yFNdgKlSj1k58HTKO+xj7JtCz8y
 Y6AHXIq7NCL+djnqTwKVgX7MNY4W+c9LWdhe38XB6qOs3nLG3YMWyOGxSY2betuWyUsR
 8++g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791024947; x=1791629747; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5Hoplvp4zRZKaEo+Yo3JBF1Ab6jSR1XjM/Ch3k4K9FY=;
 b=fFbNmxlMFQwDWqopiojvgUm6OHiqcJS0MYVsdq4qdKqsjFwlDZC2XK9CTHMWtbC9ZA
 npxUdUk7nLCpNtzYIl56Y6EabC+D6ga9hs/fW5g/bBM/lcoN/vnMSMww6T80JV/AutW4
 i2KU+r6JuLHKT1m4KEIcEdXsejT0N8haUbp4mc7+C6tmXjlyI5IkKDWE1vuOh/AG6Vrn
 TwpY3clVi9gRP0oah8rUf0IjnVd5710rW4XniupplcVqwk0rwyz28ivhzlAFhzPJDEwE
 0IdSM8TX9pWixnTG8BxhnThH6KGn8K2kvxkTNVL55Dt2se8F/a+z7m41K9A1rZQ6N6jQ
 BJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791024947; x=1791629747;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5Hoplvp4zRZKaEo+Yo3JBF1Ab6jSR1XjM/Ch3k4K9FY=;
 b=nKiWIoIlARheIr4QiAV9tNFZ5FU3rWixVPjVvovXo0wlXB2GARbI2np8QrfWRX+iIZ
 B09e02tpGDvXR6In61x+zlc/fDybJT/hrkV2d2Zr+IIl1ieuBzL/qnsowX0UZoCJ4uPU
 ECPQSZWmBZHbyJXNNZF4kbGAzp1a2ByPT3DwpgisuGlqmlFIS1FJGYM/bHlWxJTms8RC
 /PSKEmwqvTFEMbsP3EDq1x+uxc+VIBtKweoI/3C96D7UAerKKsNgDuuaR85M5dvzq/Wa
 IZs+XG/5PqbRS3pt+oApyA9P9oGSbFamjQxHWR4u/iGauqCawK3ykAnXI4ziPVt9O47H
 jo1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxehWHkI2hyGwTs4BO9rxNcK30IkyRyWobFOQXmQZB5kDpR9dU27bgsqQkfSdYY+C6SVdCldNbtMwc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKlYkekZL8YAczyeboimy8sYl7hQIYT0JPgR5RUBj8GBcn44bAT
 sKnE0LqHa7iBd13fJ0TVXSGv4gHhDi/4wwWDNHRBk0uU2h+RoUUaa6bUNbOG0hsBmFeCLX8aApG
 Usy7oGMkYgbFHOwts8JNMAqVu0YRclMI=
X-Gm-Gg: AYBFou1ivjTbpBku4zxDY8ZVefzTShOOs5IdHXChZQtZ1O+uy1n8WpjZMYRivGU76HX
 ICbVShRDt8PAUM6Td1WopkWUw3Mon1s/xJyof00svnPPaf2fJM16qxihAwanCDZZwdnwD3Ix8rT
 PmPHO6cE//c3udInaxZnE/IHtUggqY24hUkbmCh2XTaE0Z1FNKrPSY25ttf/CQbn0uSi3nelDyi
 tuy6ZyxjBar3VZsjUTnaCGWdtL9QlyPTwyII4nJ3nJxhdEpuZt7UNak+B6Np/QlXGLV2eYjAaUV
 yxDQoyjD4cEnrApjRzs6i2syHnjA9QDmYJ0vi8/ee240Tnvts8FTHA==
X-Received: by 2002:a05:690e:11c8:b0:677:bf19:f0a0 with SMTP id
 956f58d0204a3-677bf19f699mr492292d50.90.1791024947570; Sat, 03 Oct 2026
 03:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-b4-include-mmu-defines-only-in-mmu-code-v1-0-291eadfde23b@imgtec.com>
 <20260930-b4-include-mmu-defines-only-in-mmu-code-v1-1-291eadfde23b@imgtec.com>
In-Reply-To: <20260930-b4-include-mmu-defines-only-in-mmu-code-v1-1-291eadfde23b@imgtec.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sat, 3 Oct 2026 19:55:36 +0900
X-Gm-Features: AclHuK8SBcDcAw3IjrnUcRnWC_HF1LllwA82Z0gOcS9YWz92DsLbCevsVm-z4Xg
Message-ID: <CAKbEznsnKevHokY-ip6g7+TG+NQLJcKxaYEbqsKa47dM26s6QA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/imagination: Switch to kernel-style MMU defines
 and access
To: Alexandru Dadu <alexandru.dadu@imgtec.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Hi Alexandru,

>
>  /**
> @@ -442,18 +424,18 @@ pvr_page_table_l2_entry_raw_is_valid(struct pvr_page_table_l2_entry_raw entry)
>   *                        associated with @entry.
>   *
>   * When calling this function, @child_table_dma_addr must be a valid DMA
> - * address and a multiple of %ROGUE_MMUCTRL_PC_DATA_PD_BASE_ALIGNSIZE.
> + * address and a multiple of %ROGUE_MMUCTRL_PC_DATA_PD_BASE_ALIGN.
>   */

nit: ALIGN is now a shift, so "a multiple of" in this comment no longer fits.

Reviewed-by: Gyeyoung Baek <gye976@gmail.com>

-- 
Thanks,
Gyeyoung
