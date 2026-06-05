Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD5ACD8C81
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1174311A90F;
	Fri,  5 Jun 2026 14:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hYZWfuAP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E19E111A90F
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:41:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C71BE4419F
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AD61F00898;
 Fri,  5 Jun 2026 14:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780670504;
 bh=bEx0YHRGn4x2/E/byC2PUztwBRJN2xK+0yTIvxw6Fek=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hYZWfuAPs70rIcXpOl46ycLxyerofKC//Sv3j02J3EiVU9Vkl7L7RBEA1m+KQCvDK
 vFGfdVlqRp07Otz9TWPHau3U4NqpNAUg1S6gLUUjUB4tE9WBa7BcP/iWX8Na6prsfV
 cswp7mWuY236vIK3+YMqvREbZcY8nHMc3yPpe4qfUaPWy1PQpaSk7+E5yaoJlaKOwU
 U7KoXN2T8gs9WnVSMUjuYfZC3FQQZz6X7vYBtA6EXg8b08I0WFD1UOAzfnkVoNxfS1
 ntiOKLoAB4Ttky4+q4gvJi7f+AqlVXWDllCNCuWFQWpiu1uMP//woFuMXv9ZF0M3BD
 0QzAeeFiKfFMg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfauth.phl.internal (Postfix) with ESMTP id B763FF4006C;
 Fri,  5 Jun 2026 10:41:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 05 Jun 2026 10:41:43 -0400
X-ME-Sender: <xms:J-AiagsRYCTZzC8xd7DWZfAHtgnZhfFlSvlblrwxEBSWuTG1ulAJ9g>
 <xme:J-AiaoZCi5uyfvYL6FJeERgBLh_aixsfLyoNtGKJHByHqn_JiYEXRbBMZYk0c0sb7
 3dEmDpsAs6memo1T-qp3GChA2igJQbkiJZqMVWI5RDGPoajHLy4Zw>
X-ME-Received: <xmr:J-AiaqwtoO1L0yJdjYh1Z56Jqc3SDjkREAsZUbgO-ue1qbXA3fb9Hb5xgVc>
X-ME-Proxy-Cause: dmFkZTEMTIMmD8CvJoT/D/NDj88GXOnaCJSn7KQ2MI0QXg07/gTaBqxkFXNP5xthK4ek8r
 OmJ6M00G6rq3CllsjHXAhM0v35O0QEjaL36NBCfxRtqE0bxrU+wwgRWIGSv3x92yAlZxKt
 BP579Vy8yNalz3OaUwnIdBjqF9AFwHZyoSYo224UZrqlk28WIy0mM+OPKaZbCzFuijwFZr
 e5wwQVJnNkpHtLkwjopfQ3Ed6NiInuNOLSYYCdxJDKCpuMTcAHxghq4i5PLFrE9Zo8sdhy
 lZsfESjL85RfZu0R92Lej89in0RIS6wVFbepj+i+IWrF9ioUtL/Gh+68BjjJ80qmbNCISI
 5RUMmQ0rQLnTjxzMJeEFYjnrH252VrJFaxHfCJWZjtcvFqewAgOoNwqnNn+y7i27tKyykA
 I84Qh/coKsyaO7Y1F8WKail4aGwvokp22qVGxWjAeDH/oc+7WuELKjlLKpgqmaAnwNPgYj
 wTldw5wraKRlkdwqban1rEyDmCcrzYMZz7r53p8+shcQbq/sgPEAaTKa1JZC6MaNLmo8nG
 +ncgU/7vrfExJx6ovknNLIjedvVqG9nn2LkfgNsmshyjkXUsCztDNJsEGwoY03KCVCXAa4
 buzAcA9NfOsDbMfCEvHp5o0tI9W6rKqFFtu6HzOIAc2mzs5Ia+V1+EsumGng
X-ME-Proxy: <xmx:J-Aiaoj-mVclCuiTqqQ4tgRWnGw48Mpa5ybOp1Ch6rbn27wa44XgiA>
 <xmx:J-Aiaulr4yeC8us2Ukz1ecpuZC1yx_cWOE0oh9-7g_d5m7GYvmtzKA>
 <xmx:J-Aiami2Q2anhB6HZVf-aJE7UNK2FDmmg9GrJJm97kUrRZBQw1LUjQ>
 <xmx:J-Aiaq3uSgAil1Ge3sjbLCdOdlpW8xmbCXoR4IorVf-7uvV5VA9QzQ>
 <xmx:J-AianJtINJYjsKg-5PHbsXeNHyevEYgRhebRkKMMbzQvDao0SiBIMAt>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 10:41:43 -0400 (EDT)
Date: Fri, 5 Jun 2026 07:41:42 -0700
From: Boqun Feng <boqun@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH 1/3] rust: rcu: add RcuBox type
Message-ID: <aiLgJkKzwEDGWNtY@tardis-2.local>
References: <20260605133541.22569-2-boqun@kernel.org>
 <20260605134935.B6C0E1F00893@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605134935.B6C0E1F00893@smtp.kernel.org>
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

On Fri, Jun 05, 2026 at 01:49:35PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] RcuBox::into_foreign drops `self` instead of forgetting it, causing a guaranteed Use-After-Free.
> - [High] RcuBox::drop bypasses the custom Allocator A and hardcodes kvfree_call_rcu() for types that do not require dropping, causing undefined behavior for non-kvfree compatible allocators.
> --
> 
> commit f69c06884595bb68a76f4f1dd4014ee9e2c9e31c
> Author: Alice Ryhl <aliceryhl@google.com>
> 
> rust: rcu: add RcuBox type
>     
> This adds an RcuBox container, which is like Box except that the value
> is freed after waiting for one grace period (via {kvfree_,}call_rcu()).
> To allow containers to rely on the RCU properties of RcuBox, an
> extension of ForeignOwnable is added.
> 
> > diff --git a/rust/kernel/sync/rcu/rcu_box.rs b/rust/kernel/sync/rcu/rcu_box.rs
> > new file mode 100644
> > index 0000000000000..943fe3e8974e0
> > --- /dev/null
> > +++ b/rust/kernel/sync/rcu/rcu_box.rs
> 
> [ ... ]
> 
> > +// SAFETY:
> > +// * The `RcuBoxInner<T>` was allocated with `A`.
> > +// * `NonNull::as_ptr` returns a non-null pointer.
> > +unsafe impl<T: Send + 'static, A: Allocator> ForeignOwnable for RcuBox<T, A> {
> > +    const FOREIGN_ALIGN: usize = <Box<RcuBoxInner<T>, A> as ForeignOwnable>::FOREIGN_ALIGN;
> > +
> > +    type Borrowed<'a> = &'a T;
> > +    type BorrowedMut<'a> = &'a T;
> > +
> > +    fn into_foreign(self) -> *mut c_void {
> > +        self.0.as_ptr().cast()
> > +    }
> 
> [Severity: Critical]
> Since `self` is consumed by value here without being wrapped in `ManuallyDrop`
> or passed to `core::mem::forget()`, won't it be dropped at the end of this
> method?
> 
> This seems like it would immediately schedule the memory for RCU free, causing
> a use-after-free for the foreign code when it later accesses the pointer.
> 

[Cc Alice]

I fixed this locally by:

    fn into_foreign(self) -> *mut c_void {
        let ptr = self.0.as_ptr().cast();

        // FORGET: Leaking it as a pointer, the caller is responsible to free it or unleak it by
        // from_foreign().
        core::mem::forget(self);

        ptr
    }


Regards,
Boqun

> > +
> > +    unsafe fn from_foreign(ptr: *mut c_void) -> Self {
> 
[..]
