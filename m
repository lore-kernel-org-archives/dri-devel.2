Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55C7C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2224410E220;
	Fri, 31 Jul 2026 17:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="V8uG63CC";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D0010E220
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 17:14:32 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-69fec8b4638so916a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 10:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785518071; cv=none;
 d=google.com; s=arc-20260327;
 b=Kd2y+V4u0AQyGEOQozHp0gmOD1NSGfOVHdjO1G4mPhp1Ukp40PD4nlxEaVCfIn2cYx
 B0gHUf0M9PQuhF9yXzaz1zvyMxCusculgA0zuxdOZ2ry7ABlTELHD7sPJBPy91mNTFZD
 jczY19x/mud+L0XJDx6XQbcnAsk133Sz1uwklDeW4HVntJY1BP/HFqs1XynOqpmWuQ7E
 TxGCAxngK1qI1mHxpZonW82fyQ1DJQHSXfscNzuadBQ//z5ZkuJ7EdLCbwDJiYwcOKAL
 FYPazP5r5l6/nJsfrfbVS6NCC6v7d548Ky7yH6X1gaOWH4unhd3NJaMi7hk8vYX1xrcK
 ZNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1IEjvxIxcf25OzZ9XlYmxW3nZw+p1akOleAKSM54hBk=;
 fh=lB8MoCxeuxj9+WBpgpnaE9kQhBMJEjA8F7mOKgcVVRc=;
 b=NDMMgdFJduUj8AUIDeqMgJFLoLZB6mFgDIhO9CvApqEyCzE62U22a6xtKS8yIoARms
 uwtbaKHQ9OA/z8NA7xMe+C5/q8QGfDDEJCcT9I8UkVe02GInNT6MTqtW+KxEe2iO/rwK
 PE9EMgDKJuV7Szjutpwr1/M6Bjed7zZFuwuFjkM6OfmL96Ug7IyNJuH+Ff8o8A5omyQG
 qGxXGatlM6jxhyFtUErGmsdtUGJEJ6XOmyYopd7pYHNSHRRXAgcOSoUNqRupezuafiiu
 BWO47w4xPQl6zfTdRkgRGHHMpo6l2IDa+TTtnxBfpqwbLSf6TKDBLm93vX/0qcQADNZv
 snUw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785518071; x=1786122871;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1IEjvxIxcf25OzZ9XlYmxW3nZw+p1akOleAKSM54hBk=;
 b=V8uG63CClNdy9vxJCl/MllgMFZ2dIwhc6ZdYBJVKfQU3UfPs6p3QjVrWWD4Pvep4rb
 vPCK5sOtzIccZT6vE5F1YB0RTXwQecsFF/+sN7qpAxMQKllfURxk0o8UnHQQbYsx5yEP
 psyAde9u6w+fc9duDV8lqtGkycGJscji+YtVO2Z15KttoEHPFJ0Ay4Ki1G7u+yNLfuxs
 yycG8mFur5R8Yhsnl4M6qBPRU5hQe7Ep72Sfdub5+O58+wDti1IPbFDjmzHEjSz+WpV4
 ptQ8Ne0ruhi+QMnV2c2buwYddsZoGcjbXP0gORj32ogtqZ/nSzUeBmJAACTan5LcXano
 3wSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785518071; x=1786122871;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1IEjvxIxcf25OzZ9XlYmxW3nZw+p1akOleAKSM54hBk=;
 b=F4RAfe6vfEyzGiwuEWRB13H+Wl44SINNCXZRnh083UWeOK1Y/FnJWL6zUuOqhWsaoB
 C8Kc0bRTvNcaLrFZW9wdlptC3V3caVlDR6Bv6DeUAYW2fRQwhzEET47xjUrMy5onPz7R
 UeEhw99s94c3ZR27kROlu1QDz3qvgpdiu5o2WDn7LcJaTLb23xJoB6fYpwcvk0eXAtcG
 TnDwPDr2obZmXn9rIYwnQXpFVPz1o3TwQe3w3pfskKDdTJ3ehoAYFdTkIk62In26geXg
 cfO0FJ0tk9M3CRhLfhGIL9eiYkvOkWHdxEkqCjqjGM0/x4P5CmyhJc0D5fkOJfqqeOzf
 wYXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RofOPPKXgnF6JltVJMg3QjkJZnmD83MKOAm9HM/oonoTGKrgqj9nRQRc72Y7Bui9iaYz9ubKuXEeN8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCxzga5rt/lIX+eRlmOzqJs26/54+3kjZviQT8oyIjzsPff070
 QWVZ5P2YnpyK/gFWc5dZLpW6uwQjir212IYASut+28wQFtgYnHi9DV4v5ZdifQBJW9wIvZp8I0h
 Vwxk7CF0ovgNnGr9zyUzqF36PMS1svk9Pgfm6vCGm
X-Gm-Gg: AR+sD12k4Rw26Jy9aS/1jfTpBzMgYDESDB1aAka64yT3div+T9uq48lyswdKmCAz7QW
 GwBVhFbEkVNtZW6njbD/yNg1Qdz6epWXm3vZk7+wiyccJuEObYkp3CBsPIzjowrdq6Cg1pWjwiR
 MIIPOLzEnerVFNb9EOf/4z1AraGuMsebFyI91A+PjyRqGTwxYg0rI0Ef260Wm/DD+ysoCwaC+rz
 etNlIUJ5TtDOKr2MmydwasXlac9HSXWpFFpmTM4E2u34+KPCdYMFblaxHywTC7euPogPJHdaXU3
 OgLqzjN1pp0ooeM8yymc694DvvFVBzearqrF4+T4FxYxm+DIEtOjn7EGq06ror3xjEHFHbxhpXg
 =
X-Received: by 2002:a05:6402:29a:b0:69f:d9cd:ec41 with SMTP id
 4fb4d7f45d1cf-6a0a84fb211mr2629a12.6.1785518070065; Fri, 31 Jul 2026 10:14:30
 -0700 (PDT)
MIME-Version: 1.0
References: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
 <20260730062645.233148-1-shoubaineng@gmail.com>
 <20260730062645.233148-4-shoubaineng@gmail.com>
In-Reply-To: <20260730062645.233148-4-shoubaineng@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 31 Jul 2026 10:14:17 -0700
X-Gm-Features: AUfX_mzp9OFlht_i5txZ0xvAxi8mLSvD5KWIdtBZewXay8clz2l69cTX7T1s68U
Message-ID: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] drm/prime: use dma_buf_fd_install() to preserve
 export tracing
To: Baineng Shou <shoubaineng@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, Sandeep Patil <sspatil@android.com>, 
 "Andrew F . Davis" <afd@ti.com>, Srinivas Kandagatla <srini@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jul 29, 2026 at 11:27=E2=80=AFPM Baineng Shou <shoubaineng@gmail.co=
m> wrote:
>
> drm_gem_prime_handle_to_fd() open-codes fd reservation and install
> using get_unused_fd_flags() + fd_install() directly.  This bypasses
> the DMA_BUF_TRACE() call that dma_buf_fd() emits, so observability
> tools relying on the trace_dma_buf_fd tracepoint silently miss all
> DRM PRIME exports.
>
> Replace the bare fd_install() with dma_buf_fd_install(), which wraps
> fd_install() together with DMA_BUF_TRACE(), restoring full tracepoint
> coverage.  No functional change; the fd lifecycle (get_unused_fd_flags
> =E2=86=92 work =E2=86=92 install) is already correct.
>
> Note: this patch depends on dma_buf_fd_install() introduced in
> "dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds"
> [1].
>
> [1] https://lore.kernel.org/dri-devel/20260714114654.3885457-2-shoubainen=
g@gmail.com/
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Baineng Shou <shoubaineng@gmail.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

> ---
>  drivers/gpu/drm/drm_prime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 9b44c78cd77f..fe3436d1235d 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -524,7 +524,7 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev=
,
>                 return PTR_ERR(dmabuf);
>         }
>
> -       fd_install(fd, dmabuf->file);
> +       dma_buf_fd_install(dmabuf, fd);
>         *prime_fd =3D fd;
>         return 0;
>  }
> --
> 2.34.1
>
