Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A969FED3EA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 16:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB3A10E170;
	Fri, 24 Apr 2026 16:24:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="apSsknrq";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 123E98935C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777047860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bkHBfOVa4bz/wCbZfmwZYYdZCO/tCYPxae+JQxak4Yg=;
 b=apSsknrqDhMC7h2cShmEWRD3Qvr9woqVNmefE6IRbhC8GfPLl0eiIUyjJKVzb/Nsbs7HsH
 Kq4azJ5c9gPbVxTdHQ64WobC7eXeBwoo3zYWUZ59WvRIMjIIBWxd9stOWEqqKRePA/5Ay3
 Hm0Mv0YhxcdJ078jtBn+CspmUudwYJ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-XF_kVLwqODG0U2_FK_CCgA-1; Fri, 24 Apr 2026 12:24:16 -0400
X-MC-Unique: XF_kVLwqODG0U2_FK_CCgA-1
X-Mimecast-MFC-AGG-ID: XF_kVLwqODG0U2_FK_CCgA_1777047855
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48a5fb71a84so13524515e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777047855; x=1777652655;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bkHBfOVa4bz/wCbZfmwZYYdZCO/tCYPxae+JQxak4Yg=;
 b=K13jJ6M3L9OVQ0Ez05cB6WLsY+TCXAHhe/cDqE8BksaqtBjkYPoxBFa4N3cEmVF1x5
 cT9cH4GP+BfX1f2BYkuPDq/G8MQ0QwFhzCGynCf7oWndSu3v0RSlvmMfMgi6kL2Hplu6
 +MIJ5hYuqS/hKZbPncQsZM5Cw1yThVAmBRn8E3MebleYscvqDScim6b/t3L8X39oTCij
 r1oc+sTVV3PdZKQCvq1POyC9eAUaX98C5ik/MxsvGml+hW92vBMrNAQMyxd9mXc2DTvp
 hYNajd7dk5xuxrudKMcbd8gntKKGcX7NTOJ0ojT5KM6cVLiIweF8HHY6hOXSsKttsjgj
 wyeA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZqS8E/SOiSg16Y4f9zcC10prUOEGJeK7Ay/YTKd/pmJf9W901mHyztjWhhUFUXQd9DarRSGO7Xy0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKO3HfU2gejpV7L0rkIsoTHckQB5gi7vZCJAqAOwsdGVddD3ec
 u52B7uklWRqvRLUXSBR/KoFLaVgY4oLbMHz3vp84/rMLRNMBnjSLjNqCYbNG5f5wI/o+1C4bMCl
 5nhXE7cGwwJI3aS4ib3+/6jps32233YS+X7j31MVzFza8ydbR8s442DNqPPcI6ijQ6rmvcw==
X-Gm-Gg: AeBDieuNTi49Ao/FNG0Eb6Pvdrw9RYhZglmr4Tgl3k8QepAJ+Dh1CiaVleLjEOcEUre
 ux90gUil4VXywyFO7lAbmiKKkWpKzfyhz6Go4CaZ6VRmrLirgi00L1XJCyPMQUoSPjqN3PU95r8
 aPPPC5UjFQeQEQny3bPoSgHZYPIwQVUJPmuyuvKz41uMrAxKMQXrXbeIk0r1lJyjxzGStYZwcco
 UKloKcXoiYW6LDht1WBXB3bAD0us4AbcLzCjbO0XIzG+7Ls42ffDFex33UP8xNJ3BhjTPBbnuXr
 J5c4tvaRtHIdB0M5P4RnkhOy0SfO/vpOP+r9E4I1j3iU6phJ7aXKrJJI4S5V23FqTvHl+eR5TYs
 xh8AUqVdrFEdG3JELBD6Hj+KOggK3zeJJs/RmrrvHGUgGQsybeVaAoqYsRG8ZcV1Gs6KT+CDZUP
 fWQSH0fhMvPEPse58=
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-488fb8859ddmr427762185e9.2.1777047855241; 
 Fri, 24 Apr 2026 09:24:15 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-488fb8859ddmr427761525e9.2.1777047854742; 
 Fri, 24 Apr 2026 09:24:14 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a682588f8sm6272915e9.10.2026.04.24.09.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 09:24:13 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 longli@microsoft.com, Helge Deller <deller@gmx.de>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 3/8] firmware: sysfb: Make CONFIG_SYSFB a
 user-selectable option
In-Reply-To: <0156562f-5fcf-47ce-8fea-03345f2c3fe6@suse.de>
References: <20260402092305.208728-1-tzimmermann@suse.de>
 <20260402092305.208728-4-tzimmermann@suse.de>
 <78f76717-8f1e-41d6-92f7-261df96b84b6@app.fastmail.com>
 <3e466158-c2e5-4e23-934f-dcdbb71ad41f@suse.de>
 <d3d7c545-3b07-4881-a16d-45b6f039de19@app.fastmail.com>
 <001efe27-9cbb-4a89-8d2d-a1f3ae15e505@suse.de>
 <295a43ce-92fb-435d-a82f-d1cfa8f4f28d@app.fastmail.com>
 <0156562f-5fcf-47ce-8fea-03345f2c3fe6@suse.de>
Date: Fri, 24 Apr 2026 18:24:07 +0200
Message-ID: <87se8kjpi0.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gsOuKvu6G6jScX3Eh6A7sKKYbl6pyrrC3G7e7qCbH9o_1777047855
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

Hello,

[...]

>>>>>> On Thu, Apr 2, 2026, at 11:09, Thomas Zimmermann wrote:
>>>>>> I don't really like this part of the series and would prefer
>>>>>> to keep CONFIG_SYSFB hidden as much as possible as an x86

I tend to agree with Arnd here, I'm also not seeing that much value on
making this symbol user selectable. For now I would just keep it hidden.

[...]

>> Yes, I saw that as well and don't have an immediate idea for how
>> to best do it. I saw that you already abstracted the access to
>> the screen_info members in drm_sysfb_screen_info.c, which I think
>> is a step in that direction.
>>
>> I also noticed that efidrm is mostly a subset of vesadrm, so
>> in theory they could be merged back into an x86 drm driver
>> along with the drm_sysfb_screen_info helpers, and have a non-x86
>> driver that constructs a drm_sysfb_device directly from the
>> EFI structures.
>
> I would not want to have a unifed driver for all-things-screen_info. The 
> code that can easily be shared is already in the sysfb helpers. But I 
> don't mind adding a separate driver for EFI's Graphics Output Protocol.

I agree. It is much more maintainable if we have dedicated DRM drivers that
use shared helpers, than attempting to have a driver for different platforms.

As Thomas explained, the maintance effort is small on the DRM side and he has
done a lot of work to split simpledrm in efidrm, vesadrm and ofdrm.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

