Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E277C79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7493E10E388;
	Fri, 11 Sep 2026 07:57:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wkm9moXa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFAF810E388
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 07:57:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9BF6C601EF;
 Fri, 11 Sep 2026 07:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F651F000FF;
 Fri, 11 Sep 2026 07:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789113474;
 bh=QxvmERiv8BnCYnfAtiHd1dcPkzetSVLeJxzlauqjTNI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wkm9moXa2jxQrvn4Mr2qVDQh3XoSd9Rj3/9zB3DCrXkFt57hRrGpHBToJkZ8mGipw
 6zaVNiipCEEb5NXz60lbBhKjSy31mi9XJDP+3VxGzqEo9vSH2kPOgjvZIv/bokZFeB
 cVleoWBfD43bVQdABSNw6B5j0AlFN02G/iPNquvqvNmmqHBvW4D3yl6HtZYL/8u1pV
 RZEdIiFUZfM7/xIAJl1C5OB9GVV2aAxnAuj4KP4Dt6BZ42veKOPhjXHhJ6aHlk5uva
 g70RZZbbU7O+rAWspTZMAiNh+jjUV5IFtk6rZs22Y7u1c1nfT56int+EukTVA6clif
 FqzVARrnOBNFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/13] treewide: convert rdmsrq() from a macro to an
 inline function
To: "Juergen Gross" <jgross@suse.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-hwmon@vger.kernel.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dlemoal@kernel.org, linux-ide@vger.kernel.org,
 linux-hyperv@vger.kernel.org, cassel@kernel.org,
 virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20260911074530.3140830-13-jgross@suse.com>
References: <20260911074530.3140830-1-jgross@suse.com>
 <20260911074530.3140830-13-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 07:57:53 +0000
Message-Id: <20260911075753.A3F651F000FF@smtp.kernel.org>
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

> Today rdmsrq() is a macro using its second parameter as the target for
> storing the read MSR value.
>=20
> Convert rdmsrq() to an inline function returning the MSR value.
>=20
> The users have been converted using the following semantic patch:
>=20
>   // Options: --include-headers
>=20
>   virtual patch
>   virtual report
>=20
>   @@
>   expression msr, val;
>   @@
>   (
>   - rdmsrq(msr,val)
>   + val =3D rdmsrq(msr)
>   )
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911074530.3140=
830-1-jgross@suse.com?part=3D12

