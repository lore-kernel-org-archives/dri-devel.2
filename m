Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E203CDB466
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 08:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15FF10E23A;
	Sun, 21 Jun 2026 08:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WTA+D3JL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C376610E23A
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
 In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VbCbnHnZXA91Ce4PwdxC0wMTzxTLqUjbr72iwzXBJIg=; b=WTA+D3JLMQse0u30/v59IifqHa
 rvS0eXrKhEUCVhPYzTWN9GarN4MoHyZgYvZrarV0g8TQD9OVFNZoKrnf11vAFY+heiR01e8bbBiFt
 muQqdKfndDmV/Xx5f9lZS+adViF3o2cthcDfn5gOY3FHFBEbgs6bz2cRRldXMaA/UvH8HRXBtsjIL
 1j1hu5d0lTk0TT1x9FjdU07oR41leElZF1WFD+/Mpbr9BFW3pJQjrK8Jj3vkCA+rjIzHVfpF1viOf
 KZBIPEOyY9ZVA0G2TOdy54eW6q99gTuI4JoHmyJ282tgyrn/dKBBEFT0G6GOyOfialyK6b6CRRfbH
 DgRwuW5A==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wbDwx-003JgO-SU; Sun, 21 Jun 2026 10:54:43 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
 by mail.igalia.com with esmtp (Exim)
 id 1wbDwu-00DDcn-OH; Sun, 21 Jun 2026 10:54:43 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
 by webmail.service.igalia.com with esmtp (Exim 4.98.2)
 (envelope-from <anholt@igalia.com>) id 1wbDwu-0000000BBdH-2FuU;
 Sun, 21 Jun 2026 10:54:40 +0200
MIME-Version: 1.0
Date: Sun, 21 Jun 2026 10:54:40 +0200
From: Emma Anholt <anholt@igalia.com>
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: Iago Toral <itoral@igalia.com>, Melissa Wen <mwen@igalia.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/3] drm/v3d: Associate BOs with every job that accesses
 them
In-Reply-To: <b1d177a4-02eb-4925-969f-952860045e56@igalia.com>
References: <20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com>
 <20260610-v3d-cpu-job-fixes-v1-1-0d9c88989edc@igalia.com>
 <4a83fb4434459846c2e2936e4bbd297b75d70af1.camel@igalia.com>
 <b61d3055e59f0c83ac5b72ddc0befd04@igalia.com>
 <b1d177a4-02eb-4925-969f-952860045e56@igalia.com>
Message-ID: <200348797d16e20481db216f8125c2fb@igalia.com>
X-Sender: anholt@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 2026-06-13 16:22, Maíra Canal wrote:
> Hi Emma,
> 
> On 12/06/26 14:44, Emma Anholt wrote:
>> On 2026-06-10 23:17, Iago Toral wrote:
>>> Hi Maíra,
>>>
>>> I have a couple of thoughts here:
>>>
>>> 1. The original code seems to very specifica about targeting this only
>>> for the last job, which makes it look like a very intentional decision,
>>> so I wonder if there is something we are missing here. I am adding Emma
>>> to the CC in case she has any thoughts about it.
>>>
>>> 2. I am not aware of any issues despite not having implicit sync for
>>> all the jobs in the chanin. Like you mention, this is because user-
>>> space is already trying to handle job depedencies, so I wonder if we
>>> should instead work on the opposite direction and try to drop implicit
>>> sync in the kernel entirely. Would that make sense? What are other
>>> drivers doing in this regard?
>> 
>> Yeah, you should be working toward dropping implicit sync entirely.
>> tu's VM_BIND is really nice and where you want to be eventually, but
>> even if not, then you at least want something like
>> MSM_SUBMIT_NO_IMPLICIT.
>> 
> 
> I believe the main issue we would have to implement something like
> VM_BIND is the fact that V3D only has one global page table (that we
> could switch on runtime, but it would come with the cost that all the HW
> queues would only be able to operate on BOs from one client).
> 
> NO_IMPLICIT would be a more reasonable option.

I had forgotten how bad v3d's mmu is, with the contiguous mem
requirement.  I don't think VM_BIND is going to be reasonable -- we
can't guarantee new page tables for other clients, so switching isn't
reasonable.

HW queues only being able to operate on BOs the client has imported is
the right behavior, though!  It's not a requirement from DRM, but it's a
very strong expectation from the software using it.  V3D should really
be using the GMP to mask the clients from each other.
> 
>> I probably just didn't think about this implicit sync case in the
>> initial implementation, because a bin job dependency on results from
>> another context is just not a thing that's going to happen in practice.
>> The implicit sync was mostly about render targets / texturing to be
>> ordered correctly with X11, and about lifetime management of the BO
>> (which only needed the last use).
>> 
> 
> But does it make sense to attach the implicit dependencies to the
> CACHE_CLEAN job (last job) and not to the RENDER job or the CSD job?
> 

You need to make sure that the BO list also gets added to at least the
first job (assuming they're in a dependency chain), because it should
correctly wait to implicit sync against queued writes to those BOs from
other clients.  And, if you ever do shrinker, then each job would need
to know its BOs.
