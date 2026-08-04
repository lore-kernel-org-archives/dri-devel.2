Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD892C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA0A10E115;
	Tue,  4 Aug 2026 07:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="A9h45/RL";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C54210E115;
 Tue,  4 Aug 2026 07:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785827032; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YKEegjnpuSmHTOcRrWivKsOOzbbB08CCOj0SkP66xgoeeRUDl4q9qX6KRyJ0P/O/Uc0DTK7/ztOr0Vxbn5M44/apLUHVMNQY0auPY4V0BhCHSXE0P2lmLw3KHoVgQeWb+VrCU5JolVPMLXQAaQu6oB7q9hQo99tVRkiBJyU0Gq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785827032;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LgTqR8hX+MSPNZK1/ZnmYeT+jeK9oY4pjRChRQ3k7rU=; 
 b=DlFR7UTuyweWfc4n6G0VU5nhbzBuvVJoJxdEq3NvQgkAjIzPvzjFih1narD93mJh0yCmFOHN8yKnLk4ejqmRIfWAT3TNRUXYybNAlC5EpxiT9ts+TP/DvAcfUevdW8S0h26rXBKGdl7JgZ2kW0HuqdQtL9Y52gH6pokz8nge/6Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785827032; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=LgTqR8hX+MSPNZK1/ZnmYeT+jeK9oY4pjRChRQ3k7rU=;
 b=A9h45/RLAnHcnEGuDcLxNPHwcp1TGklEP6xwpHZW9svKcRED3hZD6gdBwEtkSHsw
 oHg67mvHF2W6vbAKEP+cM+xvavZ7QP6GBcTwyfNg8IEDe/xxQFrH9ihYe7GkG6gekNr
 cvmMrcU6d5InLRWQZ24+iaopqdaIXsSUaIFergx8=
Received: by mx.zohomail.com with SMTPS id 1785827030764705.228708125434;
 Tue, 4 Aug 2026 00:03:50 -0700 (PDT)
Message-ID: <c6c0e544-5a19-4ca1-b113-c085bab0c967@collabora.com>
Date: Tue, 4 Aug 2026 09:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udmabuf: vastly increase the size limit per dmabuf
To: Xaver Hugl <xaver.hugl@kde.org>
Cc: dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 kraxel@redhat.com, stable@vger.kernel.org, vivek.kasireddy@intel.com
References: <20260803144120.11524-1-xaver.hugl@kde.org>
 <2353697f-b1da-495a-b043-7a81d875856e@collabora.com>
 <CAFZQkGyfDwjPuciiOvZM3Ha8Xj+YkgkMaveHZtBK2w_S+Z+Vcw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <CAFZQkGyfDwjPuciiOvZM3Ha8Xj+YkgkMaveHZtBK2w_S+Z+Vcw@mail.gmail.com>
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

Vivek (thanks!) just pulled the patch into drm-misc-next / 
for-linux-next so it should go into 7.3 \o/

On 03.08.26 17:04, Xaver Hugl wrote:
> Oh, nice! I should've checked the list before making a patch :D
>
> Could your commit also be backported to stable? I fear I'll need to
> find ways to work around this or disable the relevant optimizations in
> KWin on older kernels either way, but it would be great if that could
> at least be a very temporary problem.

I'm not sure how realistic that is / how the policies around such 
changes are - there shouldn't be any serious risk of regressions, but 
who knows.

OTOH there are several other options AFAICS:

1. affected distros could backport the patch or set a higher limit via 
kernel command line

2. kwin could try to check the size 
(`/sys/module/udmabuf/parameters/size_limit_mb`) and disallow the code 
path if the required buffer size exceeds it (or just have a fallback in 
place whenever allocation fails)

Arguably having a working fallback path were possible would be good 
style either way - would it be a big effort to do so in kwin?

Best regards

>
> - Xaver

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

