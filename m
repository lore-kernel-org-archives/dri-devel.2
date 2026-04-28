Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA7AFF8877
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B2E310EF2F;
	Wed, 29 Apr 2026 10:10:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JPDW8yNc";
	dkim-atps=neutral
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F077310E364
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 19:12:53 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-679f6ee3fb0so4544744eaf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777403573; x=1778008373; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7XUrSex+przptT7CWc7tEJmPhAbzzbza6TE4OD6saHw=;
 b=JPDW8yNckmleAsH8b0roGUeYnj5fk6B9DoT4AhAp7wofLfEMPrztwgdBY/VBa8we9z
 ERmufxTvdRG+qtnT7AwaSU90eKoFasNQQCFNq465IcqvgnA6dXVjqCklewW1MzureUMe
 bA0JJlPeWmc+N18IVDLNvx6MdnKWbvtPdIGJ6qvApIxnVjJjif31c+cRCgQ+m06RPleU
 7rklFPDHl4tD6AAHN3hIwPVzzBSXJjxyZYhjiYo7qCK6OPANuSO7w1er1Rg6nPv+DVNF
 iyZdBQUORpfMOPle6eK8ugZkJUAi3pirk7DGGg9S+gL0jFwLfnI/5KKuVuOxcYxNPZtO
 lWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777403573; x=1778008373;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7XUrSex+przptT7CWc7tEJmPhAbzzbza6TE4OD6saHw=;
 b=kJrRBVTBYmsNLiN0099hRnmHrvVn3qIq8KfVUiqxQvSXAAUIRFAk+wfL0cHHyYZScd
 cqmCQZgOAD47PpJzMk/4imebaQ+ORej0nr+7AZAmEt6t9St6ep29+XPCKOMe+PIbePMe
 Ll3Qph3eUy2W763nT8TaVxLmK4HfeKRrnC3kuQxXLqbC5Bwq+Ib2X7PUmnquLew1nQMU
 RjHVxW7pvII/qe1u16TY2gaocdNswbvI2m05KeZ4K+BBNSvORYp91WncHz4PZNpa4lQ0
 EojoYplGgCSNnCbXuZ5ZXGYtdw9XQTE0YDNrZF/79rB1Klyod7NfVHlytcmPhptTNAEm
 YogQ==
X-Gm-Message-State: AOJu0Yzzkyhvlw3a3RwmzRUdk9CwvzNylDGWyUnY26uL+9VrMs8coByw
 tZfQ19OgQXKtHi9Rl8bhDcPoBOTTj3oyTiH9NmGSHhRiwRn7oYd/dRBj
X-Gm-Gg: AeBDiesyIXAXuxn4GBvvHR1FoaHQs4+HqrsBpiQeW9wMTbitEmBJCatsexQ9iatSpaU
 VN4FsceCRIjsgWibzBXIceT5XTbYaw0vaNQqf67WzCeQ4J60qL8xwf30LXfTm/jKV7jVVT4u4mJ
 0hIB6WqOjGdGtCrTWFDxYXjwvC0tc8ZutODVmovaX1DS7KauTz1F3hOC3AaqK+rb8LS70k+7CM8
 eLbVVyQOTHD2Ii9Utbzk/T+Rvbu96+K+VvGo4hFwPZ1ksWx5sPqf9ID+8x5TMSMKkpAgwAmujI6
 yJfznHDC8TUuA+kxD4jbLY1EETdWV9zgD3qgmdzX4c5TJm0ArydD061u+RipMkflMwv+NYv5Z0F
 WUJ9oyogfvgY8Mu7Rusg6wnNbmjs3bAvumUr/hE1P84xtaYDG7y0sefwFR7roDUU0MnDp6KVHQ2
 Q6l2/gyZ2YFHpfVP+4PaKWOP0x6e8jVOQMBZN2Kjbi23NtBUyhezqMwdw5IHWdpCQyx5er7dWAH
 PE/+PNx6S3SZ/ggZL538+k=
X-Received: by 2002:a05:6820:2220:b0:694:9861:ec55 with SMTP id
 006d021491bc7-6965ca6725cmr2331346eaf.10.1777403572887; 
 Tue, 28 Apr 2026 12:12:52 -0700 (PDT)
Received: from ?IPV6:2605:a601:aab9:5000:9c83:ae08:a2f4:6f81?
 ([2605:a601:aab9:5000:9c83:ae08:a2f4:6f81])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6965b914f8fsm2031092eaf.3.2026.04.28.12.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 12:12:51 -0700 (PDT)
Message-ID: <be1f1005-a7ed-4a5b-904b-35541b19658a@gmail.com>
Date: Tue, 28 Apr 2026 14:12:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: further issues with MGA G200 graphics chipset
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 "airlied@redhat.com" <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pasi Vaananen <pvaanane@redhat.com>
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
 <a9d176ec-d19b-4f41-af16-cdc4e475a8cc@suse.de>
 <6ec01703-31e0-4998-9508-a5a115ae7bc9@intel.com>
 <14aa4840-29c4-46df-b60d-8e1b92494ad2@redhat.com>
 <e9cca01c-960d-495c-aaba-327eac43cad6@intel.com>
 <a23413a4-f939-4a23-996f-4ba5c8294c59@suse.de>
 <5155f29b-bc4d-4e60-9a26-22d568c43e46@redhat.com>
 <0be82b55-0f78-4ef9-8b50-f068ec36ec4f@suse.de>
 <df849883-f61d-484a-bd4c-32da52473ad3@intel.com>
 <3def4337-4297-45fa-8825-4147abda49f4@suse.de>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <3def4337-4297-45fa-8825-4147abda49f4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

On 4/27/2026 7:14 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 25.04.26 um 01:29 schrieb Jacob Keller:
> [...]
>>>
>>> So I suggest to pick Manufacturer, Product, Version as key. I'd be
>>> surprised if we find more than a hand full of systems with the issue. If
>>> we see a trend or common pattern, we can generalize later on.
>>>
>> I think this is the best solution. Keep it focused for now. I believe
>> Intel has two major platforms that we care about with respect to this
>> issue. I'll see if I can dig up the data. The systems install the MGA
>> G200 for BMC use but don't seem to expose the VGA connection.
>>
>> For the specific system I have that was faulty, we have the following:
>>
>> $ for t in system-manufacturer system-product-name system-version ; \
>>      do dmidecode -s ${t}; \
>> done
>> Dell Inc.
>> PowerEdge XR8720t
>> Not Specified
>>
>>
>>
>> I believe there was also some concern about HP systems which similarly
>> use this chipset, but I don't have the DMI data for that one off hand.
>> I've asked some colleagues to confirm the situation and obtain that
>> data. I'll get back early next week if we think there are any other
>> systems possibly affected.
>>
>> In the mean time, I'm happy to have our team test any patch to confirm
>> that it behaves as expected and resolves the service interruptions.
> 
> For now, I've modified the two places that have BMC support in the 
> driver. Could you please also tell me your system's exact Matrox chipset 
> or its PCI id?
> 
> The patch is attached for your testing. It would work against drm-tip or 
> v7.1-rc1.
> 
> I've also found the page at [1], which claims that there's a Mini-DP 
> port at the front. If so, I'd assume that there's also an extra encoder 
> chip to replace the VGA. If we ever get specs for that, we could 
> implement real support in the driver.
> 
> In the meantime, the current fix should work. In the worst case, that 
> Mini-DP port would give a lower default resolution.
> 
> [1] https://www.dell.com/en-us/shop/ipovw/poweredge-xr8720t? 
> hve=shop+now#techspecs_section
> 
> Best regards
> Thomas
> 
> 

So this patch disables DDC polling if the dmi_check_system() matches. If 
this was to happen on systems that _do_ have a physical VGA connector, 
will that port still be active, just with a resolution that may not be 
compatible with the monitor that's plugged in?

I don't see anyone say that the DDC polling doesn't cause too much 
latency for real time kernels on other systems that do have a VGA 
connector... did I miss that, or is there a chance that a lot of other 
systems that use this driver might also have issues with a real time kernel?


> 
> 
>>
>> Appreciate all the feedback on this thread.
>>
>> Thanks,
>> Jake
> 

