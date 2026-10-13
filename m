Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB9BCC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 052A310E496;
	Tue, 13 Oct 2026 13:53:40 +0000 (UTC)
X-Greylist: delayed 572 seconds by postgrey-1.36 at gabe;
 Tue, 13 Oct 2026 13:53:33 UTC
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [46.38.247.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4195010E496
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:53:33 +0000 (UTC)
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
 by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4j3wWv1Qg1z8B09;
 Tue, 13 Oct 2026 15:43:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1791898987;
 bh=kn1pWwRqpSQrn5KGooof/V03NDOuyyBzzBkT7Vi6SwU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EPog4h01ga+F8U3shEq7EMlLuCDz3HXb7iY9xLYTkixzfoVzjfJD+O/HRjG9ADSLv
 Mx1VLeEzB6kJntJRTHlUZfyMdAGP1X3me3Mtkh5M7sf8LP6PpK4O13rik3qk8+IKfU
 c9+EpsiaT8lPB8BhDT+wWTarOn8mKYTem+CiaKGii2duzSwBNlRTwLXiZcJD1GJqKJ
 2KweN/+YbwoccjK3vJTpedsVqWBp/5yHAAslWokb/h8fzT8QWYZO+lZyX/S7keLpWX
 oztl5IJwR8XlQa8OWqVNwJ5PMHo0MDh8KyGg5aHxX6qqvD2DfSGRllbhnzZvAifJBE
 BZkiTMTlcSXsg==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4j3wWv0hpxz4y7n;
 Tue, 13 Oct 2026 15:43:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4j3wWs1dMTz8tfq;
 Tue, 13 Oct 2026 15:43:05 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 8117F5FB0E;
 Tue, 13 Oct 2026 15:43:04 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <144d54c1-fc08-4135-82ba-7cab417ebc3a@leemhuis.info>
Date: Tue, 13 Oct 2026 15:43:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 7.1: apple-gmux backlight dead on MacBookPro13,3 -
 PCI bridge left with VGA enable set and VGA 16-bit decode cleared, aliasing
 legacy VGA I/O over the gmux ports
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Haram Choi <haram@choiharam.com>
Cc: dri-devel@lists.freedesktop.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <CAAKWd2_MZSC=A2EHuEw3=eECr1QfaqrhYawW=njt5muk=5sA_A@mail.gmail.com>
 <0102019fcb5d411c-e0a555b7-46da-43a1-bd9d-6cb120f58a7f-000000@eu-west-1.amazonses.com>
 <ap_yIeUyNu5WxSnX@intel.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <ap_yIeUyNu5WxSnX@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179189898482.895600.241311855441224226@mxe9fb.netcup.net>
X-NC-CID: v4imGa248cozeojC2LcUIjjt27yx0htnngaRM5/r3+Ng7SF8B04=
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

On 9/8/26 13:31, Ville Syrjälä wrote:
> On Tue, Aug 04, 2026 at 06:01:54AM +0000, Haram Choi wrote:
>> I think I have found the commit. It is not in drivers/pci at all, and
>> my previous suspicion of 94555ea9a048 was wrong. Apologies to Simon
>> for the noise.
>>
>> The regression is:
>>
>>   cc6ed470caa2 ("drm/i915/vga: Avoid VGA arbiter during
>>                  intel_vga_disable() for iGPUs")
>>   Ville Syrjala <ville.syrjala@linux.intel.com>, 2025-12-08
>>
>> I have added Ville, intel-gfx and dri-devel to Cc.
>[...]
> 
> Sounds to me like the best fix would be to explicitly enable
> 16 bit decoding on the bridges on these machines. That would
> guarantee that apple-gmux works regardless of which GPU
> drivers are loaded, and in which order.
Was this regression ever addressed? From the outside it looks like it
feel through the cracks, but well, it easy to miss something from where
I stand.

Ciao, Thorsten
