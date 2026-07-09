Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A7EC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB08410E688;
	Thu,  9 Jul 2026 10:15:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bjwlpW9U";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DCDA10E688
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 10:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783592112;
 bh=wJghdPSi0y7+VDVO1LX5L69ybJKbGp83hMKKo/g6zrM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bjwlpW9UJ8UQOyo6PN9aJ8FgfnPx0lfIzb4W1Qiyru5O/WK9wIZSjBgS8FMIBwbEq
 cBwe4LBHyonaaD/TVPrBSW+E0+/0WZBUx4SdkBczDQUhwm2n3wwQGOunRM95bAIo29
 tCcBU8yd+bI48pEQwn7TPDXNwjunX4Ma/n7Z9jOafpoRIoG4Rg31ovpvsaXcHeRVcn
 R2MTnEEkdJoRSjxgmOCm6KsaViX1d2+5A8HfxLFqNktl2HrSYfJD/VKLR92gtyF1ft
 m4rvSWfAbTCWagQbh324RUCUPsnRddklYAo5pUwxa4aULonC69KU1Ih9cOq0twiNSV
 ZXVZ+S6A4APFA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5367117E0CDE;
 Thu, 09 Jul 2026 12:15:12 +0200 (CEST)
Date: Thu, 9 Jul 2026 12:15:07 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Steven Price <steven.price@arm.com>, dri-devel@lists.freedesktop.org,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com
Subject: Re: [RFC 1/8] drm/panthor: Remove redundant drm_sched_job_cleanup()
 from the .free_job callback
Message-ID: <20260709121507.2b2e817c@fedora-2.home>
In-Reply-To: <42890d89-367e-44f8-90e8-07f2580afca7@igalia.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <20260702143745.79293-2-tvrtko.ursulin@igalia.com>
 <cd319413-edd9-4bd6-b393-91f48fa7b795@arm.com>
 <42890d89-367e-44f8-90e8-07f2580afca7@igalia.com>
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

On Thu, 9 Jul 2026 11:05:52 +0100
Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:

> On 03/07/2026 16:00, Steven Price wrote:
> > On 02/07/2026 15:37, Tvrtko Ursulin wrote:  
> >> After calling drm_sched_job_cleanup(), the free job callback releases it's  
> > 
> > NIT: s/it's/its/
> >   
> >> reference to the job, where the act of dropping the last reference will
> >> also call the drm_sched_job_cleanup() helper.
> >>
> >> We can therefore remove the redundant call from the .free_job callback.
> >>
> >> But we have to leave the "if (job->base.s_fence)" guard in job_release(),
> >> since that one not only handles the above described double cleanup, but
> >> also deals with all job cleanup paths which happen before the point the
> >> job was armed.
> >>
> >> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> >> Cc: Liviu Dudau <liviu.dudau@arm.com>
> >> Cc: Steven Price <steven.price@arm.com>  
> > 
> > I agree this looks redundant.
> > 
> > Reviewed-by: Steven Price <steven.price@arm.com>  
> 
> Thank you!
> 
> Can this patch be picked up and merged on it's own and who can do it? 
> Not sure if there is any CI for panthor it maybe needs to pass first.

Nope, we don't. Feel free to queue this to drm-misc-next (with the
type fixe), otherwise Steve or I will queue it at some point.
