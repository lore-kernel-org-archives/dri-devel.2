Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1A4CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 14:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD0910E02C;
	Sun, 11 Oct 2026 14:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fESdRv/P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E84B10E02C
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 14:15:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA64660142;
 Sun, 11 Oct 2026 14:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF7B1F0089B;
 Sun, 11 Oct 2026 14:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791728107;
 bh=tMb+fCTPASOG+FUIG96jLuenOHATpxK+gnhKNBdRgeI=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=fESdRv/POaGngqe2fampDQOt0VE9ZJhnqCICpyHvceCq3QgaDG/8qxV9O9Uyy3x4t
 92+dQJCAwVSEBhJqWasz6WmE8lLuY0cnHRBhaw1gsxGFPXTFVpRnKxY9Ca3rVZ7BHG
 jnZ2x2gMID87mLuv+wrhiWAgGX1BU9FdhTYMrL90tsV1tHVjm4XDWvtA/FI52Ae6+0
 jp6m3yK8deErnGAGsUPbOBG8Qyo0D8sFFlugmAcmuQHFylbNc4FDUiCmvPcT1n0wuL
 tE8Me0Gh1VMH2CTi3pYgcJiqrhuFNewEpqoE9BEXKJDBZsb3+e8m7+aFbN8To8Yznc
 ZprmosSCp1qMA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 16:15:04 +0200
Message-Id: <DM22LS0S86HB.2G9NWE78JHV0@kernel.org>
Cc: <sashiko-reviews@lists.linux.dev>, "Alexandre Courbot"
 <acourbot@nvidia.com>, <ojeda@kernel.org>,
 <dri-devel@lists.freedesktop.org>, "rust-for-linux"
 <rust-for-linux@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/7] rust: drm: gem: gate open/close callbacks with
 RegistrationGuard
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-3-dakr@kernel.org>
 <20260814232106.01AA71F000E9@smtp.kernel.org>
 <E989BBD7-DF97-4384-AFC1-3D7448A1C747@collabora.com>
In-Reply-To: <E989BBD7-DF97-4384-AFC1-3D7448A1C747@collabora.com>
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

On Fri Oct 9, 2026 at 7:39 PM CEST, Daniel Almeida wrote:
> I wonder if this is a problem in practice? And if so, would passing a e.g=
.:
> Option<&File> be a solution?

No, it's not a problem.  The callback is only ever skipped when the DRM dev=
ice
is unregistered; this implies that the drm::File and drm::Registration priv=
ate
data is dropped. I.e. there is no data left the callback could do anything =
with
in the first place.

> From a purely logical perspective, I do agree that a balanced open()/clos=
e()
> makes more sense than silently skipping close() though.

close() is a pure optimization callback, e.g. to unmap memory that userspac=
e
can't reference anymore anyway.  For the reasons mentioned above, providing=
 it
to the driver after the DRM device is unregistered is pointless, and callin=
g it
when unregistering the DRM device would be pointless too, as any data it co=
uld
ever access is dropped at this point anyway.
