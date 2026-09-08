Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1FDC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8335910E099;
	Tue,  8 Sep 2026 07:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="B+1q3Mis";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44C6610EA7D;
 Tue,  8 Sep 2026 07:22:52 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2037AC2D;
 Tue,  8 Sep 2026 09:21:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788852075;
 bh=+4Uu9UEcxeOsHBEBCgcDtRZbr14P5InKdafDY9BK1j8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=B+1q3MisJ2fW9TID7dRHOjnrEaKLJzcbiJ4EuqhQNnSEBwdNCNe6AciO4pVB+P6ib
 i/c09ODcxgyJ7wtYuSo5+vS7OBdCXtekWl00Qk0dCOOzIipPM8Yllbf+/EitYYksb5
 I0ReGNeXShESMfm2taw6B0Yzwhz/1KhRpdbvYGQ0=
Message-ID: <c0694ac5-cd29-432d-8d7f-f4363ac4d2d9@ideasonboard.com>
Date: Tue, 8 Sep 2026 10:22:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To: Mark Brown <broonie@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <apbbvQSfUbzYRFaw@sirena.org.uk>
 <3076b44f-b499-42cc-92cf-f4a7a470fb2f@sirena.org.uk>
 <72674692-9c3e-4f7b-a3d0-00df85ef938f@ideasonboard.com>
 <c25601c4-1b82-4565-ac85-53496c2ef794@sirena.org.uk>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <c25601c4-1b82-4565-ac85-53496c2ef794@sirena.org.uk>
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

On 07/09/2026 17:08, Mark Brown wrote:
> On Mon, Sep 07, 2026 at 05:03:22PM +0300, Tomi Valkeinen wrote:
>> On 07/09/2026 17:01, Mark Brown wrote:
> 
>>> This issue is still present today.
> 
>> I have sent "[PATCH] ASoC: ti: omap-hdmi: Fix build error from a merge
>> commit" (20260903-omap-hdmi-fix-v1-1-b0447a1d35d5@ideasonboard.com). Waiting
>> for a R-b so I can push it via drm-misc.
> 
> I saw that, it is probably worth looking into what's going on with the
> process here if what should be a relatively simple build failure fix is
> taking this long to get integrated.

I have pushed 836a0bb73c17 to drm-misc-next.

  Tomi

