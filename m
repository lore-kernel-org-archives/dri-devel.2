Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01443C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1007A10F173;
	Tue, 15 Sep 2026 12:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gDuBmyMb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DCA810F173
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:39:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCD444143A;
 Tue, 15 Sep 2026 12:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1C91F0089C;
 Tue, 15 Sep 2026 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789475974;
 bh=PCrx61r+WjhYK6M7NL1fOYENh0kcxb0uFV2ps0JHmXs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gDuBmyMb5NUb0f63N0hzpGCeBBwUFKDSsYUOH49EV+yLR1N9zf84PL6llByk/FOYP
 tuLNCI1URu2g9W/RL3duDIIfpM2ajk+rZTDaTodKmGVCY7rLY+W1I/UBLc0azXTi6O
 oIU3Tn825ZbPlRG1Ta+5CLIZdx9QULRsD2A0y04URBzv7gVZxopPPtWitfnag7L2Bx
 Cs8qDKWbWdzop7MokDv5yAdKkM6uktsHF91qK3V91HIQmuwYOdLUcZpsDCTU6fRJx1
 FShUd2UvQ/HKKVeodV8+7Qfm1jaCJHhHG3fdio3pGcPNvJEBCKu07gXU1d9nL6bk8Z
 99UygBgXaMThQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] vgacon: Use vt_cursor_{start,end}()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20260915123304.1027277-4-tzimmermann@suse.de>
References: <20260915123304.1027277-1-tzimmermann@suse.de>
 <20260915123304.1027277-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:39:34 +0000
Message-Id: <20260915123934.7B1C91F0089C@smtp.kernel.org>
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

> Replace vgacon's custom cursor metrics with the shared helpers
> vc_cursor_start() and vc_font_cursor_end(). Note that the _end()
> function returns the index of the scanline below the cursor, while
> VGA hardware expects the cursor's final scanline. Hence vgacon
> subtracts 1 from the end value.
>=20
> The cursor shapes remain mostly unchanged, except that non-underline
> cursors now also use the glyph's top-most and bottom-most scanline.
> This follows the style used by fbcon.
>=20
> v2:
> - restore use of vc_cell_height (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915123304.1027=
277-1-tzimmermann@suse.de?part=3D3

