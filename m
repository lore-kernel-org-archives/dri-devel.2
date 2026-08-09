Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BC7C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7339110E04B;
	Sun,  9 Aug 2026 22:44:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="OZxTofa/";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C088810E04B
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 22:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786315445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UmqVXZ8uahzPyx1266WBfqTL4VwZVxprD5k6ycdBqMA=;
 b=OZxTofa/lxE1Qo0tL19ROJpZCwLSaFC+GJHFIRRnmJs/kMc1hhkLqbOm8k5UZnPPrGE3BE
 s7xnlBEPCZRzCnwtZflAmWztvYO53DS3gazo+V6n46U3YeqamMhAOg06PUhQibzPaAVUmy
 HTjNoJL5nK8ooH7YjiMvyeJMOn7tQ/0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-lukjfrDfP0mX4vh-QdMC8g-1; Sun, 09 Aug 2026 18:44:04 -0400
X-MC-Unique: lukjfrDfP0mX4vh-QdMC8g-1
X-Mimecast-MFC-AGG-ID: lukjfrDfP0mX4vh-QdMC8g_1786315443
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb74d5db64eso1620155a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 15:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786315443; x=1786920243;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UmqVXZ8uahzPyx1266WBfqTL4VwZVxprD5k6ycdBqMA=;
 b=DSni+OE1N+QdQ43QezPio5qXtWXN9orMlqh5fO3ByX/BtWLF+c7lEj8gwrWS83NX8U
 c69uVM3usmZ0OLojNs+kXliYU4j5l9iFek+TJBRNiDYWdI4kAS3bjGnQiNU3R5GNZ2Xs
 Iwkg20bvGLvWkAPzYtlVc4bxnuUJSAwkw4wRRylw0poMWnDtx7nFEeIFrRh1jN4TVKR3
 8hvDb2PMv2Ao6UReaY9aIhS5Q7yw727SCXrRoO13+zIh05ihR1vr0Ys+U0VqchcC9hhW
 nurjH6kNF1oxp4nkAtlg6UdlXectI0m9KgHGO0K7Hk9hyd5EODWuLHnWfdPZZm/KhTFx
 blmg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrud/OdqpcQkMs2JfTrYpRzZRff/UQPQO6U2JabaefcMpOzx0XPq/b38YbnZ4qP3AyxQsWryj6dOLg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7OlWt92rOvbVEe0gefv9Btz0K/T1o7ZumRnZerEClQFANk/GW
 FIfwlXzt4N1yVUoKNtYO44HrJ5BwkUMoUFlHb2in4v76QGh98LOteNk5NO3wxb1bMtC5EYrXVcg
 oltAvgst2QUXYve2B6rj31gbrs4Wbbz79xKl/vv6YdYQ3/bfbPHoab9nG4YOuy+4GS0P4U7PiYC
 nRF7S3Ajv2nPXp5gd5uaWhlTR7BlUW3DIhPVuV+qiQUFYT
X-Gm-Gg: AR+sD13czaJ4yZW6HgZsV/RcUzVtLEHl0I0ogKjSrKiUh94lGButC+GGNphkEfQsT+2
 UabzSM5sBTxNWE+QcVu7pYogtxdZEffIa9DfY/mhKzZee8uTncXrbTFulVIeBCrZVgp7LP2H/R3
 7N8/PA6XDCrG+gO9a7rLGvGMZHOhQISE6VpQ9Pzlfpo5Oz9AvU7exXFQEjYIQTG9y8/td4GZsc3
 bK0SUPFz1yZoMRR
X-Received: by 2002:a05:6a21:99a3:b0:3b4:7b3d:179b with SMTP id
 adf61e73a8af0-3cbce751791mr16468968637.12.1786315442957; 
 Sun, 09 Aug 2026 15:44:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:99a3:b0:3b4:7b3d:179b with SMTP id
 adf61e73a8af0-3cbce751791mr16468925637.12.1786315442375; Sun, 09 Aug 2026
 15:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260808-nouveau-fixes-v1-0-c3ebdc17a89c@outlook.com>
 <20260808-nouveau-fixes-v1-1-c3ebdc17a89c@outlook.com>
In-Reply-To: <20260808-nouveau-fixes-v1-1-c3ebdc17a89c@outlook.com>
From: David Airlie <airlied@redhat.com>
Date: Mon, 10 Aug 2026 08:43:50 +1000
X-Gm-Features: AUfX_mz-ETmvSuEhXYjQJVDLUbKw4YbP9zK1G66hyeAQkHRWyBsRWGvM6OCpIUM
Message-ID: <CAMwc25qozGSRw8KKNzVhakH1jCNWsFS_z=mFn9hswxjdNNX0GA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/nouveau: bound sync and op counts in EXEC and
 VM_BIND
To: moonafterrain@outlook.com
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3nraXcvALbpANBXbHD67q9STaVaCLNMUeBeeALuU4Ns_1786315443
X-Mimecast-Originator: redhat.com
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

> From: Junrui Luo <moonafterrain@outlook.com>
>
> nouveau_exec_ucopy() and nouveau_uvmm_vm_bind_ucopy() pass user-supplied
> u32 counts to u_memcpya(). DRM_IOCTL_NOUVEAU_EXEC bounds only
> req->push_count against push_max, leaving req->wait_count and
> req->sig_count unchecked; DRM_IOCTL_NOUVEAU_VM_BIND bounds none of
> op_count, wait_count or sig_count. u_memcpya() itself only rejects
> multiplication overflow, which on 64-bit never triggers for a u32 count
> times a small element size.
>
> A wait_count of 0xffffffff therefore becomes a 64 GB vmemdup_user()
> request. Since vmemdup_user() allocates with GFP_USER and hence without
> __GFP_NOWARN, a size above INT_MAX trips the WARN_ON_ONCE() in
> __kvmalloc_node_noprof(); below that the kernel attempts an up to 2 GB
> vmalloc that GFP_USER also leaves uncharged to the caller's memcg. Both
> ioctls are DRM_RENDER_ALLOW, so any client holding a render node can
> issue this.
>
> Reject the oversized counts at the ioctl entry points, the way
> nouveau_gem_ioctl_pushbuf() and the existing push_count check already
> do, so that the client is told which limit it exceeded. Sync objects get
> NOUVEAU_MAX_SYNCS, matching both NOUVEAU_GEM_MAX_BUFFERS and the value
> xe settled on for the same field in DRM_XE_MAX_SYNCS. VM_BIND operations
> have no comparable semantic limit, so NOUVEAU_VM_BIND_MAX_OPS is set
> well above any batch size a client is expected to submit; it exists only
> to keep the copy-in allocation finite.
>
> Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Have you run a complete Vulkan CTS with NVK across this with no regressions?

I'm weary of those limits being too low, but I think the only app that
might push them beyond CTS would be Forza Horizon 5 or 6.

Dave.


> ---
>  drivers/gpu/drm/nouveau/nouveau_exec.c | 12 ++++++++++++
>  drivers/gpu/drm/nouveau/nouveau_uvmm.c | 18 ++++++++++++++++++
>  include/uapi/drm/nouveau_drm.h         | 18 ++++++++++++++++++
>  3 files changed, 48 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
> index a08ab1cfea9b..7bdccbae53b1 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_exec.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
> @@ -389,6 +389,18 @@ nouveau_exec_ioctl_exec(struct drm_device *dev,
>                 return nouveau_abi16_put(abi16, -EINVAL);
>         }
>
> +       if (unlikely(req->wait_count > NOUVEAU_MAX_SYNCS)) {
> +               NV_PRINTK(err, cli, "exec wait count exceeds limit: %d max %d\n",
> +                         req->wait_count, NOUVEAU_MAX_SYNCS);
> +               return nouveau_abi16_put(abi16, -EINVAL);
> +       }
> +
> +       if (unlikely(req->sig_count > NOUVEAU_MAX_SYNCS)) {
> +               NV_PRINTK(err, cli, "exec sig count exceeds limit: %d max %d\n",
> +                         req->sig_count, NOUVEAU_MAX_SYNCS);
> +               return nouveau_abi16_put(abi16, -EINVAL);
> +       }
> +
>         ret = nouveau_exec_ucopy(&args, req);
>         if (ret)
>                 goto out;
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index f5e4756b4de4..bced1481674e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -1807,6 +1807,24 @@ nouveau_uvmm_ioctl_vm_bind(struct drm_device *dev,
>         if (unlikely(!nouveau_cli_uvmm_locked(cli)))
>                 return -ENOSYS;
>
> +       if (unlikely(req->op_count > NOUVEAU_VM_BIND_MAX_OPS)) {
> +               NV_PRINTK(err, cli, "vm_bind op count exceeds limit: %d max %d\n",
> +                         req->op_count, NOUVEAU_VM_BIND_MAX_OPS);
> +               return -EINVAL;
> +       }
> +
> +       if (unlikely(req->wait_count > NOUVEAU_MAX_SYNCS)) {
> +               NV_PRINTK(err, cli, "vm_bind wait count exceeds limit: %d max %d\n",
> +                         req->wait_count, NOUVEAU_MAX_SYNCS);
> +               return -EINVAL;
> +       }
> +
> +       if (unlikely(req->sig_count > NOUVEAU_MAX_SYNCS)) {
> +               NV_PRINTK(err, cli, "vm_bind sig count exceeds limit: %d max %d\n",
> +                         req->sig_count, NOUVEAU_MAX_SYNCS);
> +               return -EINVAL;
> +       }
> +
>         ret = nouveau_uvmm_vm_bind_ucopy(&args, req);
>         if (ret)
>                 return ret;
> diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
> index 1fa82fa6af38..35ddf97ca873 100644
> --- a/include/uapi/drm/nouveau_drm.h
> +++ b/include/uapi/drm/nouveau_drm.h
> @@ -220,6 +220,14 @@ struct drm_nouveau_gem_cpu_fini {
>         __u32 handle;
>  };
>
> +/*
> + * NOUVEAU_MAX_SYNCS - maximum number of sync objects per ioctl
> + *
> + * The maximum value EXEC and VM_BIND accept in their wait_count and
> + * sig_count fields.
> + */
> +#define NOUVEAU_MAX_SYNCS 1024
> +
>  /**
>   * struct drm_nouveau_sync - sync object
>   *
> @@ -332,6 +340,16 @@ struct drm_nouveau_vm_bind_op {
>         __u64 range;
>  };
>
> +/*
> + * NOUVEAU_VM_BIND_MAX_OPS - maximum number of &drm_nouveau_vm_bind_ops
> + *
> + * The maximum value VM_BIND accepts in its op_count field. There is no
> + * semantic limit on the number of operations a bind may carry; this bound
> + * exists only to keep the copy-in allocation finite and is far above any
> + * batch size a client is expected to submit.
> + */
> +#define NOUVEAU_VM_BIND_MAX_OPS 65536
> +
>  /**
>   * struct drm_nouveau_vm_bind - structure for DRM_IOCTL_NOUVEAU_VM_BIND
>   */
>
> --
> 2.51.2
>
>

