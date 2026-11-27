Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFE4606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Idkwv2yH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB9CF112A38;
	Fri, 27 Nov 2026 11:31:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83F78112A4D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:31:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C09AA61421;
 Fri, 27 Nov 2026 11:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653BE1F00898;
 Fri, 27 Nov 2026 11:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795779064;
 bh=iHqJfg58oT2JjWprq8gkzbi2akMWeQdTWy19LVMtJaA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Idkwv2yHNab8BcBGE0Jy9JHmP6UTaTHz6d4Pp4p11eLSRbg1KTAfSROYtmC8PCw7k
 3C7uSjkje+5gJCBBAqVQTODpmyAJTu1cEooazn2XmZK3bxbkpCZjvmwKBwdfh7lwde
 KuDnt1tSaYaAnNVJiQTPEGSRIFi+1P9wEEy0YCtp72d6jkCSLpstnsv8lSgY89R+77
 oum5+uWfjgVlsR271mcGYEDSo1K/xiJHEkeNopElcHd317xd8Rq43pzuW4iFgc0DDf
 8L+ExmsDZBDSAaorndkoXjISUOBTUmNXNiQ6mh0e1FhEjOwJHKZ6VsMl6fE2OjFcSl
 tgx0a2ebQndhw==
Message-ID: <sashiko-outbox-237240@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] drm/bridge: ite-it66121: simplify getting the
 chip IDs
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-drm-ite-it66121-log-probe-errors-v2-2-dbe9b5a3c5df@bootlin.com>
References: <20261127-drm-ite-it66121-log-probe-errors-v2-0-dbe9b5a3c5df@bootlin.com>
 <20261127-drm-ite-it66121-log-probe-errors-v2-2-dbe9b5a3c5df@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 11:31:03 +0000
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
- [High] drm/bridge: ite-it66121: missing linux/unaligned.h include in
  it66121_probe()
--

commit 86dd14ece48e024d13ff3916942d669c127f8cf0
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: ite-it66121: simplify getting the chip IDs

This commit replaces open-coded bit shifts with get_unaligned_le16() to
compute the vendor and device IDs in it66121_probe() and logs them with
dev_dbg().

> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridg=
e/ite-it66121.c
> index fe3c48df85388..909a21fac8c02 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -1570,6 +1570,7 @@ static const struct it66121_chip_info it66xx_chip_i=
nfo[] =3D {
>  static int it66121_probe(struct i2c_client *client)
>  {
>  	__u8 chip_id_regs[4];
> +	u16 vendor_id, device_id;
>  	u32 revision_id;
>  	struct device_node *ep;
>  	int ret, i;
> @@ -1643,10 +1644,14 @@ static int it66121_probe(struct i2c_client *clien=
t)
>  	revision_id =3D FIELD_GET(IT66121_REVISION_MASK, chip_id_regs[3]);
>  	chip_id_regs[3] &=3D IT66121_DEVICE_ID1_MASK;
> =20
> +	vendor_id =3D get_unaligned_le16(&chip_id_regs[0]);
> +	device_id =3D get_unaligned_le16(&chip_id_regs[2]);

[Severity: High]
Does drivers/gpu/drm/bridge/ite-it66121.c need to include
<linux/unaligned.h> for get_unaligned_le16()?  Without it, the build fails
with an implicit declaration of get_unaligned_le16() on architectures such
as arm64 and x86_64 that do not pull in linux/unaligned.h transitively.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-drm-ite-it=
66121-log-probe-errors-v2-0-dbe9b5a3c5df@bootlin.com?part=3D2
