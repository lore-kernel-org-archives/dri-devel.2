Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE802606A331
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLYXkxjU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BAD010E0A4;
	Sat, 14 Nov 2026 01:26:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A115C10E09B;
 Sat, 14 Nov 2026 01:25:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DC157436BF;
 Sat, 14 Nov 2026 01:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C77F1F000C4;
 Sat, 14 Nov 2026 01:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794619553;
 bh=EGMcbQNpM5ycrfarujXX+IWIzzIOT9p/YlajlU9HU0M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HLYXkxjUYAvlXP0sOyTrIDgO/VW/bNmfcl5F+FePLgWT8XVqS3k//aOYlnYDG/aDl
 OAsxdbaymvLz7J/K3PpHb3tgSLgB1c/oN2WwdnSPhV6Lb9GyQhLP+/PQZlaoM7d/gE
 6wu7Gby4KZRk/z0RxFe7YLIsJIWoMF0gr3KUoCtq4b54T6oh5RTbWjAPBU0PgZY0rf
 eNXAej2Q8xyvW5Voe7n8Kz936xFFHPNBZEtgcsDNc4CVQ1qlaReHIlejDQvWmfOBPw
 UPDJp2tGseqeOguuil8C10x/Fmr3OOKLPoJS4rc1luy+vM5oKXU5pej5qx8v0MUx53
 +87TqM7wmHx2g==
Message-ID: <sashiko-outbox-214003@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/edid: Read the monitor range from the DisplayID
 Adaptive-Sync block
To: ElXreno <elxreno@gmail.com>, dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <20261114010749.1949247-1-elxreno@gmail.com>
References: <20261114010749.1949247-1-elxreno@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:25:53 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/edid: Signed-off-by trailer uses handle instead of full
  real name
--

commit ccbdbf24ebcae6dbb6cf32b1e44947510278e9c5
Author: ElXreno <elxreno@gmail.com>

> drm/edid: Read the monitor range from the DisplayID Adaptive-Sync block
>
> A DisplayID 2.x Adaptive-Sync data block (tag 0x2b) lists the refresh
> rate ranges a display supports with an adaptive vertical total. Some
> panels advertise their variable refresh range only there, and some
> keep a narrower one in the base block range limits. The BOE
> NE180QA1-MM1 is of the second kind: the range limits descriptor says
> 48-120 Hz, the Adaptive-Sync block has three descriptors,
>
>  27 00 30 ef 00 00
>  27 00 30 77 00 00
>  27 00 30 3b 00 00
>
> for 48-240, 48-120 and 48-60 Hz. A driver that checks a mode against
> monitor_range then refuses VRR for the 240 Hz timing of that panel.
>
> Use the block in both cases. Without a range from the base block take
> the range from the descriptors. With one, keep its minimum and only
> raise the maximum, and only from descriptors that reach down into it,
> so that the result never goes below what the base block promises.
>
> monitor_range stays one range per connector. Only descriptors for the
> native panel range that declare the adaptive vertical total operation
> mode count: a descriptor for fixed average vertical total alone does
> not describe a range to pick a vertical total from. Where several
> count, the highest minimum and the highest maximum are used. Without
> a base range every rate in the result is then within the descriptor
> that reaches highest. With one, every rate is within the base range
> or within that descriptor, which overlaps it.
>
> The layout is taken from edid-decode (parse_displayid_adaptive_sync()
> in utils/edid-decode/parse-displayid-block.cpp of v4l-utils), not
> from the DisplayID text: a descriptor is 6 bytes plus the count in
> bits 6:4 of the block revision, byte 0 has the native panel range
> flag in bit 0 and the operation mode in bits 3:2 (1 for fixed average
> and adaptive vertical total), byte 2 is the minimum refresh rate,
> bytes 3-4 hold the maximum refresh rate minus one in ten bits. The
> block is read from any section of structure version 2.0 or later,
> which is what the panel above declares.
>
> This reaches every driver that reads monitor_range. A display with
> such a block and no base block range now has a range where it had
> none, which is the point for i915 and xe (their other VRR conditions
> still apply). amdgpu scans DisplayID tag 0x25 on its own when the
> minimum or the maximum is zero, and with a range from the
> Adaptive-Sync block that scan is no longer reached. When the display
> has no AMD VSDB, amdgpu takes monitor_range as its refresh rate
> range, so it follows the raised maximum, and a DP or eDP display that
> has only the Adaptive-Sync block can now pass its FreeSync test (a
> range wider than 10 Hz and a sink that ignores the MSA timing). With
> a VSDB that advertises FreeSync the range still comes from there.
>
> Signed-off-by: ElXreno <elxreno@gmail.com>

[Severity: High]
Could the Author header and Signed-off-by trailer use a full real name
instead of the handle ElXreno?  Documentation/process/submitting-patches.rst
requires a real name for the Developer's Certificate of Origin and does
not permit pseudonyms or handles.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114010749.1949=
247-1-elxreno@gmail.com?part=3D1
