Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F511CD5BB1
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 20:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D564910E284;
	Sat, 23 May 2026 20:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QpRxJtGj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD7810E095;
 Sat, 23 May 2026 20:14:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C693D4139A;
 Sat, 23 May 2026 20:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8321F000E9;
 Sat, 23 May 2026 20:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779567287;
 bh=QtM6bF8yoOj3tLh5tQ2S3M+MrcX1OercTmVBby5Gjug=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QpRxJtGj0jpM+GNm1BzSR4MqczA7yN8kxgbTkRJXqVW+6w/95wTBT1NoHMDiXv2vG
 N2BKrt1xoANalK3ebziKj1EWLYIBAD72WpIDF3QZMfqe7hqNz2qbvwgAlEGdUm14zj
 NSqiCjf0fINu3ST7v/W94WAaNjnq9SHxBoPqTClvuxB9khnF6Skovzy4xV6bIq6AI8
 0YjL8nzm0J/CpazwLRnPFyvicoGdql/7XY0UbyUWtlrckyv7M1sztsZQIiUzHQ+ay9
 8g4k9g6Z4LGkcQJKs6AuhjXweWYD770HDlnaU5w6/vwmloryjTXB+dLe+WSsZ5saQi
 ZsYSiOZptAE9g==
Date: Sat, 23 May 2026 13:14:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Simona Vetter <simona@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, freedreno@lists.freedesktop.org
Subject: Re: [git pull] drm fixes for 7.1-rc5
Message-ID: <20260523201443.GA728778@ax162>
References: <CAPM=9tx1oasUKYLGvimk5eXftsYk1LOSaNV_X27tVp-pvrMLLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tx1oasUKYLGvimk5eXftsYk1LOSaNV_X27tVp-pvrMLLA@mail.gmail.com>
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

On Sat, May 23, 2026 at 08:16:11AM +1000, Dave Airlie wrote:
> Daniel J Blueman (1):
>       drm/msm: Fix shrinker deadlock

This patch breaks the build for all clang versions and older GCC
versions (at least GCC 8, the minimum supported version).

  drivers/gpu/drm/msm/msm_gem_shrinker.c:105:58: error: omitting the parameter name in a function definition is a C23 extension [-Werror,-Wc23-extensions]
    105 | purge(struct drm_gem_object *obj, struct ww_acquire_ctx *)
        |                                                          ^
  drivers/gpu/drm/msm/msm_gem_shrinker.c:117:58: error: omitting the parameter name in a function definition is a C23 extension [-Werror,-Wc23-extensions]
    117 | evict(struct drm_gem_object *obj, struct ww_acquire_ctx *)
        |                                                          ^
  2 errors generated.

  drivers/gpu/drm/msm/msm_gem_shrinker.c: In function 'purge':
  drivers/gpu/drm/msm/msm_gem_shrinker.c:105:35: error: parameter name omitted
   purge(struct drm_gem_object *obj, struct ww_acquire_ctx *)
                                     ^~~~~~~~~~~~~~~~~~~~~~~
  drivers/gpu/drm/msm/msm_gem_shrinker.c: In function 'evict':
  drivers/gpu/drm/msm/msm_gem_shrinker.c:117:35: error: parameter name omitted
   evict(struct drm_gem_object *obj, struct ww_acquire_ctx *)
                                     ^~~~~~~~~~~~~~~~~~~~~~~

I sent a fix but it looks like it did not make this pull.

  https://lore.kernel.org/20260518-drm-msm-fix-c23-extensions-v1-1-0833559418c7@kernel.org/

Given how simple the fix is, perhaps Linus could apply it directly
instead of waiting for another fixes cycle since we are about to be at
-rc5 and the tree should be stabilizing?

-- 
Cheers,
Nathan
