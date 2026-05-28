Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3FDCD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 21:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F73D10F651;
	Thu, 28 May 2026 21:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="GHGSg6M1";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B251010F651;
 Thu, 28 May 2026 21:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780005091; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KzIBPTmthwhAeHA0/ZQk5QR5z1hu9YasP3QgYIjqwflT3fbbGBP64sWbFHbT4RKPKhyH5k3LH5+IEwSvQ/UCgNG4+ah9yO6EnM6Pc+53juka8aDEu1n4MfVEoKjkkkluCwHyvt54IZJJoieuJ1VcR5qX3CFBFyik3xQ+yrL1tkI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780005091;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=d036PFKvkwoW+sbQQSIuW3LFGAUR93jduDjOep/NYl0=; 
 b=iQ3TTYhwWw5oUHxY43Q5ZlRQGIKQaDRGJzxL4XozW5jM0EoTk9SLXMbOFKcwjgJSUjjxZhOugU5FY/RfwULVjziYno+nXfgwU8Gqmwp5zXDA6Zv8vZ68S47K0nl7XTqTY7NwcAhRkFeXozevVfsH7TN8e4Dgr875MQJTIQNPwDY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780005091; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=d036PFKvkwoW+sbQQSIuW3LFGAUR93jduDjOep/NYl0=;
 b=GHGSg6M1wuqoB10xJ9UCivvH9fJXswPSny++QiADxHs2d/bUis9JOX3cv1QmeBqA
 BmusU8Jki8bijBz7oQrmZUc9nhqfkVi0DiuFz2J8W2ZrQlB07U2sI7QBro7U0v3mlsP
 /DQo4d7i3nHUoVH/YrPx+DCLnPwoEUndVxuEzOro=
Received: by mx.zohomail.com with SMTPS id 1780005089800437.67750831704655;
 Thu, 28 May 2026 14:51:29 -0700 (PDT)
Date: Thu, 28 May 2026 14:51:29 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Eliot Courtney <ecourtney@nvidia.com>, aliceryhl@google.com,
 daniel.almeida@collabora.com, boris.brezillon@collabora.com,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] gpu: drm: tyr: use IoMem directly instead of Devres
Message-ID: <ahi44Zwu29bgxoCc@um790>
References: <20260525230152.277820-1-dakr@kernel.org>
 <20260525230152.277820-3-dakr@kernel.org>
 <DIS9H75POYGW.EBC1MLW466RG@nvidia.com> <ahd4UoKVT4cM-pgA@um790>
 <DITUMY6K2IQX.17R1VUFJGBDAW@kernel.org>
 <DIUBT4GXKI2Q.3RZEYJVWXZF18@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIUBT4GXKI2Q.3RZEYJVWXZF18@garyguo.net>
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

On Thu, May 28, 2026 at 01:58:35PM +0100, Gary Guo wrote:
> On Thu May 28, 2026 at 12:31 AM BST, Danilo Krummrich wrote:
> > On Thu May 28, 2026 at 1:03 AM CEST, Deborah Brouwer wrote:
> >> On Tue, May 26, 2026 at 11:43:38AM +0900, Eliot Courtney wrote:
> >>> On Tue May 26, 2026 at 8:01 AM JST, Danilo Krummrich wrote:
> >>> > @@ -40,9 +39,7 @@
> >>> >  pub(crate) struct GpuInfo(pub(crate) uapi::drm_panthor_gpu_info);
> >>> >  
> >>> >  impl GpuInfo {
> >>> > -    pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<Self> {
> >>> > -        let io = (*iomem).access(dev)?;
> >>> > -
> >>> > +    pub(crate) fn new(io: &IoMem<'_>) -> Result<Self> {
> >>> 
> >>> Perhaps a future patch can remove this now unnecessary looking Result in
> >>> the return type.
> >>
> >> Oh that's right now that we don't have: let io = (*iomem).access(dev)?
> >> we don't need the Result anymore.
> >>
> >> Danilo, I can add this fix to our fw-boot series which I'm preparing to sit
> >> on top of these changes.
> >
> > I can send a v2, fix it up on apply when I get an ACK, have Alice fix it up on
> > apply, or have it done in a follow-up as you offer -- just let me know. :)
> >
> 
> I think it makes sense to have a v2 with this, as getting rid of impossible
> failure paths is the reason we go for lifetime in the first place, so this is a
> good demonstration of that benefit.

yeah v2 is probably the cleanest/easiest way to fix.

And while here it would be nice to keep the subject prefix consistent,
we've been using "drm/tyr:"

> 
> Best,
> Gary
