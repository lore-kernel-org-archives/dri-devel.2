Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F9BC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9A5510F567;
	Thu,  9 Jul 2026 11:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="Yrp7aBYs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dt6TIJvu";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0537710F567;
 Thu,  9 Jul 2026 11:58:21 +0000 (UTC)
Date: Thu, 9 Jul 2026 13:58:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1783598298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mxPjGxeJFxgTx8adRduXNJ7zQ8F57eVaZDAOjdVWpzg=;
 b=Yrp7aBYs93pcNFb6GYGd5IqIowWeBA9CmOrUGNnf/BmpLu3PDZSb39HduwBB0su+G/yQ2g
 iGbSunLsCY1JkD3v3K5UGINjCnRgJCBAHQ1rRA5v+G+EcfDicNA6GbgL9iCEJecglRS2r0
 IqdeAxyzGaSgI9gfHpA9qcIeTdvTwZQSCl4gltKeUA8GVYSc8BnZKHv374wOHmT9ZOzi9Z
 VcK4X9cyks9Bm1TIEBApn2ES7K8OvJnCboOHK/qJUzVmOdcnkFovUgJ85/8R+ERaA22poj
 HxOuKANhKoGOfzcBpHufqZCBXH1GnUFPBiK3caMViLTVW8oz1xfeWmimxKErWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1783598298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mxPjGxeJFxgTx8adRduXNJ7zQ8F57eVaZDAOjdVWpzg=;
 b=Dt6TIJvuwDWgRjVuZTpe4gpdZUWnri2j6/0r0iFkvaNMQ0dUuASVl9mvptLkpBAq18aeW1
 Eu6hXXg6B4a5SRAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 7/7] drm/i915/gt: Use signalers_lock to prevent
 starvation of irq_work.
Message-ID: <20260709115817.u08CeoiP@linutronix.de>
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-8-dev@lankhorst.se>
 <20260709105754.WJvT6s22@linutronix.de>
 <93032fce-041a-4991-9eec-29dfbb0e5116@lankhorst.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93032fce-041a-4991-9eec-29dfbb0e5116@lankhorst.se>
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

On 2026-07-09 13:16:06 [+0200], Maarten Lankhorst wrote:
> Yeah, it seems I missed doing --reset-author when amending here.
> It likely needs your sob too if I add you as co author, can I reuse it from the original patch?
Sure.

> ~Maarten

Sebastian
