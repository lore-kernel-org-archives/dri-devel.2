Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC591C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9050F10F24F;
	Thu, 13 Aug 2026 09:42:02 +0000 (UTC)
X-Greylist: delayed 485 seconds by postgrey-1.36 at gabe;
 Wed, 12 Aug 2026 21:02:58 UTC
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46B3E10E47F
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 21:02:58 +0000 (UTC)
Message-ID: <b15b2687-0c2e-43b2-ac9e-78e04e77e065@mainlining.org>
Date: Wed, 12 Aug 2026 23:54:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] Add support for Qualcomm Snapdragon SM7150 SoC and
 Google Pixel 4a
To: David Heidelberg <david@ixit.cz>, Jens Reidel <adrian@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>, Miro Mraz <mraz.miro@seznam.cz>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org, linux-hardening@vger.kernel.org,
 linux@mainlining.org, Connor Mitchell <c.dog29@hotmail.com>
References: <20250422-sm7150-upstream-v1-0-bf9a9081631d@jiaxyga.com>
 <2ca2b774-fd7f-4612-b38d-f60e32ff6f9a@mainlining.org>
 <283096ad-ae1b-42b8-8312-b192f735fc80@linaro.org>
 <cce3fe36-322e-49ed-8928-3aef813faad7@ixit.cz>
Content-Language: en-US
From: Danila Tikhonov <danila@mainlining.org>
In-Reply-To: <cce3fe36-322e-49ed-8928-3aef813faad7@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

Hi David,

Thank you for your comment.

On 12/08/2026 14:40, David Heidelberg wrote:
>
>
> On 23/04/2025 09:26, Neil Armstrong wrote:
>> Hi,
>>
>> On 23/04/2025 00:07, Jens Reidel wrote:
>>> Hi everyone,
>>>
>>> apologies for the mess this created. Danila's mail provider 
>>> ratelimited him halfway through sending the series and the attempt 
>>> to re-try sending the second half an hour later ended up with a new 
>>> message ID (I think due to not using --in-reply-to).
>>> He asked me to let you know that this will be resolved later and the 
>>> whole series will be re-sent once the problems are resolved.
>>
>> The b4 web submission is a great alternative when the mail provider 
>> is rate limited:
>> https://b4.docs.kernel.org/en/latest/contributor/send.html#web-endpoint
>>
>
> I see people interested in moving Pixel 4a forward, but it seems this 
> was never upstreamed? I looked at sm7150 repository [1] where I see 
> FROMLIST, but these patches never arrived to the list and this series 
> is from 2025.
>
> Should we expect v2 (re)based on recent tree?
>

I'd definitely like to get back to upstreaming SM7150 and the devices
based on it, but I don't think there's much value in continuing with
this particular series as-is. A lot has changed in the kernel over the
past year, which would require substantial changes throughout the series
and would effectively force the maintainers to review it from scratch
anyway.

I'd also like to split the series up to avoid targeting such a large
number of maintainers in a single submission. Hopefully, I'll be able to
find some time to work on this in the near future.


> Thanks
> David
>
> [1] 
> https://github.com/sm7150-mainline/linux/commit/7ea41523c678e94a7c048936052b5b1b1b109cdd
>
>> Neil
>>
>>>
>>> Best regards,
>>> Jens
>>
>>
---
Best regards,
Danila
