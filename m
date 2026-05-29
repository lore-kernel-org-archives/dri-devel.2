Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC92CD6E4C
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 07:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4B4810FA68;
	Fri, 29 May 2026 07:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="rnLY2qa5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RsCD7dVz";
	dkim-atps=neutral
X-Greylist: delayed 453 seconds by postgrey-1.36 at gabe;
 Fri, 29 May 2026 07:55:54 UTC
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF0910FA66;
 Fri, 29 May 2026 07:55:54 +0000 (UTC)
Date: Fri, 29 May 2026 09:48:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1780040898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDsih4SqsFbZVSQ6/Dn2K0NJqce5HwZ23VRoi6b0lL4=;
 b=rnLY2qa54BPXzDgQe1mXijqDIefpWP8kX/cTIu052hfdonoVoGNqzJi3lF75EU0CTF83Fe
 4PRO+W6JbnM5K2+2+RdIvXajW7XD20q2daszzewpOCfup4Z/t89WzJub/qc6/RO44sRMvl
 qGFdBVRX4pmNYqRkvlIpMNDBiUBMYiZ6gdgr8QThr54Fw0ZyI84HtpUSOQtELadLHYE1cR
 iVsKPV4UQCXBiidlbJMYS8Vm6f5n1btzQZikw5YMvFGAG8Hi50526dc4tcc6cmWjw0EJeu
 JN15wuhpk41j2/tKZvhs5yvAnvhMZ0XfHmsofVPV93rwK+bz+rdG91IUAz2KOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1780040898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDsih4SqsFbZVSQ6/Dn2K0NJqce5HwZ23VRoi6b0lL4=;
 b=RsCD7dVzqySTQbWDZdkyNwg2IMtYYh8D4+KJwfntZV6NgNhuaqd+3B+FaSriYcITsgphJ3
 UxZ+Sws9XIDjw4Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Maarten Lankhorst <dev@lankhorst.se>
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 airlied@gmail.com, simona@ffwll.ch, clrkwllms@kernel.org,
 rostedt@goodmis.org, jerome.anand@intel.com,
 pierre-louis.bossart@linux.dev, tiwai@suse.de,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/audio: use generic_handle_irq_safe() for LPE
 audio irq
Message-ID: <20260529074816.k1K16jyy@linutronix.de>
References: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn>
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

On 2026-05-28 23:45:51 [+0800], Runyu Xiao wrote:
> intel_lpe_audio_irq_handler() forwards the LPE audio child IRQ from the
> i915 parent IRQ path with generic_handle_irq(). The forwarded child top
> half is not an independent hardirq entry point; it inherits the context
> of the outer i915 interrupt dispatch path.
=E2=80=A6

This looks very familiar and is work in progress
	https://lore.kernel.org/all/20260310115709.2276203-16-dev@lankhorst.se/

Maarten, where do we stand on the i915 series?

> Fixes: eef57324d926 ("drm/i915: setup bridge for HDMI LPE audio driver")
> Cc: stable@vger.kernel.org

No stable fix needed because i915 can not be turned on PREEMPT_RT.

Sebastian
