Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E762606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hEfU5TKE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B21B510E5AF;
	Tue, 17 Nov 2026 09:13:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E286610E5AF
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794906809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3vCu5O5rBFup8zOyNToLTiowXoRh2airbpyexQsIArg=;
 b=hEfU5TKEvfmr3dpcoxmvXHWggQkFD9TgA9PhdMgxaoeJDF1sQ/v4f/o5q6bog5VUXIUpFX
 QsPtp9ML4oRtr5uIb0pIYzwbynErJKElcHR5HoHNOFx6Xp2XsaYSOWUUTN+HiHa27DMOI+
 +EA+jkeDL+nFCS51fcGg62pDqiFboZ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-8ZugzuopOZiAginrs_EA3Q-1; Tue, 17 Nov 2026 04:13:27 -0500
X-MC-Unique: 8ZugzuopOZiAginrs_EA3Q-1
X-Mimecast-MFC-AGG-ID: 8ZugzuopOZiAginrs_EA3Q_1794906806
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4bb680f0ac4so16524085e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794906806; x=1795511606;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3vCu5O5rBFup8zOyNToLTiowXoRh2airbpyexQsIArg=;
 b=1cLweAo7WdSZ0VdL/YZN/H96Qn88AJZOAc/T838Cq5i6dSTZxRYYSuTD3UCks9TniG
 N6FFXWx4MmUou/tzLENzsgiAW97lT+20qytEZJyklKXdWNPglBoBAZg+0QVh3LBm3AGa
 Xa4YdcaNQUXkoTBk3ydHT34UdIlDRbxSwHY2Lj/jM7oVsFxLHbcnwSDwo/D6Eqa0suOp
 Nm1Wg5T8IyN/G/obB/qVeHO9+5jWPiWnr0Dx2WuitzvaM1VZpgCvnzv+twO8oX1PjCZj
 ursLvc0kZiUhQ1yXOtdFPRwwVchmnZqrTbRrzMUw+zHXcXk5heR1lY4wuEkm8oFzH+jY
 be7g==
X-Gm-Message-State: APuU4Z8qGhjjEPgeT0yQK/CeWWu5jiFUKS+bQdiyXVRqPHZtmDMG7NqE
 eB16b4Jt7pxJvzJKC0NUIxAqIF7KA/eRgJC1SkseXj1fZwYW9ZAXeONhFlfj7acxpV/2tlqDH8V
 Uc1hbJZU3X5ym/gqdijww5qCd878rJwD1CAbIm1xjo87jjVwkOIclaahDk/+pZbrNYgiEyw==
X-Gm-Gg: AYBFou3ZnyENrcpeTZbKysAevOPX96ctQwreykrVi4fJjz3uTgrEmdpq8vkk1gRi08G
 En8LfUFnTXFElC21FCbPL85KfzzekKDu6+8EYoPmOUEKjqA5l26mKKfH4U7LGUCOegfq695zt+t
 v0P6Kqs7HIfk9qyTGpNmyGdWgsXAKspd/ZojMIRO16biOsR7Tuntlj6nDAagZ+FVy1SKQBUQbur
 MliKOyVKwnh+BxDaJGHwNveCke1IHem+427zk8unKN1D0BLoCmmC5IkUeLLudjPLiytMXIHgunz
 vbdUMY2fImr6jlUxEZN0SxwayOBFfZWr7s/SkSGC3aHMI71on5+CwnIa0SHdOrEk0GLjb0U6b4f
 V4wH5fb8W5LwX+cgJAU1eZjEkjENCqzwySzlCKO4UnMsy3G1Kr2cN1tSFvy2laV4Vrc5WnvczCM
 qzwlmGxCgCguqSI0B0rHZxXc0l7Q74WXlSjOWpia8=
X-Received: by 2002:a05:600c:46d1:b0:4a7:7f3f:6f8e with SMTP id
 5b1f17b1804b1-4bb76d62556mr75648885e9.0.1794906806327; 
 Tue, 17 Nov 2026 01:13:26 -0800 (PST)
X-Received: by 2002:a05:600c:46d1:b0:4a7:7f3f:6f8e with SMTP id
 5b1f17b1804b1-4bb76d62556mr75648285e9.0.1794906805843; 
 Tue, 17 Nov 2026 01:13:25 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7ad9430asm16989955e9.15.2026.11.17.01.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 01:13:25 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] firmware: sysfb: Remove CONFIG_SYSFB_SIMPLEFB
In-Reply-To: <20261117084514.367399-1-tzimmermann@suse.de>
References: <20261117084514.367399-1-tzimmermann@suse.de>
Date: Tue, 17 Nov 2026 10:13:24 +0100
Message-ID: <xlv17bibstvv.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p4WMIE6vDHNzC5D_NhBCjocx2THsNLhUiD56BXb9ZwA_1794906806
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Enabling SYSFB_SIMPLEFB creates a system-framebuffer device on top of
> a firmware-provided UEFI or VESA framebuffer. It is inflexible and lacks
> support for various features, such as EDID and color LUTs. Therefore
> commit cc79eaf8ee25 ("firmware: sysfb: Mark CONFIG_SYSFB_SIMPLEFB as
> deprecated") marked CONFIG_SYSFB_SIMPLEFB as deprecated.
>
> Remove CONFIG_SYSFB_SIMPLEFB and the related code. Remaining users are
> advised to upgrade to efi-framebuffer and vesa-framebuffer with efidrm
> and vesadrm on top. Also remove the outdated comment from sysfb.c.
>
> Note that this change does not affect DeviceTree simple-framebuffer.
> The kernel still parses them and creates a simple-framebuffer device
> for each.
>
> The MIPS architecture code creates a simple-framebuffer device for the
> display output on the Nintendo N64. Removing CONFIG_SYSFB_SIMPLEFB does
> not affect this code either.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

