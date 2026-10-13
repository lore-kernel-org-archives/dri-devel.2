Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37743CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87BD810E784;
	Tue, 13 Oct 2026 10:32:05 +0000 (UTC)
X-Greylist: delayed 362 seconds by postgrey-1.36 at gabe;
 Tue, 13 Oct 2026 10:32:03 UTC
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D4810E797
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:32:03 +0000 (UTC)
Received: from [10.70.30.207] (222-230-65-153.east.xps.vectant.ne.jp
 [222.230.65.153])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by psionic.psi5.com (Postfix) with ESMTPSA id 47D213F11B;
 Tue, 13 Oct 2026 12:25:58 +0200 (CEST)
Message-ID: <e0e28e53-4fb9-42d4-9641-af8ea69745a8@hogyros.de>
Date: Tue, 13 Oct 2026 19:25:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/hwmon: refresh Battlemage thermal telemetry under
 force-wake
To: cch@e-psn.eu
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <5b9625f2276630e1c8822c89c8f6288b@e-psn.eu>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <5b9625f2276630e1c8822c89c8f6288b@e-psn.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 10/13/26 2:39 PM, Constantinos Chalkias wrote:

> For some context, I started investigating this because my Maxsun Arc Pro 
> B70 would latch the blower at very high speed after a long inference 
> workload and leave it there even when the node was otherwise idle.

Yes, that is because the loop polling the pkg sensor for some reason 
stops while no client is connected, but it can be triggered once by some 
other events, such as changing forcewake state, or monitor hotplug.

So I have a background task running that just does

     while true
     do
         sleep 5 >forcewake_all
         sleep 5
     done

and I get working fan control, regardless of whether I'm also polling 
the sensors.

> With a 500-1000 us settling interval, the package-only workaround was 
> not reliable. The physical blower could remain latched at high speed for 
> several minutes after the workload ended.

It works if the pulse is long enough to be noticed. If you send multiple 
pulses (because you are reading multiple sensors in turn) with only 
brief pauses in between, you're generating a longer pulse that has a 
higher chance of being noticed.

I'd bet it would also work to just assert forcewake for 10 ms instead of 
ten shorter intervals, so we can use a timer here to asynchronously 
reset instead of synchronously waiting in the hwmon readout -- we're not 
getting fresh values here anyway, because the loop has not woken up yet.

The real solution, of course, would be a firmware fix.

    Simon
