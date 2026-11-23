Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10953606A332
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHo9XLlW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F09810EF9C;
	Mon, 23 Nov 2026 16:34:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ECCF10EFE5
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:34:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CDAD61B20;
 Mon, 23 Nov 2026 16:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8641F000D2;
 Mon, 23 Nov 2026 16:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795451681;
 bh=k6ik7b3Wu505/fmtIFICmTXA27T4QVBi8Qs06F9TrW0=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=kHo9XLlWwiCnxwxe2ET0kxB7kuAHZuu7NK5JPOcC/x4YjlQ32Z2jbqi9x8e5sQUs2
 rFt5cX4ZuOHnUkdkB/o50qM0C5YCph2A6gWU8/78SFW634swZSJWNnC1a4F5dIJ4vK
 Ovls5WnjdJoxG/hPtukYj368pvB8f0XqsAtRpD+4yVqhzfXbWoHFKZtDE7e+dQQNqT
 BcZbScqxbesWQ51b5F6i9pINDNNNReBZEtitgZY/9c2o1QfDj32DkqrisUSQ8H3SoU
 c8AuWHCpthDbSJbMa93LaeJzHgz5FBGPqIMO84p9shf/zE8T8op3KDK8OPutEXVljY
 cm1d3+Q5cB1bQ==
Message-ID: <e1f51916a704096cf8e26711d4e7c793@kernel.org>
Date: Mon, 23 Nov 2026 16:34:39 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 20/25] drm/tests: hdmi: Add SPD InfoFrame vendor/product
 coverage
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-20-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-20-20e8a33a2286@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Hans Verkuil" <hverkuil@kernel.org>, "Helge
 Deller" <deller@gmx.de>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Martin
 Bugge" <marbugge@cisco.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Maxime
 Ripard" <mripard@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thierry
 Reding" <treding@nvidia.com>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

On Sat, 14 Nov 2026 20:03:44 +0200, Cristian Ciocaltea wrote:
> The vendor and product strings provided through struct
> drm_connector_hdmi_funcs end up in the SPD InfoFrame, whose fields are
> defined by the HDMI specification as fixed-size: 8 bytes for the vendor
> name and 16 bytes for the product description, padded with zeros and
> left without any trailing NUL when a name spans the whole field.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
