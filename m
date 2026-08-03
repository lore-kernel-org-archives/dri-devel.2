Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321A9C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92AFC10E606;
	Mon,  3 Aug 2026 14:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="CaQbW0aM";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5EDF810E606
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:50:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2AF8143D;
 Mon,  3 Aug 2026 07:50:32 -0700 (PDT)
Received: from [192.168.7.252] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 0E06C3F632; Mon,  3 Aug 2026 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785768636; bh=8uKEInWDos771+d9mRvAJ5VMJSpepOI6CpXD4p6XUTU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CaQbW0aMie648zTsnrzsE1t2NsnV8H1seacqlBQwLdV8wgkakUJc7z2v1Xp7mrZE9
 8xovFuZ6a9BT4T3FQCMwkqC55vtKQBsJaipq+GKKIEC8gTrfnfoEh89VQDBoSpevBg
 P4o9V2iDkk4hc/ujXmUMGhRyanSuWxfyc8Dmk5Ho=
Message-ID: <94b08c9d-649c-4c7b-882d-8b6d604a5461@arm.com>
Date: Mon, 3 Aug 2026 15:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/komeda: Set display/writeback clone masks
To: Liviu Dudau <liviu.dudau@arm.com>,
 Raveendra Talabattula <raveendra.talabattula@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, james.qian.wang@arm.com,
 asad.malik@arm.com, nayden.kanchev@arm.com, charvi.mehta@arm.com
References: <20260803142122.4127851-1-raveendra.talabattula@arm.com>
 <20260803142122.4127851-3-raveendra.talabattula@arm.com>
 <anCpsHmX-dpM8PFW@e142607>
Content-Language: en-GB
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <anCpsHmX-dpM8PFW@e142607>
Content-Type: text/plain; charset=UTF-8
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



On 03/08/2026 15:46, Liviu Dudau wrote:
> On Mon, Aug 03, 2026 at 03:21:22PM +0100, Raveendra Talabattula wrote:
>> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>
>> Since commit 41b4b11da0215 ("drm: Add valid clones check"),
>> all encoders attached to the same CRTC must advertise
>> each other through possible_clones.
>>
>> Komeda creates one writeback connector per CRTC. Allow the writeback
>> encoder to be cloned only with encoders that can drive the same CRTC,
>> and update those encoders reciprocally.
>>
>> Do this when the writeback connector is created rather than modifying
>> every encoder registered with the DRM device from komeda_kms_attach().
>> This leaves encoders associated with other CRTCs untouched.
> 
> If you don't mind I will drop the paragraph above when I commit the patch
> as it makes reference to code that has not been merged so likely
> to create confusion. I think the comment in the code is sufficient.
> 

Of course Liviu, I mentioned it to make sure that it was clear I looked at the
code you mentioned in review.

We are happy to address the relevant changes once the new series gets merged.

Thanks,
Vincenzo

> With that,
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Will push this to drm-misc-next in the next couple of days.
> 
> Best regards,
> Liviu
> ...
