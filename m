Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B36C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 01:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F093510FB7B;
	Sat,  5 Sep 2026 01:05:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Doqq4ZOY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5752E10FB7A
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:05:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6689600E2
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C021F00A3D;
 Sat,  5 Sep 2026 01:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788570334;
 bh=WFZEnUw1R4I3cLXwHzcebC0qbbi2HjQtPz1OWY6D8p4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Doqq4ZOYnMfvXvVri6V8uLVAtSsD76fgT6mWW30aEV0xec1EFHUujq5R8qCpvHWbn
 jqeZYxAw3h4bzvPZFTPa6q8ZuMsHU7C6hH66agc66UEpcfscFXFIvZneWWWz3GZirp
 C7LgRZer307+OJg0vj9VkR+kquhPq9ApFFGxaRm4zs6NWnIiwP1vbMMK57BvozoiqE
 mNsnfgnlO2HvMdGuvXZ7A3DCSbzGxTqTufyP1Hk5qZlUT+dtrx/S8xXPIQEhahdPd3
 gzU9vBBQWJR9ijFRXBGB6LIkySne8KSppUE3vUQQzac1jYuGt4C3V4rmMFTncTUWAY
 VKTS0lDdGvuIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/19] accel: ethosu: Validate resize operations
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-ethosu-fixes-v2-19-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
 <20260904-ethosu-fixes-v2-19-3767738756a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 01:05:33 +0000
Message-Id: <20260905010534.42C021F00A3D@smtp.kernel.org>
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
- [High] Flawed buffer bounds calculation for RESIZE operations ignores the=
 kernel footprint, allowing the NPU to read out of bounds.
--

commit ea6b05d137a756ad8605387afc8b28c1b9b10e2e
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Validate resize operations

This commit adds validation for resize operations by explicitly requiring a=
nd
verifying the scale, offset, and step registers. It also computes a
conservative coordinate bound when validating the input feature map.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 8114447891b25..67bee96129341 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
[ ... ]
> @@ -619,6 +631,96 @@ calc_acc_input_size(struct drm_device *ddev,
[ ... ]
> +static int calc_sizes_resize(struct drm_device *ddev,
> +			     struct ethosu_validated_cmdstream_info *info,
> +			     struct cmd_state *st)
> +{
> +	struct ethosu_device *edev =3D to_ethosu_device(ddev);
> +	u32 ifm_width, ifm_height;
> +	u64 len;
> +	int ret;
[ ... ]
> +	ret =3D resize_axis_size(st, 0, st->ofm.width, st->ofm_blk_width,
> +			       &ifm_width);
> +	if (ret)
> +		return ret;
> +	ret =3D resize_axis_size(st, 1, st->ofm.height[2], st->ofm_blk_height,
> +			       &ifm_height);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D feat_matrix_size(edev, info, st, &st->ifm, FEAT_MATRIX_IFM,
> +			       max(ifm_width, (u32)st->ifm.width),
> +			       max(ifm_height, (u32)st->ifm.height[2]), st->ifm.depth,
                               ^^^^

[Severity: High]
Does this calculation underestimate the required buffer size by ignoring the
kernel footprint?

In calc_sizes_resize(), the starting input feature map (IFM) coordinate
for the last output pixel is calculated by resize_axis_size() as ifm_width.
Because the NPU applies a kernel of size st->ifm.width + 1 at this
coordinate, the true maximum IFM coordinate accessed should be
ifm_width + st->ifm.width.

By combining the starting coordinate and kernel width with max() instead of
addition, the bound checks max(ifm_width, st->ifm.width). This allows a
malicious command stream with a large kernel width to read memory past the
validated input feature map buffer.

Could we use addition here to correctly account for the kernel footprint?

> +			       false, &len);
> +	dev_dbg(ddev->dev, "op %d: IFM:%d:0x%llx-0x%llx\n", NPU_OP_RESIZE,
> +		st->ifm.region, st->ifm.base[0], len);
> +	if (ret)
> +		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-ethosu-fix=
es-v2-0-3767738756a4@kernel.org?part=3D19
