Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746DAC98306
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 05:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3DA410F85C;
	Fri, 25 Sep 2026 05:29:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AsZIatA7";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F31310F85F
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 05:29:02 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 d9443c01a7336-2d747ee1f38so1912285ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 22:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790314142; x=1790918942; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jjesyLAW8O7xyuzsdrbUH/i4uqP33Nn67plGwTSNEoc=;
 b=AsZIatA7sl/lVFpa9XqaIDpsVkfmgHX5xL7nTWZRSifGE99Z+3ZgEU5QBp7wnMeHdJ
 gREjY8TETIjHQDTxO6xN49ubn35NFyjCVfQAciDmEM93/H3dAOybXGNYdjV6uEyzyH/G
 DDzpapS5vRBtoC+gDcJ/Q16fbrOrVEL9fo2wA1EwBC6RxpQFdX1VPCQQfI8OChwPKO3u
 DQ5mJDIt+yYmf417sl7jBUAFqbfTlBzJplHrdWOpLNKvz+K3FCsytGT6EQwvRJ26ZL2O
 mOEUyjnHj3cYl9pP4UpSNiiiecw+zr6KQFrJApbmzNYSO4CZMWeye51WUL5XSMhDB6Th
 v8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790314142; x=1790918942;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jjesyLAW8O7xyuzsdrbUH/i4uqP33Nn67plGwTSNEoc=;
 b=AnDTb072xZ8x2XMG0308r0ZjlhkdgvDBoHiTT4mNUvWTegbfLaxKONlu/GgroCJe5E
 Yskj33oKjjeRuxOUMD4JFZiHUYTPNOyAE7S11AD/0i3Xe/X61W+RxHU9GZxVf1Jb6d9D
 AErnZPuLVTS1BSHwWtUpvKuk6l4ANs+m4GS9Sfv+2LgD3bK1GWp3cH46cO/gbLLM/UiY
 /ItniXWkHAK1ewHXJ5G4dtgJNyHnnRFz3EIvPh/hsz/josQLMaPzWgyihfvz0nlq6aex
 aAyDnIHLRrYDR+oue6wTPW90nLjbKKRKuL+jROrH6KQFTQoWExaUQuDTUzRLMjyHXRML
 7yAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4hR8qNcihb6pmiQdo2LfywuxMvWB9tdCFW6xG7YOqimT9bsLD9DcKgz6oOcPJ4pfAe3sR2UcFZxE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m45B4waAvBULpFfzdcphAPRyceshpa5tgv7SnE61s6e1Im3NCh
 knpLmivViq42+3WA4XUqHga0NI876QNTn20WVICkQCTTEzxVTmIQEjOL
X-Gm-Gg: AYBFou1qUY+rU35Exs9MnFGwQKpwUBn4HLJbFjqvrlZ4pL7+vWdOJoXXEhepJqjryeP
 8LnHsujR9JIsQ69b9TwoDUFAZVhDZDGW9ogtXphOddhuNzEgGD/JjCzfAJbzW+0TfiXTaGCUKaV
 QhB1vneOM0yfxihjzn+2ftNop/Tozsp8kwsDsAP4yXYQHoP2KuI7FBdMNAy6n+bCC1UJWz2Hydu
 zlpLpB/VliNNEDW/a0maKU2fLKubOHcLhablFhHQkPAc5CEhDjcI+CKnADg9zgthCv4FFaCwRsr
 djcpR0IcrK3IsbVTCKUtxXDqnZTY+9U91jKTgQBZnWP3yahn9ioddJUP6qE/xqjfe/CLCWueBtL
 HqT/PO6lCir0XR7dkzAamtSt+Az6faPAKYJAxls79Mfm4XwQwlyuAq7Q0GeUUgZG3zHDQGr408A
 K6ojIQOXEjGyPdOgba7TzwULWOC+Zkf/ZetvN5M9q0CDlVQ7Xq+HYS3lbBHstHX5krOhgP4Te9M
 seK
X-Received: by 2002:a17:902:e552:b0:2dd:c100:7cbb with SMTP id
 d9443c01a7336-2df7dc514admr37582425ad.55.1790314141611; 
 Thu, 24 Sep 2026 22:29:01 -0700 (PDT)
Received: from localhost ([2400:2650:24e0:bf00:cc77:213f:afc3:65e2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df964d46b0sm2611595ad.15.2026.09.24.22.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 22:29:01 -0700 (PDT)
Date: Fri, 25 Sep 2026 14:28:58 +0900
From: Zhenyu Wang <zhenyuw.linux@gmail.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: airlied@gmail.com, changbin.du@intel.com,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 linux-kernel@vger.kernel.org, rodrigo.vivi@intel.com,
 simona@ffwll.ch, tursulin@ursulin.net, zhi.wang.linux@gmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: Fix mm reference leak in
 handle_g2v_notification()
Message-ID: <arYGmj-FpQS_OBCA@dell-wzy>
References: <20260916173720.2088455-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916173720.2088455-1-vulab@iscas.ac.cn>
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

On Wed, Sep 16, 2026 at 05:37:20PM +0000, Wentao Liang wrote:
> intel_vgpu_get_ppgtt_mm() returns a reference the caller must drop, but
> the PPGTT page table create path only inspected the result. A page
> table that is already tracked gained an extra reference which nothing
> would ever drop. Skip the lookup-get for an already registered mm; a
> newly created mm keeps its initial registration reference.
>

Besides sashiko's reply, those reference was designed to guard against
case that possible same ppgtt table usage within single client case.
This change just breaks all of that. So NAK this with other reason Joonas
has replied..

> Fixes: e6e9c46fd235 ("drm/i915/gvt: Factor out intel_vgpu_{get, put}_ppgtt_mm interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/i915/gvt/handlers.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
> index a34f56630af9..3d7aae6c5cf1 100644
> --- a/drivers/gpu/drm/i915/gvt/handlers.c
> +++ b/drivers/gpu/drm/i915/gvt/handlers.c
> @@ -1506,7 +1506,17 @@ static int handle_g2v_notification(struct intel_vgpu *vgpu, int notification)
>  		root_entry_type = GTT_TYPE_PPGTT_ROOT_L3_ENTRY;
>  		fallthrough;
>  	case VGT_G2V_PPGTT_L4_PAGE_TABLE_CREATE:
> -		mm = intel_vgpu_get_ppgtt_mm(vgpu, root_entry_type, pdps);
> +		/*
> +		 * A newly created mm keeps its initial reference as the
> +		 * registration reference, dropped by the DESTROY
> +		 * notification. A duplicate CREATE for an already tracked
> +		 * mm must not take an extra reference that nothing drops.
> +		 */
> +		mm = intel_vgpu_find_ppgtt_mm(vgpu, pdps);
> +		if (mm)
> +			return 0;
> +
> +		mm = intel_vgpu_create_ppgtt_mm(vgpu, root_entry_type, pdps);
>  		return PTR_ERR_OR_ZERO(mm);
>  	case VGT_G2V_PPGTT_L3_PAGE_TABLE_DESTROY:
>  	case VGT_G2V_PPGTT_L4_PAGE_TABLE_DESTROY:
> -- 
> 2.34.1
