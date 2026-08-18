Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345F5C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4098A10E521;
	Wed, 19 Aug 2026 06:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C0RgbAyp";
	dkim-atps=neutral
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A721210EBED
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 16:29:25 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id
 a1e0cc1a2514c-966e7380109so3059373241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787070564; cv=none;
 d=google.com; s=arc-20260327;
 b=MxldRCmwlV9roJwXeQeLtYFaN7imI1Cd4WPqI5q2ExEIzB/5A3hMGzric4hh8emdZK
 9EGHJ7/09WAsOqq2dmUo+uyWmv3Wg7YkaP0Fc/C1w3wOu6BK0Y5kyNEy/w7nVg7VoWMD
 a1ANwvbypKtX3d4+tf8hy36wcdKaYrCT8UFYVfGP2/R7khqE5vBWbSdDFrUyAjYZa4Z3
 f+Yj5+7Zljj22P6ZDC6juAHqdv1PuY+EPE6DeAIpObzGW2/XVqrgDCC7Oj/+lUtMK5LX
 B7Najx7i2q+RodxFg+9rrnlvc5zo48+Cjzxw9dIJTAxnjL6EQJQuThnjgrE5Jy/4AyhV
 8rMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WbLq5KSubTXR3Nv4sQNzeoIw9EVc824Iz7H+0Pk8yZM=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=CaTG5f7uiFSvuGZcqSZ6QM3OfSr7NuhoSQ5xmt/G12/s2G0IhIgM2ZqXygnyEw555i
 qYqYZdHc+hUgdEg9ZTetbaa6d7DElGilFp2RgcBkSLDAacEz+ZcvsBosDt/JCd1phOsZ
 ZZCAS5wrvsKxXgPB4BVkq1GTGKsV3mZ1XbrHUfj5Pt33GOnWljvZIyn9dTIxho19OK7H
 Pd4PYgXVfQqogdmaFpKtnWhxayCS95eroTeDdabzqv4xrzVYjz+eOl09QTqKJAYELSDR
 NSmh+Jju6Rio+4YLVFuJ72VPgGQ/4FXDSZdjl8Y78e69G+YIKPMIDM5il9AJNVB7MWiD
 peng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787070564; x=1787675364; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WbLq5KSubTXR3Nv4sQNzeoIw9EVc824Iz7H+0Pk8yZM=;
 b=C0RgbAypWCVPILMuXOPvCGZTNvwBMh4yoTW0SYEYLtFGy8eHxxv1MbhNHPQ8riYzfM
 aAVpElhZ8qAkvoZHYx6eS+cgK8nXnT7A7NOGdWGxD8ZnBRKaGE1lxYLh5G+Xer82V0y6
 f4YrVY4YTpmQdjzY7LT63oXLW6Cy4N8pukfY9LYuXODDIb9DxPrFIevHxYh94/8Uiz0g
 uw5pyni4ef99YWeirn/oda/NsB9/p4gopdkAjTlPfV3ZZJbIdLJTBOJbWFldFV5t8sJt
 klIKVjWqJrbfXccse+tafhQ1hFRgvvwEcA7w6fAaOzj0rWUrFX6ioUH4biCOmdWAj7QM
 m0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787070564; x=1787675364;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WbLq5KSubTXR3Nv4sQNzeoIw9EVc824Iz7H+0Pk8yZM=;
 b=BhIqk4OjthOyZA4LyGLdCfcE/+UlKqd1ID1PtfXNqj7GMIf9SuAOAgpN19RyuP2NZH
 Nbvk3QvnI1HE5L7sXLoD/HpVus4QPTutGd8k5R/OJ0BTVHnxKhgfCUhaRUJtlG7YWYfb
 ReXq+CuxiGOC53Cwdtrp2OOCJ1/xeN3PffnrFFNjVnTqSYT7oV0Rm/760GP+SFxGZ70E
 QD7KKAk/pxvzaW6HYUQ1mVE7ggA/l2xL+2Y0fAW9beQZpMqElUnyTgTC2LDM8J0GN+zZ
 nC6l5uS2F3DLhc22awuyOsoYjUhii14v7WZGt+UVDW02/I+qYal3EIUT6gjLuqfp5S+k
 wWnA==
X-Gm-Message-State: AOJu0YwjafT/acTa0Fn4f2Qj/eN0tsUFlm1q6Tp3M7xi03N5tov6tGAi
 R9O7bfizu8xE+LXggdpYllYApxRZ3N8Rgoc2q+UgwczHKabv3RS4urlnOgTwfrtZC54bvLZNfil
 n66BSW/XGlCE7QiUQKES8ko8RsONTnQY=
X-Gm-Gg: AR+sD11VJGVOaWQzVoCi2Z31Rd4cNgxNWqghi4MXGisvggfR/OvB4zzJf12atVJv9Y5
 3bPhqogKkhNlcNELj1q2B9RsDCCLiAAtRW87u7kFTFBFHddOAVLjR5fJ+iX1yfqHT9H2/VJd0pk
 9wnjzlydIhqIPM/n2FI8zwOAVXxaS69tPqMIJUqgtzXQ9eRNPxUY+RJedSfRIeZy896Kq9d1yNV
 f5rkIVs7z0r0VrSlNxRT/JTUQ+7zrCl8ItLJSRHKaI6IZnYtXeGCUKcZ8w/WC8HTU2uK/bAh+Sq
 72Jjnn5nxZzlL5cBuuOfrHrVbXBRbw8/oxh5KILTmfdj
X-Received: by 2002:a05:6102:512a:b0:76b:12e9:a443 with SMTP id
 ada2fe7eead31-76f2c43cbd6mr8049856137.9.1787070564183; Tue, 18 Aug 2026
 09:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260818160914.108313-1-seanwascoding@gmail.com>
 <20260818160914.108313-2-seanwascoding@gmail.com>
 <20260818161335.A761D1F000E9@smtp.kernel.org>
In-Reply-To: <20260818161335.A761D1F000E9@smtp.kernel.org>
From: Sean Chang <seanwascoding@gmail.com>
Date: Wed, 19 Aug 2026 00:29:13 +0800
X-Gm-Features: AcwNN1W-gOFcNNm6dBJE2Sjxmz20SbB5OE2mGe7N_yx2yNmOo_ToxIK5uhgNFD4
Message-ID: <CAAb=EJXmUNPB2d0qeqLqvd6jmAMWsZ1nRHjaNMMUGqQLD0avXg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/ttm: drop stale @ctx kernel-doc entry
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

On Wed, Aug 19, 2026 at 12:13=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> > ttm_bo_alloc_state no longer has a ctx member, but its kernel-doc
> > comment still documents @ctx. Remove the stale entry so the
> > documentation matches the struct.
>
> [Severity: Low]
> This isn't a bug, but is this description accurate?
>
> The commit message states the documentation for struct ttm_bo_alloc_state
> is being fixed, but the modified kernel-doc block actually documents the
> function ttm_bo_alloc_at_place().
>
> It appears the diff chunk header below mistakenly picked up the struct
> definition from earlier in the file, which may have caused the confusion.
>

Yeah, I type the wrong function name, fixing that in the
next v2 patch.

Best Regard,
Sean
