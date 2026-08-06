Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B84CC5AC9E
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A897110F380;
	Fri,  7 Aug 2026 06:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=edera.io header.i=@edera.io header.b="Pzii+jZ+";
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D7DD10F2F0
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 23:53:20 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-81f3b227a4aso45672207b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 16:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edera.io; s=google; t=1786060399; x=1786665199; darn=lists.freedesktop.org; 
 h=content-disposition:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=k3HgQkukNBNJv/hmD9hzfSotfFQHeA0758t49VFm5iU=;
 b=Pzii+jZ+3JjTrgZ+sqHfedvnUtHn3DwgMFR7YVGZo8eUUscBp8ieSknlQXJGfsHOLr
 vrK+eDsQDpuXD6NZ8L0dSb7OK8NQaA7+18QAtHyugOFKOExJtlIvRCEKE8LHJaeqrMAI
 Fr0yPncaKtbdk9DemYlXYMePvhRYzu3UHG5HnmQ+WwmN/mZr8W1bRjM9sSQja2L5yeoZ
 onofSen9Q2MbR2rLhPDaLp5QEk5JLWyarHGBG6gWWJ5DQLEP/ShceGhCVCLvqO+78Cwd
 HLoyMZ2xpBGjXdnYO/J/UkjB4iX6JANAsSeGh62GawW4TvPSm/FBKAwhOZNYEylib/8k
 kO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786060399; x=1786665199;
 h=content-disposition:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k3HgQkukNBNJv/hmD9hzfSotfFQHeA0758t49VFm5iU=;
 b=ethRWrtbPnZkO0dvvYYPa1fbX+yawlJIRr2KLwCUQQ6qIzgq3tpNHLbbppLcfOt8pi
 Dx9xA2Y2WVX+G1Hh2ajhBrIfnOxXiqNZmjN8jYuMGIzGMaYLYNA98sHR4TPC5yAyGAsg
 J8/OFJgaittIcpwKo0DlpmOlODJMPiSf9PA9p3b+o7ZSNTJdNAKAH7wNjM9mQaOmvUgJ
 nWL7s4G2mZ6oxVQMGF2iJGxvN4W6mHpy3PQJ7tSZrLRGxGWnMnfjomhX0I4d+4ofIQn3
 1O0hW/evTW5rt9pS+32SEwXMcVRF2nkKlSaf2YENWoGB3Gd8jK9oBz6f52ftX8ZJP2zU
 YURg==
X-Gm-Message-State: AOJu0YwKiZxdnRmbkfHzl9A4Ft2E+1AT4N7dVxxehYZiyrzeLCYr2JWD
 0aG28zlY9FxGX5V9IbqQs1iqBAwHq7FVVSx8TvWm1pH65b8XUk8NDHTg0gAn75ClDNM2LvWmTSe
 WmAlZtRw=
X-Gm-Gg: AR+sD13aGWe8lsEU8NKdHz0uNymmQN84LAhujVXI7idX95Lr8nzAJv3vGVV8yR5uQds
 nSYQ+J/pA0woYyNW0Fb1+c+oaUPAGoSbm3r0+t/YAa0d7ilgkicR23yxslYB56X7/dYaZOk9y7P
 QjTsXbbumVXc0qnBMSxHownj+a718n8TvggPIKIn5CsYGbQXL+OfmbXoWYX7ydsLFlhlkT2Fgbt
 B4H/oXQgCrhxxQ7qwdjoswaOoHkdjlYlXM9MdOxcVJlygcHgqPeepHtacLjtNmmmqYSkd7wePHV
 SmpS23KQbs33I/OvYl8Umm+EcbxrEyoUEMtpmuLzWooHvOuT7VIY9RgO6u5wqMQX7ia3aixwft7
 hbN78wJSagzdXJzhc9HZH7QiYhwW+nAB/qjEt3PZRIjWeJfAh3mdJvb3r9LSSkUbhl0EXnKDvCN
 PLoQv/lI2BLCwhPH6r6e3x1M+Y0kNfW3wTXfdn3YqFOkBZu2dMt/j1JWWhjbEQ
X-Received: by 2002:a05:690c:7303:b0:81e:514b:1b98 with SMTP id
 00721157ae682-8201bccf693mr116095477b3.7.1786060399007; 
 Thu, 06 Aug 2026 16:53:19 -0700 (PDT)
Received: from StolidWingnut ([174.80.170.224])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-823f0e64324sm527997b3.19.2026.08.06.16.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 16:53:18 -0700 (PDT)
From: Benjamin Leggett <benjamin@edera.io>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/virtio: use the DMA API for resource backing on Xen
In-Reply-To: <20260806231002.27B4D1F000E9@smtp.kernel.org>
References: <20260806-virtgpu-xen-dma-v1-1-e499b345bbad@edera.io>
 <20260806231002.27B4D1F000E9@smtp.kernel.org>
User-Agent: mu4e 1.12.12; emacs 32.0.50
Date: Thu, 06 Aug 2026 19:53:17 -0400
Message-ID: <87v79mu7pu.fsf@edera.io>
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 07 Aug 2026 06:47:17 +0000
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

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> [Severity: High]
> This is a pre-existing issue, but while enabling the DMA API for Xen PV
> domains, does this leave guest-bound transfers vulnerable to data corruption
> with SWIOTLB bounce buffers?

Yep, preexisting issue, but not reachable via plain `virtio-vga`.

Only reachable, AFAICT, if `has_virgl_3d` is enabled. The missing `_for_cpu`` sync
is pre-existing since 8f44ca223345 and pretty orthogonal to this patch.

A correct fix belongs in the completion path rather than at submission,
anyway, so it should be its own separate patch.

Happy to do that in a followup/separate patch, if requested.
