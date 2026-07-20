Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD638C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F8B10E919;
	Mon, 20 Jul 2026 13:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JolGGOex";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724E610E919;
 Mon, 20 Jul 2026 13:04:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 81D3060A80;
 Mon, 20 Jul 2026 13:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD98C1F00A3A;
 Mon, 20 Jul 2026 13:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784552694;
 bh=ISsGvIfiVmCTmpBk17+CxNOpuAPZuqtsfciv62CwcyI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=JolGGOexPicnfnErFSAn/d0jmybfzVKbMPFtTGBWBI9gY0GlJLD5IKQEZrCm5ezuv
 tZZ3x74Pur4I5yLFBe+CBpQ/nkZ+E866N6QM3GazmNC99hjZ8+IrdLXegfctA6oWdd
 daaV1yYFdiTwoEi7B8RG5sZVOwwuHZe57aBK35fm2XPOt6tjCYs9MgA1OKEREi8rMl
 xVGlwZQz8KbKepXqoGl48aD2SEwrkFPUMAXmGMS9kYljVXvgGVrBSHKNXGaGCCHicj
 QGBti7p5s2Jb6JiEFhqJEgKSXvUUAamXEXRMSaWescmtPxSoDWc+hPsYaNyzOfXS3m
 lQdm3WuluL6eA==
Message-ID: <b7f4445b-8108-4d2d-817c-3c8cfbc904c3@kernel.org>
Date: Mon, 20 Jul 2026 15:04:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/nouveau: Use named initializers for
 i2c_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kees Cook <kees@kernel.org>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <cover.1784545092.git.u.kleine-koenig@baylibre.com>
 <7d6033270daf9ff409b427897cb8218f9a69048a.1784545092.git.u.kleine-koenig@baylibre.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <7d6033270daf9ff409b427897cb8218f9a69048a.1784545092.git.u.kleine-koenig@baylibre.com>
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

On 7/20/26 1:25 PM, Uwe Kleine-König (The Capable Hub) wrote:
> Named initializers are better readable and more robust to changes of the
> struct definition. This robustness is relevant for a planned change to
> struct platform_device_id replacing .driver_data by an anonymous union.
> (Though these drivers don't use .driver_data, so this patch isn't
> strictly needed, but still good for consistency.)
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
