Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9C5C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C09B10EA46;
	Tue,  4 Aug 2026 13:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LE+/rcxo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B7B10EA46
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 13:27:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5194160A59;
 Tue,  4 Aug 2026 13:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5731F000E9;
 Tue,  4 Aug 2026 13:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785850044;
 bh=qzXq0pqmRjCnOp4G2VLSJ63Tvv/QL4yQDKopapWlB8E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LE+/rcxou2r7EC6876+XMrdC34+AhHB5FdkE3uwmLjkkzuBg2in7ykV+rJNCuzxU3
 CVWw/S1THSxHgPgNy2Pmwfha0kwL7aYQ5pma1zXMJl0DL/cnFbi+2OjU2cg6g1I5bW
 uL8/eKPZ6n8bZGLQzjNAv4ZfGGT311XTc8vhLOvby4EWfjZbc5Apg96BRz+YQBVr7G
 WeMcT0AUnlZaiRM7/2YVjSUUeXHiHSOXXWRNNCr150uIHBWbv+gTC/1RdobQrDExqp
 a+rEpyz9SSBPFrYwH5O1r83DMTxwXNi8vmDCFn3qfR8c5QqTr+G0Nc8uhKVtrBjKAK
 +P3GJkQaQZ5rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] drm/panthor: Add fine-grained restrictions on VMs
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804-panthor-unplug-fixes-v1-7-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
 <20260804-panthor-unplug-fixes-v1-7-abbbd2d41b13@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 13:27:23 +0000
Message-Id: <20260804132723.DE5731F000E9@smtp.kernel.org>
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
- [Low] The `bool unusable;` field was not removed from `struct panthor_as`=
 despite its usage being entirely replaced by `atomic_t restrictions;`.
--

--- Patch [7]: [PATCH 07/12] drm/panthor: Add fine-grained restrictions on =
VMs ---
commit 5761524aad92664686f92656f3aec2cb543204a6
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Add fine-grained restrictions on VMs

This commit replaces the existing boolean state checks with a unified atomic
bitmask for fine-grained VM restrictions. It introduces new restriction fla=
gs
representing operations to prevent (map, unmap, and use) and updates the
relevant usage paths to check against this bitmask.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
[ ... ]
> @@ -295,6 +314,9 @@ struct panthor_as {
>  	 */
>  	bool unusable;
> =20
> +	/** @restrictions: Bitmask of panthor_as_restriction flags. */
> +	atomic_t restrictions;
> +

[Severity: Low]
This isn't a bug, but should the unusable field be removed from struct
panthor_as now that its functionality is entirely replaced by the newly
added restrictions field?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-panthor-un=
plug-fixes-v1-0-abbbd2d41b13@collabora.com?part=3D7
