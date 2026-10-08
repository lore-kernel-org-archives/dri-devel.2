Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9BDCA600B
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 11:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 776E810E7DE;
	Thu,  8 Oct 2026 11:51:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Nkrx+O9+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B82C10E7DE
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 11:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=bIZdi0x4+Oe2fEpH8W3vJqEIkeq6WR18dtsgPzbLfvc=; b=Nkrx+O9+jdeiLPN95WrgK8B1C3
 YgXpRa8i+2BLFBbZ8Jq9HRUZxKC5q74fywLry4tsVr2xToBjbquldRVc3FgfH6EPfQ06lJlF4JC90
 hJKtLPYElWiNE331n7CWuoZgoM36mb+n1a2hCLHlSfAlPxY6ImtpT1sDUqS3W1ZB03MmKl4PaJ/3h
 amiV0PsJk4TXoOYOO/iUvQxRgexchj5jVvUnVAl6wjzjBbSNN+3TKGlkyNOOvRPiiTQRLdBYbRE4R
 Y1v8nSvIojle3G1Ww5SZORVG2VZpm/SIEIzKb5iFm0+myCyPOuVQm5N4+U4TOl3HyF77E56wNuBlG
 aC2hsn4Q==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xEmeK-00ESAw-UW; Thu, 08 Oct 2026 13:51:01 +0200
Message-ID: <5f934e82-62e6-4be3-9ace-f591fd95f7b7@igalia.com>
Date: Thu, 8 Oct 2026 08:50:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vc4: Disable the V3D interrupt across runtime suspend
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260925191318.541938-1-mcanal@igalia.com>
 <749f58993b891f756cde15e1408b1e98b861ce54.camel@igalia.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <749f58993b891f756cde15e1408b1e98b861ce54.camel@igalia.com>
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

Hi Iago,

On 08/10/26 08:21, Iago Toral wrote:
> Looks good to me, I have a couple of questions below:
> 
> El vie, 25-09-2026 a las 16:10 -0300, Maíra Canal escribió:
> (...)
>> diff --git a/drivers/gpu/drm/vc4/vc4_irq.c
>> b/drivers/gpu/drm/vc4/vc4_irq.c
>> index 7877d493d80e..98a8db720091 100644
>> --- a/drivers/gpu/drm/vc4/vc4_irq.c
>> +++ b/drivers/gpu/drm/vc4/vc4_irq.c
>> @@ -276,7 +276,7 @@ vc4_irq_disable(struct drm_device *dev)
>>   	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
>>   
>>   	/* Finish any interrupt handler still in flight. */
>> -	synchronize_irq(vc4->irq);
>> +	disable_irq(vc4->irq);
> 
> With this change, do we still need the 2 V3D_WRITEs above this?

Yes, because, before disabling the IRQ, we must make sure that the
V3D interface is quiet.

>>
>>
>>   	cancel_work_sync(&vc4->overflow_mem_work);
>>   }
>> @@ -284,7 +284,6 @@ vc4_irq_disable(struct drm_device *dev)
>>   int vc4_irq_install(struct drm_device *dev, int irq)
>>   {
>>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
>> -	int ret;
>>   
>>   	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
>>   		return -ENODEV;
>> @@ -298,19 +297,8 @@ int vc4_irq_install(struct drm_device *dev, int
>> irq)
>>   	init_waitqueue_head(&vc4->job_wait_queue);
>>   	INIT_WORK(&vc4->overflow_mem_work, vc4_overflow_mem_work);
>>   
>> -	/* Clear any pending interrupts someone might have left
>> around
>> -	 * for us.
>> -	 */
>> -	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
> 
> Why this change?

vc4_irq_install() is now called before PM resume, so it can't access HW
registers and that's okay, because cleaning pending interrupts is done
during resume.

Best regards,
- Maíra

> 
>> -
>> -	ret = devm_request_irq(dev->dev, irq, vc4_irq, 0,
>> -			       dev_name(dev->dev), dev);
>> -	if (ret)
>> -		return ret;
>> -
>> -	vc4_irq_enable(dev);
>> -
>> -	return 0;
>> +	return devm_request_irq(dev->dev, irq, vc4_irq,
>> IRQF_NO_AUTOEN,
>> +				dev_name(dev->dev), dev);
>>   }

