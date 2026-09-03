Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C383AC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 114FF10E356;
	Thu,  3 Sep 2026 08:24:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="RVpZKePw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EuRwRA+n";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CADFF10E356
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:24:38 +0000 (UTC)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1788423877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ls4xniOjZvy5k7qWaJ+bT9dRttTYo5UPShghXw3DL8g=;
 b=RVpZKePwsgjPGHsweB7GsSuZAyk6Vl8bcGSJUN6FBtM9LdDAnHDTYpG6/2temWpyraRJTj
 +1bWgj1+i/XprSF2i6YQOUoR+Vsko6rVtZM1BokT2dHT2OEA23JAM0FRAfS6lphHjOegnh
 vgVH1XfCVMIIPGlyGGrbsi9W3Qtp5Q1qMuM7i+kiPFV7YOuAZypFfOEMnQysoVhQpRwWmH
 sX/XAuMKyvlGlF/h6w7AY6WdhaYlI+Vejb8NEpi4SRSQtqQNXYLVt/aTFvYXKBLA9RVx/h
 65RCKpw9Jo2ouDGLcSUv3e4vZSaTa4K9QQUrFq0ytj3o52TtkPzLhckQFMRb0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1788423877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ls4xniOjZvy5k7qWaJ+bT9dRttTYo5UPShghXw3DL8g=;
 b=EuRwRA+nb7Nc94Y1bLLMKkBSwoTlXFOzsm6Vl3tC88wEcv4xGKBRogh0aJ7iEG+Sq1mt6V
 eezpmJsJxikFaDDg==
To: Anshika Jain <anshikajain196872@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, sashiko-bot@kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: fix len<=0 buffer overflow in
 define_fbtft_write_reg()
In-Reply-To: <CABj3sPEMo3B9B0ynfLGD=NmMu+0zpZ_Ydf2yyT7NDaT3DDNq=A@mail.gmail.com>
References: <20260902045026.7442-1-anshikajain196872@gmail.com>
 <87wlt3vnzp.fsf@yellow.woof>
 <CABj3sPEMo3B9B0ynfLGD=NmMu+0zpZ_Ydf2yyT7NDaT3DDNq=A@mail.gmail.com>
Date: Thu, 03 Sep 2026 10:24:36 +0200
Message-ID: <87cxuu68u3.fsf@yellow.woof>
MIME-Version: 1.0
Content-Type: text/plain
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

No html email please, the mailing lists will not get them.

Anshika Jain <anshikajain196872@gmail.com> writes:
> I'd like to keep this as a small safety check for the future, not as a fix
> for a bug happening today. If you think that's not worth adding, I'm fine
> dropping the patch.

As mentioned, such bug would show up immediately in testing. So I vote
dropping it.

Nam
