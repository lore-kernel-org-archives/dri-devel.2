Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FDAC44507
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 13:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CDB810E368;
	Sat, 11 Jul 2026 13:26:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aPCkOdEP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCA6E10E1B6;
 Sat, 11 Jul 2026 13:26:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E6A17601D9;
 Sat, 11 Jul 2026 13:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3331F000E9;
 Sat, 11 Jul 2026 13:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783776382;
 bh=fVjphaM/B3cY7EEbFuMGuyKiZiBk4vV629GclTQJJMg=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=aPCkOdEP19Svl46slzbLUVN6gRb91P4h3BWpj9bBDHNWrQYZye/fT7IbhOfPSYDFf
 r+5XCR61+a/C0T7mHFvbedM62i/xP2GT34cmrHvBXjEE2P8TPwf6/U8meC2leyisXs
 DwRrUoDqEfQTI4tNuOz4fDqCRkazjdeEpcuTF92/pYuVIJARQ9jMC8kCknoQoroUJi
 snEZQYtFHCOOUsb7Eld1n23rSxEJc1ioKEEQuyhs7Sl4w8vqUnjezFn79OnJ/Nax7z
 Wa7xVqEMMkwVy9kORE0Ovf3tHkRnuo7es6LQyuKLfZGiEl9XTnWk24eVb+jMhzZWXr
 P+GYpFStidKYQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 15:26:18 +0200
Message-Id: <DJVRYBLM3B94.MAUO8T8NXM5P@kernel.org>
Cc: <christian.koenig@amd.com>, <thomas.hellstrom@linux.intel.com>,
 <ecourtney@nvidia.com>, <simona@ffwll.ch>, <matthew.brost@intel.com>,
 <nat@pixelcluster.dev>, <airlied@gmail.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
To: =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 09/12] drm/ttm: nuke buffer refcounting
References: <20260710190752.2355-1-christian.koenig@amd.com>
 <20260710190752.2355-10-christian.koenig@amd.com>
In-Reply-To: <20260710190752.2355-10-christian.koenig@amd.com>
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

On Fri Jul 10, 2026 at 8:52 PM CEST, =3D?UTF-8?q?Christian=3D20K=3DC3=3DB6n=
ig?=3D wrote:
> +/**
> + * ttm_bo_is_deleted - test if buffer is already deleted
> + * @bo: the struct ttm_buffer_object to test
> + *
> + * Returns true if the buffer is already deleted and only waiting for
> + * destruction.
> + */
> +static inline bool ttm_bo_is_deleted(struct ttm_buffer_object *bo)
> +{
> +	return !kref_read(&bo->base.refcount);
> +}

This is an anti-pattern, branch decisions cannot rely on an atomic referenc=
e
count unless additional invariants are upheld that otherwise guarantee that=
 the
read values does not instantly become meaningless.

Something like this should at least document in which context and under whi=
ch
conditions it is valid to rely on the returned value.
