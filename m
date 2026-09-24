Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB64C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3074910F678;
	Thu, 24 Sep 2026 15:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EdJ1XjvB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9B110F678
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:35:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3044F601DE;
 Thu, 24 Sep 2026 15:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED051F000FF;
 Thu, 24 Sep 2026 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790264148;
 bh=CmrUxfB7KGIEWUJQIUuG1QLz9EZSp/D68be7eANfnrM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EdJ1XjvB/PEmKZZ1rZeOb1oqaV2W+/b96M0fJ1FUliA4vFPSWG4ARqKj32EzIPU6z
 tjvHVMIvk4z1/CVuflZS15CFTI1SS3wnFPXT7ReY3mCqW/x+/JKHsukVymbvHE0Z8N
 gRb4jP8bMUXl9ytLTS5v0lK9NYhkBL+IrbAIMF+Ii2pk94WdZW3pVWhchlL1esyLvm
 JEPuOvvHdlM0xKaz4Es3eytQ5MLeNKxgKIF5N/ya1ftStajbZlV52v3nK8zP9ho8+9
 hS78p7MHwXUumUizfdrnr4FT5lwxw5HpD8wMp0pEeWyNoteoxXq5m+TnXtK+g73NcX
 9ASZsRhGLawuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 9/9] vfio/pci: Revoke a DMABUF on request from userspace
To: "Matt Evans" <matt@ozlabs.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260924152159.49702-10-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-10-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:35:48 +0000
Message-Id: <20260924153548.AED051F000FF@smtp.kernel.org>
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

> Replace the VFIO exporter's priv->revoked flag with a status enum of
> OK, REVOKED, and DEAD.  OK and REVOKED are equivalent to the existing
> flag, which tracks whether invalidate_mappings & unmap has occurred
> and whether attach/map are permitted.
>=20
> The DMABUF is marked DEAD in response to a new VFIO feature
> VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE.  This passes a DMABUF by fd and
> requests that the DMABUF is immediately revoked.  On success, it's
> guaranteed that PTEs are zapped, imports have been cleanly unmapped,
> and that the buffer can never be mapped/attached or mmap()ed anymore.
> Existing VFIO move semantics could permit a buffer to be mapped again
> in future (e.g. revoke/unrevoke around a reset), but the DEAD state
> can never become OK again.
>=20
> This enables a userspace driver process to securely reclaim VFIO PCI
> BAR resources previously delegated to a subordinate process.  Using
> the new ioctl, the userspace driver process can ensure that resources
> are inaccessible when the subordinate is deemed "done".  The
> originally-exported DMABUF becomes unusable, and BAR resources can
> then be safely re-exported for use elsewhere.
>=20
> Refactor the revocation code out of vfio_pci_dma_buf_move() to a
> function common to move and the new feature request path.  This
> function calls dma_buf_invalidate_mappings() and
> dma_resv_wait_timeout() only on the revoke path
> (vfio_pci_dma_buf_move() originally called them for both revoke and,
> unnecessarily, for un-revoke).
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D9

