Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A04C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 11:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83F8F10F2F2;
	Thu,  2 Jul 2026 11:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="kePSWf1P";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F1A810F2F2;
 Thu,  2 Jul 2026 11:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782991747;
 bh=rCxBw/VGd3l54sFh0psSmFyhdYRQVmOCSC3kVN6PhyY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kePSWf1POTVQee8IjNRDZt2yYLCptTIfA3mBtXcBglGgiUQelEKWo0WvcYQzGG+7a
 hDL1D3I/5WhR5Hn6+rTPJkijWg2AwisQgkiA8qzp8hy5lBXhh6Y+39D4WC1QWFwTUu
 c+oJkhxJelv6hXG5I22r9SC5Ee4a6wJ+SJpmDdsT5lGTBJmtYpc1CL/e5rxgzxUC+t
 uE3neNuWYxZPFPVXnjNjtybXJT9AjPs5E6ydW7Td9fMul2MYQdbi/lR9B6GJTvpl/a
 c9oPUrtDnzAdpxCtVpTwwjG3Yi8FAgA3PiYSrMjc0FAsf/1pVJ87Ji7JCmM/5GE8XG
 8hpEiw+6qxU3Q==
Message-ID: <8690d35f-e63c-4eb4-979a-52528896a1f7@lankhorst.se>
Date: Thu, 2 Jul 2026 13:29:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/i915/display: Use intel_de_write_fw in
 intel_pipe_fastset
To: Jani Nikula <jani.nikula@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <20260702080346.431508-1-dev@lankhorst.se>
 <20260702080346.431508-4-dev@lankhorst.se>
 <ce83da3144dca9033d78c03bcc4e9a7c9ba3f9f5@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <ce83da3144dca9033d78c03bcc4e9a7c9ba3f9f5@intel.com>
Content-Type: text/plain; charset=UTF-8
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

Hello,

On 7/2/26 10:44, Jani Nikula wrote:
> On Thu, 02 Jul 2026, Maarten Lankhorst <dev@lankhorst.se> wrote:
>> intel_set_pipe_src_size(), hsw_set_linetime_wm(),
>> intel_cpu_transcoder_set_m1_n1() and intel_set_transcoder_timings_lrr()
>> are called from an atomic context on PREEMPT_RT, and should be using the
>> _fw functions.
> 
> Why is intel_pipe_fastset() called in atomic context on PREEMPT_RT in
> the first place?
> 
> I have no idea how to maintain this.
> 
> It is *hard* for people to figure out when to use regular or _fw
> variants.
> 
> The _fw variant usage spreads all over the place with this, and you'll
> end up with folks cargo culting one or the other at random. Someone
> looking at, say, intel_vrr.c won't know why one or the other is being
> used.
> 
> I have given similar feedback before, and the response was like, "it's
> not that hard". I disagree.
> 
> I think we'll need either 1) a mechanism in non-PREEMPT_RT to flag the
> issues in CI, or 2) PREEMPT_RT runs in CI. I don't think either is going
> to be trivial to achieve.
> 
> 
> BR,
> Jani.

Ideally we'd stop using the implicit DMC lock, and replace those with explicit
DMC calls like the xe_forcewake_get/put pairs, together with the approximate
region those calls cover. I'd love to either take the DMC wakelock for the
entirety of a modeset so we can stop using the per-register notations,
and use those register accesses only for warning.

A lot of the register writes during vblank evasion use the
intel_de_write_dsb variant, which mostly does the right thing already.

This is purely about registers updated in the fastset case, which don't use the
dsb argument.

The option to flag for !PREEMPT_RT can be achieved in lockdep by adding a fake
vblank evasion lockdep lock, together with a might_lock() in the non-fw calls.

Kind regards,
~Maarten Lankhorst
