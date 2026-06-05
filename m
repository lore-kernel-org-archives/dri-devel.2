Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF30CD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 13:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B9A112B44;
	Fri,  5 Jun 2026 13:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BFJnrfEU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6540112B44
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 13:58:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 07808601DD
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 13:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813921F00899;
 Fri,  5 Jun 2026 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780667910;
 bh=Q885mhCv0lIPD60VFH3SrbDmv8DP44ATAyk0g8vyOIw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BFJnrfEUeeqZ1RZ3Ul1PU1vuT6YpuWJi4TvxTRGDeHBmReq4769cYkueRrFA2Ezqw
 XoSwCrYHHOB/enzwzMOtgM/dZfneUZmNySFCpwIVMCmTzOUJ3yj44anGv0+vgq9WTk
 c1cNcP+f0YMbtlEzKcShPPpXtBj7JItoul0KGvdDLntCfjYyTkCiV4I5FjfEeTeCtE
 vfiE0ISq18u+vnWQOxm9qiEq01SMiBfSQv0hiyfNVO842opi97J5hXNrBKKGq+11ml
 pOpGN7BW01hU5uNUoDcE55FV6AF4tt2NC9aC/aI2wugrvO2Zcf4fjbX2r1YDkz/WH4
 9Yvd7M5qSy3kQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfauth.phl.internal (Postfix) with ESMTP id BEBE1F40081;
 Fri,  5 Jun 2026 09:58:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 05 Jun 2026 09:58:29 -0400
X-ME-Sender: <xms:BdYialzhV6KiM2N-ripSx4Ts3VydALqXnlHAG-cB68omg1IZyN8rVQ>
 <xme:BdYiauP1r6B4t8sge-RESH7li-TZKsapqOPHmty-_-C6MQY7ZbylUYQblv6UQOUOH
 -SnijHae-UYyedvQGzoSoUlZw_aK_fy6fTqTKY382AhRtAgj-i9dw>
X-ME-Received: <xmr:BdYiaq7rUl9oAJ1dreslzcRdEsyOH6VtQx2yKX__PYBzDu6N5wVN3olmsho>
X-ME-Proxy-Cause: dmFkZTGaSo7q4H7+bMA6ihnLQtBdT9xCwaWwGm0m9NWD4XbkJYiP2HHuhlBeMmscxt+LX7
 AgjNs9tdqamSEr20FWQv7TM6WxDP45fu+Va3WXZkbPXtP3t24wMICWWQ81RemQ26NKJx6H
 qeXbzzwuSgGAlKEhwLWjqlmQ1o7GFDVZ9FYhNp/6oo4D5Id27FHXJzLjJtH+Fy7Z4vaiBy
 xPGkSIBby0cGeUCWDOAynVpTTZ+qafifdbIupTJU1x24504y6qGygDSWKS740HrnVTLWp2
 iuEp6Gd+Cx4xr5Q2nerY3VdXxugbGnPvuSVawshoAbjl+4gTu2XfXxNCfYdZRwF+zJ4kiH
 mWuja+cPEJ6mqr05UJ+dyja/1qyKyJQAQC09a3i7BFZS0Jd5hG5gNbbo36L6dVE9L1A92g
 xmBPnfnFT9T5YdJDy3nkQLRuBYd3mFamqrec58fcIViXCMWYvoB810p4JEKWLU+sJh0DPi
 q1SpIgTcH0luyqoG0g+N+P8zHWiWOBwfF4brQFAVW9t50MnHY2Lvdi5mAHR1VlAwQDkEN9
 bjzrEqQNiWbHsfLDvDjvmZ8Jxb5ea8kqBJRdnjs5OX/k7OcYZzQwDI5li6IbcZnERy8Pia
 4mZGwCHYtNaaXHxOcPuaKuTcYc4oyaidKpqydcXN1AQKunK/JqDXbthRYcZQ
X-ME-Proxy: <xmx:BdYiannu5TVtKeoWOeolOWfSPbwzoooOYg6MIpkoinV3CSSpcCVYqA>
 <xmx:BdYiajSadpVXmaj599wn5ev4v66n-is06KcPapai76N8M-vSviBmqA>
 <xmx:BdYiauHP51Vh0kIuyAq_VE-gW_jluylhACQCUXDfSh9vFNQyyx9x9g>
 <xmx:BdYiagF4WQBzsD0H0vZSPGhOqI76irp7BXt_QtDjUjWpHJpSw_-jyA>
 <xmx:BdYiakQdBZZj4KLYK7d3oAFhWfmZD8A6Gute7Dak5RPYs95x5vAb38lh>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 09:58:29 -0400 (EDT)
Date: Fri, 5 Jun 2026 06:58:28 -0700
From: Boqun Feng <boqun@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: rcu: add RcuBox type
Message-ID: <aiLWBAE23BtXzVIU@tardis-2.local>
References: <20260605133541.22569-2-boqun@kernel.org>
 <20260605134935.B6C0E1F00893@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
[...]
> > +
> > +    unsafe fn from_foreign(ptr: *mut c_void) -> Self {
> 
> [ ... ]
> 
> > +impl<T: Send, A: Allocator> Drop for RcuBox<T, A> {
> > +    fn drop(&mut self) {
> > +        // SAFETY: The `rcu_head` field is in-bounds of a valid allocation.
> > +        let rcu_head = unsafe { &raw mut (*self.0.as_ptr()).rcu_head };
> > +        if core::mem::needs_drop::<T>() {
> > +            // SAFETY: `rcu_head` is the `rcu_head` field of `RcuBoxInner<T>`. All users will be
> > +            // gone in an rcu grace period. This is the destructor, so we may pass ownership of the
> > +            // allocation.
> > +            unsafe { bindings::call_rcu(rcu_head, Some(drop_rcu_box::<T, A>)) };
> > +        } else {
> > +            // SAFETY: All users will be gone in an rcu grace period.
> > +            // TODO: We are luckily since `kvfree_call_rcu()` works on both kmalloc and vmalloc,
> > +            // maybe a new `Allocator` method is needed.
> > +            unsafe { bindings::kvfree_call_rcu(rcu_head, self.0.as_ptr().cast()) };
> 
> [Severity: High]
> Since `RcuBox` is generic over any custom `A: Allocator`, wouldn't calling
> `kvfree_call_rcu()` here break for allocators other than kmalloc or vmalloc?
> 
> Does this need to always route through `A::free()` via `drop_rcu_box`, or
> should `A` be explicitly bounded to an allocator trait that supports
> `kvfree_rcu`?
> 

There is a "TODO" here to describe why currently kvfree_call_rcu() is
fine, is this a real issue in the current code base?

Regards,
Boqun

> > +        }
> > +    }
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260605133541.22569-1-boqun@kernel.org?part=1
