Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC63C88E56
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 121CF10E3AC;
	Fri, 11 Sep 2026 12:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DJB3Rulm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9132610F5F8;
 Fri, 11 Sep 2026 12:56:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F5834117C;
 Fri, 11 Sep 2026 12:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860C21F000FF;
 Fri, 11 Sep 2026 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789131389;
 bh=rXhwekFRIFNcSHEsXsELluQd1XAplSrNfZs9RSi5KQg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DJB3RulmoeFIM3hDilBjEPVJnSV7lfHw7/wf0t2n00Mi7DRMp4XJNUK1rro2v5xdL
 G74Vga6gfzGh4HRdPQVCEz993XIJgfy39BcksOUmjLupGIhHWqKuny4C4B+THf72Ap
 7vN+t6D+rnbC9SDifEFfKFOQz1Dq3wWLZr5iTCoT6V0w5neiMz14MzYc0FDhS6EKyX
 mDvw86keH7ow31N7K5gndEJ62mUdfuP49kroClijWwapcrjfcm4MCEjAXrpyH/NqPK
 KOV8dszXxMz+T2n8qFSB85Nrdi387XRJuAWMMrGi2PrQZkN2V3E45BQqXPbrBuLMUF
 9cKZaPKDtz4cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/14] drm/panic: Return errno codes if panic output
 fails
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: "Eugenio Perez" <eperezma@redhat.com>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, Frank.Li@kernel.org, gary@garyguo.net,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 wsa+renesas@sang-engineering.com, ojeda@kernel.org,
 intel-gfx@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, imx@lists.linux.dev
In-Reply-To: <20260911124540.279841-5-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:56:27 +0000
Message-Id: <20260911125628.860C21F000FF@smtp.kernel.org>
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

> Return errno codes from the panic output helpers to detect invalid
> panic handling. Avoid flushing the display if an error ocured. The
> unflushed display output might be helpful in debugging.
>=20
> For now, test the result values in the panic test cases. A later patch
> will add support for retrying failed panic output.
>=20
> v2:
> - forward return value of draw_panic_screen_user() (Sashiko)
> - forward errno code from drm_panic_get_qr_code
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D4

