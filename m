Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D396C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4D110ECBA;
	Tue,  8 Sep 2026 15:24:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K3q4EpWo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7AC810ECB2;
 Tue,  8 Sep 2026 15:24:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 492CF601F6;
 Tue,  8 Sep 2026 15:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754501F00A3D;
 Tue,  8 Sep 2026 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788881074;
 bh=PXr5c7hHW/s0gvhT0j+z4lGvWAuoX1i8hPPjZMT8+uA=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=K3q4EpWoRgrPNlSeSgNpfZ/yI6QNSgEXebIUQysMzS9lcIH6GnA9d+0Oz1u7sN0OB
 WERrfZHOKMY2L+Ydrt0DDGUdTDbpbJ5DiNxPrasZMSlnjVSLIh2Yy+/1QRUG1Q/DWa
 zdMa4xcP1MnmgzlZUBgnq8CwOyKsrQEEwEWNL0DhWzXvBMtPwu4h35DxY3oEVdUpKB
 VHwxn8hFD9QDqLSKZ/YlhZadelUmd2a6xg8ucp5Cck1Iyw28BmZbYm+9XGHt2/nmjE
 /d3DHkZ5GPFnHNdffFdImrqOmYWR9gUws86GEFky/8PpMqRkVdjVKlFt75OeHNj9sN
 g0prrKv5Lbk1w==
Message-ID: <027090776a56ad67876ade0f31039108@kernel.org>
Date: Tue, 08 Sep 2026 15:24:25 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 2/7] drm/client: Add acquire_outputs callback;
 implement for fbdev emulation
In-Reply-To: <20260709092215.168172-3-tzimmermann@suse.de>
References: <20260709092215.168172-3-tzimmermann@suse.de>
Cc: airlied@gmail.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dakr@kernel.org, deller@gmx.de,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 jani.nikula@linux.intel.com, jfalempe@redhat.com,
 joonas.lahtinen@linux.intel.com, linux-fbdev@vger.kernel.org, lukas@wunner.de,
 lyude@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
 sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tursulin@ursulin.net,
 "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: quoted-printable
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

On Thu, 9 Jul 2026 11:15:58 +0200, Thomas Zimmermann wrote:
> Add the callback acquire_outputs to drm_client_funcs to inform an internal
> DRM client that vga-switcheroo is about to switch the physical outputs to
> the client's device. Allows the client to prepare its internal state for
> the upcoming switch.
>=20
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
