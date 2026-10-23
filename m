Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC469606A324
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=YRf/Yj8Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4360E10E2FC;
	Fri, 23 Oct 2026 12:45:30 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E32510E630
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 12:45:24 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8a070755c8cso407179b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 05:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792759523; cv=none;
 d=google.com; s=arc-20260327;
 b=ADWIuoS1wt1rI/NG5yXxhEUSgVcD/n5Hr2a+ZFkDR/tagXKWDo1terto3RxhciDUf7
 bF4ucOTomMN5kQnfO4SPmrlN6h5twGZeFe97HWnddlC4fmLJB90b6MpxqihjLJ+NEjpA
 3Za/L8N2Zr2UdKVZSyFbIRojKoI2rtTaYkSAF2bYBapTtRiyttea+zv9QVb7t5mQBAfJ
 CWlS/ALGfcIVahUz9PKK2bQOP2U9oRjege/zEaWA5E2YAk8sx9Al/40xL5vWKUHEgGQv
 pL5R/0fL+cJnNn6KCAvRFCc7jvWTM0oU2yd1ISMmZaHNuj2poRbZuaKbSps2VRitkcKn
 acPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Zx+fiD+M8Z10jKgGA0r6/kgAA4dQWOpHo5PXv9d4FsQ=;
 fh=Toj60BvzYkGNvKiKH+P6Pl4vonZJeZmWnLPYIX8PIlQ=;
 b=EyUntBN9s+b0cN2zlfC8FWPRSs9LrdJF6uOK2JtX/x5PF17GrtruBU9MlaJsoPQlKE
 qKpSaQh6c4ITP+GPtGJGK/Nd6Tddn7+0FDMGi6K0dIsQ01O/0f3vdgZmFXnIitYB8j2Y
 Ug9n+HEjYGkMduCDf/yt/FglrtVB5+WCKxUSXIhejL+xpOEPYR8Q3ts6Au1q6FsZSRIy
 fVzmB9sgEeyNQYfYKDuet5XudQ3hkAsqbepZc3K7WwjiDGPZwQBXMWMN2iTar7Hg+Yjf
 MvzK7rPje+0LP2vXgW7EsUCjo3K9T3IquPDX0ObSLHNdOwY7PYKxm4HvMdIAxHFlPyBX
 qTYw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1792759523; x=1793364323;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zx+fiD+M8Z10jKgGA0r6/kgAA4dQWOpHo5PXv9d4FsQ=;
 b=YRf/Yj8Yp4fKadLKn9hslMhpwPixGOKhVvnM2HbN8TecZpI5dGiGsM5xaPTdVD2N0C
 2nzMU9Qr7vlzAFk7dcAhh0YbmAe91jb7xydJiUG7jSXi3rn+w7YItdrxJz9KQGPqSNXP
 kAbUG3f9+Olv5+R1qwY+jt+dUK436Tq1jdCCJ23dTRerHUz0CGZogvEmBaganFksbQZ5
 uecUjyLtmWb8KGKzxYq3zhyXeLfOLtOkeiuE5SC41y3jyWUuKugFK7LJwn9rzTpdJUnk
 4p3jVY54DRuSxq/iHZonjD74DmOGM76v5KbO7hVa4fLzpOQPwSZECM+/YaUOzinVaa/I
 Jj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792759523; x=1793364323;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zx+fiD+M8Z10jKgGA0r6/kgAA4dQWOpHo5PXv9d4FsQ=;
 b=F/amUMnXbgRcc5hVgnDUC3V2a1x7sugtNW/CeX4K/Gmy8aewByYIQZG9ZYdAM/S4Nm
 oqFcaRg0kXchCzAUPBKKV/Uf/hdQpem9cPSo0CbHplzEB0lkX5DWx4oDGUygVlEDyEDJ
 Ixz/Z6aNarTSQAoWoy/+jRS1aFzoGfHWDifahQUy3iBKZwd3DRGOaCNZ1jAZWLpLkMqn
 jpIbmRsbRs05WP807uK/WK/sLRTTJ40kAVMge81wVIB+ECpztheGHIcnrePDsHkgsrjK
 7CNY2eMWh3OTmw8NUBiuw8sSrxSX1IK7alYqg5wgfAWew+IkpvLvBDo+o5ej3gItZOrX
 UiuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSoIm4bsLFzpmO3vBztWwxDRcCrb4hJPZTrKVO3osglKRKVeQCX/XaBBCx/FpYkQyirqk7hMjNFRg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJmW6bkMlAmbPDnoAN/tyfd1+yotEszqLVddwq2g3I26HYAUZ4M
 MzEVXNyrptpUtnYxxeF0XpkCq2844gyUsay9/IZKfBwi9UvG7NB8mH/zGX73VaBOWXw5x+W+t0A
 GIZVAfyqvyebNenbsuWMnz95Zr8wcMzYQSNZ6S2y8ug==
X-Gm-Gg: AYBFou2dBFTIzWc2A69QYjpEX+Ng6NXtwzTpgKygf5KerFQ32AcfHS8mViaWtYCO09o
 roSEZZddvo7NvNsNFyYFq8Q0jngRyLFzt0IFDXSwKlrQLjYCDjGxyWIimWLLBhlN0hKekvE+RB+
 KEUwYhyVStZLIAWEbHIrbGP4It/A1zBS0LppWK7wAQmMhyq0+VxTj2j9UzDxC9pmPvaMbFk6CJq
 TvJodN+66Bn/VmWrISxGHk0esakqS6M8DW9FxOuQEvO6frJ7ydBgh/OYPXYXA8nxgFo2fTKNs92
 TAuGANQc6v8yamGH83WHj47aKZ8EHd+Oa+m6RWk4zWQsuc4JpCPCn1Ik2cEjn/iuDT97b809chc
 n0msITI/dLYPCcNoGbRYoagI3axH79gIjcCLZqQ==
X-Received: by 2002:a05:6a21:7e8a:b0:3e1:c716:3a00 with SMTP id
 adf61e73a8af0-3e3766b5ce0mr1335701637.53.1792759523482; Fri, 23 Oct 2026
 05:45:23 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022-panthor-as-mask-v1-1-6aba7ad8cb9f@igalia.com>
In-Reply-To: <20261022-panthor-as-mask-v1-1-6aba7ad8cb9f@igalia.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 23 Oct 2026 13:45:11 +0100
X-Gm-Features: AclHuK_zpAYlgxx5RKrw2i4Crb9PlFHl57EFnPBRh-N_CjUqxfh70BobqBJbeq0
Message-ID: <CAPj87rOWN_WVrDsWA2o-Zo4UMbv26vswut=P53Ezamb7q_AsQw@mail.gmail.com>
Subject: Re: [PATCH] drm/panthor: Replace panthor_mmu_as_fault_mask() with a
 macro
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 at 14:43, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
> panthor_mmu_as_fault_mask() ignores its ptdev argument and only returns
> the per-AS fault bit, which is fixed in the MMU interrupt registers.
> Replace it with the macro MMU_INT_AS_FAULT(), which is defined next to
> the other MMU register definitions.
>
> No functional change.
>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Reviewed-by: Daniel Stone <daniels@collabora.com>
