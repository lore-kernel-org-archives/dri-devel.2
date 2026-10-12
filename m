Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9683CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4EA10E3E9;
	Mon, 12 Oct 2026 14:16:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4ADA10E20C;
 Mon, 12 Oct 2026 14:16:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D27FC601FB;
 Mon, 12 Oct 2026 14:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378FC1F0089B;
 Mon, 12 Oct 2026 14:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791814590;
 bh=FnxOrGCm+HW6rmFcq5jOFM5NHqPVoc4YpE7Zhila9m8=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=OYnT6gp/YtuhVx2ZsMSjxgnqP/Hk8Rv/sp4I0VftUsdf3aoNbCg9q8x9eyOuxttoY
 twR75IFRtpWSj+FLak/rxUYmOij3SElriwXkQIITPFkUGHjW2byeJrvef8E1+7NjoS
 JqrOhFdI/W1apI/kkMAwF31iG26yPrMpafnrg/iTQSNwUye0REu4DwuqTphMshiUr0
 Ct6s4NnOrhTntMQbPTmrrBulJfPqkPJP2pIO38rwWRjCtnXwRrZ5f2zqnYQcyBdkNB
 G9g6Zfh2q7mrrhHWr8248FqOMzORMxUNs6jxM0q3NI64bnrMj2aYGNYVk3L9VQgo9Z
 VVL/lXJaFv8YA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Oct 2026 16:16:23 +0200
Message-Id: <DM2X9C32YMZD.S3DK3U1MEY80@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 7/8] drm/nouveau: use DRM_GPUVM_RESV_PROTECTED
Cc: "Liviu Dudau" <liviu.dudau@arm.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
 <linux-arm-msm@vger.kernel.org>, "Abhinav Kumar" <abhinav.kumar@linux.dev>,
 "Alice Ryhl" <aliceryhl@google.com>, "Anna Maniscalco"
 <anna.maniscalco2000@gmail.com>, "Antonino Maniscalco"
 <antomani103@gmail.com>, "Boris Brezillon" <boris.brezillon@collabora.com>,
 "David Airlie" <airlied@gmail.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Jessica Zhang" <jesszhan0024@gmail.com>, "Jonathan Corbet"
 <corbet@lwn.net>, "Lyude Paul" <lyude@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "Maxime Ripard" <mripard@kernel.org>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Sean Paul" <sean@poorly.run>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Steven Price" <steven.price@arm.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
To: "Matthew Brost" <matthew.brost@intel.com>
References: <20261001220632.3190896-1-matthew.brost@intel.com>
 <20261001220632.3190896-8-matthew.brost@intel.com>
 <asUm6j1GD6yxeBvy@e142607> <aszqfCemcNPebrgZ@gsse-cloud1.jf.intel.com>
In-Reply-To: <aszqfCemcNPebrgZ@gsse-cloud1.jf.intel.com>
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

On Mon Oct 12, 2026 at 4:11 PM CEST, Matthew Brost wrote:
> Danilo - correct me if I'm wrong but in prior rev one of your dislikes
> was some drivers using DRM_GPUVM_RESV_PROTECTED and others not (msm,
> Nouveau), thus I have both fixed in this series as it was quite easy +
> using two pass gpuvm.
>
> So Danilo didn't contribute, rather suggested.

That's all correct, feel free to add a Suggested-by tag if you like. I will=
 get
back to this series soon, thanks for tackling this!

> Also in a follow up we should probably rip out
> non-DRM_GPUVM_RESV_PROTECTED support as I believe all drivers will now
> use this.

Yes, that'd be great, I already added this to my list. But feel free to sen=
d a
follow-up if you want. :)

Thanks,
Danilo
