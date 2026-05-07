Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F92DCD37AC
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28EDD10F3BC;
	Fri,  8 May 2026 07:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ojfjwjfN";
	dkim-atps=neutral
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F5C10E2C5
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 19:12:06 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8d65f4073bfso172942685a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 12:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778181126; x=1778785926; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f7FKxb1CAp+U4Z7LLr7KZwzqX75i0WeSOczd8bry7I4=;
 b=ojfjwjfNKozKK8GvctBTLy/6anLsuvbnZIix4E39bYSMWH0/GGb6k4k3xmlpZv56xY
 tqtmHyPCExMXz/I/qASTPAiGRIb4nv8ExDMxwsk+KpPI2sUSx8SWjtGuIp1n2OE6KjUJ
 cUzgXKaUsHPAVAfTqzyQLAspSThLC2rM6zGaEYsPpjnnaOACO2UUOQdQvMRNJosvCLNH
 ciN9L336Mju8u/dKEX3Yoe4uDlcy/qH7ebxsihgEt7+b9LtgYuf7lA9HcKiCb7E8DiMo
 Fpp91zdGbPofm9HHNDyg3KtOwDnTCm1D4bo1a/CWH5SM3bf5pZzpIV6UZGw4M928J4IY
 OEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778181126; x=1778785926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7FKxb1CAp+U4Z7LLr7KZwzqX75i0WeSOczd8bry7I4=;
 b=MpngtF7UurhO00IzbbpMFNCg3nhJw3Mhb3bPupAe9rC46g8mnwMxcwg2/Aw2CbzN9W
 e2TItht6NAEVJTP2mD9FM9eLAwqnwUhMbw6gs4GcRQUWMJFN3DU98Inq+ncVfRrA67p5
 hvyN/US4N0VGSEGO8/RBIqHx0uViFuJdMCzVM9oiYx5GyMiKW/XuS5MmWztjbJrDWTuQ
 YYYRQf/MaUufx1AGpd44heIVvKNpH8pjBSc5UmIpYkSWOI6rid/k/4m7NQfGTwabuBxl
 2lpCnscXNhMLwrM3PzNaX0uIVCnYnzW0G8Yi+L47CrKnmqIuieUMk42ML7BOCKe57Eo7
 tgGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7yUmz463W2OYEmPsRaxDOvKQG/5Yt8ikfpPDWld8Fkyu1tIUipUTvzmQRnE5efj1Sgb/iYns4Poo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSVkO3Eb0MQTYhfUN/GLUsz/eeq3xG335BR2sXYMmIY6huX0KG
 eXdl/w7LyELCaKe4l4258j+7WHcEN1/KK1yCK1tkGVxAFkUXiJqoL+y0
X-Gm-Gg: AeBDiesvDNLq4M/W7AsZl7k5xAdlTCe0sJOtqgxK74I5XQNTXAWsv1shFqVWyUI+CG7
 YKmSkAft+r+/RzJEmIR28q+w57km2drAVwLGxDutDFDq+SSczNGR3VVSvVwxWpYhpqFx14qpcd/
 Gc6RWryBEwJBEYbX783ripyz4yWEsk6nOnYsMZfh953RXUTNHbT2uO3bQ+BumM3UH/AXd4Yc23r
 wL/OlcKwASES8ap5+AXg45BmvdubbPDukU95ORe5pRhBDWQ6dOtdxCMpvZxeopNkNsqx+swJygP
 OoYPz1NgJp1gnGOWu7KcVD+IzMcx9rpP7l1VBtEPl+faI9+gvHhOWe7LznOG2lRgmSMxze72lE6
 fHR4U6bREjW2VsAVKThzTQGR7Rhj3Bu3c5f5zmBqz0ZIdLU7iTiURvZFwmopSk7BgRBqGAyeJke
 Z6i6fQQH58SfRASD6urGi2ifR2kq+qmDeaeQTn1okv2Pzxh722mH0IlRRR
X-Received: by 2002:a05:620a:3197:b0:8cd:926f:6470 with SMTP id
 af79cd13be357-904d74bbfd2mr1491810585a.59.1778181125418; 
 Thu, 07 May 2026 12:12:05 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.6])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc29a80784sm2010560085a.12.2026.05.07.12.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:12:05 -0700 (PDT)
Date: Thu, 7 May 2026 15:12:02 -0400
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mike Marciniszyn <mmarcini@meta.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] drm/fbdev-helper: Fix deletion of stub for
 drm_fb_helper_gem_is_fb()
Message-ID: <afzkApARAHVuAcLW@PF5YBGDS.localdomain>
References: <20260501204313.127616-1-mike.marciniszyn@gmail.com>
 <afzVhCHu3FTwn9w0@shell.ilvokhin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afzVhCHu3FTwn9w0@shell.ilvokhin.com>
X-Mailman-Approved-At: Fri, 08 May 2026 07:55:51 +0000
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

On Thu, May 07, 2026 at 06:10:12PM +0000, Dmitry Ilvokhin wrote:
> On Fri, May 01, 2026 at 04:43:13PM -0400, mike.marciniszyn@gmail.com wrote:
> > From: Mike Marciniszyn <mmarcini@meta.com>
> >
> > When CONFIG_DRM_FBDEV_EMULATION  is not defined this error results
> > when building amdgpu_display.c with CONFIG_DRM_AMDGPU:
> >
> > error: call to undeclared function 'drm_fb_helper_gem_is_fb'; ISO C99 and
> > later do not support implicit function
> > declarations [-Wimplicit-function-declaration]
> >
> >  1777 |  if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mike Marciniszyn <mmarcini@meta.com>
>
> Just hit the same problem, thanks for the fix.
>
> Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>

Thanks, but actually there was already a fix.

Take a look at linux.git/master:

commit 927011b65a875302d08709bbe82eaf4d0d96c5d5
Author: Yury Norov <ynorov@nvidia.com>
Date:   Mon Apr 27 22:49:41 2026 -0400

    drm/amdgpu: fix build for CONFIG_DRM_FBDEV_EMULATION=n

I encountered this in net-next, but the above has yet to be put into net-next.

Mike
