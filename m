Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC2B107BCD9
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 19:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F9310E437;
	Fri, 13 Mar 2026 19:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="U7BWopFG";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C0E10E42B
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 19:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773429553; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bDbaw1w3PslTNM25oV6x88wM2KxstmcTTCYyDFzsaIGXwwLj7CgKBpwcvcSUTb+SWZ0hOGNncUjhriEL51Zi9lbz4uLSTGjA6wc04cbSxFsQv+xiPs8BfOWSLeYFWkk/HoF4Jp7y1PJHMGfF1RNYjQiA7+WME/86DdI3gAh2c90=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773429553;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CoKyXRFATQaNQaIfx0ExjD58Ac/pvYYKQkj0sFiiIQk=; 
 b=nqoHHvPZ8XoWQwj2v5jNA6NPsLalG/BjtYu05feMWeyulZyxNsIDqB9wEFWiiah71eW/3ylAc7+4axR6X5IT619N9qzTm0XAPWLQtyhckTsH/UPYuwmoUKjChYP+Tk2WDpAoKKpBE9szhTtkCdDtCDG81ot/EG9PhZcVgZUxPKo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773429553; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=CoKyXRFATQaNQaIfx0ExjD58Ac/pvYYKQkj0sFiiIQk=;
 b=U7BWopFGJIm4bfde1qPs0zDF0h8+Vl5NVJlIGcDAm+608nnfZyh5UZQfebs6IzYz
 YyBvqepKErKQ+Q7OnWs8AlB9YCRbg/fdQhMBokC4QW93XWJeMBi6zJGqp5Tvyglanrg
 HMYzOF3E24kjWKhcgEiBh7QXkA3R2a+aYobiqJ0A=
Received: by mx.zohomail.com with SMTPS id 1773429550667736.5198846363646;
 Fri, 13 Mar 2026 12:19:10 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 5/5] drm/tyr: Remove custom register struct
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260311-b4-tyr-use-register-macro-v2-v2-5-b936d9eb8f51@collabora.com>
Date: Fri, 13 Mar 2026 16:18:48 -0300
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
Message-Id: <7A452659-65D9-48A6-9437-96E4291C3923@collabora.com>
References: <20260311-b4-tyr-use-register-macro-v2-v2-0-b936d9eb8f51@collabora.com>
 <20260311-b4-tyr-use-register-macro-v2-v2-5-b936d9eb8f51@collabora.com>
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
> Now that Tyr uses the register! macro, it no longer needs to define a
> custom register struct or read/write functions, so delete them.
>=20
> Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> drivers/gpu/drm/tyr/regs.rs | 33 ---------------------------------
> 1 file changed, 33 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index =
6c16a041ab3c36f8aaf785487ad61925be65a026..3fc5101c2dcd5d892abc726ea07d75d8=
f22b5d23 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -27,39 +27,6 @@
> // does.
> #![allow(dead_code)]
>=20
> -use kernel::{
> -    device::{
> -        Bound,
> -        Device, //
> -    },
> -    devres::Devres,
> -    io::Io,
> -    prelude::*, //
> -};
> -
> -use crate::driver::IoMem;
> -
> -/// Represents a register in the Register Set
> -///
> -/// TODO: Replace this with the Nova `register!()` macro when it is =
available.
> -/// In particular, this will automatically give us 64bit register =
reads and
> -/// writes.
> -pub(crate) struct Register<const OFFSET: usize>;
> -
> -impl<const OFFSET: usize> Register<OFFSET> {
> -    #[inline]
> -    pub(crate) fn read(&self, dev: &Device<Bound>, iomem: =
&Devres<IoMem>) -> Result<u32> {
> -        let value =3D (*iomem).access(dev)?.read32(OFFSET);
> -        Ok(value)
> -    }
> -
> -    #[inline]
> -    pub(crate) fn write(&self, dev: &Device<Bound>, iomem: =
&Devres<IoMem>, value: u32) -> Result {
> -        (*iomem).access(dev)?.write32(value, OFFSET);
> -        Ok(())
> -    }
> -}
> -
> /// These registers correspond to the GPU_CONTROL register page.
> /// They are involved in GPU configuration and control.
> pub(super) mod gpu_control {
>=20
> --=20
> 2.52.0
>=20

Ah, much better now. Thanks!

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
