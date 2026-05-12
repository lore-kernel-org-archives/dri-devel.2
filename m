Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A42CD4F35
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 12:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9FF10E09F;
	Tue, 12 May 2026 12:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="f7l6zDQT";
	dkim-atps=neutral
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B3D510E09F
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:58:23 +0000 (UTC)
Received: by mail-wr1-f73.google.com with SMTP id
 ffacd0b85a97d-441243ba35fso4444453f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778590702; x=1779195502;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=vDWMnr041UI5ryil+k7XvoK/2F/EkGtTQwaeX0kDxi0=;
 b=f7l6zDQTvSl4f/H52E3LtWotDkkn93MrF2GlTj0NyWqVi2yRW5L3rMVfvatTeAZyDN
 UpcTedIZBBwssrA2YorVfafno95KIB91XiHYDEl/zE2paPEnR4o3swc0Pc1/l4az/Vx0
 xOYPoEk2HMfyZJq2fWjJX+xCTq0AUcBEiU0vZEDdPE1mGlVWyG+3bapG4ijL+sRyogRs
 /+DNKnCe80wbfBfmsSyYDZ1H6vNPcvherrwVq+Yt7kI74MPVNJ7v7ohzDBLQSKzFpGzZ
 loqWhSqFeGtKw2YMsULsNS8yAQ/vwFL3NELDzZSe1HZlOLE2oIbeJ5+nwgsR8po13v0u
 sd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778590702; x=1779195502;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vDWMnr041UI5ryil+k7XvoK/2F/EkGtTQwaeX0kDxi0=;
 b=gREdg4GO2gG+sLEZQEpFIDfSZWypq19fco6fXe9zuWfVfpvfOQUHuzlmOmCLKIx6Lj
 cflJ3Q8JM9I/evdkxMs8XYFFmKBBHJh8PQc6/Mz9k4svniTdbLCHia99V4+PMsc+ah5u
 v6anJDCNhm9hwMFjjJ4TBM1tw4PjCDk0qVpQUUYPyQDuv25AHswHKrm8NjqcY3h73JN0
 ypVIruO2Mwk7z1SPWV0PaY3EOllhEEPod8Po4D3S22GTa1itC/On88FsGPopeLfuuxyK
 miaCRlgoc6fULdPEI6M3buDzU5io2ic0qQXpCVNpwzAP0kkxcxhX6W3yJf0zAbWADWPN
 eC/g==
X-Gm-Message-State: AOJu0YxeQNsoZbw1wRhutiU4dfzk5UNXOJJSvvXZMeyU02n9J5D+Melq
 4T0cRz3g+Fo1iQTrizpu7CWXv3xK+Bh/VL+5VeIAQNnJXfCnSJKnI8yUin9lmkdZcAgg6z6IlmQ
 7SaJGxQEkakQCjA==
X-Received: from wmby19.prod.google.com ([2002:a05:600c:c053:b0:485:3aa2:da59])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8010:b0:48a:5339:ef0e with SMTP id
 5b1f17b1804b1-48e70687eabmr216165565e9.3.1778590701567; 
 Tue, 12 May 2026 05:58:21 -0700 (PDT)
Date: Tue, 12 May 2026 12:58:20 +0000
In-Reply-To: <20260326-gfp64-v2-0-d916021cecdf@google.com>
Mime-Version: 1.0
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DIGPS83BGEGA.5I7VLH8TV7XE@google.com>
Subject: Re: [PATCH v2 0/4] treewide: fixup gfp_t printks
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Jackman <jackmanb@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Stanislaw Gruszka <stf_xl@wp.pl>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Allison Henderson <allison.henderson@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, 
 <linux-wireless@vger.kernel.org>, <kasan-dev@googlegroups.com>, 
 <linux-mm@kvack.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, 
 <rds-devel@oss.oracle.com>
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

On Thu Mar 26, 2026 at 12:31 PM UTC, Brendan Jackman wrote:
> This patchset used to be about switching gfp_t to unsigned long. That is
> probably not gonna happen any more but while writing it I found these
> cleanups that seem worthwhile regardless.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> Changes in v2:
> - Drop gfp_t changes
> - Add correct CCs
> - Add minor fixups to preexisting code spotted by AI review
> - Link to v1: https://lore.kernel.org/r/20260319-gfp64-v1-0-2c73b8d42b7f@google.com
>
> ---
> Brendan Jackman (4):
>       drm/managed: Use special gfp_t format specifier
>       iwlegacy: 3945-mac: Fixup allocation failure log
>       mm/kfence: Use special gfp_t format specifier
>       net/rds: Use special gfp_t format specifier
>
>  drivers/gpu/drm/drm_managed.c                  | 4 ++--
>  drivers/net/wireless/intel/iwlegacy/3945-mac.c | 4 ++--
>  mm/kfence/kfence_test.c                        | 2 +-
>  net/rds/tcp_recv.c                             | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260319-gfp64-7a970a80ba4e
>
> Best regards,

Hi all,

Any chance someone can take these?
