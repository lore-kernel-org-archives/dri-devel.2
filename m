Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B937F8D776
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 20:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE80010E10F;
	Thu, 16 Apr 2026 20:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rv/ATBtU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6705910E10F;
 Thu, 16 Apr 2026 20:01:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 53D6B60127;
 Thu, 16 Apr 2026 20:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681F1C2BCAF;
 Thu, 16 Apr 2026 20:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776369674;
 bh=lz/Kvx1cRRVZbDjWprQ1HKPiEr1F7RFxJUJ+hHVwNak=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=Rv/ATBtUbXQrQ+8nnFRv+rNgyBg2UZXNYcH3u/GE9YZAbvOMJVdUhpi7evqgMIDHg
 3B6ZnjEBnl/c06EjTANun1W6ndWhNSeyt4ufG6NmhUMBKMQqNG0F+rPbezsx+1aDue
 0V5P0QFFF6ZCkPgTrjT6kTG6PGHY5FjKEcK3zelhqa/wVy6yMuzS38cUjLNDxFip0v
 8rXaTkVm9dILphoMAoFzbRYYRGH4sLxWJ6pcLqkXakRW+T8b1DKwO9DNyeVbri4PO6
 OGq9Iq1u78AlrFEeBoIpyTAAV0W5HeKdohquMetKoL2vk2aFbAVmV1uq63hYXVs3V7
 8FWtJYFf6m5eg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 22:01:10 +0200
Message-Id: <DHUUHT136HPP.1L7OL7DR568Q6@kernel.org>
Cc: <dri-devel@lists.freedesktop.org>, <saurabhg.gupta@intel.com>,
 <alex.zuo@intel.com>, <matthew.brost@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <aliceryhl@google.com>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
To: "Jonathan Cavitt" <jonathan.cavitt@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] drm/gpuvm: Do not prepare NULL objects
References: <20260130191953.61718-2-jonathan.cavitt@intel.com>
In-Reply-To: <20260130191953.61718-2-jonathan.cavitt@intel.com>
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

(Cc: Alice)

On Fri Jan 30, 2026 at 8:19 PM CET, Jonathan Cavitt wrote:
> Statis analysis issue:
>
> drm_gpuvm_prepare_range issues an exec_object_prepare call to all
> drm_gem_objects mapped between addr and addr + range.  However, it is
> possible (albeit very unlikely) that the objects found through

It is not as unlikely as you might think. The documentation of
drm_gpuvm_for_each_va_range() explicitly states:

	"This iterator does not skip over the &drm_gpuvm's @kernel_alloc_node."

And the kernel_alloc_node does not have a GEM object set. Also, drivers are=
 free
to insert VAs that do not have a GEM object set, e.g. when they have the
DRM_GPUVA_SPARSE flag set.

> drm_gpuvm_for_each_va_range (as connected to va->gem) are NULL, as seen
> in other functions such as drm_gpuva_link and drm_gpuva_unlink_defer.

That said, there is a "real" justification, other than "we do the same thin=
g in
other functions" that would have been good to put this into the commit mess=
age.

The reason I say "would have been" is because this patch has already been
applied -- unfortunately without going through the corresponding maintainer=
 (and
non-Intel reviewers). I only noticed it by accident as I saw it pop up in
drm-misc-next.

No action needed as the code itself is obviously correct, but for the next =
time,
please make sure to send patches to the corresponding maintainers and revie=
wers.

- Danilo
