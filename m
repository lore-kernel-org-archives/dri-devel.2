Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78661F36BB0
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 06:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D261910E131;
	Fri, 10 Apr 2026 06:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MRa/zXKh";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 125CE10E131
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 06:08:02 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id A7F08161;
 Fri, 10 Apr 2026 08:06:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1775801191;
 bh=h5nQIItVWk+yXDHXcdH0AQQcOE4F524k/QvgX2pIqmk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MRa/zXKhomRaKhbb2fkgtfW3xrA/GOmAvMeBbz8tqAisQCPiJfwn1RXboasMxhE5N
 U9ORUBWHlFqgGLWGV6p6s9fnVA1tHqvcvzN+76ixZaK7NFPoy+aw0nKWY7+DFX+KIc
 OabV9VM6CzyuoggtOhiWq0W8/9yWOw7E/gIgdDQI=
Message-ID: <94283390-29cb-4640-b5b4-6a332dd7f2a4@ideasonboard.com>
Date: Fri, 10 Apr 2026 09:07:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/11] drm/fourcc: Add DRM_FORMAT_X403
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
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <jCbIrZ5-fvx73de8DmjQ7xpuEw63kTCQ5p88cdF7yRcUk7uNbE9y0YU7uZbPXNotQAB9y6c0u5n3TrnXckvQ8Oje_J3QGxEwBSr_liQVDK0=@emersion.fr>
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

On 26/03/2026 16:43, Simon Ser wrote:
> On Wednesday, March 25th, 2026 at 15:02, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:
> 
>> +/*
>> + * 3 plane non-subsampled (444) YCbCr
>> + * 10 bpc, 30 bits per sample image data in a single contiguous buffer.
>> + * index 0: Y plane,  [31:0] x:Y2:Y1:Y0    [2:10:10:10] little endian
>> + * index 1: Cb plane, [31:0] x:Cb2:Cb1:Cb0 [2:10:10:10] little endian
>> + * index 2: Cr plane, [31:0] x:Cr2:Cr1:Cr0 [2:10:10:10] little endian
>> + */
>> +#define DRM_FORMAT_X403		fourcc_code('X', '4', '0', '3')
> 
> So, this one is different from the Q family, because Q has padding in

Any idea where the letters (P, Q, S) come from?

> LSB rather than MSB. Speaking of, maybe we should add "LSB aligned" to
> the doc comment to make that clear?

Yes, I can add that.

> Re-reading the sibling thread about DRM_FORMAT_XV20, sounds like the
> first digit matches my expectations for sub-sampling. How did you pick

I just used the name in Xilinx's BSP kernel.

> the last two digits? I think I would've expected "30" here rather than
> "03", since the last two planes are Cb Cr rather than Cr Cb.

Hmm, but X403 is Cb:Cr, and P030 is Cr:Cb, so doesn't 03 make sense 
here? Oh, but Q401 is Cr:Cb, and it's 01...

Now that I look at this... I think I have to go back and do more 
testing. From the Xilinx docs, it looks to me that the XV15/XV20 should 
have the same CrCb order than X403. But the comments in these patches 
say otherwise. I'm pretty sure my tests conformed to the comments here, 
but now I don't feel so sure anymore. It's been more than a year since I 
wrote the tests and properly tested these, so I have to spend a bit time 
to get everything up again.

> Has the first "X" letter been picked arbitrarily? It's already used to
> denote padding in other formats so I wonder if we should pick that
> instead of, say, "T".
I didn't invent the name, I just took the naming Xilinx used. I don't 
know the history behind it. I assume the "X" is for Xilinx, but I could 
be wrong here. What would "T" be for? "Tomi"? =)

  Tomi

