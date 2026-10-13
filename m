Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991CACC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2AA510F63E;
	Tue, 13 Oct 2026 09:01:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7299A10F63E
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:01:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 50D66402E5;
 Tue, 13 Oct 2026 09:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BCD1F000FF;
 Tue, 13 Oct 2026 09:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791882084;
 bh=m7RSWDFHpiCVLtEiLQ5ABSkhybcG0XnMFZ+uAaV/Nt4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gNJctMJf6JGd1I1Hjg8a/q+8MpnKQAFXX855A3bdF+4x3ZYgPgDQ5+fS67blQKVjk
 sWjBk/fbw/wXG/6+W8PI/9Mc1WXyDO753Htl1cki1cJ2KkDTNp5ULeljrBHLb5y5XN
 2R+8rqyusxQ4ywf7/0WOJN6QrmXq7fqN1zoy/jpD1azfvZE3n/AHSP3+TkkNxuMyEC
 2OuWE0RbL9m5ChuI6Nf0EzW13mCv5pTjZfWBwkfGNwvkbAVt3EQN7WPvG48zg2HDJK
 YW1U1O8PIYe2z8voxAAVXd070BgaEpmnPxDMTHdNzNpjF5AwTLl6ZH1WPQhpBMgcZC
 qZplbAHzdq5og==
Message-ID: <sashiko-outbox-169305@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/7] bus: mhi: Add QDU100 Sahara variant and firmware
 fallback
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261013-sahara_protocol_new_v2-v9-4-dc9f24357c4a@oss.qualcomm.com>
References: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
 <20261013-sahara_protocol_new_v2-v9-4-dc9f24357c4a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:01:23 +0000
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
- [Medium] mhi: sahara: patch changes behavior for AIC100/AIC200 despite co=
mmit message claims
--

commit 95400c2cb3bcfef8a4adb0c664417375ff8137c7
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Add QDU100 Sahara variant and firmware fallback

Extend the probe time variant selection to match the SAHARA MHI channel and
associate it with the QDU100 firmware folder. Add a firmware lookup fallback
for cases where an image does not have an explicit entry in the device's
firmware table.

> This change only affects devices matched on the SAHARA MHI channel and
> does not change behavior for existing AIC100 and AIC200 devices.

Is this description accurate?

The qaic controller driver configures aic100_sahara_fw and aic200_sahara_fw=
 to
populate the fw_folder field as "aic100" and "aic200".

With the new fallback logic in sahara_find_image(), if an existing AIC devi=
ce
requests an unknown image ID, it appears it will now trigger the new fallba=
ck
path and perform synchronous VFS lookups for "qcom/aic.../<id>", whereas
previously it would immediately fail with -EINVAL.

> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/m=
hi/host/clients/sahara/sahara.c
> index ce4fcbd40baa1..a4b3ef197b303 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
[ ... ]
> @@ -200,8 +201,28 @@ static int sahara_find_image(struct sahara_context *=
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
> +		if (!fw_path)
> +			return -ENOMEM;
> +
> +		ret =3D firmware_request_nowarn(&context->firmware,
> +					      fw_path,
> +					      &context->mhi_dev->dev);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: Medium]
Could this fallback path introduce a regression for AIC100 and AIC200
devices? It looks like those devices have a fw_folder configured, so they
would execute this filesystem lookup for unknown IDs rather than immediately
failing with -EINVAL as they did before this patch.

> +		kfree(fw_path);
> +		if (ret) {
> +			dev_err(&context->mhi_dev->dev,
> +				"request for unknown image: %d\n", image_id);
> +			return -EINVAL;
> +		}
> +		context->active_image_id =3D image_id;
> +		return 0;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-sahara_pro=
tocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com?part=3D4
