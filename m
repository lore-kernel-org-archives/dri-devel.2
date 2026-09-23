Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294DFC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60DF310E13B;
	Wed, 23 Sep 2026 15:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NRFtc8iS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB7E10E13B
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:07:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 73F34600AA;
 Wed, 23 Sep 2026 15:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170D11F000FF;
 Wed, 23 Sep 2026 15:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790176073;
 bh=oQ8G+OQJGrpP6Cfh2RBSwMFv19C/vOZSnijiYACRjXA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NRFtc8iSDTzpO2rZoXVOpgL5/fN8FQzCl6q7VUN5vWgN1mf4W+wdnJ1Ho3+zUruIR
 C8U6/M+5BRSxv8KcIIDKhip1Ljxd0AIl3wbEvEV8iQ5Gan8eRd/O5OWgOYaGS1jdCb
 fWy1API5xpk1zm2df5qOXHwnYIOY+nNPcIKerWmsfmDA6jN2hLMxZhe2TNGURmgwKD
 EaZPAgmyjtPu7sk32kKJ1ZQ2tA+aM6L1WOlO2ZeyO5w5oVZsW2rFRPduOG/owSpQDU
 XGyjzB0diANbUJMzK0Bya6lH2Ld1yj9i+42fNpDKBvKZEDZkhMllKaN6Ll578Z9krZ
 kdh2DkyXQGxIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15 1/2] drm/amdgpu: Use vmemdup_array_user in
 amdgpu_bo_create_list_entry_array
To: "Roman Demidov" <roman.demidov.nn@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260923145453.76114-1-roman.demidov.nn@gmail.com>
References: <20260923145453.76114-1-roman.demidov.nn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:07:52 +0000
Message-Id: <20260923150753.170D11F000FF@smtp.kernel.org>
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
- [Low] build: missing vmemdup_array_user helper
--

commit 4d70c808a81c22c8b9f6c03847fa45f071b2e967
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/amdgpu: Use vmemdup_array_user in amdgpu_bo_create_list_entry_array

This commit replaces kvmalloc_array() + copy_from_user() with
vmemdup_array_user() on the fast path. This aims to shrink the source code
and improve separation between kernel and userspace slabs.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_bo_list.c
> index 15c45b2a39835..b364f3f5fb918 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -223,43 +223,36 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
>  int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>  				      struct drm_amdgpu_bo_list_entry **info_param)
>  {
[ ... ]
>  	/* copy the handle array from userspace to a kernel buffer */
> -	r =3D -EFAULT;
> -	if (likely(info_size =3D=3D in->bo_info_size)) {
> -		unsigned long bytes =3D in->bo_number *
> -			in->bo_info_size;
> -
> -		if (copy_from_user(info, uptr, bytes))
> -			goto error_free;
> -
> +	if (likely(info_size =3D=3D bo_info_size)) {
> +		info =3D vmemdup_array_user(uptr, bo_number, info_size);

[Severity: Low]
Does this code call a function vmemdup_array_user() that does not exist in
this kernel tree?

When compiling drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c with
CONFIG_DRM_AMDGPU=3Dy or m, this will result in a build failure due to an
implicit function declaration in amdgpu_bo_create_list_entry_array(). If the
compiler allows implicit declarations, it would assume a 32-bit int return
type, which truncates the pointer on 64-bit systems and can lead to an
invalid pointer dereference or use-after-free when IS_ERR(info) or
kvfree(info) is called later.

> +		if (IS_ERR(info))
> +			return PTR_ERR(info);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923145453.7611=
4-1-roman.demidov.nn@gmail.com?part=3D1
