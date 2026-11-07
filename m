Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4EA606A330
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m+rZZVv4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E4010E20F;
	Sat,  7 Nov 2026 14:27:49 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C841C10E445
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 10:08:28 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5c0a520df2eso80873e87.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 02:08:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794046106; cv=none;
 d=google.com; s=arc-20260327;
 b=oo+qPEV4l7uEacLpC/hjKijHdyIIx4JB6fKy+x+055jyaGYkcshSp7KwL9rlQMpLPI
 6+c5HVt0+W/v2o2/HqD5E+WTN9J9n6AvfMjn3OXsQQhnmyMGk+viddTR4sJHYskQns4o
 OjwppLVy7zSOGMMzlJaTXzfse10SuqxV3QgtawGL9NZf5j3BD41MQMQ7DG3/oEt+kAXT
 yT+pIJ3IA4zMS55Q08xmuxR51k0DdBQUZB5APFSQK6VT6hrg+skrixFxg1kKdl4syh9T
 LiCb7iXfWDR1O3V5llR1rpaFJaT26A+920kxDgWvsut9sQAxSlgjig8MkNWj0omTNCxN
 QmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jExJ96PMaFTbUZdk2gtHqLJIWFN42YYYs3WEkMaD2dc=;
 fh=BmW86V4lSWI7EijhRGu5z9XQHC2dAYl0PQY7AqEeBj8=;
 b=gs4Kx3LrsV6shwKXlNBZYwRx74TNlBxld+DzRPVCGBsMWxonnFiCe8UV1gV16X/g3O
 zAThc4KXszbPWd2W97x/LS9VGDCK3UgcMlxfe3VEZHe60QsiWtKSEWvgEf+t4HkFelfX
 ORRG+cLOElSXYKRyrQKDBQlyJvmgqD52yopnt1D2Sp6hgoz6s1EboN7mMW01E8zu7mZf
 0SWPtp3r0DFCzj+FAy5YP/c9vcIhIe7E915RlJVK073HzjxYJ/AczFe0rtMHpXQmUl9U
 pMVYhpga8vxzaDWrFRDs4mTryUm5oYifUWf/vKzAjhlJLFU5wgYC0dsXNvRk+Ai+q1Ua
 nkjQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794046106; x=1794650906; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jExJ96PMaFTbUZdk2gtHqLJIWFN42YYYs3WEkMaD2dc=;
 b=m+rZZVv4MJeX9eZ9trl9bgs5uIucCh7d5J+sZ8PHinI8FVIBRKO4z8k/aJigOfqJy1
 0fCBLbS0gpXcrQ+vqlzf0cyybF4Hm0WXD/CqW+ehJmYtsCtvZCD2RhmnfnWINe4WrRNl
 Ej223aMXDnpksaIltFqMGxFS9JDtcs0KrbHLVdnK8hpbj0E54Kz976GrMh8zT6s/2xx8
 KsCynJ9jURgcKjifdckXQD1PiUx7uJba3w2uaDehujD1PTJA0UkYezVISEdwBGeynw8a
 EUoS8wiOY/aQL+69AHsIxS+2wq8n264h89gOYio4jVoSapsXm84vpV+DlbiwFuAP1zuA
 mPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794046106; x=1794650906;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jExJ96PMaFTbUZdk2gtHqLJIWFN42YYYs3WEkMaD2dc=;
 b=kMiBwmE5m3LvSFQ4fQNXrZL0+HV/baqBaKyXC4IKmVd3PnpJ9EN0WMkDF40oKcTsVL
 l5U0wlwttNAY+JgBBmnZejKeVow/a6D2actNuJZUTImh0gkG1p+hB9XI0CzIVpvI9iHl
 13oysBNUwmW82GL11GYdtbvxCw16WnGVpGhNkjuePkvVm2tWxlQcLuzCtzVR3A0Y2NJQ
 U6rEHz2DAVu8Y6hpIhTSzkc1Rf04UsXmQC3vgwtmZGW3Oc7lPyYzeB+DK1BpSvYBq7n+
 pUhGsoy9kCPGVveNj4WxePu288mYovmhhSsgJiAWnsBueQ7P6IAoD61+MettV6HaDFtn
 +xRQ==
X-Gm-Message-State: APuU4Z8+/BEZWhvKNCkuBz+W7iiPq8WQenOuoFGa9zaPo26pHudnvTvw
 kEPqjAEyTnTahqhYDQieFY6fWLm/OZefwuVsg5jdt/EXgkFH7P/fSr//kk0hOema+LHMBo8VN/u
 aaQGX2YZsSwlyCra9/sBLiyblSA+/H8o=
X-Gm-Gg: AYBFou0xxnPcplFOGmnxA7SuVx5x45FDOGX1TL+kn22Od6YJDCpZDyOXgMUFOrGADfd
 WjMgI/5VLjUs0vz2osER9IXI210LnkvyulC0Jdpg+flWBabemk28WR8QSyKhC+UW6cXuBzTR3iM
 L0Q5vlNLBRf3PuOreXGpY2yCh08+C2PaVj7jroy5Wa0LrBD3tAvHt+H7ZKdAu8ZhQD+9l4URx/D
 ZTwBex+2kUBOecW9JbnxgbNZhYVjSY5NCqz5h5hwsXueMWzrm3R1sWHAjTKkTzhiqy+Mw9+rVAH
 l5bXDhRNz6ZzwQc4T2ffgypttf+txj1bB0HEzIUTphEHM41d3MvvHRSiehts3Hi94GWONa1t+Pk
 o6y0qfXMd54zRgNNy5TkyJ7rq7JIdVuJ6a8WO3rlQFQgBKsoErDh6QOuej9pAndtV9mNJ2tg=
X-Received: by 2002:a05:6512:3409:b0:5bc:d39d:9b38 with SMTP id
 2adb3069b0e04-5c003a9d0d8mr1491121e87.32.1794046105997; Sat, 07 Nov 2026
 02:08:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101153000.20839-1-ravin.chokshi@gmail.com>
 <DML5U1TLCIEV.1XRE244JV8BBF@nvidia.com>
In-Reply-To: <DML5U1TLCIEV.1XRE244JV8BBF@nvidia.com>
From: Ravin Chokshi <ravin.chokshi@gmail.com>
Date: Sat, 7 Nov 2026 15:38:13 +0530
X-Gm-Features: AclHuK9wPLzSVwo1lCdFSDzmbWfi_aLkHtcPoTRq-44L11cNLY7egC1NBa4mk8k
Message-ID: <CAJxH2C5XUfTJY7RQ4aRAEu77FThiGvatLa6cUSbuwUbGFFfE5w@mail.gmail.com>
Subject: Re: [PATCH] drm/shmem_helper: Fix kernel-doc name of
 __drm_gem_shmem_free_sgt_locked
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 lyude@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 06:17, Alexandre Courbot <acourbot@nvidia.com> wrote:
>
> This is a duplicate of a patch I sent a while back [1].
>
> [1] https://lore.kernel.org/all/20260622-b4-gem_shmem_free_doc-v1-1-85496c597b18@nvidia.com/

Thanks for letting me know, and sorry for the duplicate. I missed your
patch when I searched the archive. I'll drop mine.

Best Regards,
Ravin
