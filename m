Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60479C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A766B10E61B;
	Mon,  6 Jul 2026 14:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AEoLn+Ld";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B375B10E543
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kpWouPUokyZHgzvFPproZHj6/Ef0PkuYaNYWYN2xtR8=; b=AEoLn+LdolVTfzo+WS/CSbMoSW
 5Gfx2w4VqTbyrFuhlcn+8gzRsbrwAeqxVrjAbbebSSpIwazI6pycrGdZlF/9tH9C81E0FZFEPRUoa
 CETcJ01vptZU8/XSKO/ot7xBKoijKfsBDF29GD1F4FcLolmF2SOg0WmS6/z08tApWqNB5mX0n1rpm
 YJxM3tJDkCZx/5xvJHSLKiCsdVfi07giNEelNnuKmwOvA01XNsp4zVEbvVOreCkLAd1WfS11dq1Ri
 eGdCnxaGfdaEeTMSCfNF3ubsDSLnlH6IShbIM3jNUnme4J0lCdbrAt2g9teMDtA7QmCjYgN03V528
 z+y/HfMw==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wgkS6-009mku-2u; Mon, 06 Jul 2026 16:37:42 +0200
Message-ID: <e9e12e30-80c1-4650-9d71-4107517bc956@igalia.com>
Date: Mon, 6 Jul 2026 15:37:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/sched: Protect entity->last_scheduled with
 spinlock
To: phasta@kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Marco Pagani
 <marco.pagani@linux.dev>, Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260701085920.3253248-2-phasta@kernel.org>
 <20260701085920.3253248-3-phasta@kernel.org>
 <a4091099-1931-4ca2-a81a-9c3321b123a8@ursulin.net>
 <51fbde808bd059510d667d130afae179626303be.camel@mailbox.org>
 <ce33edbb-11dd-4722-bb87-d16155f35a75@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <ce33edbb-11dd-4722-bb87-d16155f35a75@igalia.com>
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



On 06/07/2026 09:45, Tvrtko Ursulin wrote:
> 
> On 03/07/2026 15:47, Philipp Stanner wrote:
>> On Fri, 2026-07-03 at 12:27 +0100, Tvrtko Ursulin wrote:

8><

>>> I am also happy to give it a spin on the Steam Deck to see if I can
>>> observe anything.
>>
>> Could be interesting.
> 
> Okay I'll try to do it in reasonable time. You can either respin or wait 
> for it, I don't mind either way.

On the topic of benchmarking, I gave it a quick spin against four unsync 
instances of vkgears. Point being seeing if something can be shown on 
more datacenter deployments with many cores submitting and large 
aggregate "fps".

x stock.fps
+ phasta.fps
+----------------------------------------------------------------------+
|                              +                                       |
|                           +  ++                                      |
|                           +  ++                                      |
|                       +   +  ++ +  x                                 |
|                       + + +  ++ +  x                                 |
|                    +  +++ + +++ +  x                                 |
|                    +  +++ +++++ +x x                                 |
|                    +  +++ +++++++x x *                               |
|                   ++  +++ +++++++x *x*xx    x                        |
|                   ++  +++x+++++++xx*x**x    x                        |
|                   ++  +*+*+++*+++xx*x*** x xx                        |
|               x  +++  +*+*+*+**+*x******xxxxx                        |
|            x  xx**++  **+*+****+********xxxxx x    x                 |
|        x  +xx xx**++ +******************xxxxxxx x  xx                |
|      x xxx**x x**************************xx*xxx xxxxx                |
|xx    xxxxx**x*****************************x**x**x*x*x   x x x  x    x|
|                    ||_______A___A_M|________|                        |
+----------------------------------------------------------------------+
     N           Min           Max        Median           Avg        Stddev
x 218      5446.984      5862.578      5656.121     5642.9429     76.667613
+ 227      5510.432      5762.926      5620.999     5620.3585     45.407235
Difference at 95.0% confidence
	-22.5844 +/- 11.6534
	-0.400224% +/- 0.206513%
	(Student's t, pooled s = 62.6985)

Numbers are average FPS per vkgears instance. Total run each is around 
40 seconds.

More locking does appear to show a small decrease in throughput and, 
curiously, a tighter range between min and max. Whether or not that is 
telling us something about the lock cycles and inter core 
synchronisation I am not sure. Could be just noise and that more runs 
are needed. I can do that tomorrow.

Regards,

Tvrtko

