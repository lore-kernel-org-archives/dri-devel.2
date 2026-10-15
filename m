Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF2DCC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 05:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE2210E21D;
	Thu, 15 Oct 2026 05:25:21 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D29410E21D
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 05:25:15 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2db710396ffso37450135ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 22:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792041915; x=1792646715; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x3DSX4Qza6d2uuaZQntx7y2v2J0oEf5jt6hMhwGI1ew=;
 b=JyDuKNQMGNJMsO/rS6WDuTPJb9WYK/ZLi9IsyVea6Sp3a7XnPzeLn7sjqunhY7YGk4
 D3rRzs6rBGGGO/H5Qq4kVO0L+cv6e7FFxEL+oilgYM84PNt95edT3l2/DHnJC/688S2V
 M4F5pans/84b1tsqHNTuy1bRLzAqyfD9jUfY2VBtm3GUrtZtWkn7T13UdePyUNU1UiDC
 cC9Hcc/SXGwnl2VvVaZs7XL41F+uQV2ZwGOZpwrPZf1KooRiNhBpAjF4kDziz+vIhKtE
 6fCfsnK5Yedq545q0reD13Mv4+KLuZrrZsUQeGSqsIDaFwDiky/lsle+NIWPAFX70LxA
 QQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792041915; x=1792646715;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x3DSX4Qza6d2uuaZQntx7y2v2J0oEf5jt6hMhwGI1ew=;
 b=XEyJMU/9/fINUDPrrZnW/gfLfjZaGHwVAOqwhpV6tEvFzeU6N4pY/QoCWWy8oY6X4D
 hdE5WgXIglcomn2Gx0Ww+rS74gwfFSw3Y+2x/a+phTNSEQufCLZsJIBmAkxcRI//2GcY
 fefOUPneLh7gNaIQTrsgKH8yQfJy1V/wdnXhpPTnoFHtXNsDbuc+deMe/xRY7+36xJRL
 dOQlo++BX/nk0MsYpk7sRq5CVUb7Zcx9zA/ryEb+J3uhJwpRMiem+Zi+CEnAKt0M7S1u
 uLTi/maeowUEG/5fhGTx+qwcbZYq0hQGMenbU5t16AE+cnjSTKKQc27HSyCCMzGDbLFV
 84iQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzz6I5s31l+wfT8jTwtBsLRlC+KI9z84P6awle1aLdswq7bv1TulV3aWx3FT0YKm23w5eeWNQ0P2mQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYItkgvBFkQm2WdfAk4uU7vDB3vUH4S7O9NqDetWvv6iG2pCY7Uv
 vqCwj4P3KTy9SpS3C34S4RZxUq+z8qPxwQwT6bvqqw6j+1OL8+lKUeLE
X-Gm-Gg: AYBFou27fi2uXzDxcaFviuTmtYeKEiIA92Yrh98d0CtV0BeiY7xgxaEdZZUyBqTItP9
 etzlki5MAcYaODf6RtMsS2cvLWxxjgBYT17Yvqh2d9Uy+zEpHBByYwZDgoAkFHYc2+xXrjh5OKT
 9rXhwmpamoFS7FpGzro4A0Kab7kKL4T5YRymNDiFDKqQFB9qpT+nuOyOOX505EW1mWSxEeIvwEm
 L+aSqeA9AN4ncTps+tVDZ/AE0AvvoZfi/OQK813iwMGuQOuGzjXVxkxLn/+GcrnGbsjralpaDcY
 MyMPlYAiTySV3ytkBF53hEjGvOqHfidU19ufVtG1fIl5WZ09GEd4Xk5QufzJ2jyPZsAfp/waH1R
 5g3JbJZCw1WCpEDcvJSM1pz4CyVVB1PTYWyuISg2mH7vVmVq0TpYBNwwMATGyIGTizYfIK63T78
 t8ZMAkKFAeAR9bdD0WzHBbLXy5EIWe7mXmbPeI6aROwDllhVKnzjo2JzCweaocfhR1qihmy0Xx6
 xMpsWyxKfiIfQ7MHC7LH9YqYgCtofBQZ46G1YtMzqk5
X-Received: by 2002:a17:90a:d44d:b0:3a2:bb9f:f87d with SMTP id
 98e67ed59e1d1-3ab3a9f2d87mr10362341a91.21.1792041914556; 
 Wed, 14 Oct 2026 22:25:14 -0700 (PDT)
Received: from localhost (softbank126159121187.bbtec.net. [126.159.121.187])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac945e74bcsm2625793a91.3.2026.10.14.22.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 22:25:13 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:25:10 +0900
From: Zhenyu Wang <zhenyuw.linux@gmail.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Zack Rusin <zack.rusin@broadcom.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 intel-gfx@lists.freedesktop.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Alex Mastro <amastro@fb.com>,
 Alex Williamson <alex@shazbot.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drm/i915/gvt: Read dmabuf->file only while valid
Message-ID: <atBjtqQTCxLuomi2@dell-wzy>
References: <20261013120211.135807-1-matt@ozlabs.org>
 <20261013120211.135807-3-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013120211.135807-3-matt@ozlabs.org>
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

On Tue, Oct 13, 2026 at 01:02:05PM +0100, Matt Evans wrote:
> After 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
> dentry_ops"), dmabuf->file can close prior to the .release callback
> being invoked.
> 
> intel_vgpu_get_dmabuf() exports the dmabuf, then dma_buf_fd()
> effectively transfers its file's reference to the fd.  A debug print
> dereferences dmabuf->file after the dma_buf_fd(); however, the fd
> could be closed by another thread, making dmabuf->file stale.
> 
> Read file_count() while the reference to dmabuf->file is still held,
> for later debug printing.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentry_ops")
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/gpu/drm/i915/gvt/dmabuf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
> index 8a1d6c5636c2..b6f50f2b912d 100644
> --- a/drivers/gpu/drm/i915/gvt/dmabuf.c
> +++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
> @@ -503,6 +503,7 @@ int intel_vgpu_get_dmabuf(struct intel_vgpu *vgpu, unsigned int dmabuf_id)
>  	struct drm_device *dev = &vgpu->gvt->gt->i915->drm;
>  	struct intel_vgpu_dmabuf_obj *dmabuf_obj;
>  	struct drm_i915_gem_object *obj;
> +	unsigned long db_fcount;
>  	struct dma_buf *dmabuf;
>  	int dmabuf_fd;
>  	int ret = 0;
> @@ -531,6 +532,7 @@ int intel_vgpu_get_dmabuf(struct intel_vgpu *vgpu, unsigned int dmabuf_id)
>  		ret = PTR_ERR(dmabuf);
>  		goto out_free_gem;
>  	}
> +	db_fcount = file_count(dmabuf->file);
>  
>  	ret = dma_buf_fd(dmabuf, DRM_CLOEXEC | DRM_RDWR);
>  	if (ret < 0) {
> @@ -552,8 +554,7 @@ int intel_vgpu_get_dmabuf(struct intel_vgpu *vgpu, unsigned int dmabuf_id)
>  		    "        file count: %ld, GEM ref: %d\n",
>  		    vgpu->id, dmabuf_obj->dmabuf_id,
>  		    kref_read(&dmabuf_obj->kref),
> -		    dmabuf_fd,
> -		    file_count(dmabuf->file),
> +		    dmabuf_fd, db_fcount,
>  		    kref_read(&obj->base.refcount));
>  
>  	i915_gem_object_put(obj);
> -- 
> 2.47.3

Acked-by: Zhenyu Wang <zhenyuw.linux@gmail.com>
