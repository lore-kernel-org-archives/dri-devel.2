Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59659CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9783910E5DD;
	Fri,  2 Oct 2026 12:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fN56wsxK";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8319710E5DD
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790945495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GUF14AtWHioqMuqb6hp7f6A6RAbZhDlhHrFpBFNr570=;
 b=fN56wsxKxAfHrE2DxWI+4XyqqglAhXQvC0ZvnO+1Wi+rie8k5cMxz7uvmg/GdcVBiWRBDJ
 rPr/nYjLTS+giVDkr1vKtwx7esJlgz1qQtncFftnlixcONOymyO80GtUcz95cgbAmK8zHQ
 gsWCPtzrwUQHLDbj2G1/IaRQSConsys=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-Xyy2pEtsPqmJsJFZeTqy8Q-1; Fri, 02 Oct 2026 08:51:34 -0400
X-MC-Unique: Xyy2pEtsPqmJsJFZeTqy8Q-1
X-Mimecast-MFC-AGG-ID: Xyy2pEtsPqmJsJFZeTqy8Q_1790945492
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48b02e93a1eso2515712f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 05:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790945492; x=1791550292;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GUF14AtWHioqMuqb6hp7f6A6RAbZhDlhHrFpBFNr570=;
 b=zjKuUGzvwATLrqeT1Ctg7Jf7fPa7hO7T/YRA9wjgXUjzgqQ85TPRJc7lZdPPc4oTos
 nRW8Db37/Gy0o6FbCrpaNPe9+kBqFMHjBp0ggWafB99fkJYYpRwJJMCCuPeegCL9Jov+
 EqEUqVIsn3ZHGN88nHWGN2itwJvP9IvRo8VodI9wmu7mr+f4YGy3LGZy8dQRDvdrbGMk
 gDZmRlrLa4GUdeDVa9WWp50XHN7qiMTH2cgXVkSh/oiqR4tdYj+3dOzEmhBnhAtAkY02
 uRiJg8MFbn9qthAcvbJLxGqJrlznuBFODUfaY6F3KM8phuXUt5izliXdBlZ4iuvFvfkI
 lVXQ==
X-Gm-Message-State: AFq9FYKa34gDfCgEYLdTaDXXzQHYj5YbycZuDZFsESnE+fpqFO/nyn5e
 rnXRioUw9eTXbxwbFBj7J0Ffcr6Cm1b5oE0x8venHeZrC9hrcICNDO50Kgd3G0tRQ2V7gIqhLzW
 oDTK0KBZa48lAlzI8mSJ3I3KSN3XvgA06dJdlRCX9IaE1Cv8JclzeOZpRLT7igX0a9NmdoQ==
X-Gm-Gg: AYBFou3hre2C0He3oSa38N1OaRVHytlPnfBQiXRayfjoaF/U8Y7ekqS12x4xvCu+sjW
 P7RCP/dFPOCQ7zaPZWMPn2xRY/sD9J1GzHumjS05n2Raw8jucCmbNQkIhwTpjzB3ctHW5zSL347
 OLqiwtJSOmedLw6YBYNJRUa5VmXqAIOjK/M1C4GDxyBg2Q0zUKgCNjyVVlw+tDT2f94BtuBGFzW
 YLKpU/sU1+PkF4zlFMEXpOZB97cy5D4DbkwkFWgGR8rDUwXPGrbepEiBzojMU4ljmZ84NZgFToV
 AH1bxJd0qWTu2HlbgdjCKKGVku+WCLTHvnwZYFLu3MhAP1F3MxyOvOuYQMpuX9SHIwVtfcuySKK
 tdrCIukVsenwQ4kkfV+Jz7L8q/qgJW2BiJ/BP+ZJb9rSwWMjZblcMLZYgRXtIpGoYgg==
X-Received: by 2002:a05:6000:27cd:b0:48b:fc4:e84a with SMTP id
 ffacd0b85a97d-48b1271cdb0mr3218132f8f.11.1790945491976; 
 Fri, 02 Oct 2026 05:51:31 -0700 (PDT)
X-Received: by 2002:a05:6000:27cd:b0:48b:fc4:e84a with SMTP id
 ffacd0b85a97d-48b1271cdb0mr3218095f8f.11.1790945491489; 
 Fri, 02 Oct 2026 05:51:31 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b82253ae9sm4879135f8f.2.2026.10.02.05.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 05:51:31 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, ssengar@linux.microsoft.com,
 andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 5/7] drm/tegra: Do not include
 <drm/drm_simple_kms_helper.h>
In-Reply-To: <20261002124456.741011-6-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
 <20261002124456.741011-6-tzimmermann@suse.de>
Date: Fri, 02 Oct 2026 14:51:29 +0200
Message-ID: <xlv1bj9c6zam.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jHb79lsrzi7EBYprX_rfFCGH1bNqXcVmTV1xPglatK0_1790945492
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

> The tegra driver does not require anything from the simple-kms
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

