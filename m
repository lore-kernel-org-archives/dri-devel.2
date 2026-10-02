Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7C7CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B0A410E5C0;
	Fri,  2 Oct 2026 12:50:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="AkJrYX4A";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DBAD10E598
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790945445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bgkxJeBOF/HSWVBaDgnuL2peb+Evry2VYAsjv931SDI=;
 b=AkJrYX4ADw+O1qseUd9EMxK9VQSF7IAbLLusEQxFaIfn3P6FPjgjFUICeS1e8mYgY4t/oG
 pbd4YKp9/9oePVYiaMZLFfijCwn6tSncP9Hsu0gBGRvv9ghdLSJEdKu4UBNLs08mh1tJdG
 MvPlVPeZ0/oOd4NJtwOGt9UhiOhofXg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-bzHf0KL4P-6epVvmWSHNZQ-1; Fri, 02 Oct 2026 08:50:42 -0400
X-MC-Unique: bzHf0KL4P-6epVvmWSHNZQ-1
X-Mimecast-MFC-AGG-ID: bzHf0KL4P-6epVvmWSHNZQ_1790945441
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1624abeacso35295e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 05:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790945441; x=1791550241;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bgkxJeBOF/HSWVBaDgnuL2peb+Evry2VYAsjv931SDI=;
 b=AdwuZibvysee5LGD6bWm2KAI2BTn3KBWhQKbAgnpzbVaT4f0BRrTUauO/qp97XyRkA
 2F8hvMQi5MOSjR92wzQ8gw/pqGGwrqozhFPvLz9BkRksmArp9ix0Y1Tnde0F6sCbwcAZ
 O6jSCELXUCTe7usQWqpmoltxeW+Uz6z7Md+H82kUC0XmBQmlqvzzgqIHE2eHXInvs2Nm
 CjUgmvwnjhE/6LkXQ4/eAID02eh//WKWfeOVxso7LffCr9YcdcLz1qLS0jStpATP491s
 IkhAxAYyT3y+WpV59ZVaSDXBCl/vZ7V0VvKMqMyS4Q9GS52aKhuIqG/myzkFIKvJxot4
 3PdQ==
X-Gm-Message-State: AFuF++nRx9fKQrlDjCsGdIEiL07m+gGlChzrsQWGkR93Gd/8/om0GBfW
 5Sn8TghK/vJP1/FnQhap/TnBGVQaZdhlnpB7IOapTyJKDv4qbIfoF71Ie2vgAPCBLML3mk1aZZt
 7oJ9aesXdtLcygcvxeVXXo6uVWnTN0Lv+W0P3HeO+04tKNU54KjRJDNcZVjXg6JA5WajP+w==
X-Gm-Gg: AYBFou1SNcFbFgpovkdwxrd181IHqASaUddi++JDNnkK/s6zkvd0qzbsWoKH1T5P+vv
 cqloWoXWF//qzAdV/UT2UZLJDQkTWudmZf+ox1Y4/tSaPaDwBZYXIAD4QbXI+42X9YQEWjyta1+
 +FDX4pIQxFfITc922LDf8TBJ6ZgWQrDmnwxrySfvpq9uCWop2wWxq/EiwBxuXx46VV1p3ngIvQM
 QNEA75WNFe0Ju71NRjFAK5VkWBkuoH8GQOden89I1U/4G2D/pCNunFhPk7Z5ApkrbXW4ePcxKCf
 cNjpWE5NI5qvIRWTGoQQvhPYM92W0q0w9vmr43P12+kZgq1beqgCzX6LNhTGjLLRnZD/3+R7LIS
 2nI76LBdVrjCqwqyXVcjUZ7AQoA3rqbKEMhSRZ6jdb3hjbwiLT33F6VQcSfl7NTWAjw==
X-Received: by 2002:a05:600c:3501:b0:4a0:1723:2d8e with SMTP id
 5b1f17b1804b1-4a0274f3bcdmr48922535e9.2.1790945440681; 
 Fri, 02 Oct 2026 05:50:40 -0700 (PDT)
X-Received: by 2002:a05:600c:3501:b0:4a0:1723:2d8e with SMTP id
 5b1f17b1804b1-4a0274f3bcdmr48922205e9.2.1790945440249; 
 Fri, 02 Oct 2026 05:50:40 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a162e867e8sm30310575e9.15.2026.10.02.05.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 05:50:39 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, ssengar@linux.microsoft.com,
 andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 1/7] drm/hyperv: Add missing include statements
In-Reply-To: <20261002124456.741011-2-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
 <20261002124456.741011-2-tzimmermann@suse.de>
Date: Fri, 02 Oct 2026 14:50:38 +0200
Message-ID: <xlv1jyo06zc1.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o02b62kIuR7d-a7Rwc8_kSoEXTzmcyGQ-djOeguS-JI_1790945441
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

> Hyperv-drm gets a number of headers via <drm/drm_simple_kms_helper.h>.
> Include the files directly so that the simple-kms header doesn't have
> to.
>
> v2:
> - remove simple-kms include statements (Javier)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

