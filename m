Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C85C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966B510E691;
	Thu,  9 Jul 2026 15:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JAzIDcth";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C22E10E691
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 15:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783610696;
 bh=YXXylOnILki7PqXjIitCY3O7UdJ30nKkpCj3vSTRIZw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JAzIDcth73AXGzKTQcQ4VGyQXi5EIt/w19pNtV+kfFLrQltpfjTMj+iq0z5Zh0uvw
 jSpDuwAGSLRFPGJbu6yiDgY/XDP9Vh21Tfa1FT+asjeklzX4DYMCILUEEwckOS1BrT
 GnMPWeODfOn1EAhSiS7jWjQV1U3vFaRHu7W4r6hfusUvd4dGcryP7C++5r02SJzQK2
 eSW2BtrA8ZI3h+RztN2tqvqwSQMLDb1YkoLGF8QKbzZOEyufITFzZr3WqedwxEFLpe
 Cb13i6fpwNfhuplbTt0JttGio+yF1iTc2ONOzrXBpVKMHY1A1LCySa5TAeUpoL//bb
 au+fLYho9Nwcg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4012517E0886;
 Thu, 09 Jul 2026 17:24:56 +0200 (CEST)
Date: Thu, 9 Jul 2026 17:24:52 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com
Subject: Re: [RFC 2/8] drm/panthor: Use separate workqueue for DRM scheduler
Message-ID: <20260709172452.486e845f@fedora-2.home>
In-Reply-To: <ffc05a67-66ff-4e0a-98f3-a9e4e87af6b0@igalia.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <20260702143745.79293-3-tvrtko.ursulin@igalia.com>
 <20260702173127.3103af30@fedora-2.home>
 <8aa9ffad-ece3-428b-b307-1d5f4136db73@igalia.com>
 <20260706161812.07ee7500@fedora-2.home>
 <bd262d12-65d0-4c59-a314-b42b540acd99@igalia.com>
 <20260709084520.16d32cb7@fedora-2.home>
 <8e079d0b-427f-42cd-8013-7b8af005cd6d@igalia.com>
 <20260709141957.7f7664d0@fedora-2.home>
 <ffc05a67-66ff-4e0a-98f3-a9e4e87af6b0@igalia.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 9 Jul 2026 15:33:01 +0100
Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:

> >> But in principle I am fine with going with N workers. It's just a matter
> >> of what is N derived from and how big it is. It could be even be passed
> >> to alloc_workqueue in the today's code base but I accept there is not
> >> much value to that since I don't think there are SoC's with a Mali GPU
> >> and server level number of CPU cores.  
> > 
> > I think we can start with one ordered-wq per prio level. So basically
> > what you intended to do in this patch, but instead of having a single
> > ordered-wq, we have four of them (one per prio). It doesn't address the
> > fact run_job() on non-resident groups might hit their ringbuf before
> > resident ones, but that's probably good enough as a first step, and as
> > you pointed out, the current locking forces this serialization with no
> > more guarantee regarding who's going to be served first anyway, so it
> > can't be worse than it already is.  
> 
> Lets for a moment assume the kthread_worker idea will not fly due to xe, 
> or any other reason really. Also since the option for RT workqueues is 
> unexpectedly on the table. In that case, and assuming RT workqueues will 
> happen, could a feasible plan for panthor be to create three workqueues:
> 
>   1. One unbound with max_active = 2 for low and medium group priority.
>   2. Another unbound + WQ_HIGHPRI, also with max_active = 2 for high.
>   3. And one unbound + WQ_REALTIME, again max_active = 2 for realtime.
> 
> For high and realtime max_active either 2 or 1 on dual core, if there 
> are such SoCs. Two threads ensure same priority clients are able to keep 
> the GPU fed.
> 
> One issue is that you mentioned you would like dynamic priority changes 
> and with this it may be tricky. But ignoring that for the moment, and 
> the discussion on how to handle other panthor workers which take part in 
> the execution flow post submit, this should pretty much address the 
> submit latency from userspace to ->run_job(). What do you think, is it 
> worth entertaining this alternative?

I think that would do, yes.
