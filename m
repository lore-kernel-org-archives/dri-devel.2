Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077AAC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48C1E10E30F;
	Wed, 16 Sep 2026 08:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="E/1lLIDz";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB5510E30F;
 Wed, 16 Sep 2026 08:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789547967;
 bh=YIBXtxjlvihuJge9Li/Y0AAox/N2DGq9Jq7aBDPnFRI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=E/1lLIDz9DlwpZnr5oiCzS7QwGu9aZFBKzgQjmgkvqbzB1+FVzZNN3ZjPOSRy00+8
 5q028oxdtb1/7o+/xN3T5TqGAQhZONRYoEUUH/eikzaTyWMU1KULBix0tIQxqtpz9/
 IfaCBHRAzF0fBM6Yz2rUuXBwVuhXQt6y9xxNffjyYGa55SY7BAWphEuCbsc/mLMRVQ
 YjGagPpS4U8TT9d8cppAKlF5Jh2R4HgmgrkE1QaV4mUqTggFgVxVssGNqWt4h4Cy5L
 pVjk8mkIBmFQmSSuTvna6giRIeySIE5pdwiIYD6McovZha8Jcb/LinePYdlam4oZ9Q
 ielEbSwWkGk1g==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C36D817E07A9;
 Wed, 16 Sep 2026 10:39:26 +0200 (CEST)
Date: Wed, 16 Sep 2026 10:39:22 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Kamil Konieczny <kamil.konieczny@linux.intel.com>
Cc: Deborah Brouwer <deborah.brouwer@collabora.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 steven.price@arm.com, liviu.dudau@arm.com, adrian.larumbe@collabora.com,
 samitolvanen@google.com
Subject: Re: [PATCH i-g-t] tests/panthor: skip sparse VM_BIND tests before v1.9
Message-ID: <20260916103922.1180951b@fedora-21.home>
In-Reply-To: <20260916075741.zeu3k3bd7ynwdrju@kamilkon-DESK.igk.intel.com>
References: <20260915-b4-panthor_version_sparse-v1-1-7ac10b75e631@collabora.com>
 <20260916075741.zeu3k3bd7ynwdrju@kamilkon-DESK.igk.intel.com>
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

Hi Kamil,

On Wed, 16 Sep 2026 09:57:41 +0200
Kamil Konieczny <kamil.konieczny@linux.intel.com> wrote:

> Hi Deborah,
> On 2026-09-15 at 17:13:26 -0700, Deborah Brouwer wrote:
> > Sparse VM_BIND support was introduced with Panthor DRM driver version
> > 1.9. If a driver isn't advertising support for v1.9, then tests that
> > call DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE should not be run.  
> 
> Can you just call that ioctl and if EINVALID skip?
> Checking version of a driver seems strange.

That's how we check feature-support in mesa, so I'd be tempted to do
the same in IGT, unless there's a strong reason not to. If we were to
check against EINVAL to detect when a feature is not supported, it gets
hard to know when it's an actual uAPI regression vs when it's tested
against a driver version that's too old and doesn't support the extra
arguments/flags.

Regards,

Boris
