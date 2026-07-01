Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A51AC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44C610EEE0;
	Wed,  1 Jul 2026 10:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UZbXMUJP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A481F10EEE0
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:53:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DA0940DFC;
 Wed,  1 Jul 2026 10:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E501F000E9;
 Wed,  1 Jul 2026 10:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782903195;
 bh=CgzRgOKLURTpeJWV/j8krqyG2ED/Gq+ur/AKckBwiS0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UZbXMUJPYJ5fhHyvk+Vc2saLIiZ2e9PqeK962/hHax4fN5xg/G34f2plTl5FMIo32
 +zV4BGwJjv6E69m621ywVjkZJ0ZiVF1HKpBs5EaAvcz3W4HOqkHrSyUYATIGxERJkD
 sdL1R2Tu+8AUzylDCuFgZD1XiCowLJ/2pkVHJs/Uvj+WP2vFy4pl6zBwzjYt050p6e
 fzlv4LqPMho75ng09ZUfOwFYkF0MLCdyMkoCkX6POi78GIVZxhvyWO/xVj7Lmybozr
 lG+TFozDGai2O2TE/OcbEx5afUoZT01uFo65XF5yzfwgolRc+j9tMioqc2JCRtecYc
 8H4Ltc7BUl42A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/7] bus: mhi: Add QDU100 Sahara variant and firmware
 fallback
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-sahara_protocol_new_v2-v6-4-3a78362c4741@oss.qualcomm.com>
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-4-3a78362c4741@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:53:14 +0000
Message-Id: <20260701105315.46E501F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] The firmware fallback mechanism inadvertently changes the behavi=
or for existing AIC100 and AIC200 devices, bypassing their explicit allowli=
st and contradicting the commit message.
- [Low] The `dev_err` statement in the fallback error path uses a signed fo=
rmat specifier `%d` to print an unsigned 32-bit integer.

Pre-existing issues:
- [High] A malicious or malfunctioning device can trigger a NULL pointer de=
reference or Use-After-Free by requesting an image transfer with `image_id`=
 equal to `SAHARA_IMAGE_ID_NONE` (0xFFFFFFFF).
- [High] Missing cancellation of `read_data_work` during driver removal lea=
ds to a Use-After-Free of `context` and `context->firmware`.
- [High] Lockless concurrency between `fw_work` and `read_data_work` allows=
 a device-triggered Use-After-Free during firmware streaming.
--

commit e80f9e2e7047bfa82528957f04343840159ae175
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Add QDU100 Sahara variant and firmware fallback

Extend the probe time variant selection to match the SAHARA MHI channel for
QDU100 devices. Add a firmware lookup fallback to provision images dynamica=
lly
if they aren't explicitly listed in the image table.

> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/m=
hi/host/clients/sahara/sahara.c
> index e339c67e236af..9adbd84859073 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
> @@ -189,6 +189,7 @@ static bool is_streaming(struct sahara_context *conte=
xt)
> =20
>  static int sahara_find_image(struct sahara_context *context, u32 image_i=
d)
>  {
> +	char *fw_path;
>  	int ret;
> =20
>  	if (image_id =3D=3D context->active_image_id)
>  		return 0;

[Severity: High]
This is a pre-existing issue, but can a malicious or malfunctioning device
trigger a NULL pointer dereference or use-after-free here?

If a device requests an image transfer with image_id equal to
SAHARA_IMAGE_ID_NONE (0xFFFFFFFF), context->active_image_id is initialized =
and
reset to this value. sahara_find_image() would return success (0) without
acquiring firmware.

Later, sahara_read_data() unconditionally dereferences context->firmware->s=
ize,
which would be NULL or a dangling pointer.

[ ... ]

> @@ -201,8 +202,28 @@ static int sahara_find_image(struct sahara_context *=
context, u32 image_id)
>  	}
> =20
>  	if (image_id >=3D context->table_size || !context->image_table[image_id=
]) {
> -		dev_err(&context->mhi_dev->dev, "request for unknown image: %d\n", ima=
ge_id);
> -		return -EINVAL;
> +		if (!context->fw_folder) {
> +			dev_err(&context->mhi_dev->dev,
> +				"Request for unknown image: %u (no fw folder)\n", image_id);
> +			return -EINVAL;
> +		}

[Severity: Medium]
The commit message states this change does not affect behavior for existing
AIC100 and AIC200 devices. However, legacy AIC devices populate fw_folder at
probe time.

Since this check relies on !context->fw_folder instead of matching against =
the
SAHARA channel, will legacy AIC devices fall through to the VFS lookup via
firmware_request_nowarn() instead of immediately returning -EINVAL?

> +
> +		fw_path =3D kasprintf(GFP_KERNEL, "qcom/%s/%u",
> +				    context->fw_folder, image_id);
> +		if (!fw_path)
> +			return -ENOMEM;
> +
> +		ret =3D firmware_request_nowarn(&context->firmware,
> +					      fw_path,
> +					      &context->mhi_dev->dev);
> +		kfree(fw_path);
> +		if (ret) {
> +			dev_err(&context->mhi_dev->dev,
> +				"request for unknown image: %d\n", image_id);

[Severity: Low]
Is %d the correct format specifier here? image_id is a u32, so if the
requested ID is greater than INT_MAX, it will be printed as a negative numb=
er.

> +			return -EINVAL;
> +		}
> +		context->active_image_id =3D image_id;
> +		return 0;
>  	}

[Severity: High]
This is a pre-existing issue, but does device teardown systematically omit
canceling read_data_work?

When the driver is unbound, sahara_mhi_remove() calls cancel_work_sync() for
fw_work and dump_work, but fails to cancel read_data_work. If read_data_work
is pending or executing, it can run after remove() returns, leading to a
use-after-free of the devres-managed context.

[Severity: High]
This is a pre-existing issue, but is there lockless concurrency between
fw_work and read_data_work that allows a device-triggered use-after-free?

During firmware streaming, sahara_read_data() schedules read_data_work. If a
device sends a SAHARA_END_OF_IMAGE_CMD immediately after a read request, the
command is processed by fw_work which calls sahara_release_image() to free
context->firmware.

Because these are independent work items without synchronization, could an
untrusted MHI device deliberately race the EOI command against the executing
streaming task?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-sahara_pro=
tocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com?part=3D4
