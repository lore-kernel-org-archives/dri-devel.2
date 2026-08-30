Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C4EC61DB9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 11:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3BA310E0DE;
	Sun, 30 Aug 2026 11:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WItnuxLa";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5234F10E0DE
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 11:43:41 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso16707975e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 04:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788090219; x=1788695019; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WlfkYyar9vumibw7mRgIAgoFjQzAhszDTK4deysoT4I=;
 b=WItnuxLa5OnxSlnb21pnzRGoPCotx/1FeSf4Py8uBXAG8r/r4bwu9EWtszaIBUXiBC
 eun9wS3tsD+QMXhuDPn9A6m2FuCmYUW82UFc9Q3bLAJGE+MCTFHXpugSBB+juRZWZ1T2
 4F6orjb1cHqvfUoV3RfGzTu9e5ZTnyNG8NgBmlR9Im2PAlLRzbo+TQ41JudbLb/WsnHz
 H9xEq5+RgpubPZ3h5Zwgpf2loxWoQWW6kUFS9+6aTOYE3QOhRN+XGBQ9m7Ns0FIP89FI
 z4gLi6GpOi+fShY9yOmVsmj7PLOux/3JqyO4mNcG08IC5Llo/wkkiTzoHpPg0TpT4xqa
 YdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788090219; x=1788695019;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WlfkYyar9vumibw7mRgIAgoFjQzAhszDTK4deysoT4I=;
 b=fsKUckJfG6Ir4mplD6ep7Thg1CdgBND9u1/gEoaWWosN04wf8JoNdjEpjat/GqCer6
 MPVn5NlK1fdZYObHPoj3G/jQL9iaXK3wk3JNZkNqNtyzIWsjYpSKbp7HFQO+Zb8eaMEL
 InxnstwIyZA5QevvbCReA74Mh88MpL9C14DmIDFx/32h3WVtobfB2GVXMOqOR7z7Heds
 tps/qa37u2TZdbn4782UZf9NXE/exi0cHT6imRX6RCdjwWIo0nLnzrYQXzpd36+4h79R
 HJyxOwKC6HJvnmMnS93f5emgSha3bjEbPRdrNh+sX49U0Lrse2SihbnjxbUAytWopLvP
 1XEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRLAC9jU95sBCh7inMZadYfHvBOxtexvtRQerx5zNZUTbZ7TBBYnQ0aeYuxKPn9QsehB5WTn0YEmY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mDDBUu1oVQsauErIHwgOmf4wOT8n9VJH7Yddd3v516u0RubWzH
 IT2Q1v6s7UqKDgB7ttL0xW/N6WCOWiTXQ4t/9lXNvr47tKyJIcUievL2
X-Gm-Gg: AR+sD13cVmh+IfyIFQfSDxW1QEsnc3IDo/XStIdZ/bnDSqZYK1Gor0+eNLFJQaJM2pB
 2J+Id+6vKHL5SOh1gHFW4+GauQeR2KbGJ8IytbcQjIe+xX4pWhjq+0yfNYOtoIofixMZEwDMb5M
 k6dbe7n2iraJwPSRMzP3P38b0193XsxWMECW7hzECTaavLjxUIEWzGoXNFXJIzj2I5n/RbN0ig0
 e+9vKV4bNI3P48YG/xCa73O60UHWrglAm4E73LlJgQWCgEYIkHdeZhK51u6DpTC8hhYyCrfN/Rm
 O51iM2JgjPyzeybx2/Z2dJW/xzKj9mZwkV3Vv9Wx7wJ9Szz/WX2Ci46sITM0kGFuQqq8Ml2RIQ5
 6aqcs/VCqW/LFWHo4lSiS5tccz80lilLBwKp3TO7aID2zxFM5JPrOFAbxBg0tKGN7Yq8ctkGCv5
 9IuVeAFb5LTsVcm7SERCHM/E8gH6ac18ilw5mcleoxj59V5w3CR14xCqm15m7f++AwhyRaTqhVi
 9h6MB1XxKH1XgL1SkNKkJy8X7OwpMfU8FS8
X-Received: by 2002:a05:600c:a016:b0:49c:d60c:74e0 with SMTP id
 5b1f17b1804b1-49cd60c74eemr23912455e9.13.1788090219141; 
 Sun, 30 Aug 2026 04:43:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dc1076sm195266535e9.3.2026.08.30.04.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 04:43:38 -0700 (PDT)
Date: Sun, 30 Aug 2026 12:43:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Gow <david@davidgow.net>
Cc: Jim Cromie <jim.cromie@gmail.com>, "Maciej W . Rozycki"
 <macro@orcam.me.uk>, Andrew Morton <akpm@linux-foundation.org>, Matthew
 Auld <matthew.auld@intel.com>, Arun Pravin
 <arunpravin.paneerselvam@amd.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Chris
 Mason <mason@kernel.org>, David Sterba <dsterba@suse.com>,
 dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] linux/log2.h: Add 64-bit safe variants of
 power-of-two functions
Message-ID: <20260830124334.105b84b1@pumpkin>
In-Reply-To: <20260830103321.2042968-1-david@davidgow.net>
References: <20260830103321.2042968-1-david@davidgow.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 30 Aug 2026 18:33:15 +0800
David Gow <david@davidgow.net> wrote:

> The existing roundup_pow_of_two() and rounddown_pow_of_two() functions work
> on values of type unsigned long, which is 32-bit on 32-bit systems.
> Equally, is_power_of_2() operates on an unsigned long.
> 
> There are several instances where 64-bit safe versions of these (which
> operate on a 64-bit value regardless of sizeof(long)) are required. Most
> particularly, some hardware (especially GPUs) have 64-bit address spaces,
> and some formats (such as filesystems) use 64-bit offsets. Some of these
> (such as i915 and btrfs) have already implemented their own 64-bit
> is_power_of_2() helpers.
> 
> Add a version of these which always operate on a 64-bit value. These have
> the (unimaginative) names:
> - is_power_of_2_u64()
> - roundup_pow_of_two_u64(), and
> - rounddown_pow_of_two_u64()
> and otherwise work identically to their unsigned long counterparts.

Why not just change the definitions (back?) to #defines.
Then they can be size neutral and you don't have to guess the correct one.

You may need to use __builtin_constant_p(x <= ~0u) to select between 32 and
64 bit versions.

It is also worth checking what gcc/clang generate for the 64bit versions
on 32bit when passed a 32bit variable.
It might be that they optimise the code and avoid all the 64bit maths.

David

> 
> To avoid conflicts, the i915 implementation is also removed here. The btrfs
> one (which has a different name) is replaced in a separate patch.
> 
> Signed-off-by: David Gow <david@davidgow.net>
> ---
> 
> This patch adds u64 helpers, and the following two use them. And v2 also
> has the i915 change to remove the conflicting implementation.
> 
> So I'm not sure who best wants to take these. Ultimately it's an include/linux
> change, but it touches i915, patch 2 touches GPU/DRM, and patch 3 btrfs.
> Personally, I'm keen to get patch 2 in, as it fixes a real issue, so if taking
> 1 and 2 via DRM makes more sense, that's fine by me.
> 
> Changes since v1:
> https://lore.kernel.org/all/20260821091918.1902032-1-david@ingeniumdigital.com/
> - Include is_power_of_2_u64() as well, and remove the i915 version
>   (Thanks, Matthew)
> - Use _u64 as a suffix for the 64-bit versions, not just 64
>   (This is a much nicer name, and matches what everone else was doing)
> - Fix some comment typos.
> - Add a third patch which removes a similar is_power_of_two_u64() helper
>   from btrfs.
> 
> ---
>  drivers/gpu/drm/i915/i915_utils.h |  5 ---
>  include/linux/log2.h              | 73 +++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
> index ecc20e0528f4..1cec51984d8c 100644
> --- a/drivers/gpu/drm/i915/i915_utils.h
> +++ b/drivers/gpu/drm/i915/i915_utils.h
> @@ -75,11 +75,6 @@ struct drm_i915_private;
>  	__idx;								\
>  })
>  
> -static inline bool is_power_of_2_u64(u64 n)
> -{
> -	return (n != 0 && ((n & (n - 1)) == 0));
> -}
> -
>  void add_taint_for_CI(struct drm_i915_private *i915, unsigned int taint);
>  static inline void __add_taint_for_CI(unsigned int taint)
>  {
> diff --git a/include/linux/log2.h b/include/linux/log2.h
> index e17ceb32e0c9..fc44e59f5732 100644
> --- a/include/linux/log2.h
> +++ b/include/linux/log2.h
> @@ -47,6 +47,22 @@ bool is_power_of_2(unsigned long n)
>  	return n - 1 < (n ^ (n - 1));
>  }
>  
> +/**
> + * is_power_of_2_u64() - check if a 64-bit value is a power of two
> + * @n: the value to check
> + *
> + * Determine whether some value is a power of two, where zero is
> + * *not* considered a power of two. Unlike is_power_of_2, this version
> + * always operates on 64-bit values, even on 32-bit architectures where
> + * long is 32-bit.
> + * Return: true if @n is a power of 2, otherwise false.
> + */
> +static __always_inline __attribute_const__
> +bool is_power_of_2_u64(u64 n)
> +{
> +	return n - 1 < (n ^ (n - 1));
> +}
> +
>  /**
>   * __roundup_pow_of_two() - round up to nearest power of two
>   * @n: value to round up
> @@ -195,6 +211,63 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
>  	__rounddown_pow_of_two(n)		\
>   )
>  
> +/**
> + * __rounddown_pow_of_two_64() - round a 64-bit value down to nearest power of two
> + * @n: value to round down
> + */
> +static inline __attribute_const__
> +u64 __rounddown_pow_of_two_u64(u64 n)
> +{
> +	return 1ULL << ilog2(n);
> +}
> +
> +/**
> + * rounddown_pow_of_two_u64 - round a 64-bit value down to nearest power of two
> + * @n: parameter
> + *
> + * round the given value down to the nearest power of two
> + * - this always operates on 64-bit values, even on 32-bit systems
> + * - the result is undefined when n == 0
> + * - this can be used to initialise global variables from constant data
> + */
> +#define rounddown_pow_of_two_u64(n)		\
> +(						\
> +	__builtin_constant_p(n) ? (		\
> +		((n) == 1) ? 1ULL :		\
> +		(1ULL << ilog2((n)))		\
> +				   ) :		\
> +	__rounddown_pow_of_two_u64(n)		\
> +)
> +
> +
> +/**
> + * __roundup_pow_of_two_u64() - round a 64-bit value up to nearest power of two
> + * @n: value to round up
> + */
> +static inline __attribute_const__
> +u64 __roundup_pow_of_two_u64(u64 n)
> +{
> +	return 1ULL << (ilog2(n - 1) + 1);
> +}
> +
> +/**
> + * roundup_pow_of_two_u64 - round a 64-bit value up to nearest power of two
> + * @n: parameter
> + *
> + * round the given value up to the nearest power of two
> + * - this always operates on 64-bit values, even on 32-bit systems
> + * - the result is undefined when n == 0
> + * - this can be used to initialise global variables from constant data
> + */
> +#define roundup_pow_of_two_u64(n)		\
> +(						\
> +	__builtin_constant_p(n) ? (		\
> +		((n) == 1) ? 1ULL :		\
> +		(1ULL << (ilog2((n) - 1) + 1))	\
> +				   ) :		\
> +	__roundup_pow_of_two_u64(n)		\
> +)
> +
>  static inline __attribute_const__
>  int __order_base_2(unsigned long n)
>  {

