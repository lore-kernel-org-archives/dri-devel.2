Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468FDC5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 17:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9144410F39B;
	Fri, 21 Aug 2026 17:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GTXAOfd2";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0901A10F39B
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 17:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787333013; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MGrEfaEkbyY0rx0nwMDBxXJVIhIlJtq2nMuOqHq5Bxs8+N3r0gi7Tl0jIVH3E4etyE8cKrwiUvMk9dNPBfuMU6TyEjhMA1iyhkFEc7xOZ/Er65KcLgpo9BEf1OzriOwHyZ7M42gd5JCqygkbdkxiyuKtOYatMgN5db7j/oyILtw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787333013;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=s2U7DZDY9tfPJYgvMgpJ0UGRMetPtwyd+1Mwri0MT9I=; 
 b=SHzJHTZaNIx9Jhigiqn+b9nHweHTuD0dqXgfTinSDdFmsknr4CY3gx2ulo53fzWExSWoQNZyG9Sl+gDRTGq6LhRRGedh6hUx+3USsjgf8ZS19Rt7jOWTnL5tYI0oQMsoXjH9NmQqcvq8N8O+NRPVlAivMUyQXV1CKC3Vq12Uaz0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787333013; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=s2U7DZDY9tfPJYgvMgpJ0UGRMetPtwyd+1Mwri0MT9I=;
 b=GTXAOfd2BtFrtj/n7wWEE83keAOdzX7PTxcWVPOaU40Mpm8KoxaiqRqAoho0h7qe
 1mIJBHvgBPrXGLqOxJGjXFLbVbqYwIh8pgRdeXz6xqk/jw2EoOXIFRdRujXHjEEXKfd
 1YEwcG6HvnmpoAy/I3fJ7etglykhrtVxKhwqGK4g=
Received: by mx.zohomail.com with SMTPS id 1787333010663388.90751470786734;
 Fri, 21 Aug 2026 10:23:30 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 2/3] drm/tyr: add GPU reset infrastructure
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DKUS768JV9RM.36WFW7QI27WKK@kernel.org>
Date: Fri, 21 Aug 2026 14:23:12 -0300
Cc: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, aliceryhl@google.com, airlied@gmail.com,
 simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <74217098-8793-4701-8292-FBE0DB31FD48@collabora.com>
References: <20260819-tyr-reset-impl-v6-0-7b4e1e041fe5@onurozkan.dev>
 <20260819-tyr-reset-impl-v6-2-7b4e1e041fe5@onurozkan.dev>
 <653D47F5-0AF3-44B5-9896-F0AA81F67B61@collabora.com>
 <20260821155814.980146-1-work@onurozkan.dev>
 <2AD43D0D-2B01-47E3-AACB-32032B3358C9@collabora.com>
 <DKUS768JV9RM.36WFW7QI27WKK@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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



> Why do you think it is useful to print "Starting GPU reset." and "GPU =
reset
> completed." with dev_info()? How does this help users or help with =
debugging?
>=20
> In general, if drivers work properly they should remain silent. A =
successful
> reset means it worked properly. What you rather want to print, likely =
with
> dev_warn() or dev_err(), is what caused the GPU reset to be performed =
in the
> first place.

I agree, no argument from me there. The problem is, when the GPU is =
resetting,
things are far from "working". In fact, things went so bad somewhere =
that it
brought the device down for everybody, and the system is taking steps to =
(try
to) bring it up again.

As a user, I very much appreciated this when games went down, it made me =
think
that the problem was important enough to report, and also likely =
explained why,
in that particular hardware, things didn't really work 100% well =
afterwards,
which prompted me to reboot the machine.

Two outcomes could have come from that, a) filing a bug on the game =
itself, and
b) telling the kernel guys that their reset code wasn't really working =
100%
well either.

I do agree that "Starting GPU reset" is frivolous, but at least a =
message
saying that a reset took place, either sucessfully or not, is better =
than
silence. In fact, isn't this exactly what AMDGPU does? [2].

[2]: =
https://elixir.bootlin.com/linux/v7.2/source/drivers/gpu/drm/amd/amdgpu/am=
dgpu_device.c#L5094

> On 21 Aug 2026, at 14:01, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Fri Aug 21, 2026 at 6:39 PM CEST, Daniel Almeida wrote:
>> My point is that resetting the GPU should not be a =E2=80=9Cdebug=E2=80=
=9D trace, but rather
>> something that should hit dmesg unconditionally. Of all things that =
are
>> printed on a driver, a =E2=80=9Chey the GPU is being reset because =
something crashed=E2=80=9D
>> is something that should always show up IMHO.
>=20
> Please see my reply in [1]. If something crashed, please feel free to =
add a
> dev_warn() or dev_err() print about the exact error condition. But =
please do not
> add dev_info() prints about things that were successful and just bloat =
dmesg.
>=20
> In this specific case you want the caller of ResetHandle::schedule() =
to print
> about *why* the reset work was scheduled. You also already have a =
dev_err()
> print when the GPU reset failed. So, at this point you're good =
already.

I guess that also works, so long as it says that the GPU is resetting? =
i.e.:
it=E2=80=99s not only a fault or something, but also a message saying =
=E2=80=9Cthis fault=E2=80=9D (or
whatever it was) is causing a reset.

>=20
> Additional prints about when exactly the reset work starts and when it =
completes
> is stuff for dev_dbg().
>=20
> [1] https://lore.kernel.org/all/DKUR5TGKTJT1.3VR0LSG4WWXJJ@kernel.org/

