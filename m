Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A30C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9ED610E928;
	Tue, 15 Sep 2026 14:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SOIIdH32";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B9C810E928
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:14:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8BB9E600D1;
 Tue, 15 Sep 2026 14:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EE71F00893;
 Tue, 15 Sep 2026 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789481676;
 bh=1DqTDhfTaY5kNEZvyvJAHvbbtLEgp4W1u2FkCfhR/3Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SOIIdH324OsHlSys8G4ktSwBhwKeQYT1XdDI4BiW1MHArQnOlJdFM2/S+1tTFysVm
 PqWF2uHubMFvVdjcTfZwL2Et5wrF/MOSUaAybJM1vTFl1oj9pZ8nGk3YFTLtsrm7yN
 GVJi8mKsmpRptJ9eWR3GovF6lACo7eSWoreoj0ziJtq92tpUEQ4wdHcxoBoJLuqdU8
 Q0Q4MmkKvGWoBg4eHDZ4zyg/uVUyS3C5rOsTw6X5zkb0rs3SBgNwf8pJhjhwjj/6gy
 +6nWc65BtFjhs+7k4sT/derBjKiMHdYO+tUPpwIskuOQrdRimUpxuLjuMfiXu0S32Y
 myrB4BeG+Uo9A==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>,
	dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH v5 03/33] drm/atomic: Convert
 drm_priv_to_bridge_state to container_of_const
Date: Tue, 15 Sep 2026 16:14:02 +0200
Message-ID: <178948162526.1987579.5824374892587582733.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907-drm-state-readout-v5-3-5fa1ac7a5148@kernel.org>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
 <20260907-drm-state-readout-v5-3-5fa1ac7a5148@kernel.org>
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

On Mon, 07 Sep 2026 15:23:39 +0200, Maxime Ripard wrote:
> container_of_const is more flexible than container_of when
> it comes to mixing pointers constness. Switch to it.
> 
> 

Applied to misc/kernel.git (drm-misc-next)

[03/33] drm/atomic: Convert drm_priv_to_bridge_state to container_of_const
        commit: 7a4e435602c949c4a64e8cadfe816450953c2f6d

Thanks!
Maxime
