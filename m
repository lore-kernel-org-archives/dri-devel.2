Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5828606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Czg23b32
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B994810E3FE;
	Sun, 22 Nov 2026 07:55:27 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC4D10E3FE
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:55:21 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-8b4d5e645d1so13993377b3.1
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 23:55:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795334120; cv=none;
 d=google.com; s=arc-20260327;
 b=qMZaVpizzBYJOhMa1tHnkj/B2A462zvSzLu7P8UzdxKjZKaqqCraTYywc+AUj3U0wg
 6ShX/p6e2firYQ8M3kJc0JfBxxIx8piSfcUaA+pjew8rmRGP4G+OX5U/qTWa6uEjhQSF
 +YV8no3fjYASBR4sU5O9WA7mpeb80Ch85x5C2+QGix1EAjX9kG80otggWl5hHps6LLfZ
 lPI3En2ZFWx58VX9314zu/+NKG6I1Y1oNq1SOboaDdfe+7KvqxBNOTY6HyjcKghKdjRq
 R/89FnDa/CfY0C/V7I55l4JeTJ5rli+YFiBW2K/khJzhNLXljKlpDCoub89l2PTj0Hw5
 Yb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pdeshsNcFSymLEnyYgGQ3YuhLZb8c16ueubDFBPinGo=;
 fh=pNUeXJ9FZQY3f/pDoxyxsQEwc4McuSc/v/xx9SnyuN8=;
 b=HBlCuwqIbVI2ulEyAvM/T3XKWmFQfYW3yUPN5/EeZ0mCkOD9rmgBrvMoPi33mvdCNw
 x7nzWrLJNMejYzDl8xLzob+j07t7Cz/+as72U2TkVGU56aRI1vlpB0PWDPz3RvaxK1eW
 tgKbTSrq0rF8YJ/sTCgQbPSrw7U2JXDXnC52ARagEXcu4JEf7leJUAQQu8VGP3TxvjDa
 Zgpf0+o/qDQ+e4hXgsDBNHIcU2XsJcKnWp8JtAlqPRCjJDr+GYqPqeNn4IHLFiS0kTs3
 K6RPDXV2rgMtSDNf3bk1gPTZSRmYICk5CXLuxym/x6jwosbpmH+57uaJsgsuQAonFexr
 RZXw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795334120; x=1795938920; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pdeshsNcFSymLEnyYgGQ3YuhLZb8c16ueubDFBPinGo=;
 b=Czg23b32TNngOD2q7eAWDnQby76y3Rh3GFw6v5+HFc7x9zJIZhr6wy7pbjCbUcZ9cp
 1bw4c2f0prMMXDZAsH9S9p17nyDHvrLcU5/aBlxWxvA52H0d7xNKJpreIevZuKX0+vBG
 20780ieRCTux0PedYcusXzg+3jjb3zcu7uLgNnkTwX/q0F1XMa5vjPBJsf8ZeJzFW7/z
 mvGKTT1cKaFkIKDUyOq4MLPtxVdxxL5F0ZFtIDTa9QD83Hfz93AWTICIIahLE3EZh8AU
 HNUhFoxBOUc7l7YsgjLW/n4YXhBm0IzZiq/ld1BsncDTbg/XdReYzTV+qXSWU4/wqy4V
 tV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795334120; x=1795938920;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pdeshsNcFSymLEnyYgGQ3YuhLZb8c16ueubDFBPinGo=;
 b=Ivo7RRM6i7T5uzluDhsbK74sG/lMty0qDanlgBRzhHLdr5rXO2pKgUUuO1IFTOrh6I
 teyr3yi31dH0rDFrWGNdeeMLeGpbhfUSuYEFjN9SzRwCkj889gxmoj8+ZmNKAZA+1Gfc
 JyJeznEmmT7kzXR/wQ51WInNHVjK0RuG7zlrobvUt9GyPkWSfIo4yRXcvZCqu3Slbtbf
 bD2rw10W3qgvtwKKeMMUQLMl5btKuD6ohp5PABvmDdIxcnvrxGaUCQPAM6khILqVUZw9
 H+oXnDAYMp8QV6ZobLygk4SwwhS6Z44oIvCwvGlqfQAzbOL7+Fc1QACsoEMWBvSbNUtP
 Zd7A==
X-Forwarded-Encrypted: i=1;
 AL+hErFSfPJ1j4xWK1Jeott5u7NKjwtDQhY5UB2ZpQhn8V4E9NDQzRM0R3OqZnyiUXjlK7XbB4I9Bhmk24A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8oYGiZiKD49HixccRJ2Iu2nKVqDPIvbmAibjUAwI+mxfrgLVxd
 c9H0Je4nbzEk6EBmZV9a945FVNtYhiJN6bsZgRedTfbsKEB3iKeH0ntPtTnKK5OxgR2ifLLEOYo
 BY2EKcorV2cng8o3tyNTnfzMFTAwxKkc=
X-Gm-Gg: AZFdTZfWU8jNjrsLS0Ymyyn86YwYLQTRm8hJesbzVp9ZyQAQyd9Y6JfpH+C7mJzsJm0
 NutiPDWdetcBzu28tkJywvBMr7sAZQvbhlu6ueXQkX5gudEunODjeNZqPTCvILW65VwzKx5Nui1
 o7vU9615G8pPW9QMoK6fGtJaKE+zWXbmKlZxJnToSe2/TEhe6FeOFh6/ENfDHKj91FbNbqNrIaA
 ZaaqmZlqi7scPVsV3CatAy5XTBW/0aw2oXdNxVxHCy9i7nOaCjmgtPiP72wndksfFZv6Mq3fu81
 nqI3VfUr3KKn27kR6SdZlvWrZjEfbVU3UumCvoeZ9YZLv+tvRwuQVeu3HnRey/FI3EGnI3jv+bX
 9LBaJjrW8x6NjAP1KEbhVwV+7CikJaTiT3x0otbI=
X-Received: by 2002:a05:690c:b01:b0:8b4:e57d:9421 with SMTP id
 00721157ae682-8b52031b209mr33010807b3.7.1795334120430; Sat, 21 Nov 2026
 23:55:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-pvr-gem-drop-zeroing-v1-1-2dc725857053@baylibre.com>
In-Reply-To: <20261111-pvr-gem-drop-zeroing-v1-1-2dc725857053@baylibre.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 22 Nov 2026 16:55:07 +0900
X-Gm-Features: Aa3M54q1h5hYCprIEwOOOX9ZVBe-G655I8fGo68Sbafor7iQqw7YnSzMQ2bEnTE
Message-ID: <CAKbEznssOrO84z_msOZ0tYjVYkaQ8P+f8uma3PhOF6+zp32Hvw@mail.gmail.com>
Subject: Re: [PATCH] drm/imagination: drop redundant zeroing of new GEM objects
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org
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

Hi Guillaume,

On Wed, Nov 11, 2026 at 6:43=E2=80=AFPM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> pvr_gem_object_create() clears every new object through a CPU mapping
> so that userspace never sees data left by a previous owner of the
> pages [1]. shmem already guarantees that: it clears each page it
> allocates, and the dma_sync_sgtable_for_device() call that follows
> makes those zeroes visible to the GPU. The second pass, write-combined
> on non-coherent devices, only adds latency.

I'm not very familiar with shmem, so I'd like to ask: is this zeroing
something shmem guarantees, or just a current implementation detail?

Since the driver would now rely on it, could you spell out in the
commit message where the zeroing happens and why it can be relied on?

--=20
Thanks,
Gyeyoung
