Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8ADCD4F5E
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 05:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD3310EEEC;
	Wed, 20 May 2026 05:38:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=packett.cool header.i=@packett.cool header.b="QjFgm1Ki";
	dkim-atps=neutral
X-Greylist: delayed 431 seconds by postgrey-1.36 at gabe;
 Wed, 20 May 2026 05:38:46 UTC
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com
 [91.218.175.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA4210EEEC
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 05:38:46 +0000 (UTC)
Message-ID: <60643a0c-23cd-4622-9538-1ba91a839b16@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
 s=key1; t=1779255092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGYoIE75gOLv11YOsjTlE0cTLYpybGxsyImlheTdOOE=;
 b=QjFgm1Kid3HP1UE8ktDdvXmlZXmJlFoW0YNVS57YR+Tp+Do8ULmqJ6MMEKzfm+oCPkOTIH
 WXBB/xRshD0VrEbWa4FKBWZLE+ZVIf8psnawrUwbntSZcf+cwJz2O50p3fTeRg0trIILmx
 a5y75KSXa2hdTgk5HIF/dVRH6PPqRu5yFSYH6aXq2NU32X2ef4YGQn77EeNNAc+NDEY9Cf
 WV5LCsCWaATRnnUvKsXF4LSolvOpelsz2PvmP/kWy5558smiOfLm6Z9NlApdMIXTpWYvXY
 AmRUvqNUmzBo3fEXaExA72KbPt4eo6+PJqkqCAPtXgYK8BrinmyKmv5ymiVI0w==
Date: Wed, 20 May 2026 02:31:25 -0300
MIME-Version: 1.0
Subject: Re: [BUG] drm/msm: WW mutex self-deadlock in msm_gem_shrinker via
 direct reclaim from msm_gem_fault
To: Kendell <linux@kendell.dev>, freedreno@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <492340a5-5894-475b-acd5-6c6b6b32c706@app.fastmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <492340a5-5894-475b-acd5-6c6b6b32c706@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

On 5/17/26 1:25 PM, Kendell wrote:

> Hi,
>
> I've hit a full GPU deadlock on Snapdragon X1E running the Zed editor.
> The shrinker self-deadlocks when msm_gem_fault() triggers direct reclaim
> while holding the VM's dma_resv.
> […]
> - Bug report assisted by Kimi K2.6 (language model).

Instead of firing up the slop machine, you could've searched for 
"shrinker" on https://lore.kernel.org/all/ ..

https://lore.kernel.org/all/20260508065722.18785-1-daniel@quora.org/

https://lore.kernel.org/all/20260518-panthor-shrinker-fixes-v4-1-1920234470d5@collabora.com/

These have just landed in linux-next btw.


~val

