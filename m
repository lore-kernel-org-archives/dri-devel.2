Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D2EC5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A4310E49A;
	Sun, 23 Aug 2026 09:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=accessweb.be header.i=@accessweb.be header.b="wF12fRJw";
	dkim-atps=neutral
Received: from pan.awservers.eu (pan.awservers.eu [149.202.17.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A26BE10E226
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 13:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=accessweb.be; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t6kLtiPUQdGFVlHiC0dIyTk+1CRlcDej5nLfbQq7DU8=; b=wF12fRJwGE56vhRxQryVwvOYu6
 nK3X7SxPSRwa5WFV3e3LA97X52ikMjQDdbDs1i2RBvMB6ON9A3JiJZrsXpkfRWZW9dj5xOdWMGrRm
 qa/5TSoXP5Xk+XiCebgQn6sOGaO5jPYz30vC6LRJHXShsAydCpP7drx4D9OlLdaOy34H7XgVt6EBR
 5NcQJSjO+Iic69ijmZU5T58FxhcY3VYhvFLbkqxH1jhabYl0Odgzg+7jmolyKj7GxdVIQeRKMzOXB
 lFfUHHiHKV7EPrNHfxKZ/iZpwUqJg+J/1CKbB5CX68UvklmvkeeiJm1nCM7cDAo+DAhCtHSX1gZBH
 MteUYIOA==;
Received: from [195.240.176.17] (port=59206 helo=[192.168.2.230])
 by pan.awservers.eu with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.5) (envelope-from <jellis@accessweb.be>)
 id 1wxOYt-0000000DDxf-1Zeo; Fri, 21 Aug 2026 14:41:30 +0200
Message-ID: <dc43e4ee-45b9-411e-9aba-956cec109057@accessweb.be>
Date: Fri, 21 Aug 2026 14:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/vmwgfx: graphics memory not returned,after all GEM objects
 are released
To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>, zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com
References: <66c0b5db-bea1-4608-be8f-bae437760d97@accessweb.be>
 <9ad23800-db89-48f2-a960-6c2fa11ee6d5@broadcom.com>
 <363bcf88-1f13-46c0-9dbc-aa21102ab397@accessweb.be>
 <55b08fb3-cc29-4c2a-bbe5-26742de77614@broadcom.com>
 <b0b0caf9-ca76-4f93-9495-d386d313fad1@accessweb.be>
 <7af1cbb9-bb99-462c-a3e4-c70d8fbd2dcb@broadcom.com>
Content-Language: en-US
From: Jellis Onsea | AccessWeb <jellis@accessweb.be>
In-Reply-To: <7af1cbb9-bb99-462c-a3e4-c70d8fbd2dcb@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - pan.awservers.eu
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - accessweb.be
X-Get-Message-Sender-Via: pan.awservers.eu: authenticated_id:
 jellis@accessweb.be
X-Authenticated-Sender: pan.awservers.eu: jellis@accessweb.be
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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

Hi Maaz,

Updated today: mesa 26.2.1, and the kernel went 7.1.8 -> 7.2.0 in the 
same batch. 3D enabled, renderer is SVGA3D, vmwgfx reports 2.21.0.0.

The surface warning still fires, four times during session startup:

   vmwgfx 0000:00:0f.0: [drm] User surface fd 157 (handle 49) is null.
   !user_srf
   WARNING: drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:958 at
   vmw_surface_handle_reference+0x297/0x320 [vmwgfx], CPU#2: 
kwin_wayland/4631

Not new - we have had it since 12 July - but it survives your fix.

Leak numbers will take a few days. I have no usable baseline on 26.2.0: 
the machine was mostly idle before the update - 27 of the last 42 hours 
were completely flat - and growth here follows render load, not uptime. 
Quoting a rate from that would be a startup curve, not a leak.

An intensive work period starts today, so I will send numbers from that, 
with the caveat that mesa and the kernel changed in the same update.

I have not tried your dri-devel scanout patch yet - we run distribution 
kernels here. Say if you want us to build it.

On the emails: you are right. English is not my first language so I use 
an LLM to write them. I will try to keep them short from now on.


Best regards,
Jellis

Op 21-08-2026 om 04:09 schreef Maaz Mombasawala:
> For the 3D-enabled case, could you try with mesa 26.1.8 or 26.2.1, both of which contain my fix.
> Also if you could try the patch I just submitted on dri-devel - drm/vmwgfx: Return gem fd handle for scanout buffers.
> If you still see issues with these patches, let me know.
> 
> As for the 3D disabled case, I can see issues on my local machine and am working on a fix.
> 
> PS - Your emails are overly verbose and narrative, could you include only the actual problems you are facing.
> If you're using an llm to write these, please make them more terse and human readable. Thanks.
> 


