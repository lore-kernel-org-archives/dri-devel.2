Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE43CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B6E10E31F;
	Mon, 18 May 2026 14:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UaarwUzN";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43C7F10E31F
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:23:21 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-12c7288cfb9so86279c88.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779114200; cv=none;
 d=google.com; s=arc-20240605;
 b=gz09GoGSMHGJKvt/PhSfs9tAkSfmS+ZDQYeBl/jq64WjzZAthFGOI2Mg5cUlOX6vKD
 fj7hBpbVB7/BameOVYUB6IEpB6sfeUdEElJgQQeMkt7BrpLMBeIQrkf1zoYLfH43XKH4
 jPOcUnUWHripgFJKbXRuoHaGV8Y6P/hPADsYH/Pc0oRvMvs4KfDXDKqlm3LcV9MY2TgX
 ivUYFklUmR0nw4Q58Tbk972/aFcglnnfKJP9GolmL4EIRxO1sjuDpLIk8RoFWfp5zjQx
 iDAntNjCKn/EraEofRQFWQ/mdGIi4bkF09O2EMrjjwtDxzUw0flWk9BtPOCluWlbpTYp
 7WxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Zwu0oRHpCCQfq/phaRSC6OzwRfYGO4XIvJ0p97gM72o=;
 fh=Saef7Dza2j2iYO9PGyrGvoW6Wghub1tU7efC8v6I9vA=;
 b=Ta//f0H2zjc4wqHiuxw5fhgkKBlNepMZ/7ioTPGCIg65kexMg3mQ44pNyfcJgmog6H
 dWOBJArwpFyKJU478epOMs92igTfCXbznRaVzMXhY5DX7Lgy/Ewq8sSBMdN4HcdT8OcY
 OZ+JxwjlVTtQ1mhXfpwrIv8esfP0Lommrf9z28WYuqzN611OM3xk8//ShzjUixj2+nVn
 Q+DWrGAXPsbfMLt4kAEDbP95n2D3wafWk0kOvRTN8L6rYuepd3t0f5J1uynbVd0VxGQB
 HqsPYsJyIbN9RsknlFkL6YxKSCwsm5XcV4CpNCfNSHRYYhVrJQO6q+UTMRWHf4bT4PHp
 Su/A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779114200; x=1779719000; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zwu0oRHpCCQfq/phaRSC6OzwRfYGO4XIvJ0p97gM72o=;
 b=UaarwUzNh7QB+jH3ilEyprAaOh5qVtbBsuehhbSYo6Dbt0aibPK71dtHg5zrUi6dbx
 ROvG73xxi76OY3nZ4OzRVYnjXPUl/nmY9/+NACA63jT2/QIYl+nuImriZofHw97Kne7H
 XXFLYv6kA37zqjbhWCv2RzXmXD+3oPO0qXxeKsPxnt+PQpnfm4pX52kJ8JyTc6L6uSZK
 JeoZ/6t1djG77nPvuglBmMH6tcaO2INiSXLf2VMjXnGcjk0t6NYuVY8LUy2eVigTUsUO
 H1qr44s7+jbcNcuHc0c55OYsyZjbokvyS3O5jK4LFv909jlFO+j7QiRHN3u0HFcyf5Ba
 wyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114200; x=1779719000;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zwu0oRHpCCQfq/phaRSC6OzwRfYGO4XIvJ0p97gM72o=;
 b=eTUnhnfEH2BWoCkpm+zf7SXYFqFJ3xRz97xA9CmwPupzEqACn3biiV+TWT67sBClsr
 6yc9NPUsFBd0HKSPiKMtbGzVyDrk+vbHj3zgpDn0WuXoVgKgVbR2c/BS7cuomYk40tHP
 uoftR75hHXg27VdOI2x0teSKCcihylUmqqGVMwkVzZ0v33Kpk/ERA5wqBf/bxC6Zux7E
 TZ7WO7iD3xnmtHZT3XkYZzm4gtw5JGI/dJ6OtjeCfakC8LLudpvdk4yzbrpfJ9ZYedch
 Mbda3W7mkTzpwQ+H9E1qeGbkoBia9i6qI8qoLEefUAQOA18xkJ4wK87wQzKfQq+AUGnj
 nx/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nVcQnVxK2b1i31u9E1ih1mF0sXrCtMZnO9fqOrXeOdv4zIJOh4cw3ioKRIKQyOP3rBzQoT6keC18=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYOpNueSQNf8dVt4avIQIpntNAJMtB/iXYXGucyr0NGCtPh7dE
 LxUElBjHba3oQVOWWn2T1JkHIPK45uu7H/fLtmrLRFSSDU0UouegeYGvlc5DnLSpMSNPzHw7ihx
 v4aeg50d65P/FDcwfSvDmtpE1tcYuUr0=
X-Gm-Gg: Acq92OE/+KA7pzLDjZybi9JPH/u9KmBKNhg+H3YORuu9YQmk0K/D2ksABHMJHjL3yNQ
 VtMWLvB52BGaKWs+q8HVg2I5RHHx09FlautGY7wJy3kDS02P/+O5wGjTw/0V3NloG7MhY5Gr1ak
 CyIV4pKJnZnttSAODPt6HcYXO9a4xjoJvLQlfbJt5vkUSFLkgmqxOpaEZ2TM5dXgX427QfLtxPA
 5zP3MbIwDyLcIzm4aau5mXbJYWmmKTHo98bOyv5nrmYuP723NbBrEOZKrJZNxmrJQkxpl0aiSW6
 mw7lbEjAg04dtG7sol4dl3NWJk0ii7ZNv1uK9xfYBt+fa+aGKdtwe5hAwPhNteCcGEWD/A==
X-Received: by 2002:a05:7022:f8a:b0:130:a479:79a8 with SMTP id
 a92af1059eb24-13504525046mr2894588c88.2.1779114200472; Mon, 18 May 2026
 07:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260208000255.4073363-1-n7l8m4@u.northwestern.edu>
In-Reply-To: <20260208000255.4073363-1-n7l8m4@u.northwestern.edu>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 May 2026 10:23:08 -0400
X-Gm-Features: AVHnY4JUU7D5KQcWeSUQF6foLgyk3bLCNxbtKBkEADllVhBA3EuS8e9rBkuwdko
Message-ID: <CADnq5_Nn69ZYnyPrvRdP_jn7XiG-850nC0kSTi=m6ZecMUsXVg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: check num_entries in GEM_OP GET_MAPPING_INFO
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Mon, Feb 9, 2026 at 5:37=E2=80=AFAM Ziyi Guo <n7l8m4@u.northwestern.edu>=
 wrote:
>
> kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNEL) at
> amdgpu_gem.c:1050 uses the user-supplied num_entries directly without
> any upper bounds check. Since num_entries is a __u32 and
> sizeof(drm_amdgpu_gem_vm_entry) is 32 bytes, a large num_entries
> produces an allocation exceeding INT_MAX, triggering
> WARNING in __kvmalloc_node_noprof(), causing a kernel WARNING,
> TAINT_WARN, and panic on CONFIG_PANIC_ON_WARN=3Dy systems.
>
> Add a size bounds check before we invoke the kvzalloc() to
> reject oversized num_entries early with -EINVAL.
>
> Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP ioct=
l")
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 3e38c5db2987..ef5d8bd216b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1047,6 +1047,11 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, vo=
id *data,
>                  * If that number is larger than the size of the array, t=
he ioctl must
>                  * be retried.
>                  */
> +               if (args->num_entries > INT_MAX / sizeof(*vm_entries)) {
> +                       r =3D -EINVAL;
> +                       goto out_exec;
> +               }
> +
>                 vm_entries =3D kvcalloc(args->num_entries, sizeof(*vm_ent=
ries), GFP_KERNEL);
>                 if (!vm_entries)
>                         return -ENOMEM;
> --
> 2.34.1
>
