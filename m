Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDA8C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C9610E6DD;
	Wed, 19 Aug 2026 06:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.b="RXOMzCze";
	dkim-atps=neutral
X-Greylist: delayed 388 seconds by postgrey-1.36 at gabe;
 Tue, 18 Aug 2026 03:03:26 UTC
Received: from mta-sndfb-w02.mail.nifty.com (mta-sndfb-w02.mail.nifty.com
 [106.153.227.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3476110E4B3;
 Tue, 18 Aug 2026 03:03:26 +0000 (UTC)
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
 id <20260818025655235.IIMY.18412.HP-Z230@nifty.com>;
 Tue, 18 Aug 2026 11:56:55 +0900
Date: Tue, 18 Aug 2026 11:56:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>, Danilo
 Krummrich <me@dakr.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: X does not start (or does not show screen) on DisplayPort of NVIDIA
 Quadro 600 with nouveau
Message-Id: <20260818115653.b3a2d355a1cc4c71090c7b78@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=default-1th84yt82rvi; t=1787021815; 
 bh=VV3fsrnwtbIg4scMnbRWdN8Kc/L1AB3L+OZdUmOlIQM=;
 h=Date:From:To:Cc:Subject;
 b=RXOMzCzeZnabLVrLEAyZMSpVrqaxcx5YYQhAu4Hxh8K6FqjM6sUqiBvN9gjY/+5XNYZ7EQ6J
 7g221Hs+VMXe3RP5wRw+00jxCzg+9Rs/DecVCrVz8+nkNwfSkW3D6IgURCF+fGLGJlCH+Krg4l
 Z6yrC2XQ8jjmfDl4Z17+AoQMOd9y7piVUAv48CAWhUi5CsDTiThHJvpt+r9NBET8DrFi2aYkoW
 8JZ2p9LME3BhbV3iYuAxakQUzqMldXleFtrEttRi7vCAPIp/LQYPxt1iUF7FkO3nQjx1JQKiWX
 9doiWRO2NilIHFsdgoM2V2+HONKfiWyTuX435qTrsR5L4ygQ==
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

Greetings,

I apologize if you have already noticed this or are already
working on it, but I wanted to let you know that I have posted
a bug report along with a corresponding patch at:
https://gitlab.freedesktop.org/drm/nouveau/-/work_items/496

The report describes an issue where the nouveau driver fails to
output the correct signal on the DisplayPort of the NVIDIA Quadro 600.
The bug also affects the Quadro 2000, 4000, and FX 1800, but it
does not affect the Quadro K420, K600, and K620.

I would appreciate it if you could take a look. Any assistance
or feedback would be greatly appreciated.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
