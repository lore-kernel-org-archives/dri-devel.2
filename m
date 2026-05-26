Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17167CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 11:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717EC10E626;
	Tue, 26 May 2026 11:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NBpmCATl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E435E10E626
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:35:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 82E4B43321;
 Tue, 26 May 2026 11:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E051F000E9;
 Tue, 26 May 2026 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779795313;
 bh=XAFFB/ti5ppyZh8MzLYmcCCCoGstaLaSac5HP7Oym30=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NBpmCATlSk82CG+IjXD3NxX/P+FXuwztclyQ9bxhPOji4foWcNghs5hT2Nif2/BhN
 5LEbXKSPAZC8waxhBCtNJLow5qzi0h+zq2ky3HGiRnWgexPmgC65RRbZyiONGuhcf+
 9PrVGuEp9e2MzpI7Cd39vB+TCS06sWLD1wReWMXQU1jCDaDiL0c5jAaDCf53KlbpX0
 YxM04pnnwhkrboup/wJQVcU/MYdsTzDUbiQ8ynKgbg4vFq8RRQDBGMboKR8yXugEkZ
 QYFNgFkyBI4jle9UBwq+82qnyYVMGKdIGq5jfTQDHbee43MdA4vSWQvHHMSQUonmEs
 E+WqatJb0KqQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 louis.chauvet@bootlin.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 w15303746062@163.com
Subject: Re: [PATCH 6.18.y 0/5] drm/vkms: Backport generic vblank timer to fix
 ABBA deadlock
Date: Tue, 26 May 2026 07:35:05 -0400
Message-ID: <20260525231000.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525131610.608273-1-w15303746062@163.com>
References: <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com>
 <20260525131610.608273-1-w15303746062@163.com>
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

> [PATCH 6.18.y 0/5] drm/vkms: Backport generic vblank timer to fix ABBA deadlock
>
> 1/5 drm/vblank: Add vblank timer (74afeb812850)
> 2/5 drm/vblank: Add CRTC helpers for simple use cases (d54dbb5963bd)
> 3/5 drm/vkms: Convert to DRM's vblank timer (02e2681ffe1a)
> 4/5 drm/atomic: Increase timeout in drm_atomic_helper_wait_for_vblanks() (79ae8510b5b8)
> 5/5 drm/vblank: Fix kernel docs for vblank timer (3946d3ba9934)

Thanks for putting this together.

Looking at the five commits:

  - 1/5 (74afeb812850) is the one that actually fixes the ABBA
    deadlock you observed under Syzkaller; it adds the generic vblank
    timer that replaces the open-coded vkms hrtimer path.

  - 2/5 (d54dbb5963bd) adds new CRTC helpers for "simple use cases".
    No Fixes:/Cc:stable, no described bug.

  - 3/5 (02e2681ffe1a) is a refactor that converts vkms to the new
    helpers. No Fixes:/Cc:stable, no described bug.

  - 4/5 (79ae8510b5b8) is a v7.1-rc1 timeout bump that depends on 1/5.
    It is not yet in any released stable, so applying it to 6.18.y
    would put it on an LTS before any LTS contains it.

  - 5/5 (3946d3ba9934) is a doc fix for 1/5.

Per stable-kernel-rules, what I need to queue is the minimum set that
fixes the bug. Could you explain, per patch, why 2/5..5/5 are required
to make 1/5 work / are required to actually fix the deadlock? If only
1/5 is needed, please resend just that one with your Signed-off-by
added (the carried patches today only have Thomas's S-o-b, which
breaks the chain of custody on a stable submission).

--
Thanks,
Sasha
