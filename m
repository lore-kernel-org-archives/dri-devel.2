Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B22606D80E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=vrCVlLh9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE19210F66B;
	Tue,  3 Nov 2026 15:25:24 +0000 (UTC)
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de
 [91.216.248.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C0510F67A;
 Tue,  3 Nov 2026 15:25:17 +0000 (UTC)
Date: Tue, 3 Nov 2026 16:25:12 +0100
X-Lima-ML-UUID: e4870b7e-9828-46f9-914d-9fb9ffacc200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
 s=securedbylima-20251205; t=1793719516;
 bh=njPnq2aWT4E//QJrFHKeY7X8sbaPLa6DqsdOZFRP2uI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=vrCVlLh9oESE2yAVr+1ERF32JCpba+KbVd8efy0/Cg30jL8cMIUpayucO9eKKh+M9
 nYFdn4aiuGgB+URDxB5ariF5wBYgBuoddSOX3T75yEvF6yKdf7leH+9w8fF2jNNN9p
 lQ2//60uxIrjWL84hPU+HxhtOTey8D5y+HQtQjtRSS0bOLKVxa4K+mwzpOY27Y6NYu
 XsdZYa7Ha2zpOpiiAy6EajgIi1HK3d/xIs5nAns5XrdUfzAlkKmtvZu3wHLIMcv/mr
 Bxt613+RPQUB+E3uYhU7Pl2JkaqA2sU3Mc3NPLyKxUn/yVz1OL2Eko9yZk5xQttnj8
 N9vwmZRAfoYDw==
From: =?UTF-8?B?QW5kcsOp?= Eikmeyer <dev@deq.rocks>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Ed Schofield <ed@aicharmers.com>, amd-gfx@lists.freedesktop.org, Kenneth
 Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
Message-ID: <20261103162512.2ec834ac@kait2en-mbp15-1>
In-Reply-To: <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
References: <20260916144014.879355-1-ed@aicharmers.com>
 <CADnq5_MsaUDm8rcxr3_0wuEAXywxziAofOO9w-dUxYS9PUoasw@mail.gmail.com>
 <20261030123000.5573e70f@kait2en-mbp15-1>
 <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
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

On Tue, 3 Nov 2026 09:30:34 -0500
Alex Deucher <alexdeucher@gmail.com> wrote:

> It is the same issue.  I don't want two fixes for the same issue.

Understandable, but it is not. Two devs told you the same
independently. 
On another note I reviewed your patch. It only rejects empty or zero
levels. On the 16,1 the pptable levels (736/750 MHz) are non-zero.
Besides other issues in the code, the commit message says the exact
patch wasn't tested, yet v5 extends it to every Apple Navi 1x.
I am sorry but your patch is implausible to me.

Andre 
