Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756EE606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XoC+6MMc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D384F10F18D;
	Mon, 26 Oct 2026 22:41:16 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E409810F1A6
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 22:41:10 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so3042976f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793054469; x=1793659269; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1IjnlN6+aaXZFs4fDwukWvb2fFrAKDEe8srxsq1Mvqs=;
 b=XoC+6MMcd/wChxnbp4Xo5B5kmqiTFCCDbAqb4bkyj9XK+vhtlLQqroDtlnw+/n4QFB
 BaXNhgGsqOyQv3r6d16vv7443pXWjL3qAESiWNcKi1zsRhAbUEE6AmOdUflcgswKG4dR
 h3ti5QyRv7VKTJupggkjf/tWZuLqDouFGw9Z1z7lvdqTCKa99i5xLAwRWBl3Irk55La9
 3M4Uj2RhhOzwwYb7+2CWDRDogYsmzpPzwbNyABGw+m4+Cq5HA/3Jsw0tQLN1H4JAGHM6
 DWAl0qFco1jCTPG3Owv7HG60uEaCIsB5zY0mlPEpSNSSbj1OVeL7ugqCYx8yxLFc8loK
 fU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793054469; x=1793659269;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1IjnlN6+aaXZFs4fDwukWvb2fFrAKDEe8srxsq1Mvqs=;
 b=JgrpnAkmpFdwjZyPPOMXYo7k2hu0tV6+l4dqDP3sNeDSVTDeDlEbekJIuaBKTeDhXn
 HBBPSkP8Fz1G/buBcD/sz7Aklk1Nze1doAJ2ts7SPV1Bkf36TxO8Sf12E9zcIMLOfq0M
 v//bsO035rS6H3ftc4QC6AFWx6c18q8W+v8BNQONLmvG7zeky2+f/OCG5/qAgJ7dc1qc
 SBOPXUFouIgpW7cGw+ifx1+JgHPbyYhgKdEWwYH2IeExrR6zzRIlDni/XFwHB4UMm3Y7
 yOsXGsdamfwheX6d1umBqNyK/rpMM4Ldj/pRfgb0zipgQ2b866z/jUHtJI81VTW3C4mI
 kWyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBykJYj+PVPtHSPSaQiW0xZXNKauO2RSCOw9KL96rofUgWjANsSioRWCMMSa71e4bZvnKRmfuCrLFDA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYISGioPGc3c8mAH8ZXjcTbf+PAVWBuOWyTmk7VcZmqtEf2Xl1hF
 f2QxKtEVy1rUY2yalkKrz69rKk45dMEASq/6GVaL1I7M9TbgIAXok+hI
X-Gm-Gg: AYBFou3LgBZrs/Az466+PQnUAPH1M3Ys+T17DDl/UrMzezRULowEMqig06fWFw0/XLN
 HXXgx4geG8JrD7dMczz3oQ+4HnHIkLk1GGJ4yJcXkxxYe8Y9xyxejdt9uxuphWzDQEew0VKGRcc
 fJjvjMaI1aXnfp1gy4xazqdsPHz3INRH27nDGzuO94v+jOfKDvKW1uzMkgKa7a41iMgNmQy/lcg
 9v835QE6V9G9gKIXYL973tXOKh9Q4DGq2DFnW/ArRlSZAyYDg+y7G146Jjra3e66uRudyFG+Lx5
 7zY/yZSatzvgBjp28awU1CynabsNEZdAKqVKWBtwu/zbt/urooKrtPFcwMt+/fBOy3HG2p2o8Ky
 ++mGXT1IYxxyJOD2OdPUNqAxnV30cd8MdcD4+ZQ7pYaNnqcWvc7+iBKXdsWpfn+JrRCXAm2/B4P
 jdMrXgG+V4uflfesHNvbKpf5fT4XRGdUqmx6oOo08gKQZ8esm8urzdDg6CNL6xTAIEUVweuK+P8
 pYT3eynK+LUS4dgp8kmFxzXU8/Pszjhfn7o/AWRGLYjR2MKKrL0t3JUM7dmTmTZFuIl6eX6Hi3Y
 KNef2yTzHHPlq0g=
X-Received: by 2002:a05:6000:1a8b:b0:48e:3085:425f with SMTP id
 ffacd0b85a97d-48e3eb265camr18739691f8f.2.1793054469211; 
 Mon, 26 Oct 2026 15:41:09 -0700 (PDT)
Received: from [192.168.1.253] (4E5C1F56.dsl.pool.telekom.hu. [78.92.31.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dd7sm18468284f8f.15.2026.10.26.15.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 15:41:08 -0700 (PDT)
Message-ID: <0c7e45a13fb78064390818bb501e754b62f16f6e.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] drm/radeon: process the VCE interrupt on SI and
 Trinity
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matheus
 Tagliari <mptagliari@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 23:41:07 +0100
In-Reply-To: <88c61950-125e-4109-955e-ce09ebaab7af@amd.com>
References: <20261022114754.865669-1-mptagliari@gmail.com>
 <20261022114754.865669-2-mptagliari@gmail.com>
 <88c61950-125e-4109-955e-ce09ebaab7af@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-10-26 at 09:22 +0100, Christian K=C3=B6nig wrote:
> On 10/22/26 13:47, Matheus Tagliari wrote:
> > radeon_vce_fence_emit() ends every VCE fence with VCE_CMD_TRAP,
> > which
> > raises the VCE trap interrupt (IH src_id 167).=C2=A0 cik_irq_process()
> > handles it by calling radeon_fence_process() for the matching VCE
> > ring,
> > but si_irq_process() and evergreen_irq_process(), which serve the
> > other
> > ASICs with VCE1 (SI and Trinity/Richland), have no case for it.
> >=20
> > Add the same handling.=C2=A0 The trap interrupt is not enabled on these
> > ASICs yet, so this does not change behaviour on its own; the next
> > patch
> > enables it.
> >=20
> > The SI part was tested together with the next patch.=C2=A0 The Trinity
> > part
> > mirrors the CIK and SI code and has not been tested on
> > Trinity/Richland
> > hardware.
> >=20
> > Fixes: a918efab631a ("drm/radeon: add VCE 1.0 support v4")
> > Cc: stable@vger.kernel.org
>=20
> Please drop that, we really don't want this to be backported.

Hi Christian & Matheus,

Why wouldn't want this patch to be backported?

AFAIU the main case for this patch set is to fix VCE1 for people who
are still stuck on the old radeon KMD on old distros that ship an LTS
kernel version.

Timur
