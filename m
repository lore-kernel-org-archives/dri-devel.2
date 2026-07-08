Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A34DC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94BBF10E621;
	Wed,  8 Jul 2026 16:28:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pjj8Wk5q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C16110E621
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:28:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF44F40B31;
 Wed,  8 Jul 2026 16:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0C71F000E9;
 Wed,  8 Jul 2026 16:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783528116;
 bh=XpiaCvBcRSVe0aJ70fnXRFoJ2U/2HD+Ywbrl2kVCn34=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=Pjj8Wk5q6MdmXQYuw9MWwtJ2El98jvspzfj6cmGKeNUhRSQPWiTessd5wC89OhjiA
 9cvcPLhvffRXWMsnevOJ1n5B6cv0jXp4LbH1tY4d3cf5YzI0n/EtK8O/yFZXZSdLA3
 xoVL0zVWc3YhEn1YRdGWNfGUZbgI2eiDfdrHYjZTv5YGRdta5GH4FvuVSOYM544XSX
 Wax7imOlxgMjAJNXoOxYnnggOXn9E1SMWGHMX//hQ5hrM8GGjd0HpPdSR9Q1M4NIOU
 u+jbSY5XgHmrCLtusp51QqVmPpgMY64/aAGn1urpeq9h+DycvkgmHbmC42EqrE0FkG
 8pO0YlOzP8iIw==
Message-ID: <99f0b52f6a723f2a548a5b06deea957b@kernel.org>
Date: Wed, 08 Jul 2026 16:28:34 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v4] drm/fb-helper: Only consider active CRTCs for vblank
 sync
In-Reply-To: <20260702145021.226932-1-tzimmermann@suse.de>
References: <20260702145021.226932-1-tzimmermann@suse.de>
Cc: airlied@gmail.com, akemnade@kernel.org, dri-devel@lists.freedesktop.org,
 hns@goldelico.com, jani.nikula@linux.intel.com, javierm@redhat.com,
 kernel@pyra-handheld.com, letux-kernel@openphoenux.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, sashiko-reviews@lists.linux.dev, simona@ffwll.ch,
 zhengxingda@iscas.ac.cn, "Maxime Ripard" <mripard@kernel.org>
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

On Thu, 2 Jul 2026 16:50:13 +0200, Thomas Zimmermann wrote:
> Only synchronize fbdev output to the vblank of an active CRTC. Go over
> the list of CRTCs and pick the first that matches. Fixes warnings as
> the one shown below
>=20
> [   77.201354] WARNING: drivers/gpu/drm/drm_vblank.c:1320 at drm_crtc_wai=
t_one_vblank+0x194/0x1cc [drm], CPU#1: kworker/1:7/1867
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
