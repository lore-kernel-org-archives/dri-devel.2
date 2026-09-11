Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0774C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE87A10F5E9;
	Fri, 11 Sep 2026 12:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eYQIhxm8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7614810F5E9;
 Fri, 11 Sep 2026 12:55:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 11FBA42E0B;
 Fri, 11 Sep 2026 12:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512D21F000FF;
 Fri, 11 Sep 2026 12:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789131312;
 bh=an0BVH+ZbY2/m5yLlE1s2KfrTVlB5o9WmKtC+kS3FTQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eYQIhxm8bz+zg3lMoJknpy4qOCj0QpHQhMVBHgxVD1MAsux/FRPCzEXSZtIbKVzgO
 fL16HDUJ6KBvYQvJxw21Y9OjRrhKsug0pl3MRzoDy/KApNrICjxLUFJvd4vE1Rmwgh
 U9/DnVU4R1tnIgllFmMgBAhjKXm5NJxbUI8IgsL9q6q/zFMkKNmAWEAgA4JEws7L0g
 qeHPs5hnc12mj5HhbG/3Cbj4s/39M4tom1QpfochVtBD8jL0uE1K7GcCli4qRW2l25
 Ee9exB/eCUIJYgVDOaSj3/uK8Hz9/afWAceSjOf1zveiiXRLNu78HqvQpCUa6Poljh
 FaIXcRBORaaEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/14] drm/panic: Restrict to primary planes
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, ojeda@kernel.org,
 "Eugenio Perez" <eperezma@redhat.com>, wsa+renesas@sang-engineering.com,
 gary@garyguo.net, imx@lists.linux.dev, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org
In-Reply-To: <20260911124540.279841-11-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-11-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:55:10 +0000
Message-Id: <20260911125511.512D21F000FF@smtp.kernel.org>
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

> Restrict panic handling to primary displays. Overlays and cursors
> should not display panic output. If there are exceptions, they can
> be registered by the driver itself.
>=20
> v3:
> - also update drm_panic_is_enabled() (Sashiko)
> - still do some testing when unregistering (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D10

