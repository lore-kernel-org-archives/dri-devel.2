Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99140C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C9A10E07D;
	Mon, 29 Jun 2026 08:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Xo2DxI3n";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3566910E07D
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:49:17 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gpg1j70zzz9vCB;
 Mon, 29 Jun 2026 10:49:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782722954; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNexwtP6qx9lBB2uR84+WnHRT3J5jrJo35qB4/OoSvo=;
 b=Xo2DxI3nSm1iCegJk8MQv5Ll1eLaAPBnhGRqiegbYbTjCxRaGQqzDB3W07+kH4nKtBOK3X
 dxkTDCXuQUDwC3ZesbR6kjyCUEGGStztrYbNGILYnuOljcBSgRh5/6RAXtVP+gguGSSf+x
 Yp9xjAj2QGvTgG5xfjoDECXVfis/ea/aNTXlV72Invo1LvyMebH9dEi7iC4S+JDfzfAdnQ
 NRnFSdYbz+GRaxibti2WUcwH/Eu4d6B7AwsMUUcfxA9sx16NZNKM+5nDCFuW7+7BGqOKXG
 6xcZzlTKT1me4aIiAYV/TZQcQYu1viLrzGkqyS1iVNviQ4rGqBMWAmeqkCMbHw==
Message-ID: <058f4bb261e408cf17deca9ff7354460675eacbf.camel@mailbox.org>
Subject: Re: [PATCH] dma-fence: Make dma_fence_dedup_array() robust against
 0-count input
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Baineng
 Shou <shoubaineng@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner
 <phasta@kernel.org>,  Akash Goel <akash.goel@arm.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Mon, 29 Jun 2026 10:49:08 +0200
In-Reply-To: <becd29b5-9e40-4104-b6c9-3d91e2ddddff@amd.com>
References: <20260629031346.3875683-1-shoubaineng@gmail.com>
 <becd29b5-9e40-4104-b6c9-3d91e2ddddff@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: qsgddayaj8bgcsbnm6438m7kgxrxucpg
X-MBO-RS-ID: eb9239d37414620f1a5
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, 2026-06-29 at 10:45 +0200, Christian K=C3=B6nig wrote:
> On 6/29/26 05:13, Baineng Shou wrote:
> > dma_fence_dedup_array() returns 1 when called with num_fences =3D=3D 0:
> > the for-loop body never executes, j stays at 0, and the final
> > `return ++j` yields 1. This contradicts both the kernel-doc ("Return:
> > Number of unique fences remaining in the array") and the natural
> > expectation that 0 input gives 0 output.
>=20
> Good catch.
>=20
> >=20
> > All in-tree callers currently filter num_fences =3D=3D 0 before invokin=
g
> > this helper (__dma_fence_unwrap_merge() bails out via the
> > `if (count =3D=3D 0 || count =3D=3D 1)` fast path; amdgpu_userq_wait_*(=
)
> > cannot reach the dedup call with a zero local count because the
> > amdgpu_userq_wait_add_fence() helper guarantees num_fences stays in
> > [0, wait_info->num_fences], and wait_info->num_fences > 0 is enforced
> > at the ioctl entry).
>=20
> That's not correct, wait_info->num_fences is just the maximum amount of f=
ences we return.
>=20
> It is perfectly possible that amdgpu never finds any fences to add to the=
 array.
>=20
> >=20
> > However, dma_fence_dedup_array() is EXPORT_SYMBOL_GPL, so any future
> > caller that forgets to pre-filter the zero case will get a misleading
> > return value of 1. Depending on how that caller uses the result, it
> > could dereference an uninitialized fence slot in the array, since the
> > caller's array may have been allocated but not yet populated.
> >=20
> > Make the contract match the documentation by returning 0 early. This
> > also skips an unnecessary sort() call on an empty array.
> >=20
> > Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>=20
> I will add a CC stable before pushing to drm-misc-fixes.

No offense intended or taken, but don't the DRM rules say that things
do not get merged while there are outstanding concerns or significant
points in review feedback?

What about my comments?


P.
