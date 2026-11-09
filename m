Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF7B606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=NW7ei05y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C25B10E243;
	Mon,  9 Nov 2026 20:20:59 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA31110E243
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 20:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794255651;
 bh=8QMmlJOyXYlkKm0qbr8+Mg9iII8ZAXA3eOsqDxVO/1w=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=NW7ei05yK1PBmE5ViCWK6tUV0mV3vMfhGFrcViShk5+pP1bJnhtX2F1/ZptB6GOOd
 Tg4Co234NOUFYxFsiLy/LkRdykrl/QrqVdLyo0W7pRZuf16oh+2P8YZ8P86vaS2jnp
 GezkwiNZ7SeKfB7sPmZ6UDyNSfTql+kgkZU9GnPHnAltiv2etmGpxHSi4EjhMpCn+L
 GttjhmwdRP6Gp9rt9cRp/NKOyRzMCZ8VsqZghR6DH84zVvHvIaesomYNglK34MJnks
 b5PwNTiwjNPkfI3lAeD3ZdlnhBSoHwrMit3vo2hpx1KZ9EdGZ4EX4b9yhDP2mcSmDM
 PwwxQ3YZettrA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DB8D317E0DC3;
 Mon, 09 Nov 2026 21:20:50 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20261104-hdmi-scdc-scramb-fixes-v1-0-16a9bb3d64a6@collabora.com>
References: <20261104-hdmi-scdc-scramb-fixes-v1-0-16a9bb3d64a6@collabora.com>
Subject: Re: [PATCH 0/3] drm/display: hdmi: Fix SCDC scrambling corner
 cases
Message-Id: <179425563470.412379.16294380759448058422.b4-ty@b4>
Date: Mon, 09 Nov 2026 22:20:34 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-36e3f
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 04 Nov 2026 15:26:19 +0200, Cristian Ciocaltea wrote:
> This series fixes a few corner cases in the scrambling helpers
> introduced by commit d653818324ed ("drm/display: hdmi: Add HDMI 2.0
> scrambling management helpers").
> 
> Patch 1 fixes a potential NULL pointer dereference in
> drm_connector_hdmi_sync_scdc() reported by Smatch.
> 
> [...]

Applied, thanks!

[1/3] drm/display: hdmi: Prevent NULL pointer dereference in sync_scdc()
      commit: 6e73b637dc16953067635d9ba2019f5645092217
[2/3] drm/display: hdmi: Use committed state to decide on SCDC resync
      commit: 59d532e39ea794ba6d0f8e8acd1ea4fb20d27877
[3/3] drm/display: hdmi: Reset sink scrambling on non-scrambled modesets
      commit: b4146c6155b1efefe8caa604ed9cc7a2673f8591

Best regards,
-- 
Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

