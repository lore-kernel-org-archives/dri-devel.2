Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B2606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B2610E2B4;
	Wed, 25 Nov 2026 08:53:52 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0912510E2B4
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:53:51 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-85c1135c286so4245066a34.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795596830; x=1796201630;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g2VZTRXJhfP019ydeKL5YFHq+Ono4E72cezNWVIlDDs=;
 b=rDvN7PSUOM4PZ9NPpeGpYtxrCOZg74juEQfym65gIufLU5iILFkeGDZpixt6k1yorc
 v8+lHEQJPpmz0iK4OcRy1KQC9L8NOsOis7sEego21EZlIMw5HUzpi0ppxPfesRIV2q3K
 ZVxlx5l58IA4TXXUJcR3rrrSVN47eZJFnA1Vzqo7FzkbmaJMRBj9xGq1P33AxN6oAXYO
 MAk/O7vaDtCUhF1BY+C6n9LwuUWeN/HnyODkkJDxdDM9ABatOvkdGMlwKbq3QEZwXlHH
 3pTjcOydUrG4EJhRrBQ2Z+FKRUQgW2YH1TLN52jmf1Pj3uXsCnGkW4Z6OKaY+TE6s8Lb
 l9Kw==
X-Forwarded-Encrypted: i=1;
 AL+hErGl4e5mrAkV6JIQcOV4U3TOPW56tVoFrdh0SlAJm0+FzxRkXE2ibkwtP9Z+VlwcF6q4sarNjBS33XM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ODFbfH3W5r8ItTMADdMVik3llKdjF5AZyyy6o0JXR7ESObRml
 +TSndCcrmqre2/HYSiriwJ49Z3zo2/SEIiA6NvkhPOqwuzS/ypGips6nx8yTmLyh
X-Gm-Gg: AZFdTZcSdVajYABBAfzjy643dPLoGFRebUfehDq9i+Wsb1dVvdUrQATqRAl/JUHjYqc
 OlP6yExOvH/LQxrxPgWQBHzPvY1N8RolKcewE0zrC4EjeMnx+4Q0nPZ9kD0Lf+oVUyos9uTcafA
 V9aLJdJvJuQ+zc13uPATN7Fdlmsow+mx6pjH/9ZzU0YCvp3d5eWJa0wEyDDUE5QhMFuKfE/D0SS
 hTf5ayUstNsX1fS0tfGGhVyOsfvNJADlnzVym6q3aKGlAnX84mO/wKIo828OUY0qAQf6XeeQtpy
 zvvDUzGP0dfz0dxpJSLR426vbjkauCoD6B1PRWDauUcXqCHDtOjDCvStrP3AyMdNtwimrUiiRQ6
 J51gQ8nFc+QmFNYUG9l65gbi5d9Ec/kNw6X86NYwwfgg6iblvqnzl4yisI0INmCvIoL/CtafE/4
 qrn8LFWzDL1mBapBM4PShjmOKSv3a6beh8fn6jZzjaWnowXmme2Z4igiUq+paul+qDMhqkSUbTQ
 wZSe0qm0w7fvoD7qOk/lF2J/W8jkY8TiFgw4hR8lxVn+EQ5tMDz3AgrS3HHHnZBsheKxp1vnfw3
 z4udrzZL0aLNCHs814HFzaUhXRRSADs/8iDq+hAyjFdKU49FL2BZInQtEJ4Hon4CU2M=
X-Received: by 2002:a05:6830:4103:b0:862:e9e6:62b0 with SMTP id
 46e09a7af769-86315646d6fmr19084385a34.9.1795596830070; 
 Wed, 25 Nov 2026 00:53:50 -0800 (PST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com.
 [209.85.210.50]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168bdc75sm13903036a34.8.2026.11.25.00.53.49
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 00:53:49 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-862df509ccbso2767175a34.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:53:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGDAbaEq4SARWhyc1KY0YB8+/ZxHVf7SriGr5lAmoT0ESDCuS03soTj+xX8YOIFONHtgnGWgeP2cv4=@lists.freedesktop.org
X-Received: by 2002:a05:6102:cd3:b0:7cc:56a:58da with SMTP id
 ada2fe7eead31-7d7395d630fmr7124513137.23.1795596450466; Wed, 25 Nov 2026
 00:47:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103-prep-meta-fw-arch-independent-v4-0-513d1c51f458@imgtec.com>
 <20261103-prep-meta-fw-arch-independent-v4-2-513d1c51f458@imgtec.com>
In-Reply-To: <20261103-prep-meta-fw-arch-independent-v4-2-513d1c51f458@imgtec.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Nov 2026 09:47:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVqGEZckVZMnmKfwpJZ-sT6Jisj7JkL31uS0S_XABCbGg@mail.gmail.com>
X-Gm-Features: Aa3M54oYWwJ4QX4LtZBAQOtixmcWW5HWWBj8NKw1oLcuyKzIqPAFolEjnn9UcmQ
Message-ID: <CAMuHMdVqGEZckVZMnmKfwpJZ-sT6Jisj7JkL31uS0S_XABCbGg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] drm/imagination: Limit access to the RISC-V
 firmware interface
To: Alexandru Dadu <alexandru.dadu@imgtec.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexandru,

On Tue, 3 Nov 2026 at 10:01, Alexandru Dadu <alexandru.dadu@imgtec.com> wrote:
> From: Alessio Belle <alessio.belle@imgtec.com>
>
> - Rename the RISC-V firmware processor header adding an "internal"
>   suffix.
> - Add guard to the RISC-V firmware processor header to prevent
>   accidental inclusion outside of the RISC-V firmware specific logic.
>
> Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
> Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>

Thanks for your patch, which is now commit 2f42457ad97a6d32
("drm/imagination: Limit access to the RISC-V firmware interface")
in drm-misc/for-linux-next.

> --- a/drivers/gpu/drm/imagination/pvr_fw_riscv.c
> +++ b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
> @@ -7,7 +7,9 @@
>  #include "pvr_fw_mips.h"
>  #include "pvr_gem.h"
>  #include "pvr_rogue_cr_defs.h"
> -#include "pvr_rogue_riscv.h"
> +#define PVR_ROGUE_RISCV_INTERNAL_H_EXPLICIT_INCLUDE
> +#include "pvr_rogue_riscv_internal.h"
> +#undef PVR_ROGUE_RISCV_INTERNAL_H_EXPLICIT_INCLUDE

Really? IMHO that is very ugly.

>  #include "pvr_vm.h"
>
>  #include <linux/compiler.h>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
