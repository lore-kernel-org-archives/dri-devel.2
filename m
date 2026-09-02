Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D887C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18FE910F02C;
	Wed,  2 Sep 2026 07:10:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fgf4am5j";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8915810F02C
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 07:10:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B5EC40BAC;
 Wed,  2 Sep 2026 07:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F0B1F000E9;
 Wed,  2 Sep 2026 07:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788333051;
 bh=mkNkOka81TvpWCQXQjDjyJBfSTFlkGAdLKmI+ByzmA8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Fgf4am5jJyE90OYVghPGqx5FnXVzC3IblXws4qY6hJm0WyQefrF4575MQL3G/l4MY
 N/JKZ5NxbpGHS4wd16VXnd05KQVIMyQFlwul74Aj5sQaVryHgIG+xOz2TAYZ2EXGF3
 i/IG9NXREMeP94enEFmcBKJ1S6aBlBhUnl7yQWrX6f74T12zNIIWNRg+O6K4+MDsPn
 HzaA6XUF/1pviVzCLux4iZxYmsMY0090vUbYnTF2TA0NrtFJQ2VviYRpuIWwr1KhKE
 up/Fb5Dd/FQ+4qvJbBQeLjkFmrtRVn0hgyMxtHEA8n4zboXeFMIXeily+BOf+XUXvf
 5zBo04c2/Buug==
Date: Wed, 2 Sep 2026 10:10:46 +0300
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
Message-ID: <20260902071046.GO24140@unreal>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <20260826093222.GC42790@unreal>
 <fabric-leon-reply.1787844400.ksinyuk@kernel.org>
 <20260827170911.GG42790@unreal> <apGzqP6cEZ1miNmR@intel.com>
 <20260901110120.GJ24140@unreal> <apbuUsS_3RVbB5vh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apbuUsS_3RVbB5vh@intel.com>
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

On Tue, Sep 01, 2026 at 11:25:06AM -0400, Rodrigo Vivi wrote:
> On Tue, Sep 01, 2026 at 02:01:20PM +0300, Leon Romanovsky wrote:
> > On Fri, Aug 28, 2026 at 12:13:28PM -0400, Rodrigo Vivi wrote:
> > > On Thu, Aug 27, 2026 at 08:09:11PM +0300, Leon Romanovsky wrote:
> > > > On Wed, Aug 26, 2026 at 06:38:58PM +0300, Konstantin Sinyuk wrote:
> > > > > On Wed, Aug 26, 2026 at 12:32:22PM +0300, Leon Romanovsky wrote:
> > 
> > <...>
> > 
> > > > The wording alone is not sufficient. Your proposal should be backed by
> > > > real devices representing different architectures from different
> > > > vendors.
> > > 
> > > Future Intel (and other vendors) hardware will include UALink.
> > 
> > I guess that, like most of us, you are not authorized to discuss or
> > comment on Intel's non-public roadmap. Can you point to any public
> > commitment from Intel to implement UALink in its devices?
> 
> That's the only public support commitment you will find for now:
> 
> https://ualinkconsortium.org/blog/intel-supports-ualink-for-scale-up-networking-829/
> 
> as an active member of the consortium
> https://ualinkconsortium.org/members/

I saw that PR article, but I couldn't find anything on the Internet stating
that "future Intel (or other vendors') hardware will include UALink."

So, for now, this RFC can be considered an academic project.

Thanks
