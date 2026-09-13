Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1304C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 23:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6BAA10E343;
	Sun, 13 Sep 2026 23:38:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H9jOcCnB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5547C10E343
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:38:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00D9A43972;
 Sun, 13 Sep 2026 23:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C2C1F000FF;
 Sun, 13 Sep 2026 23:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789342723;
 bh=Z9ofMVE+Mb6inv/8TcNJc3FIs/P7U2fWQrD7C4n/uNI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H9jOcCnBM+XFHc5xMz+52LLNSzU1ty/KJ9EX3iJ7t6ZgXOUJhxisF+VtdTVfWI/bO
 43MLCQwGYxXfzkW/WP3IaPm9Rkob8bUJpPrrIVfKzXFgJCcr1KhT1rx0/57GcmRe5r
 Yu561m0xLDv5e7dhU1IpxEUQb4L6UOG6M4nRk7aVg7gNzidsoNbBYw17z+bNfMWc/2
 /7CfxMprpzYvQOafcQhoWXTxVkQbucQ5XSLMLAAMbymrAJMsWPtAF3fntseI4gdnfz
 uBwU6KTjortpupalBq03e4+S/73NlHzEiVupOJBAk96YME1zG2XeuKIGmY2HGMsBqa
 uNQLXLATzZ3yA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/mdp5: drop cursor pipe for msm8x76
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914-mdp5-fix-cursor-v1-1-9fba3ace6cb9@oss.qualcomm.com>
References: <20260914-mdp5-fix-cursor-v1-1-9fba3ace6cb9@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 23:38:43 +0000
Message-Id: <20260913233843.B7C2C1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing `flush_hw_mask` update when converting to legacy LM cursor=
 breaks cursor updates.
--

commit e1dbf3d7b78aa6bf44fff588ff9b069eceea7f6b
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/mdp5: drop cursor pipe for msm8x76

This commit removes the separate cursor plane configuration for MSM8976/56
platforms. It drops the erroneously added pipe configuration to let the LM
block provide a legacy cursor instead.

> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/m=
sm/disp/mdp5/mdp5_cfg.c
> index 7c91fc1915f39..389d74ff75163 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> @@ -698,15 +698,6 @@ static const struct mdp5_cfg_hw msm8x76_config =3D {
>  			MDP_PIPE_CAP_SW_PIX_EXT	|
>  			0,
>  	},
> -	.pipe_cursor =3D {
> -		.count =3D 1,
> -		.base =3D { 0x440DC },
> -		.caps =3D MDP_PIPE_CAP_HFLIP	|
> -			MDP_PIPE_CAP_VFLIP	|
> -			MDP_PIPE_CAP_SW_PIX_EXT	|
> -			MDP_PIPE_CAP_CURSOR	|
> -			0,
> -	},

[Severity: High]
Since this drops the cursor pipe to rely on the legacy LM cursor, does the
ctl.flush_hw_mask in msm8x76_config also need to be updated?

Currently, flush_hw_mask is set to 0xffffffff for this platform. When
standalone cursor updates use MDP5_CTL_FLUSH_CURSOR_0, fix_sw_flush() in
mdp5_ctl.c translates this to an LM flush for legacy cursors. However, this
fallback is only triggered if BIT_NEEDS_SW_FIX() determines the cursor flush
bit is excluded from the platform's flush_hw_mask.

Because the cursor bit is still included in the 0xffffffff mask, the
software fix evaluates to false. This prevents the LM from being flushed
and sends a hardware flush for a non-existent cursor block, which can
cause the cursor to lag or freeze during standalone updates.

Should flush_hw_mask be updated to exclude the cursor flush bits (for
example, 0xffffffff & ~MDP5_CTL_FLUSH_CURSOR_0)?

>  	.lm =3D {
>  		.count =3D 2,
>  		.base =3D { 0x44000, 0x45000 },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-mdp5-fix-c=
ursor-v1-1-9fba3ace6cb9@oss.qualcomm.com?part=3D1
