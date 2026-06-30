Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65460C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 21:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 985F510E262;
	Tue, 30 Jun 2026 21:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="ne1obNUa";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10ACD10E262
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 21:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782853501;
 bh=+cbhdqNensUJxiX/smKQ0OfprDwHcpCabVotqLwQDkA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ne1obNUaObnlr8ZmJZyL/XaSJfHHSMdoCLb2zySqY5GgBqLhShRTbZ7azjMIsEVSn
 JVY8b6UBcoV/NkooefXk0k4DvPqO4fX3eeV2ehXwZ7MrQrLQj0HwDALvgtkVRpOdE0
 lssdyQewQk0QxfO9t//7NsAfkhhPxMdxI0D9pVtO7JghfO2nKxn60FLD+RVNm37sNO
 4O5Jb3I1kddyOtT3UntjptZ00khZP1aKOJN5duvLD1koAhVKHJlNc/dEstzDA6hcvn
 +kIdQTzTE1Pu57xcPFK+zUvS3diNJ7bv/JNsvl+GeE6+6/th5KTAO98Fwe2Fn0eu5f
 rDXM5MZOpOIcA==
Message-ID: <2021ac83-3f17-4a77-94ec-5156618c00fe@lankhorst.se>
Date: Tue, 30 Jun 2026 23:05:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup/dmem: add per-region event counters
To: Hongfu Li <lihongfu@kylinos.cn>, Natalie Vock <natalie.vock@gmx.de>,
 tj@kernel.org
Cc: cgroups@vger.kernel.org, corbet@lwn.net, dri-devel@lists.freedesktop.org, 
 hannes@cmpxchg.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mkoutny@suse.com, mripard@kernel.org, skhan@linuxfoundation.org,
 hongfu.li@linux.dev
References: <ajwnf0uzT4PMHYZx@slm.duckdns.org>
 <20260625021053.488107-1-lihongfu@kylinos.cn>
 <b549422c-7c35-434d-ad4a-49a4676970ac@gmx.de>
 <c645a8df-1d76-4e4d-bb97-47c539f7a205@kylinos.cn>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <c645a8df-1d76-4e4d-bb97-47c539f7a205@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hello,

On 6/25/26 12:21, Hongfu Li wrote:
> Hi,
> 
> On 6/25/26 4:57 PM, Natalie Vock wrote:
>> Hi,
>>
>> On 6/25/26 04:10, Hongfu Li wrote:
>>> Hi, Tejun
>>> Thanks for the review comments.
>>>
>>>>> Add dmem.events to report hierarchical low/max event counts per DMEM
>>>>> region.  Increment counters on dmem.max allocation failures and
>>>>> dmem.low protection events.  The file is available for non-root cgroups
>>>>> only.
>>>>
>>>> Please don't double space in descs or comments. Also, maybe it's obvious but
>>>> it'd help if you list why and how this is useful. Why do we want to add
>>>> this?
>>>
>>> I'll fix the double spacing in the commit message and comments.
>>>
>>> As for the motivation: dmem already exposes per-region limits and current
>>> usage, but not how often those limits actually matter at runtime. Without
>>> event counters, it's hard to tell whether allocation failures come from
>>> this cgroup, a parent limit, or pressure elsewhere in the hierarchy.
>>> dmem.events provides that visibility for tuning dmem.low/dmem.max and
>>> diagnosing recurring device memory pressure.
>>
>> Shouldn't you be able to deduce this rather trivially from just looking at the current usage together with the low/max limits you already set? I'm not sure I really see anything this events file provides that analysis of current usage and set limits doesn't? If your usage is highly variable, the separately-developed dmem.peak file might also suit your needs, but still, not sure what you can do with dmem.events that you can't already do with these tools. 
> Thanks for the question.
> 
> Besides exposing counters, dmem.events notifies userspace on changes via
> cgroup_file_notify(). This allows tools to monitor limit-related events
> (for example, allocation failures or low-protection fallbacks) asynchronously,
> without the need to periodically poll dmem.current against the limits. While
> you could infer some conditions from current usage and limits, polling is
> inefficient and cannot capture transient events in real time. dmem.peak only
> records the highest usage, not these specific events.
> 
> So dmem.events provides both lower overhead and richer, actionable information.

Agreed, they're separate but both useful.

The peak tells you what the maximum memory consumption is.
The events are sent when a limit is reached, but more will also count how often limit is reached and reclaim needs to happen.

So if you have 4 cgroups, and 1 of them sends a lot of events, that tells you that you may want
to increase that cgroup's limits dynamically to have a more performant system.

Kind regards,
~Maarten Lankhorst
