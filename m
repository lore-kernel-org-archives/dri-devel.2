Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64726CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC4E10F042;
	Tue, 29 Sep 2026 18:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fFngQLgg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8CEB10F036;
 Tue, 29 Sep 2026 18:51:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4439C602C3;
 Tue, 29 Sep 2026 18:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E82C1F0089B;
 Tue, 29 Sep 2026 18:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790707876;
 bh=kaRa43CELU4o2hL/fYKd1KiJSlVv0GcSE3JqRJkpNgI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fFngQLggkCT7MHNkNQbVe5irXs0KqAdjCdnawZ1d5UAYxmy0iEisVnTjDlCzn6Bnv
 VK7EyIubW9JlAHNP4vMAaS477xBUn61WNTl6rtchbPUSzOx0OslaBXDFiEsP+gRK+W
 HVmSzYgv/BKHugdSEhL3fOvk81GuDTDmg99h5gIS5pyXgKCd/gb1V8Umr8YQJt5xKw
 HWZRVqZukixX8TxBcjSWiYzF5fZmrESJYIdrWVwB00b1nQIMiMTCQrfxwK7AI0ylC7
 wPTGELqAf6OUP6sqoxpUHatRe3i5GhT/foINUJKxOsM1rmd3i4Ol5LSTwUaTK+k7Fb
 eRnlOp0c4g9qA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <xinhui.pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Ensure array index tg_inst won't
 be -1
Date: Tue, 29 Sep 2026 14:50:52 -0400
Message-ID: <2026-09-29-daily-reply-0009-re-amd-tg-inst-index-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929031209.87164-1-artem@trailofbits.com>
References: <20260929031209.87164-1-artem@trailofbits.com>
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

> This one addresses CVE-2024-46730. It adds upstream's zero-count guard
> before the fallback timing-generator index is computed.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
