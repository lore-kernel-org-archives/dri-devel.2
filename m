Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED817CD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 21:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F201310E086;
	Fri,  8 May 2026 21:11:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nh43N0dz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 767EE10E086;
 Fri,  8 May 2026 21:11:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BCA6419D3;
 Fri,  8 May 2026 21:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CAFC2BCB0;
 Fri,  8 May 2026 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778274712;
 bh=CgBnBDmdkqvx8nTgl5Mp3KpqinE1WaOcJGs2i3jhD10=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nh43N0dz8PHuBTkQmma420H1eyihOXkbglB+IaF81WJIm74qn2gZyQNK189fCbfOW
 o7xIk+VEKHp1fpKlc6PIvwSuSRKB6qNVpLZvSEfbzfJtK/iOBQCYZM5foZiIMOVKKB
 SZ246dr9gmguxkCi21S/7hXzN62IIQRKkGgdgT/v19zcx+HPSw5cJxE9ZyTl4QS3Ul
 zgiN+3IutVhy2LfM3MMYv4KX34T5XABIzXYtSgr4xQ4PEUMCetIoRkzk5dhok2W+E4
 3zqPxeR8JypLjxYmGodzNUtP8emJ0bpnrZO9fBWKt4DBv0JWibkhqoCzcheFXVZmsw
 hfeUJDrife11g==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	dev@pp3345.net
Cc: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, harry.wentland@amd.com, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, ray.wu@amd.com, Wayne.Lin@amd.com,
 mario.limonciello@amd.com, aurabindo.pillai@amd.com,
 timur.kristof@gmail.com, jdhillon@amd.com, hersenwu@amd.com,
 Roman.Li@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Fang Wang <32840572@qq.com>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Do not skip unrelated mode changes
 in DSC validation
Date: Fri,  8 May 2026 17:11:39 -0400
Message-ID: <1e7ec2f7bb732f43-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_CCDB1B23FED831830856396BB4DF59D1B106@qq.com>
References: <tencent_CCDB1B23FED831830856396BB4DF59D1B106@qq.com>
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

> Subject: [PATCH 6.6.y] drm/amd/display: Do not skip unrelated mode changes in DSC validation
>
> commit aed3d041ab061ec8a64f50a3edda0f4db7280025 upstream.

Now queued for 6.6 and 6.1, thanks.

--
Thanks,
Sasha
