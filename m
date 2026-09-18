Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7EFC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E9CE10EC14;
	Fri, 18 Sep 2026 08:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="joQWAoCL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6OV651Et";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2095A10EACF;
 Fri, 18 Sep 2026 08:31:22 +0000 (UTC)
Date: Fri, 18 Sep 2026 10:31:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1789720280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DX63TqpbNH0JKD1nTOlsNwIQYNz4LSFy5bw8/4DuG0s=;
 b=joQWAoCLBaxqngfdBIVegfj2UYyK0RZn8lJG/Je3Lq20mM4GURRU15lkrRTsg/G3YpEkG7
 iWq9i61ZSn5RsEVB+3Rxg1rNk9JftCrIhZT2Bg+t0KFp+R29rGi1Ap7Tv38Osos7+3OFlq
 qfTgKSRyPqgoeopkWjjP+AnC2YUExvRYYhCHVnWbaQ91iwYyYLcntvSDp3SZthGPDakTKq
 vTmhGcl9S8yaQQ6oCCwSeLYOcBLEsydKZC2dPwjshrEE7IaqWIWAaNgfVisv5weLtGTtBo
 AuDJndjRkea9dGOo0p2ture2b9E+GaKnx+6MK2sNHY1ytHNMDqPVJpwOaIpZdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1789720280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DX63TqpbNH0JKD1nTOlsNwIQYNz4LSFy5bw8/4DuG0s=;
 b=6OV651EtGSh+Zvt3+rp9IdApzQ40p5ozNrvH8EI8d3HA/rOj2fhBMlDAlml46nfgfwXeHH
 BMKTPiDb3qPJUHDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
Message-ID: <20260918083118.POmXtJuv@linutronix.de>
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706122026.IJAiyhhw@linutronix.de>
 <c4222f81-72b2-4eea-a900-da327f0df928@lankhorst.se>
 <20260709110200.2_5Eg8xF@linutronix.de>
 <a6c056ba-0847-4d2c-a7bd-39ac27eb15d5@lankhorst.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6c056ba-0847-4d2c-a7bd-39ac27eb15d5@lankhorst.se>
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

On 2026-07-09 13:36:57 [+0200], Maarten Lankhorst wrote:
> Hey,
Hi Maarten,

> Yeah the problem was similar, I believe neither check should exist,
> instead the caller should give this information like the comment mentions.

Any update here? Maybe I have been left out on reposts. Any chance this
gets in before the LTS of this year gets out?

> Kind regards,
> ~Maarten Lankhorst

Sebastian
