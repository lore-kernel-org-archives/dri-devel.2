Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD415C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3AB10ECDD;
	Tue,  1 Sep 2026 13:19:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ak/7kcQm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 590F610ECDD
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 13:19:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 11855407B1;
 Tue,  1 Sep 2026 13:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9581F00A3E;
 Tue,  1 Sep 2026 13:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788268746;
 bh=Wcf9+VWlWMP+kX+y0ioV2acMTgyFxK4XAqVm9ppv9zM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ak/7kcQm4ZxquSgauuvMOza+VcyZ6n2cIV/jUPv0RrGtcS4ws6csmFb3EHiQIhQHu
 xcVYLU6Aq3Q32PtkOi0Dj1CKrbYWXNdwptCqG6OdmEJJEQynyNezGbBdt/wSMdmCXS
 eNAoYGcN/KsjoP+BezK1YJ3xlUIwKdbL/7F9gPWB7kotcxDHV/y4lFOIFtnsJTtkH4
 Qr9JmpOtnsQEMwUkaNkXsrtfjt3eULwiht4qd8toWXJ4MVo0nN7KfRGgWbFJxcdK6d
 sVvIsu25BXPhICT6wyRJpXdB284Q111kVd0lvf+sDdXp5HnMh56i7EdIka/m4p4dvu
 1N/rJx1S4rMVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] accel/ivpu: Limit firmware log name prints to
 field size
To: "Dawid Osuchowski" <dawid.osuchowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260901125749.404338-4-dawid.osuchowski@linux.intel.com>
References: <20260901125749.404338-1-dawid.osuchowski@linux.intel.com>
 <20260901125749.404338-4-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:19:06 +0000
Message-Id: <20260901131906.BC9581F00A3E@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unbounded string read from firmware data in `ivpu_fw_parse`.
--

commit 7d0d9c625b89d41a9d3cbe859e6e2b33348102cf
Author: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

accel/ivpu: Limit firmware log name prints to field size
   =20
This patch fixes an issue where the NPU firmware log name field is printed
using an unbounded string conversion. By enforcing a precision limit based
on the field's size, it prevents out-of-bounds memory reads if the firmware
string is missing its NUL terminator.

Closes: https://sashiko.dev/#/patchset/20260827102339.281799-1-dawid.osucho=
wski@linux.intel.com?part=3D2

> diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_f=
w_log.c
> index 4f9055aa9d33f..9eafc42120b6a 100644
> --- a/drivers/accel/ivpu/ivpu_fw_log.c
> +++ b/drivers/accel/ivpu/ivpu_fw_log.c
> @@ -69,9 +69,9 @@ static int fw_log_from_bo(struct ivpu_device *vdev, str=
uct ivpu_bo *bo, u32 *off
>  	*offset +=3D size;
> =20
>  	ivpu_dbg(vdev, FW_BOOT,
> -		 "FW log name \"%s\", write offset 0x%x size 0x%x, wrap count %d, hdr =
version %d size %d format %d, alignment %d",
> -		 log->name, log->write_index, size, log->wrap_count, log->header_versi=
on,
> -		 header_size, log->format, log->alignment);
> +		 "FW log name \"%.*s\", write offset 0x%x size 0x%x, wrap count %d, hd=
r version %d size %d format %d, alignment %d",
> +		 (int)ARRAY_SIZE(log->name), log->name, log->write_index, size, log->w=
rap_count,
> +		 log->header_version, header_size, log->format, log->alignment);

[Severity: High]
This isn't a bug introduced by this patch, but since this patch fixes an
unbounded string read, is there a similar issue in ivpu_fw_parse() when
reading the firmware version?

Looking at drivers/accel/ivpu/ivpu_fw.c:ivpu_fw_parse():

	if (!scnprintf(fw->version, sizeof(fw->version), "%s", fw->file->data + VP=
U_FW_HEADER_SIZE))
		ivpu_warn(vdev, "Missing firmware version\n");

The scnprintf() function evaluates the length of the source string until a =
NUL
byte is found when no precision is provided for "%s", regardless of the
destination buffer size.

If the loaded firmware file lacks a NUL terminator at VPU_FW_HEADER_SIZE,
could this lead to an out-of-bounds read past the loaded firmware data?

This could trigger a page fault and expose adjacent kernel memory if a
malformed firmware file is supplied.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901125749.4043=
38-1-dawid.osuchowski@linux.intel.com?part=3D3
