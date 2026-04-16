Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E732F8809B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C477210E820;
	Thu, 16 Apr 2026 07:14:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="XxsFd09V";
	dkim-atps=neutral
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com
 [209.85.218.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E4D10E820
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:14:55 +0000 (UTC)
Received: by mail-ej1-f74.google.com with SMTP id
 a640c23a62f3a-b9c4d923668so545342166b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1776323694; x=1776928494;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=PL0zxWT9yr8avn3NY1DoBsUP7UaDGDNRZMMzAWVPz+4=;
 b=XxsFd09VPvYzEwUV93//XWBGYip+4FeFv+V2S3fol0ptmLd9rrzhJd9lsMXljaLBAE
 VCLi5b1JnrgF7Rd8KiD4YI07fFbbVYcNXlE/KxWWnyP9s++wHU+6MAy7E+SGU2WFYEkL
 p1fLDYnbQq2tTwS5CKBTZF4mmYLPFIg6xafWmOTiP5BEOlAsq6WFm9l5Bb9SJIfbNfrA
 iUtn9Ui8psL9XwGQtALciyT7kRMBFD1eEB5Kuf8MVYcVx9atEt3B/DDkp0tiOd0SLJDZ
 HXZOlQ0axf3Y78aJLL2LYv2XFW2fsVceNgvOGHbrefgwkNPEPsCKLJM3SCGDT+soy3Uw
 bmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776323694; x=1776928494;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PL0zxWT9yr8avn3NY1DoBsUP7UaDGDNRZMMzAWVPz+4=;
 b=SgAL9I8PofSvXnZt9UjK2ndvjY9yW8T7/71lCsZWOeDF2NFi9D9ZhIGwftoLtFCdSK
 txrCMqcE4nGJmBPGcb0ysxwmZqaUKTbTmP+G/g1VIkyUPPA7JDuZhE4uxkKMubeuKKJL
 zDy/Qv3Knv5VLHy+e2WJPl9U9R/yFG0qHn8MdB12DpTu3tqshGxxSlyG337G3Kcp/4Hs
 b4GQ/TwTtiJCYSc1Xv97lIUCZhxoJq6dA6TOFqc9hA54+zISlFcu+3O0t79P3T3rsHdm
 Hl93x9o/nCvutGCBcC31LTWJXAwMuHflsEFqsfgdYA6UcjzN1CFff1OlOV/vuMNPNguJ
 fThA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9TGyTdgmHxlWHDq3pjEqVhCmlDyGQM5I2kcn6hkXqgCASTFi02zt4RsxY1qq1ziTu39pXWtuYpcmI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBvxFFC237geQpsTComBsEX9dFmSytZLJ2sBEH9KOUpZ4tQa4T
 9ARRuKEi/+DvisxZ7aVzCXYVqAbJv14VDZLcUSN6SsF4tKAeUMbvqzVy0K5kk4X7wULJfiHDxMX
 JLsGGvQEhEEbVbKhMlA==
X-Received: from ejccs20.prod.google.com ([2002:a17:906:dc94:b0:b96:682e:377b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:8b98:b0:b9c:a70c:d30b with SMTP id
 a640c23a62f3a-b9d727931camr1261267566b.19.1776323693818; 
 Thu, 16 Apr 2026 00:14:53 -0700 (PDT)
Date: Thu, 16 Apr 2026 07:14:52 +0000
In-Reply-To: <20260415-projection-syntax-rework-v1-5-450723cb3727@garyguo.net>
Mime-Version: 1.0
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <20260415-projection-syntax-rework-v1-5-450723cb3727@garyguo.net>
Message-ID: <aeCMbJoYQBS_I9lK@google.com>
Subject: Re: [PATCH 5/5] rust: ptr: remove implicit index projection syntax
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Alexandre Courbot <acourbot@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Wed, Apr 15, 2026 at 08:57:16PM +0100, Gary Guo wrote:
> All users have been converted to use keyworded index projection syntax to
> explicitly state their intention when doing index projection.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
