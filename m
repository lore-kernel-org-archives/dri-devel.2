Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690D0C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8005A10F1CC;
	Wed,  2 Sep 2026 13:11:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UJDd6b+u";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D52110F1CA;
 Wed,  2 Sep 2026 13:11:26 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 64F5CBE;
 Wed,  2 Sep 2026 15:09:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788354593;
 bh=laBufeDfUKVlcUtOt70XztqXseNEuZLpL6vmLx/iFuo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UJDd6b+upWu0WPOwmOLLUPCAsF8vPJ0LVvE92tOvDmdPWmm8wOGbaJjC6XoXl1aOa
 //ssimM3VjWLMTZkZURBWupBrGMF+Pt05BPg4+iWAghdFjO5dOEvev4AMfyjWFSP4r
 IwLKYopaTh3yj4EFw0rEg69sJ/QrAxrc2X0rTusU=
Message-ID: <d1a594e7-7393-4f2f-b11d-bfff720de743@ideasonboard.com>
Date: Wed, 2 Sep 2026 16:11:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To: Mark Brown <broonie@kernel.org>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <apbbvQSfUbzYRFaw@sirena.org.uk>
 <3cd2c640-3ce8-4163-9f7b-3abba46ae072@gmail.com>
 <64bdb5bc-ced6-490c-b4c8-fd3dcabbbd4c@sirena.org.uk>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <64bdb5bc-ced6-490c-b4c8-fd3dcabbbd4c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 02/09/2026 15:11, Mark Brown wrote:
> On Wed, Sep 02, 2026 at 09:52:24AM +0300, Ivaylo Dimitrov wrote:
>> On 1.09.26 г. 17:05 ч., Mark Brown wrote:
> 
>>> /tmp/next/build/sound/soc/ti/omap-hdmi.c:408:6: error: no member named 'card' in 'struct hdmi_audio_data'
>>>     408 |         ad->card = card;
>>>         |         ~~  ^
> 
>> This seems to be due to an interaction between two patches:
>> 1. 9af2c1d4f847 (ASoC: ti: omap-hdmi: remove unused *card) / 875e906efdc4
>> (ASoC: ti: preparation for Card capsuling)
> 
> Those are in -rc1...
> 
>> 2. 699e5975e2a53 (drm/omap: Report HDMI hotplug events to the ASoC HDMI
>> codec)
> 
> ...which the drm-misc tree has now merged so I don't expect it to build
> independently of any other tree.  I'm a bit surprised this wasn't caught
> when merging up -rc1.

So the fix is just to remove that line. Any preference, should this go 
via drm or sound?

  Tomi

