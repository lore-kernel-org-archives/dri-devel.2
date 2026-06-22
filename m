Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0708ACDB481
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC37710E9F0;
	Tue, 23 Jun 2026 08:07:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=skoll.ca header.i=@skoll.ca header.b="aKi3naqD";
	dkim-atps=neutral
X-Greylist: delayed 440 seconds by postgrey-1.36 at gabe;
 Mon, 22 Jun 2026 19:42:33 UTC
Received: from dianne.skoll.ca (dianne.skoll.ca [144.217.161.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14EA410E7EB;
 Mon, 22 Jun 2026 19:42:33 +0000 (UTC)
Received: from pi4.skoll.ca ([192.168.84.18])
 by dianne.skoll.ca (8.18.1/8.18.1/Debian-6) with ESMTPS id 65MJYotZ452560
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 15:34:50 -0400
Received: from gato.skoll.ca (gato.skoll.ca [192.168.83.21])
 by pi4.skoll.ca (Postfix) with ESMTPS id 4gkdgs6PrZzdZSgV;
 Mon, 22 Jun 2026 15:34:49 -0400 (EDT)
Date: Mon, 22 Jun 2026 15:34:49 -0400
From: Dianne Skoll <dianne@skoll.ca>
To: Jaak Ristioja <jaak@ristioja.ee>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Salvatore Bonaccorso
 <carnil@debian.org>, Chris Park <chris.park@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Harry Wentland <harry.wentland@amd.com>, Leo
 Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 1139950@bugs.debian.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [resend] [regression] amdgpu carrizo: no display signal after
 modeset
Message-ID: <20260622153449.453b493e@gato.skoll.ca>
In-Reply-To: <6cf6be99-76c3-43b3-854f-96cae180318c@ristioja.ee>
References: <9fba2020-24d1-4235-9869-319d4aab3a4c@ristioja.ee>
 <178198613176.3658222.16247101620976737948@eldamar.lan>
 <ajcLuO0YZCoPN7Xw@eldamar.lan>
 <e4f60b98-9bd8-491a-9703-a5a7a58a4ca0@amd.com>
 <82b5026d-2dcc-4dcd-9094-2ccf70057964@ristioja.ee>
 <6cf6be99-76c3-43b3-854f-96cae180318c@ristioja.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skoll.ca; h=date
 :from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=canit2;
 bh=4YKCsCv6Dg8q+CHcKvgFdReQSfbL8ScgwMWEpw1J2Gw=; b=aKi3naqDtIW0
 rwnLRqwlTtUGB4KeoXWWFDyebgVE337PqtNWO9EJIEE7N3rBKvbl07mgLFaN2pEk
 MTX0mEwjvYSYbSjDJIKITwAMbbedhvmtJgEDnplHQVqk8MkovLY1PT/9JT7S2KrI
 BFZRskstywzSZzeyhJZ/4zNlEwy9WVzDXafBpASbPBT3jY4k6Z5D0IsvjfkRvwOO
 VrADqTpLA4BohSmK0rAIr58C+YbIqdnJXqCL8Jhh7qBjwtMiL7KNvZiMgUGsSR/N
 OtAWnWImdP52ZKKt+iSTK1rAB2KGWNoTzG1IBoDPWNphJrDMSevFAemwEQP76zJ1
 B5/Mk5ITQA==
X-Scanned-By: CanIt (www . roaringpenguin . com)
X-Scanned-By: mailmunge 3.20 on 192.168.83.18
X-CanIt-Geo: No geolocation information available for 192.168.84.18
X-CanItPRO-Stream: outbound (inherits from default)
X-Canit-Stats-ID: Bayes signature not available
X-CanIt-Archive-Cluster: tWKWaF/NcZkqjWIj0BEJTBHJhwY
X-CanIt-Archived-As: base/20260622 / 01huHyO29
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:06:53 +0000
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

On Mon, 22 Jun 2026 20:46:44 +0300
Jaak Ristioja <jaak@ristioja.ee> wrote:

> Reverting commit fee50077656 ("drm/amd/display: Bump the HDMI clock to 
> 340MHz") on top of v7.1.1 appears to resolve the issue, as I am now able 
> to get a picture.

Unfortunately, reverting that commit will *break* it for me with my Dasung
E-Ink monitor. :(

If it's not possible to detect what the maximum HDMI clock should be, perhaps
a module parameter specifying the HDMI version could be implemented?  Or
a parameter to specify the maximum HDMI clock directly?

Regards,

Dianne.
