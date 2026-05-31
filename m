Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF26DCD6E56
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 09:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21EC10E575;
	Sun, 31 May 2026 09:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="vcOUEJKV";
	dkim-atps=neutral
X-Greylist: delayed 58308 seconds by postgrey-1.36 at gabe;
 Sun, 31 May 2026 09:26:39 UTC
Received: from mail-244120.protonmail.ch (mail-244120.protonmail.ch
 [109.224.244.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF9E10E575;
 Sun, 31 May 2026 09:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1780219597; x=1780478797;
 bh=ufOpnOo52TYNCazTfkbDOI1WNGGOv5LGir9FEooQ2P0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=vcOUEJKVFNc+tdKsSpueS7jFHt+DEAtr+FzBMB7NNnca42Yh9S51yZunwcGttgX8O
 nuLztTc1cCdQXoecn3mFg9GakBmnLJTP7GlPkvfcIS6q2y7CMiNTJLqXuQZ80YkLvV
 rjVNB4FZd3oaAFJyXE6P188f3TcuyYSEsRe9PcaqkzVahjXR4jkmVLJ8N0L2/p0V3Z
 aW61Z5LO6grPVV59BLCHDLRtobw09YuLTtweb8T9BjPaz2W9I11nDJmrlyfkxG9+NZ
 CcjKkRorjr1Jlc1zOS+B4c9EURKZ9pv39Ouiq6z08QhWJpAHcHtq1gnDsHkDUt+b2a
 h0OdfHkopqy4A==
Date: Sun, 31 May 2026 09:26:32 +0000
To: dri-devel@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: wayland-devel@lists.freedesktop.org, Daniel Stone <daniel@fooishbar.org>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] drm/atomic: introduce PAGE_FLIP_EVENT property
Message-ID: <IuIpqwB2CY7dG3slDq6s1SKiyHW_0m8JuVsLgNyx3AnoOTYy-9ydgF5ovlj0RcTyHu3oOuGp1ZsJPgFlh-k7RoP2zo8ZFwOTDVTfh6ldduQ=@emersion.fr>
In-Reply-To: <20260530171422.4615-1-contact@emersion.fr>
References: <20260530171422.4615-1-contact@emersion.fr>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: b4ede5e9974416789e2dbf2f281bb5f981e8da47
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

IGT test available here:
https://lists.freedesktop.org/archives/igt-dev/2026-May/111026.html
