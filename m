Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6A9C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4BE410EC54;
	Tue, 30 Jun 2026 12:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yt/5L7H/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49B9810EC54
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:37:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DED4A42D7C;
 Tue, 30 Jun 2026 12:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3541F000E9;
 Tue, 30 Jun 2026 12:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782823075;
 bh=gFrSgFmeb/xqCopXlwbbqo/0obZElfXwNWbu9ZgZAes=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=Yt/5L7H/IkbJ9HNCJOdZa23vVb/ZtSnHchmYg+O3goLpkPlSXZpYXob7ZCcB/3dIL
 TUl9LNgwWQNx527FTikZLkkz3u9bW5U5/VcwQnkW64KB/061DouY40i3ITsBDfpWG5
 cF2oCQnEkUZ648ANOj0HejnPcVkywnjSwNY4UmSWADyjLg2GwaF4ZNvjq3uPquvVIL
 XKp8LdwYFmIUAoCALE7z3PMSPeUZtbpToOlz6y3Cn5qtQsuooA8EeBSWhrRoGmh5sv
 3Q/Pct2EoLle52uw8PfTNHu2qVs+i7VTfFh6qP1EarbnGLq/wrLfVw8392mSHz9t1p
 FrPmsXWXe4PEA==
Message-ID: <b10ed22795de18c499f444e3ce8f3756@kernel.org>
Date: Tue, 30 Jun 2026 12:37:53 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Romain Gantois" <romain.gantois@bootlin.com>
Subject: Re: [PATCH v2 1/2] drm/logicvc: Avoid use-after-free with
 devm_kzalloc()
In-Reply-To: <20260630-logicvc-uaf-v2-1-99e881833860@bootlin.com>
References: <20260630-logicvc-uaf-v2-1-99e881833860@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Jason Xiang" <jx@jasonxiang.net>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Paul
 Kocialkowski" <paul.kocialkowski@bootlin.com>,
 "Paul Kocialkowski" <paulk@sys-base.io>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
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

On Tue, 30 Jun 2026 11:10:10 +0200, Romain Gantois wrote:
> The logicvc driver calls drm_universal_plane_init(),
> drm_crtc_init_with_planes(), and drm_encoder_alloc(). These functions
> should not be called with structs allocated with devm_kzalloc(), as this
> can lead to use-after-free bugs. In fact, a use-after-free caused by this
> has been observed on a v6.6 kernel.
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
