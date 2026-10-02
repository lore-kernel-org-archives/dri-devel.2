Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F797CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E0310E5E9;
	Fri,  2 Oct 2026 12:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="NiAzmk6W";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559E010E5E9
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790945513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B2xT9hRgPB5QRriD8h5Z5tNs8Qaw44VoG/fyOaMAKs4=;
 b=NiAzmk6Wx/uo6gP+bGspvIqcW4/tzggjR+c+Waz5L0ptwKMozTZa0We3eTPP+jdF7ADJZI
 MSa25urOY8+w60hYi2tvrk34rr9y2PC2IOUik9pTayLkEMIEFqqbEN6sGgnbC/+WLxTIah
 WOmkqGN2svoP9WKRNrlKsyXPCrdV3UU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-ERsV95_SPdqtz5_NBupm0g-1; Fri, 02 Oct 2026 08:51:50 -0400
X-MC-Unique: ERsV95_SPdqtz5_NBupm0g-1
X-Mimecast-MFC-AGG-ID: ERsV95_SPdqtz5_NBupm0g_1790945509
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48b028d93c5so1651186f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 05:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790945509; x=1791550309;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B2xT9hRgPB5QRriD8h5Z5tNs8Qaw44VoG/fyOaMAKs4=;
 b=vXgKWzE0pNVPO2jPU6JC7qQV1kiH8NwI4i/zFY0KWFqzU/eKMkRMKq/l8Lcql9B3Er
 sAckXrrVs1QRXVbYHqIgDEQ3ly4K7P/I5eGKDEMvaWV9QOIVf2YGB/ByH0pfwv8KA67t
 bG7Vf8riWYhmSZHUizisxquIAlSEwBazSF/jELhpBggsPw65aIr+ugUJ0tcWl5lQBogv
 3T9hPnY298p/u/hRSdSQRg5ltWcMj/+QVQH4M2JK9M2bEjhucWct6/d+cs9AiZzeCDxc
 tjFNlhBteHEBD39VhYhKRWmDREqJM15gJDjO7/lq6oEBWFKxwysXtXHmSfgkDGJNFdS4
 2aUw==
X-Gm-Message-State: AFq9FYLHfsbjc/GpL8MYVG3i5c/iJQrurOThq9DmXnrEmuZidG0rIWL0
 VkRlWZcExmP+1o5NEWwMCCTIpMAIYPKwQrHyAPUWk79i/SUbxHbTxJTaoBusp8xs0km/KlnWjwM
 Urib4HeiA1L79LMbFcRRzYrVekPXU6gEmKvlANAGhFTZmpIXbo/x0qlOhX/M146Ff3dO9GQ==
X-Gm-Gg: AYBFou3YapC8Mghxtr6yiZjScxUOhtGgelf5L1ksA1Aoz4EhtaOGIOzMv3sZXf9myKm
 H8LXgPRgMzFOOcwSh+NFPEeUp6tynklf0oV1QUFQIfVDqyhpSsf4yIPGEeXbir+7tBwX9tEaxbH
 LEgHpyJtF4zmVmxUUgA4Z/g9jmloA/byakdsaJ40ma2yqG7p1AHlOuR22hkWZztzbIaks3Lhh+a
 Z7HgMSuKYuOAgdPn/7osCC+RRTNxdaxuYbg+349lcQqTn/PQW3TNwl/YWf7OmBYJY67/QvmOEow
 z1SSm8ircOrm2PCqqCCgNv7lr6IS2gOYY5FrFiPacrpM/B+mrMb2157PNQLSRJSVaBNtqNFRO2R
 XCAR335RACuIdwDc0bNoZiDC8+T0L1qjrNCn5lLAqF3ZebuwaA7USmsogepNcXwgV3w==
X-Received: by 2002:a5d:5f53:0:b0:48b:74b:4ce8 with SMTP id
 ffacd0b85a97d-48b12754475mr6263162f8f.17.1790945508855; 
 Fri, 02 Oct 2026 05:51:48 -0700 (PDT)
X-Received: by 2002:a5d:5f53:0:b0:48b:74b:4ce8 with SMTP id
 ffacd0b85a97d-48b12754475mr6263100f8f.17.1790945508338; 
 Fri, 02 Oct 2026 05:51:48 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm5711527f8f.37.2026.10.02.05.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 05:51:47 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, ssengar@linux.microsoft.com,
 andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 6/7] drm/verisilicon: Do not include
 <drm/drm_simple_kms_helper.h>
In-Reply-To: <20261002124456.741011-7-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
 <20261002124456.741011-7-tzimmermann@suse.de>
Date: Fri, 02 Oct 2026 14:51:45 +0200
Message-ID: <xlv18q4g6za6.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dOBA95aALyV6ovmxXtHGWbOTc9G9TwU4Kqb7Cpj5QWg_1790945509
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

> The verisilicon driver does not require anything from the simple-kms
> header. Do not include it.
>
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

