Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE77FC982E6
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 19:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1F110E128;
	Sun, 20 Sep 2026 19:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mo84Ifi0";
	dkim-atps=neutral
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B82910E128
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 19:39:49 +0000 (UTC)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b899413537so3471611e87.1
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 12:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789933187; cv=none;
 d=google.com; s=arc-20260327;
 b=iTG3rkog0x71lb65cC1WxMhJd4WjtNbgv1CDmNKfI8pUTelgwmbKJ+xQ4w5MMid+T7
 Cvwqn8zz9oQ4sNBDmww0K90UU0iLIexvzRJNRUJ7Q9Xr9TlXo699qjQU/vmsiuOHInjp
 pUlnozvitM3fnjc3V+nDHISETPUznly8cZhV3nUbIlRjL2TU+R0zdI7j72QZAPxxdYH7
 YRO/4WduDSw84UIBy90wa96En0u1ssUSBL88ExUKwH5IQe8pv+GZQ1VKDa9v8xR2xaCN
 T0h23iouWBLFX9LQCQGKmSMH9E0AphT/A9tIz9vy52EuY9/tpGSOgBJ/dayG3MNbn5ql
 2wVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vz6p4cr59OhOE0k1clmpsoNI1WGvNP/gGmXgC4bdz78=;
 fh=mKr05x0NXR9Ll693umCutw8ktlNvIk/f9RRdj2EP4BE=;
 b=UgV1te/LSu0Ox2fVdDHgyv+fdKEVxCVayzKDrnteA8wEuibf9IyDRKs+6ebOsUa7UD
 RTb/0XibSbvZjyBNM71cdiXPMTjJx/dPdPLL8DmYmVoovhgayBkB8HleEGKlJifVk+Yi
 ZrvJ0DPz/MXXZL9HItSxbKYMLUJz3D18AxXbbXjiNVEqNXsOsROSZszVxn+v8o6tlQK7
 ihXfqwrBVXZSE576YyPRrjJm2x/5q9/eGxcuf/Pag8fw0tnuWg2/XM/Fl+DquB9NNXYu
 YFYWFBzjLOAyMR5W029vx/OgaW+W++y1vQQoM6Xw7tbqhW/RhTyWjLtlwi8JReVg30Ux
 xZxA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789933187; x=1790537987; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Vz6p4cr59OhOE0k1clmpsoNI1WGvNP/gGmXgC4bdz78=;
 b=Mo84Ifi0Lca82RXUF5Gq4GOMRLnj7IEyVNpG7XeZGzQ3VCkpJt1PINVTWeZGdzrpFh
 AYtCocYHHx+FdDUZDJN2l2Z3qVwQCsgWJxYHGJyqwErU5whutzpsYBPqyFukLN44ACo9
 s9c8uiK898jsj6MHM36NViqMwDdso22lMB9gmG/II1NRkuUKbLdfzaqiWHcmhkhocdjP
 ouLtp8biZ93k8c5RFHMY9OZ5xfY+/gpoiw92zdufqOyvdrepqY8cF3WC/1+LNFFUopYg
 NB8IN8roB2Kbjqb3XSIZSYD3wJ4ANe51NO0TapSbbowAI2YamdQL9NJFp2p7uPkRBVYY
 XetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789933187; x=1790537987;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Vz6p4cr59OhOE0k1clmpsoNI1WGvNP/gGmXgC4bdz78=;
 b=zBOZDmYsVZHXbsVwKtamNQeQC2TM2agQEEk19+1SYV4jr7Evp4zrQ6N4r4ZoeJrkhw
 sQGqGcE7fgK83pyakS4yG9dZ4buFTlgmvIoi/raJYaeYIYxHhRwneaA3bgm+OiMipb26
 MyJkz/zDempSI9wSXYyiufhcUT2NsusBBq1UHFN3yj31k0tGlsKq6SYvqsXYeCu3N2MX
 tK9eXInd0S1hbLf9SjL1f9O3qoiM9TB9vYTqwMya4JfirSH90s4ia3A7rWoJDq34mtyH
 mbkMyt4ELqXwj0YFatB5Q8pDm2lj7hfuHm0sonKcXXZg+EFF7XoyfT0ckGJsmVDdnPn7
 Pbqw==
X-Gm-Message-State: AFuF++nCi9FlnHMxXQ8oVCEMlwlewcIA3TpaHebz2bity5fZW/tnePTm
 bTc2roz6o14sYTZ3M5CaJYdbX//5dIIEJJS4pYCnNrImxT2g5PCPoPjVkG+019WQ52Fy51LkvVP
 psJDMpr9j+odPThzWV16hXOXMvNrDktk=
X-Gm-Gg: AYBFou23pv5eba9UTYcrw8n72El2Ac0zZVSjNEr/zi+QMAWg0DqcIj+8n4uncG5srdf
 7Gwk7h9/fFnGhfMNryDnfZAvRo2iXIz4NtKT38EzQ27LrHVIHk1UHojpGEsBsQims55/3CxBX4O
 u66cRjvZiFcE/tn8h+y0dGDhnZH2ozizTcYhE5kOnU2ld+JiDuL/dSXWy89oKWUwTKjSMpXmEdM
 5tsCihfvnXsmp22tRXs4LIYxYiY+Sq4+0BDZPBzIUEFToKoMc28haLrL4URlU85cjtggZl1CQaS
 34XghYYlsoUR6EyNH70DIzOd+jjswK78RE8q+Ecvafo615mNmwbKIJwf2wgaFXvr6gt3phq+Ekz
 JnA9EUFh5R900xUPFLby8adpqPqnhf5xIdoQejdJ6co752s/00qkSyg8hUhAVOK//2HID3l9JEQ
 ==
X-Received: by 2002:a05:6512:3a96:b0:5b8:9c46:d4cd with SMTP id
 2adb3069b0e04-5b8c1951288mr2754329e87.55.1789933186922; Sun, 20 Sep 2026
 12:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260913205007.118552-1-kieweg.leander@gmail.com>
 <20260913205007.118552-3-kieweg.leander@gmail.com>
 <b5bb9302-0f09-4372-a169-88deb52d5524@suse.de>
In-Reply-To: <b5bb9302-0f09-4372-a169-88deb52d5524@suse.de>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Sun, 20 Sep 2026 21:39:35 +0200
X-Gm-Features: AcwNN1Xc595MmKUQVQovNFiu30qC4psJKctAnYnI_hrq_nWGZ8b92q9NSpZghk4
Message-ID: <CAMwcS0jPcjfJd3ErUfytFqy8Pu8VdFz+Qy0GdX684k-SwvOQxA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/glanda: Add initial DRM driver for GlandaGPU
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 u.kleine-koenig@baylibre.com
Content-Type: text/plain; charset="UTF-8"
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

> Hi,
>
> please see the Sashiko bot's review for several details that might be
> worth addressing. I've also left a few comments below. Apart from that
> the driver looks quite nice already.

Hi Thomas,

thanks for the review. I'll address all of it (yours and the bot's)
in v5, including making the IRQ a hard requirement instead of the
polling fallback.

Best regards,
Leander
