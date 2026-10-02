Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0390BCA5FE7
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CFC910F832;
	Fri,  2 Oct 2026 12:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="U1icpor6";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE80E10E763
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790945539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tCH7oA4DdPw+pCkiWuwkP5ynmVOdNK54ww31eSeUk6E=;
 b=U1icpor6JO/+XEIKdwhAuwb3f6RQRNdaZ5F7xa+yAxJe8Fn8t7YopWosEzYIg1P1SQDVzb
 roDq8J88PZgg8Bo7kpB/srJxesu4lFgg2YaYpdvn0ULeLXGVPUt0Rcexh9NMRXjRlV0jKK
 1B54xuO4K3mf4NNN3NUCamDjdsxOO7c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-r8jk5TqaMKm8eQQT3zKbDg-1; Fri, 02 Oct 2026 08:52:15 -0400
X-MC-Unique: r8jk5TqaMKm8eQQT3zKbDg-1
X-Mimecast-MFC-AGG-ID: r8jk5TqaMKm8eQQT3zKbDg_1790945535
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a0101292baso36816615e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 05:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790945534; x=1791550334;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tCH7oA4DdPw+pCkiWuwkP5ynmVOdNK54ww31eSeUk6E=;
 b=JCKqQ/elNnw317iTa+tckDGhqxVoeMg5TMTAW/8oFbazvGd4MR0szhwooOc+LUDPR6
 7yOJm41/Dq1LDMHre3l/1kmn29+PqoNhmJs68pebGV3/3AtuZpZ6PaEpdA9X03QRZX3q
 OmSLjhEakDupZBebGi3A3CFkf9IClxtBJo98GD7NQwW+R5ZhRjCdOkpo+zJQrPY1mwSp
 1DF+a/4+gerz63nTg/A5cx48ptBa6QyXzg1Bk1QKkgNx+GfN5NAVM5ZXFFU8zp+EhjQv
 TNOP0dc3/JNLVsN1JWga3VONMcrLft6O7XQiEuwfZt3WLfkEIX0I3cGT4R4Se88ige9L
 8IZg==
X-Gm-Message-State: AFuF++ltJKUR6xbzsWf9qGlfObpCzCqP+tkBQcCQ2J92L4q6BKEMrg6c
 uj0k2oKdEOTtFD6MpsoEfaCHVhSPBfY/9Dn3xPHxJ7P+sozmqUhEgjrxmtVAREQGft0EVQHwwWY
 cTME2GaSo2posDTtohiNI0o09WT08UewDiiruAW8hKg+O3ZlAGooYD88c4r0wK0tCANlkyYULBM
 tKlg==
X-Gm-Gg: AYBFou1QbKVIhxOK4j04HoxAW0HU4yoP7xL9u9iAInAVRGCxmMJ9wewDq27idGHcnyc
 tYxXObvebyVRc6XbqAEQFWuqy8hoMMBL3uz2exey1+pPxMz3f7+q0IN9vIGllXVbd7tdg/pP3Mg
 0aKsm6QM0zroBlKjDpA6fxO9KF/0oJtdeuanz6sk+TG/dIKS/6GwmVxjbldTEYO6XVm2VW7hFPv
 iV7zbgAyg8KZk95Z9SALxnJH6T+EFMRn3Y6kiNVTPDeg82Y1Ajp7iSX3qDZLcwwiAep9pjjoPbE
 2aWyP2V/8lCSN1sVlt/LaZcV8+pm0OT0kwwjnafbBWSe6w+0VcDhz1grV/jU6Kyzt5VDEqHGtMJ
 Ua21uPn0RbqNeZZ37z6OtsbXkbDLEN6YEJywONaXzQNTYDvt/TxcAHQH33nRebP0XaA==
X-Received: by 2002:a05:600c:1911:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-4a02756643dmr43591625e9.10.1790945534503; 
 Fri, 02 Oct 2026 05:52:14 -0700 (PDT)
X-Received: by 2002:a05:600c:1911:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-4a02756643dmr43591275e9.10.1790945533987; 
 Fri, 02 Oct 2026 05:52:13 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38105239sm7570526f8f.33.2026.10.02.05.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 05:52:13 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, ssengar@linux.microsoft.com,
 andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 7/7] drm/vc4: Do not include
 <drm/drm_simple_kms_helper.h>
In-Reply-To: <20261002124456.741011-8-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
 <20261002124456.741011-8-tzimmermann@suse.de>
Date: Fri, 02 Oct 2026 14:52:09 +0200
Message-ID: <xlv15wzk6z9i.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: isTROz4o5rnE92M3kXsig2580DUSdfWaKrX_JPp-glA_1790945535
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

> The vc4 driver does not require anything from the simple-kms
> header. Do not include it.
>
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

