Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ED2EA3C5C
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 06:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F21810E112;
	Fri, 10 Apr 2026 06:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="R5wWkwLY";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60D010E112
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 06:54:30 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id DC0D81E7;
 Fri, 10 Apr 2026 08:52:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1775803979;
 bh=qIh2apO5uVPz4zofCV4yZ1mMYArxi+ARdOUwja15s3c=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=R5wWkwLYjqyw+6Wt4oCcdEqC0Z/ihIU8dYz+dqanpziJ9xq7gmRq6zXPki23+6MGQ
 A0IZ/UQfYWG2Oqs1Kbi69ho9LWCPi2jTgCNxDOUFMNhBBDbRsAAT1af4XczPWGoxcV
 Hv04Pgv4c7uiXq5rZwAdWIJWWrTybnZW9m0x6i7M=
Message-ID: <6abc165b-4220-422c-8190-283a3dea1f62@ideasonboard.com>
Date: Fri, 10 Apr 2026 09:54:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/11] drm/fourcc: Add DRM_FORMAT_X403
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Simon Ser <contact@emersion.fr>
Cc: Vishal Sagar <vishal.sagar@amd.com>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Pekka Paalanen <ppaalanen@gmail.com>
References: <20260325-xilinx-formats-v9-0-d03b7e3752e4@ideasonboard.com>
 <20260325-xilinx-formats-v9-5-d03b7e3752e4@ideasonboard.com>
 <jCbIrZ5-fvx73de8DmjQ7xpuEw63kTCQ5p88cdF7yRcUk7uNbE9y0YU7uZbPXNotQAB9y6c0u5n3TrnXckvQ8Oje_J3QGxEwBSr_liQVDK0=@emersion.fr>
 <94283390-29cb-4640-b5b4-6a332dd7f2a4@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <94283390-29cb-4640-b5b4-6a332dd7f2a4@ideasonboard.com>
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

On 10/04/2026 09:07, Tomi Valkeinen wrote:
> Hi,
> 
> On 26/03/2026 16:43, Simon Ser wrote:
>> On Wednesday, March 25th, 2026 at 15:02, Tomi Valkeinen 
>> <tomi.valkeinen@ideasonboard.com> wrote:
>>
>>> +/*
>>> + * 3 plane non-subsampled (444) YCbCr
>>> + * 10 bpc, 30 bits per sample image data in a single contiguous buffer.
>>> + * index 0: Y plane,  [31:0] x:Y2:Y1:Y0    [2:10:10:10] little endian
>>> + * index 1: Cb plane, [31:0] x:Cb2:Cb1:Cb0 [2:10:10:10] little endian
>>> + * index 2: Cr plane, [31:0] x:Cr2:Cr1:Cr0 [2:10:10:10] little endian
>>> + */
>>> +#define DRM_FORMAT_X403        fourcc_code('X', '4', '0', '3')
>>
>> So, this one is different from the Q family, because Q has padding in
> 
> Any idea where the letters (P, Q, S) come from?
> 
>> LSB rather than MSB. Speaking of, maybe we should add "LSB aligned" to
>> the doc comment to make that clear?
> 
> Yes, I can add that.
> 
>> Re-reading the sibling thread about DRM_FORMAT_XV20, sounds like the
>> first digit matches my expectations for sub-sampling. How did you pick
> 
> I just used the name in Xilinx's BSP kernel.
> 
>> the last two digits? I think I would've expected "30" here rather than
>> "03", since the last two planes are Cb Cr rather than Cr Cb.
> 
> Hmm, but X403 is Cb:Cr, and P030 is Cr:Cb, so doesn't 03 make sense 
> here? Oh, but Q401 is Cr:Cb, and it's 01...
> 
> Now that I look at this... I think I have to go back and do more 
> testing. From the Xilinx docs, it looks to me that the XV15/XV20 should 
> have the same CrCb order than X403. But the comments in these patches 
> say otherwise. I'm pretty sure my tests conformed to the comments here, 
> but now I don't feel so sure anymore. It's been more than a year since I 
> wrote the tests and properly tested these, so I have to spend a bit time 
> to get everything up again.

I think the comments are correct. I guess it depends on which way you 
look at this: for P030 etc, starting from the lowest bit, the order is 
Cb:Cr. For X403, starting from the lowest plane, the order is Cb:Cr. And 
that's probably how Xilinx HW "sees" it and thus they use the same Cb:Cr 
order.

But in the comments we describe P030's components starting from the 
highest bit, and thus it's Cr:Cb.

>> Has the first "X" letter been picked arbitrarily? It's already used to
>> denote padding in other formats so I wonder if we should pick that
>> instead of, say, "T".
> I didn't invent the name, I just took the naming Xilinx used. I don't 
> know the history behind it. I assume the "X" is for Xilinx, but I could 
> be wrong here. What would "T" be for? "Tomi"? =)
So... While the Cb:Cr order can be seen both ways, perhaps the Q formats 
are a good reference here to follow, and thus it should be "430", not 
"403", as you suggest. As for the letter... Anything that's not 
currently in use is fine for me =).

  Tomi

