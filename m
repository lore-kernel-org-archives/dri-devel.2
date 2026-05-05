Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4EDCD3430
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 08:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6CAA10E409;
	Tue,  5 May 2026 08:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="b8ad2IU+";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C33E10E409
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 08:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777970030;
 bh=ZTezVbSul7TTdgv9frluFrCT9XdKbrTiGjqbGxeNFbM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=b8ad2IU+h5JNzZOgZIKyUojFqZ4ijB8TBZzUF5cs6ATRCLrNOQFtbPI375O/aikyd
 94r2IFVAWnWFhv5SeFuDZOptrPCu/3Qv8xSnebuSC54FBeIQ1ez+X14KZzdNCNyUM4
 09M8PAnJBuYt8uN/DlNn8FIPFk1Dq/e1pwgR49BPGBxrDqRN0U+NmQMbyTn/gZJ484
 t5q00rTHWuBxqaH6wLikMFokXAG3X5oUZsYwn2HoUpgxauWP3GaXEi1ffAF7IyPrFM
 oi9reA1NHS9M+rKVq7tWimNkw0/2WuP3t6sOHhF1M3yd0zFy1gotl7oy8I3CUu0cAq
 FXECP/C/vHHqQ==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 822BA17E1301;
 Tue,  5 May 2026 10:33:49 +0200 (CEST)
Date: Tue, 5 May 2026 10:33:45 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Marcin =?UTF-8?B?xZpsdXNhcno=?= <marcin.slusarz@arm.com>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven Price
 <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>,
 nd@arm.com
Subject: Re: [PATCH v10 5/6] drm/panthor: Support sparse mappings
Message-ID: <20260505103345.5bc1984a@fedora>
In-Reply-To: <afmm-gRz7W3LTW3H@e129842.arm.com>
References: <20260429183253.66422-1-adrian.larumbe@collabora.com>
 <20260429183253.66422-6-adrian.larumbe@collabora.com>
 <afmm-gRz7W3LTW3H@e129842.arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 5 May 2026 10:14:50 +0200
Marcin =C5=9Alusarz <marcin.slusarz@arm.com> wrote:

> On Wed, Apr 29, 2026 at 07:32:17PM +0100, Adri=C3=AF=C2=BF=C2=BDn Larumbe=
 wrote:
> > @@ -1651,6 +1715,13 @@ int panthor_vm_pool_create(struct panthor_file *=
pfile)
> >  		return -ENOMEM;
> > =20
> >  	xa_init_flags(&pfile->vms->xa, XA_FLAGS_ALLOC1);
> > +
> > +	pfile->vms->dummy =3D panthor_dummy_bo_create(pfile->ptdev);
> > +	if (IS_ERR(pfile->vms->dummy)) {
> > +		kfree(pfile->vms);
> > +		return PTR_ERR(pfile->vms->dummy); =20
>=20
> This is use-after-free.

Indeed. Let's add a proper error path where panthor_vm_pool_destroy()
is called to make sure we don't leak resources when an error occurs
anywhere in the creation path, and let's make panthor_vm_pool_destroy()
safe against dummy=3DNULL.

void panthor_vm_pool_destroy(struct panthor_file *pfile)
{
...

	if (pfile->vms->dummy)
		drm_gem_object_put(&pfile->vms->dummy->base);

...
}

int panthor_vm_pool_create(struct panthor_file *pfile)
{
	struct panthor_gem_object *dummy;

	...

	dummy =3D panthor_dummy_bo_create(pfile->ptdev);
	if (IS_ERR(dummy)) {
		ret =3D PTR_ERR(dummy);
		goto err_destroy_vm_pool;
	}

	pfile->vms->dummy =3D dummy;

	...

	return 0;

err_destroy_vm_pool:
	panthor_vm_pool_destroy(pfile);
	return ret;
}

>=20
> > +	}
> > +
> >  	return 0;
> >  } =20

