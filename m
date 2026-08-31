Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2BEC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD40210E3CB;
	Mon, 31 Aug 2026 11:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PQBkfrBY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7EDF10E3CB
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 11:45:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFDAF40BE1;
 Mon, 31 Aug 2026 11:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D0F1F00A3F;
 Mon, 31 Aug 2026 11:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788176742;
 bh=bC0M3u1C79l9mZxmj5fz1xjpZ2H2du7CqTBNxjYUL6E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PQBkfrBYrPDy7GY4tMT2xbCMVrCB1YoW5+2t7lkCi+/PXWgBjBK8dFy2a+Bl8heRL
 V3n48mZs5qlAlSs6IE4bAbYHKzwNa3blY1OW+muOXgy41yX504QKdN5Xq2chOn0m59
 Q9lPufYgEiULi+Qgpu5BKc8LNnlTQMcErbdKWdaDjRr0HQJfpbxccxTlMbUiyxLjRv
 WeYxNgQ+58kQkUM8rvaOlDsrhpjVj7RL3fN92lrUxuI8K4VWGKNyWf/kDaE6Xry3S4
 fXxRciCiSAj8NVxGBNZ+wfBunJtWbOg4wxt2MWrgNFUmNEUjVtoQc9bIwCrCWXrteX
 EbZ/D9y/zgqVA==
Date: Mon, 31 Aug 2026 14:45:40 +0300
From: Konstantin Sinyuk <ksinyuk@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
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
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/12] drm/fabric: vendor-neutral topology
 infrastructure for scale-up accelerator interconnects
Message-ID: <fabric-leon-reply2.1788176465.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <20260826093222.GC42790@unreal>
 <fabric-leon-reply.1787844400.ksinyuk@kernel.org>
 <20260827170911.GG42790@unreal>
In-Reply-To: <20260827170911.GG42790@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
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

On Thu, Aug 27, 2026 at 08:09:11PM +0300, Leon Romanovsky wrote:
> The wording alone is not sufficient. Your proposal should be backed by
> real devices representing different architectures from different
> vendors.

Agreed that discussion and simulation are not substitutes for hardware
implementations. This RFC is meant to shape the model early, while it
can still change, and to ask whether the objects hold for other scale-up
protocols, including NVLink and SUE/ESUN, not only xGMI and UALink. It
is not a merge proposal.

> The amdgpu xGMI implementation already exposes the required UAPI through
> sysfs and would need very strong incentives to abandon its "legacy"
> users in favor of this new netlink interface.

Nothing has to be abandoned. An amdgpu provider could publish topology
through the common in-kernel API while the existing xGMI sysfs stays as
it is.

I agree that xGMI alone gives AMD little incentive to add another
interface. The stronger motivation is UALink: it is a new cross-vendor
ecosystem, and accelerator and switch components may be owned by
different vendors and subsystems. Common userspace should not have to
assemble one fabric from incompatible vendor interfaces.

The cost of waiting until every vendor has a shipped interface is that
the common model then has to preserve all of them. That is the position
xGMI is already in today.

> The last new subsystem I am aware of was introduced with implementations
> from three different vendors to demonstrate its robustness. You should
> probably aim for a similar level of coverage here.

That is a reasonable robustness target, and I cannot claim it today.
The next revision remains a design RFC. The object model and subsystem
boundary still need review against different hardware architectures.

The LPC BoF is the next step:

  https://lpc.events/event/20/contributions/2412/

Thanks,
Konstantin
