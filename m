Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31F5C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 064FC10E32A;
	Fri,  3 Jul 2026 16:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="WKWVTjA1";
	dkim-atps=neutral
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk
 [78.40.148.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C00F310E32A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
 Reply-To; bh=bJF5AimFzn/vjuyllbCot1tOEiTcY9zfJPLE09CxB1k=; b=WKWVTjA1qyK0z/EV
 nYqifrOJMqF5TcMqQDW4p2f3Zg5k7ZAsuYayMVtY7X98ZlGCgeKFsSPt/NvxKoviP6d7zOs3yx5uM
 riwSOps4f+xnxYSGu1ZwemmHz8YnxkdDBtcoi0tKaSnzzuyLPsV7/x98pkcdd4Xid+wYBpt/Q0SSJ
 9J1QU4HMEatqE0HOeQpQ76VboLbR0rajXfiPkGJRhLBDR0zYs1LfE5/kUQOVTG2ZzD+IAtXP+SJI4
 Lzj7hF8z123wKQA5gogqDq/mB6x5cJCWHfQZVEBn/krHRrMK3/QvHKeRJXo86XoyIoYeivRlgTOHf
 Pw0p1Hx2oY4mutZi4Q==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1wfggE-00AfRf-Et; Fri, 03 Jul 2026 17:23:54 +0100
Message-ID: <968ee419-6eac-4b52-b193-40963d23ae42@codethink.co.uk>
Date: Fri, 3 Jul 2026 17:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/imagination: make pvr_fw_trace_init_mask_ops static
To: Alessio Belle <Alessio.Belle@imgtec.com>
Cc: "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "Matt.Coster@imgtec.com" <Matt.Coster@imgtec.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, Frank Binns
 <Frank.Binns@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260623105341.775693-1-ben.dooks@codethink.co.uk>
 <055465207ab6f86f0d12b73a592bbecd9768c8f6.camel@imgtec.com>
 <8114990b991bab4ad2b1ee97844db3c2556c05e7.camel@imgtec.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <8114990b991bab4ad2b1ee97844db3c2556c05e7.camel@imgtec.com>
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

On 01/07/2026 19:18, Alessio Belle wrote:
> Hi Ben,
> 
> On Mon, 2026-06-29 at 11:05 +0000, Alessio Belle wrote:
>> On Tue, 2026-06-23 at 11:53 +0100, Ben Dooks wrote:
>>> The pvr_fw_trace_init_mask_ops is not used outside pvr_fw_trace.c
>>> so make it static to avoid the following sparse warning:
>>>
>>> drivers/gpu/drm/imagination/pvr_fw_trace.c:74:31: warning: symbol 'pvr_fw_trace_init_mask_ops' was not declared. Should it be static?
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>
>> Reviewed-by: Alessio Belle <alessio.belle@imgtec.com>
> 
> Actually, could you add a Fixes tag pointing at c6978643ea1c ("drm/imagination:
> Validate fw trace group_mask")? You can then add the Reviewed-by tag as well for
> last.
> 
> Thanks,
> Alessio

ok, done


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
