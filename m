Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E37C5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A10E610F250;
	Thu, 13 Aug 2026 09:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PIwuljl6";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B35A510E3BC
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:06:10 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5b01910b499so768023e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786536369; x=1787141169; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jwQe5AqkZRV6AycdDoCBJdkEwP9l6TMebpmQtJszUio=;
 b=PIwuljl6Z5QPiqwJUu8GZAsK16v8luMbicA6zIfnwdB4dDa6ABkDV9I9zcjYYcuEDj
 E5dqTN5hV1AkEcCGnu1co/tvgFoUQWgPDi+1g9+F7YRk7du5g3OzCSSr6M2J2ClCyFuv
 FE5ncIvaBCvbkxaMcjj1+Jz36/uPxLmjdYG7p3RkouagTOsx98oMpWKUrSoJ8qE2IgIc
 nicaj7oRaaidG+rhQUXcjypHhytH7GWf4+Ojr8QHH+4kPsloUw+G3ne6j/u7d9L84S5E
 IIBCMgo6QKQ/cUH+DzgQHILeYt7z10QVanTjhh66XixyAfG5/zWy5OeY/T96nec5zLtn
 JnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536369; x=1787141169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jwQe5AqkZRV6AycdDoCBJdkEwP9l6TMebpmQtJszUio=;
 b=nClTAN3clPn+/W3eSngDSWWu4/dCDdNOqDD3MRQ0RN1N8AdxQ/Gu13CRfQYS+qh7xh
 15Qlgw8Rp2R0/tGD47amhwM1/MhzScVtqWScb6Sgr+Y70HdNkAiGIDgdE+NincC4dOY/
 4m1J2pYjlL3sbdZyPCaL6lKUT8xLF3bGugXPja4BiA6OqQgxPhxJjlj6OK85eKODjpKb
 n86DyYjZxMntWDB0e+cH7oSuhvPjAecycSv2pSCvfkw/uI1wWuveJvdc0WxagpHLGWb7
 hr4++tFMp6wFtRKs3vYgD5CFECjdWovF2hVVB5TW8kHG3mtrR5f719vS3Ezik9QRdK5J
 wIkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfP19lreS6QHjS/Vebsls1cStgQ1r+kJRlHHoGEcZc/PQmAZT4Aj6slbMMHJ6TvCKVPfk/5OC+SQU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxhg2dwib57V3GCT+xmyBZANiRZfmN70YtKYQwffnSvMZW1Ldcn
 sw1GkfkheueDUseP2KCTvlUX6tbg4UQfx+arTaKn4h6lur20j5ekYyut
X-Gm-Gg: AR+sD13/uDk2pULRu8ndUYMnUpKCmRLjmuLARNDSZ1a1/ccuQuUGzq1P2Ft+LtKqlao
 hNd2lxiEmovS9EM0M2cXMqd0aYoRbKqi1ODH0K4UDCMq/w1i//8cWVm/hqYhdV+B8oizDe1unvO
 8uJs4kmt3ZXyUeK3FPmLEKd00OkSnMrLe6BYm3BguuD1qYvn4aZyOACWGnRdZQ1dGAD78K3iqdA
 4Be9eTPRpN/gPrftdBPNV4pvlVuAYxIQF8VlKVJrVHRJGKB2/OaXikGQagc/lmXgi1JMVx58nTP
 IAgSBBY0VISICs40aAMzWMJD9g4iL6VXVb68cW7xEYjzewbI6MOXMJpjTeBTMpOWtM3MI3LW8h+
 /xeAMTFyiMKd3IVGc3Z7yRht9Ojemz7zMHOnpwKnOa14l4ywiBbKnNubMyMJfPr4Wg7JjCkCb3e
 eM/KMfzFczYJoipHQnpqD80yYJrrbH66Y/xOBcMv6+hwyj4Hrc6ippdpUErlTp75SGYQ==
X-Received: by 2002:a05:6512:a34d:b0:5b2:aa5d:9ce7 with SMTP id
 2adb3069b0e04-5b44bb2312fmr944010e87.10.1786536368688; 
 Wed, 12 Aug 2026 05:06:08 -0700 (PDT)
Received: from localhost ([95.190.105.95]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b44d04903esm447818e87.76.2026.08.12.05.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:06:08 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: sashiko-bot@kernel.org
Cc: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
Date: Wed, 12 Aug 2026 19:06:06 +0700
Message-ID: <20260812120606.191456-1-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812113752.532537-2-vladazaharova2018@gmail.com>
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

sashiko-bot@kernel.org wrote:
> Does this code need a memory barrier (such as dma_rmb()) between reading
> the 'put' pointer and copying the buffer contents?

Not in the path this code is written for. snapshot() is called from the
drop path of the log buffers, which is only reached after PinnedDrop for
GspResources has run the GSP unload sequence, so the GSP is no longer
writing to these buffers and there is nothing to order against.

The one case where that does not hold is a Gsp::boot() that fails by
timing out: the GSP may then still be alive and appending while the
buffers are dropped. The copy is best-effort there - it cannot be made
atomic either way - but reading a non-zero 'put' and then reading
contents that predate it is indeed the pattern dma_rmb() exists for.

I am happy to add it, but there is no dma_rmb() abstraction in
rust/kernel at the moment: sync/barrier.rs only provides the smp_*
family, and smp_rmb() is not a correct substitute, as on arm64 it uses
the inner shareable domain rather than the outer shareable one that
dma_rmb() needs.

Would you prefer a small prerequisite patch adding dma_rmb() to
rust/kernel, or is relying on the unload ordering acceptable, with the
requirement spelled out in a comment on snapshot()?

Thanks,
Vladislav
