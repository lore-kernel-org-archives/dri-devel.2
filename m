Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24903CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E04310E1EA;
	Tue, 29 Sep 2026 19:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AxGSA/qI";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02A0110E1EA
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 19:54:03 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so26206125e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790711641; x=1791316441; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u27k5NmvBzDFGlc9tKb68XrZeYB1FzHqqK5+lL8nqVA=;
 b=AxGSA/qIrsfJkH0mDzprVDVVysl89H/Ds0TPllcO/HFekCcT+mGXllSlEy1Bl8TsFf
 uFAl1vtUa/e0XYclU/7EKyVbqGAeTI/KRQwMRH3yK+abKkaIOq+U9g/ge2ufwoRvD3Xy
 sMls+ED9OmA+nNA2sHXDz4KE9/PogUh1BKHjMfjS+HRvix0vXwlfJKC9gdumS21xagoy
 lr/LDklWKPjCVXZ72L0SC5Rg9HqGPsNtDSUg5B0yg+VCzM1HUbq/les/nj7IerqvtVSC
 Iu1Rzf4xRPUzslcvCTZ/HZSiWkg4u4JldVbD1OZl6QCZdvBUlDxBrZi6hotCuS7huqwo
 xQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790711641; x=1791316441;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u27k5NmvBzDFGlc9tKb68XrZeYB1FzHqqK5+lL8nqVA=;
 b=AthWDJw6tNykqUI4APQOnpOHYc5pqi6gGAgU+f3O8VDaOJzxXenUslZphBMIm1EBgF
 1/3ZTE67rHAyw3nB3Dk1CES1UihYTtb1P6phQxuSN4FcOm+tvLdSTY6vvizUIdLdxMqr
 xtK4OMXU/gYNvmlF77eAWGMcML8vGk4KLn9wzEyKMdzWe+/0kvQ5EqimfQ+2WkB1DqIc
 ZNLKmRYX1+n6QHVJz+9jJgFVDfJc6M9RNL8t5ObM45eMGKh/c60fPSE5X78/GRdIkxof
 NbRhn84pF6g7CqmuXcZI3/8pwKN2u8RSxwhT4fyFWwIJ/xae2QNi7sqC/OUj41bFgKh6
 HmOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMInu4V1FfapNjLVyrIMpR2mz/M/2EjTk4KEulfa3ddffeb9DnVv0VbZPa/BosUaDA+ogd2GkJ61w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lhUzZUIjL/B9406IehM66CFtUgrA9HR9Dy00S0SwxOw12EqyIi
 1rpG7ZLhioy81IlLHiuoK4uh6x/mNZnvzysy7cT/h+BUhxTpflaM2tpU/YGtYbhp
X-Gm-Gg: AYBFou1PlGP+xEriavzVFeVlyZG4msPGFb0cnbtxPZo5OxEh8HdlOeD74X0lNQ1PLGD
 q/noVkLBqxpNl/CX/VC9eIwsTxr87VKIt+xwHe5d0UzI3Gp7gQEJL4+OfYV+DiWnMy4kKejHhz+
 kMyMEDye41IIm9mS52TmBMlpAPkShskhF+M0RKTJy0zjOjkvY7MJ5RQzYY9oWGV4m0CaHO7jIab
 SjvspB3f1auQkGWQLCqD2T3+hiwf7IVZVhSIvLHVATjBOoQpmo4R0GgvMnydUud+RfhZCXj4j3u
 /w4x3ALe8Vuv8b9o/S4LPMp1+8JO/53allUXx279140Wc3ahLX2wfZl1q/T6AFa6HXz1PAuLCsy
 NZo++DWP9klve9XWhT1vN4WfnStNCnfLHipRNPjgZRrepzWrTNWkUFKwYru1fo7rhu8rDweurfB
 59NYwtFTEQtf4wZmcd2CLuunePXORSiBvmAyY8z0WM16boVTdV0reToewtWY4RplT3zFJeEopr9
 5CEfNM6zUIpQlvi40d+BQiJI3lbL7FID1+dAJR8vGz6uVFUEqpAwUttx/DaaV03VAlz39iRHdPO
 6o4INhs3XaJ4QG/1l2ipulRr9bn3ZUp25zFnJN9RlQjK1aXKlInGCtJ9PbMxJYVEfUC3agsK4CB
 7qd/W2g==
X-Received: by 2002:a05:600c:3ba3:b0:49c:fc6c:be03 with SMTP id
 5b1f17b1804b1-4a015155f74mr2815545e9.26.1790711641143; 
 Tue, 29 Sep 2026 12:54:01 -0700 (PDT)
Received: from MBP-von-Karl
 (dynamic-2a02-3100-9c32-f801-9d9d-c89f-9fb1-4ec2.310.pool.telefonica.de.
 [2a02:3100:9c32:f801:9d9d:c89f:9fb1:4ec2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a015019e5asm8566915e9.2.2026.09.29.12.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 12:54:00 -0700 (PDT)
Date: Tue, 29 Sep 2026 21:53:59 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>, g@mbp-von-karl
Cc: sashiko-bot@kernel.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] udmabuf: respect the device's maximum segment sizeg
Message-ID: <arwW9XNaoppy5o4k@gmail.com>
References: <20260929054835.94118-1-kmehltretter@gmail.com>
 <20260929060028.371041F00893@smtp.kernel.org>
 <20260929065601.99518-1-kmehltretter@gmail.com>
 <20260929120317.GH1616761@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929120317.GH1616761@nvidia.com>
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

On Tue, Sep 29, 2026 at 09:03:17AM +0100, Jason Gunthorpe wrote:
> On Tue, Sep 29, 2026 at 08:56:01AM +0200, Karl Mehltretter wrote:
> > Right, the misc device has no dma_parms, so it gets the 64K default and
> > sync fails with 256K pages
> 
> I would ignore this, it seems fictional to me, and if someone really
> needs to support this rediculous combination it should be done inside
> sg_alloc_table_from_pages_segment(:)
>  

Fair enough, Sashiko got me there. Looking around, 256K pages seem
to be barely supported today: they were already disabled for 47x, and
I couldn't get userspace running on a 256K-page 44x kernel in QEMU.

I'll leave v2 as is. Thanks for the review.

Karl
