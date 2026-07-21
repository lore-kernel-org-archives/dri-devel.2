Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5766AC4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E474110EB83;
	Tue, 21 Jul 2026 22:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nanonej.com header.i=@nanonej.com header.b="RITv0cPo";
	dkim-atps=neutral
X-Greylist: delayed 402 seconds by postgrey-1.36 at gabe;
 Tue, 21 Jul 2026 15:57:56 UTC
Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch
 [79.135.106.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C377210E3A1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nanonej.com;
 s=protonmail2; t=1784649067; x=1784908267;
 bh=4xJdf7VXivw/wmWg7N3kuh9PsFrCjXHEJpgiZKPVOoc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=RITv0cPoav8kjkOZduD2wA3VWlIWqR0QQLXZeNAesxuutc8FhpHzT4NJqE5G0BZOD
 hRUJz6gFgCbK6bnYhW5yFZpz+jMfkBxo995/q/xDvoMqn75BklpIaExf2SOcclEzDp
 js3M/HwdE41w5CqHxloA9UraDefXS0fYEoxpNILCMzKNLOuNERal1FpwCDNgytTcoC
 OkU5uGcS+29840CmC3JQp8TnDWIZ0bdmbsSSgy1YDrDq7i5ijBvEIbf0kFSO4jaMdN
 GPKJN1ySBFUvmMwSFAMk/mS55kgasZ9tAq3rUHQ9YX+outBKYZ1QCAXrkovPR/gKi9
 rq4QUGLrmq5fw==
Date: Tue, 21 Jul 2026 15:51:04 +0000
To: Alexandre Courbot <acourbot@nvidia.com>
From: Nanonej Dev <dev@nanonej.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, daniel.almeida@collabora.com
Subject: Re: [PATCH 3/3] gpu: nova-core: Move one PBUS register definition
Message-ID: <TPL-Nmz1jd_sB3sr_x-746jIwTxY7IRTMU5b8jwBv1ice0C31BNvqzUzo3s68ZkE1-mfZHAx2SURO54hHnbR8CUPo3rNLnfHIs_ujtl8D_Q=@nanonej.com>
In-Reply-To: <20260721-nova-core-regs-split-v1-3-384fa2a42244@nanonej.com>
References: <20260721-nova-core-regs-split-v1-0-384fa2a42244@nanonej.com>
 <20260721-nova-core-regs-split-v1-3-384fa2a42244@nanonej.com>
Feedback-ID: 32181229:user:proton
X-Pm-Message-ID: 3cbe4f318882a5b26acc02f784099a943722e458
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------90ec2874e62782a973c832ee1cb04ece76142ec267716d49afc83988116fa4c7";
 charset=utf-8
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------90ec2874e62782a973c832ee1cb04ece76142ec267716d49afc83988116fa4c7
Content-Type: multipart/mixed;boundary=---------------------caaab8e2f47728585588c4be9d747c1d

-----------------------caaab8e2f47728585588c4be9d747c1d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

> - Move the `NV_PBUS_SW_SCRATCH_0E_FRTS_ERR` register under the `gsp`
>   module, since it is clearly themed after `FRTS`, which is part of the
>   GSP boot. But, without moving `NV_PBUS_SW_SCRATCH` (the actual
>   register being aliased). I expect you will hit a bug of the `register`
>   macro when doing this one - I'll try to address it, but the first two
>   steps should be safe to do and correct.

You told me that I would hit a bug on `NV_PBUS_SW_SCRATCH`, but as far as =
I compile, I didn't. Anything I could have missed?
-----------------------caaab8e2f47728585588c4be9d747c1d--

--------90ec2874e62782a973c832ee1cb04ece76142ec267716d49afc83988116fa4c7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmpflVAJEFKmzSsu6sDwRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeO7oAu5DM/5lP6bIP2W+HspMUPayb2ZPEYyasl
PmwVbBYhBI+99gDJjAW7MoHJ0VKmzSsu6sDwAADS/AD9EpYBfq9Kr+a39+kQ
akbqa9xwLHWgaL4MEK4wf7bbpCgA/RyEo4HklPGFdn5zLDzNb7te8K4qYiHa
YJma6b43vjoC
=WCSH
-----END PGP SIGNATURE-----


--------90ec2874e62782a973c832ee1cb04ece76142ec267716d49afc83988116fa4c7--

