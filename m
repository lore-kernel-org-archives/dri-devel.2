Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10318606A324
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ail3lb8U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7353910E1DF;
	Wed, 21 Oct 2026 16:00:53 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4240E10E1DF
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 16:00:47 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c37b612635bso128495366b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792598445; x=1793203245;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5W0wO5ApY1ruwZkrfuprI8pGOadn8UJEcw8Q72azQTg=;
 b=Ail3lb8UntkaJD6VdPQCUkHRTjdgCMlXctlgs7coH/ObzHmEce1F1bYAVqRagaT4wq
 c/+2nDfHfHeQODuCJbIGZBca7lxr9+sYBC2kOctBRv2ydVXqlwaUYAyvFUVpS3wYJx4L
 I1xRuH7qja7znj1A8rAY3+Qq+rQOlGbGZxzks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598445; x=1793203245;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5W0wO5ApY1ruwZkrfuprI8pGOadn8UJEcw8Q72azQTg=;
 b=oOIHhtVjUJ66UpXCF7HOrTyXDX5/zeOkZmrTNIOwcLfpJsnIc9Bc0YyGGa61/mRh7J
 i2E1MIC6I5ai25irDT0Ioj8v6jaiFyv9ixzH/MEKo81xYfnnjAuIc9cSui2c+X6USKrp
 rI5JQ/Fun0QnUnLoZpuT43+2b50UdvWMqCicVOLr2a+dQ3e+ntF/Z5sOAkN+ZpgQnjrY
 xLrnatytwuSTOeAi8Puh0lfpm/g86kM7yNhfV3tT5azll5Ve7dd1MMpujvNOtvkdtT5B
 6naZlDj0ykcUlmKFDLZIxuWOWX6EPUJ/S7KABW0x7iUDbQMprXBU2aWQ1OpZNkbcCeTm
 v7rg==
X-Forwarded-Encrypted: i=1;
 AKwUvByxq4tQOrl0+z3azerMdvhB5OKXi8+KjOAmjKI0y6Q4k5gtLQqoTSw+HO3HYerI/zx5j8TyWezyN9Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK3JiuP/hcdQB0Q5nwA9DJWi/AZZElRk45EXqPsQ8t9cJTH9pvS
 NYPG8p47bkSghD/eYO8t0qR4L/4SbGWQQKqpSLbJ+GC1O0V6hNMXiAv5ECaDJ1Zitj3RQTEFluA
 ZAy8c4zQu
X-Gm-Gg: AYBFou3F8QJqZwWB8rl7+pzyQedt55yXaurZsaSK4EH5b8cu8hzPs0r1g6FOF20jxXT
 7JV93XV2IAc+wqN6FGvzFHqk68qt7xAwTE7S7JDnNO6QRCU+ji5r2PMGOvTsmcxYc0kQ4AZDIPZ
 JfNYiN6hIWuQQxNfBpG1xJQlgJksl2BRuYFNu4kArNQKgqaWuMCTofhnbDVdYJuVmgQlpn9h2KX
 pmIOJk1ZMcBxJigw+QOEbbEAatQ/lGjNMeSYpShgapgNwE3gxigtfPAFfwzUZbGDhxyrBbaaDs7
 GFLJui8pLdZ2G2T0/9nUy8qH2d6PRFyHARZo1O9e7+cVR2iTyfjA1V2A25xBEnS/mQxTjzP+CXl
 dyvKp3CWpQYAgCIqgjKgepvL8hUN+q1OMymP7rgmsKacSpjZZST4ArJSbKrI42XZ6WCTD1hcCC2
 FYE6cv70wh0L8Ezzt+IV3iv0XmJLwXvhalM/B98/GouP4kEUJXLS2VzpnssZ1QwgM0U8YXDcQ/Y
 HhF4bF4DcQYhKISYQXuj47uZhe6LNLbWXVJzXQjJ4OTr+fcIhv2OccCsyS1NfUCue5+bXGyuDBr
 a22BSRlp3VSahejLIrVEX7Ltt50T9+Rf+LyY
X-Received: by 2002:a17:907:968e:b0:c42:102f:15e8 with SMTP id
 a640c23a62f3a-c4679661deemr209139366b.14.1792598445120; 
 Wed, 21 Oct 2026 09:00:45 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com.
 [209.85.208.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c468a55cc99sm14917066b.37.2026.10.21.09.00.38
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 09:00:42 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6afac79b3a3so11927a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:00:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwX6z6p3U005uEaO2LXEYzvc5QzHi6/OjAFpcctTywL0K5Vq3ZxL1kTkCZ7LpkZWPHNp3Dz6s8R7Sw=@lists.freedesktop.org
X-Received: by 2002:a05:6402:c181:b0:6b4:124b:da30 with SMTP id
 4fb4d7f45d1cf-6b4124bda8emr34019a12.12.1792598437038; Wed, 21 Oct 2026
 09:00:37 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1792392288.git.kmehltretter@gmail.com>
 <f2258d73562e0ebf2efd793b646706ba0dacb2c7.1792392288.git.kmehltretter@gmail.com>
In-Reply-To: <f2258d73562e0ebf2efd793b646706ba0dacb2c7.1792392288.git.kmehltretter@gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 22 Oct 2026 01:00:19 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CDPG4RxUwPDbPUJSCxVZE1cEeYEZvQ25Sy4CuJR861Yg@mail.gmail.com>
X-Gm-Features: AclHuK9e58N_Im_zhkbxzzSKI3JdeU-CBpj5GNDyWEt5aL7nKqE3jFXgtXMdHNo
Message-ID: <CAAFQd5CDPG4RxUwPDbPUJSCxVZE1cEeYEZvQ25Sy4CuJR861Yg@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: videobuf2: finish prepared buffers in
 VIDIOC_REMOVE_BUFS
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: linux-media@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Tomasz Stanislawski <t.stanislaws@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Karl,

On Mon, Oct 19, 2026 at 4:14=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> VIDIOC_PREPARE_BUF leaves a buffer DEQUEUED after calling buf_prepare()
> and the prepare() memory operation. VIDIOC_REMOVE_BUFS accepts that state
> but frees the buffer without calling the matching finish operations.
>
> With VIDEO_ADV_DEBUG, vivid reports:
>
>   unbalanced counters for queue 000000009fa716f8, buffer 0:
>        buf_prepare: 1 buf_finish: 0
>        prepare: 1 finish: 0
>
> Finish prepared buffers before freeing them, as queue cancellation does.
>
> Fixes: a3293a85381e ("media: v4l2: Add REMOVE_BUFS ioctl")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Thanks for the patch. Please take a look at my comments inline.

>
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/me=
dia/common/videobuf2/videobuf2-core.c
> index b0a6084f17573..460eaf4e82f78 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -1746,6 +1746,19 @@ int vb2_core_remove_bufs(struct vb2_queue *q, unsi=
gned int start, unsigned int c
>                         goto unlock;
>                 }
>         }
> +
> +       /* A buffer can be prepared without being queued. Finish it first=
. */
> +       for (i =3D start; i < start + count; i++) {
> +               struct vb2_buffer *vb =3D vb2_get_buffer(q, i);
> +
> +               if (!vb->prepared)
> +                       continue;
> +
> +               __vb2_buf_mem_finish(vb);
> +               call_void_vb_qop(vb, buf_finish, vb);
> +               vb->prepared =3D 0;
> +       }
> +

__vb2_queue_cancel() does much more than that, especially all the
media request handling. In addition, this open coded handling just
causes code duplication.

Would it make more sense to refactor the relevant part of the buffer
cancelation loop from __vb2_queue_cancel() into a helper function and
call it here instead?

Best,
Tomasz

>         __vb2_queue_free(q, start, count);
>         dprintk(q, 2, "%u buffers removed\n", count);
>
> --
> 2.47.3
>
