Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D739BC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 309B310E031;
	Fri, 10 Jul 2026 16:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DsRnfXud";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723D310E031
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:11:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A03B6434CB;
 Fri, 10 Jul 2026 16:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E3D1F000E9;
 Fri, 10 Jul 2026 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783699863;
 bh=lA30wsLgedj6w77Bx+yxBoIN8xuCtAuzQG9CJlT2U70=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DsRnfXudcKFG4tE3uLg5wp1FQDvtvaP3zis21eWpWJzIuBaUs7jUvRkYx9yaT5Nna
 Uke3TnMF3NN03Cv+ZeGpduZL8MSUkx+2KHq7Eao/ytUWaT9krXEoRRphWk5hwsn5mS
 +oOnjNZHoG6Sw9sCadD2KogeNj1XuoZFS0ZzWZvIZxoSRRpvLBBnvQlffy5clryzmG
 +JedC5YhTSJb3G2zpE4wLJZ1JvqbOmNHDFzVFAuE9LzV8lHXIuLi31mnvf2VMZdEM8
 m5PEKw8EoFLP0Y2xha99VDIzTd5ef8Zf9ZKcrs55tMyBIhxf9M5/0JU541HdYeARb2
 fU+d+27YLEATA==
Date: Fri, 10 Jul 2026 06:11:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: phasta@kernel.org, dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, kernel-dev@igalia.com
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
Message-ID: <alEZlhfTZ1tD3hMo@slm.duckdns.org>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <4eb23476ff56bee108578adfe131be38e8fc1476.camel@mailbox.org>
 <b76ea01c-ead3-4eaf-86a7-5bf91bfdb9cb@igalia.com>
 <akwD28ihbzn1FB-P@slm.duckdns.org>
 <fe9c5564-9a56-429d-a991-9b77f8a97d5b@igalia.com>
 <19f0c3fe-7395-492f-b016-7a7a507da4f6@igalia.com>
 <250bfc53-e91b-4c48-9401-bbe636d3400b@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <250bfc53-e91b-4c48-9401-bbe636d3400b@igalia.com>
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

On Fri, Jul 10, 2026 at 01:29:19PM +0100, Tvrtko Ursulin wrote:
> So the question is whether something like this is acceptable to workqueue
> core? If so, I can send it as a proper RFC and go from there.

Yes, that looks like enough data. Let's add RT support.

Thanks.

-- 
tejun
