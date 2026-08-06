Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4969FC5AC67
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE1E10F2ED;
	Thu,  6 Aug 2026 21:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="eeIRbe3I";
	dkim-atps=neutral
Received: from mail-oi1-f225.google.com (mail-oi1-f225.google.com
 [209.85.167.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 787BA10F2ED
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 21:19:52 +0000 (UTC)
Received: by mail-oi1-f225.google.com with SMTP id
 5614622812f47-489f3611e0cso1581941b6e.1
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 14:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786051191; x=1786655991;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sCIRRZenQ/KtG7UWZlCV8MwCf8+1g36iQjeU/KFIQpg=;
 b=gNiSYE/9Za4PYkDublmSj7Hqq5JTDZQXTphxnXqla0SdY1t2mZIlZ+pjR5Z1moEVq8
 6fH2rNIiENfxsRDRoO3+M4zIS1yElcdM6sqbNS+NNNIupVyLsIiBlKaFe7MH4SILquUu
 zi67EaMofaeZ+6JeUPIt4Amnz5kYEpwDU9KDmFNfDyAKRywRWbEQ32euYy8bZEQbZXLB
 MwkEU3IR5CRHW4cOe/eu/gB7rfW+V0p/IEMsS5qPiWw7J01U2d2XGHrS7smGzzXTTHPY
 NUBCoFpyWcIHXDq2nGscD6y1HAW9ZdYzaqC9mYQ2e49P2XFfZcwY3bBXqcwRBvT4qZTe
 OtUQ==
X-Gm-Message-State: AOJu0YyCBavrSLt8nExtA79uOVvm38gFkUQPSKXK9hU4jzZqvTC8wRo9
 4mr/QGWEmzZEZf+X9wtVIXHTgFGBTIvFei+kwUCKAE4d+QxpDbZjEKkw/smKBqY8k7aMP1T1bPr
 NFqJKYo4fnkFZtVvpX+xFeWguKSdZFTWpbPL2+uAv1Go2+XUrsdFkGGpCF38pIYWuZOZp+5Aq9l
 KcSPF1ux5Q0vRXIq66swWvIx+SdbOeOqgoysL0mnjJfq7CqNn1fd2nO7ROl7J8d1UgpW0Dhc3ni
 Sq7PHgVw0sWggMGGaKzXOzarcpB
X-Gm-Gg: AR+sD12coyZBWghCLXXfY7udsUxwZ19jzR0K45/sRqXhFKj8NBV49K3oiXR703/gpdb
 a+GQB49wQrS7jZ2vIjnHLPyDGX3gyeWqryWMM9ME3IDb2D0tQRKZlZdGnNn+R5WNs7y1mJ/oy3i
 GDiawe+aQlMQvGHOac9zb8Gb0/RAjfWSOm0OT4uF9vjvo9njtXolVZavJPhEMfL2OMWMeI9ZSGD
 uVS0SCDgXncJVesRqxnh6I4A5ki9d/osTXnK0avJXtMqkSKSzy3uPx/LiZ8kSgneYK3l9QlBk41
 rKEvmbcVPKWv7uQ6Gd9hBATVCindD71j7n9CeepJCiWllOJVfg40DXjJSpqk+SjPFUFHLS5JjBM
 /1dBmGe62nWFFrolqG9BVv84S3Ii8857MPEqjpcOqjkJs1bDVZIuAEg9kJUF7RZQDfK6h3bWdUG
 tiDmhoGur/SsZPv1hKYcVz/0tU8HCEI32GnquSHLas
X-Received: by 2002:a05:6808:3445:b0:495:f85b:38c0 with SMTP id
 5614622812f47-4afae0dd292mr9967496b6e.12.1786051191292; 
 Thu, 06 Aug 2026 14:19:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-7f1df5915c4sm1164622a34.5.2026.08.06.14.19.50
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Aug 2026 14:19:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb835525b10so3290236a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1786051190; x=1786655990;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sCIRRZenQ/KtG7UWZlCV8MwCf8+1g36iQjeU/KFIQpg=;
 b=eeIRbe3ICQ08cbJavQ7zSFcib4q2MF0ZTAtF794PcGQdhvy4F5z6XdQQIKDLx2iu2B
 v2T+jK+/Sp0x+PZiBQu38Si7ewnGbuGhSPxE5zysOtg3EutGnVq0Mvk8745i6REGv/nG
 0ckHViz4kdcmStRHHsCd9QijqZ6wh56IpUiCc=
X-Received: by 2002:a05:6a21:2293:b0:3c3:994f:b4f5 with SMTP id
 adf61e73a8af0-3cb85eefa11mr23378837637.28.1786051189899; 
 Thu, 06 Aug 2026 14:19:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:2293:b0:3c3:994f:b4f5 with SMTP id
 adf61e73a8af0-3cb85eefa11mr23378794637.28.1786051189417; 
 Thu, 06 Aug 2026 14:19:49 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141019a0528sm220059c88.1.2026.08.06.14.19.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 14:19:49 -0700 (PDT)
Message-ID: <5bbf4d74-d435-48d1-96ab-b119ce6fc4bc@broadcom.com>
Date: Thu, 6 Aug 2026 14:24:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/vmwgfx: graphics memory not returned after all GEM objects
 are released
To: Jellis Onsea | AccessWeb <jellis@accessweb.be>, zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com
References: <9a795e26-53de-41da-bdb8-9ced20b70e87@accessweb.be>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <9a795e26-53de-41da-bdb8-9ced20b70e87@accessweb.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
As Zack mentioned, we have had issues with kwin attempting to gem_close() handles
causing a memory leak.
I have submitted a fix for it in mesa and it has been backported to 26.1 as well.
Could you please test things again with that fix?

To do so you can build the svga mesa driver (https://gitlab.freedesktop.org/mesa/mesa)
on either the main branch or staging/26.1 branch.
Alternately you can also wait for the release of the next release of mesa 26.1 which
would happen august 12th, or mesa 26.2 which should be our august 29th.

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
