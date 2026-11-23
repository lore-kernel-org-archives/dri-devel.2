Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B942606A68D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=parXm2QX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F5F910E2C5;
	Mon, 23 Nov 2026 18:41:53 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32BD210E4D0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 18:41:46 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3b155f50c24so2905702a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:41:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795459306; cv=none;
 d=google.com; s=arc-20260327;
 b=Jl6E2QfsJydSBABmpFsMdPUJb1G4plIZPyBWJuheKcJFsMYqEYI7w1cYYoPdRQkBbx
 PoaP3hsB6QD3qGuB/ROA2uyj6tCHyqOabW+kdEl71dhuRdvJh5dDZKBj5FNaCJXwLrBp
 F1FHcKKZXp39FX1smglCaYoKMGkTIkDv7h5pXKX3gb1U4oKNDaevhPPPoxdsukaCUymp
 mSGDWfmGXpGoSHmAcLMZaqoX3hDr6B5V9Ox0zcowWDeJtHFuRU/LqfVR+vBdqQrT2MiU
 vpJbJJ5UIxpecMmn46B+UC0QR6hDbiK/hDYOXa0/fdr1+FxSZ1uIiSV2JtccE5RUVLu4
 Nvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7KCCFV8c12xHGuVa12sa42pR/GvO+E15oZ8scml+fpM=;
 fh=vgC7DfJvS9xpdpXlLsX90vVMzImrHbxLZifbxmp/V0s=;
 b=KoudBcu4AEriN+YDJn31iWbl4Barn6JWJObCllKro5TJM95rQacaZOMfyK1jFd9bXZ
 ArHCQC3vb4ex35MFYka7nlFqzaZeEnpJW1Gzhc9I3x+b9I324NIWlr5DYHmJePA2y/6P
 L7pPOgIupssW+7EPQ22ue5BEXIbjdxeEiz07HhIp8B1qwMH7W89OVCEfp0+deXUOWLG9
 JF/IGiUNv2A/AyPKbce0bPcGBV5KIadAeZGXexMExS/Ht0FXeI6xdp7Byckh8Nj3Rulb
 BfB7kr9lJ88/15YxmcNJAvxaZnRPIiwPyYunIf7szR+zFVJhpo3G7rZGsvGRvY3yvP7k
 BRBA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795459306; x=1796064106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7KCCFV8c12xHGuVa12sa42pR/GvO+E15oZ8scml+fpM=;
 b=parXm2QXj/P9bFgzSZ8WMT05dJ9G9GSvT43ZWUgoYXeogrwKGVlfUxorR63jLVsTpt
 iTmUU2YY7qrDtlr/4IdlgWxSeFCB9JSo519WU5dpgI4CIZXYWYQkvkQEoHb+bZOjk0Gu
 Ns2g7pEkIJfvI63C6LsaGHBtc6bSS6w5JbK+wQ4EwnLu74Rf4KeZ3CzWJAZjqxOBOIPR
 jMRL9yYKuXKTUrzIr6j5ymF8W1SpgvDr1UNXcGQ50H8lc+B1bF8i6U5zq7wGAfPvaJbP
 buL7zZLv+j7seGrFF8UOqjQPlm4O2W13DDuJTfSQxCPbz0F/mB2J0mgcg/pGusVn4l81
 7sGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459306; x=1796064106;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7KCCFV8c12xHGuVa12sa42pR/GvO+E15oZ8scml+fpM=;
 b=RK8Ksyt72lg7t1QySfjZ1sijDw5FU2jYbSxIUEqwsxt6GhDVglgZ0gBD1yBu5u1g/h
 M58WgBL4ggQwzJPUKvHAYuMiWkUVRrZvtX8ZIcB8FUsaJgsXS7pAlsXBYlHuCLowNcXD
 zl+NFO0MJcdOPrHF9kSGy33DTug//SPBFlueUE8mtcVi0Rha3yeuKj7k+tZp7ONBVoBF
 /TRgVnc3QlpELqjvWW2jtQkhKXEUb7I/nwLAgaNLvtRNAd7DbdrgCH1Bktdzd1B7b9qP
 ROG0aZZI5yYzbsOjqyIHmWWNBcfAZimpI+9fwhyRwZ0olj/Pe1pcs8RUreE+NViNHQPd
 J6ng==
X-Forwarded-Encrypted: i=1;
 AL+hErGBDPidOG9MpGIr2qVKLG28n/C5QtT8BxyBDFuxMbyvqc3h7D/YU2ybpMpYTqCwcU1y7Rkg6IviLbw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8LhCjjl71hZu5a54B09AZg+oN2IoHPkij3X3UOsT7iwvEHsmgU
 FJUGpAbQs3DW6JNl7WVU6nmMIO5PCWrM8UdzX5qSNLMiuoB6L+Z7rKxwuv1UBU2iD0pRZgsoSCV
 OOV7byGI51abgNyrAUGZGKVJcKjLLPy0=
X-Gm-Gg: AZFdTZfn8K3S/C+E5cLoQYVcbZSAVVveWjLyWTMpInvR1J0k3PQCWNM3tKQQqedqm45
 XGe88QOaBKVC8gW9iEsd3Tre6dEzZm/tyAEahFjzKAgOn2FHcFMG3g5ID/Ka4X49WSh/FM//JPI
 N8NZZlozpam9US5iIpNxjVIPmt+MAV/1ly1U1QmuW73nnGGgj8lBwRUfewmKJ7Nl62jn21Qv+1W
 9kyTEuWTa8p72SvL2kTVb9H1x3ME9i+GIGAzUz3UeSM6LUj3tH70oXW+m1XS5BpwhUES3K8VfAz
 v41kgtTsIq/bHR9we3/APPaWo3VGlT2kCYeGKC2O6nPs9Rq4RtcmZ2hZ6ELdmm1+PSDGoh+X+BP
 /bd96SpuZc+wGlGfx1LRBD8IF5cRf79Btp+Mgcw==
X-Received: by 2002:a17:90b:17cd:b0:3ac:6fcf:91d2 with SMTP id
 98e67ed59e1d1-3b41c8fe3d1mr11633543a91.19.1795459306227; Mon, 23 Nov 2026
 10:41:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118-orangepi-gpu-v2-1-f68676f844eb@gmail.com>
 <20261122184434.545341-1-frederic.mahe@cirad.fr>
In-Reply-To: <20261122184434.545341-1-frederic.mahe@cirad.fr>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 23 Nov 2026 19:41:00 +0100
X-Gm-Features: Aa3M54rYymnQncJINmj7PXylw19m9Q_Z0b_H3MvffZyCzTJDH31b-Bzjr4MRK-U
Message-ID: <CABdCQ=PnfXRd2=b6_yEN94RCRvPnWx-WFfHZDC+jhHv_UFZ1ZQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: dts: spacemit: k1: add PowerVR GPU device node
To: =?UTF-8?B?RnLDqWTDqXJpYyBNYWjDqQ==?= <frederic.mahe@cirad.fr>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Baihui Liang <liangbaihui@linux.spacemit.com>,
 imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Fr=C3=A9d=C3=A9ric,

Thanks for testing this on the BPI-F3!

> Two notes:
>
> - On v7.4-rc1 the driver refuses the GPU ("Unknown GPU! Set
>   'exp_hw_support' to bypass this check"); with
>   powervr.exp_hw_support=3D1 it works as above. Is a driver patch
>   adding the K1 GPU pending somewhere?

You're right. I forgot to mention in the cover letter that I was loading
the module with:
sudo modprobe powervr exp_hw_support=3D1

I plan to send a separate patch to add K1 GPU support directly in
Imagination's driver.

> - The GPU never runtime-suspends: after 160 s idle,
>   runtime_suspended_time is still 0 and the power domain stays on
>   (autosuspend 50 ms). That looks like what Baihui's "drm/imagination:
>   re-check firmware idle state before runtime suspend" fixes.

I hadn't tested runtime suspend for the driver before, but after you
mentioned it I gave it a try and can confirm it doesn't work properly.
Hopefully Baihui's patch [1] will fix this issue.

[1] https://lore.kernel.org/linux-riscv/20261111-img-pm-autosuspend-v2-1-42=
7689f6f2f9@linux.spacemit.com/
