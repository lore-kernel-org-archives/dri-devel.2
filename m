Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCD2C44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CD110F48A;
	Thu,  9 Jul 2026 10:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="dmI2n3Dy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y2Wiy6rG";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C5710E6A4;
 Thu,  9 Jul 2026 10:01:19 +0000 (UTC)
Date: Thu, 9 Jul 2026 12:01:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1783591275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FqQCOTptLlptTKhPh6RLDNm9t7bmkVyXpDJ6LnwO9oQ=;
 b=dmI2n3DykHtIFfy/8Zd80zLfl09c6PbqlHrJyzEAupcQAaZiof0r0+h7xei5nd5etbJTG0
 sF2wRJTtspM11Djv2mlDvdOtlVjD6lecKdpI+GXEtzQuFKt3QBvoXorHBbVgt0rsPQUYb2
 ZSHghpCaPcNY4jvyR86HYetWbIht1i1iOXvdP0TiIgwaLV6oL+WgGGCWtMBe2ELNClU3zc
 0bktjmKr1roJtwPwlVviiuj6aulGUIz+P1bmerWmi7awx+A1coK3ZVcYHhaZugriBnKSkT
 2yh4tn9/GbRKsWHuxuOgY5JDR1cPFXXGdXn/sw+0ovEu1K/F/63s/JTEA+a//g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1783591275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FqQCOTptLlptTKhPh6RLDNm9t7bmkVyXpDJ6LnwO9oQ=;
 b=y2Wiy6rGOrItN4cI2ulAvzqMK5bdpMeW+cx9aE3Lu8tFeQD9gFVMk/SJ6cI8KP6IwrZQc/
 xcrqjovOgwIqdcCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
Message-ID: <20260709100114.WZISwM7f@linutronix.de>
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

Hi,

> The test results are available, mostly looks good except 1 spurious incomplete.
> 
> I tried reproducing it, but was unable to. It seems that pre-existing incompletes
> on the specific IGT testcase already happened before the changes.
> 
> Do you want to review the patches you didn't author, so I can move forward?
> Even if you are uncomfortable to review the signalers_lock changes, it should
> be possible to have the rest reviewed and merged upstream.

I planned to do while you asked me but got distracted.
Let me do it now and I want to get this done.

> Kind regards,
> ~Maarten Lankhorst

Sebastian
