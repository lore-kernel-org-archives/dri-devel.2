Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24D8F94CB0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E97B10EDCD;
	Tue, 21 Apr 2026 21:52:07 +0000 (UTC)
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC25310EDD4
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 21:52:05 +0000 (UTC)
Received: by vps.thesusis.net (Postfix, from userid 1000)
 id 08BCDDB856; Tue, 21 Apr 2026 17:52:05 -0400 (EDT)
From: Phillip Susi <phill@thesusis.net>
To: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: Regression from: drm/amd/display: Move FPU Guards From DML To
 DC - Part 1
In-Reply-To: <IA1PR12MB63078F14C8F3B76619725A9AF82C2@IA1PR12MB6307.namprd12.prod.outlook.com>
References: <87cxztkz7v.fsf@vps.thesusis.net>
 <IA1PR12MB63078F14C8F3B76619725A9AF82C2@IA1PR12MB6307.namprd12.prod.outlook.com>
Date: Tue, 21 Apr 2026 17:52:04 -0400
Message-ID: <87ik9kc77f.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
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

"Ostrowski, Rafal" <Rafal.Ostrowski@amd.com> writes:
> Hi Phillip,
>
> Sorry for problems that occured on your platform.
> This issue is fixed as part of this change: https://patchwork.freedesktop.org/patch/718415/
> Please retest using mentioned patch. If it works correctly, please let me know.
> If problem still occurs please share me details and I will work on resolving it.

That did the trick.  Thanks!
