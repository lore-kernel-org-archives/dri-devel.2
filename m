Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAEDCD98CF
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 18:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19EA610E5E7;
	Mon, 15 Jun 2026 18:49:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UzdfkPaW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59D2810E5DC;
 Mon, 15 Jun 2026 18:49:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 73851600AB;
 Mon, 15 Jun 2026 18:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066761F000E9;
 Mon, 15 Jun 2026 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781549396;
 bh=/E/EQUQWpDPjINhgmxIfofQL7z7fKAPRGJ0jdZ84qwY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UzdfkPaWLxvN73MupLzIuTXup5jyw6VsrwSo4tTuTaiM7hsogCNZqzndjDaIZrGAj
 XoXxpx94/F3n9z6b+KuhnGumNwbqi82G3ufmdjQ/yCt28c9sUVnbSz4tDerk/MxZXZ
 o4pd8TG4rz/eGa5F03ajmSKeNNEkHyBBIOyLXLweZ7WXCgMwlpvNEd4zXTwFjSHRgg
 G08vsoOLFZJ44XnnAP4gR9Xd46FGicmp/ZzW8XUfGkYUz4BXQyQPvwJynn7r2yB39c
 PatIxKPfu5RaGxgoWMBdnoHdrIwXCpdnHLYNC02w4Qa6L+e2sTM4SJcLlXea2sA6Pt
 DTiqxYMlyMRyw==
Date: Mon, 15 Jun 2026 08:49:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] [PATCH v6 0/6] Add reclaim to the dmem cgroup
 controller
Message-ID: <ajBJU-Jp2QVy14qt@slm.duckdns.org>
References: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
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

Hello,

On Thu, Jun 11, 2026 at 07:32:55PM +0200, Thomas Hellström wrote:
> When writing a "max" limit lower than the current usage, the
> existing code silently failed. This series aims to improve
> on that by returning -EBUSY on failure and also attempt
> to synchronously reclaim device memory to push the usage
> under the new max limit to avoid the error.

The canonical behavior for cgroup2 would be not failing the write at all
even when the usage can't be brought down below the new max. Updating the
target configuration and tracking the current usage are separate operations.
The former should just set max and trigger reclaim and a writer should not
assume that a successful write indicates that the usage is below the written
max value.

Thanks.

-- 
tejun
