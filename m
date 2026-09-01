Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892E6C624CF
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C16DC10E23B;
	Tue,  1 Sep 2026 11:01:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ObR1Hbvx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA93110E23B
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 11:01:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F0CB42A61;
 Tue,  1 Sep 2026 11:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9801F000E9;
 Tue,  1 Sep 2026 11:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788260484;
 bh=aHxVERBew5CgbQQj/MuD9uQI515uVkBhK5soxUtArlo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ObR1Hbvx8mIlygu/0Q7wQ04cJeYLdBrCbKqhDMcBy15MfEa0QWJ2LL2T+loGt/Qiy
 Erp5toxkW16/RHLQfLOnF8d7SBfPNX8x/b8ZGpzKQf9EUUi2POwKavf/485oXpqyge
 bX4S1WxYPzWsSCuptkwjYSKznjido5rft1Kf8VHaYdz/gmnvGqc6XrM4YdIUepo6Q9
 wxT59x27V95hx3ZnqXhUaXXYOEqRR6GcJYxOjlNoShRw2HBX+vsLW6Fz4PzS97Rc1r
 uUiLKfhTB8B6Ri+fsU4TE6+Lrc/MrgBdtbGuHZ3H7cL0wvSkDW7/pbkRy18dBMYsqd
 +mVzweO6p72Aw==
Date: Tue, 1 Sep 2026 14:01:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Konstantin Sinyuk <ksinyuk@kernel.org>, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Francois Dugast <francois.dugast@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ilia Levi <ilia.levi@intel.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/12] drm/fabric: vendor-neutral topology
 infrastructure for scale-up accelerator interconnects
Message-ID: <20260901110120.GJ24140@unreal>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <20260826093222.GC42790@unreal>
 <fabric-leon-reply.1787844400.ksinyuk@kernel.org>
 <20260827170911.GG42790@unreal> <apGzqP6cEZ1miNmR@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apGzqP6cEZ1miNmR@intel.com>
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

On Fri, Aug 28, 2026 at 12:13:28PM -0400, Rodrigo Vivi wrote:
> On Thu, Aug 27, 2026 at 08:09:11PM +0300, Leon Romanovsky wrote:
> > On Wed, Aug 26, 2026 at 06:38:58PM +0300, Konstantin Sinyuk wrote:
> > > On Wed, Aug 26, 2026 at 12:32:22PM +0300, Leon Romanovsky wrote:

<...>

> > The wording alone is not sufficient. Your proposal should be backed by
> > real devices representing different architectures from different
> > vendors.
> 
> Future Intel (and other vendors) hardware will include UALink.

I guess that, like most of us, you are not authorized to discuss or
comment on Intel's non-public roadmap. Can you point to any public
commitment from Intel to implement UALink in its devices?

I couldn't find one.

<...>

> > The current proposal is based on a single implementation, which is
> > unlikely to be ported to this new framework in the foreseeable future.
> > The amdgpu xGMI implementation already exposes the required UAPI through
> > sysfs and would need very strong incentives to abandon its "legacy"
> > users in favor of this new netlink interface.
> > 
> > The last new subsystem I am aware of was introduced with implementations
> > from three different vendors to demonstrate its robustness. You should
> > probably aim for a similar level of coverage here.
> 
> If we wait 3 different devices to show-up before we can start discussing
> a common API, then it might be way too late.
> 
> But of course, we can definitely move this netlink as is to inside
> drivers/gpu/drm/xe and call it xe_fabric and if someone else is interested
> in join effort we move that outside.

We are not talking about "waiting for", but about "being backed by".
The general kernel rule is that the second implementation is responsible
for consolidating the code. XE appears to be that second implementation.

Thanks


> 
> Thanks,
> Rodrigo.
> 
> > 
> > Thanks
> > 
> > > 
> > > Thanks,
> > >  Konstantin.
