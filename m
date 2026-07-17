Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8629CC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E391F10F60B;
	Fri, 17 Jul 2026 21:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Y5DX3Bai";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEEF110F60B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 21:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784322850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nbxP6xfvX5CxNHoMYiu6LalibiLgaMNPLbr1qz5t6/w=;
 b=Y5DX3BaiuSqlV6PsPf/bsg1rXpg2oJ3bekE9Amm9DW6+R6wdZKRDdm8ZSrb0SBzOs/muoJ
 Yqe8JLNHrxC2cEt94rDa4eHnN78z3nQeZiiKh5zpHdv8Mwh2ydcMRGQdbzm7xHltXitPhi
 Y+1gl+Ba0GpWeO3wfPY5x5vZUVIqqCQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-ShrZKzMhPW20SHGGyIU-hA-1; Fri, 17 Jul 2026 17:14:08 -0400
X-MC-Unique: ShrZKzMhPW20SHGGyIU-hA-1
X-Mimecast-MFC-AGG-ID: ShrZKzMhPW20SHGGyIU-hA_1784322848
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e9a2b95b5so1117086485a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784322848; x=1784927648;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3n8ovVroS/g0E1kqDzhNKBMWW9UR5F3sPuTt8jUlpU4=;
 b=Vr3tyRbFtWlbQwXCvcq1ZGNOjK1cqkQln4K+3Au+gLPjxJXtdg1BqhNp3isBJV9GKi
 ExxfUQC9RC0Kikm9lCMNfJxUhHbrtNqpmi2Nh5JniZG5bO+mWeGCjJAiBSzCSXlL8wZc
 dqVeeXRbyGJnyrt+0mnKMTtnG/Edl20GfKgBg3NAImhz3AywXrHGZg51zQVxQeFtWvXr
 YtyPa6ZjDjKiO7uezyOpvZ4PTD/R5putZGuJRJur14HAKDrKGr9I+l0+dhCEzRCJDgEZ
 G9dfvbU0GRuHLWpmwYu0zo8H2VEMeoe7WHVdVmiRdibivQAnZBGoGGYOWGPEO6YebwiH
 qi1w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0ZUmLYG4IuRdpos86C8DI+ZuYIGi/YQgUVrudg7kRHS3UaeycekPFrm8eSAi2BnSvXs7A2tEhZiQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEFSay8i00RN4nVbV+4UEq1J26nxEEvL1Bfij24eMBHSlmDJU0
 Z3PtRTY+xXU/t0IXOZQpWzBTHKLSqbo0HG8P+Mim1FmhQb8G7z34S+o6GIszs60haPqiq3eEOfI
 HCN2haYkTEgj0wjGP7LOQlCQDWLDnOlACG8f33nQxcv5P9RZhw7Nw2Rk422DhP2t4hj6DSg==
X-Gm-Gg: AfdE7cns8vJPErsBhjfP0xI08KHGvf5IEtSPakK0BQPdmqbT9isRQ5Rj5nR+FSo7vH/
 CChvgQK7DlMLUaLwSE+x22Ng3hT3ZQ2zEtooVoFd4lnDMecyDoGfs1MNz3cztLcBcBej+T7bgnp
 EnRiZ0sALO8LUcPYz/RAv40qbVfKFGtJiHNIoSyY9gPP2xXtFzBqXEbHeAfD0zVCwYAyAf7jlw1
 V1mIPotdsi5aKcaOqVYoqPDyEIXZczXe3y+pTuuArnNkGH2jS+gu5AERXk+3HQdeot1BOO87rR6
 FEILEtwunNLLxLsVyw2r/wzCbsOFAeZMuDzjLH3q/YDgUABfuOrtdKPIwRil0yxu/7lI6jja
X-Received: by 2002:a05:620a:390e:b0:930:b12c:158d with SMTP id
 af79cd13be357-930b3eea06cmr491922585a.38.1784322848146; 
 Fri, 17 Jul 2026 14:14:08 -0700 (PDT)
X-Received: by 2002:a05:620a:390e:b0:930:b12c:158d with SMTP id
 af79cd13be357-930b3eea06cmr491919185a.38.1784322847719; 
 Fri, 17 Jul 2026 14:14:07 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b5461a16sm247735785a.33.2026.07.17.14.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 14:14:06 -0700 (PDT)
Message-ID: <2aba63b4d22a329259f335b1a69a4642ad1ddb89.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Omit a redundant
 pm_runtime_mark_last_busy() call in nouveau_pmops_runtime_idle()
From: lyude@redhat.com
To: Markus Elfring <Markus.Elfring@web.de>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann	 <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Fri, 17 Jul 2026 17:14:05 -0400
In-Reply-To: <e3631a8e-b4a4-4e14-822d-2199f1576cc9@web.de>
References: <e3631a8e-b4a4-4e14-822d-2199f1576cc9@web.de>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NOQhp9M1vJgc7eOaIkz9UhP12NQOslHwLDGHJY5szCE_1784322848
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-next in just a moment

On Wed, 2026-03-25 at 15:05 +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 25 Mar 2026 14:55:01 +0100
>=20
> The device's last busy timestamp was set in a wrapper function since
> the commit 08071e64cb642ae19ebd6ffeb13b4f3d130b5860 ("PM: runtime:
> Mark last busy stamp in pm_runtime_autosuspend()").
> Thus delete a pm_runtime_mark_last_busy() call before
> a pm_runtime_autosuspend() call.
>=20
> The source code was transformed by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_drm.c | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c
> b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 5d8475e4895e..62ac9593230f 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -1209,7 +1209,6 @@ nouveau_pmops_runtime_idle(struct device *dev)
> =C2=A0=09=09return -EBUSY;
> =C2=A0=09}
> =C2=A0
> -=09pm_runtime_mark_last_busy(dev);
> =C2=A0=09pm_runtime_autosuspend(dev);
> =C2=A0=09/* we don't want the main rpm_idle to call suspend - we want
> to autosuspend */
> =C2=A0=09return 1;

