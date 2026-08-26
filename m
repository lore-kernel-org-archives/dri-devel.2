Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B96C61DCB
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B9F410EF7E;
	Thu, 27 Aug 2026 09:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=accessweb.be header.i=@accessweb.be header.b="wd4KNHQh";
	dkim-atps=neutral
Received: from pan.awservers.eu (pan.awservers.eu [149.202.17.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA9B10E27F
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=accessweb.be; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5kr6ONTZGcP+4gzhwJRzM9uYj1wLi4Mt58RL8rHvwjE=; b=wd4KNHQhIgO1isylHY1q0VA+CZ
 h1fX4oTNTTCAeEPUWqpdT0p9ffQdOImHi3kyK8yWHwcis7nitikxgz3xHnsSDXSi4nDA0tflEVZeT
 ZbTo5mibht4GdbMvTsQUMR5NjK04wB/xbtU1Y/jDAT/Zl7xGN3rwBYLXDYwVGArxrAV8qKzM1P2bb
 xvitSHBts8osJL+wzwRNuk4OGw6G1OP4MiyAW0J2AR+e4CCGLk6M/0lkd+s/49TTB0D9qbe6wmSWC
 +mnAAPr2ASeeg80nFsJU6zDkFk2lNBF6Jkp7DReR/FGw8K4/YSSRwShBA7FdVu+NcgbVc/jUKxP1x
 gh/wPoGg==;
Received: from [195.240.176.17] (port=38760 helo=[192.168.2.230])
 by pan.awservers.eu with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.5) (envelope-from <jellis@accessweb.be>)
 id 1wzERk-00000008H1j-0yMO; Wed, 26 Aug 2026 16:17:44 +0200
Message-ID: <5d110271-9a0d-4ba7-92e9-286ba557c16e@accessweb.be>
Date: Wed, 26 Aug 2026 16:17:43 +0200
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
X-Mailman-Approved-At: Thu, 27 Aug 2026 09:44:45 +0000
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

Short version: mesa 26.2.1 is running here with 3D on, and the leak is 
still there.

Setup: one boot, 119 h, a single kwin_wayland (6.7.4), mesa 3:26.2.1-1, 
kernel 7.2.0, renderer SVGA3D.

   TTM sys+mob    0.36 -> 16.73 GB
   objects        1948 -> 10365
   kwin_wayland   holds 8484 MB in 4894 objects
   free RAM       4.9 of 31 GB - we have to reboot today

It tracks rendering, not uptime. Idle nights (02:00-07:00) in this same 
boot:

   22 Aug  -0.03 GB       25 Aug  +0.00 GB
   23 Aug  +0.02 GB       26 Aug  +0.04 GB
   24 Aug  +1.88 GB   <- the one night an automated GUI test run was active

The surface warning still fires: 1168 WARNING blocks at 
vmw_surface_handle_reference in the last 27 hours. That is a window, not 
a total - journald has already rotated away the earlier part of this boot.

Correction to my previous mail: "four times during session startup" was 
wrong. It fires in bursts throughout the session.

We have not tried "drm/vmwgfx: Return gem fd handle for scanout buffers" 
we run distribution kernels here. Say the word and we will build it.

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



