Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77DFC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D17CB10F361;
	Thu, 10 Sep 2026 08:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="EcPyZ5gy";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C628510F361
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789027875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DHVsvo6RwXVpI3O0qorfwMCGL9oJM3VblhLkUEiQrLE=;
 b=EcPyZ5gywqnux3TrHqVnptydjQ7S/duFW5PbqfrzuKHwz+G2vXcI6b2fVc+KlSd5VQC0CD
 xCJgdxX9vktHORw9kSsjp2LJ5iDcQ7spzqt+JS7VXY7GCsoW2Gn3WFHeBH+ka6Xn8e1elm
 EcCI/IY0s5qPCeuv6BC3vrYV/7R0eCI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-j7qs-lmgP6240w9m2uYf5A-1; Thu, 10 Sep 2026 04:11:13 -0400
X-MC-Unique: j7qs-lmgP6240w9m2uYf5A-1
X-Mimecast-MFC-AGG-ID: j7qs-lmgP6240w9m2uYf5A_1789027872
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so4762266f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 01:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789027872; x=1789632672;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DHVsvo6RwXVpI3O0qorfwMCGL9oJM3VblhLkUEiQrLE=;
 b=lHBnWTrZya9rSmdnPzVptp6XEfy/AC6+2tjxZhMUrAXVKgBkwcoyfl+uFGsARpZkmp
 XWLS8FWBh38TQNxHBsSN570iSlydKINTqyUpqNn0jgCFSw4MGUhv18T1jkBe4oQbR95K
 yE7sCONgJ/Dg7DfmTb+vzTYLCX8uCCKV78hIOD6C6f6ofFupSYOCE74qNvIs8KFzwMNO
 ejh1VwSGgupzRUttSg3/nbuCuc2s9uUSj407IcGQmFxcW+/4bT6a94FgNA4QR4ddhLzR
 tL1LqZeTW1CpmYUqIfVMMIbWTMt24G1e7x6UtIzl8JbtKBN8afI/HWH1g+fuRRmYvn2Q
 QYaw==
X-Gm-Message-State: AFuF++nw0gfgWoxDj+CvEdlruu8EHJjlTT+jzbXF+ZmXEnUG3Rrq9C/n
 NQGSw+ihcg1wchGn17L4YJ3WFYa+jkSzHeqyQ6Cob6kbcxdoe87kYgVJt3/ebiVCLERx7eD6hYt
 3g0aghBjIXYXch8lZRmBZCeMlHjp3Mpq92L7YsEJs0eG+AgVv3cr8kmwAAWW+0hJrw3CL2A==
X-Gm-Gg: AYBFou296hHMrKn/MfSPq9ZmqbUwM1omx8pUTEx9gY9XURrHMlll726ofm/mJ7EEsfA
 J3ipoRCFcjXB8VJk9sMyIWbOV7ocJ/lKtEFWvyHD6QVHWGpuHho4vsWHSu9SMjj0/9yPpscuPdm
 sWzZzZ6YeFQT9ZTSXCl3ktoPW10zwfNtrOeBH4nYeU+Y6JYE37CjqhdxGdcTzCo0HDScUy+DKzQ
 xFOfwDrie1SK+HXXgT8SkjiTbzb9NGAQr9buaERYw6HF9PPaW0wt53mcg5rQzEa5mW/cidVNulL
 UXn9SEpS/WbZFCCVITgqoNjHWbTxZbmbN2Cri3xvCeD7MZzUWkVAos4tUoUmW4KkxnLzmcy/B9e
 Yhv7xIz1zzOMsGFJVlpCuJE3n7iqNgksvzcAqIxTy7aRU7MJw7Zg1iVvu0Q==
X-Received: by 2002:a05:6000:4694:b0:482:fb97:2ae0 with SMTP id
 ffacd0b85a97d-485872ade60mr34287598f8f.14.1789027872195; 
 Thu, 10 Sep 2026 01:11:12 -0700 (PDT)
X-Received: by 2002:a05:6000:4694:b0:482:fb97:2ae0 with SMTP id
 ffacd0b85a97d-485872ade60mr34287569f8f.14.1789027871872; 
 Thu, 10 Sep 2026 01:11:11 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c5bc5sm52649193f8f.24.2026.09.10.01.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 01:11:11 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
 ilias.apalodimas@linaro.org, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 3/3] drm/sysfb: Use preferred panel size for panel
 orientation quirks
In-Reply-To: <20260904090850.43060-4-tzimmermann@suse.de>
References: <20260904090850.43060-1-tzimmermann@suse.de>
 <20260904090850.43060-4-tzimmermann@suse.de>
Date: Thu, 10 Sep 2026 10:11:10 +0200
Message-ID: <87v78dcyqp.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y0DL9dSqZYxtJlg9_ZttuVaM33VaRUAkDmynnnDkLnA_1789027872
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

> Sysfb drivers currently use the given display mode for looking up the
> panel orientation. But the look-up table stores the native geometry of
> the panels, so the lookup fails if the current mode sizes differs.
>
> Get the panel's native geometry with drm_edid_detect_panel_size() from
> the EDID and use it for looking up the panel orientation.
>
> v2:
> - ofdrm: validate EDID header before using it (Sashiko)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

