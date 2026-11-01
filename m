Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D66606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYCi0cSr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4FB810E3BA;
	Sun,  1 Nov 2026 11:55:33 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F9210E3BA
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 11:55:27 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-8b06c0794cfso18362127b3.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 03:55:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793534126; cv=none;
 d=google.com; s=arc-20260327;
 b=MrhNi6nHjflm411yxnPi9K8ft0MYWrY8DTd4qyV1pGkkRBZmPEY8H4f0PzWBgDU9U6
 1y/mD2o95LsYFg23JJ3mLOaEcMZsvoBSZ8hXlkSfxLKxCsvnUGlVD/lkap/FmiuDXoPw
 QRPbFhTuQBAgYpCdoaYnqoyciv6x2xBuc/KhcdBkv1Ayu3D45VNv0HvIOUE0lcjp4/iE
 J20XwwhGKyNXe4ylXGW0Sxk43Lx3iYath6GkyoddlJi3OiZ1zB1NMvxsG+Rqv/yejt55
 8Va2AwHvaIi29hpAZVzepp8izt5BHcyQYhZUvYEHp35m76EJYomdWUbBUYbMDzoAMrsV
 mvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7fqcRS854qRJ/jeh/UhWfPYnmMyFLLL8s53M6ZZX1/U=;
 fh=qU5R07BUaWYwC5ThJFn0JuESwrBLxjjy9ZqFOx6c8ts=;
 b=ou1NUDaUfLrbBUI88iDYnrogsF5vhDfOCG86xTma5G3/pkfDZnYjRRz0DLtgv2vlCD
 0WlzNPVLVw+HIIOCv8PJOcCry8H1wouVBUg7Mtz3LIEYVmMGd++kOYPVtjCF1Iz6AF93
 ap/yM176ld1HbXsnTaL5CNNV/Bh0Q4L7per4nf+kzUHxX2zmrYwKO+vZxoXUOu9aULb5
 vfQ9dy6jx/pF5siqAZG+2uTzxlOEj1BjRKYnz3lDPcOrVprjqjli+CeaC57LHfbTMYB3
 kfCYbr+ftX5LdVFyBeWSGPA0Cad52pAcUQvc4OE0UT6vvDx2U5lBx6wb9pDrwnHCn5Rn
 pbzg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793534126; x=1794138926; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7fqcRS854qRJ/jeh/UhWfPYnmMyFLLL8s53M6ZZX1/U=;
 b=GYCi0cSrTwFWm/7EPKUP5U89+27vHPmqewSGYVE2bumXEQbzuzKZX5XwcS6oTTi2Ae
 SGyMY2ohgOgsJSH1MHzwywAHcxBYw61Np/Gt3XfoBVi3SADyvZopH66mZK4XCPrg0oD9
 Kp/7AelY6a2jWQ235hJJStlXNWKil//d2svJEIuTLgZi0urBmzBZJq2D8gxHTkrMBfxn
 ol/oU7vdTJbz9b7Y8PwsCegJk/JFDFGff5+1K68Ab+QO9SxZALyFi3J4KNx2d8MGpnp8
 oJql0XPXTJa3xgb61zLEiLE4ppLzq0kO6CVPqBPO6RhJeLuKT10MfWCuSz+U4eBVa2CU
 tFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793534126; x=1794138926;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7fqcRS854qRJ/jeh/UhWfPYnmMyFLLL8s53M6ZZX1/U=;
 b=n6zHUDGEbxJbXRMA50AENzylrYf/bRZX5KE27FfdyU4POl/PXVkY7Yo4w7j9LVWFkZ
 BxZlmNPpnaxzuxyF1qacemDF/gLGEa4BPe5eLkaMY+TpuVVFMJldYLwvZLgE8jrnqNgT
 PBS4SaHxYNnDf5pDshJOnTR/0WWGAFuKsv+Z/UYYFDjkfmKBqsRsI1xaXPlOqWmdtLgz
 A9t3zK0ruMA26hoHeejNMRSwNkOquFIj5CMFvNlbuOGbkvqIl+XrhUBz1ToqbLJfC7Rs
 jTiADSL/C04t1w6lqtJVSy1GDJ02DDmV5Qg3sLYVd50LpSRvVLyKmjH1lwvaVGXLjsgo
 VVbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwp2twOeI5Y4A7+O88YNu1Dp+yPAfQCZkkS5tTKd6J72eLxCYR7SPTXGuwbc12g0wMy8Rior60apfE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9t6x5TZk81YMD3yqbHk88MbfQ+6uQ606udXTbPbsPbqpK2JGmK
 S6ikn4jew77/RsXmvAT8pbQOqEfAYtAkECOH4H2qtJUOfHVaCwHTEpuSkcNJ3a20ie+TmXUMWHf
 oMIxJBEfLyHezl4BosuI+/GzY2skcg4k=
X-Gm-Gg: AYBFou21UWlO4wPAXJLPBmnPfc03ryyIjEjT05MdQlRJMn5LW8l7MLZ7I36i6mFzVgO
 nzVVMfStzftNuamfYpfq3jImaoxK+p/TKQZV/Tn6xG7L6YTe6zz+ndVFqchalZVHfUNXHeACNjB
 Wp4p41NlucghSilckbOFmrjGFS4QL+eUHPrq0A1Wy6w0OMM2vPpa0DDQJ8ehx/+iEbnVLYVgRrr
 7TXHPTezwG8DepV5kuxqUFaaG2MOQg0/NalWaiJA3X9rBlxNbEywLxOYt/oScqcaOruwYOz2YJU
 G7BYMB9kJDffnUq16GYxFh56FC7ierpMr3meP1XIW+FHt9Njb/hMOyVSLqSeJYujx37sf+D+iCR
 +ZdZ+T48oq/5uFBOdxTwjhGuUm+rW/DJL/l9Sp5I=
X-Received: by 2002:a05:690e:1906:b0:674:9cc:4128 with SMTP id
 956f58d0204a3-67ba50db7c2mr5707194d50.86.1793534125780; Sun, 01 Nov 2026
 03:55:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261031083642.1076356-1-sidong.yang@furiosa.ai>
In-Reply-To: <20261031083642.1076356-1-sidong.yang@furiosa.ai>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 1 Nov 2026 20:55:15 +0900
X-Gm-Features: AclHuK-C5JJioyiCBX-IupgWA8EMz6wvl_OsWsPGARgDfid2h8EI2yQI9l4pcfI
Message-ID: <CAKbEznsRK68w=qimTHifgDhD_Roi4eg2NrBYu+r6foYRZv1ePw@mail.gmail.com>
Subject: Re: [PATCH] accel/rocket: Report per-core engine usage through fdinfo
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Sidong,

> If userspace (for example systemd-udevd reacting to the drm_dev_register(=
)
> uevent, or a client opening the device while remaining cores are still pr=
obing
> or deferred) calls rocket_open() before all cores have finished probing,
> rocket_priv->engine_usage is allocated with the smaller rdev->num_cores c=
ount
> at that moment. Once the remaining cores finish probing and increment
> rdev->num_cores, calling rocket_show_fdinfo() will iterate up to the new
> rdev->num_cores and read past the end of elapsed_ns[].
>
> Similarly, if a lower-indexed core is unbound via rocket_remove(),
> rdev->num_cores is decremented while higher-indexed cores retain their
> original core->index. If a file is opened afterwards, rocket_job_handle_i=
rq()
> indexing engine_usage->elapsed_ns[core->index] can also write out of boun=
ds:
>

I reproduced the OOB access sashiko reported.
I used `driver_override` to keep core1 and core2 from
binding, so only core0 had been probed when the file was opened:

  BUG: KASAN: slab-out-of-bounds in rocket_show_fdinfo+0xac/0x120 [rocket]
  Read of size 8 at addr ffff00000242b230 by task grep/461

  Hardware name: Radxa ROCK 5B (DT)
  Call trace:
   rocket_show_fdinfo+0xac/0x120 [rocket]
   drm_show_fdinfo+0x218/0x2a8 [drm]
   seq_show+0x340/0x648
   seq_read_iter+0x318/0x9d8
   vfs_read+0x220/0x6a8
   ksys_read+0x108/0x1f8
   ...

  Allocated by task 444 on cpu 5 at 79.841431s:
   __kmalloc_noprof+0x2d0/0x740
   rocket_open+0xb4/0x468 [rocket]
   drm_file_alloc+0x37c/0x568 [drm]
   drm_open_helper+0x110/0x2a8 [drm]
   accel_open+0xc4/0x1c0 [drm]
   ...

> drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq() {
>         ...
>         core->in_flight_job->engine_usage->elapsed_ns[core->index] +=3D
>                 local_clock() - core->in_flight_job->start_ns;
>         ...
> }
>
> Would it make sense to record the total core count allocated for rdev->co=
res
> in rocket_device_init() (or store the allocated array length in struct
> rocket_engine_usage) so that the allocation size and bounds stay consiste=
nt?
>

`num_cores` is used with two different meanings:

  1. in rocket_device_init(): the number of core nodes in the DT
         (the size of the cores[] allocation)
  2. rdev->num_cores: the number of cores currently bound

This patch uses (2) where (1) is needed. How about storing (1) in a
new member (e.g. max_cores), as sashiko suggested, and using it instead?

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031083642.10=
76356-1-sidong.yang@furiosa.ai?part=3D1


--
Thanks,
Gyeyoung
