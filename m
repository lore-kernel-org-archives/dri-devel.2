Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894C7CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77CDE10F039;
	Tue, 29 Sep 2026 18:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oT3kBYZ4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E556110F039;
 Tue, 29 Sep 2026 18:51:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 66CD06022F;
 Tue, 29 Sep 2026 18:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E161F00899;
 Tue, 29 Sep 2026 18:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790707880;
 bh=Z2xVvwUtdyqBwNLaR4fNUGqbS0doqYiFvfVfZlYtop4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oT3kBYZ4yMh0AWp0GaDMTffmAd0p5slEU7Lr57QPYUQxqriPV8vpWhZcgMPh6Idot
 jdWheR6EdlgUYPvHcQPWbWGrHSzJcUruZh+eNjusrwIyzBTf1093nSUwYWaVYu3ZcI
 5J7w8POdHwLPzhfON43dyFoeH/fegSaj8k6DWxY5m7o0DUF3JX/joM3lS6T5AZe9hv
 UUH8i/DJjO8squaCap+KVfG/y45xXiGYRFAV5OeN0zTgpLwmy/0XtdXzWcAo48wXlC
 W0UevDGqzNizZDaEfd+19M/aeYFaEWm27EnLAuusTkZcS9c+J43FuuGe3L6tCJ0dEp
 pT5QJKS4RuPkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <xinhui.pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Validate function returns
Date: Tue, 29 Sep 2026 14:50:54 -0400
Message-ID: <2026-09-29-daily-reply-0011-re-amd-validate-function-returns-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929031602.87583-1-artem@trailofbits.com>
References: <20260929031602.87583-1-artem@trailofbits.com>
MIME-Version: 1.0
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

> This one addresses CVE-2024-46775. It checks four display-helper results
> before their output is used.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
