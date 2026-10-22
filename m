Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B043606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XMKYwysr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E6810E45A;
	Thu, 22 Oct 2026 17:58:20 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBF9610E45A
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 17:58:14 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-150ef97e790so961c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 10:58:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792691894; cv=none;
 d=google.com; s=arc-20260327;
 b=pu2tBIp4M/+4OHgbbSlCbTP9dgudI4+E/Q/9padwFJR+t8D00H045erzlPaW3sou50
 CCub2ol0BGG6AyMCdR5CQuS+DC+zBN46xq83aXKOIFNyvZ7u9xI5EX8MHCpvWphybiI3
 7p0OvpLSc+O2gY60B04FPBOjWGMwQ2J3FZeIRJWZNC/hmC4DfsXH76MFWiF/W/Nj31f9
 sT5ShlAK72cVf/Gsgeq3K9S9q4BJHVh8goiWBzsNGwSJzYTDGiFGgqHCMTK/QDey+2+M
 1dPKPkvxPboCzLFNBPfvNOWKUlo/0U2bYTxElpCWbe3IJXi6IvhSIXF09XYfjWmGxkUW
 W6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gOxyJqweGrhnvnodtSAXe9yahnUU1PnlCf3PPg5Ekys=;
 fh=akIR/G5V39dhkxt3pShWtq1I+TxFvT/QUoEyvC1YEYA=;
 b=PuhGTh1Zgyr/c8+ufCDp/lNEdqLDoJs+XLIwx/8gyON1FHi2T7F4z8nx9uKAV7ud5J
 hgMCudPAmgmvIZ0aoE2QLRSUDBP/U8ZeRXoe0L7qIe6fllMl5jHEDcwLznicBp6xKZRf
 T0iD0X30C1K4a9anD8evEnplrv/2NEgje1TF5zWiwmBqJPoJIJKKGjtdconAlWNjQTM7
 943Fz5dEmocNYj6ateX4rWdmJ77N/5FH9WLp/nRXVs3tzeyTHezcFc7EdiX2eG30/Pcy
 HbdVAlVvFi+19MDX8rhMmJ7kXus94BH4CqXqfsP72v+Q0oeQAE8uhvKLh3NuikdS8JOU
 vFhw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792691894; x=1793296694;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gOxyJqweGrhnvnodtSAXe9yahnUU1PnlCf3PPg5Ekys=;
 b=XMKYwysrSFCvXIY6MlX40efWWNvk3KrauSewFU9+hf8GV8Pw0HCYh+RXKsHOhj5E4T
 P3DOvjI7QMLj5pyx7iPbPCMsymwAB8WrXcjhbSr5c7qzo01Hq9BntQxXR112oahiZqhx
 YZkln5ubao4esv2AAgMTKaW3XgSHl2j+cTFph8iI4zBasNaE/r4PGFxBbtYKd7MyYkNq
 kQzF8RrrpzqscvZ1DmXXCSxxZska7ZpWAmfpiLybsfUJehK4JWmgfvxP4oZY7t6sKgKM
 Af8kTPoxNp7/F/d8xCr9rU1rEBGmPBcmX8HovY1TUB8aRKQtKI5f4RR0MAa2HYcFIvhO
 29ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792691894; x=1793296694;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gOxyJqweGrhnvnodtSAXe9yahnUU1PnlCf3PPg5Ekys=;
 b=tGj87qZKcsM9s9smlDYv2pZ/2kEqVpZmhtzBzJfaY89oYzv6WzuLLwWf3Flct2f1JL
 ESShsmV5gXQXXThhVMXNyOjt63j+w2X9B3MU/M2Z/j5hGlr/Hhkiagvim73Hke/4yz7Y
 g6p+as36G0Mg7ZRJsP3WZqihDb4LteGg33OOo1VmtJMhbvQw8H/sMWw2VcAGZ5N/epAK
 fYT1mO1saKODbjlJ6qu64mEnnio8WFzMnnRhvFICgnDVD3XA+3IV4nPY2jfeqyFPTs2y
 gXVDvVQJFB6DST63M3Os7wlveDRHOtE8StDDY5DJTucMsWxqmNgCmdxknCakCz1w/7f2
 kzXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByJXJePZd2jh2ePi1mfijnUHJnHyBBywjqIbXlur+N7KX96HPPvsTjmJbFJ18g7+i9eoOXsIN+2IPA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLV+V9EM6VqPAosoIReCucnjBObHhbKbdzRF0mOnicPsrCcGgQI
 FDsDpU8CmqqA1pDNjX2x6uxxRTLbnoVH8RsLRbSShMeC+rUiliBu048HvxbhT5FDH2NxcWx9Vdz
 OPTcM5AM0h4DA8MA2fZNaXIxkcHQntuuG/f3RKrn+wzV4qWjwojnTAo87uA==
X-Gm-Gg: AYBFou1lOcMdEW0vjdvb4dcSpzYQv3/hSVAjXvM+LqIh3ewwMx2+VP4cEsw0Tx1N14q
 162BswZgfblrxXv7RWnqhfTDGGrhbjfJyo3VqWmcIa4LsRcblo0knOEwwFMcOWv7NPR8sp6Gc+T
 hefGKuMu/+aY1kXA+OVWH/iEFRtcyxT5BeB4ywUOUjGMqnGar3SsrpJShzbqwqpMull0F/r/ppY
 YdKJD+Uvc/WucBEjJVyvucf35ApoxzpvZIMwEsoA4efmdQaqkET3MmXylPSm9sqBoRcd6anQhwR
 mDFJthbVPKcf9caY5J1472tCka1DEhe/Bsyii93ivSjU4iatQ/IvmDvG85148N7+uGW1a1cejc6
 Kjl0w4I9jS91rpFbezqQxoFlkjIb7pY3jBuzOD0ZRp/SSs1C05WieuvOKAntIuxU3zpLnoKh4tI
 DkMqKt/NQqhLPGojLpeZrCOUJOEGLMozfaZXRNGyTUK0ndUugTe9DI
X-Received: by 2002:a05:701b:2085:10b0:192:ce56:4982 with SMTP id
 a92af1059eb24-195b384f21cmr17350c88.1.1792691893149; Thu, 22 Oct 2026
 10:58:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261006154913.2689067-2-val@invisiblethingslab.com>
 <8b0fbe1a-1410-42d7-8031-611795ae39d9@collabora.com>
 <4d86ec37-ce27-4556-966e-4b4e80ec0718@invisiblethingslab.com>
 <f717bc84-57f4-4001-a15b-fcdca67bb9b4@collabora.com>
 <6c0f26af-e363-46b8-b3b9-8d3910297dc0@collabora.com>
In-Reply-To: <6c0f26af-e363-46b8-b3b9-8d3910297dc0@collabora.com>
From: Yiwei Zhang <zzyiwei@google.com>
Date: Thu, 22 Oct 2026 10:58:01 -0700
X-Gm-Features: AclHuK8zrBSyPW0ecQ4Wi5vbzBHjWnhi_xIgMiJLjDz9C3zXcHZS3t6jUqqUQ44
Message-ID: <CAKT=dDmEf3McX50KYxmLDb-oeuYWMBSnkcGGSEfi_PO4pD6qjA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: do not enforce blob_alignment in
 cross-domain contexts
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Val Packett <val@invisiblethingslab.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, Sergio Lopez <slp@redhat.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, 
 Ryan Neph <ryanneph@chromium.org>, dri-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-28.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14, 2026 at 2:02=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 10/10/26 22:40, Dmitry Osipenko wrote:
> > On 10/8/26 23:59, Val Packett wrote:
> >>
> >> On 10/8/26 4:33 AM, Dmitry Osipenko wrote:
> >>> On 10/6/26 18:42, Val Packett wrote:
> >>>> VIRTIO_GPU_F_BLOB_ALIGNMENT is designed for GPU rendering context ty=
pes,
> >>>> however VIRTIO_GPU_CAPSET_CROSS_DOMAIN is not one of those. Resource=
s
> >>>> created under cross-domain contexts are arbitrary shared system memo=
ry
> >>>> files, which includes unusual things like Wayland keymaps received
> >>>> from the host compositor. Do not enforce alignment requirements ther=
e.
> >>>>
> >>>> Fixes: 47248e0d8264 ("drm/virtio: honor blob_alignment requirements"=
)
> >>>> Signed-off-by: Val Packett <val@invisiblethingslab.com>
> >>>> ---
> >>>>
> >>>> v2: also check has_virgl_3d to prevent dereferencing NULL vfpriv
> >>>> v1: https://lore.kernel.org/all/20261006004044.2242154-1-
> >>>> val@invisiblethingslab.com/
> >>>>
> >>>> ~val
> >>>>
> >>>> ---
> >>>>   drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 +++-
> >>>>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/
> >>>> drm/virtio/virtgpu_ioctl.c
> >>>> index 3ddd5481d6bc..4d5ae062834d 100644
> >>>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> >>>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> >>>> @@ -551,7 +551,9 @@ static int verify_blob(struct virtio_gpu_device
> >>>> *vgdev,
> >>>>       params->blob_flags =3D rc_blob->blob_flags;
> >>>>       params->blob_hints =3D rc_blob->blob_hints;
> >>>>   -    if (vgdev->has_blob_alignment &&
> >>>> +    if (vgdev->has_blob_alignment && vgdev->has_virgl_3d &&
> >>>> +        (vfpriv->context_init &
> >>>> VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) !=3D
> >>>> +        VIRTIO_GPU_CAPSET_CROSS_DOMAIN &&
> >>>>           !IS_ALIGNED(params->size, vgdev->blob_alignment))
> >>>>           return -EINVAL;
> >>>>
> >>> What userspace has this problem and why it re-purposes virtio-gpu to =
act
> >>> as udmabuf for arbitrary data that never reaches host?
> >>
> >> Sorry, what do you mean by that?
> >>
> >> This is not related to data that "never reaches host" at all! The erro=
r
> >> I referred to in the patch message literally says "received *from* the
> >> host"=E2=80=A6??
> >>
> >> Guest userspace is any of the cross-domain proxies:
> >>
> >> * https://codeberg.org/drakulix/wl-cross-domain-proxy
> >> * https://github.com/talex5/wayland-proxy-virtwl
> >> * https://github.com/google/sommelier-rs (or old C++ version)
> >>
> >> VIRTIO_GPU_CAPSET_CROSS_DOMAIN "repurposes virtio-gpu" to act as a
> >> cross-VM UNIX socket transport that supports fd passing. By referring =
to
> >> virtio-gpu resources in the send command the guest can make the device
> >> send the resources' corresponding host fds to the host Wayland
> >> compositor. It can refer to resources from other contexts, in order to
> >> present drm/venus/etc rendered buffers on Wayland surfaces. (i.e. the
> >> host would send the actual dma-buf from virglrenderer) But the resourc=
es
> >> created on the cross-domain context itself are system memory buffers,
> >> generally used for software rendering and miscellaneous Wayland "stuff=
"
> >> like keymaps which are sent *from* the host, and exposed to Wayland
> >> clients in the guest. Socket receive handling in rutabaga-gfx stores
> >> incoming fds and returns their IDs to the guest, then the guest does a
> >> CREATE_BLOB with matching blob_id, which creates a virtio-gpu resource
> >> from the incoming buffer, so the guest can just MAP_BLOB it. These are
> >> the blobs that are not aligned to anything because they're just
> >> arbitrary memfds on the host.
> >
> > RE "These are the blobs that are not aligned to anything because they'r=
e
> > just arbitrary memfds on the host." I'll appreciate confirmation from
> > people more familiar with Sommelier internals like Gurchetan, Yiwei or =
Ryan.

Technically there's no need to enforce alignment on keymaps backed by
memfds, meanwhile those consumed by GPU have the proper alignment told
by CROSS_DOMAIN_CMD_GET_IMAGE_REQUIREMENTS (unless it fails to do the
right thing).

> >
> > In a case it is a correct claim, might be better to remove the
> > blob_alignment check entirely and let blob sharing fail naturally if
> > alignment is wrong.
> >
>
> Reproduced the bug with Sommelier.
>
> Driver always implicitly rounds up BO size up to PAGE_SIZE for both
> guest and host blobs [1][2], hence need to retain this old behavior to
> fix the problem properly.
>
> Please send v2
>
> [1]
> https://elixir.bootlin.com/linux/v7.2.10/source/drivers/gpu/drm/virtio/vi=
rtgpu_object.c#L217
> [2]
> https://elixir.bootlin.com/linux/v7.2.10/source/drivers/gpu/drm/virtio/vi=
rtgpu_vram.c#L210
>
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -539,9 +539,15 @@ static int verify_blob(struct virtio_gpu_device *vgd=
ev,
>         params->blob_flags =3D rc_blob->blob_flags;
>         params->blob_hints =3D rc_blob->blob_hints;
>
> -       if (vgdev->has_blob_alignment &&
> -           !IS_ALIGNED(params->size, vgdev->blob_alignment))
> -               return -EINVAL;
> +       /*
> +        * Blob sizes always implicitly rounded up to PAGE_SIZE by the
> +        * driver, userspace may be unaware of the host's alignment.
> +        * Round up to the larger of the host and guest page sizes.
> +        */
> +       if (vgdev->has_blob_alignment)
> +               params->size =3D ALIGN(params->size,
> +                                    max_t(u32, vgdev->blob_alignment,
> PAGE_SIZE));
>
>         return 0;
>  }
>
>
>
> --
> Best regards,
> Dmitry

I like Dmitry's latest proposal much better. Keeping the alignment
agnostic to the guest userspace is more seamless, which also covers
the implicit 4k alignment case without forcing userspace to adapt.

Best,
Yiwei
