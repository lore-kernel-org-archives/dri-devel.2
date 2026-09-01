Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506F3C624D2
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B79310EACE;
	Tue,  1 Sep 2026 12:38:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NtnnX+AQ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8BD910EACE
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788266287;
 bh=t6gp/ZegTeXdNL/BzhBDyU250Dh0osTv3SphAvKOI50=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=NtnnX+AQ2v169vtHTrrq10rkPda4iynNjVGe6M1N0u2ndUOaXtrcBhSiLXNfDbWz1
 n0Qh/fT7bYuan0Y2TXJ2jqZnVkut8eiSnn1woUBawm9JhZqZyD6DgIC9SdGHksXGzW
 fyUMcSXcLX7fOpLliFQTSLD/ndudSF3CVP/I2nTXasCjJFMxGvQ//fZY1sSuiD8FY5
 WXg8995Etv4P3VIX1FEmzZoIg209o8azdfXMtpH6/tFgiEaMNMxEdliKJaf/c10stv
 ayaSNOv8bmloGyjj8AVL3MiWHQkqMckxHl1qQAtun1mxUL0TmIKar/WQWHot64Xdrs
 gafYQkhxL4Hwg==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C1E8217E0934;
 Tue, 01 Sep 2026 14:38:06 +0200 (CEST)
Date: Tue, 1 Sep 2026 14:38:03 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 06/17] drm/panfrost: Consolidate device clock
 management and reset
Message-ID: <20260901143803.22ae33c4@fedora-21.home>
In-Reply-To: <20260828-claude-fixes-v7-6-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-6-72a13b2c125d@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 28 Aug 2026 21:56:46 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Gather all clock enables and disables into a single function to avoid
> repetition. Also, as part of the same function, handle reset control
> (de)assertions, since that was already the case in the PM runtime
> functions.

I think I'd prefer to not mix clks and reset-lines. So basically, a
set of helpers that deals with clks (panfrost_clks_{enable,disable}()),
and manual calls for the reset line.

>=20
> Also do clk (un)prepares and dis/enables at the same time, since the
> clk_prepare_* family of functions can simply increase the refcnt of
> an already prepared clock.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
