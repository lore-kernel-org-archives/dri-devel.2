Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5D4606A332
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ht/IiM2W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EABC1122E8;
	Thu, 26 Nov 2026 11:18:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF0611233C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:17:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C848623F6;
 Thu, 26 Nov 2026 11:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED661F000F2;
 Thu, 26 Nov 2026 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795691874;
 bh=GqYs8OZaH2c+zBQE/38ZCtNT+Emw+NouIYphZtdKmCw=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ht/IiM2WPk95K35kdy4FcuDNp8wNM7P4EHNySsade7buMiGQ+00hIfCjQ6tycn1ET
 pBMf5NIMGDf5RqjVX7kX0kGbVxQeW6e/QEoD7kUhmMRpZksRs7V6UyROjVqsG/oSTp
 8AHi0TWInQJY5kX2Zf89luGJVKRWhAAb3N0Nv+B3LzOzkn5wUPpJy5NhjjdlkK4v0Y
 7yNOgBtBewU8apo3vBkNFzQC6/rkEuut0H9FsAg++OjSrrlkM4ZChyFKDfUy/GqgUJ
 7DZP+LhEYa5M2EBT+tgqeEOyzFunoEl5p3t9kfw97xiNRE1bf4wvwjtBVp7rZvNlLa
 QkEYJ+4XoVDJA==
Message-ID: <sashiko-outbox-235358@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] drm/syncobj: Use scoped cleanup for
 drm_syncobj_array_wait_timeout syncobjs
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261126111117.67342-4-tvrtko.ursulin@igalia.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
 <20261126111117.67342-4-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:17:53 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/syncobj: separate declaration and init of __free() in
  wait_timeout
--

commit 7b5691e728edfdbf53ebabd68fe3be6523faee57
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/syncobj: Use scoped cleanup for drm_syncobj_array_wait_timeout syncobjs

This commit converts the entries allocation and syncobj wait cleanup in
drm_syncobj_array_wait_timeout() to use a DEFINE_FREE() scope-managed clean=
up
helper instead of goto labels.

> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index bd3f9e74e678f..7d5c4e4e29b20 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
[ ... ]
> @@ -1052,6 +1077,7 @@ static signed long drm_syncobj_array_wait_timeout(s=
truct drm_syncobj **syncobjs,
>  						  uint32_t *idx,
>  						  ktime_t *deadline)
>  {
> +	struct syncobj_wait_entries cleanup __free(syncobj_wait_entries) =3D {};
>  	struct syncobj_wait_entry *entries;
>  	u64 *points __free(kvfree) =3D NULL;
>  	struct dma_fence *fence;
> @@ -1076,6 +1102,11 @@ static signed long drm_syncobj_array_wait_timeout(=
struct drm_syncobj **syncobjs,
>  	if (!entries)
>  		return -ENOMEM;
> =20
> +	/* After this the entries cleanup is fully automatic. */
> +	cleanup.syncobjs =3D syncobjs;
> +	cleanup.entries =3D entries;
> +	cleanup.count =3D count;

[Severity: Low]
Could cleanup be defined and initialized in a single statement right after
entries is allocated rather than declared empty at the top of the function?
Per include/linux/cleanup.h conventions, defining __free() variables at the=
ir
point of initialization preserves LIFO destruction order relative to points
and avoids running syncobj_wait_entries_free() on early returns before
entries is allocated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126111117.6734=
2-1-tvrtko.ursulin@igalia.com?part=3D3
