Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2328DC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE0F10E0C3;
	Thu,  3 Sep 2026 08:24:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="UmxLU3+0";
	dkim-atps=neutral
X-Greylist: delayed 1802 seconds by postgrey-1.36 at gabe;
 Thu, 03 Sep 2026 08:24:00 UTC
Received: from mta0.migadu.com (out-9.mta0.migadu.com [91.218.175.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A70F710E0C3
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:24:00 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=imCkeXbS8TdnEfLcrGpGKahoCmkpvuvbQG4Dqv/gX6E=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788423838; v=1; x=1789028638;
 b=UmxLU3+0b3lHJK31JVywtkGJDYNDU0Amrhu+u5yuH7LVB6QUGTlcu33IuWXGEOUTLJBbaC8e
 AUpQRUFxCSUigKQETgxwrhIc0t2d3e+pOvwHj3DvwxTJmwFt1vgeYKI9JLBhRyBCMrCl4Yg6ycx
 UffsO97HBIyqxEU1hGzVapzI=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 5c9fc66824390f15;
 Thu, 03 Sep 2026 07:47:52 +0000
X-Mizu-Trace-ID: 5c9fc66824390f15
X-Migadu-Flow: FLOW_OUT
Message-ID: <e046eddf-3c2b-42a9-b201-c919ebb217ac@linux.dev>
Date: Thu, 3 Sep 2026 13:17:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS, mailmap: use Aditya Garg's linux.dev account
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Aditya Garg <gargaditya08@proton.me>
Cc: Aditya Garg <aditya.garg@linux.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260723100136.14467-1-aditya.garg@linux.dev>
 <27a31a37-688d-427b-a0ba-c3133db19c97@suse.de>
 <txsiv43u7qv-Pc_dRDdbgiUHVP54rhl5g-xLzQU457o0E29MYkL9FX-zdozYxVySvTed10VduLizWQw3zNDJTGxTIfFLX71G3U_Kj3qnJao=@proton.me>
 <47df26aa-a160-4306-84f0-510584c3e8e0@suse.de>
Content-Language: en-US
From: Aditya Garg <aditya.garg@linux.dev>
In-Reply-To: <47df26aa-a160-4306-84f0-510584c3e8e0@suse.de>
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



On 9/3/26 1:16 PM, Thomas Zimmermann wrote:
> Hi
> 
> Am 03.09.26 um 08:57 schrieb Aditya Garg:
>> Hi
>>
>>> Am 23.07.26 um 12:01 schrieb Aditya Garg:
>>>> From: Aditya Garg <gargaditya08@live.com>
>>>>
>>>> Due to non standard IMAP and SMTP protocols by Proton Mail, the account
>>>> was giving trouble. Since my linux.dev account has been approved, all
>>>> communication related to Linux development shall now be done there.
>>>>
>>>> Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
>>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Can someone please merge this. I am still receiving mails on my old email which I do not use for dev work anymore.
> 
> Done now. The update will go out with the next drm-misc-fixes.

Thanks a lot
> 
> Best regards
> Thomas
> 
>>
>>>> ---
>>>>    .mailmap    | 3 ++-
>>>>    MAINTAINERS | 2 +-
>>>>    2 files changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/.mailmap b/.mailmap
>>>> index 501d858cb..baea6ba4d 100644
>>>> --- a/.mailmap
>>>> +++ b/.mailmap
>>>> @@ -19,7 +19,8 @@ Abhinav Kumar <quic_abhinavk@quicinc.com> <abhinavk@codeaurora.org>
>>>>    Ahmad Masri <quic_amasri@quicinc.com> <amasri@codeaurora.org>
>>>>    Adam Oldham <oldhamca@gmail.com>
>>>>    Adam Radford <aradford@gmail.com>
>>>> -Aditya Garg <gargaditya08@proton.me> <gargaditya08@live.com>
>>>> +Aditya Garg <aditya.garg@linux.dev> <gargaditya08@live.com>
>>>> +Aditya Garg <aditya.garg@linux.dev> <gargaditya08@proton.me>
>>>>    Adriana Reus <adi.reus@gmail.com> <adriana.reus@intel.com>
>>>>    Adrian Bunk <bunk@stusta.de>
>>>>    Ajay Kaher <ajay.kaher@broadcom.com> <akaher@vmware.com>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 1ab873685..f32e63428 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -7970,7 +7970,7 @@ F:    drivers/gpu/drm/sun4i/sun8i*
>>>>
>>>>    DRM DRIVER FOR APPLE TOUCH BARS
>>>>    M:    Aun-Ali Zaidi <admin@kodeit.net>
>>>> -M:    Aditya Garg <gargaditya08@proton.me>
>>>> +M:    Aditya Garg <aditya.garg@linux.dev>
>>>>    L:    dri-devel@lists.freedesktop.org
>>>>    S:    Maintained
>>>>    T:    git https://gitlab.freedesktop.org/drm/misc/kernel.git
>>> -- 
>>> -- 
>>> Thomas Zimmermann
>>> Graphics Driver Developer
>>> SUSE Software Solutions Germany GmbH
>>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>>> GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)
> 

