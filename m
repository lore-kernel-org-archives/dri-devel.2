Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6680606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=VoQ8JOOM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92575112760;
	Fri, 30 Oct 2026 11:30:14 +0000 (UTC)
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de
 [91.216.248.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A98112760;
 Fri, 30 Oct 2026 11:30:08 +0000 (UTC)
Date: Fri, 30 Oct 2026 12:30:00 +0100
X-Lima-ML-UUID: cb4c68a3-c4df-444f-b29d-b3be3ecdeeb1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
 s=securedbylima-20251205; t=1793359805;
 bh=P9F0Hx3zzFPEhRZXhwMxkkF3mMj+Be93AHgQNYo3wK8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VoQ8JOOMH4GClI4YH5Jdrqd80ih1F+smHYE6S/wn3HdO5dGjaS6fFjukwafT9J1/I
 2XBTymfc6kbY421FW0B6zykjikZmi585nL2hLz5jbIHyk16nW/d0JGJQwGR4LQX9TJ
 rZUVZCkFHTawB+0W4hZEW2eVb7aXFlksBjAz14PUMXQTAPiuSmlAFIDARByWM8diTH
 MMAPGlxlL8GaodhSBCoIlNfPjAxrWdExYi1ckCfXixX606/lD86ExLpd5fKMGZz/ol
 /ly7UgjANuU5qkbC6OdZIX261an5MZBqV29BJGlOTZlZaHEsA07I35KkTVB/un2gEd
 D8jPXCaYHPpMA==
From: =?UTF-8?B?QW5kcsOp?= Eikmeyer <dev@deq.rocks>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Ed Schofield <ed@aicharmers.com>, amd-gfx@lists.freedesktop.org, Kenneth
 Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
Message-ID: <20261030123000.5573e70f@kait2en-mbp15-1>
In-Reply-To: <CADnq5_MsaUDm8rcxr3_0wuEAXywxziAofOO9w-dUxYS9PUoasw@mail.gmail.com>
References: <20260916144014.879355-1-ed@aicharmers.com>
 <CADnq5_MsaUDm8rcxr3_0wuEAXywxziAofOO9w-dUxYS9PUoasw@mail.gmail.com>
Organization: KaiT2en
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 17:57:49 -0400
Alex Deucher <alexdeucher@gmail.com> wrote:

> @Andre Eikmeyer I think this patch should fix your system as well.

Hi Alex,

I guess you have seen it already but the patch doesn't match the 16,1.
Its boards are 7340/020f and 7340/0210, and v4 only matches 0218, 0219
and 021a.

That hang is what I sent a fix for
https://lore.kernel.org/all/20261024162109.307247-1-dev@deq.rocks/

The VBIOS trains the UMC p-states at different frequencies the pp-table
lists. The SMU hangs as soon as UCLK switches into level 2. Deferring
the UCLK enable doesn't change the levels, so the hang just moves from
boot to later under load.

The two patches can coexist after a trivial rebase.

> ...your system...

I need to clarify here. I actually don't own a 16,1. But I maintain a
distro (KaiT2en) that specializes on T2 Macs. So the patches I develop
are extensively tested by the community before submitting. Atharwa is
part of this community. Ed is not, but Atharwa reviewed and tested the
code.

Best,
Andre
