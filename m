Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34467C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D9810E3C4;
	Mon,  6 Jul 2026 16:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="zrOUeLN/";
	dkim-atps=neutral
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk
 [78.40.148.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C2F610E3C4
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
 Reply-To; bh=4QhyIdNvjJG9/SfQXiZAEqun0KFeZ25ciqpUlHFi75k=; b=zrOUeLN/+JKHjL+Z
 CXL0SE5V5/Tyw8Qo2imFlJrUqAcEGkb7zXekGpPX6w9EW/GCB9pbXdDrg2CPmrT1B1FSp2G2cvxcY
 IOBLw54rrAifVOcIH6WGsjG5wZT6H7+txZg6ubOmrv/wfk64iF1QbgnOtYL7JkXJzK1M1bn90HGSu
 CNc5LfAzDBIyLSsxUW8PiygtlV8ByPK8VjAHlHrCP/PFnmhomdGuxlj5nsb0FjD3kY34AOR3sOQ+h
 DEmZA4ssStXQMTBAdP/fmVEiIf43QsWVvPN38xH7VyYo/NX2x8GIgW4aJcvZ42wnh5viy5AJdugpy
 Fy7eHrIqv1rbcGSLYA==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1wgmKb-00Gg3Y-Ta; Mon, 06 Jul 2026 17:38:05 +0100
Message-ID: <45e86efe-28a6-491c-80c6-79b2dd947cf5@codethink.co.uk>
Date: Mon, 6 Jul 2026 17:37:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/imagination: make pvr_fw_trace_init_mask_ops static
To: Alessio Belle <Alessio.Belle@imgtec.com>
Cc: "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "matt.coster@imgtec.com" <matt.coster@imgtec.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, Frank Binns
 <Frank.Binns@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260703162338.2848039-1-ben.dooks@codethink.co.uk>
 <1c7c5867cfba89094d39e5178cc281c0cc9c87fa.camel@imgtec.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <1c7c5867cfba89094d39e5178cc281c0cc9c87fa.camel@imgtec.com>
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

On 06/07/2026 17:31, Alessio Belle wrote:
> Hi Ben,
> 
> On Fri, 2026-07-03 at 17:23 +0100, Ben Dooks wrote:
>> The pvr_fw_trace_init_mask_ops is not used outside pvr_fw_trace.c
>> so make it static to avoid the following sparse warning:
>>
>> drivers/gpu/drm/imagination/pvr_fw_trace.c:74:31: warning: symbol 'pvr_fw_trace_init_mask_ops' was not declared. Should it be static?
>>
>> Fixes: c6978643ea1c ("drm/imagination: Validate fw trace group_mask")?
> 
> nit: the "?" at the end
> 
>> Revied-by: Alessio Belle <Alessio.Belle@imgtec.com>
> 
> nit: Revied-by -> Reviewed-by
> 
> I can fixup these manually after applying the patch, if you are fine with it,
> unless you prefer to send a v3.
> 
> Planning to apply this patch to drm-misc-fixes by the end of this week.

Please go ahead and fixup the issues before applying.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
