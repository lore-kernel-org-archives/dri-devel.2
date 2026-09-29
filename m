Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B714ACA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE07410F032;
	Tue, 29 Sep 2026 18:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lKCg71Ko";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B0D610F032;
 Tue, 29 Sep 2026 18:51:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 17DB16022B;
 Tue, 29 Sep 2026 18:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0531F00893;
 Tue, 29 Sep 2026 18:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790707873;
 bh=L/fe21HAVUmdM6qJ1mnrLspumxlrl2x6ZLSmHA92wwM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lKCg71KoPPQcig0qO9V1o5vXvuAe3+gv1/xhW9RBy6LD1/H4N8NiqVbDPdRNTExTm
 9GuvOIePVYJ8ods8a9m7sGm2gZdD9JB+hz7IP/DH6MvOQWRFa9LZDhfq//QMXzvM30
 6LcyoU0U7zavQ5ex9HYYCoqXSgtoeQ/6vbe/RScs/qEfwhE7tNR58xBq6flMoasDCL
 DrpIpZlsNmTlsYaydt/D/173sCHcoVtVWHVVeckk9Lu/772JOV7OouPhLRKVMGFkF0
 J3PfW/Wkuk81ktVCcexqWTMXQIrwWjv7baTA0tgheSGK53HaN7JHuriRO3sfaXT5Sj
 XM4QLqx5OD7nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Allen Pan <allen.pan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Alex Hung <alex.hung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <xinhui.pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Add a dc_state NULL check in
 dc_state_release
Date: Tue, 29 Sep 2026 14:50:51 -0400
Message-ID: <2026-09-29-daily-reply-0008-re-amd-dc-state-release-null-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929030936.86941-1-artem@trailofbits.com>
References: <20260929030936.86941-1-artem@trailofbits.com>
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

> This one addresses CVE-2024-26948. It adds upstream's NULL guard to the
> older display-state release helper.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
