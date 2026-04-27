Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A76DFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038F210E8D8;
	Mon, 27 Apr 2026 18:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="lKvXqjyZ";
	dkim-atps=neutral
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA06910E8D8
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:46:42 +0000 (UTC)
Received: by mail-wr1-f73.google.com with SMTP id
 ffacd0b85a97d-43ff0eb2b2aso7808280f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 11:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777315601; x=1777920401;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=schKK6eemA/etdLN7SA+QtE76XJ0JVRvUkLlJGOyRrQ=;
 b=lKvXqjyZ1+2ZP4dWKOgNLR3L8cTk4SqK6OA1NPzw/D1DcnBkfhclC1WI4XclkqOZDW
 WdaTSAsWPdbEvpCyuBZgjDDzbUYk0wACwIDRltO6BhZWrw1tiJbJd/TlbxSnToJSyMZ1
 BbO2Wxb4axJJQ9H5dfeFImwCC8iIpW3T3jh17c1FhDIGLsi0ZSV9fiqPNODOgSsrg37X
 vDe/jJaVgv0Qp0pwFmpw355Vfql7KhvpKSQ4h3F1ghBzYQ79yQR9VzdvG/4VMJ/mzpjj
 vhLERhiHGN8Pa3DnaqTQ9k3umXqYntL17J+QLLKw0dER6y67t77KkIxlmU41Pt1pL6hH
 c6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777315601; x=1777920401;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=schKK6eemA/etdLN7SA+QtE76XJ0JVRvUkLlJGOyRrQ=;
 b=pHSHi+8fsvoHwr8hBQlznT7qFqQCZ0PfoujNmu3x9zwW4Byo/WFITtNgmqglm5tHHY
 5SpvqaOLHBvluch0JrnJeC6RHNp5HWPfD1Lvkzf2eyfJLCzEkNBulNczZlRD5SwVQnAB
 oFwKjPTuCO4UQDWnzYXol2BP3NLE1foCsgSCSgyyvm6GYJbZ8UBrDJbvV2eNR+7+Cf90
 2yKmvfhZB0Venkg76+RN+jJNGb0DufvX8oNqT3TDQ3pAhg2Yd7pBgTNcTWzwnP1b+4AM
 VP4bAokLSjptCiKm39cCAAGv31xTvJFEzMlgO63rH16qKssLsh2VDHyWVqqXPikOMUou
 MZZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kANcfQW6n8RNfGJi4HvGOuu0dxn7CFiVBl56qTXIAcxmAX3Lbwtti+iV5K9wN9OBbxZE0II0RPAA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybxrD9oPlSBrOCnTS8K4fXCLScGyz6Q/eMsKKoZGrvecal/+Ab
 gSis7Zz/8+SjnuuDTqqoYWBEB0gR8W3gJ0p7II5TvM7VS+0KA1bv4r1y7PnOjK2Hxs94D6m5Xhk
 wQGJhOdLXJkTmuFmVSQ==
X-Received: from wrh14.prod.google.com ([2002:a5d:5a0e:0:b0:445:168d:28e9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2287:b0:43f:e22e:e8da with SMTP id
 ffacd0b85a97d-4464761c4f8mr124941f8f.5.1777315601387; 
 Mon, 27 Apr 2026 11:46:41 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:46:40 +0000
In-Reply-To: <20260423-fix-filter-v1-1-b3b197c65daf@nvidia.com>
Mime-Version: 1.0
References: <20260423-fix-filter-v1-1-b3b197c65daf@nvidia.com>
Message-ID: <ae-vEDyPvUqPRmiQ@google.com>
Subject: Re: [PATCH] gpu: nova-core: simplify and_then with condition to filter
From: Alice Ryhl <aliceryhl@google.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Thu, Apr 23, 2026 at 04:11:44PM +0900, Eliot Courtney wrote:
> This code is more simply expressed using Option::filter instead of the
> and_then with conditional.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Applied to drm-rust, thanks!

I modified the commit message to quote the clippy warning fixed by this
commit and added Fixes:/Cc: stable tags.

Alice
