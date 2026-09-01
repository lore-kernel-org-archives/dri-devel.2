Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A322EC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9E3310EF25;
	Tue,  1 Sep 2026 20:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DZnp7Cb+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C71D10E308;
 Tue,  1 Sep 2026 20:29:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AF5F243C53;
 Tue,  1 Sep 2026 20:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38511F000E9;
 Tue,  1 Sep 2026 20:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788294550;
 bh=ItPrb8m+8Z75krTp11hhE6Jc3K1gPkj7qQ/v5ze/0As=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DZnp7Cb+mm1iS1vX2nH9QUjMDPPWrpfvCDM3ZbIQC0REkHUwO/19ZK5AmjML+IWpA
 sKqY07WnE394O1OfphCqtORuUbXwLb1uSRZ7RGkt/tLK7xUVF2RzclQJ99giNkREDm
 4mhoUSXOagxpB2o4CVe7zQzSXOusS8oIK/ojra3VAJgjKxERGjNIyQetisv51ta8GB
 ZPFslsUeOKlJxzG69AgC/6gRtaiuh1UNpT+9n5JJy50orhQ1hVOfXTGvvqyS9Ieq7N
 v/RgsOiFoBRCTI3pySCePHxaIGUTNRYklb+HPOK8lwSDG38p1e3rL8Xo1fIylumCMn
 8wEhPCCu0JyaA==
From: Danilo Krummrich <dakr@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>,
 Faith Ekstrand <faith.ekstrand@collabora.com>
Subject: Re: [PATCH v2] drm/nouveau: Use write-combined maps for coherent
Date: Tue,  1 Sep 2026 22:29:00 +0200
Message-ID: <20260901202900.6808-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821-tegra-coherent-wc-v2-1-2b1ddb67bf18@gmail.com>
References: <20260821-tegra-coherent-wc-v2-1-2b1ddb67bf18@gmail.com>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 21 Aug 2026 23:42:59 -0500, Aaron Kling wrote:
> [PATCH v2] drm/nouveau: Use write-combined maps for coherent

Applied, thanks!

  Branch: drm-misc-fixes
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/1] drm/nouveau: Use write-combined maps for coherent
      commit: 774b73428e6e

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for Linus's tree and should land in the next -rc release.
