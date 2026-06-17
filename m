Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C55DCD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 972C210E2DC;
	Wed, 17 Jun 2026 08:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UcyjAeZJ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 476FF10E2DC
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781685973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pFhQQHKU3t1hnJ/IuHZdwIg4ogrFO0iWtKlJaJoc+2M=;
 b=UcyjAeZJkN3AbJ0NRn0DIj+RhSE/J9HfP2v8p8aMkXQTc33Ce6E/lVBOMZwkI1g3bVuAUY
 WOB5bPOVpzn3rG2zldKoem58KGtr7Eril67s3OApirsapU7cdom8Tm3UIb+mHGz5oc4aFf
 hefvUt2/rBertbihMMW7pYsbic57DBc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-1_QYC2mYPLqyAE_yvL41qg-1; Wed, 17 Jun 2026 04:46:11 -0400
X-MC-Unique: 1_QYC2mYPLqyAE_yvL41qg-1
X-Mimecast-MFC-AGG-ID: 1_QYC2mYPLqyAE_yvL41qg_1781685970
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-462d8ccf553so233389f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 01:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781685970; x=1782290770;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pFhQQHKU3t1hnJ/IuHZdwIg4ogrFO0iWtKlJaJoc+2M=;
 b=f+ymqsyvuXcv1qEXSn7944jIVFd1gGk8mHMFf2rFNMOUX6FM9VQc9BjQMRlOX/khKX
 jcbuieapJ710BW8wxB2drIb/MqR2Nkeeazx9zeMDow7bJU7NFR3nf7mHnjNtpw8CWofK
 LII9V24gZxhW2Hjp0XnRUQjdNNOMHG7xzGbpdPUuaMUuzsWdD6e3hgNoZGRVfOmJRQuK
 RLIeMCiIpAMzLfHFbZeSEwSCm4j0d14ZTdI6KHzc86Tjku0BJcthdr0iv+1U6FsxOECl
 dUgedonnWqJ+Duuaf8VZEFwEW9CecJeOKVp4HU1nduI+xnqIYcOax+1zFllRF/RSZHRC
 eD0Q==
X-Gm-Message-State: AOJu0YzbTjbPDIw4LEq0z1T32+cGDI3UuwZQGEOnjUgZchAN1S5skMbi
 QqrekMDx+x85FrUYY/wzb9gaQ0hqqhE5gMM5ijebusC0lqbJmZ7yzERyHsrT0Ap6APEYHSfri/E
 r3qBwGqFxqhAOJ3u8lYnuewTAfV5JMWe4sY5xi5hl6ernM6++KTpCwrwTWWP8zzy2ZYLyUQ==
X-Gm-Gg: AfdE7clN1cz/DA1DVfUV8d3xqa1AiacWbe/miMcH/h5JQlvNrfBSPwcClDNb5mCCQs4
 +QMtY6UU4aujQr46zpZUEPm3xJlcegIQqI/h6KFH5p/UgZyeASdhm2Nh7f678SQFqJmG7EkboQn
 VLEEpdOkBxtSOEYHRdULGN8tN4BOM+enN8Qb/dW54mvwSc4XWcodJBBTi2u5gwOPC/0Z72/sMXW
 NxVzHGKIfesPJYQMAmmbeVaHsSGVdGl9Z3pQ31rcLNx9DZEf5xSXsdcYxsqwqoeGp8iwnjAg12y
 xzrVsg4VgaSXY8GGVGGUZIOf68i5xsnnyhRLoArzRH3HHeIXm4gqUxw8UpmHhxRZ1xmra5/r0GA
 W8Hh1/N/Uuoyt0BTfpMAfjsNZSqk/ZAxy54ttvQNFVeSA70OJ1/r30PSx/CNuyuuk66xgeA==
X-Received: by 2002:a05:6000:4206:b0:462:d07e:4bc4 with SMTP id
 ffacd0b85a97d-462d07e4dd6mr2154267f8f.7.1781685970469; 
 Wed, 17 Jun 2026 01:46:10 -0700 (PDT)
X-Received: by 2002:a05:6000:4206:b0:462:d07e:4bc4 with SMTP id
 ffacd0b85a97d-462d07e4dd6mr2154194f8f.7.1781685969953; 
 Wed, 17 Jun 2026 01:46:09 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f726sm49513436f8f.15.2026.06.17.01.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:46:08 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, sima@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] firmware: sysfb: Mark CONFIG_SYSFB_SIMPLEFB as deprecated
In-Reply-To: <20260617081810.218168-1-tzimmermann@suse.de>
References: <20260617081810.218168-1-tzimmermann@suse.de>
Date: Wed, 17 Jun 2026 10:46:07 +0200
Message-ID: <877bnxzh9s.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r2Uk3USNaa68MF-cnThuMvECOkRlPgghwjAA5Ia5-V4_1781685970
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

Thanks for the patch.

> Mark CONFIG_SYSFB_SIMPLEFB as deprecated. Enabling it allows to
> run simpledrm and simplefb on EFI/VESA framebuffers. Doing this
> is discouraged in favor of using efidrm and vesadrm.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Do you know what the policy is for removal? For example,
how many Linux releases should we wait for this to go away?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

