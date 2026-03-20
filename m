Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807481093191
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:05:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B804E10EAA2;
	Fri, 20 Mar 2026 09:05:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lcvRcE/1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFFE110E541;
 Fri, 20 Mar 2026 09:05:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EDC0560127;
 Fri, 20 Mar 2026 09:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22591C4CEF7;
 Fri, 20 Mar 2026 09:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773997535;
 bh=1+/V3M72eicHKatX91jOMQbyAysvN6oRz5SSDh43k3U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lcvRcE/1AlZ1LeZ6wPkfYP5/RYZNjCMZxUocYBkwsIiIaMUKjzOT51HHNMB5Zkd85
 fFRt2lS1uOx0lF4ZOkruQg8cr5awaWrPR+zVIuXbBrR5p/+HNhCuciG4owx+mcVOMA
 0OC9y/yYCAboum5FvrQnYMljnyjJ9Mz7fIDvyuMq6wvSes8wQ7rk1csUqDNhgHowAk
 V85kOj+gxW/isVA7z6TAiwIuklrtv9iVM58oY+eMF3anFrWiWUF02se2qdIjk72b8U
 0mMr7ZHck8q+Xzkl5+YARVfoEE1rB8OKKSRI7qin5EH8xDuIAzulM0qp6ZwtPFX/E9
 CLSJTesLIwlww==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 linux-mips@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>
Subject: Re: [PATCH v5 0/4] drm/atomic: Allocate drm_private_state through a
 callback
Date: Fri, 20 Mar 2026 10:05:30 +0100
Message-ID: <177399752799.2530289.3477869792206272729.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224-drm-private-obj-reset-v5-0-5a72f8ec9934@kernel.org>
References: <20260224-drm-private-obj-reset-v5-0-5a72f8ec9934@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Tue, 24 Feb 2026 17:10:25 +0100, Maxime Ripard wrote:
> This series started from my work on the hardware state readout[1], and
> was suggested by Dmitry[2].
> 
> This series deal with the fact that drm_private_obj (and thus bridges)
> are not initialized using the same pattern than any other object. This
> series solves that inconsistency by aligning it to what we're doing for
> all the other objects.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime
