Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA6CC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9A410E941;
	Wed, 23 Sep 2026 16:29:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="auF5lQbs";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD18E10E941
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790180985; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eMkK9jljnaAGA3UKMIQxdtAdzQx5+mQIPuJCRKLCCWCBCRyE0fvDoFiwxlmHclMLFLJfPOsa2x4aTpj38L+lJfitYhOvqGEHSyYUNV8cQCWmoJbPwyGwhQzhuXmbJUmvZTv4kU2EjTdqsrJrcPYzicGIANMga5Q/yabK1cZ0LU4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790180985;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=honOZdl9wry64JgMz31XKXdFoAX9aKnTxZ89OftIsLg=; 
 b=exCsol+Hveja4UdKkALCkt9+j5mm3NRRMmQKgxk4yE+qPBmLdbsDreQ4S37fVXQvvjt36P+rHTc0Rn/13//ImgEH2rQAev+/C8ax97wtWTlgeuOKYjkVvf5+gG6NyjPUEXLQ/FYNZDVT5R5ftQJ+SG5qgfd2RJXMb0MFgHT5fZk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790180985; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=honOZdl9wry64JgMz31XKXdFoAX9aKnTxZ89OftIsLg=;
 b=auF5lQbskSRsp1waSQO0xhG3D5F2kNSrQEbxS+U3Ky0hkSrw/LvMMfAWvptm6Kq+
 l5cJRSYI3vDAlNRy/c2Sr/iVO5bZ41kcSmLQlv7ihq4raoSNj5p/py8QZI4UNJhjUy5
 UdMt9TqPrhY9jlQTgqjus9ILX5pCqK7e8S8bFmRo=
Received: by smtp.zohomail.com with SMTPS id 1790180982645897.526443803996;
 Wed, 23 Sep 2026 09:29:42 -0700 (PDT)
Date: Wed, 23 Sep 2026 09:29:41 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tyr: use `bitfield!` instead of `register!` for
 non-registers
Message-ID: <arP-dat7V0Rg70ok@um790>
References: <20260910165734.80378-1-gary@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910165734.80378-1-gary@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.142.6
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

On Thu, Sep 10, 2026 at 05:57:33PM +0100, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> `SectionFlags` and `MMU_MEMATTR_STAGE1` are not registers themselves. Use
> `bitfield!` directly.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  drivers/gpu/drm/tyr/fw.rs   | 12 ++++--------
>  drivers/gpu/drm/tyr/regs.rs | 11 +++++------
>  2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
> index 7edb5eff1707..aea151ff1f93 100644
> --- a/drivers/gpu/drm/tyr/fw.rs
> +++ b/drivers/gpu/drm/tyr/fw.rs
> @@ -14,6 +14,7 @@
>  //! [`Section`]: crate::fw::Section
>  
>  use kernel::{
> +    bitfield,
>      device::{
>          Bound,
>          Device, //
> @@ -27,7 +28,6 @@
>      },
>      num::Bounded,
>      prelude::*,
> -    register,
>      str::CString,
>      sync::{
>          Arc,
> @@ -39,8 +39,7 @@
>  use crate::{
>      driver::{
>          IoMem,
> -        TyrDrmDevice,
> -        TyrRegisters, //
> +        TyrDrmDevice, //
>      },
>      fw::parser::{
>          FwParser,
> @@ -101,11 +100,8 @@ fn from(value: CacheMode) -> Self {
>      }
>  }
>  
> -register! {
> -    base: TyrRegisters;
> -
> -     #[allow(non_upper_case_globals)]
> -    pub(super) SectionFlags(u32) @ 0x0 {
> +bitfield! {
> +    pub(super) struct SectionFlags(u32) {
>          0:0 read => bool;
>          1:1 write => bool;
>          2:2 exec => bool;
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index 0c419c4e1186..6f626957a010 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -986,6 +986,7 @@ pub(crate) mod mmu_control {
>      /// This array contains 16 instances of the MMU_AS_CONTROL register page.
>      pub(crate) mod mmu_as_control {
>          use kernel::{
> +            bitfield,
>              num::Bounded,
>              prelude::*,
>              register, //
> @@ -1130,14 +1131,12 @@ fn from(val: MemoryType) -> Self {
>              }
>          }
>  
> -        register! {
> -            base: TyrRegisters;
> -
> +        bitfield! {
>              /// Stage 1 memory attributes (8-bit bitfield).
>              ///
> -            /// This is not an actual register, but a bitfield definition used by the MEMATTR
> -            /// register. Each of the 8 bytes in MEMATTR follows this layout.
> -            MMU_MEMATTR_STAGE1(u8) @ 0x0 {
> +            /// Each of the 8 bytes in MEMATTR follows this layout.
> +            #[allow(non_camel_case_types)]
> +            struct MMU_MEMATTR_STAGE1(u8) {
>                  /// Inner cache write allocation policy.
>                  0:0     alloc_w => bool;
>                  /// Inner cache read allocation policy.

Reviewed-by: Deborah Brouwer <deborah.brouwer@collabora.com>

> 
> base-commit: 73e5616f3d197c1af5a04a481fe0f13aa3913bd1
> -- 
> 2.54.0
> 
