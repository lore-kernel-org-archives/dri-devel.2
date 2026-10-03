Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DB3CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 22:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD1510EA4D;
	Sat,  3 Oct 2026 22:38:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BThYNJj3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8C4910EA48;
 Sat,  3 Oct 2026 22:38:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8338A4171E;
 Sat,  3 Oct 2026 22:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0319B1F0089B;
 Sat,  3 Oct 2026 22:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791067108;
 bh=PYWK/vh7WiCukWTrYPPqGU7WnxK7cVjDRNd8vW5QqG4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BThYNJj3zLI77GsJXXRNPd0ok6hUjbYgkCwBmnkNnfCAfj8IMCrndxH6sSspNQcwz
 DZ2jD51R6ZIiMXp8jZvpCjrtA8DXGA9hRm/hid7LhhqRkylEC9mzNb+wLXmPyQ5Wmd
 mttzWS8lkDHhL63NYG48I5VoqG87pkmHER38RbNl/GkUBwF5NyhJg0UCaCmD5r8VX8
 X4NzPf7GxzJXGq8hhp1O+NMlTABeMKbJeiLyOxqRYKYl1DMp7atXeXjDMD5HsjraP1
 RyJqTTVhyElmDlaKf9RPjVv4PQeMs+syQ8FqykNcdQAWdgkujR+YJdDmjM837JZ9jn
 fw0ds2k1FAFbw==
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
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org
Subject: Re: [PATCH 6.1.y 0/2] drm/i915/hdcp: guard both capability checks
Date: Sat,  3 Oct 2026 18:33:02 -0400
Message-ID: <2026-10-03-1-daily-reply-0021-re-i915-hdcp-both-capability-checks-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002194030.20489-1-artem@trailofbits.com>
References: <20261002194030.20489-1-artem@trailofbits.com>
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

> already present in 6.12.y, 6.18.y, and 7.2.y. Could you please queue both
> patches for 6.1.y?

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
