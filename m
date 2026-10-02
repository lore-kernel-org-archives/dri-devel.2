Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22844CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C53410E5C8;
	Fri,  2 Oct 2026 12:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="atIgTIth";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E73C910E5C8
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790945479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PXxRsRzuT/lLVwUTudBZrzfm5MyaTiR0eopkV7RSLVU=;
 b=atIgTIthjjOpKzHImRlDobJ+m2Iyw8z1/NmGSnbF67y+owkubwGOd3415wUIUamObxr+3A
 jeeDe69AGUSQ4ZePWxkBFThVBjyCq2Kfy4Ah1dUEl4v0Uvc0Xzo7q+9RDhus9xbBiW4RZ5
 uwqvSkZyLrX1G9GAusMUaaaI6KV1cSc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-Nn4DaDm5PHuUrvMthQqCpw-1; Fri, 02 Oct 2026 08:51:17 -0400
X-MC-Unique: Nn4DaDm5PHuUrvMthQqCpw-1
X-Mimecast-MFC-AGG-ID: Nn4DaDm5PHuUrvMthQqCpw_1790945476
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a022fee32fso56855e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 05:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790945476; x=1791550276;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PXxRsRzuT/lLVwUTudBZrzfm5MyaTiR0eopkV7RSLVU=;
 b=HBz8dn69w2T+sWvMc/Ew0lt+5h9Rxkh3bYckUzJhuE6I2WXtq7d43JgXxHtqouQ/Y+
 Tu3ko0TYfCqfIn3M4eZy3Ye/wTVUkfqXzZSzTZH00S80b1xIbtoDgtvBK0yGPFzK3+MH
 O8gZWY4kRfhT/9EN+oCeGuCPk3TM1e/flo8gp4cWSvf16/fh0raG/ZtbHTu6nVmZRNUE
 smNHm+qjsXWMyEfu27Ck60V+WkM7Ca9DHI2pGXSVl6SGtiX95WNzUEs3VpXiM2tDCEs/
 FsbhDC6WN6ImL8sePkDGB0/C5oRhMCPmf81uHsUGD15WssP06OpGoJPyCd3A5Dujuxoz
 R0pg==
X-Gm-Message-State: AFuF++nP/dmGA8nA8zN37ajVSX4Z+lCA5VpxvIfXPni0kzVGlhL0lKAo
 bQsIQGTJG8XmlFCNQ6S0vRhRkjh+QnA1inBld42ya5p0udiaAhLr0RgZPxXggKZTW3eOr4yzrpr
 jxvS489hx0OcxphzAxYpkWx6yKrtgbXuSsE/wRihnjPP+4dA/bySWd1jjHz3m13RkagsgMg==
X-Gm-Gg: AYBFou0giBvQYdoI2UFwQTv/QAi51RE+lzUnQG3xHvPq1zstdPQhdbrbbuY+HDNxi3A
 l5WEHPAaqZ1BHB7WP6mVwIShGtkXrA3C0/C1gEvKE3F1fYaZJJMRI6ixiPxrKUFgdaP0Jhbk3OF
 SkRy1uvXLDhkvieMZU0CKi5UvmYlByY721qIuTiMwaguSd7xlmkOrCgiAb78pkd260CW7aeDZG6
 vzm8jMPd9zYuXBD51amk5+ZCg1rgnhUKY3xvYjdkDzZg+Vva9BelS9I0nHTcxaoNmrhCgV9XZ6D
 HnxRKYflMuPSgtPvEtnkP0EYBJNh2Lh+F2Dqw+t8JuHckCA4iYF8sU3ZMPLjnhDEV/F5nAeyAWc
 0vZjG/D0Thp2Z+PMkp4Dx6kzZ6ns7NcbsoMnYF9qLGDIjG/0rS6zENhdbLtM+7/7O9A==
X-Received: by 2002:a05:600c:6098:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4a0274e9d3dmr46216585e9.1.1790945476434; 
 Fri, 02 Oct 2026 05:51:16 -0700 (PDT)
X-Received: by 2002:a05:600c:6098:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4a0274e9d3dmr46216415e9.1.1790945476056; 
 Fri, 02 Oct 2026 05:51:16 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280bcf0fsm88527965e9.6.2026.10.02.05.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 05:51:15 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, ssengar@linux.microsoft.com,
 andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 4/7] drm/hisilicon/hibmc: Do not include
 <drm/drm_simple_kms_helper.h>
In-Reply-To: <20261002124456.741011-5-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
 <20261002124456.741011-5-tzimmermann@suse.de>
Date: Fri, 02 Oct 2026 14:51:14 +0200
Message-ID: <xlv1ece86zb1.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1aau-F74YCgD7_s71P1Kx00k26QWGnGsEffWIOdy0do_1790945476
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

> The hibmc driver does not require anything from the simple-kms
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

