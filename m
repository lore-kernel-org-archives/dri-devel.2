Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18A4C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 08:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2B9389241;
	Mon, 21 Sep 2026 08:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cinemaone.ch header.i=@cinemaone.ch header.b="aiBr5sLQ";
	dkim-atps=neutral
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch
 [83.166.143.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2292789241
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 08:01:48 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hpG0C05V1zKJT;
 Mon, 21 Sep 2026 10:01:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinemaone.ch;
 s=20250113; t=1789977706;
 bh=ffgYr5YDmmbHJ/YZbfGMXSYf7rRr6BO8vxNzGNH3a+E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aiBr5sLQJq6jiVKceXYMPYCUK2bmY0T6ByE2DKDetSNCjUnMUZWZkmWhwHUUDzuB5
 Hh3kli6XN7IpAXM6LoidZ5zlPLvthkCFzRaN//q6JSiYXjWOhp74pXiF4hgkl6SJQq
 2NmNpx++yOBoCum0H7qhn3X/BEATyyZRCRtBJajt3fL3be/HhPDex03EJrxSjVRfjl
 4ysvUsdXFArHZmQ5g2Il4equZToy3O4z5Kbr8U/E2VTnBW9j568YLRY7IiSWtMjReP
 wI8oBkBI4OqfnMom8FMHYtB7u6R2Ai/A12be/QluL23EZ0VGlRfuaV617vih0fZpuL
 QOmW2BoWW2EgQ==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hpG095mmVzhss; Mon, 21 Sep 2026 10:01:45 +0200 (CEST)
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
To: Daniel Ramos <capitain_jack@yahoo.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drm/amd/display: HDMI 1.4 3D output (frame packing,
 top-and-bottom, side-by-side)
Date: Mon, 21 Sep 2026 10:01:26 +0200
Message-ID: <20260921080126.98936-1-adrian.betschart@cinemaone.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921034104.1021664-1-capitain_jack@yahoo.com>
References: <20260921034104.1021664-1-capitain_jack@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

On Mon, 21 Sep 2026 00:41:04 -0300, Daniel Ramos wrote:
> Independent confirmation of this approach on older DCN hardware and a
> consumer-TV sink, plus a boundary record that matches your patch 3's
> diagnosis.

Thank you, Daniel. A second DCN generation and a TV as the sink is
exactly the coverage the series lacked, and the black frame-packing
picture without the doubled timing is a good independent check of
patch 3. (Adding the maintainers back to Cc.)

> Happy to run anything specific on this APU and television combination
> if it helps the review.

One request, if you have the time: your runs used your own port on
7.0, so a run of v3 itself would make your Tested-by cover the patches
as posted. It applies cleanly to 7.3-rc1. Top-and-bottom is the most
useful check, since patch 2 only affects that layout and your report
covers side-by-side and frame packing.

For the record, as with my later amdgpu patches: the series and this
reply were prepared with AI assistance (Claude Code); I reviewed and
tested the series as described in the cover letter. A respin will
carry the Assisted-by tag.

Harry, Leo: any comments on the series?

Thanks,
Adrian
