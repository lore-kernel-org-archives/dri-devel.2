Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6741075286
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDCD10E922;
	Thu, 19 Mar 2026 09:42:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="tG63bQvf";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tG63bQvf";
	dkim-atps=neutral
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9752010E804
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:22:16 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=93LCmuldWr4tLH+BtbdYHpMx6zo+NrUbQf0xHNbPV1Y=;
 b=tG63bQvfFvVkNAGGiCoRwP/MqBoPqUK6+S7qg2/5tPZ9+0VBBLgZGeDEYAAJijAWBmzLSNYub
 tcXw1iyXwXnT+hGBdkPmoRey3jRCufYovSSLLFvaGBHb6n5eTZWSksVA+XV38frXSlKeQ56HI3c
 xmHFN5IaKymb57kG7dlqwE0=
Received: from canpmsgout04.his.huawei.com (unknown [172.19.92.133])
 by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fbqFB2qF7z1BG87
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:21:18 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=93LCmuldWr4tLH+BtbdYHpMx6zo+NrUbQf0xHNbPV1Y=;
 b=tG63bQvfFvVkNAGGiCoRwP/MqBoPqUK6+S7qg2/5tPZ9+0VBBLgZGeDEYAAJijAWBmzLSNYub
 tcXw1iyXwXnT+hGBdkPmoRey3jRCufYovSSLLFvaGBHb6n5eTZWSksVA+XV38frXSlKeQ56HI3c
 xmHFN5IaKymb57kG7dlqwE0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fbq8M28wQz1prn3;
 Thu, 19 Mar 2026 10:17:07 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
 by mail.maildlp.com (Postfix) with ESMTPS id 872414056A;
 Thu, 19 Mar 2026 10:22:09 +0800 (CST)
Received: from [10.174.179.11] (10.174.179.11) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Mar 2026 10:22:08 +0800
Message-ID: <17605e19-065c-4b71-abb2-a9c9a7b9ddc6@huawei.com>
Date: Thu, 19 Mar 2026 10:22:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: matroxfb: remove dead code and set but not
 used variable
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Sam Ravnborg
 <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
CC: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <b.zolnierkie@samsung.com>
References: <20200403021609.20968-1-yanaijie@huawei.com>
 <20200408101852.GC20795@ravnborg.org> <abpX_2PUWie03GdG@black.igk.intel.com>
From: Jason Yan <yanaijie@huawei.com>
In-Reply-To: <abpX_2PUWie03GdG@black.igk.intel.com>
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

在 2026/3/18 15:45, Andy Shevchenko 写道:
> On Wed, Apr 08, 2020 at 10:18:52AM +0000, Sam Ravnborg wrote:
>> On Fri, Apr 03, 2020 at 10:16:09AM +0800, Jason Yan wrote:
>>> Fix the following gcc warning:
>>>
>>> drivers/video/fbdev/matrox/g450_pll.c:336:15: warning: variable
>>> ‘pixel_vco’ set but not used [-Wunused-but-set-variable]
>>>    unsigned int pixel_vco;
>>>                 ^~~~~~~~~
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>>
>> Thanks, committed and pushed to drm-misc-next.
>> The fix will show up in upstream kernel at the next
>> merge window.
> 
> The most of the patches from so called Hulk Robot appeared to be controversial.
> 
> First of all, even so called "dead code" may have side effects on the registers
> in HW which may lead to other issues. Second, the mentioned dead code elimination
> patch doesn't improve anything as now the dead code is 'mnp' variable (that's how
> I got into that, I still have a build error).

Sorry, I do not understand what side effects this may cause. Would you 
please explain it in detail?

Thanks,
Jason

> 
> That said, for the starter I suggest to revert this change. After one need go
> carefully through code to understand if it's exactly the case and what to do with
> 'mnp' which involves some IO.
> 
> +Cc: current fbdev maintainers
> 
