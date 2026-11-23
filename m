Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91923606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUe1wyqY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE3410EC6A;
	Mon, 23 Nov 2026 17:35:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A06FA10EC7F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:35:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 85A5361192;
 Mon, 23 Nov 2026 17:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5171F000C6;
 Mon, 23 Nov 2026 17:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795455304;
 bh=hC4nFY4qn2FoYG59uJIazwzQgxO/atFut06x40eUBFY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iUe1wyqYIrsEDqOD+2N4UjJLIIxa+R85wh+JzcDWQkzX3tQt+4rIRU4T1hohikBVy
 Hj6Er2qtKhWubJ6As1tNguYt+nkKGlTi+m7mewmA2f1LFnH6VLPPxyzL3hx9rU/DzZ
 C4pBCoyNuXmWA80PdtL5BBNSHeA9J3t/CJ1q4K5dygWbeaAFrwop01BsTqFTJjawHF
 HBHGvdP8CWi4uu5XWQS6zwHN8+6lrEOPxu8j4Z56aohPVfady/hQbgts6g3HXL7d1W
 vnWeNDlo1iqFs6fEwUP9xpqjRsYYWweJA4OxJFK3Q76aILd27nvgXuSFJjHADfe8sQ
 R05xgzLLEqkEg==
Message-ID: <sashiko-outbox-229766@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] dma-buf: Reject attaching a zero-sized dma-buf
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261123171114.1451429-1-lizhi.hou@amd.com>
References: <20261123171114.1451429-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 17:35:03 +0000
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
- [Medium] dma-buf: userspace-triggerable WARN_ON() in
  dma_buf_dynamic_attach()
--

commit ce500544d70a1177e5ffafe3281fb66a51101188
Author: Lizhi Hou <lizhi.hou@amd.com>

dma-buf: Reject attaching a zero-sized dma-buf

This commit rejects attaching to a zero-sized dma-buf in
dma_buf_dynamic_attach() with a WARN_ON() and -EINVAL.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 5c6957f8839a8..8be7b6023e4a7 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1050,6 +1050,9 @@ dma_buf_dynamic_attach(struct dma_buf *dmabuf, stru=
ct device *dev,
>  	if (WARN_ON(!dmabuf || !dev))
>  		return ERR_PTR(-EINVAL);
> =20
> +	if (WARN_ON(!dmabuf->size))
> +		return ERR_PTR(-EINVAL);

[Severity: Medium]
Can userspace trigger this WARN_ON(!dmabuf->size)?

Because dma_buf_export() continues to allow exp_info->size =3D=3D 0, any
exporter that does not reject a zero length from userspace before exporting
allows an unprivileged user to hit this warning (and crash systems with
panic_on_warn).

For example, DRM_IOCTL_AMDXDNA_CREATE_BO reaches
amdxdna_gem_create_ubuf_object() -> amdxdna_get_ubuf(), where
va_ent[0].len =3D=3D 0 passes IS_ALIGNED(0, PAGE_SIZE) and exports a zero-s=
ized
dma_buf that amdxdna_gem_prime_import() immediately attaches:

drivers/accel/amdxdna/amdxdna_ubuf.c:amdxdna_get_ubuf() {
	...
	for (i =3D 0, exp_info.size =3D 0; i < num_entries; i++) {
		if (!IS_ALIGNED(va_ent[i].vaddr, PAGE_SIZE) ||
		    !IS_ALIGNED(va_ent[i].len, PAGE_SIZE)) {
	...
		if (check_add_overflow(exp_info.size, va_ent[i].len, &exp_info.size)) {
	...
	dmabuf =3D dma_buf_export(&exp_info);
}

Calling dma_buf_attach() on that buffer then triggers this unratelimited
WARN_ON() on every ioctl call.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123171114.1451=
429-1-lizhi.hou@amd.com?part=3D1
