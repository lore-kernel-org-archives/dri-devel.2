Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9802FF53D69
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 15:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0764E10E3E1;
	Mon, 16 Mar 2026 15:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="CvMkdm8a";
	dkim-atps=neutral
Received: from mail-oi1-f228.google.com (mail-oi1-f228.google.com
 [209.85.167.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60EB10E3B3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 15:54:54 +0000 (UTC)
Received: by mail-oi1-f228.google.com with SMTP id
 5614622812f47-4671cbce2feso1990831b6e.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 08:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773676494; x=1774281294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FEjnWJ08Oh5Ex3BKDiMyba94dr8Bcks5XBBocfAw9kA=;
 b=lBV+9g3/k7dBpleS1x5NxCABm3dMON6KVZeSahsBRbBuipaGtD6ZHbbWJdBmTp4I8e
 TEcP+9o8C2MtYNXXiuMByazbfAF8brrcc26aNXxuyRGmurEQc9sc9tPdKXa1kcqEjR3e
 kq8HR0beavddrXzL9ZFoWk7FlUh/NmdN7rG6nI7SEcQhxLIiC0t5Otx5lK5Jrj/VTAFV
 Spv56cV+rAmfns1SVv9Jv+BcsUY/uRoV1suDKsEM7jyLfjgR9TU5Hbw+H3LHn4Jbh0Ze
 +kMdL6zhxw7q7MD/Ha6VspoVYTzWyA2lXg/CqXEYeiN9D0BvXodrsT2ETzeDhgJuJRIl
 zyiw==
X-Gm-Message-State: AOJu0YyBU2Q6e0lo0YMFxSO+fOvbryS5iB/cqGlSevR21G1Iu9P7TXqs
 g2qpe4ZtGZNSdRYiaV6rCpAuMu6qnbd02joGWJXefvF5ylXqPkA6PLh/+hWCm7MhY9fOhhM1LXr
 QWAvujWaJaXRLSZAdLf91rzPLh/pIim0dIvIGzfCd8oYcHbFQGRPS29TIWXJ53ZlCxUV46GQIvN
 b9tjTl4AD/BZmY7AdiC0Kp8h86dJkD5GDbFlM3oFfK1ksZJdiM2j1yD63kVJCxuciNbdH+pKbkL
 KqjlTfENjmSkK+0B+3e
X-Gm-Gg: ATEYQzwafIN9T4MgV+QgdgNFP1RFchJNAqpF1Mgr+550F9sGXU25vmlwh0v5smbl1A8
 nkWER+mSonZ2jRYv/NlGRANW5lIhynNwEBwqR2GYKxMJXVatOMlHwdlT72jLvyCXLvqn4rtOVk1
 Qxz7LdGF2bANE0CPjEQAKkKaPa8VQ5GOEMVPWQ88DNoo02ON+SyunBKdJ4L5vdO4XfwssJat5Bu
 RW6jvqRtmGQPO23745PRviUHbFcBeC4KKc9ZfUmsZYaZMuI9Fuf6ggOVrom5nymUIOWLC3R0YR0
 fwC9xLly7ViSMH3y4hHT98VxJxKx9C450EGcCir0pKVZgyEq03DQIcZddPX6FrzFECly/jhwpvi
 Qh77bViQ8+YNG4TYRtBRf0VQyme/lrG9L1vQ00u4w9UhLmvFbV7yBZmfKSJStFoRIhCjT/yhNC2
 IyO8afGIX+jeVtILo2BsLvCWgoV0zFX5Kxz64cwnxDcjXCsKh+ACM7Q0MT
X-Received: by 2002:a05:6808:179a:b0:467:3f4:9077 with SMTP id
 5614622812f47-4675752d2ebmr7685639b6e.51.1773676493663; 
 Mon, 16 Mar 2026 08:54:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-4177de82d02sm2534698fac.0.2026.03.16.08.54.53
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Mar 2026 08:54:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3870692ea5cso29054421fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 08:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773676491; cv=none;
 d=google.com; s=arc-20240605;
 b=O+pqZ8LnUIiD4cWyjMersvOX+YBS94yjV5acSgwXjK2jQyBq45LYU4HnFXXrMUryZ4
 9mOdzW8TKIu66jIu06bW/prLNtEVVWvX5gJlZG/MCbttHch+zBo6mBWTpt0e1uVnMxzm
 LItKNWbKfAv+QssSk4kWcJILkplDiE2kja6lY2sl4bFPzwrbe0Okz4RLDmzA3UUwxOkf
 6hRZOrmCWkfXbGb6yPhRjodeN+aYXlKYJAmA4gj9HuIerT4KX2sm8NJ+Mqwszaoab7yM
 r97NoQrvRQB2oAQpvm5axzLLpukubCHYJRakL4ULwWKMZJOA48hKSTy0lopQENSXgGan
 qORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FEjnWJ08Oh5Ex3BKDiMyba94dr8Bcks5XBBocfAw9kA=;
 fh=/PrjhOqwZ5IbSRs0d4hj8vXHZuoYcEoAhOD0rjF39qg=;
 b=ekWAX8Of2VAtgwJY23jTV+vjMjYGU2b8KLfTd7/CZMhVOOmG5d777Jqp1hNYjpJQdp
 /oSkc/zFc8zypGbaucDTc6V5bK134V4w78OPYwIsebOqZH6/KzwB2gNTa6V49CboqpfP
 uk7zpLjqSY2xdvgq3Aoq/hNybOoNXaH/NRf6Ks3EqHii8MGnqg37t1PHV8Bm4TUaZpjj
 1jOzPrx0GRyPGr86U/TYRQOrAU+gUd8nz5ndQclp+bMGf1MjXr0W98GULIHK67QFzlHJ
 6RHpvGXJjTGcbFrqfN/25Yt8HK4NQrWoBlaVmw9rKMSoLId68LjlUajWNVE9tmN8tvsV
 9ryA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1773676491; x=1774281291;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FEjnWJ08Oh5Ex3BKDiMyba94dr8Bcks5XBBocfAw9kA=;
 b=CvMkdm8aEV1TNuekbkh9JzuxokoUQS3Pf/683WECyc3iW7V0FJ0qU1OaAPq4/kT6cr
 4pqfgHEMuE6u4Lbew5mKdHc+c31SsorV/ljO/L2r+1CRYpKoku4fOMX/0XSx06m75trP
 IZLGNwROkQR7ILWRMI+46QRxBDjAwejOvqQMw=
X-Received: by 2002:a2e:b8cf:0:b0:385:fccd:70e5 with SMTP id
 38308e7fff4ca-38a8977dbd2mr44790881fa.28.1773676491355; 
 Mon, 16 Mar 2026 08:54:51 -0700 (PDT)
X-Received: by 2002:a2e:b8cf:0:b0:385:fccd:70e5 with SMTP id
 38308e7fff4ca-38a8977dbd2mr44790721fa.28.1773676490716; Mon, 16 Mar 2026
 08:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260219215548.470810-1-rdunlap@infradead.org>
In-Reply-To: <20260219215548.470810-1-rdunlap@infradead.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Mon, 16 Mar 2026 11:54:37 -0400
X-Gm-Features: AaiRm52g0yOWMU9CNiKpJI971rAjDVXE3B6ESvZR_OynZEhB6C9kuK1iaeLyiRA
Message-ID: <CABQX2QP-JxZWkNdQAahfY-M_8mkaxbpG7TV1kYSoCAMaju69HA@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/vmwgfx: fix kernel-doc warnings in vmwgfx_drv.h
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000003ea9f6064d263db6"
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

--0000000000003ea9f6064d263db6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 4:55=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Fix 45+ kernel-doc warnings in vmwgfx_drv.h:
> - spell a struct name correctly
> - don't have structs between kernel-doc and its struct
> - end description of struct members with ':'
> - start all kernel-doc lines with " *"
> - mark private struct member and enum value with "private:"
> - add kernel-doc for enum vmw_dma_map_mode
> - add missing struct member comments
> - add missing function parameter comments
> - convert "/**" to "/*" for non-kernel-doc comments
> - add missing "Returns:" comments for several functions
> - correct a function parameter name
>
> to eliminate kernel-doc warnings (examples):
>
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:128 struct vmw_bo; error:
>  Cannot parse struct or union!
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:151 struct member 'used_prio=
'
>  not described in 'vmw_resource'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:151 struct member 'mob_node'
>  not described in 'vmw_resource'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:199 bad line: SM4 device.
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:270 struct member 'private'
>  not described in 'vmw_res_cache_entry'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:280 Enum value
>  'vmw_dma_alloc_coherent' not described in enum 'vmw_dma_map_mode'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:280 Enum value
>  'vmw_dma_map_bind' not described in enum 'vmw_dma_map_mode'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:295 struct member 'addrs'
>  not described in 'vmw_sg_table'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:295 struct member 'mode'
>  not described in 'vmw_sg_table'
> vmwgfx_drv.h:309: warning: Excess struct member 'num_regions' description
>  in 'vmw_sg_table'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:402 struct member 'filp'
>  not described in 'vmw_sw_context'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:732 This comment starts with
>  '/**', but isn't a kernel-doc comment.
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:742 This comment starts with
>  '/**', but isn't a kernel-doc comment.
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:762 This comment starts with
>  '/**', but isn't a kernel-doc comment.
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:887 No description found for
>  return value of 'vmw_fifo_caps'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:901 No description found for
>  return value of 'vmw_is_cursor_bypass3_enabled'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:906 This comment starts with
>  '/**', but isn't a kernel-doc comment.
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:961 This comment starts with
>  '/**', but isn't a kernel-doc comment.
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:996 This comment starts with
>  '/**', but isn't a kernel-doc comment.
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:1082 cannot understand
>  function prototype: 'const struct dma_buf_ops vmw_prime_dmabuf_ops;'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:1303 struct member 'do_cpy'
>  not described in 'vmw_diff_cpy'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:1385 function parameter 'fmt=
'
>  not described in 'VMW_DEBUG_KMS'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:1389 This comment starts wit=
h
>  '/**', but isn't a kernel-doc comment.
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:1426 function parameter 'vmw=
'
>  not described in 'vmw_fifo_mem_read'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:1426 No description found fo=
r
>  return value of 'vmw_fifo_mem_read'
> Warning: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:1441 function parameter
>  'fifo_reg' not described in 'vmw_fifo_mem_write'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Zack Rusin <zack.rusin@broadcom.com>
> Cc: <bcm-kernel-feedback-list@broadcom.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h |   93 +++++++++++++++-----------
>  1 file changed, 57 insertions(+), 36 deletions(-)
>
> --- linux-next-20260218.orig/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> +++ linux-next-20260218/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> @@ -96,12 +96,17 @@ struct vmwgfx_hash_item {
>
>  struct vmw_res_func;
>
> +struct vmw_bo;
> +struct vmw_bo;
> +struct vmw_resource_dirty;
> +
>  /**
> - * struct vmw-resource - base class for hardware resources
> + * struct vmw_resource - base class for hardware resources
>   *
>   * @kref: For refcounting.
>   * @dev_priv: Pointer to the device private for this resource. Immutable=
.
>   * @id: Device id. Protected by @dev_priv::resource_lock.
> + * @used_prio: Priority for this resource.
>   * @guest_memory_size: Guest memory buffer size. Immutable.
>   * @res_dirty: Resource contains data not yet in the guest memory buffer=
.
>   * Protected by resource reserved.
> @@ -117,18 +122,16 @@ struct vmw_res_func;
>   * pin-count greater than zero. It is not on the resource LRU lists and =
its
>   * guest memory buffer is pinned. Hence it can't be evicted.
>   * @func: Method vtable for this resource. Immutable.
> - * @mob_node; Node for the MOB guest memory rbtree. Protected by
> + * @mob_node: Node for the MOB guest memory rbtree. Protected by
>   * @guest_memory_bo reserved.
>   * @lru_head: List head for the LRU list. Protected by @dev_priv::resour=
ce_lock.
>   * @binding_head: List head for the context binding list. Protected by
>   * the @dev_priv::binding_mutex
> + * @dirty: resource's dirty tracker
>   * @res_free: The resource destructor.
>   * @hw_destroy: Callback to destroy the resource on the device, as part =
of
>   * resource destruction.
>   */
> -struct vmw_bo;
> -struct vmw_bo;
> -struct vmw_resource_dirty;
>  struct vmw_resource {
>         struct kref kref;
>         struct vmw_private *dev_priv;
> @@ -196,8 +199,8 @@ struct vmw_surface_offset;
>   * @quality_level: Quality level.
>   * @autogen_filter: Filter for automatically generated mipmaps.
>   * @array_size: Number of array elements for a 1D/2D texture. For cubema=
p
> -                texture number of faces * array_size. This should be 0 f=
or pre
> -               SM4 device.
> + *              texture number of faces * array_size. This should be 0 f=
or pre
> + *             SM4 device.
>   * @buffer_byte_stride: Buffer byte stride.
>   * @num_sizes: Size of @sizes. For GB surface this should always be 1.
>   * @base_size: Surface dimension.
> @@ -265,18 +268,24 @@ struct vmw_fifo_state {
>  struct vmw_res_cache_entry {
>         uint32_t handle;
>         struct vmw_resource *res;
> +       /* private: */
>         void *private;
> +       /* public: */
>         unsigned short valid_handle;
>         unsigned short valid;
>  };
>
>  /**
>   * enum vmw_dma_map_mode - indicate how to perform TTM page dma mappings=
.
> + * @vmw_dma_alloc_coherent: Use TTM coherent pages
> + * @vmw_dma_map_populate: Unmap from DMA just after unpopulate
> + * @vmw_dma_map_bind: Unmap from DMA just before unbind
>   */
>  enum vmw_dma_map_mode {
> -       vmw_dma_alloc_coherent, /* Use TTM coherent pages */
> -       vmw_dma_map_populate,   /* Unmap from DMA just after unpopulate *=
/
> -       vmw_dma_map_bind,       /* Unmap from DMA just before unbind */
> +       vmw_dma_alloc_coherent,
> +       vmw_dma_map_populate,
> +       vmw_dma_map_bind,
> +       /* private: */
>         vmw_dma_map_max
>  };
>
> @@ -284,8 +293,11 @@ enum vmw_dma_map_mode {
>   * struct vmw_sg_table - Scatter/gather table for binding, with addition=
al
>   * device-specific information.
>   *
> + * @mode: which page mapping mode to use
> + * @pages: Array of page pointers to the pages.
> + * @addrs: DMA addresses to the pages if coherent pages are used.
>   * @sgt: Pointer to a struct sg_table with binding information
> - * @num_regions: Number of regions with device-address contiguous pages
> + * @num_pages: Number of @pages
>   */
>  struct vmw_sg_table {
>         enum vmw_dma_map_mode mode;
> @@ -353,6 +365,7 @@ struct vmw_ctx_validation_info;
>   * than from user-space
>   * @fp: If @kernel is false, points to the file of the client. Otherwise
>   * NULL
> + * @filp: DRM state for this file
>   * @cmd_bounce: Command bounce buffer used for command validation before
>   * copying to fifo space
>   * @cmd_bounce_size: Current command bounce buffer size
> @@ -729,7 +742,7 @@ extern void vmw_svga_disable(struct vmw_
>  bool vmwgfx_supported(struct vmw_private *vmw);
>
>
> -/**
> +/*
>   * GMR utilities - vmwgfx_gmr.c
>   */
>
> @@ -739,7 +752,7 @@ extern int vmw_gmr_bind(struct vmw_priva
>                         int gmr_id);
>  extern void vmw_gmr_unbind(struct vmw_private *dev_priv, int gmr_id);
>
> -/**
> +/*
>   * User handles
>   */
>  struct vmw_user_object {
> @@ -759,7 +772,7 @@ void *vmw_user_object_map_size(struct vm
>  void vmw_user_object_unmap(struct vmw_user_object *uo);
>  bool vmw_user_object_is_mapped(struct vmw_user_object *uo);
>
> -/**
> +/*
>   * Resource utilities - vmwgfx_resource.c
>   */
>  struct vmw_user_resource_conv;
> @@ -819,7 +832,7 @@ static inline bool vmw_resource_mob_atta
>         return !RB_EMPTY_NODE(&res->mob_node);
>  }
>
> -/**
> +/*
>   * GEM related functionality - vmwgfx_gem.c
>   */
>  struct vmw_bo_params;
> @@ -833,7 +846,7 @@ extern int vmw_gem_object_create_ioctl(s
>                                        struct drm_file *filp);
>  extern void vmw_debugfs_gem_init(struct vmw_private *vdev);
>
> -/**
> +/*
>   * Misc Ioctl functionality - vmwgfx_ioctl.c
>   */
>
> @@ -846,7 +859,7 @@ extern int vmw_present_ioctl(struct drm_
>  extern int vmw_present_readback_ioctl(struct drm_device *dev, void *data=
,
>                                       struct drm_file *file_priv);
>
> -/**
> +/*
>   * Fifo utilities - vmwgfx_fifo.c
>   */
>
> @@ -880,9 +893,11 @@ extern int vmw_cmd_flush(struct vmw_priv
>
>
>  /**
> - * vmw_fifo_caps - Returns the capabilities of the FIFO command
> + * vmw_fifo_caps - Get the capabilities of the FIFO command
>   * queue or 0 if fifo memory isn't present.
>   * @dev_priv: The device private context
> + *
> + * Returns: capabilities of the FIFO command or %0 if fifo memory not pr=
esent
>   */
>  static inline uint32_t vmw_fifo_caps(const struct vmw_private *dev_priv)
>  {
> @@ -893,9 +908,11 @@ static inline uint32_t vmw_fifo_caps(con
>
>
>  /**
> - * vmw_is_cursor_bypass3_enabled - Returns TRUE iff Cursor Bypass 3
> - * is enabled in the FIFO.
> + * vmw_is_cursor_bypass3_enabled - check Cursor Bypass 3 enabled setting
> + * in the FIFO.
>   * @dev_priv: The device private context
> + *
> + * Returns: %true iff Cursor Bypass 3 is enabled in the FIFO
>   */
>  static inline bool
>  vmw_is_cursor_bypass3_enabled(const struct vmw_private *dev_priv)
> @@ -903,7 +920,7 @@ vmw_is_cursor_bypass3_enabled(const stru
>         return (vmw_fifo_caps(dev_priv) & SVGA_FIFO_CAP_CURSOR_BYPASS_3) =
!=3D 0;
>  }
>
> -/**
> +/*
>   * TTM buffer object driver - vmwgfx_ttm_buffer.c
>   */
>
> @@ -927,7 +944,7 @@ extern void vmw_piter_start(struct vmw_p
>   *
>   * @viter: Pointer to the iterator to advance.
>   *
> - * Returns false if past the list of pages, true otherwise.
> + * Returns: false if past the list of pages, true otherwise.
>   */
>  static inline bool vmw_piter_next(struct vmw_piter *viter)
>  {
> @@ -939,7 +956,7 @@ static inline bool vmw_piter_next(struct
>   *
>   * @viter: Pointer to the iterator
>   *
> - * Returns the DMA address of the page pointed to by @viter.
> + * Returns: the DMA address of the page pointed to by @viter.
>   */
>  static inline dma_addr_t vmw_piter_dma_addr(struct vmw_piter *viter)
>  {
> @@ -951,14 +968,14 @@ static inline dma_addr_t vmw_piter_dma_a
>   *
>   * @viter: Pointer to the iterator
>   *
> - * Returns the DMA address of the page pointed to by @viter.
> + * Returns: the DMA address of the page pointed to by @viter.
>   */
>  static inline struct page *vmw_piter_page(struct vmw_piter *viter)
>  {
>         return viter->pages[viter->i];
>  }
>
> -/**
> +/*
>   * Command submission - vmwgfx_execbuf.c
>   */
>
> @@ -993,7 +1010,7 @@ extern int vmw_execbuf_copy_fence_user(s
>                                         int32_t out_fence_fd);
>  bool vmw_cmd_describe(const void *buf, u32 *size, char const **cmd);
>
> -/**
> +/*
>   * IRQs and wating - vmwgfx_irq.c
>   */
>
> @@ -1016,7 +1033,7 @@ bool vmw_generic_waiter_add(struct vmw_p
>  bool vmw_generic_waiter_remove(struct vmw_private *dev_priv,
>                                u32 flag, int *waiter_count);
>
> -/**
> +/*
>   * Kernel modesetting - vmwgfx_kms.c
>   */
>
> @@ -1048,7 +1065,7 @@ extern int vmw_resource_pin(struct vmw_r
>  extern void vmw_resource_unpin(struct vmw_resource *res);
>  extern enum vmw_res_type vmw_res_type(const struct vmw_resource *res);
>
> -/**
> +/*
>   * Overlay control - vmwgfx_overlay.c
>   */
>
> @@ -1063,20 +1080,20 @@ int vmw_overlay_unref(struct vmw_private
>  int vmw_overlay_num_overlays(struct vmw_private *dev_priv);
>  int vmw_overlay_num_free_overlays(struct vmw_private *dev_priv);
>
> -/**
> +/*
>   * GMR Id manager
>   */
>
>  int vmw_gmrid_man_init(struct vmw_private *dev_priv, int type);
>  void vmw_gmrid_man_fini(struct vmw_private *dev_priv, int type);
>
> -/**
> +/*
>   * System memory manager
>   */
>  int vmw_sys_man_init(struct vmw_private *dev_priv);
>  void vmw_sys_man_fini(struct vmw_private *dev_priv);
>
> -/**
> +/*
>   * Prime - vmwgfx_prime.c
>   */
>
> @@ -1292,7 +1309,7 @@ extern void vmw_cmdbuf_irqthread(struct
>   * @line: The current line of the blit.
>   * @line_offset: Offset of the current line segment.
>   * @cpp: Bytes per pixel (granularity information).
> - * @memcpy: Which memcpy function to use.
> + * @do_cpy: Which memcpy function to use.
>   */
>  struct vmw_diff_cpy {
>         struct drm_rect rect;
> @@ -1380,13 +1397,14 @@ vm_fault_t vmw_bo_vm_mkwrite(struct vm_f
>
>  /**
>   * VMW_DEBUG_KMS - Debug output for kernel mode-setting
> + * @fmt: format string for the args
>   *
>   * This macro is for debugging vmwgfx mode-setting code.
>   */
>  #define VMW_DEBUG_KMS(fmt, ...)                                         =
      \
>         DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__)
>
> -/**
> +/*
>   * Inline helper functions
>   */
>
> @@ -1417,11 +1435,13 @@ static inline void vmw_fifo_resource_dec
>
>  /**
>   * vmw_fifo_mem_read - Perform a MMIO read from the fifo memory
> - *
> + * @vmw: The device private structure
>   * @fifo_reg: The fifo register to read from
>   *
>   * This function is intended to be equivalent to ioread32() on
>   * memremap'd memory, but without byteswapping.
> + *
> + * Returns: the value read
>   */
>  static inline u32 vmw_fifo_mem_read(struct vmw_private *vmw, uint32 fifo=
_reg)
>  {
> @@ -1431,8 +1451,9 @@ static inline u32 vmw_fifo_mem_read(stru
>
>  /**
>   * vmw_fifo_mem_write - Perform a MMIO write to volatile memory
> - *
> - * @addr: The fifo register to write to
> + * @vmw: The device private structure
> + * @fifo_reg: The fifo register to write to
> + * @value: The value to write
>   *
>   * This function is intended to be equivalent to iowrite32 on
>   * memremap'd memory, but without byteswapping.

Thank you! Applied to drm-misc-fixes.

z

--0000000000003ea9f6064d263db6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIBmO
Wz7S7in82a8GcLloSkTkoQWI3n5cNMMR7pvbSpwwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDMxNjE1NTQ1MVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHSLv49CPBR6FTHY4m03Ydmv+PteVfXfMkI/bU0V
PFetUFvFjVFHUN/iQUZFxKSQF6UUiC42YodB2nij1pbYwZvUgnX5HqdmuSr/+1ZyPeUqexwpwDhv
gwR+80JaRGOsxlNP0v85B2dR9wwtZy3iD4dXJhCv9eG6TQHYpbXyRrZC7EN9ffb+AFEzzPJaPObO
RcxaVKPmq6tXfRgSLvEMonhjI7v6JJZyHrd5XDtbTSHZOHeWQyvABw0bf8gOsE/3x3K2zppwwCLz
SKJhrkodRr9y4tbhYzpjtBTDET/ZA1iOd4/0l/zYKnsPTerqsACZO9dsF9xizqfz4K6kN4nl1qc=
--0000000000003ea9f6064d263db6--
