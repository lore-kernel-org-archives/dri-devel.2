Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01303606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9TdZpTi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 697EC10E58B;
	Fri, 27 Nov 2026 13:25:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F7CB10E58B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 13:25:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 67A8A62C0F;
 Fri, 27 Nov 2026 13:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5671F00899;
 Fri, 27 Nov 2026 13:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795785942;
 bh=T3Qakc0DoWKnOnFUhpua5bH9wcPAgnn0/TDdTHiHRDI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=C9TdZpTitZRrT3yoi03kFgVOZ48FSLjdYvuhaBMdQknmg6xRN0hWGXzmG+aMY/Cw1
 8pzmD+z9OZpAdHPjlzeHC88L27XoCgTeh/NXME7BtkDOLobqJICwRNsNxbQfj5zlsT
 a3iwvWHUBUxaEu84dJ8oqNaZaMIHNhBjH85VjDPisHdAgaSZLHhUJx8AFAIbBSeWZJ
 CurJZr19Zj+8XRjQgnA1s6mI4/Iwdgn67SbExSgRrDa/fluBGcktSFY88y6/8X3lKt
 RacPbaBRwbZQ5VqPce+AjDz552R3xYQ8RSYXi80rHsgqVht0zfvg1xGGbqGt9jkJOA
 dWsxVGuoiXf1g==
From: Maxime Ripard <mripard@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Robert Foss <rfoss@kernel.org>,
 Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Luca Ceresoli as bridge maintainer
Date: Fri, 27 Nov 2026 14:25:36 +0100
Message-ID: <179578591795.2876180.4302250564876415366.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119133533.520180-1-mripard@kernel.org>
References: <20261119133533.520180-1-mripard@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 14:35:33 +0100, Maxime Ripard wrote:
> Luca has been one of the most active reviewers of the DRM bridge
> subsystem without having the maintainer status.
> 
> Add him as a maintainer to match the current situation.
> 
> 

Applied to misc/kernel.git (drm-misc-fixes)

[1/1] MAINTAINERS: Add Luca Ceresoli as bridge maintainer
      commit: 8dd87427ed90d53f4dc1787948a1124d5e219bc1

Thanks!
Maxime
