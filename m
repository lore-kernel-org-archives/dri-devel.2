Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684C9C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC5B10E517;
	Mon,  6 Jul 2026 12:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="EFN47mwh";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2027989FA5;
 Mon,  6 Jul 2026 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1783342254;
 bh=7r+siOYaJs4PQAazhD5o8ko6J7tWMYCwN536i5wzqYg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EFN47mwhH7IrwMCpMv80OA7asq2N+TV0ciI2F9yeSKHFDL3gI3mbnJ6H7O5YS9iVJ
 /Xfvs98yyjNrG/jIUHrmPTHsfshI3iJ+QsTx9WuZNEjPi/bZ/5m/Y6DlMpT3kgIcOl
 l6+1b/gfxGT+v5KeN94iQcraz7PeVInXaJPFG7i4JjccI7cqkMJnRAlt181iO3D8Fl
 e9+KgnmORvsZEcWYOfedKWgfx8ewSjMllgiEVvxdsv2pCwF8E03d8ML6OWwEmGBO/W
 ELtSsLOw4JP4kzZxKKW95p1Jw9BmFNXhQgst+yBvmAmEq7EO5QfS2ktYdkEpr8L25j
 FW6ise1CYSkdQ==
Message-ID: <623e11ee-2f45-471d-bef1-d7bd9b717e1a@lankhorst.se>
Date: Mon, 6 Jul 2026 14:51:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706122026.IJAiyhhw@linutronix.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260706122026.IJAiyhhw@linutronix.de>
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

Hey,

On 7/6/26 14:20, Sebastian Andrzej Siewior wrote:
> On 2026-07-06 13:48:16 [+0200], Maarten Lankhorst wrote:
>> All fixes to make the core i915 module (without display) working correctly on
>> PREEMPT_RT.
>>
>> Some fixes are still needed, as the selftests still fail. But otherwise the
>> test results were looking good on PREEMPT_RT.
>>
>> It looks like the patch that added a spinlock caused a regression on !PREEMPT_RT,
>> and may even have caused similar test failures on PREEMPT_RT, so to fix it
>> I removed RCU entirely, and converted to a locked implementation instead.
>>
>> This time at least, i915 live selftests pass on !PREEMPRT_RT for at least 1 machine
>> with same config as CI.
> 
> I saw the version counter overflowed and is at 4 here. I appreciate all
> the work. May I ask how are things?

I'm fixing the bugs in core i915 with this specific PREEMPT_RT series,
and left out the display changes. This showed that the failures in i915's
selftests were at least partially related to the PREEMPT_RT changes in the
last patch.

Hopefully v4 passes CI and if you want, you can review those changes so they
can be merged. Looks like sashiko is great at finding concurrency bugs,
changing from RCU back to a normal lock is non-trivial. It unfortunately found
1 more in add_signaling_context for a missing !list_empty(&ce->signal_link),
but should be safe to review regardless.

Kind regards,
~Maarten
