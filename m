Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F48DF55123
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 14:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B64210E271;
	Sun,  5 Apr 2026 14:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="Rt4tEmCh";
	dkim-atps=neutral
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 830DB10E271;
 Sun,  5 Apr 2026 14:05:53 +0000 (UTC)
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
 by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4fpZ3t5N18z3y0c;
 Sun,  5 Apr 2026 16:05:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1775397930;
 bh=jQet2Faqu/SfiaQVBlH92dqcmVEQXnUI0ztUimFNtU4=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=Rt4tEmChuTXhDzaIUMowBAMGEQ3AOYYVxFJfcVruf0Pp+vjIgUFG05gl17+qj26/v
 aESucPxTPGr6/128AfxA1qjmiczIDlZYwA0ibnLKZX06U7UeSwyhOuqcgHoD4wxc0E
 mxZLh6Gjx1EJccHX3oScuu6gB5hv5lKNTasgE3kdhW8U0OLKvJ5Mz6J4ZMAkA0swij
 PhYazk4Q40uOMTgeJ8BwZBU2zbAbbvuyWbgtm7yu+rOfCD0JG7p388GgFoPdSLGleB
 TeKtEYYyjExZQTaVZSrDej9IjyKWaeWppog941k4qIGlh7PlDZeEynV8I5n/quDoI1
 1NraFAAJ6Fpww==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4fpZ3t4bQGz3xxZ;
 Sun,  5 Apr 2026 16:05:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4fpZ3s3LZ7z8sZl;
 Sun,  5 Apr 2026 16:05:29 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 633A1632E2;
 Sun,  5 Apr 2026 16:05:28 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <aae00041-805f-4a05-a142-1bbf7027e8aa@leemhuis.info>
Date: Sun, 5 Apr 2026 16:05:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression fix for audio issues with pre-DCN401 chips
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 airlied@gmail.com, simona.vetter@ffwll.ch,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexdeucher@gmail.com>
References: <20260401184456.3576660-1-alexander.deucher@amd.com>
 <47c508c3-3424-4e8a-a63c-1f29d13b6ebe@leemhuis.info>
 <CADnq5_MiFOYLP9aUnYw4HFb-xWLZdq245ZB3e6iGn09ywOsY2w@mail.gmail.com>
 <CAHk-=wiNdTNNxzRuxXYq1Ebpiv6YF4UMZApoQGnktbMjKFYP+w@mail.gmail.com>
 <7030db14-ebd5-4652-9301-b9c8bec441a8@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <7030db14-ebd5-4652-9301-b9c8bec441a8@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177539792876.2771324.15287198715894626686@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 633A1632E2
X-NC-CID: iqAdRmPqyAza5dTS3yUUWDo8cevY9eAU5YWUjEXlW4QLs3fVa4I=
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

On 4/5/26 16:02, Thorsten Leemhuis wrote:
> On 4/2/26 21:01, Linus Torvalds wrote:
>> On Thu, 2 Apr 2026 at 11:27, Alex Deucher <alexdeucher@gmail.com> wrote:
>>> There are always new fixes.  Worse case it ends up in 7.0.1.  If it
>>> causes other regressions, then we end up introducing a new regression
>>> in rc7.
>> This was a regression in rc1, that was reported several weeks ago.
>> Anything that gets reported that early in the release cycle is bound
>> to hit lots of people, because the number of people testing early rc
>> kernels is relatively small.
>>
>> So why pointlessly delay *known* regressions for fear of a potential new one?
>>
>> And why point out rc7, when dammit, this could have been fixed long
>> before and *not* be that late in the release? [...]
> 
> Thx for jumping in there. While at it: I see situations like this all
> the time (I'll reply to this mail with a few current examples), [...]
FWIW, here are a few examples from the report I sent earlier this week
(a fix for one regression mentioned there hit your tree yesterday; a fix
for another is in a PR Greg sent today). All of the following had fixes
on the list or even in -next a week ago for -rc6:

##################################################################
Regressions introduced in -rc1 stage and known for two weeks or more

------------------------------------------------------------------
 ARM: dts: imx: Colibri iMX6ULL and Colibri iMX7 no longer boot
https://lore.kernel.org/lkml/20260219151157.2549198-1-max.oss.09@gmail.com/
known for 6 weeks, caused by 8124b4a4a96b (v7.0-rc1)

  Fix is bccaf98c1077f2 ("Revert "ARM: dts: imx: move nand related
property under nand@0"") [next-20260318 (pending-fixes)] aka https://
lore.kernel.org/lkml/20260219151157.2549198-1-max.oss.09@gmail.com/

------------------------------------------------------------------
  PCI: problems with Nvidia P40 24GB or eGPU's
https://bugzilla.kernel.org/show_bug.cgi?id=221205
https://lore.kernel.org/all/a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com/
known for 22 days, caused by 3958bf16e2fe (v7.0-rc1 as well as v6.19.4,
v6.18.14)

  Fix is 9036bd0efcb616 ("PCI: Align head space better") [next-20260331,
afaics targeted for 7.1], which is 09/10 of a series:
https://lore.kernel.org/all/20260324165633.4583-10-ilpo.jarvinen@linux.intel.com/

------------------------------------------------------------------
  drm/msm/dpu: pink noise on the screen
https://lore.kernel.org/lkml/DH1IKLU0YZYU.2SW4WYO7H3H4R@fairphone.com/
known for 19 days, caused by 2892de3f4f98 (v7.0-rc1)

  Fix is b9699dd862760e ("drm/msm/dpu: don't try using 2 LMs if only one
DSC is available") [next-20260325] aka
https://lore.kernel.org/lkml/20260317-fix-3d-dsc-
v1-1-88b54f62f659@oss.qualcomm.com/

------------------------------------------------------------------
  ceph: writeback can lead to a panic
https://lore.kernel.org/lkml/20260315232500.251088-1-CFSworks@gmail.com/
known for 16 days, caused by cac190c7674f (v7.0-rc1)

  Fix is 681a6d350eff10 ("ceph: fix num_ops off-by-one when crypto
allocation fails") [next-20260320, might target 7.1] aka
https://lore.kernel.org/all/20260318023733.116789-1-CFSworks@gmail.com/

##################################################################

Regressions introduced post-rc1

------------------------------------------------------------------
  HID: core: GPD Win5 handhelds stopped working
https://bugzilla.kernel.org/show_bug.cgi?id=221271
Known for 13 days, caused by 0a3fe972a7cb (v7.0-rc5)

  Fix is  9e2a17d2e8088f ("HID: gpd: fix report descriptor on GPD Win
handheld (2f24:0137)") [next-20260403] aka
https://lore.kernel.org/all/20260324013847.68024-1-honjow311@gmail.com/


##################################################################

Bonus: I'm not on-top of regressions from earlier cycles (sorry!), but I
know there are at least two that have fixes available for at least a
week, too:

------------------------------------------------------------------
2c10400e4a2332 ("media: ipu-bridge: Add upside-down sensor DMI quirk for
Dell XPS 13 9340 and XPS 14 9440") [next-20260311] aka
https://lore.kernel.org/all/20260225203058.40545-2-johannes.goede@oss.qualcomm.com/

It looks like this is heading towards 7.1:
https://lore.kernel.org/all/abAgZWlNRTIDMFda@valkosipuli.retiisi.eu/

------------------------------------------------------------------
wifi: ath12k: prepare REO update element only for primary link --
https://lore.kernel.org/all/20260210-ath12k-rxtid-double-free-v1-1-8b523fb2886d@oss.qualcomm.com/
-- sitting on the list since 2026-02-10

------------------------------------------------------------------

