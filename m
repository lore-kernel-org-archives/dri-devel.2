Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0191CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735E510F48D;
	Fri, 26 Jun 2026 07:53:45 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0FDD10E1C3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:21:21 +0000 (UTC)
X-UUID: 99c25ac0707f11f1aa26b74ffac11d73-20260625
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:0080bd47-685c-4fc7-9089-0ad4c452358a, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:10
X-CID-INFO: VERSION:1.3.12, REQID:0080bd47-685c-4fc7-9089-0ad4c452358a, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:10
X-CID-META: VersionHash:e7bac3a, CLOUDID:429edb8e878399609e86c16f6629f87f,
 BulkI
 D:260624112706YSGBNPCQ,BulkQuantity:7,Recheck:0,SF:17|19|38|64|66|78|80|81
 |82|83|102|127|841|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:
 nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:
 0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 99c25ac0707f11f1aa26b74ffac11d73-20260625
X-User: lihongfu@kylinos.cn
Received: from [192.168.109.123] [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <lihongfu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
 with ESMTP id 1977568665; Thu, 25 Jun 2026 18:21:16 +0800
Message-ID: <c645a8df-1d76-4e4d-bb97-47c539f7a205@kylinos.cn>
Date: Thu, 25 Jun 2026 18:21:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup/dmem: add per-region event counters
To: Natalie Vock <natalie.vock@gmx.de>, tj@kernel.org
Cc: cgroups@vger.kernel.org, corbet@lwn.net, dev@lankhorst.se,
 dri-devel@lists.freedesktop.org, hannes@cmpxchg.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mkoutny@suse.com,
 mripard@kernel.org, skhan@linuxfoundation.org, hongfu.li@linux.dev
References: <ajwnf0uzT4PMHYZx@slm.duckdns.org>
 <20260625021053.488107-1-lihongfu@kylinos.cn>
 <b549422c-7c35-434d-ad4a-49a4676970ac@gmx.de>
From: Hongfu Li <lihongfu@kylinos.cn>
In-Reply-To: <b549422c-7c35-434d-ad4a-49a4676970ac@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

On 6/25/26 4:57 PM, Natalie Vock wrote:
> Hi,
>
> On 6/25/26 04:10, Hongfu Li wrote:
>> Hi, Tejun
>> Thanks for the review comments.
>>
>>>> Add dmem.events to report hierarchical low/max event counts per DMEM
>>>> region.  Increment counters on dmem.max allocation failures and
>>>> dmem.low protection events.  The file is available for non-root 
>>>> cgroups
>>>> only.
>>>
>>> Please don't double space in descs or comments. Also, maybe it's 
>>> obvious but
>>> it'd help if you list why and how this is useful. Why do we want to add
>>> this?
>>
>> I'll fix the double spacing in the commit message and comments.
>>
>> As for the motivation: dmem already exposes per-region limits and 
>> current
>> usage, but not how often those limits actually matter at runtime. 
>> Without
>> event counters, it's hard to tell whether allocation failures come from
>> this cgroup, a parent limit, or pressure elsewhere in the hierarchy.
>> dmem.events provides that visibility for tuning dmem.low/dmem.max and
>> diagnosing recurring device memory pressure.
>
> Shouldn't you be able to deduce this rather trivially from just 
> looking at the current usage together with the low/max limits you 
> already set? I'm not sure I really see anything this events file 
> provides that analysis of current usage and set limits doesn't? If 
> your usage is highly variable, the separately-developed dmem.peak file 
> might also suit your needs, but still, not sure what you can do with 
> dmem.events that you can't already do with these tools. 
Thanks for the question.

Besides exposing counters, dmem.events notifies userspace on changes via
cgroup_file_notify(). This allows tools to monitor limit-related events
(for example, allocation failures or low-protection fallbacks) 
asynchronously,
without the need to periodically poll dmem.current against the limits. 
While
you could infer some conditions from current usage and limits, polling is
inefficient and cannot capture transient events in real time. dmem.peak only
records the highest usage, not these specific events.

So dmem.events provides both lower overhead and richer, actionable 
information.

Best regards,
Hongfu



