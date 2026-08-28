Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E69C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 18:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0533410E4D8;
	Fri, 28 Aug 2026 18:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XPrlwORE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF95510E4D3;
 Fri, 28 Aug 2026 18:21:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE4B660052;
 Fri, 28 Aug 2026 18:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5721F000E9;
 Fri, 28 Aug 2026 18:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787941280;
 bh=CLbnUNZVoS6+zOQUj99F7wbjx3rx5WK9TNeR/HF217I=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=XPrlwOREf+KgZ7V8V4hf03MBAa+RjZ0RNJdiNTJJ1LpzQB5Bky5tkKeABuClDZ+UW
 CoU+QvUiXO4OwA36bwp/Hv2/z4RUaBt1bKulIcxWmiNPJJYdeMEAdOFdDLdeVg/tbG
 rMV5fX9hdts9ALJLkYm9/klZM6b0fiNjDmJi6kFYfvyXRIK8e/XC2kiMbkZpXitypJ
 v98+IeyuAq1Xy9TJKSv+lYApREsWI+HiO60HzjpaA2yxDjGOL4xAtDPAgnQyqQrPVV
 z1nB5TZMOMD31Sn8yBEQK/ksnt5nMja1KigH0y8WO1YiWEOJKqzMEoE6/Y9LE0LDe8
 LB5zXpaXecaDg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 20:21:17 +0200
Message-Id: <DL0SABOU2QO9.20AA8OP9CXXA5@kernel.org>
Subject: Re: [PATCH 01/10] dma-buf: Add reference counting to dma_resv
Cc: <christian.koenig@amd.com>, <thomas.hellstrom@linux.intel.com>,
 <ecourtney@nvidia.com>, <matthew.brost@intel.com>, <nat@pixelcluster.dev>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
To: =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-2-christian.koenig@amd.com>
In-Reply-To: <20260827124910.2245-2-christian.koenig@amd.com>
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

On Thu Aug 27, 2026 at 2:38 PM CEST, =3D?UTF-8?q?Christian=3D20K=3DC3=3DB6n=
ig?=3D wrote:
> This provides clearer ownership semantics and makes the code more
> maintainable by removing the embedded allocation hack.

Again, fundamentally disagree; please see [1] for details and reasons.

Besides that, I don't really know what to expect from the series. The cover
letter says "Refcounting dma_resv v2", yet there's no changelog telling peo=
ple
what has changed since v1. On the other hand, none of the patches has a v2
prefix, so what is it?

[1] https://lore.kernel.org/all/DJVRML4G11GZ.Z7FTZH7I1LZN@kernel.org/
