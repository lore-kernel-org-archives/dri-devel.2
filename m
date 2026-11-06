Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F95C606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPU1YcMO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BE84112C39;
	Fri,  6 Nov 2026 09:18:44 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E85B910ED60
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 07:35:34 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-5e948e56af3so137371e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 23:35:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793950533; cv=none;
 d=google.com; s=arc-20260327;
 b=PSQI/dxumz0QOZrWk5esA7r1J8N8Y5ndeZYy9w2KEGEEFt8Q/DRgej/CwVp94sD0T6
 x2FcT+LkG64HXDPC9YbIt3UFT47yQXvZFgdFkhvf2kSsLFSordIr6h82IOAtwqq8ZykI
 Zaw6yuztHs5TIAf+fFwbF9qTtMvqaN9L4vmf36gQ7K50l860RxkXXKZD2ViKX60tkea8
 2tpWHpABYORkt851lKmQC24Vv6EdQe48LGBKWtqTD+cWAvQoT3Ys67Bp/Tfd0Z2q6y7T
 Xea0aVQu+Hr2iLYNKT8dskPB8YntYvruuePF5tzBkIJzaeV/C+IvXSHDGTcTWM3g114i
 VOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7ptbIZ/iYk/cUsLSNwK54InvG9cKveVC2qE/NSlCtAg=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=kKaV3tOOQOYXGuzbpsMSkTX3L/oZTNfnCXvMdLpODdqZJAOgUN6WJELH2VfSmVNRK9
 7mf51pgD1gd1UTCSJAVc1Uimqbel0KJbaOvB+eecGJnEExRBscXpooNrKrAeIVkbJiZh
 RtynHbj69q58Lu10xBF+IaiCo3VAqhqao6wRN44R4jWL+5k4jlZAjtjHCZ82Dg9cpPwl
 B3L8N/wQkqyZDtmNHhplxiabmcDF8y1VUpnrSaNuW4n3fUsA9pmQfd4kp+WNPuhyMXxi
 VvoC0xqwCmHQfZrdxOkPYyLCNiLxxy5i2ynRNB6m7gWeFHTKLrln1holit3vzplm7ZK2
 ayUA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793950533; x=1794555333; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7ptbIZ/iYk/cUsLSNwK54InvG9cKveVC2qE/NSlCtAg=;
 b=zPU1YcMOSkeiJ0QFZMn+c9+NZczG+4hmIVW98Shz55WY0Ix/X9XNJpANA9OdGjabE/
 fV+Eh3vhzfl3et85J1kQhGxmOFH6g3LEzHT9yEvryehih3Z13z9MfgmR+DI3pmHfD36P
 BvUvg1CdbysMzK6p/JLXAuhwxIC4j9vqdT7c6XFp+SnqIei1q+cMk50K/ndUzg16rCEt
 3YsKA+T80u2oTalr1zWXEtqT7juzSahcetOsEF2dJbo62/bkopiWxG4nr+Ml74PxMYdx
 +aWPWlKz6/VQ09kpcC51bdDkJFiBOziajxSyIK0YQLyzNv0gbaDFGDsD9pU5AOPSe4Lf
 GlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793950533; x=1794555333;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7ptbIZ/iYk/cUsLSNwK54InvG9cKveVC2qE/NSlCtAg=;
 b=TxoDgXoZJeF5p//ViNWk8Z+oj+3/8cG1jezKWTI0nhgNI/axrrwph1zmPeLGT88keW
 lDqDXgShvq5nRT6STc0PyH38s6W+vxsPNWhAjxIHCYCVo9cs46DzbwFie+5Z1oW70XuN
 rpZZzn9/hysDZ4jDwOD4zEsfvai9Ezfv7U2ajVjHaOEkXfCNnzC9uR0p3dK19ZfYwO81
 k6cNeoWpB8FVNdCf6TsptyEAMaSnEIPGyGpO66pW1Ogszdy2ZUPcniQl8R1Dl+sxrfwu
 a+nphOf7pXFgF48fiJR+z2XUtosrC3XAWUosLo3pzN1lmL02/B7j6pQxMZTrcC4EwBIO
 IC4Q==
X-Gm-Message-State: APuU4Z/EjwQWrXaDuMdBIdM8vN7C0IZjNhf9UXFONrwvq+MYFkhoGhXe
 zx0vtQ0bLwv8pOACUJ5Wcb9JGlLqpVErWcmZTnvEmhDcjOj4b4h0Sp/RjLpB9p+sIajrY7ThoMD
 xmSAhvpSywhqhWvTy0+V5Z0duDifeazehE/pa83TrJgCF
X-Gm-Gg: AYBFou3iSRIW5IJTwpIQ6KXNMH/vTRa55/apfZ/diNiLkl5rbDmXnmqHgPniL8QOzpD
 yI80PQ+1KD2FwIbtuNglMBvnmr2tk98KGrKKtJgcJm6BYdEEL1rRF+ow5pD2JYZWgLHMHHGxkEo
 DIhVcIYcdG9127icQNsgCQrjet+DyxKNIUpyoky8742rPyK7J1K28yeF0yQlGbHwJ9VB8WW22qA
 ZYx4c6e99RidxKFKxB7toiZrx5ppIWpHbCLsm5RI1/nRkbDIS/je+/DJh/pBSRm8oushNeLHKBv
 r20tEMdBODzdOQrt46C2rI//2Duf5S6NFOrnW48Rd1W1xoMBNTajIYnNfUXQ7qyaHBp0nw4HDNP
 8jxMggOy+tTXa4HehrJW9/HeQaPwfb3DVuwbymSvaJYs/WI4DZ9UT27rRsYi9m8ewjoAif/k=
X-Received: by 2002:a05:6122:1d07:b0:5ec:c3ed:7d99 with SMTP id
 71dfb90a1353d-5ecc43bb9camr883031e0c.6.1793950533575; Thu, 05 Nov 2026
 23:35:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-amdgpu-dumb-map-offset-v1-1-7299d94ede11@gmail.com>
 <sashiko-outbox-199163@kernel.org>
In-Reply-To: <sashiko-outbox-199163@kernel.org>
From: primecoder 99 <primecoder8@gmail.com>
Date: Fri, 6 Nov 2026 13:05:22 +0530
X-Gm-Features: AclHuK_2NbDauhK1vtY44LNfDgnkfJZczP0ASKl7ziRTUuqXw8aHM_GaounR8o4
Message-ID: <CAPf2aH3ZEXbiukx-gGqJq6Sd9_B2qQmcbLNf-Knsw-U1xYg6FQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use drm_gem_ttm_dumb_map_offset() for
 dumb_map_offset
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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

> should amdgpu_mode_dumb_mmap() be folded directly into
> amdgpu_gem_mmap_ioctl() (or at least made static) and its prototype
> removed from drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h?

Thanks, done in v2:
https://lore.kernel.org/r/20261106-amdgpu-dumb-map-offset-v2-1-0abfb77a84b8@gmail.com
