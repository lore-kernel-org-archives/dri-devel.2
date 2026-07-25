Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B92C531D0
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52E410F506;
	Sat, 25 Jul 2026 05:08:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hv00ONOU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E373310F506
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:08:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B20A40622;
 Sat, 25 Jul 2026 05:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72A21F000E9;
 Sat, 25 Jul 2026 05:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784956099;
 bh=GN6aqntHEPq5XDOXgFW8etw4HsuTNEBa3VPzvY5PKqU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hv00ONOULMkkAlpWMUxcUCoLfA508BVmyB1VpzWromTSYnMrnx+zDS95OZxuM7L0W
 MO8tuW58ZI5U/PWkC9ATIBTKBaW2AbhHH6MiShZhS0j8Hbilk1qWPZjtY0wiXqx76W
 HH1V2xQsNQ62Qd+UMw2tfC2rtA5O6C7KEuSNZAEZcm8pTmpMYkAyLjC62tYMRsIpkn
 MwFX2HeZjOg9u+sVyCNimyGq8GHJPskT3u59Lowa8q89eVOB4s1rT/bYl2M0UUCaCp
 mULbGyYEKvO7I6e954TJBDF6Jb52waBnNB8WfI9GLD33yk2cckpkrJJ6EO/U2hakG/
 TKuY6r4/A7y9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 14/17] riscv: dts: spacemit: k3: add display nodes
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: robh@kernel.org, olteanv@gmail.com, linux-phy@lists.infradead.org,
 conor+dt@kernel.org, vkoul@kernel.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org, devicetree@vger.kernel.org
In-Reply-To: <20260725-k3-display-v1-14-6de34d80e86c@gmail.com>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-14-6de34d80e86c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 05:08:18 +0000
Message-Id: <20260725050818.E72A21F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The DP controller hardware is not initialized before the eDP panel=
 probe is triggered, causing synchronous AUX transfers to fail or hang.
- [High] The custom EDID read function violates the I2C EEPROM protocol by =
omitting the Middle-of-Transaction (MOT) bit, breaking EDID reads on sinks =
that require a repeated START.
--

--- Patch [14]: [PATCH RESEND 14/17] riscv: dts: spacemit: k3: add display =
nodes ---
commit 9b9ee39195ad90a76f056f9bddbdabb8377b67ec
Author: Cody Kang <codykang.hk@gmail.com>

riscv: dts: spacemit: k3: add display nodes

Add the SoC-level display nodes: the two Saturn DPUs, the two DP/eDP
controllers with their PHY children.

> diff --git a/arch/riscv/boot/dts/spacemit/k3-display.dtsi b/arch/riscv/bo=
ot/dts/spacemit/k3-display.dtsi
> new file mode 100644
> index 0000000000000..4892ee6acda22
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k3-display.dtsi
> @@ -0,0 +1,156 @@
[ ... ]
> +&soc {
[ ... ]
> +	edp0: edp@cac84000 {
> +		compatible =3D "spacemit,k3-inno-dp";

[Severity: High]
Does enabling this device node cause the eDP panel probe to fail?

Looking at inno_dp_probe() in drivers/gpu/drm/spacemit/spacemit_inno_dp.c, =
it
populates the eDP panel device on the AUX bus:

    ret =3D devm_of_dp_aux_populate_bus(&dp->aux,
                                      spacemit_dp_edp_link_panel);

The panel driver probes synchronously and attempts an AUX transfer to read =
the
EDID.

However, the DP controller's hardware registers (including the AUX clock
divider DP_AUX_CTRL_CLK_DIV and soft resets) are not initialized until late=
r:

spacemit_inno_dp.c:spacemit_dp_bind() {
    ...
    ret =3D spacemit_dp_dev_init(dp);
    ...
}

The uninitialized controller ignores the transfer or the AUX state machine
does not start, causing an unavoidable timeout.

> +		reg =3D <0x0 0xcac84000 0x0 0x4000>;
[ ... ]
> +	dp1: dp@cac88000 {
> +		compatible =3D "spacemit,k3-inno-dp";

[Severity: High]
Will EDID reads fail for sinks connected to this node?

When reading EDID, the driver splits the transaction into a write and a rea=
d:

spacemit_inno_dp.c:spacemit_dp_conn_get_edid_block() {
    ...
    ret =3D spacemit_dp_aux_i2c_write(dp, DDC_ADDR,
                                    &edid_offset, 1);
    ...
}

It calls spacemit_dp_aux_i2c_write() which hardcodes the request:

spacemit_inno_dp.c:spacemit_dp_aux_i2c_write() {
    ...
    .request =3D DP_AUX_I2C_WRITE,
    ...
}

The missing MOT (Middle-of-Transaction) bit guarantees an I2C STOP condition
after writing the offset address. This resets the internal address pointer =
of
many standard EEPROMs, causing the subsequent read to repeatedly fetch bloc=
k 0
instead of the requested extension block.

> +		reg =3D <0x0 0xcac88000 0x0 0x4000>;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-k3-display=
-v1-0-6de34d80e86c@gmail.com?part=3D14
