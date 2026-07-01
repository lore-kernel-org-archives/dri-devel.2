Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1865C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E6A010E1D4;
	Wed,  1 Jul 2026 18:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="UyyTmZ1l";
	dkim-atps=neutral
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com
 [209.85.222.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23EE10E1D4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 18:27:02 +0000 (UTC)
Received: by mail-ua1-f98.google.com with SMTP id
 a1e0cc1a2514c-966eabad303so277008241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 11:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930422; x=1783535222;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6eELnJDfMDhCnRTklfCSi4o2D3KkPbfnfWJheXfazTU=;
 b=OwDUzCvUMIGO1M0xin5w/XR5ptE6bZQtCTF71+k4qnWROtwjzcK+ZzMLSEJjtqhcHi
 Q3kc6yzcsoPtC043dzQIzYgZz7AvK+2SFr8/GudilEXPNRigj7voPIv03roANxNt3MqI
 469fXTtcw7qI6mHkudlgK9Esja4pms49GS015rFoQWTWAuE8kPcBSPP6609ruiPKvqWA
 4go+Nzyh9nv2lJvuOxSpMgGZ81qGThQdqMhgOPvMybnsLd0obdNBRLa4uq6qQbjdbXKv
 wIsHuB6rjWtTTCthqxQdKszKgMxSjtWMb8RXVUuWjMN5oW0y47EcxE1z9nDIXLxZIafa
 Y9Gw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rru3oFHwV9mjGRuwY48hvgyLFRzGhxBZ7hwdBkLLrQUlKBfiudvFOU/OJxYYhEkX+znhbv+B0scCrc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysmuUPLzCa64WwCoIOKzhEOMvlM07X1gEQTfO+pHN8aktOYGeL
 t9E+s98b67hrgbxA54ukAZtQ5YMqNGVkFNLllr238SC/iQQK9Z1rdwrHO7eHPEH5L2PGJq1DvuB
 hOKiBnVG6p5cCR5jQ1REDpysBTvt7cx28PibWWvg/CSK5iIEE3lphslEYLp3mVmhScD7i6XP9wb
 WqMojNnvoA3zs6AB9rHR4B6R2K2L1eSaDFZ59TMJWjH7xDQJDrfegoPIdx8ZC+JFmqn4Ih5m7Oh
 DbjazGcFyKxagIqkoXhKhRhbFot
X-Gm-Gg: AfdE7cnFO6ZThLfJHJhaBG1m/KgtRK7/rFjaF+sa1dMXp8Kb92QkVvIcrTD7U3coyJH
 FZJIiU7UxPXfPSYbzvcpMWcogD2MIRm7uIQr4OGI2Ya/CUxLqXChvjLQWMOxLI581MSDFSbrK6q
 U69E6XyyzfpiOLQ+CuQ43nyroR5OKtNEBvFLrwmEJfvC3JRzaFBsHx0z7cjic/oGcNJmYi5Cn6f
 IeVSE+pT4EIDcCRfedIF4S+lV6TW2fO+Mf10vhvRkfj5JHx5WgyH9ciSDvEx1SLJCgkBGfNyhwX
 DtmqggChfKCcGTp4N/+9ZbjydHhY0fXwWUgVP6q2rkhjZIyow7pOl3DfDne9mDTkxnDU145Un4T
 fErMrIp0j4wrweVndiekj0+XIKjg7yWvd7PuFxh+G+h0p5Gbn1DupeGCS07Xpr10QE4Xs52ilrA
 vNxGbwArIXqlafiXQXTQIbaslwJ4ZLoUBSZ2T6WD0EZ+Q28GY4rJ2vyg==
X-Received: by 2002:a05:6102:5093:b0:739:4470:d8 with SMTP id
 ada2fe7eead31-73daa581a0cmr1349680137.26.1782930421649; 
 Wed, 01 Jul 2026 11:27:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-73e1993472bsm29247137.5.2026.07.01.11.27.01
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Jul 2026 11:27:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-37d4f23eb37so1575597a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 11:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1782930420; x=1783535220;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6eELnJDfMDhCnRTklfCSi4o2D3KkPbfnfWJheXfazTU=;
 b=UyyTmZ1lzVpMHKlAm18uD9oMJF6WEmF44cjliAaBTfGY9Jv/78viiTnNKCzb/NzZ/g
 6/O7gtDS8Vs14fKHoupiN6/UrQsYkh4CtCTu8gWdugFksjj7OHRQGTo2lFaj/VanoRkk
 mSB+pKTe14RrX9imAMy6iqI20yO5u7OsI/Xao=
X-Forwarded-Encrypted: i=1;
 AHgh+RqqtjaQQBl+AtKTVkbQVqnicSirJR5L4eVNCkcqCXo+uZ72xPZfyqfPWzjl60u/xQyd+WgFz5lTUhg=@lists.freedesktop.org
X-Received: by 2002:a17:90b:35d1:b0:380:9d0d:7af8 with SMTP id
 98e67ed59e1d1-380aa1847famr2431628a91.20.1782930420519; 
 Wed, 01 Jul 2026 11:27:00 -0700 (PDT)
X-Received: by 2002:a17:90b:35d1:b0:380:9d0d:7af8 with SMTP id
 98e67ed59e1d1-380aa1847famr2431601a91.20.1782930419919; 
 Wed, 01 Jul 2026 11:26:59 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbdc4eesm279758eec.24.2026.07.01.11.26.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 11:26:59 -0700 (PDT)
Message-ID: <cd012938-fd69-486f-b441-ea66def7aa96@broadcom.com>
Date: Wed, 1 Jul 2026 11:31:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: Validate vmw_surface_metadata::array_size
To: Ian Forbes <ian.forbes@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com
References: <20260623193314.506257-1-ian.forbes@broadcom.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20260623193314.506257-1-ian.forbes@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

On 6/23/26 12:33 PM, Ian Forbes wrote:
> This field comes from userspace and should be validated against specific
> limits depending on which Shader Model (SM) is available.
> 
> Fixes: 504901dbb0b5 ("drm/vmwgfx: Refactor surface_define to use vmw_surface_metadata")
> Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> index b2d3927b5567..bd0563741e89 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -78,7 +78,7 @@ static int vmw_gb_surface_unbind(struct vmw_resource *res,
>  static int vmw_gb_surface_destroy(struct vmw_resource *res);
>  static int
>  vmw_gb_surface_define_internal(struct drm_device *dev,
> -			       struct drm_vmw_gb_surface_create_ext_req *req,
> +			       const  struct drm_vmw_gb_surface_create_ext_req *req,
>  			       struct drm_vmw_gb_surface_create_rep *rep,
>  			       struct drm_file *file_priv);
>  static int
> @@ -1503,7 +1503,7 @@ int vmw_gb_surface_reference_ext_ioctl(struct drm_device *dev, void *data,
>   */
>  static int
>  vmw_gb_surface_define_internal(struct drm_device *dev,
> -			       struct drm_vmw_gb_surface_create_ext_req *req,
> +			       const  struct drm_vmw_gb_surface_create_ext_req *req,
>  			       struct drm_vmw_gb_surface_create_rep *rep,
>  			       struct drm_file *file_priv)
>  {
> @@ -1521,9 +1521,21 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
>  				req->base.svga3d_flags);
>  
>  	/* array_size must be null for non-GL3 host. */
> -	if (req->base.array_size > 0 && !has_sm4_context(dev_priv)) {
> -		VMW_DEBUG_USER("SM4 surface not supported.\n");
> -		return -EINVAL;
> +	if (req->base.array_size > 0) {
> +		if (has_sm5_context(dev_priv)) {
> +			if (req->base.array_size > SVGA3D_SM5_MAX_SURFACE_ARRAYSIZE) {
> +				VMW_DEBUG_USER("Invalid Surface Array Size.\n");
> +				return -EINVAL;
> +			}
> +		} else if (has_sm4_context(dev_priv)) {
> +			if (req->base.array_size > SVGA3D_SM4_MAX_SURFACE_ARRAYSIZE) {
> +				VMW_DEBUG_USER("Invalid Surface Array Size.\n");
> +				return -EINVAL;
> +			}
> +		} else {
> +			VMW_DEBUG_USER("SM4+ surface not supported.\n");
> +			return -EINVAL;
> +		}
>  	}
>  
>  	if (!has_sm4_1_context(dev_priv)) {

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
