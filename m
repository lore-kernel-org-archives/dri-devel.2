Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FD9C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934C110E17F;
	Fri, 14 Aug 2026 16:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cv2hHrav";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38DD810E17F
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:49:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C5D6141AEE;
 Fri, 14 Aug 2026 16:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1C91F000E9;
 Fri, 14 Aug 2026 16:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786726193;
 bh=iPbONPrWn9DI8bqdIN7E4h7pgVze/LgeRsXKs+sHhkw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cv2hHravD1251BFNvuHokHsEsnwO6RMVd4aaGFUbrFHNFgAkaype5DJoBL4qgCgWY
 ebfQtJtGIGTv9pQpQkTN5Fss09TtxGHLIMVxAlLJpOg1sJOaMST8tXKPag+Z+osCB3
 fiUvjC3+hOlN8CEQ9YjtLLnLHBwUmuqxPH+GxdqzM+2L3Y+wP92pZbw8EnmKqYHVuu
 ntoglVIjDtoyujv/Xjk4jbJP+YfUIl+BG8ekDqHF4e/uO4OOihukHhcfQ6IVBLDXKh
 tUgN3ewBN/WYu4fQA/+wdCtAFu3u62NsgaTLq7woyptPlxKKnETwXru6xL6aH/pe8m
 cdBv02faMA4Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] drm/edid: parse HDMI 2.1 gaming (ALLM/VRR)
 capabilities from HF-VSDB
To: "Fangzhi Zuo" <jerry.zuo@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814164344.3098143-3-jerry.zuo@amd.com>
References: <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260814164344.3098143-1-jerry.zuo@amd.com>
 <20260814164344.3098143-3-jerry.zuo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:49:53 +0000
Message-Id: <20260814164953.7E1C91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Kerneldoc comments for `struct drm_hdmi_vrr_cap` refer to non-exist=
ent fields `@mcnmvrr` and `@mcinema_vrr` instead of `cnmvrr` and `cinema_vr=
r`, and contain minor typos.
--

--- Patch [2]: [PATCH v4 2/4] drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) ca=
pabilities from HF-VSDB ---
commit c7bd732acb69a8a5eeca4f1e80e71d88085a1ae5
Author: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>

drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from HF-VSDB

This commit parses the HDMI 2.1 gaming-related capabilities from the HDMI
Forum VSDB (HF-VSDB). It exposes them through struct drm_hdmi_info and
adds a new struct drm_hdmi_vrr_cap to describe VRR capabilities.

> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index cd06a3b914a03..9f8f109c2dd1f 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -254,6 +254,44 @@ struct drm_scdc {
>  	struct drm_scrambling scrambling;
>  };
> =20
> +/**
> + * struct drm_hdmi_vrr_cap - Information about VRR capabilities of a HDM=
I sink
> + *
> + * Describes the VRR support provided by HDMI 2.1 sink. The information =
is
> + * fetched fom additional HFVSDB blocks defined for HDMI 2.1.

[Severity: Low]
This isn't a bug, but there is a typo here ("fom" instead of "from").

> + */
> +struct drm_hdmi_vrr_cap {
> +	/** @fva: flag for Fast VActive (Quick Frame Transport) support */
> +	bool fva;
> +
> +	/** @mcnmvrr: flag for Negative M VRR support */
> +	bool cnmvrr;

[Severity: Low]
This isn't a bug, but does this kerneldoc mismatch the field name?=20
The documentation uses @mcnmvrr while the field is named cnmvrr.

> +
> +	/** @mcinema_vrr: flag for Cinema VRR support */
> +	bool cinema_vrr;

[Severity: Low]
This isn't a bug, but similarly here, the kerneldoc uses @mcinema_vrr=20
instead of cinema_vrr.

> +
> +	/** @mdelta: flag for limited frame-to-frame compensation support */
> +	bool mdelta;
> +
> +	/**
> +	 * @vrr_min : minimum supported variable refresh rate in Hz.
> +	 * Valid values only inide 1 - 48 range

[Severity: Low]
This isn't a bug, but there is a typo here ("inide" instead of "inside").

> +	 */
> +	u16 vrr_min;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814164344.3098=
143-1-jerry.zuo@amd.com?part=3D2
