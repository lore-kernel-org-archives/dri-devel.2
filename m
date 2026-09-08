Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905D1C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B8910E094;
	Tue,  8 Sep 2026 22:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ijVeLKSN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8CC10E094
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:22:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A5E9543534
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F58E1F00A3A;
 Tue,  8 Sep 2026 22:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788906132;
 bh=tEW5iiEaCooNc+HyjtcBuB7Rh90r8MHxfQqHGtDKti8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ijVeLKSNplabRf9m8OJPaRg1oOd1jfhg9/KhFL/Cr0K5dOfeFgj4wSUqUFz+kb0wk
 Uk+7pihDLBHZZXwIBbppnoTt15hsJD/MRGFiFHga6t5Br9UdY6qr6Z8ZAu+KD26tgc
 sv998+2+pml8krRsrzYFTlf3ejbpvSCfNd73/P9OcTMPayn4Xj+4kYJFtr0HbZ1rBc
 1eJ6n9J4NAuyaLI7P5Y+U1p2dxF71wuAbx98qsuyLVWVY9qASR9Emttit0sCFdR9OX
 Xfz5K+XxNJgYJpkGHzmXTVjl9xTUXflYlgjrqUDdUXz9byi6tsuScV2NRJFQm4Uxl4
 6r5vtuTyfnN5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/22] accel: ethosu: Validate secondary streams
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-ethosu-fixes-v3-11-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
 <20260908-ethosu-fixes-v3-11-490fe215286f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:22:11 +0000
Message-Id: <20260908222212.5F58E1F00A3A@smtp.kernel.org>
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

New issues:
- [Critical] Bypass of bounds validation for secondary weight and scale str=
eams due to 'optional' logic, allowing use of stale register values.

Pre-existing issues:
- [Critical] Missing bounds validation for the scale stream in elementwise =
operations.
--

commit 097571887d553c034763bdb8261594ca466ee7e8
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Validate secondary streams

The command-stream validator records the additional U65 scale and weight
stream addresses and the U85 weight decoder addresses, but only checked
stream 0 against its region buffer. This commit checks every configured
secondary stream against the matching weight or scale region before
accepting a kernel operation.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 6f6712f4efd1f..abfb173e10080 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -436,13 +436,17 @@ static u64 feat_matrix_length(struct ethosu_device =
*edev,
> =20
>  static int buffer_size(struct ethosu_validated_cmdstream_info *info,
>  		       struct cmd_state *st, struct buffer *buf, s8 region,
> -		       u16 region_cmd, u16 base_cmd, u16 length_cmd)
> +		       u16 region_cmd, u16 base_cmd, u16 length_cmd, bool optional)
>  {
>  	u64 end;
> +	bool base_set =3D cmd_state_reg_is_set(st, base_cmd);
> +	bool length_set =3D cmd_state_reg_is_set(st, length_cmd);
> +
> +	if (optional && !base_set && !length_set)
> +		return 0;

[Severity: Critical]
Does this logic allow omitted streams to bypass bounds validation while
the hardware might still use them?

If a userspace application omits the base and length commands for secondary
streams that are inherently required by an operation (such as a multi-core
convolution), this check returns 0 and skips bounds validation.

Since Ethos-U NPUs retain register state between jobs, the hardware might
execute the operation using stale offsets from a previous job. Could this
lead to an out-of-bounds memory access by the NPU if the current job's
regions are smaller than those of the previous job?

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but does calc_sizes_elemwise() miss bounds
validation for the scale stream?

In ethosu_gem_cmdstream_copy_and_validate(), a use_scale variable is
computed but completely ignored when calling calc_sizes_elemwise():

drivers/accel/ethosu/ethosu_gem.c:ethosu_gem_cmdstream_copy_and_validate() {
    ...
    ret =3D calc_sizes_elemwise(ddev, info, cmd, &st, use_ifm, use_ifm2);
    ...
}

And calc_sizes_elemwise() entirely lacks logic to validate the st.scale
buffers.

If an unprivileged userspace application provides arbitrary, out-of-bounds
NPU_SET_SCALE_BASE and LENGTH values in the command stream for an
NPU_OP_ELEMENTWISE operation, the hardware will read from the unvalidated
offset. Can this allow an attacker to access arbitrary NPU-mapped memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-ethosu-fix=
es-v3-0-490fe215286f@kernel.org?part=3D11
