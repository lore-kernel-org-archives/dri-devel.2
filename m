Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4678107BCD0
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 19:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C6E10E18D;
	Fri, 13 Mar 2026 19:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="TM9JLdaF";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 231D510E18D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 19:18:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773429496; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VcL2GLiTCWTItirQfyLnX38j3VRSR65hVZw+AwaHE3VU5szEbpNzfziQppfiswocXCqEFMZmA/z0l34Fu6/2+JYOYvCxhPdvtFcGB8I5bQkEqxBwPw0M0XyHUbRlCNJ2so5S4EYcAGVWYrjrZS8XpTWIEF/WND4uQp3yrz9RvAI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773429496;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=yY0FrrsuS3wV+AMHglNHlOoP/Q+e0/GquE22z2KC0j8=; 
 b=QLo6ZyF6UE5M5GDDoK6+S5AuRfCdAuglYdNWlQtCtojfTxND95feV/C+XPnRjVH09Zy2dxUjRgWaauAQV4iPVF8vr6nNDEc1ufNp0dAhawA6Pc14XAnHFoLCnYyGWLEZbW9CMtvLtf9R4oAKzRDCUqjvSaovOT9gZOKeCB/ykbY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773429496; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=yY0FrrsuS3wV+AMHglNHlOoP/Q+e0/GquE22z2KC0j8=;
 b=TM9JLdaFjZ4xdCjmKNueUmjiugUFuVSSUThY0eqFL9VOopShosi53u5v+2UQxhyx
 nEsRCslNZZhSM9dPP79YJXE4VO7PlMaJHhERN/cc24SxyH9OLBhbschvtHqhO8RRw4a
 AZbI9qjTEkDDkw6J1Q2knokkmb6IO6QOBNSlAMa4=
Received: by mx.zohomail.com with SMTPS id 1773429494921787.0272129881002;
 Fri, 13 Mar 2026 12:18:14 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 4/5] drm/tyr: Use register! macro for MMU_CONTROL
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260311-b4-tyr-use-register-macro-v2-v2-4-b936d9eb8f51@collabora.com>
Date: Fri, 13 Mar 2026 16:17:51 -0300
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Boqun Feng <boqun@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD257DBF-FF23-4703-ACBD-C011C146B59B@collabora.com>
References: <20260311-b4-tyr-use-register-macro-v2-v2-0-b936d9eb8f51@collabora.com>
 <20260311-b4-tyr-use-register-macro-v2-v2-4-b936d9eb8f51@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
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



> On 11 Mar 2026, at 20:04, Deborah Brouwer =
<deborah.brouwer@collabora.com> wrote:
>=20
> Convert the MMU_CONTROL register definitions to use the `register!` =
macro.
>=20
> Using the `register!` macro allows us to replace manual bit masks and
> shifts with typed register and field accessors, which makes the code
> easier to read and avoids errors from bit manipulation.
>=20
> Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> drivers/gpu/drm/tyr/regs.rs | 56 =
+++++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 51 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index =
686986536297ac2cc53ff14b162b19eaa759c192..6c16a041ab3c36f8aaf785487ad61925=
be65a026 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -627,11 +627,6 @@ impl MCU_STATUS {
>=20
> pub(super) use gpu_control::*;
>=20
> -pub(crate) const MMU_IRQ_RAWSTAT: Register<0x2000> =3D Register;
> -pub(crate) const MMU_IRQ_CLEAR: Register<0x2004> =3D Register;
> -pub(crate) const MMU_IRQ_MASK: Register<0x2008> =3D Register;
> -pub(crate) const MMU_IRQ_STAT: Register<0x200c> =3D Register;
> -
> /// These registers correspond to the JOB_CONTROL register page.
> /// They are involved in communication between the firmware running on =
the MCU and the host.
> pub(super) mod job_control {
> @@ -681,3 +676,54 @@ pub(super) mod job_control {
>         }
>     }
> }
> +
> +/// These registers correspond to the MMU_CONTROL register page.
> +/// They are involved in MMU configuration and control.
> +pub(super) mod mmu_control {

Like Boris, I see no reason for pub(super) instead of pub(crate).

> +    use kernel::register;
> +
> +    register! {
> +        /// IRQ sources raw status.
> +        ///
> +        /// This register contains the raw unmasked interrupt sources =
for MMU status and exception
> +        /// handling.
> +        ///
> +        /// Writing to this register forces bits on.
> +        /// Use [`IRQ_CLEAR`] to clear interrupts.
> +        pub(crate) IRQ_RAWSTAT(u32) @ 0x2000 {
> +            /// Page fault for address spaces.
> +            15:0    page_fault;
> +            /// Command completed in address spaces.
> +            31:16   command_completed;
> +        }
> +
> +        /// IRQ sources to clear.
> +        /// Write a 1 to a bit to clear the corresponding bit in =
[`IRQ_RAWSTAT`].
> +        pub(crate) IRQ_CLEAR(u32) @ 0x2004 {
> +            /// Clear the PAGE_FAULT interrupt.
> +            15:0    page_fault;
> +            /// Clear the COMMAND_COMPLETED interrupt.
> +            31:16   command_completed;
> +        }
> +
> +        /// IRQ sources enabled.
> +        ///
> +        /// Set each bit to 1 to enable the corresponding interrupt =
source, and to 0 to disable it.
> +        pub(crate) IRQ_MASK(u32) @ 0x2008 {
> +            /// Enable the PAGE_FAULT interrupt.
> +            15:0    page_fault;
> +            /// Enable the COMMAND_COMPLETED interrupt.
> +            31:16   command_completed;
> +        }
> +
> +        /// IRQ status for enabled sources. Read only.
> +        ///
> +        /// This register contains the result of ANDing together =
[`IRQ_RAWSTAT`] and [`IRQ_MASK`].
> +        pub(crate) IRQ_STATUS(u32) @ 0x200c {
> +            /// PAGE_FAULT interrupt status.
> +            15:0    page_fault;
> +            /// COMMAND_COMPLETED interrupt status.
> +            31:16   command_completed;
> +        }
> +    }
> +}
>=20
> --=20
> 2.52.0
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
