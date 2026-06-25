Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83294CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDC210E116;
	Thu, 25 Jun 2026 12:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NSgXdqA3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85FFF10E116
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:53:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9638A6014C;
 Thu, 25 Jun 2026 12:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9BE1F00A3A;
 Thu, 25 Jun 2026 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782391984;
 bh=wQIZMxzfJjfzL8M591fghzvjvNH2xiN+Jtl9L8XO734=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NSgXdqA3+W+PyPIPoI5B6cUWyKPOqC/NGNStvDnsl4Jk5bZRVHk9z8UYxGFEOW25W
 j8UguxBtH6s1QLIsQwsKyIqveaAVtkZaVojxBgr1uQ+LFXvSawv/U5lpk2avWApoea
 xI74p0Wn8AZTscK8r9XrL1lbBfZcunrr2+OziM3aP/fHw8PyWbD2LUdDi3F2bnO2Gq
 uZ80+TYQo1VapuEbAQIMTaqtn5h/QGwKREzF01UVWqAJUt84PI7lJrtAZ4NchTjHj9
 zoYLJcrmvMjS4sms+Yqke3OovkBdzymYBnN3/GAcP+u1aRqcr7e2F2XVP+NxIFJXcq
 sDMGbV7eJXoJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] drm/panthor: Drop a needless check in
 panthor_fw_unplug()
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-panthor-misc-fixes-v1-8-b67ed973fea6@collabora.com>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-8-b67ed973fea6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 12:53:03 +0000
Message-Id: <20260625125304.2E9BE1F00A3A@smtp.kernel.org>
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
- [High] Integer overflow in `panthor_fw_read_build_info` leads to an out-o=
f-bounds read when parsing untrusted firmware.
--

commit 36848cd8008e907cd2d324339568a4a41f683911
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Drop a needless check in panthor_fw_unplug()

panthor_fw_unplug() is only called if we at least managed to initialize
the IRQ, so it's safe to drop the "is IRQ initialized" check.

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index 986151681b246..4fbddb9e18c8b 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c

[ ... ]

drivers/gpu/drm/panthor/panthor_fw.c:panthor_fw_read_build_info() {
    ...
	if (hdr.meta_start > fw->size ||
	    hdr.meta_start + hdr.meta_size > fw->size) {
		drm_err(&ptdev->base, "Firmware build info corrupt\n");
		/* We don't need the build info, so continue */
		return 0;
	}

	if (memcmp(git_sha_header, fw->data + hdr.meta_start, header_len)) {
		/* Not the expected header, this isn't metadata we understand */
		return 0;
	}

	/* Check that the git SHA is NULL terminated as expected */
	if (fw->data[hdr.meta_start + hdr.meta_size - 1] !=3D '\0') {
    ...
}

[Severity: High]
This is a pre-existing issue, but does this bounds check use 32-bit
arithmetic that can wrap around before the promotion to size_t?

If an attacker supplies a large meta_size (e.g., 0xFFFFFFFF) and a carefully
chosen meta_start (e.g., 0) such that their sum wraps around, could this
bypass the check since 0 > fw->size evaluates to false?

Execution would then call memcmp() on the attacker-controlled meta_start
offset. If the string matches "git_sha: ", execution proceeds to:

    fw->data[hdr.meta_start + hdr.meta_size - 1]

Could this evaluate to fw->data[0xFFFFFFFF] (a 4GB out-of-bounds offset)
and cause a page fault or oops when parsing untrusted firmware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-panthor-mi=
sc-fixes-v1-0-b67ed973fea6@collabora.com?part=3D8
