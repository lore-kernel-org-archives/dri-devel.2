Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CD31075289
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FE2A10E927;
	Thu, 19 Mar 2026 09:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="xyrtlGI8";
	dkim-atps=neutral
X-Greylist: delayed 20676 seconds by postgrey-1.36 at gabe;
 Thu, 19 Mar 2026 08:06:48 UTC
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F24E810E8D4
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 08:06:48 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=de6sE0gCPgrQLlge7GJt5+7mdZ20YrkwDcyPCmIYdVQ=;
 b=xyrtlGI8N5W0OqJoOiz2rntCCfiKwiaRAAAYOwqZqmdMSWeqYtOGYjRGWBFtTlnmPT/yfzWzj
 PCSewm+U1YSDipSNpqz0Exgws1TKde7eJCIP/kN6hTFJzv9ByelYVstgwAZ0+vnU9U9eADfEeIW
 68G2YJDSMMmpQWqfErpiWEE=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fbynR0xD8z12LD3;
 Thu, 19 Mar 2026 16:01:15 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
 by mail.maildlp.com (Postfix) with ESMTPS id 0107540538;
 Thu, 19 Mar 2026 16:06:46 +0800 (CST)
Received: from [10.174.179.11] (10.174.179.11) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Mar 2026 16:06:45 +0800
Message-ID: <e5f7611f-f087-4835-99e3-4fddc927aab8@huawei.com>
Date: Thu, 19 Mar 2026 16:06:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: matroxfb: remove dead code and set but not
 used variable
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
 <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <b.zolnierkie@samsung.com>
References: <20200403021609.20968-1-yanaijie@huawei.com>
 <20200408101852.GC20795@ravnborg.org> <abpX_2PUWie03GdG@black.igk.intel.com>
 <17605e19-065c-4b71-abb2-a9c9a7b9ddc6@huawei.com>
 <abun9dwCYAWd1nIB@ashevche-desk.local>
From: Jason Yan <yanaijie@huawei.com>
In-Reply-To: <abun9dwCYAWd1nIB@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.11]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)
X-Mailman-Approved-At: Thu, 19 Mar 2026 09:42:18 +0000
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

在 2026/3/19 15:38, Andy Shevchenko 写道:
> On Thu, Mar 19, 2026 at 10:22:08AM +0800, Jason Yan wrote:
>> 在 2026/3/18 15:45, Andy Shevchenko 写道:
>>> On Wed, Apr 08, 2020 at 10:18:52AM +0000, Sam Ravnborg wrote:
>>>> On Fri, Apr 03, 2020 at 10:16:09AM +0800, Jason Yan wrote:
>>>>> Fix the following gcc warning:
>>>>>
>>>>> drivers/video/fbdev/matrox/g450_pll.c:336:15: warning: variable
>>>>> ‘pixel_vco’ set but not used [-Wunused-but-set-variable]
>>>>>     unsigned int pixel_vco;
>>>>>                  ^~~~~~~~~
>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>>>>
>>>> Thanks, committed and pushed to drm-misc-next.
>>>> The fix will show up in upstream kernel at the next
>>>> merge window.
>>>
>>> The most of the patches from so called Hulk Robot appeared to be controversial.
>>>
>>> First of all, even so called "dead code" may have side effects on the registers
>>> in HW which may lead to other issues. Second, the mentioned dead code elimination
>>> patch doesn't improve anything as now the dead code is 'mnp' variable (that's how
>>> I got into that, I still have a build error).
>>
>> Sorry, I do not understand what side effects this may cause. Would you
>> please explain it in detail?
> 
> Any IO (and specifically on PCI bus) may have side effects. If the removed code
> did some HW accesses (especially reads), it affects the state of HW. You can
> read more about PCI bus and what read from it does.

No, the removed code did not do any IO and will not affect the state of HW.

> 
> Helge, can we revert this change and start over, please? (I can also send
> revert if you think it's a better way)

I don't think we need to revert this patch. Please provide proof that 
this modification will lead to real issues.

Thanks,
Jason

> 
> I do not believe this change was ever tested on real HW, and I see an evidence
> that this most likely was blindly made as it led to the similar issue after
> the change.
> 
>>> That said, for the starter I suggest to revert this change. After one need go
>>> carefully through code to understand if it's exactly the case and what to do with
>>> 'mnp' which involves some IO.
>>>
>>> +Cc: current fbdev maintainers
> 
