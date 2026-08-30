Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C92EC624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84AAA10E698;
	Mon, 31 Aug 2026 07:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p+q8I3np";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDEEB10E12E
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 06:25:44 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-66e3d262d43so625144d50.2
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 23:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788071143; cv=none;
 d=google.com; s=arc-20260327;
 b=tB8rRN/qm+AcU5mJ/yIYy6OkYiYQHEje1MGGC4u8iZrkzRNUZq5z5ReS62PAi9aJ2m
 EXNvX+RPKxRGAVrP6F9Usylz/HcnYIYXEMvVkr+HVURtimp+fD6spLm9wf8t9AIvhd4J
 kiMJmQhqygCoM9fFqZmNz9r211wVoYehHNPk/7sfcWaTpWnALeoePAt3aLBPvWpJ8a8g
 qzMS92wxI8/80tUMKr2DtBB//ZSV2zfEAZ7HQEr1cUtqwnobW2febTYXI0SA/G8HovCu
 fFjaoEo+USSSbrtQsHdRWUW+AJiIAwmXolzSyITWRpjuT2RM2HHuta4uYn/c2g6rYnh2
 Elkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ie2zZl8YsHAeQXHgNP1pjeAs7NQ+FFglXIo7DLINxR8=;
 fh=O7jv6rswyu33/tqy8d6jNjs5kLsjYHCKKyyxC3uDBwk=;
 b=Y8JRuJ71P4bYjYFKoo4ykhmF5J5OKytotN7h02uV0YpdVQklY+o04vhHb7ExbiibLY
 PQoBpmZ7EGpPy8EXcJsd+s18SYri6fD5/txaTkIQ0kANF8B8BRBUjD6FTM7QAbASiq8W
 CMxP9ijdBXlOccGSZvA2QRXCilBtFsccDUmIl8PFmcsiJwEdEQi5oxR/vYh3I/n9LNWz
 xMp58Om94UoDa+T+QCHPJuAasRXavK8y3IsbXGDYpWW+dt44j+rCf6fk5Z/fxdVa7zSQ
 jPfTBEkEVOmAd6XWII1kwGkEzm0EVyKxOVPOX6RRNLYUwIQh+xunNX8Kwni6f2bbuZYl
 OWmA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788071143; x=1788675943; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ie2zZl8YsHAeQXHgNP1pjeAs7NQ+FFglXIo7DLINxR8=;
 b=p+q8I3npwgst6WDLaG+F61f29ZJqMZvB7kK+5FZdOYgYyPAGqz7PmoRlL7MHoCGZLS
 +aLfsAMYLQDcCDX+y4hhMMfgKfA5wV/GyHPaf7fF42M7/IM74p0y74FlUtoVIM1e0M1j
 Iy5thH/MAWSov9Ejei1+jUq2yYgf14q0L5fbd3TB3u0zJpmoMglPN1z67cTa62SVlhpI
 On11WwKv1prqU2FDE4olz4ESByfQtuQ2NucIMz9GXjKxScwt2OyqUbuRdHbXrLzPkd7J
 bGDM6IMJlFA14iYb3DJRCgzOIeKKxXJuZPQ+D+xVY2pc7cRoInF/ItSK5p+GxAbg2wbz
 LG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788071143; x=1788675943;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ie2zZl8YsHAeQXHgNP1pjeAs7NQ+FFglXIo7DLINxR8=;
 b=fl33NuROUiHRsruWdFapR7v1TXidgRIZutoAzn+KjfnYISJSCGOh9q+/7G65XQD4kR
 CnxzsLF75pU42MCZ1AzsBBFrJauj+JGa44cIplkR5zBCPTpw+TENDDhD/g4ghtm1TkDm
 RMAq66c2u4eYOdWzUvvovabgkxz+69T8fbQssjCn8XEHf3UdMtCR5dfCvOiejmPwlFDR
 HapkeJqFBxm6QKsx3RGU7E2gYWGfNr6TXhaLWKNb0DEBhLv6myjvPbH2FByQhD4GCcAD
 9AAGibO4vC2xricKCO2oDT6BV42lypRDFuJuLNQemn4W1QM0vifzy/JlDSaG1yAgiJzV
 yufg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWv4pto/+EGqTb4ZA9uA7JBh1yHJ8g7XXa4lwEPKgx3Nx8BFSxz9/0KJrXq1pLN48QqEoIlTJYXbU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nPke87HEtKeap+YNUUyOt2i31edNgy2bbpXlSG/2XtvaTSaDNi
 /Xk2MfHK1iF6bCE495eInF8ogeCR6n3yxCw0L3fUoCpECa9XCAUtH2kY81XabkIF+3g4SaxYdKd
 Cn11x3+Af2hJCBErq0bEDVW9f481Ukac=
X-Gm-Gg: AYBFou1oHaL5x/3JjWQWwFBoA5yvJpkGQwNCf1FAaqug8klQ3qAY6yygRMOAonOap1Z
 WAU7rOmnj37bzvFyVkRsaCfnIIJxSXYBuUFCqSs39IDILezAlDxcacqh34dA/wwFUvlo6ELVTHl
 OAosCv82oBUO1mzvReiS3d40Vqo7PqGc846Oc8B+pDr5PqYV4RhaxciecBOTC8RCXIxf3dIAoNc
 kpQ6H2uveNtBaDRD0nXaq/Bg69jtA8sJAjSNbS3NjZOiJof0ssAjY86RnZMrYLKu9obgotUYCYN
 DreTsKHMiiWoFB1E7/n3D5qXz//rTxWWXSEwNOa5mKdwe6bV1p2sO4PjxAw0aluLijYaCuZHhH/
 fqYprmZ/MJYM1ZA1WOD9M+eNPjuObzGCvxQ==
X-Received: by 2002:a05:690e:480b:b0:66e:61be:b280 with SMTP id
 956f58d0204a3-66e61beb351mr919322d50.48.1788071143285; Sat, 29 Aug 2026
 23:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260813064902.367504-1-kartikey406@gmail.com>
In-Reply-To: <20260813064902.367504-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 30 Aug 2026 11:55:31 +0530
X-Gm-Features: AcwNN1Uz1IASuABwBGrNzT8vqscd8g3KsyTVjcnjYQteHxWUUv-5lbfRLHAaf4c
Message-ID: <CADhLXY4YXGWUi8JcfdYMJ4HhKMKS2RLg2WvnZnku_XK45m4-fQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915: Guard against NULL driver_data in
 i915_pci_probe()
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com, 
 simona@ffwll.ch, krzysztof.karas@intel.com
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

On Thu, Aug 13, 2026 at 12:19=E2=80=AFPM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> pci_match_device() can return the dummy pci_device_id_any entry
> when a device is force-bound via sysfs driver_override, in which
> case ->driver_data is unset (NULL). i915_pci_probe() casts it to
> struct intel_device_info * unconditionally and dereferences
> intel_info->require_force_probe, causing a NULL-ptr-deref.
>
> Reported-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Ddb96c5ff032f4292a8dc
> Tested-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v2: Drop Fixes tag, this isn't a regression from a single commit -
>     the unconditional dereference of ->driver_data has always assumed
>     it points into a MODULE_DEVICE_TABLE()-backed entry, an assumption
>     broken by the generic driver_override fallback path, not by any
>     i915-specific change. Add Cc: stable instead. (Krzysztof, Jani)
> ---
>  drivers/gpu/drm/i915/i915_pci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_=
pci.c
> index 82415af47d54..2f03f95945f1 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -958,6 +958,9 @@ static int i915_pci_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>                 (struct intel_device_info *) ent->driver_data;
>         int err;
>
> +       if (!intel_info)
> +               return -ENODEV;
> +
>         if (intel_info->require_force_probe && !id_forced(pdev->device)) =
{
>                 dev_info(&pdev->dev,
>                          "Your graphics device %04x is not properly suppo=
rted by i915 in this\n"
> --
> 2.43.0
>

Gente Reminder. Let me know the status of this patch .

Thanks

Deepanshu
