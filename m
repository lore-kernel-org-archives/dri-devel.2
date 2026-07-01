Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DC2C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 21:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D17F10E174;
	Wed,  1 Jul 2026 21:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="njkDg/k1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77EC110E174;
 Wed,  1 Jul 2026 21:52:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B65086001D;
 Wed,  1 Jul 2026 21:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB5B1F000E9;
 Wed,  1 Jul 2026 21:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782942777;
 bh=WxLJxKFpUA0kAUkIQ6mS7yvA+8HJGo7B22jNIaZOi6g=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=njkDg/k1sBTK4PF9q016m9mONKxrqizl4XhE4icxmXHbl+YGkhRaGiE+u7f7Ll/ad
 MIkPZjyXfN5LKw8zDKync8/jLHo20qcaGBXqQW4kUPoES7ZD/L7ZRWuIC++GbNgvBx
 k4O1uNA2gIyFw4piRNmL4IpG2RvQ2sMPKK6C5YPMjNkrJcOw/rkSR/s2p36tulNaYH
 idVBXaPKcC0wJ3BldiAhxDN1B6NPKWQuTwfhtEP2nBnzEuq66dV5vAgsF7VPuUU+tT
 rTWCDGJ/jgWGgLriEkdMgy0wu8nxrkpKHEmej9c9YmgkQuAibRByt3Q/P0OCxOC6xF
 bTQYrdn5O3S2Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 23:52:55 +0200
Message-Id: <DJNKGRGHSFEA.2KYSDR2HKUEC4@kernel.org>
Subject: Re: [PATCH] nouveau/instmem: use iomapping interface for instmem
 handling
Cc: <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>
To: "Dave Airlie" <airlied@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260623223320.3837840-1-airlied@gmail.com>
In-Reply-To: <20260623223320.3837840-1-airlied@gmail.com>
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

On Wed Jun 24, 2026 at 12:33 AM CEST, Dave Airlie wrote:
> @@ -172,8 +175,7 @@ nv50_instobj_kmap(struct nv50_instobj *iobj, struct n=
vkm_vmm *vmm)
> =20
>  	/* Make the mapping visible to the host. */
>  	iobj->bar =3D bar;
> -	iobj->map =3D ioremap_wc(device->func->resource_addr(device, NVKM_BAR2_=
INST) +
> -			       (u32)iobj->bar->addr, size);
> +	iobj->map =3D io_mapping_map_wc(&imem->iomap, iobj->bar->addr, size);

Apparently, the u32 cast was there for a reason. nv50_bar_oneinit() creates=
 the
BAR2 VMM with a 4GiB base, so iobj->bar->addr includes a 4GiB offset that w=
as
truncated by the cast.
