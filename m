Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814FBC44502
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D41DA10E914;
	Mon,  6 Jul 2026 12:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="yYRL2aYI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wNuj/vtn";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B6310E386;
 Mon,  6 Jul 2026 12:20:29 +0000 (UTC)
Date: Mon, 6 Jul 2026 14:20:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1783340427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vwgjeZEUy5xLROQXQp8bFHb+5LD1aSG7+FqAwA2PMAE=;
 b=yYRL2aYIO5A/bd/VRkeD8QrEcQQeXQSdAzN8qmrIOkPVxNBp3W4LGOmqfCC0AvtjkBPqTv
 /Ao3NYub2PU7IOLCbycBo0BZ1UG+6l6fHkdrVMv5RXgr7puL1vDBQdRB97rXxIho+VWh8y
 5GgpdfiU+INESWsgTAo6Yi6EEUk0zVvjPnbCO2893LRm967dYDlpkgXe/u3d/VAUSkDCYi
 /K1ZMrAdhNPVGRbAoSuq0GSeqbeAQVHi/Uw3sBu646548EWBYXuvH7wEXQ5MrMTxHWmHa8
 dW+SgniCH6ZD0u26+KMIPOJS43CpqmT8kcxZlylOhaEzWkLALoeWXSPR+u+wvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1783340427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vwgjeZEUy5xLROQXQp8bFHb+5LD1aSG7+FqAwA2PMAE=;
 b=wNuj/vtnG92JmVN3V2MZUGJfyzRhJjIPLenm9RnHqjhdCukEx0dkqzFYnkUx/oGiXjhApm
 u0XmQuXCSBKdAvAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
Message-ID: <20260706122026.IJAiyhhw@linutronix.de>
References: <20260706114823.752313-1-dev@lankhorst.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706114823.752313-1-dev@lankhorst.se>
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

On 2026-07-06 13:48:16 [+0200], Maarten Lankhorst wrote:
> All fixes to make the core i915 module (without display) working correctly on
> PREEMPT_RT.
> 
> Some fixes are still needed, as the selftests still fail. But otherwise the
> test results were looking good on PREEMPT_RT.
> 
> It looks like the patch that added a spinlock caused a regression on !PREEMPT_RT,
> and may even have caused similar test failures on PREEMPT_RT, so to fix it
> I removed RCU entirely, and converted to a locked implementation instead.
> 
> This time at least, i915 live selftests pass on !PREEMPRT_RT for at least 1 machine
> with same config as CI.

I saw the version counter overflowed and is at 4 here. I appreciate all
the work. May I ask how are things?
 
Sebastian
