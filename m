Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39DB107BCD7
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 19:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0419210E057;
	Fri, 13 Mar 2026 19:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="LBOXlLze";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F399910E057
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 19:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773429175; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FSWfR6j1DrHDC13UfRbB8j1DsWSYjv4hjbhwi7dSqSoz8H5AEkkbO59OYmhArRtMIWT9IujhrfNuyLh7Uk2C7yfIn4A+26o2d5QdYuCl9Dw7hlxXNlxTYZ9ZHZn3B4iRztEtTv/sXW4+1X+s36lA7KkpW1/y6Ux99F4Ym05+dt0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773429175;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=9Cu1moDd6FyNG2O6F3s76YBzJwRcb+zLd7wsEdTI6zI=; 
 b=RPuqgvIgEcjspLwassNCQbkMo81eDLkpzJ5N9XBvfe2iwhs1mJmr7YeRDEJN15gSE6TEhdnZEcHhLGH6l/XWetXGTuFweum7V8uIzWT7vvGbFmsKKoo0YXiLwZmhGjLIhEE2i0SLPU/jHCuy1CmvY/EUGQocZVeSbwAteTdg8+s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773429175; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=9Cu1moDd6FyNG2O6F3s76YBzJwRcb+zLd7wsEdTI6zI=;
 b=LBOXlLze91CTG7HYTg///qWUxvciiNEQf5HPZN8A26OFd8JcNta1IPFNA0TRbEGK
 OoIgmg1ea3fFs9jszn66FKLqo6FPLAEGQ9KzTlyDJGfO+Wmpqs+prgBG8B+868HDYyi
 BV1KmAsYYfoOLkuTgrdScwuAAeEXeYhHDBzxWXKo=
Received: by mx.zohomail.com with SMTPS id 1773429173856665.0141807260597;
 Fri, 13 Mar 2026 12:12:53 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 3/5] drm/tyr: Use register! macro for JOB_CONTROL
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260311-b4-tyr-use-register-macro-v2-v2-3-b936d9eb8f51@collabora.com>
Date: Fri, 13 Mar 2026 16:12:27 -0300
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
Message-Id: <023662E8-F6A3-411E-B7FF-0F7F14ACCCCE@collabora.com>
References: <20260311-b4-tyr-use-register-macro-v2-v2-0-b936d9eb8f51@collabora.com>
 <20260311-b4-tyr-use-register-macro-v2-v2-3-b936d9eb8f51@collabora.com>
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
> Convert the JOB_CONTROL register definitions to use the `register!` =
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
> drivers/gpu/drm/tyr/regs.rs | 58 =
++++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 50 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index =
ba61a3dbe2a3e6fa1169b03d4f62e82769041057..686986536297ac2cc53ff14b162b19ea=
a759c192 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -28,7 +28,6 @@
> #![allow(dead_code)]
>=20
> use kernel::{
> -    bits::bit_u32,
>     device::{
>         Bound,
>         Device, //
> @@ -628,14 +627,57 @@ impl MCU_STATUS {
>=20
> pub(super) use gpu_control::*;
>=20
> -pub(crate) const JOB_IRQ_RAWSTAT: Register<0x1000> =3D Register;
> -pub(crate) const JOB_IRQ_CLEAR: Register<0x1004> =3D Register;
> -pub(crate) const JOB_IRQ_MASK: Register<0x1008> =3D Register;
> -pub(crate) const JOB_IRQ_STAT: Register<0x100c> =3D Register;
> -
> -pub(crate) const JOB_IRQ_GLOBAL_IF: u32 =3D bit_u32(31);
> -
> pub(crate) const MMU_IRQ_RAWSTAT: Register<0x2000> =3D Register;
> pub(crate) const MMU_IRQ_CLEAR: Register<0x2004> =3D Register;
> pub(crate) const MMU_IRQ_MASK: Register<0x2008> =3D Register;
> pub(crate) const MMU_IRQ_STAT: Register<0x200c> =3D Register;
> +
> +/// These registers correspond to the JOB_CONTROL register page.
> +/// They are involved in communication between the firmware running =
on the MCU and the host.
> +pub(super) mod job_control {
> +    use kernel::register;
> +
> +    register! {
> +        /// Raw status of job interrupts.
> +        ///
> +        /// Write to this register to trigger these interrupts.
> +        /// Writing a 1 to a bit forces that bit on.
> +        pub(crate) JOB_IRQ_RAWSTAT(u32) @ 0x1000 {
> +            /// CSG request. These bits indicate that CSGn requires =
attention from the host.
> +            30:0    csg;
> +            /// GLB request. Indicates that the GLB interface =
requires attention from the host.
> +            31:31   glb;
> +        }
> +
> +        /// Clear job interrupts. Write only.
> +        ///
> +        /// Write a 1 to a bit to clear the corresponding bit in =
[`JOB_IRQ_RAWSTAT`].
> +        pub(crate) JOB_IRQ_CLEAR(u32) @ 0x1004 {
> +            /// Clear CSG request interrupts.
> +            30:0    csg;
> +            /// Clear GLB request interrupt.
> +            31:31   glb;
> +        }
> +
> +        /// Mask for job interrupts.
> +        ///
> +        /// Set each bit to 1 to enable the corresponding interrupt =
source or to 0 to disable it.
> +        pub(crate) JOB_IRQ_MASK(u32) @ 0x1008 {
> +            /// Enable CSG request interrupts.
> +            30:0    csg;
> +            /// Enable GLB request interrupt.
> +            31:31   glb;
> +        }
> +
> +        /// Active job interrupts. Read only.
> +        ///
> +        /// This register contains the result of ANDing together =
[`JOB_IRQ_RAWSTAT`] and
> +        /// [`JOB_IRQ_MASK`].
> +        pub(crate) JOB_IRQ_STATUS(u32) @ 0x100c {
> +            /// CSG request interrupt status.
> +            30:0    csg;
> +            /// GLB request interrupt status.
> +            31:31   glb;
> +        }
> +    }
> +}
>=20
> --=20
> 2.52.0
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

