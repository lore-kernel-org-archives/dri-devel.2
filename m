Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F586606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=EPhaMfec
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B093110E623;
	Fri, 23 Oct 2026 12:53:29 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DE3010E623
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792760001;
 bh=YkBcRcfcoP4qWdvjhMUSL1em+0uRO6/4DhTUss/sluU=;
 h=From:To:Cc:Subject:Date:From;
 b=EPhaMfecjbtd2477VZf+r8nFKp2DebRPcHZjTONw8bFTbI0iY51xYzh23xD0JsUXw
 kSIchlFVVmc6fvnYrgSvo2ajLFgN/r6NxNXxHs9YkDmPZ843OBKrJ0Bp1g8Z4dM6+z
 xD2iTCY+d1UR+TTHg3M2vgjSyu0UbAElj/HDMnCtVpxyGStm7Mj3ZIh5ElbIBRgrdX
 YJYcAIX82+6LLH2T8B1pvih4zOWDmJzAe2qGiV5DNHdvTZOqlb3KX0o3Jse8AVr3kp
 8/qVf9o61GqcrGF31X5z5YGxER0rRcTY1HiyjdkZ2TUxqDNBR/nt/Pcg3jKvWAmumI
 +/lobSUZPv/Cw==
Received: from reinforced (unknown [100.64.0.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: daniels)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6652417E03FF;
 Fri, 23 Oct 2026 14:53:21 +0200 (CEST)
From: Daniel Stone <daniels@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: boris.brezillon@collabora.com, laura.nao@collabora.com,
 adrian.larumbe@collabora.com, daniel.almeida@collabora.com,
 liviu.dudau@arm.com
Subject: [PATCH v3 0/2] drm/panthor: Consistently delegate shader power
Date: Fri, 23 Oct 2026 13:53:10 +0100
Message-ID: <20261023125319.35905-1-daniels@collabora.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,
When trying to bring up a v14 platform, one trap I fell into was
inconsistent power-domain delegation. When delegating a domain, all of
its child domains need to be already delegated, so the firmware can
exercise effective control.

We unconditionally delegate the L2 domain to firmware power management,
along with the tiler and shader domains, however the neural-engine power
domain is also a child of L2 and not delegated. Failing to do this
results in the firmware going into a loop when attempting to power up
the shader cores for the first time.

Changes in v3:
  - fix error-unwind ordering when retracting domains

Changes in v2:
  - send the patches from the right tree so they actually compile

Cheers,
Daniel

