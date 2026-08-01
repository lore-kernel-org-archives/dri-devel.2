Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E18C55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 18:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F88510E375;
	Sat,  1 Aug 2026 18:12:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="VsJ1Mlt4";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E7410E375
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785607923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QuTNiFWTTsXb3gAvFi53MKk8btbhasMaATEQzE79DwE=;
 b=VsJ1Mlt45tmQM6mNKZAcHo/isWyA56noSToIFFAiEhX7/3knzuMXgfDhAbr3VPqzppvp/c
 /zZSF9Y/HB768a4BcH9+ERJBZpUCuvWagHC856JY6oFfcTTY37oNrcxKvU9VdoV6rlITBt
 ldYKhAWnGlr1KnLrsEDLGhVYAlJLsPg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-FNF9DRLsOsi_E-l2hWoNmw-1; Sat, 01 Aug 2026 14:12:01 -0400
X-MC-Unique: FNF9DRLsOsi_E-l2hWoNmw-1
X-Mimecast-MFC-AGG-ID: FNF9DRLsOsi_E-l2hWoNmw_1785607921
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-496b6f97676so9150025e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 11:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785607920; x=1786212720;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QuTNiFWTTsXb3gAvFi53MKk8btbhasMaATEQzE79DwE=;
 b=Il1BjCk35cM6q5l9+0kKJhNOELyK635OTzCmb3l5beNFm1r6qlzr9Q7QiA+dtFT4jF
 5AcCQozIIl8IWDKozPjKurSQLc/S4k6fq3FjDi411s9MSX5bdMz8DVLRM6Cc+zpfD4+r
 7AyO6IKw9XHrPlqk9AtEeXoo9U03v+/R91hSJUOApSndzC8cA4LEP4JPMowx6tT81IXY
 MYYfX8Eoy576/LYfA60BkhMcJ9j2w+w8+715/aRQ2e8wFDUpOjhnkwzELMvyTjYmdfQA
 qnyILo5y+vRBOipZq1q5oqtjX01Dk6AUKw3DcPMxRxoqGgDd506z27xR29fj3a+cPK0+
 Eg9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoURQyEuTFSJEQeogVhLv3CRuF91UuhLDNXfgSDd12HiXtP5hnUbm+8uWI4G39OASQdzMLNloiVR0o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhW6rAuBg/1C7w8mseKvm6SSOBOsuOc6O0NET99Na1W/XVcupu
 mbHxgb1XMWi4/Qatqo7t19vBJMBf57pzloGijDwrhaNyi9zvH0gIzMFrRVZyfeRCxyjliRcteW0
 Eh4/V90fNDqGXp9fVmqAFWk0xAYaK74FyHPz4YNz4s7Bevw1ILJ518c3+5EMVpCHNqPP0tA==
X-Gm-Gg: AR+sD138Q7sR34WRy5CIT0xruOI62dQ2hD11PkYt+/50HMBeF0GZfAmsS+t4fYcC+iq
 1S+MZSZAnltcIeE4ewLGwisIx/ZHbBs+B391Vj3bbm9p2klEmoRzYKKObXHFL9PQyV1L8rgy84n
 aLDBpEpeXMwYDLqekytD/EEV5EXHvclTFxJP4vRFGX7XJxxjRthCk28VzMVd4pDRMVRy6/Fc6PD
 +Zh/gDG6gbILskaJ7Eqv823rLSaCQjI2nogCHDBSDkkHvkp+l7DIdN26n/2J+j2RWhfm4b1lBQ7
 wu1YZtZWN11CHZGC6VI0KNtD0L75olyx+ytkf6LsY0AXtidLB+KMIKcEJCFsYvAPsGRCmnSrtL7
 uKGGEWZWovrlHTAtsT87KypHah4zDVo2215N96z+w2pyMwVp2qKm98ZkfeoM=
X-Received: by 2002:a05:600c:840f:b0:493:c42e:5be0 with SMTP id
 5b1f17b1804b1-4980c60705amr64842225e9.0.1785607920457; 
 Sat, 01 Aug 2026 11:12:00 -0700 (PDT)
X-Received: by 2002:a05:600c:840f:b0:493:c42e:5be0 with SMTP id
 5b1f17b1804b1-4980c60705amr64841705e9.0.1785607919932; 
 Sat, 01 Aug 2026 11:11:59 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980878dcb4sm117791635e9.13.2026.08.01.11.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 11:11:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Helge Deller <deller@gmx.de>, Jakub Turek <jakub.turek@elsta.tech>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fbdev: ssd1307fb: add support for Sino Wealth
 SH1107 controller
In-Reply-To: <a90747ae-e2c0-4add-9fff-1ff473d1b410@gmx.de>
References: <20260731-feat-sh1107-v2-0-0d2893e44ebd@elsta.tech>
 <20260731-feat-sh1107-v2-1-0d2893e44ebd@elsta.tech>
 <a90747ae-e2c0-4add-9fff-1ff473d1b410@gmx.de>
Date: Sat, 01 Aug 2026 20:11:57 +0200
Message-ID: <87y0epd82a.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J_HjU3TDpk4sLUZcbR-3LtlRXuCpbafjgSY2x_vYs5A_1785607921
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

Helge Deller <deller@gmx.de> writes:

Hello Helge,

> On 7/31/26 16:45, Jakub Turek wrote:
>> The SH1107 display controller is very similar to SSD1307 but the main
>> difference is that SH1107 has different memory layout and uses page mode
>> adressation only.
>> 
>> The SH1107 relies primarily on vertical page addressing mode where the
>> internal 128x128 GDDRAM is split into 16 vertical pages, rather than
>> the horizontal/tile addressing modes natively utilized by the
>> SSD1306/SSD1307.
>> 
>> Signed-off-by: Jakub Turek <jakub.turek@elsta.tech>
>> ---
>>   drivers/video/fbdev/ssd1307fb.c | 87 +++++++++++++++++++++++++++++++++++------
>>   1 file changed, 76 insertions(+), 11 deletions(-)
> series applied.
>

Why did you apply the series? I mentioned in v1 that Jakub instead should
use the KMS ssd130x driver that already support variants that use page
addressing, such as the SH1106 (adding SSH1107 should be trivial).

Also, Sashiko correctly pointed out that the fbdev driver doesn't support
most of the properties mentioned in the DT binding schema.

Now is the opposite given that you merged the DT binding patch. The ssd130x
driver doesn't have support for the "sinowealth,sh1107" compatible string
that is being added by patch 2/2.

I guess that should post a patch to delete the ssd1307fb, to make clear that
shouldn't be used anymore since we have a KMS driver that has better support.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

