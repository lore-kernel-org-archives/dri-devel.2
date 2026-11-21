Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33854606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ozq81Mhc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E77410E19E;
	Sat, 21 Nov 2026 09:53:14 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A0010E19E
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 09:53:08 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-8b4d543b6b6so9817037b3.3
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 01:53:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795254787; cv=none;
 d=google.com; s=arc-20260327;
 b=L134fNVuUrjzAa5CQWxqDkZCf3BHsg9IVFGb7FzrJPrrncXYLI61kg/1R5Dc8HAn2Z
 l2nd8hswjGXq731eib56YnTztuTcgx/sscZ1jgCurOP2VcNEsLwRk7JgIsaz1pdpcUfy
 4cUhMOj5J2dB7VEAt5HZWXfJv+E5QMM56azKslsVj6n7infB0s+sfm6JHqU6YQO09qTG
 Sby5KTBaFs+jK5t/jyqzqCXt/CicQ3z/1XOPJnoUPs4pYYeJsbWkUz5ipHiyV54iW+9q
 6MnD7hhoWtlpnk71uPuMo07g1XurWCJ4ecBR+zFDDLOAk3exkdvSJ5jWAG2ERyNS2Ipu
 sbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zENLsrjxXzbyMbN8YT2IRoZaTX6XrURmTnkpOGqlJsA=;
 fh=bvt0Bq2se0yQBSjLXUipKH+3fOjxSndVK7HpDwACxno=;
 b=AJEhSqF0dynUmIW9rFVE1D55zzgWHpKA89EurNO+nFArLos0dYU80ZWywH7iDL8+9g
 7Z4v3gTCHosKM85gk0alGaULSlJ1h+8IOfYOX/dXnpjpe9n/FbeBzQD3VdOiaj8XgS0c
 VT3+l9YenPMWWyfi8GiAY1TCx9b+lWvTvwU6JS7wU0cHnqbGNAIpZSuumpJCj77q6mzx
 ozYJ59EW37hUaf9ZdBHwwRlTi0QH8wbdQQUKiQhXTvIN39mEEWeliRh9W3yAJ3js6sZY
 i54RdC1vUWUqJegN9KFyBaR2npkqc/bQGh3AmMb1b2lowrhUXO5mBLrTfW5W1YOaXJfq
 0png==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795254787; x=1795859587; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zENLsrjxXzbyMbN8YT2IRoZaTX6XrURmTnkpOGqlJsA=;
 b=Ozq81MhcbLWYJUUFo+GdJeVIEM5QDDh0PDc0J02+W7Y5fYHdwYjH/wiZlsr1ULCn9r
 6w4+9wbHizAISDeg8UKuiDSOSZ9SAyjLcnuvzPsnTr35ifx6cOKdf709HyK4JVrEf0yu
 xj9JrfPAuQHrqPVvWlvjuAqc3In2JU16Obs5R0vINo7EJFlAoWKfkgVx6z8FzYLu0l8x
 tQGmmlx0f8IhlxsCuh9fgwbJrM3btkUvl6/hiPzCGdZtiuuECtwfdb2WwAU+01OUnoQU
 4X9LtaHqIzhyXsYXvtoN9whIY/TxvGwVemvpIYkvwzc+u4fkRcj7UurqfyniS1U6MDGf
 AW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795254787; x=1795859587;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zENLsrjxXzbyMbN8YT2IRoZaTX6XrURmTnkpOGqlJsA=;
 b=JWzg0ufS9hl1KnSSFvqBEu+q7hivDh2e/NlXWqw9erQk+E8haVEYGr/4MTb7f72vb7
 MYO0PQ2XCUbzDaOt9+25y2sSCVWYiqLSonXxqWZv0yZogobhuvVA6YuqNvwy4k2P+kRM
 FmIcQf8n0hsjo6GzxfSm0Sjt21NWqvV/TiaK+8D5K/k/imTRae7D1aXa0McKM02cb2xw
 NK5gW9mn1DzU3VNOLsVQ1lu1qQuG1/pR7BZ72QcRm5O06Eh0FEqRJMiqK3q9v/82OU+d
 YO1nfdx460dJ0SP4U78mpDsxWFShw5R2litHPMVFxofHJjc3/5h2RYmWt5Jf0D81URs/
 E6lA==
X-Forwarded-Encrypted: i=1;
 AL+hErFD7aYSiUXG4rdNrEs/3AKB0V4mnuEsk+7dI8ZvMzYrwOl/DX/q2+9J3wiIOhWSz+SMBcyH6CI0kyk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9wl0AtoFsCxFvkGG8fsXXMIKontq+GR1StUk/3GfHtbS112ceS
 2RX54odBTiEa92bDJ9P55JcibCS5w5IaxOgZEcQr2ZjsRz0PFAWoyuV7rOiA6bIj0QF2h0SZAaE
 yjTFP2XxhRaN2cYE5/3S4ZP65JmMTCfo=
X-Gm-Gg: AZFdTZePajZc3+z2n3WaiEWWww4/Ks5ae2Faaa3n47Bq/+W+a+yMMniABekbj/gPWok
 D8q4ArKFbv7UfMfEI+jNCOzHrySVN6RjDXEvTjOmmW9t/WNFeyCxk+vfAoMsVo3ZK5rotWheXW7
 sTe1Fl0M8AVF1k3dxhnY2wHldjvt1uEdkQU9hIe1ljRESjbaP5vXK9Aq3nHkG1zrJVjM0IMdJEe
 S+tRTGGzLQ2u4VxJq+Or7uxS7gJ9Cp1j9BRrerTfATe1K+xn3/k8UrscQ3lA7rYQRFVxLaUGzbm
 vAM82CiTENy/V0GWRkUkQcB2ly0rgWXlWU6ZJ1n+0rYjztVH+baMxa+8kxT51+VP7qsNKGKeUBS
 IzDN53H4+qesBKDR0Zewxs0QWrEtkLwm5nrGvuUg=
X-Received: by 2002:a05:690c:9a8f:b0:8b4:cd96:e2e5 with SMTP id
 00721157ae682-8b52047eb39mr22433217b3.57.1795254787409; Sat, 21 Nov 2026
 01:53:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120141225.789350-1-sidong.yang@furiosa.ai>
In-Reply-To: <20261120141225.789350-1-sidong.yang@furiosa.ai>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sat, 21 Nov 2026 18:52:56 +0900
X-Gm-Features: Aa3M54p2-QsFjV4SsFcebynkN_mXbs5R4b29wWDoqMp8rJ_L5RBNQwxz99F4OLs
Message-ID: <CAKbEznuH4sgiAQvnCxh+DeLcLHfzariiMumo-K9S3=zi7LNYxQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] accel/rocket: Report NPU usage through fdinfo
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, ckoenig.leichtzumerken@gmail.com, 
 Tvrtko Ursulin <tursulin@ursulin.net>, mcanal@igalia.com,
 Heiko Stuebner <heiko@sntech.de>, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sidong,

On Fri, Nov 20, 2026 at 11:12=E2=80=AFPM Sidong Yang <sidong.yang@furiosa.a=
i> wrote:
>
> Report how much of the NPU each client uses through fdinfo. Patch 1
> exports the runtime the scheduler already accounts per entity, and patch
> 2 uses it for rocket's drm-engine-npu key.
>
> v6: Rename the getter to drm_sched_entity_get_runtime_ns() (Ma=C3=ADra
>     Canal). Report rdev->num_cores, the cores that are bound, as the
>     capacity instead of rdev->max_cores, and skip the key once no core
>     is left as a capacity of zero is not allowed (Ma=C3=ADra Canal). Add
>     tags.
> v5: Use the entity runtime from the new drm_sched_entity_get_runtime()
>     instead of a counter in rocket (Tvrtko Ursulin). Reviewed-by tags
>     are not carried as the accounting changed. Based on drm-misc-next.
> v4: Single drm-engine-npu key with drm-engine-capacity-npu, and
>     documentation (Tomeu Vizoso).
> v3: Add a rocket_engine_usage_create() helper (Gyeyoung Baek).
> v2: Size the per-core counters by rdev->max_cores.
>

Posted gputop support for accel devices to IGT, which shows the NPU
usage from drm-engine-npu here:
https://lore.kernel.org/igt-dev/20261121094225.628262-1-gye976@gmail.com/

Tested on RK3588 (Rock 5B+) with rocket and panthor running together.

Tested-by: Gyeyoung Baek <gye976@gmail.com>
Reviewed-by: Gyeyoung Baek <gye976@gmail.com>

--=20
Thanks,
Gyeyoung
