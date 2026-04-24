Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34E6FB44C6
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3434910F32E;
	Fri, 24 Apr 2026 07:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="F7Pypy7X";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3A010F32E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 07:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777016203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GR1I951DfLNllyU6188EDOfKm8/DNfw6yoqebTDFACA=;
 b=F7Pypy7XUBiLa7ez1NdbV2IG3l9nRoL2NRLKF3wuftrWSVf9w4b8BGpTUBIFq3o7TXjLQB
 ROI+hRZUGHInYJ1eUmQgkW/szZX8j9TexETmJ2DgQHCZnV2P5tWmfA72ycrxs5hoY6yUIb
 fQyr/XVKmLb/SzWXSUY6bJpxYaS9Hu0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-rVUZnIy-OJCqR5xKKZ-59A-1; Fri, 24 Apr 2026 03:36:41 -0400
X-MC-Unique: rVUZnIy-OJCqR5xKKZ-59A-1
X-Mimecast-MFC-AGG-ID: rVUZnIy-OJCqR5xKKZ-59A_1777016200
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso82005755e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 00:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777016200; x=1777621000;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GR1I951DfLNllyU6188EDOfKm8/DNfw6yoqebTDFACA=;
 b=nKx0m4EOh0I60IO8kqW5D3kx759nsGE7jt7rzJiMl+uiAmthMMd41UNpuTE8m9e/fh
 RrzCiQBABJpXM8cmGi6a4AuGOPzLOqT9htbAN2u2D4rimaaYTtR4NVgPUBHv++oycyq5
 phOczwTXbV3lqFiAjKgN2pJmSJ7bSkm2gFpWNfs6MGZyfLCrr2Gy9u8XYz9x+QOHCKtF
 oneEbHzKl7sMkTqS8j8CHOBicN1VFTpgWOcrbJH8m7JdP8fMczqz2ou+RmSXu9AYOabC
 OlZiWAhjRmU2k80SqtN47yIwtVmBTQCViwOZKASyXVWFqoLvtLxKN27i7P08yTxbmeAv
 xhsg==
X-Gm-Message-State: AOJu0YwjicowTghYZj91Tv47VNQAMqU6umYlavE7XHSAxURfEQaDqpf5
 Txd8G6G6YG5dRChYrLlBTUAD1Flh/2qxhIAzK3ugjBTAvehpgE4DCylL2LL9E5h8FdN+hsQPYVB
 rd52lOG9xHs/FKMJNLZH6wFw0P89A+XF9kUCAkRvoXMbfzRoIdgPZEVG+52Av8JXVst4Eag==
X-Gm-Gg: AeBDievP+qLmhaS2+QztEcas3et2ptJJh3v2pKTqSPVhBqEtXVI5spraKrFpN4cFbDH
 7sA9xVrmQmZV9F4OxUrbeum1RsRKi6yVMk6kGReiCquhU17T1/6s1KnEPKwD3vp91W2PFnIt3ih
 qXzBL0VbGYBLbz8mLnrfsVuJDSnCb1KyiuXRRn09rZ9TxHFO6qzTKXPcP3KfvZ/bZS5su5DhupA
 /LhvvLQHA1Q7oyeNflMLN5PGhuovj47xnbnYMY1bCMz/B7Hj3bzKzwWvh89w3o17Rv+0yY2C5dC
 lNm6vOr6HKWUNqOw7UaCXDpT5kvpHRTmXJiBwqd9PVzGRrwTHW28ftSxCBjV82DhQ5Pg1wWXiRG
 ZnB8/TAREOiQrMWwAYl5SbBWzfe9gk9dAtvbNl5R3GWGqbMwDOQW9CZIg2JpHp3580cUNXUmx
X-Received: by 2002:a05:600c:859a:b0:48a:53ea:13eb with SMTP id
 5b1f17b1804b1-48a53ea15bdmr170455135e9.5.1777016200478; 
 Fri, 24 Apr 2026 00:36:40 -0700 (PDT)
X-Received: by 2002:a05:600c:859a:b0:48a:53ea:13eb with SMTP id
 5b1f17b1804b1-48a53ea15bdmr170454735e9.5.1777016200010; 
 Fri, 24 Apr 2026 00:36:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb77b001sm272603645e9.3.2026.04.24.00.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 00:36:38 -0700 (PDT)
Message-ID: <5155f29b-bc4d-4e60-9a26-22d568c43e46@redhat.com>
Date: Fri, 24 Apr 2026 09:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: further issues with MGA G200 graphics chipset
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Jacob Keller <jacob.e.keller@intel.com>,
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
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <a23413a4-f939-4a23-996f-4ba5c8294c59@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _RFiYyFuN23LQWzLbjJv3GXIBQNRCL-_UQavgH3ZRrU_1777016200
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
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

On 24/04/2026 08:20, Thomas Zimmermann wrote:
> Hi
> 
> Am 23.04.26 um 21:42 schrieb Jacob Keller:
> [...]
>> Unfortunately, I also have no better idea than a DMI quirk table to
>> record known platforms that include the controller but don't have a
>> physical VGA connection exposed.
> 
> I'm in favor of this. If you send a meaningful DMI identifier for your 
> system, I'd make you a patch for testing.

I didn't find something related to VGA connector in dmidecode.
My suggestion would be to use the chassis-type [1], and disable polling 
on Blade (0x1C and 0x1D) and Rack Mount (0x17) as they are less likely 
to have a real VGA monitor connected.
My Dell T310, which is kind of a Tower, has a chassis-type of 0x11 "Main 
server chassis" so it might not be very reliable.

Another option would be to disable polling if PREEMPT_RT is set, so if 
the user expects low latency, he can actually have it.

Last resort is that the driver did work for 2 decades without polling 
the VGA connector, maybe we can revert to that behavior.

-- 

Jocelyn

[1] 
https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.9.0.pdf

> 
> I don't know of any way for detecting the presence of a physical VGA 
> connector BTW.
> 
> Best regards
> Thomas
> 
>>
>> Thus, I'm wondering what else we can do? Using WQ_UNBOUND might help
>> somewhat? I have no idea if its safe to sleep instead of spin while
>> reading the i2c connections... As far as I can tell the non-atomic
>> version has nothing that *strictly* prevents sleep.. but maybe i2c
>> access has tighter timing requirements than what usleep_range can
>> fulfill? I am not sure...
>>
>> I'd just really like to not have to worry about going to every single
>> user and asking them to unload and ban a driver for these big server
>> platforms...
> 

