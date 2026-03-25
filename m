Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8C2103A9AD
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 11:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 056C110E7D1;
	Wed, 25 Mar 2026 11:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="kvvAHspv";
	dkim-atps=neutral
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com
 [209.85.208.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725CB10E7D1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 11:44:26 +0000 (UTC)
Received: by mail-ed1-f73.google.com with SMTP id
 4fb4d7f45d1cf-668c932088fso6954047a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 04:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774439065; x=1775043865;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xUNk5DBarhia0VP1Ved6SPUtX2O9K1Wf39PDjoKefxc=;
 b=kvvAHspvHg6SttDRRKuSQJSK69WuFc0BLUiEq2M6neGUGZXQmLRAgukcL/ux5mhUyI
 3uwclg5fWXEo7aoPhBOP3DsOnBZVvHARSJMMNJe+K+RB8ifPbBt22ynUkLluSu5kc8RW
 yHx/7CFO39wisW2+JmNXoCa2MMjOm5lZtx6DVPdc87p3+d4LOSJKGAo7l+L1OntqcnOr
 yfUywMb32m4TVgFAFfF8NCbjaWSHAqjQ9WCB9v3JPcnPJzpwpLvSrKEJTvavqzyVGz0y
 rzgBKW8FGnO2dk2ju/QD8GSPML86KhfQj2CAMPwwL9BpX8vpn8/REMMLGRFMsSFJwI/V
 iAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774439065; x=1775043865;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xUNk5DBarhia0VP1Ved6SPUtX2O9K1Wf39PDjoKefxc=;
 b=GqONyAS93I/jwhTWOKxUZ1pFV7LDP0w/K9PTGMZxD7reOUHMid2OjDKvfzMboEtznB
 btCyyxU0hysE/xcC4971gE9U3oTbBYnkvsaqMm8CuMRlZ6P45W6Gp9Wunk+WE4K+mSAf
 +6qLfb0QZPbjse4Ma1cpFoCe1djwTY2BWQZHh7bIRNnb17+hTTgpftJzNlXiMkIxMYRv
 n+cxyohcs2DoEIi5CI2Xgf+W53wMtu18vE4AKtsGElcdrD28Fwp6/UMOv3BuAvNODYBN
 aeGGTW/DMoEGSX9Awx0ujSA3TDE0vCG24JY64jJnebx0Yo9BYM2yJmoVFpYBkX8qEtHu
 pO5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdvPulgcN6SgayER6c10/SkzaFQjwULuvEtTklsuQP1KhCWtFaDZ2okGxkSmB4TJIIjR8qe8sMhPs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZ6sK330GfYjnz2DxOQLRzEeTMPUZuSrd0rByPi6HikN4UboaP
 Y+mAnapRGrFnlTGpX5c3N66RoLVfUb5q1IZzJYaVFkBdbIbbh66vsIj2ydCaybmzXW3QNtDWd5o
 XavFho4poE+7x8D/Qww==
X-Received: from edgg21.prod.google.com ([2002:a05:6402:1ed5:b0:668:8a5e:6647])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2116:b0:667:7fcb:3a2c with SMTP id
 4fb4d7f45d1cf-66a826b30b2mr2152133a12.24.1774439064945; 
 Wed, 25 Mar 2026 04:44:24 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:44:23 +0000
In-Reply-To: <20260325003921.3420-1-dakr@kernel.org>
Mime-Version: 1.0
References: <20260325003921.3420-1-dakr@kernel.org>
Message-ID: <acPKl5HXwd6e4Sl2@google.com>
Subject: Re: [PATCH 1/3] rust: uaccess: generalize write_dma() to accept any
 Coherent<T>
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, abdiel.janulgue@gmail.com, 
 daniel.almeida@collabora.com, robin.murphy@arm.com, a.hindborg@kernel.org, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu, 
 ttabi@nvidia.com, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

On Wed, Mar 25, 2026 at 01:39:15AM +0100, Danilo Krummrich wrote:
> Generalize write_dma() from &Coherent<[u8]> to &Coherent<T> where
> T: KnownSize + AsBytes + ?Sized. The function body only uses as_ptr()
> and size(), which work for any such T, so there is no reason to
> restrict it to byte slices.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
