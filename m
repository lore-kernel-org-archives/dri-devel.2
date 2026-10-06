Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36046CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4854010E307;
	Tue,  6 Oct 2026 13:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="oaZxjX13";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E657910E307
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=cuBXybBUoDkg6+ydTmReZGyM4NMPu0ZgI71jNBcqLlw=; b=oaZxjX136cx5v4tV8vk3rr3UPH
 7FuP+xqtsTrFOCzKDXew16n8q5k2MAUZz2XcWCb8GsKGziY9zOHbOUYeWC+YMqsBjcs4HVMu0JLfl
 gntMjK2BKH/oVOdMuInZFnvTlvlXnjDb3Sj20CN/tF6JmZBXFCc2XRLpNXc/g9rfN0dFxYLSvQH4L
 FnTroKxPK7G547IiX43kQ8Jl6Jeb9Vo4aMVNu+200w9Yk9oaVm693jEsquBRy/GlAC3aJQMONbKYy
 ekXfV1eoMD53k3gSj9gdKTVzbnL6BzbSl95Nh7mzCJfbTQYnG5ch6+F/MyXIJSLvCVfdnY+aMUz8D
 gXyCIm/A==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xE5e9-00CyrJ-Ju; Tue, 06 Oct 2026 15:55:58 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Drake <dan@reactivated.net>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/vc4: Set DRM DMA device directly from HVS and V3D
Date: Tue,  6 Oct 2026 10:55:29 -0300
Message-ID: <179129492581.2506814.16927758002559575379.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004-drm-dma-device-2-v3-1-45b121ab819f@reactivated.net>
References: <20261004-drm-dma-device-2-v3-1-45b121ab819f@reactivated.net>
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


On Sun, 04 Oct 2026 19:24:45 +0100, Daniel Drake wrote:
> vc4 uses of_dma_configure() during bind to set the DMA configuration of
> the drm device by borrowing the configuration of one of its component
> devices.
> 
> This violates driver model expectations that IOMMU probing and domain
> attachment occur before driver binding - see commit bcb81ac6ae3c ("iommu:
> Get DT/ACPI parsing into the proper probe path").
> 
> [...]

Applied, thanks!

[1/1] drm/vc4: Set DRM DMA device directly from HVS and V3D
      commit: b0a6b769cc174dd9fd154270f78acf72dc3e5c7e

Best regards,
- Maíra
