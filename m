Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4219CC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F64510E2CB;
	Mon, 31 Aug 2026 11:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cclrgie1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1998610E2CB
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 11:45:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A6C7C41665;
 Mon, 31 Aug 2026 11:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182301F000E9;
 Mon, 31 Aug 2026 11:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788176718;
 bh=MGM5UjBFTBl6z/Tmn5z2Mz6KhaOwI7O+2FjYZ4TU9vE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cclrgie1c/zQ/qUNz+5jQ5Fyp7rGqXNHQK5CMuKXGOOIxvQ0yx4Ajp0BYXaDLfUy8
 8x6RAvO/F9bNR+6EU1FYnrO9CKRvQu/drwaKCFBDDHoBLPmGyj7hVpcFrf0rKqa4o3
 l+kZfTXifyTJv+44ACiLmE5CQ4H/CUaTdUNymPY4OrpI8dV6uFFhAHCzu1/UQJ1Xne
 6ud2nJGT6O7MZn7un0z5IRBF9IlmTEzQ8rZukQ7YJwCKedf0JMTRb57L4mwHUJMeAe
 7hVzmQzxUPW53Ez/2VeMEVMOa6wC2bIQRLEyLdlw2T084Y/4Prh5IySZ51GJT7GjOL
 iddabrOKiaOlg==
Date: Mon, 31 Aug 2026 14:45:15 +0300
From: Konstantin Sinyuk <ksinyuk@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
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
 linux-kernel@vger.kernel.org, jhs@mojatatu.com, jgg@nvidia.com
Subject: Re: [RFC PATCH 0/12] drm/fabric: vendor-neutral topology
 infrastructure for scale-up accelerator interconnects
Message-ID: <fabric-jiri-reply.1788176464.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <apAsfOowcG0cTvT8@FV6GYCPJ69>
In-Reply-To: <apAsfOowcG0cTvT8@FV6GYCPJ69>
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

On Thu, Aug 27, 2026 at 02:35:16PM +0200, Jiri Pirko wrote:
> Using generic netlink instead of sysfs for this makes a lot of sense,
> but it may be a bit odd to use it outside the networking area.
> I've been struggling with the same in another non-networking use-case
> as well.

Agreed, and the series shows the friction. The namespace handling is
nominal, and CAP_NET_ADMIN as the mutation gate is another borrowed
part of the model. I went into that in more detail in the reply to
Jason.

> - One character device per registered instance, not one global family.
>   Access control is the file: udev rules, ACLs, an fd passed into
>   a container.

The fd-based access and event model addresses real problems with one
global family and one multicast group.

The main question is what the CTLV instance would represent. A fabric
can span multiple devices and has its own lifetime. An endpoint can also
be detached from a fabric with fabric-id 0 and continue to exist. A
character device per accelerator would not provide the same global view
as the current family.

Can a CTLV instance represent a multi-device fabric or the global
fabric registry rather than one physical device?

> Would this make sense to use for you?

In principle, yes. I cannot base this series on an out-of-tree pre-RFC,
but the fabric, endpoint, port and peer model is separate from the
current serialization.

Changing transports would be more than regeneration, so I will read the
draft before saying more.

Thanks,
Konstantin
