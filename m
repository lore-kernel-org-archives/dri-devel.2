Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE891C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C08110F3B2;
	Thu,  9 Jul 2026 06:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="WEmaChua";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36AA110F3B2
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783579934;
 bh=HRZoaw1+NvQ7wGW2Hw834tArYyN0nAPw9Nql/EjCXzc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=WEmaChuaKyx3875SvspDLRecjjfFr2N+Q4e8CgP9ACV89KSCn8D6qYX+q7aHBGVER
 sHbG/vbyRud+2FCDOlwDGIyU52/1ioP1P/R1DSXWFuuidEJXH3XEoqqd4W3AgYoCwh
 8+rsOrc48NoGmJ26VKXGquisYS1Gy9KM6m0eCal1DVtZQW3RmnsaDraVCXM73rV2pr
 TPFi+GauvLaivmlSJXIFSqPVkfUOVHwUq1t8yvZ6Z1cLdo6AcPp5RZw5fZsyMf0FAX
 F1MhvkCXXLqZj978hykp3xfa6jal0T4yN5mM43d170VgF/bPfzcKc2Hjwq4ajW6bLM
 xSOX0MSEOTPng==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id ACD0F17E0564;
 Thu, 09 Jul 2026 08:52:13 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:52:07 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 <dri-devel@lists.freedesktop.org>, Steven Price <steven.price@arm.com>,
 "Liviu Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 <kernel-dev@igalia.com>
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
Message-ID: <20260709085207.6741c71c@fedora-2.home>
In-Reply-To: <ak63Qzqxn1k9ezEd@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <akd/ae5VGQrsWqsf@gsse-cloud1.jf.intel.com>
 <5963b079-cb44-4cd4-be56-f47bf3f15e0e@igalia.com>
 <akwyNSXO+QspyoBx@gsse-cloud1.jf.intel.com>
 <akym7rllMDFFcz8q@gsse-cloud1.jf.intel.com>
 <992e86a0-990c-46ab-8816-cf3c030d274a@igalia.com>
 <ak63Qzqxn1k9ezEd@gsse-cloud1.jf.intel.com>
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

On Wed, 8 Jul 2026 13:46:59 -0700
Matthew Brost <matthew.brost@intel.com> wrote:

> > 
> > Why I was unsure about deciding at drm_sched_init time is a) runtime
> > priority changes, but perhaps that is not such a big deal and we could live  
> 
> Xe only allow static priorities on queues, unsure about other drivers.

There are plans to add dynamic GPU context prio adjustment to panthor,
so, even if it's not needed at the moment, I'd rather have the option to
do it further down the line, if it's not too much to ask.
