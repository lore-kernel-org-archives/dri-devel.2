Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1974FCD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E0F610EC24;
	Tue,  2 Jun 2026 06:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="typz2QUm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2BIwIP7i";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D039010EC24;
 Tue,  2 Jun 2026 06:30:03 +0000 (UTC)
Date: Tue, 2 Jun 2026 08:29:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1780381799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ecggid4oxBPetO9VpD9pgbKrnVT8Kxu3BoqG4VRuLbY=;
 b=typz2QUmbKfo+Q6/hTQy/WbKJq6sXmiN4N3qdWYLujpSvVtsSmu/4B5Iu9nhbg6TZ0/z1k
 KPt5PNGXPlN+U0rgWEyHYkm9mXS3MUkR4A4SJuYZqNkSS2+5gZO3sOrnx/17beSYVJKHBG
 iLhuLvMLpw4Oe48JGKHaMsQpyFt3YSHCo0UDsU71PgfBA50pGw3NJXDagptw45rNg2jbCn
 oovTq17aRiBQxI6pxjlUYW0pJEuUFw3XxSMwlUvOymxAuOE9r5vq/nF56L26i2HpCBD5ey
 XWb9Qj4jfKTNBn4ipmVpUY+lFWVx4lRMRyDmrxBHqIgl+1ukk8vNJVzJfcQ+7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1780381799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ecggid4oxBPetO9VpD9pgbKrnVT8Kxu3BoqG4VRuLbY=;
 b=2BIwIP7ijhYHOgzJGQ/Jk9AmUAqnSuGIS4ltnmmeyUc+iYjyc47tMZ3uzueiR2RNQ2b9Cq
 5FlYlewRfVaAkjCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 airlied@gmail.com, simona@ffwll.ch, dev@lankhorst.se,
 matthew.brost@intel.com, uma.shankar@intel.com,
 pierre-louis.bossart@linux.dev, jerome.anand@intel.com,
 tiwai@suse.de, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn
Subject: Re: [PATCH v3] drm/i915/display: Fix intel_lpe_audio_irq_handler for
 PREEMPT-RT
Message-ID: <20260602062957.0Nbtw_yY@linutronix.de>
References: <20260602004515.1907422-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602004515.1907422-1-runyu.xiao@seu.edu.cn>
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

On 2026-06-02 08:45:15 [+0800], Runyu Xiao wrote:
> From: Maarten Lankhorst <dev@lankhorst.se>
> 
> The LPE audio interrupt comes from the i915 interrupt handler. It
> should be in irq disabled context.
> 
> With PREEMPT_RT enabled, the IRQ handler is threaded.
> Because intel_lpe_audio_irq_handler() may be called in threaded IRQ context,
> generic_handle_irq_safe API disables the interrupts before calling LPE's
> interrupt top half handler.
> 
> This fixes braswell audio issues with RT enabled.
> 
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> Reviewed-by: Uma Shankar <uma.shankar@intel.com>
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
