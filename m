Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403ADCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 10:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC7710E779;
	Wed, 27 May 2026 10:39:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ke4tNRza";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6770910E793;
 Wed, 27 May 2026 10:39:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F267544146;
 Wed, 27 May 2026 10:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBF01F000E9;
 Wed, 27 May 2026 10:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779878383;
 bh=2amUF8cUcwPqh6wqAPS+j6IJ8uflyM2KHb04cXCLNDU=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=Ke4tNRzatvlJpxtx9OjYInrW/RNqXnKGl9/CtlAQJaO6INh5bScnEnf95Jaiq6DOO
 ao5bE+daMCUsquaHEzqgtOA/S0pMmDAI9OYtPZ0DbRMzNgcs4gVblfrsoQZgE+f98W
 MocZH0pE7/5xbt+Xezagn/HW6ZhUrTjrQZE+EPJ+NjOYYhbm2+od+Oaim0wJIUbVx3
 FlfGusVcXGa3X5peOynmHjEMVdywfF8RMQxY4YoY6STG9JzD3cTaK2Rz+qWKT2yDZs
 FGe0E96wdcDQWjPirZ9Ix2KrFUiacDeicn+D9c7OW6jUoKHEGTtDUU1nXs95BSYfyJ
 i1s9syzAznfeQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 12:39:39 +0200
Message-Id: <DITE87NC3I9L.QHBKWC4PEMX4@kernel.org>
To: "Hongling Zeng" <zhongling0719@126.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] nouveau/gsp: fix NULL pointer dereference in r535
 nvenc/ofs alloc
Cc: "Hongling Zeng" <zenghongling@kylinos.cn>, <lyude@redhat.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <airlied@redhat.com>, <ttabi@nvidia.com>, <bskeggs@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
References: <20260526014721.13299-1-zenghongling@kylinos.cn>
 <DISMY2BS8E1D.Q85V8DKCPM1C@kernel.org> <6A164F51.7010203@126.com>
In-Reply-To: <6A164F51.7010203@126.com>
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

On Wed May 27, 2026 at 3:56 AM CEST, Hongling Zeng wrote:
>    Should I submit a patch to clean up the IS_ERR_OR_NULL() checks in:
>    - nvkm_gsp_rm_alloc_get() / nvkm_gsp_rm_alloc()
>    - nvkm_gsp_rpc_rd()
>    - All the callers

Sounds good. Ideally, where it makes sense, do it in separate patches and s=
end a
series.

Thanks,
Danilo
