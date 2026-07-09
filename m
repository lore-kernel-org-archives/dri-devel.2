Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552D6C44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCFAE10E69D;
	Thu,  9 Jul 2026 11:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="4IaDf5B+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VdwdA1sN";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDDD510E090;
 Thu,  9 Jul 2026 11:02:05 +0000 (UTC)
Date: Thu, 9 Jul 2026 13:02:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1783594921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FySWx+2h8Y4gcqIJ96KDKfhGXlG+iSlkEpznsqFWM9o=;
 b=4IaDf5B+2yQLEVXL/mW4/VrV+UM7wjmx29zfUuV9yrul2YS6RolI77m4kfmU/6QRlOhQpp
 0tCu5GAn0yZHOw+cCBmxZfJacr20uuV+73NFeKa8etwBms/Xz3Hir90RztOZLcCa3S2bp/
 FhvBwz42yKR1Prfp8Bdrk6x8HKIvIgBZ30KRr0k1zvkrJu4E2YA0CHUpzGToT6PbbLs5I5
 vTX/NTXiGSpOcSzpb0CEv/9w8323skv/tEYfnogDYbzPe7foh3X1/7uxGOGZ3AAXYKerZw
 8Lcgpgv+2F0XFbctrmiQrzOKG4HgDAONQhRfduQg2D2Gqi+z20kkXvdz9Qdt3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1783594921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FySWx+2h8Y4gcqIJ96KDKfhGXlG+iSlkEpznsqFWM9o=;
 b=VdwdA1sNFb934bTDnq/D/xK5Azys6XiIfgwVDbKT+LIJiSu/GZcbnRgX+WyH0H2VZbE6K0
 Vm2hxtxsllMfIcAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
Message-ID: <20260709110200.2_5Eg8xF@linutronix.de>
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706122026.IJAiyhhw@linutronix.de>
 <c4222f81-72b2-4eea-a900-da327f0df928@lankhorst.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4222f81-72b2-4eea-a900-da327f0df928@lankhorst.se>
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

On 2026-07-09 11:53:52 [+0200], Maarten Lankhorst wrote:
> Hello Sebastian,
Hi Maarten,

> The test results are available, mostly looks good except 1 spurious incomplete.
> 
> I tried reproducing it, but was unable to. It seems that pre-existing incompletes
> on the specific IGT testcase already happened before the changes.
> 
> Do you want to review the patches you didn't author, so I can move forward?
> Even if you are uncomfortable to review the signalers_lock changes, it should
> be possible to have the rest reviewed and merged upstream.

This looks good to me. The condition in 5/7 is the as in 3/7. Not sure
if this should be merged into a helper or if it should be passed from
the caller. But it seems the information of the calling context is lost.

Please move forward ;)

> Kind regards,
> ~Maarten Lankhorst

Sebastian
