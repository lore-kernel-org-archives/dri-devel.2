Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA1EC9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 16:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4876710E1D9;
	Sat, 26 Sep 2026 16:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AqQk3Jb2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D44310E1D9
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:39:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0EFDD6020C;
 Sat, 26 Sep 2026 16:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FAE1F000FF;
 Sat, 26 Sep 2026 16:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790440781;
 bh=VD5Gm+hR15ohJ5wVTjgweg6mMAFFp2xYQK7jmt6Fwt0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AqQk3Jb2AMUp39KSzyyV2ZYAtxsdRvTSqT2kCAmjswk0HtltsP0xeAqrnGfFG+t+z
 tuY1grYCSWc+v0N6lsYq+WZdFUfTROdk+01ezQ7Z/Pbfj/I/ZiGycjO9Sre48LAmta
 0LpdRsJW4V5LziTbdYsHVKorHezvZ9GkPamb+ZeLsfsn4XAAiFLoUJlixcpiHtkf+d
 Kj9pcs2HJFWj1J+S1wBA3JGI/7zpymHSwypAUXgz1JvN9nXSQF6sgxtk8JrE+fGx4L
 yaNlIo6dHrN2AznsNLr8mf9TwRRpR1NsSg2r35n8c5s9c1FQCQ6L3lByBLmRoLtTf8
 0803ndnE8hCVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] drm/qxl: wait for pending commits before
 applying DirtyFB
To: "Dillon Amburgey" <dillona@gmail.com>
Cc: dri-devel@lists.freedesktop.org, "Eugenio Perez" <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260926163123.39217-3-dillona@gmail.com>
References: <20260926163123.39217-1-dillona@gmail.com>
 <20260926163123.39217-3-dillona@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:39:41 +0000
Message-Id: <20260926163941.76FAE1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> The modeset locks protect software state, but a nonblocking commit can
> swap that state before its hardware updates finish. DirtyFB can then
> race primary-surface replacement and draw into the preceding surface.
>=20
> Wait for the current CRTC commits while holding the modeset locks before
> checking the primary and issuing dirty updates. Return wait and lock
> errors to the caller instead of reporting success.
>=20
> Fixes: 9973c879cff7 ("drm: qxl: Atomic phase 3: Wire up atomic page_flip =
helper")
> Assisted-by: LLM sparse
> Signed-off-by: Dillon Amburgey <dillona@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163123.3921=
7-1-dillona@gmail.com?part=3D2

