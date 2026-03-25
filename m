Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F1E109C04D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 17:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2C08949C;
	Wed, 25 Mar 2026 17:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="eZKHiMpN";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDCCD8949C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1774460441;
 bh=hj3o3G9XhkwMqaTKh0AJYwv6VWqb3tJ8NSmdRt1luSY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eZKHiMpNpcPIBahNXtzhZb5u11e7BXyJac+OoEP9JjHLFsZUJor4xTsiRBdJldpcG
 JxkZTFskDnDfdzUMU4YThMBSUhQ3dYKVkk1+VDvALuUS3jtDdRafU4PKhDcYYRvrYX
 qRN3wutLAHfplDWP1dZcuXKpirZ3cYgzno0AR2od31PKg9wZa8axtErRUtj7WtxZEX
 FkO35/mJ5YaSigo8jriGUSkzxGU8pVzQ2zPTc+bNc7RLPhxBGdcWCmo7EA1FTcqN7I
 7w2SB0wcD0MwoMMiFZIQUz3ixnz2ae1QPK1cQybgWhFVcI/bGh7fr/MMg9vg92e1Yl
 SUucGB9dfxchw==
Message-ID: <f1edec8a-f446-4fdc-b39b-1dbb690ff57e@lankhorst.se>
Date: Wed, 25 Mar 2026 18:40:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] cgroup/dmem: allow atomic irrestrictive writes to
 dmem.max
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
 <b099d9248df084fed8d4252e3c6fc485@kernel.org>
 <88f89d75-1e1f-4457-8c1f-57e934c251cc@lankhorst.se>
 <acF6PMV-aezq3dWc@quatroqueijos.cascardo.eti.br>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <acF6PMV-aezq3dWc@quatroqueijos.cascardo.eti.br>
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

Hey,

Den 2026-03-23 kl. 18:37, skrev Thadeu Lima de Souza Cascardo:
> On Mon, Mar 23, 2026 at 05:46:28PM +0100, Maarten Lankhorst wrote:
>> Hey,
>>
>>
>> Den 2026-03-21 kl. 20:27, skrev Tejun Heo:
>>> Hello,
>>>
>>> Generally looks okay to me. One comment on 3/3 — the naked xchg() in
>>> set_resource_max() needs a comment explaining why it's used instead of
>>> page_counter_set_max() and what the semantics are (unconditionally sets max
>>> regardless of current usage to prevent further allocations, since there's no
>>> eviction mechanism yet).
>>>
>>> Applied 1/3. Maarten, Michal, what do you think?
>>
>> Yeah probably drop 2/3 too since there is no longer a case where setting a limit may fail.
>>
>> Kind regards,
>> ~Maarten Lankhorst
> 
> Actually, this can still happen if an invalid region name is given.
> 
> So, one could write:
> 
> echo -e 'region1 max\ninvalidregion2 max\n' > dmem.max
> 
> And even though setting the value for region1 would be applied, the write
> would return -EINVAL.

Makes sense. It would be good to validate in advance then. If that's not possible we
should at least not error when we try to update 2 regions simultaneously. Likely the
best to do so anyway if we want to handle eviction, which may be handled in a blocking
fashion.

Kind regards,
~Maarten Lankhorst
