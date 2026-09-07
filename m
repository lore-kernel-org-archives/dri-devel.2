Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0101C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF0310E616;
	Mon,  7 Sep 2026 14:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ajLKzX2V";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE7E10E4B2;
 Mon,  7 Sep 2026 14:03:27 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 97564BE;
 Mon,  7 Sep 2026 16:01:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788789712;
 bh=OrL2hM5MGp5RzTrgCz4IxlWP+lbXPPigUyPR3/geJyI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ajLKzX2VAy1Lp0BsfqtggVm8osJkPGkD+kfd7xq2K7J208/9N9ZbNehrafRogac6c
 0Lv+pGUJCBVUrdWT+hK6pVvfMOPvD6uKnFd4TypXI+Z2I5ZaTPlQTBNveDeuqgjc7f
 ++8MtdPxAzlMK/8D0egehhGrZQ5q2ruOlfFpK8+8=
Message-ID: <72674692-9c3e-4f7b-a3d0-00df85ef938f@ideasonboard.com>
Date: Mon, 7 Sep 2026 17:03:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To: Mark Brown <broonie@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <apbbvQSfUbzYRFaw@sirena.org.uk>
 <3076b44f-b499-42cc-92cf-f4a7a470fb2f@sirena.org.uk>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <3076b44f-b499-42cc-92cf-f4a7a470fb2f@sirena.org.uk>
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

On 07/09/2026 17:01, Mark Brown wrote:
> On Tue, Sep 01, 2026 at 03:05:49PM +0100, Mark Brown wrote:
>> Hi all,
>>
>> After merging the drm-misc tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> /tmp/next/build/sound/soc/ti/omap-hdmi.c:408:6: error: no member named 'card' in 'struct hdmi_audio_data'
>>    408 |         ad->card = card;
>>        |         ~~  ^
> 
> This issue is still present today.

I have sent "[PATCH] ASoC: ti: omap-hdmi: Fix build error from a merge 
commit" (20260903-omap-hdmi-fix-v1-1-b0447a1d35d5@ideasonboard.com). 
Waiting for a R-b so I can push it via drm-misc.

  Tomi

