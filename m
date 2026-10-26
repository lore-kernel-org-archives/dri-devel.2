Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488F606A31F
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m1r+1o0F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A4C110F337;
	Tue, 27 Oct 2026 09:32:06 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com
 [209.85.161.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0398610E0ED
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:32:55 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id
 006d021491bc7-6f5a0893610so1898739eaf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793007175; cv=none;
 d=google.com; s=arc-20260327;
 b=pMwytVST5dZXoA4Dk3cRmSWBCJCqkf+hu3beuwe2i2fo3UwcRcCuKmd0sdsR5C/St5
 MnoSdfRcvlQI2UqRg0MtRz/HN5XXyfRT61BlUlG6M2ZBuR1WWXHaUXBS/bqu89mKw6sY
 MearqpNEmT78vrHyLa4zDSdD0BaZp26AWVFjh/oeA8c2zD41Kf3xW5dd6pqC20ztP1Xv
 PNppPltLKg7a/ky2dYNA2dB4mMlwO+H0mYgi4WsenkXf+ElzQZFi40P5zyYhwCMDY3wD
 ExfoEE4iGErUN5Fs4WpoM8R36BfvyxboqqSUtZa4enxXiN/UvsBzr9pAbGgqZlsD+ZBi
 VpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q6uMsTxs9DnFToK/y/1eGhUA0bzycwdopukAlnns2fM=;
 fh=Vsf61Zax+DlsywTYeKl0SwKhlLZ4zElvxdWJcCgDkFM=;
 b=q+QagWg7dpSNwdbO8Bzn4AucTHFRszRER/zomyCDvqZ//Sch0khkxQO8PCWf7UhNmy
 izduTCWKelI8vZISGMtT/cT3tjKr2+G8fFA0DFIK+guKjmEFz2dtAOs1lOqszLx3wI1c
 jchLB+34avfjQMz1LJY7EHm2YU3bBHnzJLCyRpKKrFmPxZX+Mh+l5VC5qDuSWsUALCE2
 7fbqXWdlMvulC5gWGP7ap4HCyS3bckD3b/GiMC6ybVSJMtDHQvY/xOsa6rksD37LHBBu
 EJL4w9ZaXoaNFegzV8D5z86tPrHxkQHj0nBbU2sEtoCXqqBjSOLd88NzVzRIacR23WU4
 TTvA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793007175; x=1793611975; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q6uMsTxs9DnFToK/y/1eGhUA0bzycwdopukAlnns2fM=;
 b=m1r+1o0FLmNb+ZkZXicvizOP4ULpikJkh9+mk4DxcRIDdYYCA2QMYpwqe1RRXKTzad
 hezOW+TFpqKc9D/U5ifcHHac5OZrVIA+cRhUSvHkg/t2jVNBgAIf2SJKMolZn7v+BVNO
 dQ6WUSEiB56/bEzCCUojSL7NbWyenR/KWe02I4xF6697FDPbFSqS8uqWMjsqfH7rTGFU
 O9WQKrotN56LvNRUdvmzXiv6g6nyMIwdC/bJY2irmch+/D+3sndcOjy3J3EDZEqLlbHd
 M8sHfYLTgzOMdKNT1I4a51n08MHVOIRknfEW9aJfCzVPgDnV/12seygom+sruPykuh29
 +zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007175; x=1793611975;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q6uMsTxs9DnFToK/y/1eGhUA0bzycwdopukAlnns2fM=;
 b=LTaFFXvQCchbxXmfSZ2RWAA/O/d1J2W8tuib7WixFvds9tpUV0R8kUXCgYIO4Fuofz
 SzP93mtJdE0DK1DRYgV+HFKpXPyf59H1/bj+qCqarzt9IY8dhO+dhXXUk3aFkMQJnE2s
 b1Ekwaasdh7qm9F6nxLBFPL+usSdS+OAWaKfs07nTa5Y6234k3jWIQ7J75lNV+5LpP6e
 aaa3m5dXmEw8v42VI4s58Kg7EW8VwirwNVhLngSVeRy+5lwFIuxAkw18gkG1bY9t6y1l
 Dcb/31vLHxJ7MxYvsQLK80gE6hLD3Cyn8mBMiV0TMULYd9AizUJC9DJmqjgtzF+ZuCS/
 fJog==
X-Forwarded-Encrypted: i=1;
 AKwUvBzO1g6CepcTtWKGZ1aJNXYwcqMPOjYnvbeMHgi//UD0bYeTBV+MCTC1nRc2pNaDONI8IUwtwmwPOKY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKXXtJLtme4PHPmHqMvPVyCTav3oXPnyk18Nn7RfBjScwAYbolE
 unbnW3hq/TV7KyXH7o784/uyB35wjHdQCJh4fUOlK9WUUnnk7PZIjWW8c7qxKw+H5ZsMyV6vXql
 HuQPZ9M8YemTUk7NModdLvMDlmZDMsIc=
X-Gm-Gg: AYBFou0AjoHfr6A/t7ssRPYhr+3R+IgU27U2Ur8kvLN8bQ/g5GMHdAhdYhHLx+z509n
 GFBz6okV8Sa1kPgctvuOW6TBH8hp3Tnlbp3RpQY86GUt6YWjAv0lrlXKuVkzdNViu/JhCCiZR3c
 LyVnDScYgzbEC6kz8n/cn+zKZdjv1k8bkHNBOsuDIfa4eezlafWae72/e5dlhevjFRydvMBehzc
 g9jiaOYUu4yhq70lbi7yFZTB1kd6Fp6DiWYj1W3tWU7PoZ7R5H9CYh1QGwfYc5auZAAXIS/04d3
 P7/d5IWycC83Kz5Xr34OqTJ+dxHUlai/Y4xvopiZXNscYRbBjFSPZYkuHVcNXHDUDqy2ScOtE4r
 P3C9V74FUWSz4sjwKkXrLmiDppDtOKIztjf3t5YoZJyGlJqjwmVX7ighYTPU2UQvGVKatKYs=
X-Received: by 2002:a05:6820:1c84:b0:70e:d5d:8712 with SMTP id
 006d021491bc7-70e0d6cd311mr1154315eaf.70.1793007175058; Mon, 26 Oct 2026
 02:32:55 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026081832.60570-1-himanshu.bakshi478@gmail.com>
 <at8cAMm6psyWsqbe@ashevche-desk.local>
In-Reply-To: <at8cAMm6psyWsqbe@ashevche-desk.local>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 15:02:43 +0530
X-Gm-Features: AclHuK9WK4Yy6vI4OA679g4Ynf2HPB3VI2XldS6LVlec7p2KSdSehO3JF_dOaiM
Message-ID: <CAGLmz9+0DoWZtmLjUq-8X85p+DrCXKazsGtN-QOccK++d+YGrQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Remove unused macro
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com, 
 cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andy,

On Mon, Oct 26, 2026 at 2:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:

> > removed. After compiling the driver, there are no undefined macro
> > issues.
>
> > Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> > ---
>
> It doesn't say how you tested this, though.

I believe there is no need for test since its a macro deletion and there is
no call for fbtft_init_dbg() which should be apparent from the kernel
and driver being compiled successfully...

Thanks and regards,
Himanshu Bakshi
