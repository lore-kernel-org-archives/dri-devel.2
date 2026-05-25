Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA3ACD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 07:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC8610E4E6;
	Mon, 25 May 2026 07:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lc7PyXSy";
	dkim-atps=neutral
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E41710E4D9
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 07:00:55 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-38be5e86918so114626641fa.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 00:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779692453; cv=none;
 d=google.com; s=arc-20240605;
 b=lyUJMUtcfnUUFEACMkGWnKiXzX3yYGEzKE6oO4P3qCgQ/IQOMSDPxeFtX5Dgz4pT0d
 XeS5Ws0EXnzZwxO8r+T+PI4qBsTw4oHPKQG9zBYlKDQXT756/FXftODQSsovsrQsHNyT
 abjvIqOixe3Nj0HxzDX4j/WkRZKoiCm9wzujkQM8GQjnnXDsliWKPENsjlhVuJ1nRKsr
 AO7bVy552Fc9rpuupMPOP0TgK421glVU/+3MMXilgA98bfvEo17kxlih99abOZG9aPNm
 u7/z10ueylldtlt+RTx6ToxGLyMrx2l/hAibuXEWW1EHv0YsR+gsxsGJO09mPsbuW/nk
 0tfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JUjlbnJYbkRdlxiYQtavpZsY3nMGypg9CaIw/zecZ9o=;
 fh=nZXM94EmuODnR0RSWMrAMkPZDZ7P8luwjm/mFt3yG/A=;
 b=dmpVEv+rm56aYHzw2cRPkEpv3L5XpzjAVo1fp1c0U4eDSAlViZJZepW8YAjEfrbwLL
 pmqbILVqBjdU6o6jLGokNTq+WJ0H16PGa42AlkEvoXWt/s+QP4RIO7tviwVtkTFU8nt1
 7OpvheGyWgVrL4VV0Ja+YlFYVsAfv2eRpglSklSRnvMO30hPh/wY4g2302MFAB/5ULov
 pa35XbjdOt+c4wrQyJbs+RFvRZFmlsGUK4oao+P9gvHeqHzKQwBjzbhN/1jlcsNOvcYx
 aG4qUkrmU5iMsevuYDJ0lvRAJGrcgU228pfIdoaB4Q+0mMugxxo11Nisdxc92EFSb4Ub
 aW+w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779692453; x=1780297253; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JUjlbnJYbkRdlxiYQtavpZsY3nMGypg9CaIw/zecZ9o=;
 b=lc7PyXSyjUkWoCBkVsfHIr9ZXURk7Yyc7C3GA97k0DCQC3gq034KaEhXn0scUGh66p
 x7jzGib27iLp160Gbbi9zxwCOXVHNpwvBuHTEItc4doUM4tKJ146y8JBFjGRVgwtqJvn
 aPoYExWkaPkNA46jOECsi61YjDTnZ8FCiaO2bgSm23gGmRfCLDS3ErSGmhphNhpkgj3p
 xzNSy2bkR8efoNMqeHT7w7qVGcJJdp5nAHqiOACn6ewdzvDiXiBZezxW9orRQPjdUv36
 cIWmyxJZPFvVYZ3UDQ1pzTbBDdVXEo/hMimYC9G5FkrhWP2QUMj6TDQTu/NdPwn9F2r8
 gLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779692453; x=1780297253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUjlbnJYbkRdlxiYQtavpZsY3nMGypg9CaIw/zecZ9o=;
 b=THXkQtAckbvL0wN90ONSZRnkgm6ZvWNr7r2XnlzRwBEPqzXcRoXZ761+inz2gP5uKl
 oD1zwCELGIjBM27ueNERz90NFhXit0M59MEvgQZv58+1chX9/jkJYgaNrJhOKYx7XycK
 ywn44vkTWvF4ccivMzbX5I+Xa9UQbUyJCTcXmP1I3qqIlbwy4sQnGh3vxw5MQ13bXNaw
 B0Cj4Y8mvJz9/tLs/6KUjRjnSajtGVfwmas3VtOsijoYwAvEs0kd8tWqGF0cyWpqoayE
 NPhcxZz7AKStmf56ta+2qZ4of3GXpIzMnZngg/dfSeh6lQRI68p3OtqixOrgqZ95S6Ra
 lI/g==
X-Gm-Message-State: AOJu0YxzIHUDaALFJq2XdKy54mn5InLM88TXLZo1uHGtT8fl8eT+cW18
 g+VcEV+L8cpH2jBRT9PUMe6ztXFQP3R5n2yqEOOn7B2GiFFhisW4bXf2qmpwNHMfS+apinkLVWY
 TpIFD++K4GD9N5d3OCA2ClvKEH4OWBqQ=
X-Gm-Gg: Acq92OFiC/1ZEeUE2Ux0sodN/vwl5hG5AyzdrqI21mO2aBSkgvTsT2oF+Iq7pbP9JpG
 M6AND7tsO2BubngC31hlVWr7eb2C0wewJyjQ26l1yNx06rf8faypiGBHPuUG6pA/dnzK03qJsgm
 LqVCODJASOWRSiPbHxKE6pNu4hwTXU/czmo/sS01a8sXPYImGphcZ8tBpgmDxsdW8EF7FnIZFSe
 nvg4qZup0MkMQqklAlI20hZOBjZMhOhQOp5dgbT8l49YUeJdTlDB4+3HH4MP7Qxut+1e+07qw0h
 Vqjr+rtw1fcB4FRn6gYiw2BJc3XWjZmYOQ50m+6j8KcKhybI0Q==
X-Received: by 2002:a05:6512:3e12:b0:5aa:12a3:461e with SMTP id
 2adb3069b0e04-5aa323229d5mr3611414e87.16.1779692453186; Mon, 25 May 2026
 00:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260409154826.8955-1-yiconghui@gmail.com>
In-Reply-To: <20260409154826.8955-1-yiconghui@gmail.com>
From: Yicong Sito Hui <yiconghui@gmail.com>
Date: Mon, 25 May 2026 08:00:00 +0100
X-Gm-Features: AVHnY4IBAVB4xP9dmdekyumR6_AK_QjMPnGfuyn_CtUFiDxM8NPxSnbL3u_hqbc
Message-ID: <CAJ4mek1UTYPd5E7JgcZ0fpN4KoB4z7oSPoxbsNUXmdN4uqgFgQ@mail.gmail.com>
Subject: Re: [PATCH] drm: Remove unused header in drm_dumb_buffers.c
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, alexdeucher@gmail.com, 
 christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, me@brighamcampbell.com
Content-Type: text/plain; charset="UTF-8"
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

On 09/04/2026 4:48 pm, Yicong Hui wrote:
> Remove the header #include "drm_internal.h" from drm_dumb_buffers.c,
> which is included but not used.
>
> Header was introduced in 47f10854ca89 when moving functions, but was
> not removed in 96a7b60f6ddb when the drm_gem_dumb_destroy function was
> removed.
>
> Compiles successfully with DRM enabled, pass kunit tests and
> IGT-tests in a vng virtual machine.
>
> Fixes: 96a7b60f6ddb ("drm: remove dumb_destroy callback")
> Signed-off-by: Yicong Hui <yiconghui@gmail.com>
> ---
>   drivers/gpu/drm/drm_dumb_buffers.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
> index e2b62e5fb891..61bf3c9b7182 100644
> --- a/drivers/gpu/drm/drm_dumb_buffers.c
> +++ b/drivers/gpu/drm/drm_dumb_buffers.c
> @@ -32,7 +32,6 @@
>   #include <drm/drm_print.h>
>
>   #include "drm_crtc_internal.h"
> -#include "drm_internal.h"
>
>   /**
>    * DOC: overview

Hello!

Is there any further feedback or progress on this patch?

Thank you!
Yicong
