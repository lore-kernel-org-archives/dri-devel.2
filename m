Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C766CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 22:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5F6710E358;
	Wed, 13 May 2026 22:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="t4NVFrGs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D03610F0DD
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 22:32:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C4F760052;
 Wed, 13 May 2026 22:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B01FC19425;
 Wed, 13 May 2026 22:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778711529;
 bh=iFy6DyTK6bP2bzHFBlZ5Z6Lji7h6EOpHFC92IovV77E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t4NVFrGs/s1WZW5Q2qbdlWc6hVF1PfSK8ydtSf2fkRWro8Ms/Xlt+dfLZBAwuo+J+
 42tqJkknGI6zzJlJKHAYAuiJJuaa8x4OevegQ9ms/Zd7BHq/vIVE15D7rlw8ddoNNo
 CK6Vm39M98AeCorbWjZoNzf1K1pnCXhK7l1U7ItDlWF9qYFeWECWBxsUNj0/cMOAuR
 XONP6LbOlVfevmhwkjEIwm8gm+DCbdp3ACMqCopW4QHVeaeYUfzA+854dnholO5f+5
 zDjyIyTw7kHJL5mtcT+qZQ9/NabEHq5j88yuI5D+5vvWyJJgcdGcXEqdBc8EgtUcqc
 KLG7/Uda5MMoA==
Date: Wed, 13 May 2026 22:32:07 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "jfalempe@redhat.com" <jfalempe@redhat.com>,
 "drawat.floss@gmail.com" <drawat.floss@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "ryasuoka@redhat.com" <ryasuoka@redhat.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Drivers: hv: vmbus: Provide option to skip VMBus
 unload on panic
Message-ID: <20260513223207.GA336053@liuwe-devbox-debian-v2.local>
References: <20260217182335.265585-1-mhklkml@zohomail.com>
 <SN6PR02MB415786A3C7D10C22FAB12E3ED4312@SN6PR02MB4157.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415786A3C7D10C22FAB12E3ED4312@SN6PR02MB4157.namprd02.prod.outlook.com>
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

On Mon, May 04, 2026 at 08:47:50PM +0000, Michael Kelley wrote:
> From: Michael Kelley <mhklkml@zohomail.com> Sent: Tuesday, February 17, 2026 10:24 AM
> > 
> 
> Wei and Thomas --
> 
> This small patch series has been neglected. Patch 2 of the series is here [1].
> 
> Long Li < longli@microsoft.com> has given a Reviewed-by on this patch,
> and Jocelyn Falempe <jfalempe@redhat.com> has given a Reviewed-by
> on Patch 2 of the series, modulo a comment which I have incorporated.
> See [2]. But I neglected to add her R-b when I spun v2 of the series.
> 
> Any reason this can't be picked up as a bug fix for 7.1? I just checked,
> and it applies cleanly to a recent linux-next (20260423). I'd suggest
> going through the hyperv tree, as these two patches should be kept
> together in sequence.
> 

I thought they were not reviewed yet. I have now applied them to hyperv-fixes.

Thanks for the reminder.

Wei
