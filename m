Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5094CCC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8755F89070;
	Thu, 15 Oct 2026 14:47:16 +0000 (UTC)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B499B89070
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:47:09 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id B2C4C1F90C;
 Thu, 15 Oct 2026 16:47:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1792075626;
 bh=Vyrg04IdV6YTuudUHDorKqPJHiwj0+rhGH0L6LDMbCo=; h=From:To:Subject;
 b=nsJkExFOd+ol+Gbg9biHjB0d6fVRlTVJ7XD/5l++G8Zd9aLABJz4Q8r01z7cXhz/b
 XBcP5+ivKyccbiSSNj2kn4l2bXEak0VHqpudbPSF1gs4oqeLME0FYFUHmzIqurPJKM
 QN8CdSRkahSziTghDJmeR/f9SBqInrYDvzqcJK2rV9QGIK7nFfeow36QXvcJZ38OeR
 MAIfyemUM2o70Q3aZlwfvCCilSidjz3m/WTzJ/MLQ85AcyksQSqsNsI5PP1quzIsdA
 9sUveEQkcKSWrjVDB8Rima5zGYBGVidqT1PN7ox5592N7OjaohNYVPOwmem6K2yUr/
 tRTci8N2biW3Q==
Date: Thu, 15 Oct 2026 16:47:02 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH 11/75] drm/bridge: lontium-lt8912b: Switch to
 drm_atomic_helper_connector_create_state
Message-ID: <20261015144702.GA140066@francesco-nb>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-11-586c9c026823@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-11-586c9c026823@kernel.org>
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

On Wed, Oct 14, 2026 at 07:26:34PM +0200, Maxime Ripard wrote:
> The bridge: lontium-lt8912b connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
> 
> Switch to drm_atomic_helper_connector_create_state() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

