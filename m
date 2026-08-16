Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59D4C5DF6D
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F7610E33D;
	Sun, 16 Aug 2026 19:11:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lk58hIJQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9716710E33D;
 Sun, 16 Aug 2026 19:11:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE6AF601DE;
 Sun, 16 Aug 2026 19:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9AE1F000E9;
 Sun, 16 Aug 2026 19:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786907459;
 bh=65xm/BJ2ILV0+VnpFw5xUmzgOfgFFFEa6yjAp0pX8N0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lk58hIJQhP2tQmKfHOYxDKjHbnzQCpKafIxj92z2lAMUf0yVPjuSdF1GNIZY0YCWr
 VNLXhZ0E20ngfkXVAG7HLy9KdnzRdkjiWhNJSdgnHou/PcrKv3g/8MUfBUzXFQcgVz
 oK+/xGIfa9TPn5cBC+N1hfZwlba1YqcGMtcLzfLxzHZq1pXj45OHUDk5O5KSCSriLb
 UXjsWPdH9jCPZoLVtHznBaBBkzU9JwMN/UIU1XZM6Y4rQmSegEd6N7IS+Kq2Xxfv51
 bonXk2oiqHc+O59K8bonyUk3zxTo1JPSddtknK60zuyPKNqacYEHxC7hS6CVqYbiDQ
 15zDN/ITjZExQ==
Date: Sun, 16 Aug 2026 09:10:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: maarten.lankhorst@linux.intel.com, intel-xe@lists.freedesktop.org,
 cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 pallavi.mishra@intel.com
Subject: Re: [RFC] dmisc cgroups controller
Message-ID: <aoILQuck_EuxQgVh@slm.duckdns.org>
References: <894f9d44eae62aee5762495b4f90f9bdd2b5585d.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <894f9d44eae62aee5762495b4f90f9bdd2b5585d.camel@linux.intel.com>
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

On Fri, Aug 14, 2026 at 11:32:54AM +0200, Thomas Hellström wrote:
> Hi!
> 
> We (drm/xe GPU driver) have a use-case where we have a very limited
> number of a particular device resource (CLOS slots) that we potentially
> want to expose to unprivlieged processes for reservation / allocation.
> We want to be able to restrict per cgroups the number of CLOS slots
> that are available for reservation / allocation.
> 
> This is not a good fit for the misc controller since these resource
> types may be added and removed similar to dmem regions. Neither is it a
> good fit for the dmem controller.
> 
> Would a dmisc controller be suitable here? It would be similar to the
> misc countroller but with dynamic addition and removal of resource
> types similar to the dmem controller.
> 
> Any input greatly appreciated.

Would extending the existing misc controller be an option?

Thanks.

-- 
tejun
