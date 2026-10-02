Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08763CA5FE0
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5752110E690;
	Fri,  2 Oct 2026 19:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n3NL5xFw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BBE710E690
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 19:30:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF5C3447F9;
 Fri,  2 Oct 2026 19:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C10E1F000FF;
 Fri,  2 Oct 2026 19:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790969451;
 bh=J8mM4qitVdSD3LXu+ZiZEVubQ7QVZWIFirCQYWVxbPA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=n3NL5xFw6Kd9dUEDQ05hV6EoETKNeOpu9ZGXDms3BqHupfDSlAiFNpjf9rMh/8E+6
 cKzZf8ajdWYRh+4fx4BRzniTDO3MA7iWenW25BIIW94wQQ0YcKIHY3ntle17xM/+Fc
 nAtQhVwhap3sAdwiT486CsZS3OwC81dxA4BhNbeHgcnJ6ckaHFAu9828hBZXSJCx/r
 SNqVki6VsPE3t+11cTqO6De4WNSA90Fcm3GekAF/I+dvoug8eBCxxqAKneQSO5bfH3
 h7uSwZS9T3B8sqn71ttTS8D5mHFuVqa8V4Wtki9vCFarRrG/Y7s2jD07qcOP/mUBnK
 IjNTuXG0VmMvA==
Date: Fri, 02 Oct 2026 09:30:50 -1000
Message-ID: <24bf5dfc5777aaa0b18a6778437eca21@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Breno Leitao <leitao@debian.org>
Subject: Re: [RFC v6 1/3] workqueue: Simplify unbound sysfs attribute
 registration
In-Reply-To: <20261001160711.59888-2-tvrtko.ursulin@igalia.com>
References: <20261001160711.59888-1-tvrtko.ursulin@igalia.com>
 <20261001160711.59888-2-tvrtko.ursulin@igalia.com>
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

Hello,

The following is a Claude-generated review.

On Thu, Oct 01, 2026 at 05:07:09PM +0100, Tvrtko Ursulin wrote:
> +static umode_t wq_sysfs_unbound_group_visible(struct kobject *kobj,
> +					      struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct workqueue_struct *wq = dev_to_wq(dev);
> +
> +	if (!(wq->flags & WQ_UNBOUND))
> +		return SYSFS_GROUP_INVISIBLE;

SYSFS_GROUP_INVISIBLE is documented for named groups only. For an unnamed
group, fs/sysfs/group.c masks the bit off and the leftover 0 is what hides
the attribute. Can you return 0 here like wq_sysfs_is_visible() does?

Thanks.

--
tejun
