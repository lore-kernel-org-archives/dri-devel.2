Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989F1C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 07:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025B610E0AD;
	Wed, 15 Jul 2026 07:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hC3ryODu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C69E10E0AD
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 07:58:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DC88640350;
 Wed, 15 Jul 2026 07:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960001F000E9;
 Wed, 15 Jul 2026 07:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784102307;
 bh=SCxGMhXAckoMulFh2tSSC5a/vs6HgzhO+ywlKaGyrRk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hC3ryODura3sD4Hw++uxtrBQ85OuQSGHGrIVONey9JOqswRBJvojUY8iBHfkPvkfY
 JEFTQc2qwyw7/iTNON+QyrvtXKYxFR8U97JFTSyEfvkHXYO2PYpHBXfMDHucYAj/N1
 RPOtO+dwkq21eiBty9EiJ/Tct8OowR0arcWXVOnN4vrSEcYzsgdLK2o9nK8rfpMC9b
 iW+VQDeG4p/rXVVRn/hJg35N71odO8ZWsbppubhkRurM3a3dyvlq/yyYD9YW07JyQh
 irLS5IigGKSEpFeGT+/2IamaclZfCbIO61iqYgMbMauTqhLoW7BHkTaO7qAu8K7Rbk
 4iDH2sa+M5Ghw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ivpu: Reject firmware log with size smaller than
 header
To: Jhonraushan <raushan.jhon@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260715074206.867712-1-raushan.jhon@gmail.com>
References: <20260715074206.867712-1-raushan.jhon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 07:58:26 +0000
Message-Id: <20260715075827.960001F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The validation of `log->size` and `log->header_size` is vulnerable=
 to a Time-Of-Check to Time-Of-Use (TOCTOU) race condition because the fiel=
ds are read multiple times directly from firmware-shared BO memory, allowin=
g malicious firmware to bypass bounds checks.
- [Medium] The firmware-controlled `log->name` character array is printed u=
sing an unbounded `%s` format specifier, which can lead to out-of-bounds re=
ads if the device does not null-terminate the string.
--

--- Patch [1]: [PATCH] accel/ivpu: Reject firmware log with size smaller th=
an header ---
commit 8efc93a32eb39ab04f9058367f2b3c6355d62590
Author: Jhonraushan <raushan.jhon@gmail.com>

accel/ivpu: Reject firmware log with size smaller than header

This commit adds a check to fw_log_from_bo() to reject firmware logs where
the log size is smaller than the header size. This is intended to prevent
an integer underflow when calculating the data size in fw_log_print_buffer(=
),
which could defeat bounds checks.

> diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_f=
w_log.c
> index 275baf844b562..716467aa31567 100644
> --- a/drivers/accel/ivpu/ivpu_fw_log.c
> +++ b/drivers/accel/ivpu/ivpu_fw_log.c
> @@ -43,6 +43,10 @@ static int fw_log_from_bo(struct ivpu_device *vdev, st=
ruct ivpu_bo *bo, u32 *off
>  		ivpu_dbg(vdev, FW_BOOT, "Invalid header size 0x%x\n", log->header_size=
);
>  		return -EINVAL;
>  	}
> +	if (log->size < log->header_size) {
> +		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
> +		return -EINVAL;
> +	}

[Severity: High]
This is a pre-existing issue, but since the log pointer accesses BO memory
shared directly with the firmware, could a malicious firmware alter log->si=
ze
or log->header_size after these checks are performed?

For example, in fw_log_from_bo() the offset is later updated:

	*offset +=3D log->size;

And in fw_log_print_buffer() data_size is calculated:

	u32 data_size =3D log->size - log->header_size;

If the firmware changes the values between the validation here and these
subsequent reads, could this bypass the bounds checks and lead to the very
same underflow or infinite loop this patch aims to fix? Would it be safer
to read these values once into local variables?

[Severity: Medium]
This is also a pre-existing issue, but I noticed that later in
fw_log_from_bo(), the log->name array is printed using the %s format:

	ivpu_dbg(vdev, FW_BOOT,
		 "FW log name \"%s\", write offset 0x%x size 0x%x, wrap count %d, hdr ver=
sion %d size %d format %d, alignment %d",
		 log->name, log->write_index, log->size, log->wrap_count, log->header_ver=
sion,
		 log->header_size, log->format, log->alignment);

Since log->name is a 16-byte character array in the shared firmware BO
memory, what happens if the firmware fills it without a null terminator?

Could the %s format specifier read past the array bounds and leak memory
or cause a page fault?

This similarly occurs in fw_log_print_buffer() when using drm_printf()
with %s on log->name.

>  	if ((char *)log + log->size > (char *)ivpu_bo_vaddr(bo) + ivpu_bo_size(=
bo)) {
>  		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715074206.8677=
12-1-raushan.jhon@gmail.com?part=3D1
