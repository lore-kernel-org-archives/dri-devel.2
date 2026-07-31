Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD70C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 545B110F2EC;
	Fri, 31 Jul 2026 16:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G9Nsfo7I";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6E810F2EC
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:16:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5006660A6D;
 Fri, 31 Jul 2026 16:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74131F00AC4;
 Fri, 31 Jul 2026 16:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785514588;
 bh=WLrhxGnki3Kw7sopbL/iJRgkIQ/u5z/+Ddg37AauneU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G9Nsfo7IckeW0JaYtfqpMtWzia3sOC3bFrE9G81d5tzyLCElSp5/vKHHnGyxlp5yb
 E69rfCO6OrwYorNOIt/5YpzPCxqh5TG+ZbegIYYCaKswReWSUirSvng8CvdzdAeNP6
 6MkvlpIvlviROyTX07OfFQj8iwJ3hFjTN60oJqZjrIHTXUfzVKsWShR9EXWgqfARkU
 zCLscJxFSQ14evMTZF1HfsI6IqntNAm4Gb3qcICaHH7XXn40bVXZf03BjooPoYdh60
 el14+qcgpQrFRFzdxkTREGhnYRelxgKRhCps9Nsek4JlU5/rkGD7sDJlLELouiQiJm
 rBjPNkC3D7jQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/21] drm/bridge: synopsys: dw-dp: Fix support for
 short I2C reads
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260731-synopsys-dw-dp-improvements-v8-7-ac1e6a75782f@collabora.com>
References: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
 <20260731-synopsys-dw-dp-improvements-v8-7-ac1e6a75782f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:16:27 +0000
Message-Id: <20260731161627.B74131F00AC4@smtp.kernel.org>
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
- [High] Buffer overflow and integer underflow due to missing bounds check =
on DP AUX read length.
--

--- Patch [7]: [PATCH v8 07/21] drm/bridge: synopsys: dw-dp: Fix support fo=
r short I2C reads ---
commit db106fc9593a19fc4e0e7028df22f1cecf9e1c41
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Fix support for short I2C reads

This commit modifies dw_dp_aux_transfer to support short I2C reads by
returning the data received rather than returning -EBUSY when the read
count doesn't exactly match the requested size.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1513,7 +1513,7 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux=
 *aux,
>  		if (msg->request & DP_AUX_I2C_READ) {
>  			size_t count =3D FIELD_GET(AUX_BYTES_READ, value) - 1;
> =20
> -			if (count !=3D msg->size)
> +			if (!count)
>  				return -EBUSY;
> =20
>  			ret =3D dw_dp_aux_read_data(dp, msg->buffer, count);

[Severity: High]
Does this code adequately protect msg->buffer from overflow if the hardware
reports a count greater than msg->size?

By removing the exact length match check, an anomalous DisplayPort sink mig=
ht
return an AUX_BYTES_READ value resulting in count > msg->size. This unverif=
ied
count would then be passed to dw_dp_aux_read_data(), which could write past
the bounds of msg->buffer.

Additionally, if the hardware reports an AUX_BYTES_READ of 0, could count
underflow to SIZE_MAX? Since SIZE_MAX is non-zero, it would bypass the !cou=
nt
check, potentially causing dw_dp_aux_read_data() to attempt an excessively
large read and write operation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-synopsys-d=
w-dp-improvements-v8-0-ac1e6a75782f@collabora.com?part=3D7
