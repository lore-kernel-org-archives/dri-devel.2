Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42919CA600B
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AF8810FC70;
	Thu,  8 Oct 2026 06:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g4M1a8if";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B413210FC70
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:35:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D1D54107A;
 Thu,  8 Oct 2026 06:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6198B1F000FF;
 Thu,  8 Oct 2026 06:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791441324;
 bh=0OpgAzGa67nrFSlllc9zBA/M/gpNDJIxhTyVZSQQq94=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g4M1a8ifLVCpASPHsGZA6qdI3B+PViWMFUZdfK7daBakOP1KbghlkZBDyJCG+bkhN
 P5k0KP2iljyYzSfstgt2MauBk93BT4StGjBPbZEqBqMkFVLlrIExypj31SYOZ520ZS
 3E090jddzD1TNRK4G2zDVR6Wc1ZN0RSUhIpbz4DG5/zubBlfKcTkQTmmdMhjuIqDd7
 W4yLMIcPpsAjT7TzHFGeVZAJZkdAaWpCCjTHkvnTXkk1QSc/Po/mU7IndZvj1YuqST
 L+i9Xqx1RRM4yr11zKFoAeLaJcpD/dMfbE9oBiyZycGQSqBziZ/NjEF/AeRbfvZp3j
 TdfRC6FTCKy0A==
Message-ID: <sashiko-outbox-163699@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/7] bus: mhi: Add QDU100 Sahara variant and firmware
 fallback
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-sahara_protocol_new_v2-v7-4-90d278bd7414@oss.qualcomm.com>
References: <20261008-sahara_protocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com>
 <20261008-sahara_protocol_new_v2-v7-4-90d278bd7414@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:35:24 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sahara: unintended firmware fallback behavior for AIC100/AIC200
--

commit 02c795f9adf45b209ef5da56b858e0490ac4667d
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Add QDU100 Sahara variant and firmware fallback

This commit extends the Sahara driver to recognize QDU100 devices and adds
a firmware lookup fallback for unspecified image IDs. It allows QDU100
devices to request required images to be provisioned by the platform.

> bus: mhi: Add QDU100 Sahara variant and firmware fallback
>
> The Sahara driver currently selects a firmware image table based on the
> attached device, but it does not recognize QDU100 devices that expose the
> protocol on the SAHARA MHI channel. As a result, the host cannot associate
> QDU100 devices with the correct firmware namespace during image transfer.
>
> Extend the probe time variant selection to match the SAHARA MHI channel a=
nd
> associate it with the QDU100 firmware folder. Add a firmware lookup
> fallback for cases where an image does not have an explicit entry in the
> device's firmware table. This allows required images to be provisioned by
> the platform.
>
> This change only affects devices matched on the SAHARA MHI channel and
> does not change behavior for existing AIC100 and AIC200 devices.

[Severity: Medium]
Is this statement accurate?

Since fw_folder is populated for existing AIC100 devices (for example, in
drivers/accel/qaic/mhi_controller.c where aic100_sahara_fw sets
fw_folder =3D "aic100"), the new fallback lookup in sahara_find_image() will
also apply to them. If an AIC100 target requests an unspecified image ID, it
will now trigger a filesystem lookup instead of being immediately rejected.

Does this unintentionally change the behavior for existing devices?

> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>

> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/m=
hi/host/clients/sahara/sahara.c
> index e339c67e236af..7fe5158c17e98 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
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
> +
> +		fw_path =3D kasprintf(GFP_KERNEL, "qcom/%s/%u",
> +				    context->fw_folder, image_id);

[Severity: Medium]
Could this unintentionally execute for AIC100 and AIC200 devices?

Because aic100_sahara_fw sets .fw_folder =3D "aic100", context->fw_folder w=
ill
be valid for these devices. An unknown image_id request from an AIC100 devi=
ce
will fall through to this path and perform a filesystem lookup instead of
returning -EINVAL immediately.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-sahara_pro=
tocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com?part=3D4
