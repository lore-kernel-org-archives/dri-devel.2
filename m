Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289CCC88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 588CC10F606;
	Fri, 11 Sep 2026 12:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MFC3WueJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 368BB10F5D9;
 Fri, 11 Sep 2026 12:58:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 956636025A;
 Fri, 11 Sep 2026 12:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6061F000FF;
 Fri, 11 Sep 2026 12:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789131497;
 bh=q4w4nA6VQmPEv6TrJcP8o1hT/BdL9siYpgV8FxVBIHY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MFC3WueJe/mGj35Ob4ByEZ8WcDs42ra28FNQHwlwFFXYi8wdZ0Hp3WLxKcVwQVwAx
 dWGW0rx/TGFGmKpisYjSXeUiopTEKLVTkpBXm+B3g+SV+pljZEU1hTrKqv8sS1M/gf
 +Fb48MjKsJ9jjeA793DnLmyUvYUShfa9tc9sZ8nVhR5fqnwjNjFo4OEZv/heVQfMij
 vkK1052pnWgT+xfDtsjJpixCDpOXjDVgizPG7gfoxPQDK1zzQvi3ZroJFHK0YGWDRl
 g3PTb77wZgpp6yqaGLY/xNdW34C5lyR7Tre5NUw8Aie0brCK15u9n/idg6FO/qI0B1
 hmo4YVKWWRl8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/14] drm/panic: Test address from kmap op for NULL
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: imx@lists.linux.dev, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 ojeda@kernel.org, wsa+renesas@sang-engineering.com, "Eugenio
 Perez" <eperezma@redhat.com>, intel-gfx@lists.freedesktop.org, gary@garyguo.net,
 virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, Frank.Li@kernel.org
In-Reply-To: <20260911124540.279841-3-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:58:16 +0000
Message-Id: <20260911125816.9C6061F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL checks for page pointers passed to kmap_local_page_tr=
y_from_panic() leads to a kernel panic in the panic handler.
--

commit 69a5d51433b94a040beb8954801343ad106c13c9
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Test address from kmap op for NULL

Do nothing if kmap_local_page_try_from_panic() returns NULL. This is
not likely to hapen, as the previous page from the same memory area
has been mapped successfully.

Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.18+

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index ba21df4be3380..d28ce8878e055 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -178,6 +178,8 @@ static void drm_panic_write_pixel24_xpage(void *vaddr=
, struct page *next_page,
>  	u8 *p =3D vaddr + offset;
> =20
>  	vaddr2 =3D kmap_local_page_try_from_panic(next_page);

[Severity: High]
This isn't a bug introduced by this patch, but can next_page be NULL here,
leading to a kernel panic?

If a scanout buffer is sparse or partially unpinned, the pages array might
contain NULL pointers. While drm_panic_blit_page() checks for NULL before
most operations, when a 24-bit pixel crosses a page boundary it calls
drm_panic_write_pixel24_xpage(vaddr, pages[page + 1], ...).

If pages[page + 1] is NULL, passing it to kmap_local_page_try_from_panic()
causes a fatal page fault when attempting to dereference the page pointer.

Additionally, drm_panic_fill_page() seems to omit the page validation
entirely and passes pages[page] directly to kmap_local_page_try_from_panic(=
):

drivers/gpu/drm/drm_panic.c:drm_panic_fill_page() {
    ...
    vaddr =3D kmap_local_page_try_from_panic(pages[page]);
    ...
}

Should the page pointers be validated before attempting to map them?

> +	if (!vaddr2)
> +		return;
> =20
>  	*p++ =3D color & 0xff;
>  	color >>=3D 8;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D2
