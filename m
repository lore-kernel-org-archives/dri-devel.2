Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10548F588E4
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 15:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782BC10E696;
	Mon, 20 Apr 2026 15:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mGEuyqDW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F27A010E696
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:08:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A1AF544704;
 Mon, 20 Apr 2026 15:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2223C19425;
 Mon, 20 Apr 2026 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776697698;
 bh=Lm07FRYIKpA8U6ZJrO9wQ8KmSm2Q2i2gtVveDLehFiM=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
 b=mGEuyqDWjiHHC23jeDEmZ5Nkuft1cLcQDZ7YMWQ7dVJ8ue2+v85tWXbw+FKorMx0q
 HJyo8lD54osLtE2j9K/SUH54XbPmje4/dSD/WtyCcdr1EaoedwzjwFc6vbuqy8M9zu
 O2GjA/iW+qqp8Xddj9SyZYfa8XZk0M8Z6IBP1l5NXloHDGY9YfPrBiwGrUDp5NI+rt
 uqSaN4oPht0t0GAWmtNWwq2ti8mRrIFXygHnPJ6T8o7RKn+96EvN2uWjMiBr7oSpBp
 7JL0uRS12qKwxz8SDhwu7mz/kkcdMzvHRuHTBz/+IzjdVPTT7gL+oyTLxr5O5nq2nr
 dATHCIeKzj1xw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 17:08:15 +0200
Message-Id: <DHY2RPB300R2.1XXG87NPYFRCI@kernel.org>
To: =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] drm/gpuvm: take refcount on DRM device
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260416-gpuvm-drm-dev-get-v1-1-f3bc06571e73@google.com>
 <544c97fe296f39da35e5349ba1fc0af05f2ff643.camel@linux.intel.com>
 <DHVOJ6ILGSLK.3OWKA4RV2HB5C@kernel.org>
 <215f305ff04ddf8a426871e895aaf520b02e89bf.camel@linux.intel.com>
In-Reply-To: <215f305ff04ddf8a426871e895aaf520b02e89bf.camel@linux.intel.com>
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

On Mon Apr 20, 2026 at 11:28 AM CEST, Thomas Hellstr=C3=B6m wrote:
> I agree with your reasoning here, but current fact is that most (if not
> all) holders of a drm device reference (files, pagemaps, dma-bufs)
> currently also hold a module reference to protect against this, and
> drm_gpuvm would be an outlier.

I'm not convinced; if the DRM device has the requirement to not outlive the
module it is associated with, then the DRM device code has to take care of =
this
requirement, and not every caller of drm_dev_get().

Besides that, if GPUVM holds the module reference count on behalf of the DR=
M
device, it has the same effect that you rightfully point out below -- it br=
eaks
rmmod.

> To fix this properly (lifting that requirement) one could introduce a
> drm device count in the module and have the module exit function wait
> for it to become zero, *and* that the code that did the last decrement
> finished executing.
>
> https://patchwork.freedesktop.org/patch/712146/?series=3D163298&rev=3D1

This looks like a reasonable fix to me. And it makes me conclude that we
basically agree on everything. :)

Regarding the reference count in the meantime, it remains that omitting it =
does
not solve the underlying problem, i.e. I still think it is orthogonal.

> Or one could also have the drm device hold a reference count on the
> driver module, but that would block unloading without previous unbind
> which is not typical driver behaviour and would likely be seen as a
> regression.
