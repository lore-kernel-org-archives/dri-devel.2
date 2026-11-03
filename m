Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C37606A337
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=e6tKkOS0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058A010F6DA;
	Tue,  3 Nov 2026 16:15:42 +0000 (UTC)
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de
 [91.216.248.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925B910F6D8;
 Tue,  3 Nov 2026 16:15:35 +0000 (UTC)
Date: Tue, 3 Nov 2026 17:15:28 +0100
X-Lima-ML-UUID: 679b76d9-915f-4cd3-99df-b2e53f6cf96b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
 s=securedbylima-20251205; t=1793722532;
 bh=KQtvUYqOwLZd5uCo5462X/CnoM3Ap3jbUDTXdiBqhgM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=e6tKkOS0wrr9oqh1VYZAHOoOy3jLOA1E6c0ZRrQQPnacpg7INLttwDBXV6uus2bvA
 91wel74rCzaZSin6RHp45gXgDpNO9zOl38kmM08d4Md6dJj+SJdfXZhfCPTK5BezW4
 puH8QXyUookVOwFduNdENebIxpQV/Q3XdHiD4vGfynlXh5cDx4GRS6T6AXvpLwX5i3
 /cb0Yk5moE8Y26tdqeacZaO217t4bgIFFsxAwThkSiGEXaMGMNMYXLqHg5c86lrG+v
 HgD8W+xW71IV43SRxhVMTv4oT8HJok3rto8xLK1veFaFeNtuM2ujrFhSVz8ShP5KqP
 w6FIXnLzwbQOA==
From: =?UTF-8?B?QW5kcsOp?= Eikmeyer <dev@deq.rocks>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Ed Schofield <ed@aicharmers.com>, amd-gfx@lists.freedesktop.org, Kenneth
 Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
Message-ID: <20261103171528.6c6a0edf@kait2en-mbp15-1>
In-Reply-To: <CADnq5_NDJ7V=TQLOJ37msbmhwsVG+70mPKU3ns+xmAu9jxWwcg@mail.gmail.com>
References: <20260916144014.879355-1-ed@aicharmers.com>
 <CADnq5_MsaUDm8rcxr3_0wuEAXywxziAofOO9w-dUxYS9PUoasw@mail.gmail.com>
 <20261030123000.5573e70f@kait2en-mbp15-1>
 <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
 <20261103162512.2ec834ac@kait2en-mbp15-1>
 <CADnq5_NDJ7V=TQLOJ37msbmhwsVG+70mPKU3ns+xmAu9jxWwcg@mail.gmail.com>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 10:53:56 -0500
Alex Deucher <alexdeucher@gmail.com> wrote:

> I forgot to remove the pptable check.  Can you try a simplified
> version of the patch?  I think all you need to do is delay the UCLK
> DPM enablement until late_init.  Something like the attached patch.
Alex, as I told you earlier.  I don't own a 16,1. I developed the patch
I submitted. It took me months to figure out while debugging via ssh.
Currently a community of nearly 6000 people are happily using it.
I dont understand your fixation towards a patch that fixes nothing. I
dont understand why you write patches based on obvious slop without even
being able to test. And I dont see why I should help you with it. There
is simply no point in it. 
