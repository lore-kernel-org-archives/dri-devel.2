Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59962C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6D210E0B4;
	Tue,  8 Sep 2026 22:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T2uBnMfr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7772910E0B4
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:23:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EBAD601F9
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3667B1F00A3A;
 Tue,  8 Sep 2026 22:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788906193;
 bh=QR0BcsLNTQrY6NnIbXHMb4gj9AbMhS9UlIh6TlexWn4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T2uBnMfroWyWktoQ+uwTT1erk7YBf+zmLfSm6CPfRiVS58kVtQsmVOAvidbReYpji
 dMMVAr9bxizJe2tufau73JCR/wD65tTaCitzrBlupKMUZGaXI8lr83k48eME7AoHAR
 hxURYVEFy0R4EHql/pIdDawX0P999B00hSHZxxdY92CEBd+qz4CuFDz24gJzXvQYNC
 9hHZusr6wb9ZQ9bg3mcLmkD5gnqNbmSdR2LZlBVoOiY/AZxN2BjK+VsSER7p4vygZH
 Mxuf1F8vfU+P98729KTe7yJPC7lY9FFsBwxx+bRIGq9TQHdgfzM7OBKcIIHm1nLNXc
 rBSt5IAQIS2rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/22] accel: ethosu: Validate accumulator input
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-ethosu-fixes-v3-18-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
 <20260908-ethosu-fixes-v3-18-490fe215286f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:23:12 +0000
Message-Id: <20260908222313.3667B1F00A3A@smtp.kernel.org>
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
- [High] Persistent accumulator state causes spurious validation failures f=
or subsequent operations.
- [Medium] Unconditional accumulator format validation rejects valid comman=
d streams on U85.
--

commit 1aba4b3d50bf7ffb97c4f8a708b27672c76cbb73
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Validate accumulator input
   =20
The U85 ACC_FORMAT command can select IFM2 as the accumulator
input. This is used by null-pool operations and can also be used
by convolution. Track this selection and validate the IFM2 feature
map against the OFM extent before submitting the operation.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index f4bd31018e564..632a2352491a0 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c

[ ... ]

> @@ -522,6 +523,32 @@ static int feat_matrix_size(struct ethosu_device *ed=
ev,
>  					  max_len);
>  }
> =20
> +static int
> +calc_acc_input_size(struct drm_device *ddev,
> +		    struct ethosu_validated_cmdstream_info *info,
> +		    struct cmd_state *st)
> +{
> +	struct ethosu_device *edev =3D to_ethosu_device(ddev);
> +	u64 len;
> +	int ret;
> +
> +	if (!ethosu_is_u65(edev) &&
> +	    !cmd_state_reg_is_set(st, NPU_SET_ACC_FORMAT))
> +		return -EINVAL;

[Severity: Medium]
Does this unconditional check reject valid command streams on U85?

If a user submits a U85 command stream containing only operations that do n=
ot
use the accumulator (such as pure elementwise or resize operations), the
compiler may optimize away the unnecessary NPU_SET_ACC_FORMAT register. By
requiring it unconditionally here, the driver will reject these valid comma=
nd
streams with -EINVAL, preventing userspace from executing certain models.

> +
> +	if (!st->acc_input_ifm2)
> +		return 0;
> +
> +	/* The accumulator has one input value for each OFM element. */
> +	ret =3D feat_matrix_size(edev, info, st, &st->ifm2,
> +			       FEAT_MATRIX_IFM2, st->ofm.width,
> +			       st->ofm.height[2], st->ofm.depth, false, &len);

[Severity: High]
Can this persistent state cause spurious validation failures for subsequent
operations?

When a user submits a command stream where an operation (like POOL) sets
NPU_SET_ACC_FORMAT to use IFM2, st->acc_input_ifm2 becomes true. If a
subsequent operation (like ELEMENTWISE or RESIZE) ignores the accumulator, =
the
compiler does not emit a new format register, leaving st->acc_input_ifm2 as
true.

This will validate the previous operation's IFM2 state against the new
operation's OFM dimensions in calc_acc_input_size(), leading to a dimension
mismatch and artificially inflated memory requirements or an -EINVAL reject=
ion.

> +	dev_dbg(ddev->dev, "ACC IFM2:%d:0x%llx-0x%llx\n",
> +		st->ifm2.region, st->ifm2.base[0], len);
> +
> +	return ret;
> +}
> +

[ ... ]

> @@ -692,6 +722,9 @@ static int calc_sizes_elemwise(struct drm_device *dde=
v,
>  			       true, &len);
>  	dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n",
>  		op, st->ofm.region, st->ofm.base[0], len);
> +	if (ret)
> +		return ret;
> +	ret =3D calc_acc_input_size(ddev, info, st);

[Severity: High]
Since elementwise operations do not use the accumulator, does calling
calc_acc_input_size() here inadvertently apply stale accumulator state from
previous operations?

>  	if (ret)
>  		return ret;
>  	if (!feat_matrix_chained(edev, &st->ofm))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-ethosu-fix=
es-v3-0-490fe215286f@kernel.org?part=3D18
