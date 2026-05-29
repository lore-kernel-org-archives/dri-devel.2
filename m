Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4265DCD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 09:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E5910FC3F;
	Fri, 29 May 2026 09:58:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="acIjAd7e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF64110FC3F
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 09:58:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0C2786022B;
 Fri, 29 May 2026 09:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1811F00893;
 Fri, 29 May 2026 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780048692;
 bh=4Hatc3dCJ/JJHmcD5A/CmbyVccH+ZeL5ciQwtHVoWAo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=acIjAd7ekzwXnF3wIC+gRlr3zQB5d1rQvunSxkrz5GEq6hhR4SL4+v2baQ1BF6l65
 fkxnZ3pU2ihcSq+WMdSTOGv0ngzuGAFgpLCAikcdMmVV8gv4tH/kbVETHDoIWRki8r
 eK55dSoVKpVSgNhtEqtxoYRWjvKarnYV1W43zjHchCFRHVDmDLTXRiKyjRRTVBPuKP
 5nDcU2tkYppUs1BY/62DDR7CyAq26WxQHVv1E0XB1zDJ9zwPV9/Qll8qfC3GeEO8aE
 tiTToMu9V5v/SainH/Oud3oGJ8XOfauLDpyJe1rnJV5sK5/dDKGG2J8fY/UZkInlz5
 oqEFhfvcfvZwA==
Message-ID: <9f1b9cf9-5083-4b2b-b95f-ee15d3847852@kernel.org>
Date: Fri, 29 May 2026 11:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] drm: link connectors to backlight devices
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>, harry.wentland@amd.com,
 Louis Chauvet <louis.chauvet@bootlin.com>
References: <20260528054911.1513208-1-superm1@kernel.org>
 <20260528054911.1513208-4-superm1@kernel.org>
 <vtyq4mxhyyp5nt4vtl2ct4yxxqogzpqxrvnupwqfa46ucddnil@cul44errvgnb>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <vtyq4mxhyyp5nt4vtl2ct4yxxqogzpqxrvnupwqfa46ucddnil@cul44errvgnb>
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

On 5/29/26 11:56, Dmitry Baryshkov wrote:
> On Thu, May 28, 2026 at 12:49:05AM -0500, Mario Limonciello (AMD) wrote:
>> This will show which connector in sysfs matches which backlight.
>>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/gpu/drm/Kconfig             |   1 +
>>   drivers/gpu/drm/Makefile            |   2 +
>>   drivers/gpu/drm/drm_atomic_helper.c |   8 +
>>   drivers/gpu/drm/drm_backlight.c     | 430 ++++++++++++++++++++++++++++
>>   drivers/gpu/drm/drm_connector.c     |  12 +
>>   drivers/gpu/drm/drm_drv.c           |   8 +
>>   drivers/gpu/drm/drm_mode_config.c   |   7 +
>>   drivers/gpu/drm/drm_mode_object.c   |  66 ++++-
>>   drivers/gpu/drm/drm_sysfs.c         |  28 +-
>>   drivers/video/backlight/backlight.c |  17 ++
>>   include/drm/drm_backlight.h         |  46 +++
>>   include/drm/drm_connector.h         |   3 +
>>   include/drm/drm_mode_config.h       |   5 +
>>   include/linux/backlight.h           |  13 +
>>   14 files changed, 641 insertions(+), 5 deletions(-)
>>   create mode 100644 drivers/gpu/drm/drm_backlight.c
>>   create mode 100644 include/drm/drm_backlight.h
>>
>> +
>> +static void __drm_backlight_worker(struct work_struct *w)
>> +{
>> +	struct drm_backlight *b = container_of(w, struct drm_backlight, work);
>> +	static const char * const ep[] = { "BACKLIGHT=1", NULL };
> 
> This caused compile errors on linux-next, I had to drop both const
> specifiers from this declaration.

Yeah - my fault for trusting checkpatch suggestion right before sending 
upstream and not compile testing because it looked "trivial".

Will fix in next spin.

> 
>> +	struct backlight_device *bd;
>> +	bool send_uevent;
>> +	unsigned int v;
>> +
> 
> Nevertheless:
> 
> 
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # SM8150-HDK
> 
> 
> 

Much appreciated!

