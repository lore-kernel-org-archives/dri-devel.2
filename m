Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4014ACD98F2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D1110F049;
	Wed, 17 Jun 2026 16:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A6PXb+e6";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8AC610F060
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 16:45:34 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-462ebd5d37dso36921f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781714733; x=1782319533; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=A1zq+Wkffhwt6DPuMr/sNaZlD6xfxWLIc+V5gFViAHY=;
 b=A6PXb+e6QlBUdMap2T6u1L41vlRstFcI3R3iwLe0KOAOe2j67o3XboD5q989ETL06o
 q6qj9vk/DtDX1a24XOmZretimzr1J+kRL7SEOe4Wa+44NiVI3WpgCpei/13d9or7RQH5
 sh/yLoGok34PojVAgJZFb4BkQkPQaGbCADbUeUFCn9oCR679hLRZklO4k2aqH2eFtYia
 Z7FHQ3ctvXd5lQ6mXWdMOmBREZotbro8h6ucsM3JOcNHKFSTETXno18lAR1QdAdYUWum
 YzjgSNuKsvagsl5R9+6s98NMJumXTWnQKkltXxnvElkmZ9BdYE/chPULcNiczp0UfJMT
 5Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781714733; x=1782319533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1zq+Wkffhwt6DPuMr/sNaZlD6xfxWLIc+V5gFViAHY=;
 b=CySczsPtG+/Hpc0zxad6hbbBYrnvpucBIoWQ8M26ySYhy3hYdF41Ct9WQwMTmgJFZe
 ye3RXUnLQrb4cZwOhzaO+mN+u7rz2IucbACyIb11HBoQ3MhV/Eovd/Q6LamJqQrap9k0
 G85LLZBJFIucdQmDk/P0Lj8GXZnTxcHIaGeBjuVRlny8GIMTZts14cscUcTa9iZ2YL0t
 WEzRFcYQS2pkUcxf9CFxmFz5UJFEliLJljwJIUSZJA1Z1SaG5j7MO5dBvJbjixrvdE7l
 mrDJ0hJf3kJLvZMZXnjKLU3hVZPoh6igeEECwMn8LYE4WhxnULblytPAZwTL7NM20kJH
 oFiA==
X-Gm-Message-State: AOJu0YwpPts569oDS5EhSAyQVUiDBaevtmZH4gjtN22n/M2hhpMEuFN2
 Dkv+us+YRjPYgAc3sU7GvE+w29WGGddiZXvJy5WD7lrCDz2EW1mpFwOC
X-Gm-Gg: Acq92OG3QDHYOHxD4u++tNSCT65Y5E3C5Ai/7ENOXgpXJEyXEAZ9msmSqVXNtn1rcjp
 qf78WJHZgBGqltQZuJbZSGBMwXCz/CIYuTlyXw9DVDcz35oyAuvAB05YoBUXHE/nGdlKLJEsHWl
 2G744QZ6sRMjFQtKkN/M0cMeAnqDVA8f672P1VU2YW/s141BwQdeaFe+HTF8jGP/dXIPMDZXfcW
 fHeu2KurfnSn4ymPMRKOKt08394Na9fGQDwadzNGWzgAbNjZJamLX1n4TsLmGBMvZ87ORTIYfH5
 tiWVgz/GKG+zAlUsDg29s9pI8QZfA+ubwtCNnZa+dVd6WNW68W/6mDPrSKJyzHJKDR90xv0KCJ2
 bBw/hl//91Js+2TPkMsLKJAYJM305TJaiGfAvOI2nccaj+Voc5Zi6YVr0l0s5/FkR5/Hz94nm0F
 WS6UpEnJKr+jGN0J3ri3/JABzpp9+XmFMfFzsvUXAbEeRydtNknl+4ht3E+Mxu5e2JstCd19H5O
 2dALmA=
X-Received: by 2002:a05:600c:c16a:b0:490:58ef:cea7 with SMTP id
 5b1f17b1804b1-49238226b0amr3695935e9.22.1781714732879; 
 Wed, 17 Jun 2026 09:45:32 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0c10sm54827640f8f.21.2026.06.17.09.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 09:45:31 -0700 (PDT)
Message-ID: <7da7d892-3b3c-4f83-b3b0-93eafe14e15e@gmail.com>
Date: Wed, 17 Jun 2026 17:45:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: sysfb: Mark CONFIG_SYSFB_SIMPLEFB as deprecated
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 sima@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260617081810.218168-1-tzimmermann@suse.de>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260617081810.218168-1-tzimmermann@suse.de>
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

Hi Thomas,

On 6/17/26 09:17, Thomas Zimmermann wrote:
> Mark CONFIG_SYSFB_SIMPLEFB as deprecated. Enabling it allows to

>  config SYSFB_SIMPLEFB
> -	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
> +	bool "Mark VGA/VBE/EFI FB as generic system framebuffer (deprecated)"

In v2, I think it also makes sense to add the 'transitional' attribute
to the Kconfig entry to help phase it out.

Also see this patch message for an explanation of 'transitional':
https://lore.kernel.org/all/20250923213422.1105654-2-kees@kernel.org/

- Julian Braha

