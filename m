Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B268CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 22:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9698410EA45;
	Sat,  3 Oct 2026 22:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aI+Iy38r";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0237310EA3B;
 Sat,  3 Oct 2026 22:38:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DAA4260052;
 Sat,  3 Oct 2026 22:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1333A1F0089B;
 Sat,  3 Oct 2026 22:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791067084;
 bh=eBzr4YTPQUP3nF8hY66j2htV41vnUfMgR3tV5Q+OhXY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aI+Iy38rn74cVT8xGzoTqmPC/lUxc5segDxqq42/o8tqp68F7df+cH9sxPgTVgvbc
 kispNODRNEsiRpbRO+BeOCx3ESgMIKbeIHHLpHEJqe8oAoe1b/BbKLktn1es/7CM6S
 CbgdwiO9bT7D9beLplFTLjaNPfI04zXzvgFnaR0ZcdsO5wnUsMkNUfaeudXE0Q0Kjg
 67gFYcAKvmmPQZaPyECKSZai+mkIvhuCU682DW60r90H5n918P0RIEgW2hYVct8kbC
 NPIePL7co75YNcxMaAKOMd2+9CCB/T7mfPOPbPd5twQ31WzOQ2adyJGoCUcTn/47h5
 XSAk1blYyiQhw==
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
Subject: Re: [PATCH 6.1.y] drm/amd/display: Validate function returns
Date: Sat,  3 Oct 2026 18:33:01 -0400
Message-ID: <2026-10-03-1-daily-reply-0020-re-amd-display-validate-returns-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002193753.20239-1-artem@trailofbits.com>
References: <20261002193753.20239-1-artem@trailofbits.com>
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

> [ Upstream commit 673f816b9e1e92d1f70e1bf5f21b531e0ff9ad6c ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
