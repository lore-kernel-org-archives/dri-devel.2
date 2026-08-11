Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62E3C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C01B010E72A;
	Tue, 11 Aug 2026 14:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="RZYxxq4P";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4487210EC4F
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786457938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1HU6LBDnWtUkFmucBW5pIeZXLIpgzR08eamvaDcYUA=;
 b=RZYxxq4P9YClxyrPIm81XjFoizPPKby/YlJOEAXkpS7avMWn3LnD+F+83tSiLV4GNZc6fH
 QQ4gd3y8qVkf5J/H3UDb9t/JJEdHx3eejF130+OwKidavt0mgXSU1DapsS6e4reGbANSoU
 liTsVpQPhsHdSVSwVle0tJM/BgTbteI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-uNj8_-awOkmwhVd6HyAKug-1; Tue, 11 Aug 2026 10:18:56 -0400
X-MC-Unique: uNj8_-awOkmwhVd6HyAKug-1
X-Mimecast-MFC-AGG-ID: uNj8_-awOkmwhVd6HyAKug_1786457936
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dd87656d3so3946907a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 07:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786457936; x=1787062736;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d1HU6LBDnWtUkFmucBW5pIeZXLIpgzR08eamvaDcYUA=;
 b=cGCFVAg48GRKdPDOXGX0p6YSFonn1UJ3Mf0ipkYxA+OapvhKTDgpUQMqDwxupKXg1e
 7xXXN/NC9b6lvT4X6hytl1gHLM2QNpUnWnn6eEv+kCn86Bg1Qpz85uLNEc3YeKKRmjg3
 yReN28ieMLlOSZt2RIkiz5eMeaiJmLTou8/M0ngnLSgl4/crKGHuMRmtNJ9E9M/RfKg8
 zwWN4f4S2RbyPw5LKHqiT2sxzv+8/kGy/ZsJDDazy2a+SUzRZkCgbK3lDeTOnHXirJ4Z
 VqADxc811+CBOOFSavaJRSPRNip/nOgaLD7whc7DVT5mpOVRfL7festwhhydUfKMyhva
 /L4g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpJpXwx0BtfHn2k27TZKJDqz82cxHP/jVIe1skoZHJsd9i+1vj2xNTNOyU611aI/TCXO4aHw23OPI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6MLV9oMIw5sDkQ0GpKmLadXLBG9IkaCZP+/GuGf2hRUTdwBaP
 Qj17PWFlkDfzUkOqjpN8vKQISEngdkVqbMPvhdFyZ2zqxHI1PtUt0/W8IwW7rctMJjXOobOnLWa
 Ahgli5KCH1znoNhyLMWSOFdBQcy2tskJ5jrnAis2fsCOaOwYCR5jWhu/ZeO0ACRYVkv1g4w==
X-Gm-Gg: AR+sD13tkjklp7oijTcpY9LjrWazP4v9ywdHWTyTnU91KVxciYlTU9fzM8UH7oTv5/1
 c+RQFL1Hn0K+i3+lZm9WE6SorZXbp2kDNSJiI5LDg+hl6lTgrOWHwMe9RH9G+zUPrD0kkEETT8O
 pTq+413nnZNayTTexgCtpwvGbZZ9Kj8yt1Pp1nTg0YwGKCfeqhF7SEngls8HnzGAQLSzmsKhPIg
 V9R7cQwF40krNgIXCKncd95PIBQmqLCJAfxpnxUvegQ/9wDNPxqDpn6khWvEp+tfkoR/lDU1/A+
 N6OINRke+sYuk/IygDODAFknzH4ABZfhcx+bEAn/hMy+K98nQwu2GLsJtyTcCT1+/NLdCUokpkV
 kUTs13hKzBXk/TUv8LSnuGA0kB4ERzg==
X-Received: by 2002:a17:90b:39c7:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-392ec5f1516mr3991881a91.12.1786457935626; 
 Tue, 11 Aug 2026 07:18:55 -0700 (PDT)
X-Received: by 2002:a17:90b:39c7:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-392ec5f1516mr3991746a91.12.1786457934885; 
 Tue, 11 Aug 2026 07:18:54 -0700 (PDT)
Received: from localhost ([181.122.135.46]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf67912dbsm42228eec.22.2026.08.11.07.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 07:18:54 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: airlied@gmail.com, andriy.shevchenko@intel.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, robh@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v3 3/3] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
In-Reply-To: <20260811122603.30773-1-amit.barzilai22@gmail.com>
References: <20260811122603.30773-1-amit.barzilai22@gmail.com>
Date: Tue, 11 Aug 2026 16:18:52 +0200
Message-ID: <875x1gpwoj.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DGreM4DFvLpUx00xiC-Stg7RPVFRFvSYUW1ObImnGCA_1786457936
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Amit Barzilai <amit.barzilai22@gmail.com> writes:

Hello Amit,

> Hey Javier,

[...]

>
> So for v4 I propose:
>
> - Keep ssd130x_write_cmds() writing SSD13XX_COMMAND per byte as it does
>   today, so there is no change to I2C or SPI wire behaviour anywhere in
>   the series.
>
> - Still do the ssd130x_write_cmd()/ssd130x_write_cmds() unification as
>   its own prep patch, as you asked. It removes the duplicated variadic
>   loop and gives a single place for the check below.
>
> - Add a bool cmd_params_are_data to ssd130x_deviceinfo, checked after
>   the first byte is sent to decide how to send the parameters. If it is
>   set, the parameters go through ssd130x_write_data(); otherwise the
>   existing byte-by-byte loop is used.
>
> - Drop the separate SPI transport patch entirely.
>
> The comment in the core will be phrased in the core's own terms this
> time: parameters go on the data path rather than as further command
> bytes, without mentioning D/C or any other transport-specific
> information.
>

Thanks for the explanations. Since you have given a lot of thought of this
I trust your judgement and agree with your plan. Let's see how the patches
look once you post them.

> Apologies for going back on something I already agreed to. If you still
> prefer it in the SPI layer I will do it that way and fold in the 0x00
> control byte change, with the I2C framing change called out in the
> commit message, but I wanted to flag the breakage before building on it.
> I have already implemented the fixes for most of the other comments
> locally. Once we settle this, I will submit the finished v4.
>

No need to apologize, I appreciate the deep thought and willing to not
break the I2C devices already supported.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

