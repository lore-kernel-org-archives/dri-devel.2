Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6984606A78F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ua9S8h+a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043DC10EF68;
	Mon, 16 Nov 2026 11:10:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BD510EF68
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794827411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uRTVYEsDszveZvZe7HLiwaYLtr8pHwx+WE+BtUNEJrU=;
 b=Ua9S8h+ae9wvOq5W8zJjatZzw2NmvNkUcaYAViYGpWW8Z3j/IuaHg3MKx9svFCvvLGjYKS
 SdIjeMkLVWn+I+vy3KKN2+XRAV+2mUG6QGDBGqu5xAl2Ba11D4gLfJkOMvmQTY+1NZV0AY
 csAsuz2LF7uLBUvAc4BTd17TT2qt86A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-NzbqB-nSNt6NG_dv2f5FCA-1; Mon, 16 Nov 2026 06:10:10 -0500
X-MC-Unique: NzbqB-nSNt6NG_dv2f5FCA-1
X-Mimecast-MFC-AGG-ID: NzbqB-nSNt6NG_dv2f5FCA_1794827409
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4ba078f26f4so20657335e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 03:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827409; x=1795432209;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uRTVYEsDszveZvZe7HLiwaYLtr8pHwx+WE+BtUNEJrU=;
 b=mmh0URUv4yYpOZdlELZHv8o3MR0zufDdyPuaciD29/8yY6i0x6uLQ6DhFGqojy3tet
 Lwcch+A1/YZvXPa6oLIMM/NmncjARbqnLA6tCS0NPtTUsGMgnG7Y4P44VQGvH3gE2GcS
 /cTctqQ1qEu6Dd+9VO0kZ5yO8GhsY8EB/WiC/OYttDodFXXitJhmJClWTioL+ECWFiMG
 9UadIKJDYhheUUeCycufup+0bk0JG/j5ZnwVF6WdBuLad+VfKmwKvClai1wWAind2gis
 u+YxiQYgGgSrkLT1u8mVFH00ww1oXFl7uaM68VHpoRhW6JmWb+wHpVC+OSC9OL8tM2Su
 j5Yw==
X-Gm-Message-State: APuU4Z+siasWh5H5dgJZdMJwVKsrqqtwfDZw7NWkC3/tr62/iO34esdL
 FNd26+qhfh2FOWqCB4nb5Tiju6q/5r578jOYjuK7ftbR5EOrh+6o/Slw296G1QfEZV2Qol7+6ya
 dcwIaHJWdTiwVhkPNEVwp+mRpV5hKGMbZZBe5Z45QaAugrQ86loHvr8TT2AgSUDrDYt0fOA==
X-Gm-Gg: AYBFou3vGLpu4RGhORknjGbcsnr7/hvD3rIGQnYhbKOdVSlwkEUqq6Ig7JHD/qZ1lgi
 LqF606XdyO/VHahlLzcfIgCs3NGC11i59qUrwlAz960dNNUYCnZGSmv81GdkdgcdMIxlz4DJw4N
 CfwJalz1obeEfWW3vK3ZvnyW4JrUqJhTjOuN2flrS3VT325JJJR+3YU/s6hkynlXbDiO9Uteoht
 UnYPg3b7hq261MgeKzXrN0dXiwcpDSHYFFyfZuW/dgBatIKmRX9g9iuPwC30FhBz10CMguZ0f+k
 ux2jviAxlOVM2GMPUJ+M41fpedNryYJcUlMUsGC+T3GfSCaAD9LRKxL3nzehNIFpYrH0R+wnAD4
 Qi9l/kYJ5YOFIOmAhySeuy4/EaZ0lGPw0nszTFgiZJ92JXcaX/DlqXVDXk8FoELN20Kr8nV0sjc
 uLEUQSlSqXBHV2/mYsZiHogmYBmOdYetWXWcHTNAg=
X-Received: by 2002:a05:600c:3ba1:b0:4bb:6847:792d with SMTP id
 5b1f17b1804b1-4bb68477c2dmr116141415e9.20.1794827408539; 
 Mon, 16 Nov 2026 03:10:08 -0800 (PST)
X-Received: by 2002:a05:600c:3ba1:b0:4bb:6847:792d with SMTP id
 5b1f17b1804b1-4bb68477c2dmr116140975e9.20.1794827407940; 
 Mon, 16 Nov 2026 03:10:07 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ac0e1esm255738645e9.3.2026.11.16.03.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:10:07 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Wentao Liang <vulab@iscas.ac.cn>, Thomas Zimmermann
 <tzimmermann@suse.de>, Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Wentao
 Liang <vulab@iscas.ac.cn>
Subject: Re: [PATCH v2] firmware/sysfb: Fix device reference count leak in
 sysfb_disable()
In-Reply-To: <1794071765.2669957.4378216502938475@iscas.ac.cn>
References: <20260916073815.1972045-1-vulab@iscas.ac.cn>
 <BN9PR12MB5146B7A8975825C3623CFF97F7B92@BN9PR12MB5146.namprd12.prod.outlook.com>
 <2d89b88f-863c-4e8d-839c-5e800b4c4902@suse.de>
 <1794071765.2669957.4378216502938475@iscas.ac.cn>
Date: Mon, 16 Nov 2026 12:10:05 +0100
Message-ID: <xlv1cxs5rq0i.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UFXdkEJ7-_yykmKGb0ZF8zWEkXhSE-QU1OtUkzmf3tA_1794827409
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Wentao Liang <vulab@iscas.ac.cn> writes:

Hello Wentao,

> Hi Thomas, Alex,
>
> Sorry for the very late reply, and thanks for the review.
>
> Alex, you asked whether sysfb_unregister() would still need to be called
> when the parent device lookup returns an error. It does: without a known
> parent we cannot tell whether the system framebuffer belongs to the
> calling device, and leaving it registered could make sysfb interfere with
> the native driver. Thomas, that is the defensive behaviour you suggested,
> so v2 unregisters unconditionally when sysfb_parent_dev() fails and only
> drops the reference on the non-error path.
>
> The reference leak fix itself is unchanged.
>
> From 8c5f084941a3b6aca5d3ae8cff0c3bd1d4ae1e6f Mon Sep 17 00:00:00 2001
> From: Wentao Liang <vulab@iscas.ac.cn>
> Date: Sat, 7 Nov 2026 17:02:27 +0000
> Subject: [PATCH v2] firmware/sysfb: Fix device reference count leak in
>  sysfb_disable()
>

Could you please post this as a separate thread? Otherwise I'm not sure if
tools like patman or dim would handle your patch correctly.

> sysfb_parent_dev() returns a pointer to &pdev->dev with an acquired
> reference when it finds the PCI device that contains the system
> framebuffer. sysfb_disable() never drops that reference, so a reference
> to the PCI device is leaked on every call that resolves a parent.
>
> Release the reference with put_device() before leaving the critical
> section.
>
> If the parent device cannot be determined, unregister the system
> framebuffer unconditionally, as it might still belong to the calling
> device. Leaving sysfb registered in that case can make it interfere
> with the native driver.
>
> Fixes: b49420d6a1ae ("video/aperture: optionally match the device in sysfb_disable()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
> - Sorry for the late reply.
> - Unregister the system framebuffer when the parent device lookup fails,
>   as pointed out by Alex Deucher and Thomas Zimmermann.
>
> Disclosure: the candidate was found with our static analysis tooling, and
> the audit and the fix were assisted by DeepSeek and GPT 6.1 sol.
> ---
>  drivers/firmware/sysfb.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>

This change makes sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

