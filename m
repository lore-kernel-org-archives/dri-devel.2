Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649C0606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ku1oyNGj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEBC810EA05;
	Fri, 27 Nov 2026 11:32:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFBB10EA05
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:32:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B52584335B;
 Fri, 27 Nov 2026 11:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793831F0089A;
 Fri, 27 Nov 2026 11:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795779170;
 bh=bdCnr/yR8+V2PGjFgkRC7xw13Bgy7S5gFmsBywMnDrg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ku1oyNGjp+pfBRX2w3UCO0ViM994xniCS06HZU1DvGuj2F0+lQJBpsaxMNieQiB1a
 Brsi+bbO/vAUDkBG+zHCfrRSIkVTZTw4AgA3sY+zJPaeCG3B4iRIjnYsKB3KydD/gp
 pK9nKza6/IjdrFtKNKAAC/kSgUpc7xua5UUhb85+qnOICStnJB/hVGMJhTFDn4ADqm
 I1F+Cdy1QEIWUhmEWAlasD4MAEu22zR6nxLZZBR7LIR4Q+hemXT1fcClVnLySq2q6u
 iXF1cYhPrZY1RUIoKq+eAFkFuuGJ33V0lPSnHeD1Td+tCp5QDsTE3GntTil0O9bzND
 Q+9fKMXsKp0dw==
Message-ID: <sashiko-outbox-237241@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] drm/bridge: ite-it66121: make successful probe
 quiet
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-drm-ite-it66121-log-probe-errors-v2-4-dbe9b5a3c5df@bootlin.com>
References: <20261127-drm-ite-it66121-log-probe-errors-v2-0-dbe9b5a3c5df@bootlin.com>
 <20261127-drm-ite-it66121-log-probe-errors-v2-4-dbe9b5a3c5df@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 11:32:49 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/bridge: ite-it66121: missing linux/unaligned.h include in
  it66121_probe()
- [Low] drm/bridge: ite-it66121: duplicate chip ID dev_dbg() in
  it66121_probe()
--

commit 46732f4e982566f4573478b485add2d91b24ff1a
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: ite-it66121: make successful probe quiet

This commit converts the final probe message in it66121_probe() from
dev_info() to dev_dbg() and includes vendor_id and device_id in the log
string.

> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridg=
e/ite-it66121.c
> index 48f320df8fe77..04e84def2d1b3 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -1695,7 +1695,8 @@ static int it66121_probe(struct i2c_client *client)
> =20
>  	drm_bridge_add(&ctx->bridge);
> =20
> -	dev_info(ctx->dev, "IT66121 revision %d probed\n", revision_id);
> +	dev_dbg(ctx->dev, "IT66121 vendor %04x device %04x revision %d probed\n=
",
> +		vendor_id, device_id, revision_id);
> =20
>  	return 0;
>  }

[Severity: High]
Does drivers/gpu/drm/bridge/ite-it66121.c need to include linux/unaligned.h
for the get_unaligned_le16() calls computing vendor_id and device_id (added
earlier in the series by commit "drm/bridge: ite-it66121: simplify getting
the chip IDs")?

On architectures such as x86_64 and arm64 where asm/uaccess.h does not pull
in linux/unaligned.h transitively, building this driver fails with an
implicit declaration of get_unaligned_le16().

[Severity: Low]
Does this dev_dbg() duplicate the chip ID debug message added earlier in
it66121_probe() by commit "drm/bridge: ite-it66121: simplify getting the
chip IDs"?

drivers/gpu/drm/bridge/ite-it66121.c:it66121_probe() {
    ...
	vendor_id =3D get_unaligned_le16(&chip_id_regs[0]);
	device_id =3D get_unaligned_le16(&chip_id_regs[2]);
	dev_dbg(dev, "vendor %04x device %04x (rev %01x)\n", vendor_id, device_id,=
 revision_id);
    ...
}

When dynamic debug is enabled, every successful probe prints both messages
with the same IDs, formatting revision_id in hex (%01x) in the first and in
decimal (%d) in the second.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-drm-ite-it=
66121-log-probe-errors-v2-0-dbe9b5a3c5df@bootlin.com?part=3D4
