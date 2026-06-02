Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7346CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 12:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C81F10F043;
	Tue,  2 Jun 2026 12:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="lH189INm";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E12A10F043;
 Tue,  2 Jun 2026 12:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1780403606;
 bh=K+FlRKhK+GvWaFhWkAEe2MkfHRh8M1Iw4+vqrP9ah9o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lH189INmYn7cg7lWKSQS3h8AC77c5XNvSL/SpqjY7Ro8l1fQG62qFDhPY5qIdVnzd
 swt861wBKVrvwicVliz3vXnPyhzneLzr9vO7cEimWxBi3HbbyzDAZ0gBd96fmzitF3
 GG8Det468GjgIih67hmB47wssOi2RSj+fvKhf8ycWR2W4mHgaA6wvK9rq41bTFh3uX
 EFIt4ZhcFRfF6u2DCPcfpnCPfGbTr0S2ejmRilr6eUWg5OH/y9uTHmCLJ1RCzTYj3s
 HTFq6zwLafeJ9WXbL2hY2Q84pUPg4XWVmN2cdB1802xlszbXJjP70v5vnVF763Td7J
 d7zgsLuQgjKQQ==
Message-ID: <3e012936-8493-43c8-b547-17ae40e6ef74@lankhorst.se>
Date: Tue, 2 Jun 2026 14:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/i915/display: Fix intel_lpe_audio_irq_handler for
 PREEMPT-RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, matthew.brost@intel.com, uma.shankar@intel.com,
 pierre-louis.bossart@linux.dev, jerome.anand@intel.com, tiwai@suse.de,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260602004515.1907422-1-runyu.xiao@seu.edu.cn>
 <20260602062957.0Nbtw_yY@linutronix.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260602062957.0Nbtw_yY@linutronix.de>
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

Thanks, pushed!

On 6/2/26 08:29, Sebastian Andrzej Siewior wrote:
> On 2026-06-02 08:45:15 [+0800], Runyu Xiao wrote:
>> From: Maarten Lankhorst <dev@lankhorst.se>
>>
>> The LPE audio interrupt comes from the i915 interrupt handler. It
>> should be in irq disabled context.
>>
>> With PREEMPT_RT enabled, the IRQ handler is threaded.
>> Because intel_lpe_audio_irq_handler() may be called in threaded IRQ context,
>> generic_handle_irq_safe API disables the interrupts before calling LPE's
>> interrupt top half handler.
>>
>> This fixes braswell audio issues with RT enabled.
>>
>> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
>> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>> Reviewed-by: Uma Shankar <uma.shankar@intel.com>
>> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> 
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Sebastian

