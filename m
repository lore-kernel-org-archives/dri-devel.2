Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB8CC44507
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 18:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 192AC10E0A8;
	Tue, 14 Jul 2026 18:21:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="GbV8WE14";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C0010E578
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 18:21:50 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2cea3004256so45672335ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 11:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784053310; cv=none;
 d=google.com; s=arc-20260327;
 b=W5vmO1tPlhgf7OPBPcQvjm2fPJlL49yaqCM6nfXN4q3OBREF44zLTLW25fdYGz1Iqt
 gaOF9J8GOC1MndfwPEGe55xQ+VJyQW5ijfxgNdNllSPnzQoey1nag2IM8TYkFA/gqZER
 /07izrVjwNuafCe/OG8+6U/RzgUxaTy4fvzv/y4n7MVSFCHr/5/lCw5Rhe9UaEiDVqjX
 6K5qqPzF+rWaVWpJpszHMNVVo6NiyQtXidSvtLOjfUJa4rfNbYDWRDMsNbinw6WXkt6l
 aOdRvufftdO5pv2NweIKEq64vkX1oADCvSZtlwEk4suO1qC86mYHtTOlZCL+WTApN8e6
 /IGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FXnfENBOyCD4/NTRzFTKvpp5LaBqEwlidKR5Zh8lHlk=;
 fh=yNgpb4JmYxaJ0Bd0MKzd82U3p1Wm73oRcIJhItq4mTg=;
 b=qRbj22IjEHk/JjXADjAhXAePA/TMJ2rAYXd4jFD7q2xJRkPmWNtQ2CP7ieBeI2YOrw
 34FKdkpGFTrKhvZb7CSIR7TFuBbf7z4KMHfRnmGVpXkoDDuQEIAkKhvfSnBcOSHTa+0P
 Y+0HBIvWzyXYTUSGxetGblcxU53O455y/38LUtKaM8SlzdP7GWavCd9fwqSZWB/yBBuR
 hVai0b42kA9ku+NgHw0HU2WKnVPbb1ZvRZA4bm3UJWlaBNrSrT4UKpJyR/zm/NaFB0iu
 tiZPuoVf7DOUC+LgDnfWV2u908mtfP8TjifFqOKdNtbER00EmRimWKgzCZKEqxodoyWQ
 RqmA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1784053310; x=1784658110;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FXnfENBOyCD4/NTRzFTKvpp5LaBqEwlidKR5Zh8lHlk=;
 b=GbV8WE144ybcH867cWFDKFJrm5dja+Y+TDBDrLkZKaSV4Y7e/5ylYxnep0HY1kSOK5
 AMnNbEpuAb3ONPNyjxwUB9fqsNuoGcGp6nEi28qGm/L07rZKl8OqMn+I7bslO/W2O+n2
 DIRzhlok1LiP1BOe9+psIQEFMByipscU3Ge1vqMiLEY7Tx0m7UCPOv5MrvS9WGPapIWy
 ePQpwDFbloUmn3vFknTzflfY+I39o6dgyte9JuTII6/FjO7Uxzz38ZCFqORrLITdOwjI
 L6ahSbH9jPiMK8DfzBR4FJSQRkpzk9zt32yMKpPfNDORANKc0/sTqdpSj2mqdd1ycAID
 KFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784053310; x=1784658110;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FXnfENBOyCD4/NTRzFTKvpp5LaBqEwlidKR5Zh8lHlk=;
 b=LZajNaOeGt65ELb5DvPFknfkRyRoWXg4Y3/W56UcGNKlJxqCHjlhjL4cbIDg3CGyty
 XbTnb2CY/hW7+w8Ja+YQrft6Wkn2MBYRJ3RFiAJOlwWQPQ/l51iXeLmahDpGHGZ1pZXT
 oq6/lgLywhtBEczDR9Opjh8JDAfd69Q4718nt8x9eg5vt6bAodqknffP36cYHNcht6S3
 LG4yWCSEB5UamdlK87lt4vVWFweAN5pCuZlrVQeYNefzd4xsQqkxTp53EVF9HqenFamW
 GZ/LGAkjfPQPwIHii3uX9I/cKjQNzfEssv3wsZPWdyB18c8zCJmCqIJPnO94LGY95XUd
 G87A==
X-Gm-Message-State: AOJu0YzJbDAnlRh7UCvdVwesQMwaRej9j1d32AKRg7uuac32xxA2vdh1
 I99zpLx023dlYh4cl7zgBzJsrSYPkZCd2MKwzJO3IY+rt/0wURNeWkJCfbOeTPhanHeQjcY86h6
 H4fV35z4qSytSfmfJbSrfIC2l8YydeK1zmDYCMyZdAw==
X-Gm-Gg: AfdE7clkleKbnGQcXwFiQnDxni2VrBJu2IshbVFWRtH27vQ8jgbUExdelmS8b56fnyL
 klR4EW1dyJA7ZFX8/qYza0GDfvTpr+NOt2iVqO7g1XkP3IHS+sBm3+ksZtnV/R6SojWdsv5LgoC
 hg+QA8VrM45Z2z7UbQnpuuCA1Y/759pyEJeasGcOGgcxi1SimtJO+8YpmF+YGkC9VW0W+aNgecY
 pBUiSRZ14aP+mxekVrGJoRLCaSg2JEb8+snHHhT4LIuMJ/VRKZf642BSLdWP/j/o/ns99R/
X-Received: by 2002:a17:902:d4c2:b0:2cc:96ab:9798 with SMTP id
 d9443c01a7336-2cef143afe2mr35286185ad.28.1784053309628; Tue, 14 Jul 2026
 11:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260526181700.25310-1-leandro.ribeiro@collabora.com>
In-Reply-To: <20260526181700.25310-1-leandro.ribeiro@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 14 Jul 2026 19:21:38 +0100
X-Gm-Features: AUfX_mxuZ3vb_HZYFSpfP_MzhtfakRcLJkAHcxNeLNxL8yn4dCSfpAByyI-VGhg
Message-ID: <CAPj87rMYpXsxO1D2w_zv-RTw-WdtBHPYhdSTQN7rY+uMndFDsA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] drm/drm_blend: allow blend mode property without
 PREMULTI
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com, daniels@collabora.com, 
 jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch, 
 tzimmermann@suse.de, ville.syrjala@linux.intel.com, 
 linux-kernel@vger.kernel.org
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

Hi Leandro,

On Tue, 26 May 2026 at 19:17, Leandro Ribeiro
<leandro.ribeiro@collabora.com> wrote:
> Some hardware only supports the COVERAGE blend mode and lacks PREMULTI
> support entirely. DRM currently requires that PREMULTI is present when
> creating a blend mode property, which prevents such drivers from being
> properly upstreamed.
>
> This series removes this restriction and allows drivers to create a blend
> mode property without PREMULTI.
>
> On Weston (userspace), we are working [1] towards adding support for
> this kind of hardware.
>
> [1] https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2046

The series, and the Weston MR, are also:
Reviewed-by: Daniel Stone <daniels@collabora.com>

Thanks!
