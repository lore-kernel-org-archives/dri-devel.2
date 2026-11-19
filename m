Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8F0606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3OJpwQV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E533B1125F4;
	Thu, 19 Nov 2026 15:50:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B2861125F4
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:50:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 17D7843497;
 Thu, 19 Nov 2026 15:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9C51F000C4;
 Thu, 19 Nov 2026 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795103439;
 bh=DZsvY3GHN+zBDSQkGmr/kuPCseIeNfXUyCe3V2K5xmg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=V3OJpwQVQcZgs7/FtbNOVAWnSsC3bAYtnrLKqCUP9aLd1uRm8oKEWe/9AS8OCbrGQ
 39CpmTbBFmzrlsBHJ6/zA0x70DTvBMLY/+zAQvdP7kxxc9BtdEbs6wd7l2GVKSDspk
 Y01hw7Wl12UJGP8C0Ppvt9mh/p2lebrlcr5FJpFK2NOxY38vfa8mHYx3j8qYNxFLW4
 Nyz1J0AIpbFxdgNtBIGXCLP1k3A7BIu1TY0ICXml4Jt02J/gNy+9ZzoORQWMRu9YrS
 v0aflKir0VQmx+0F9DRNeGscpxEXdHdBX97iZevlD7e5my+ouoxHX1jl60Ak/QeQ85
 ZtiaehWH09G0Q==
Message-ID: <sashiko-outbox-223427@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] drm/panthor: Rename neural accelerator feature
 macro to NX
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261119154604.2519184-3-karunika.choo@arm.com>
References: <20261119154604.2519184-1-karunika.choo@arm.com>
 <20261119154604.2519184-3-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 15:50:38 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/panthor: commit message does not explain why GPU_FEATURES_NX
  is renamed
--

commit 5e9eb3b7663e54adfe7c44a448b5ceec6839bd33
Author: Karunika Choo <karunika.choo@arm.com>

> drm/panthor: Rename neural accelerator feature macro to NX
>
> Rename GPU_FEATURES_NEURAL_ENGINE to GPU_FEATURES_NX.
> Update the panthor_hw helper to use the new name.
>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

[Severity: Low]
This isn't a bug, but the commit message only restates the rename without
explaining why GPU_FEATURES_NEURAL_ENGINE is being renamed to
GPU_FEATURES_NX while panthor_hw_has_neural() keeps the neural naming.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119154604.2519=
184-1-karunika.choo@arm.com?part=3D2
