Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E536CD98F2
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 14:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E9D10E3B5;
	Sun, 21 Jun 2026 14:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FXEsbNYs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 386B310E3B5;
 Sun, 21 Jun 2026 14:07:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 831F044412;
 Sun, 21 Jun 2026 14:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA001F000E9;
 Sun, 21 Jun 2026 14:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782050830;
 bh=Y2cgyHfbek07AZHYJxVDvRYBpvV/pT8ewpQ26OswMew=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FXEsbNYs9Os1uNb4cUJCsnW4UlhUPtPc/MtpUUV/w8nspm1kjXw/1/usx7poYizDT
 Ztp7TYOzsKiVWk2D2WWgeL8naVd2S0gCX+4usCDGqelvlVdbZU61HPuDMrBIRN6fPX
 lGsmOgaxWM2E5vJp8LOs2v3UKwLwuIogaWdsnv1arXQImZqLaKqDp3ZcJp0HfYuN7r
 LkxtFnuw/PrtTZQEEEQUzMA58SD9wIekaxGSwkliVozEdLfe0cbq6z92HwOxXD+dmz
 m/xJgQsyMQ1yykcGF2uBoKMUloJ1bk0qWHYH9FQFya1dWD+G1eAoytOtqgprvdFU59
 QL8joYg4n1Xog==
From: Danilo Krummrich <dakr@kernel.org>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 dakr@kernel.org
Subject: Re: [PATCH] nouveau/vmm: fix another SPT/LPT race
Date: Sun, 21 Jun 2026 16:07:02 +0200
Message-ID: <20260621140702.9656-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615044737.3419585-1-airlied@gmail.com>
References: <20260615044737.3419585-1-airlied@gmail.com>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On Mon, 15 Jun 2026 14:47:37 +1000, Dave Airlie wrote:
> [PATCH] nouveau/vmm: fix another SPT/LPT race

Applied, thanks!

  Branch: drm-misc-next
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/1] nouveau/vmm: fix another SPT/LPT race
      commit: d008141ed4ce

      [ Properly format commit message. - Danilo ]

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
