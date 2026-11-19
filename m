Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C66A606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5BmaewV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6267810E23A;
	Thu, 19 Nov 2026 13:33:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 228FD10E23A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:32:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E99963633;
 Thu, 19 Nov 2026 13:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E6A1F000C8;
 Thu, 19 Nov 2026 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795095173;
 bh=Ibjc8kqEvblB/tzyUxSJt8so1KQch3X8+96BOlcy7c4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=h5BmaewV7AT26YYeLWQlUYUyV0KRkNHu3YiRsl+efLw6OcSSUSxoMkyBDSGcn2nQs
 0QQYbbqYxQGTFMiTcmLA0G7fON9Ool+HVyiAUoee6rCxwzDPozQHAz3U/4IXH82bVg
 btV7AzCGBQ/qZZ7umJ199IOr9Ebpl5C7frgzAACWzFGH6WjdMigCjyTv5aO2Zz9G3S
 bjONVoCEHLlVakfP/cV2JLjKmzlAFEnR+h1WODcdy3inynweezvYaGx86fyd3yb4CS
 uMQMfHI6vjtEU4wGCdfo8VPTIZo1uHFWoLnRBsMkU789mXQnqh/2Qud2f/aH0pCYZG
 8kvYHZmgySmaQ==
From: Maxime Ripard <mripard@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/7] MAINTAINERS: Move armada DRM under drm-misc
Date: Thu, 19 Nov 2026 14:32:48 +0100
Message-ID: <179509516367.519411.14007804106890887602.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261105142127.708219-1-mripard@kernel.org>
References: <20261105142127.708219-1-mripard@kernel.org>
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

On Thu, 05 Nov 2026 15:21:21 +0100, Maxime Ripard wrote:
> The armada DRM driver has its own tree entries in MAINTAINERS, pointing
> to Russell King's drm-armada-devel and drm-armada-fixes branches.
> 
> However, the last pull request from that tree was sent in July 2019, and
> more than 80 patches have been merged through drm-misc since then.
> The driver is de facto maintained through drm-misc already.
> 
> [...]

Applied to misc/kernel.git (drm-misc-fixes)

[1/7] MAINTAINERS: Move armada DRM under drm-misc
      commit: 3271e518ed7f786ee7fe8dcc97bc51493127b79d
[2/7] MAINTAINERS: Move Keem Bay DRM under drm-misc
      commit: cc2b377111c158d8559498102fc81ebe74c184b6
[3/7] MAINTAINERS: Move Tegra DRM under drm-misc
      commit: 7ee2d18acb3f5a770b6bc96d45cd18a1dfccecf0
[4/7] MAINTAINERS: Remove Jonas Karlman from bridge reviewers
      commit: bbc18d8620a6ad7011a43bebf9e48037393177e2
[5/7] MAINTAINERS: Remove Andrzej Hajda from bridge maintainers
      commit: 6d62f036a554c60131d7872914fa752e08e9b527
[6/7] MAINTAINERS: Remove myself for VC4 DRM driver
      commit: 7620e93a9d5a5c36636bd97c1fc734bbb27132f6
[7/7] MAINTAINERS: Add Dmitry Baryshkov as bridge maintainer
      commit: 8f4557137542a343ce12ea5ca02b63e36f933cac

Thanks!
Maxime
