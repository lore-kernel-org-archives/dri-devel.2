Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E51CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B005010E1F4;
	Thu,  1 Oct 2026 13:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KM8eYvA9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49DCA10E1F4;
 Thu,  1 Oct 2026 13:52:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 554616022E;
 Thu,  1 Oct 2026 13:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597AE1F0089E;
 Thu,  1 Oct 2026 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790862760;
 bh=2UQ2d/eInSoNKLD1if8zl9YzeL4EqylpYk3DXqsT4nU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KM8eYvA9iOpKBwcdiqGAuA7c4z4xoT7RY8Krsxs7w834zArwmDZEfml+LRp8H5aKu
 livxL/Cc1VD9qNiDb7nXMd7ge8A85zYZPSSOo+yEc5aO37cy0X6nsaZFNU2x+OcU02
 wPa7inx/hrkEp/QYrkC+D47UrPdL9YxkhlRTJRf2ORilxI0rll0HaY6QB1GgP8o4Mi
 lMJNaqMNsF3IOG2XagQl4dqHkMR//biy3zsbQ8p+Cb44vvL1faIg+O+dTXL0KS3zEP
 ozlCdH/zV+UO8uirQNAMmD/IYvT2CSR4Pb49jG4k009KOkAiFJhhsqPLLZvCi9Voec
 /y/mPJEot3hGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Suraj Kandpal <suraj.kandpal@intel.com>,
 Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y v2 0/2] drm/i915/hdcp: guard both capability checks
Date: Thu,  1 Oct 2026 09:52:14 -0400
Message-ID: <2026-09-30-1-daily-reply-0010-i915-hdcp-both-capability-checks-v2-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930010323.93999-1-artem@trailofbits.com>
References: <20260930010323.93999-1-artem@trailofbits.com>
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

> Together, the two patches make both debugfs capability checks return
> false before converting the missing encoder to a digital port.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
