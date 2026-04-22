Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F44FFA1FEC
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 386F610E060;
	Wed, 22 Apr 2026 20:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.b="Oi7UDCCA";
	dkim-atps=neutral
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98FB710E060;
 Wed, 22 Apr 2026 20:33:44 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 886C740E00C0; 
 Wed, 22 Apr 2026 20:33:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
 reason="fail (body has been altered)"
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id tD28Lksxw9KL; Wed, 22 Apr 2026 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1776890010; bh=ZULv/2Ns+OXFe7bZ1RnxURwmdqhIqJdtiN70kRnMqB8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Oi7UDCCAnmnDSykhHnLPSbOkFhVPWtZTqFBNzUSZu6KrJj0fKyZ578gU4MfPYi3Ou
 7qSSxa06UtzW8GjlKld0Om2h8c8f0FeaGPZtnHyPBHW1vkOU63igicD4/CsRXKkGgg
 2Z9iIh6A9PfABzQs6H0E8LDMolEYtIE5Bhu6Hvz4lMZ1wem5lLCm4sgLXP/ZA0tpKd
 sc6gTC0u2mqEzYqZrkAuxDxcawS529vNBg2W4uOFiCp7j2l2qoXE2YjWugPuq07YYG
 qrbTR183E59+HNRFptT1lQoFq+g6WPM12DywYPfTS8A04buaXx7CRDxA9FasvQjNQy
 88MQAXFLYLWETKE2bJxhXZPXTNBjuzA08jQY6KIs8uAhZhmUNF+i4SSjW0g5IjDQtd
 aMmp7ps8F1qgVz50ujIZVEw0pAdnFI5aHQd1ToVdRtijbcl/fsJixL86zwhs5H+bXK
 vfzjB+T7JOe6QCMSFDjtuH9WdC3c9hsj5Xq6c0pabCmZ+iC4eVSOjiIvvpoOmbX0bw
 Kcg9mOgEL+0SAwRX3PqQYHeQiYPS0qyGkTw/sgfxYPNp1cALXVU2Fl3OC0TZ2G75yH
 SZHwPGVrRqZv3Sdxdd7P3ZIYhNhMyS4VNa7b2zlkiw5uNX2Ap5gaYRUXvnQB4LZM8c
 rkrnNPm7jTz2yDdJetTbiFJ8=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id
 DF0C240E0032; Wed, 22 Apr 2026 20:33:20 +0000 (UTC)
Date: Wed, 22 Apr 2026 22:33:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Rafal Ostrowski <rostrows@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: amdgpu: WARNING:
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:58 at
 dc_assert_fp_enabled+0x10/0x20 [amdgpu], CPU#5: (udev-worker)/418
Message-ID: <20260422203314.GCaekwikuCiHx8CK-S@fat_crate.local>
References: <20260421132303.GCaed6N9mDwutP6sEx@fat_crate.local>
 <CADnq5_POMAQyY1OtqE6v4-NwoN2ViUCTeq-RQp79UwpMeDZRYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_POMAQyY1OtqE6v4-NwoN2ViUCTeq-RQp79UwpMeDZRYA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Apr 21, 2026 at 10:06:01AM -0400, Alex Deucher wrote:
> On Tue, Apr 21, 2026 at 9:59=E2=80=AFAM Borislav Petkov <bp@alien8.de> =
wrote:
> >
> > Hi,
> >
> > this is latest Linus from today on a Zen2 laptop:
>=20
> +Rafal Ostrowski
>=20
> I think this should be fixed by:
> https://patchwork.freedesktop.org/patch/718415/
> Which is already included in my last PR.

So I just tested:

Merge: d46dd0d88341 a7756371e57f
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Apr 21 17:39:21 2026 -0700
=20
    Merge tag 'drm-next-2026-04-22' of https://gitlab.freedesktop.org/drm=
/kernel

hoping that your fix might've landed in the meantime there but nope, it s=
till
fires.

Also, patchwork is timeouting for me so can you pls send me this patch in=
line
here so that I can run it?

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
