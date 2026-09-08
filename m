Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F776C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED9D10EDD3;
	Tue,  8 Sep 2026 22:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NQRZGXpe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF9AD10EDD3
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:20:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 952BB42A84
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DA71F00A3A;
 Tue,  8 Sep 2026 22:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788906000;
 bh=L/pyLrJJsryFTFetowElsbI34h3mJbNyo4P7wZlCD4w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NQRZGXpe4btKpnDyZNASvFImdKTIz9JaWKSOkm2ElyKm3h0omr5jtRQM1Exk4fBSk
 3CiyLpz0+PlSETAP2orVCSltUybOsvbgrA44Y7710VutMAsyNqr3U7UQmj+keEFwhX
 BsbibxeWyC5U3Y4SKn27K/OgruYdisSdzbKTV9/6XTIoWcNjiCnC+Z6uU7HDO3Mm47
 Vqmp64r2P79TQWQKaSkStg+6RyDwzsVK/K2naS8J5K0h+lzzwWCFUU722o4acyEXr4
 SxyNL2e/FpIH5bgVua+67Qhy08DQAk0Ef5GgwtbU+zfaVwFquTQi0uvnA/kgDvyC15
 +9cud7dvtq18Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/22] accel: ethosu: Fix NHCWB16 bounds calculation
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-ethosu-fixes-v3-10-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
 <20260908-ethosu-fixes-v3-10-490fe215286f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:19:59 +0000
Message-Id: <20260908222000.57DA71F00A3A@smtp.kernel.org>
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
- [High] Missing endianness conversion for NPU command stream.
--

commit 0751ca432d602d192378042d9197a6392196efe4
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Fix NHCWB16 bounds calculation

This commit fixes the NHCWB16 bounds calculation for the Ethos-U NPU driver.
It adjusts the address calculation to account for the NPU accessing data in
complete 16-channel bricks.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 2707b7df5dbe6..6f6712f4efd1f 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c

[ ... ]

While reviewing this file, I noticed a pre-existing issue in
ethosu_gem_cmdstream_copy_and_validate():

drivers/accel/ethosu/ethosu_gem.c:ethosu_gem_cmdstream_copy_and_validate()
...
		if (get_user(cmds[0], ucmds++))
			return -EFAULT;

		bocmds[i] =3D cmds[0];

		cmd =3D cmds[0];
		param =3D cmds[0] >> 16;

		if (cmd & 0x4000) {
			if (get_user(cmds[1], ucmds++))
				return -EFAULT;

			i++;
			if (i >=3D size / 4)
				return -EINVAL;
			bocmds[i] =3D cmds[1];
...

[Severity: High]
This is a pre-existing issue, but should the NPU command stream be converted
for endianness here?

When reading from the user command stream on Big Endian hosts, the
Vela-compiled (Little Endian) commands will be read natively by get_user()
and copied directly to the DMA coherent buffer.

This causes the command opcode and parameter parsing to fail against the
expected command opcodes, returning -EINVAL.

This will cause the driver to reject valid jobs and render the driver
unusable on Big Endian architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-ethosu-fix=
es-v3-0-490fe215286f@kernel.org?part=3D10
