Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654A760A2605
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmWgsbwA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD43610E10A;
	Tue, 20 Oct 2026 08:56:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB29010E10A
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:55:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F44D43639;
 Tue, 20 Oct 2026 08:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090AC1F000C4;
 Tue, 20 Oct 2026 08:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792486559;
 bh=sdNaoVSRuGZpGug/DK6AKDScm0L5vKpD110CMZcWZBE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nmWgsbwAIgJnmmPfeTwzZvOKWfuxsBYnYGAP4QVf+75YOZKM+R4nz74AbmledcGnK
 gODFHcOXfzrNyZTjztWdT75yf2Naj7epndP0uzJBHLnvzYoZtNJXexcFLwO8paQ3Mm
 9z78gclw9xIVRIzPv2aoPROmFXQfAjmpZt9pSIwsOOVmPfW8DLpd+OGE+8uMRiV6J0
 Qmox650orB0WXCRXulBh5yMtyQARAcGbQdKoDH2B1L6hJ6Cxy2xVtudpoRpjWyy4eK
 cWJcyWCzqgVprWsd/fMCQIpzu0J3mtJHUu3LmzgUelf26MtAYUxxPeM5i6cgCkm/6N
 aWB4/OuuiiA3A==
From: Maxime Ripard <mripard@kernel.org>
To: Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v2] drm/ci: Add CI pipeline for drm-misc branches
Date: Tue, 20 Oct 2026 10:55:53 +0200
Message-ID: <179248655167.2849206.582866226743194201.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-drm-drm-misc-ci-v2-1-1847f89585cb@kernel.org>
References: <20260911-drm-drm-misc-ci-v2-1-1847f89585cb@kernel.org>
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
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 11 Sep 2026 14:18:04 +0200, Maxime Ripard wrote:
> The DRM CI infrastructure builds upon Mesa's CI to run IGT tests on
> hardware. Its focus is on functional testing on a selected number of
> targets.
> 
> The concern for drm-misc is different: it merges a large number of
> patches across many platforms, and build or unit test breakages happen
> on a regular basis. Adding build and unit testing for drm-misc has been
> on the back of our minds, and a first attempt was made last year. The
> feedback was to rely more on the existing infrastructure.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next)

[1/1] drm/ci: Add CI pipeline for drm-misc branches
      commit: d1025d345b21261ddc10e598ec736aa5875aedbd

Thanks!
Maxime
