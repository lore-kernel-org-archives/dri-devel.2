Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11D4C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245C010E807;
	Mon, 13 Jul 2026 07:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="QXkWykl8";
	dkim-atps=neutral
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A439310E571;
 Mon, 13 Jul 2026 07:14:52 +0000 (UTC)
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
 by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4gzDFF2YLdz41mt;
 Mon, 13 Jul 2026 09:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1783926833;
 bh=ft5/eljShbuYhVYHfb0X4qATRaHxv9WlJJ3lqFQIN2A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QXkWykl8hifEgutAY/lzyn35YKVwZWQWF3ZaqD7dFUropywiLUD+NzTU9FbrMS8Gb
 N7TxJzsyM0rLg1s/N6S+evPSuSWcZKd3S72/5H9dIgpUVrYW9zJfbJ/NJReuVi0hiA
 ZEdzy7+Yr2Yn2lwb9NaTOuQbP8Q03XImk0jOy1ds6DrsPXaCFjrUwgbNgeJU2W9foc
 IeTnObDohuNHv8HGeUgcPfb760bwn+7YdwIoW7B5laHHhvYjg6ZsQPAN7SCUtJNtAk
 XCKUKycfalhsqa+m1pOL8dSc8Pd5aec/KxZiGCDjsJndw0jrSY8Hn+zQwBmHhsLsgy
 IClFEYaqTfVJA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4gzDF31rC6z41vC;
 Mon, 13 Jul 2026 09:13:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gzDDz3Vhbz8tbl;
 Mon, 13 Jul 2026 09:13:39 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 81FD66041D;
 Mon, 13 Jul 2026 09:13:31 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ae5c29aa-3790-479a-bdfb-1b571eaab809@leemhuis.info>
Date: Mon, 13 Jul 2026 09:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend] [regression] amdgpu carrizo: no display signal after
 modeset
To: Dianne Skoll <dianne@skoll.ca>, Jaak Ristioja <jaak@ristioja.ee>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Salvatore Bonaccorso <carnil@debian.org>, Chris Park <chris.park@amd.com>,
 Matthew Stewart <matthew.stewart2@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 1139950@bugs.debian.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <9fba2020-24d1-4235-9869-319d4aab3a4c@ristioja.ee>
 <178198613176.3658222.16247101620976737948@eldamar.lan>
 <ajcLuO0YZCoPN7Xw@eldamar.lan> <e4f60b98-9bd8-491a-9703-a5a7a58a4ca0@amd.com>
 <82b5026d-2dcc-4dcd-9094-2ccf70057964@ristioja.ee>
 <6cf6be99-76c3-43b3-854f-96cae180318c@ristioja.ee>
 <20260622153449.453b493e@gato.skoll.ca>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260622153449.453b493e@gato.skoll.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178392681229.3442660.9578169747564647640@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 81FD66041D
X-NC-CID: MzLG2tZMKB/ADR25837MhEmuu9VJVl40ek1ivkRoK5XTXQ/26lE=
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

On 6/22/26 21:34, Dianne Skoll wrote:
> On Mon, 22 Jun 2026 20:46:44 +0300
> Jaak Ristioja <jaak@ristioja.ee> wrote:
> 
>> Reverting commit fee50077656 ("drm/amd/display: Bump the HDMI clock to 
>> 340MHz") on top of v7.1.1 appears to resolve the issue, as I am now able 
>> to get a picture.
> 
> Unfortunately, reverting that commit will *break* it for me with my Dasung
> E-Ink monitor. :(
Jaak, was this ever resolved? It looks like this fell through the
cracks, but maybe I missed something.

If this is still unfixed, I think it likely is best if you report this
to https://gitlab.freedesktop.org/drm/amd/-/work_items/ if you haven't
done so already -- I suspect that is more likely to get the attention of
the amdgpu maintainers. Please drop the link to the ticket here after
submitting the issue.

Ciao, Thorsten
