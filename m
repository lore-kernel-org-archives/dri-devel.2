Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5401ACD98D2
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 02:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC2610EBCF;
	Sat, 13 Jun 2026 02:28:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WyOByydZ";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4697810EBCF
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 02:28:58 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2c0c35980fdso15898545ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 19:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781317738; x=1781922538; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kLHJ0DrZbAxmSP/INU6NP0BNF9ycUzCW6F9L82yYfNc=;
 b=WyOByydZUKgmo2zrlvfyBmDvzOdxEDso2az6gnIv+oTtogL+LwRMbBeXGPvH+kEior
 r2bpQYjeomq6CNO0cVuQIoVIxmqMlrP60CmD5Es9+lZ7G191JIwla/dFMEl+g3L5nJcn
 OGNgQQfPPMMw757APz8kp9f/T/ez6hqf8Y3g0XrXx++BaDBWqnyiz9TS+jB6exqp6ckU
 ltQXkKDTXsldUTC+n7YWbvpUGseDq2UM2SexjBf7SLlz873yhgfqGwZUrMl49KaQzY7h
 uVEyQorwMaiHGExJ44E2AMg4/teFnX7fk4LTRAUjK7T47MO6n4FEhPhq8s4vsPXMwP1Q
 AV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781317738; x=1781922538;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kLHJ0DrZbAxmSP/INU6NP0BNF9ycUzCW6F9L82yYfNc=;
 b=BE3GXWI+/d4rVEmOjUd/m9jPpon/i8sBFkZd4CbhHeAANtSbYXxnHyi/gRILmA816Y
 GUx/Eo1PPG3V0Gs5pNW5jclB4FvtryMZ475CnZQ10//x7z8tz0eck0mUscaHRteo7wc6
 kI/HJrmOKvwr9iGrWPDi32qQOHlhEAcUjC0omkoP/tN+VaKXfxEg9cx+UPbugl87kwkQ
 j7Mxefd5gTiAagqXSLsR/gRFFq6eM5pb31TlkF4q+zcHu0JoSXbLjiADuewJBvyZ/vTr
 SM3YYdUMHDwehtu0UcP9D7K3TiOCadwnlngqAMvUy+q2QHSxhre/iI68mLwJ2J+V5vCE
 +i1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ysYRFuaLoxW1moi7woPygxkNtQG84k/AoC1gu1HgZSKnL0HubIIw22Bk6yQWqz5hkeK/K4EcO1HQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztFzBvpT/IWJNrtD7EkHNp8epwO9WD16T6F29OX9FIoBCgtb4M
 Dm1snqdS0DRP1IYhrgfptFwtwBaP0316WVIBeX1RBG3D2pP/P55aRww5
X-Gm-Gg: Acq92OGZq+O3MJzFLlTvErfEOIU0vx6XDj4MoRcTsgb2iBd/TcOlS8bIfk1g40z3ksa
 eepQVt4l5pp5oclPBfoYm+ulVCw3kKVJZCtE9Zh5yO7HvWngGoZ5PjXO9Y4YoR6GQN9fMaqIG3Q
 tkWlt/iONbVdZrObYHoggfeR3U5TB0nV61WfvyCyttZbaSZYZdapNrBXY1zkVj7jneOH5vYZvSZ
 +rEuHhd5sgLmejqnZh3mFn59UXXTsMEkGEk4FYFpwv4QekOy/znzr4iclLuDa0e+X3L1HXNnSRV
 gBfLtX+sszmA7wyN2dcHL7VxC2Cm6nxG06qZ8ynMTYPVMMSyPVOmkJ2ZEnaSJuI9EOqBiJlkoWR
 FD76UkKY6bJG2+R6TDSCZNeKKZkFXG1q0D86pdZcza9Bh6vzW7fakxPntcZRKAcftsMzVyxxlwG
 21hWB8UZJpmknvE5Z5UqEtDz7/q4G3l3EoE40/8f+CfxuxcTOtIqEU2CQNxmU2m1oGF4cccHX9k
 M6tMM78fLGXRMyDWb5pwz29g9+0TlGCA64/VGHLVmFxbUDJs1CR6DAc+RSNVfD9fvMeTxNf9iV+
 UQhSSO9bgwnJr5jmNkGpMwziI2sSrIAj1A==
X-Received: by 2002:a17:902:e84a:b0:2ba:4ad9:70f6 with SMTP id
 d9443c01a7336-2c412d2854fmr68416635ad.31.1781317737604; 
 Fri, 12 Jun 2026 19:28:57 -0700 (PDT)
Received: from ?IPV6:2601:1c0:5780:9200:2220:80f5:c3dc:900f?
 ([2601:1c0:5780:9200:2220:80f5:c3dc:900f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4327ac79fsm29829035ad.45.2026.06.12.19.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 19:28:57 -0700 (PDT)
Message-ID: <713470d1-0eee-461c-98ee-b7a378ebd0c2@gmail.com>
Date: Fri, 12 Jun 2026 19:28:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: claim Cyber2000 SPARC I/O aperture before ioremap
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux@armlinux.org.uk
References: <20260611035243.16192-1-chintanlike@gmail.com>
 <9df39aa0-4bac-4479-87d3-667c8dd8000a@gmx.de>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <9df39aa0-4bac-4479-87d3-667c8dd8000a@gmx.de>
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


>>        */
>>       unsigned char __iomem *iop;
>> +    if (!request_mem_region(0x3000000, 0x5000, "cyber2000fb iop")) {
>> +        printk(KERN_ERR "iga5000: cannot reserve I/O area 0x3000000\n");
> 
> pci_err() or pr_err() please.
> 
>> +        return -EBUSY;
>> +    }
>>       iop = ioremap(0x3000000, 0x5000);
>>       if (iop == NULL) {
>>           printk(KERN_ERR "iga5000: cannot map I/O\n");
> 
> while at it, use pci_err() here too then.
> 
> Helge

Hi Helge,

I initially left the existing printk() usage unchanged to keep the patch
focused on the memory resource reservation change and avoid unrelated
churn. Since you've suggested updating the error reporting as well, I'll
switch both messages to pci_err() in v2.

Thanks for the review.

Regards,
Chintan
