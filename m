Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0CEC88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3434A10F856;
	Tue, 15 Sep 2026 02:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jKIveioP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A015510F855;
 Tue, 15 Sep 2026 02:03:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ACD9F602C4;
 Tue, 15 Sep 2026 02:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0291F0089B;
 Tue, 15 Sep 2026 02:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789437838;
 bh=z0vL2p+Bd88btvl3Ksm1wFnOPohiOiTkBKSRUoYcHVM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jKIveioPNhMqPBhOJHPVrFRe2TZU9csQBTAj24Nftp8XjhJudo+o/kpgK4cZ9MEcD
 kfA2tqmfMEdKI0BdpYR4ayV7j+459XEIq9gzICqy3hOEpaofPwq7TC+hl1NmMMG17z
 wCcRRadLkpzn0xRHzUC3oJKos4jCot8G5C1ithqxsMhAMMv8oyHfelW4JRr8etH37T
 GwNf4RHs6YbK+/yV7P9LIhZEMZhqIUO4xRHVw4e5XYRBcWd/V00wUpfmCL3sA3P+sx
 Vx42Jksvt7+Zz4nVDvdlyQS8amvJSZMFva2Y6tUF0yGBNOt59vIF+yBTAsmBQwuIQQ
 KXUEDFhiZWbCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
 Roman Demidov <roman.demidov.nn@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>,
 Alex Hung <alex.hung@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, WenTao Liang <vulab@iscas.ac.cn>,
 George Zhang <george.zhang@amd.com>
Subject: Re: [PATCH 5.10/6.1] drm/amd/display: set new_stream to NULL after
 release
Date: Mon, 14 Sep 2026 22:03:31 -0400
Message-ID: <daily-reply-0015-re-amd-display-new-stream-null@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914081639.12512-1-roman.demidov.nn@gmail.com>
References: <20260914081639.12512-1-roman.demidov.nn@gmail.com>
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

> If a later error (e.g., color management failure) triggers the fail
> label, the error path calls dc_stream_release() again on the same
> dangling pointer, causing a double release and potential use-after-free.

5.15 carries the same double release of new_stream in dm_update_crtc_state()
and has no fix for it, so taking 6.1 and 5.10 alone would make a 5.10 to 5.15
upgrade a regression.

Could you send a v2 covering 5.15 as well?

-- 
Thanks,
Sasha
