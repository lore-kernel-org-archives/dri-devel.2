Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24544CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 883271127BD;
	Fri,  5 Jun 2026 15:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sarze8Ca";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D167E1127BD
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 15:33:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B158442AE1
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 15:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652C71F00898;
 Fri,  5 Jun 2026 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780673608;
 bh=Mbdmq4Leb+ZwNWt2t0EiTXdInl4X5ELk6gS+BDi40i8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Sarze8CaQXIeUh0LxG+LNjaZOAkFNtKMtCGAUXKYWRLQog2MHPBW3mcMuD6wzHjAx
 GKBmtxTTlomZ8JP74z6t+PolFKlpVyxSz2w6ELKxn98iYspxRD409Q55yJGD+hQdqM
 SL38P2cYSM4uaidBYzOoWY5kwpCEmMTpI0etpt+4gCIB+huwE6aWdBkOwYpYDJ61AS
 km+JqK0FApRGa56+1n9iAlrNmWw4FUk/FA/4T4wW8lf545QIz1Z2wlbAXLVNWSeDHO
 6V2qpjEnM1bIO0BGu7lFUPiYOruwGuTEvyNVOkiPI+sRYfsU7g2U82Uugc3kMFJT4z
 Heik13egUPbew==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfauth.phl.internal (Postfix) with ESMTP id 9922DF4006F;
 Fri,  5 Jun 2026 11:33:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 11:33:27 -0400
X-ME-Sender: <xms:R-wiag_yggALpQ_A3CEUcnpnnZIdWF84d_9K86fZpaYuXJ5uKCZbPQ>
 <xme:R-wiajqpPpSJ5tlj8qN9Ml9aiKLQ3vvbaolr3hjPTSsBEolHogb4WF1El6g0ZQPZG
 qhihsY6MxHIqJZmML48ZX0VGL_-trCIH-w16xo740KHBXlylgoiNRs>
X-ME-Received: <xmr:R-wialCgOMZeCMpQfi7Y3flj7cDHYl3v3ISRNyNmGGpyiUwVQK8G1Gwyy7s>
X-ME-Proxy-Cause: dmFkZTE5q7wspRguf/xfzLeVi3MIs2Gj4EfIHTkUc1lLAmhybEywZyWFPuPAchSTPk302j
 5qa7Ta75/FfpsA9ph/y6zR8dOlipoy2NsJryeCv/cMr+KRmiWbN5BTDzMY09PKgPw6Q8/S
 JOrNBMYEwaRZaQQpqEbygfvD4EKweAd1f/LEWcRkUNU2kx6mYNxsjy1On2KzKqsLciVQGU
 BpN5qsnQnZ09Sg8h+Ite1nVQy3obAfWhBuTG1G+oW38s2TVFq31W9GKGBj7Wah+ndwXE7Q
 QqsDM+FN9gCvCmAM8OijbjxYVINJ7C121xS0f50lXW82d75diCF5OdbN1WyWapAyFjgblL
 brlJoA0MM1gvpmGP3KPxPVpJRj6PLnoZyPyzS09TqOKWpLmgYjhUJfLcKomC+L3pAq+RV1
 gs2zfu2UwvnVrLTwJxCGGo0/z/Bp68InsXjq7MXUx9UdhxdvB6vWOXdAiezHG2Qr2HbUmk
 EWQyAwszmoBUUTayyLTi12jUIVK3wd5uasMtHv2bYL+7+No3nez6Gn6Wiy4NjrwxNQChvE
 2MkrosLDTsbe1qHXAb/YZN53ElTwbVaczqkhjEV/l1ZgJlS5J2e2D8qfRiAZplZ5FuS6oN
 XhzegrTUvLMLshR5WLVYINVI1VkPLf6EQzzQntPp4f4CfO1YtSoloe32I+9w
X-ME-Proxy: <xmx:R-wialwmsm7WJhW1PeysoUg4RdFP0hVThJgIJt_tawH-TdrEF48Igw>
 <xmx:R-wiai3ZZECYe4b5noWuc65Ow--1iNyXAM2bR6lVH0Oz6CyrG18qFw>
 <xmx:R-wialxUOtBmFVJwt6aLXC_hJ1Koj5VmMDdhfxVoGm0wX-zUpwPP1Q>
 <xmx:R-wiapFnJeVXfqsTY6IYikssaDySFaVP3k4arC0WUPNnMCTy635shQ>
 <xmx:R-wiaoa-8rVNKpz61--7XNOBC41A8UQwkolhdzlcePhlwhgALiG6a1U_>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 11:33:27 -0400 (EDT)
Date: Fri, 5 Jun 2026 08:33:26 -0700
From: Boqun Feng <boqun@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: sashiko-reviews@lists.linux.dev, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: rcu: add RcuBox type
Message-ID: <aiLsRpKWnRk5DQBd@tardis-2.local>
References: <20260605133541.22569-2-boqun@kernel.org>
 <20260605134935.B6C0E1F00893@smtp.kernel.org>
 <aiLgJkKzwEDGWNtY@tardis-2.local>
 <CAH5fLgimUgbK_dVwq7RQimOugqJka2bM_u2r5S=3aze_8uCnbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLgimUgbK_dVwq7RQimOugqJka2bM_u2r5S=3aze_8uCnbA@mail.gmail.com>
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

On Fri, Jun 05, 2026 at 04:54:55PM +0200, Alice Ryhl wrote:
[..]
> >
> > [Cc Alice]
> >
> > I fixed this locally by:
> >
> >     fn into_foreign(self) -> *mut c_void {
> >         let ptr = self.0.as_ptr().cast();
> >
> >         // FORGET: Leaking it as a pointer, the caller is responsible to free it or unleak it by
> >         // from_foreign().
> >         core::mem::forget(self);
> >
> >         ptr
> >     }
> 
> I prefer to avoid use core::mem::forget.
> 
>     ManuallyDrop(self).0.as_ptr().cast()
> 

Sounds good ;-)

Regards,
Boqun

> Alice
