Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0437EC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42EE110F03D;
	Wed,  9 Sep 2026 09:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FAVjyRLf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF2A10F025;
 Wed,  9 Sep 2026 09:17:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 00F7A60218;
 Wed,  9 Sep 2026 09:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4081F1F00A3A;
 Wed,  9 Sep 2026 09:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788945462;
 bh=M2Xg+0GJnnYkjQOT8Sa7lr2VWKOZ2P++qzDCF237qaE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FAVjyRLfwXziH97gNMGoH6iHM0d+jjEJmSnR4WjvFVu8rbOvJ2AwlZqAMhB64L76R
 FrnAVmxYjt2NKNbS0pFfZBR56R5QYwajY/CFPP9c87oqHCx9f+YxuSIA6ScFCudqcB
 VMQmjuODJrPxihzHI8ui7zI+/95xrhNph/n12J0hySyELIpJ1a7iLNiLbib/LlNPEA
 SBjuah8o/qrndnWFg2QL5TLC4qqV1MPswPVBjmSNEsx0xPY5YaY4JuF39891rkDF6g
 Xh7iLkxwsRtH7lFHdAletVynoRNmX4kiwfWAP4JX9wzzcDgxxusPIj4RCtJcS7nCZG
 XmUW4E8CN3lqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/14] drm/panic: Retry in dispatch function if panic
 output fails
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-gfx@lists.freedesktop.org, gary@garyguo.net,
 virtualization@lists.linux.dev, Frank.Li@kernel.org,
 wsa+renesas@sang-engineering.com, ojeda@kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260909085826.64529-9-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-9-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:17:41 +0000
Message-Id: <20260909091742.4081F1F00A3A@smtp.kernel.org>
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

> On failed output of QR codes and kmsg buffers, fall back to a user
> message. QR-code output already did this internally, but now formally
> support it in drm_panic_dispatch(). Streamlines the existing logic.
>=20
> With the implicit fallback removed from QR-code support, the tests
> cases fail for thr smallest output size (300x200). This is because the
> QR code requires a minimal output size. Increase the size to 494x494,
> which is the minimum supported size for QR output.
>=20
> v3:
> - update outdated commit description (Sashiko)
> v2:
> - fix minimum test size (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D8

