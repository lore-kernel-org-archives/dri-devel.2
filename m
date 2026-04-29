Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F95FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9330910EEB5;
	Wed, 29 Apr 2026 08:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="cKIsv7RM";
	dkim-atps=neutral
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD81210EEB5
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:20:52 +0000 (UTC)
Received: by mail-wr1-f73.google.com with SMTP id
 ffacd0b85a97d-43d03065782so7904421f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777450851; x=1778055651;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=bluhmjXcTfIn97yUd3T09g1X3EwLW9m0vPzh6yHpaDs=;
 b=cKIsv7RMqjaQjhOlzXXqe2Dw9Hn7FWUDseNdo2qnJNuUmolxQ9WrPjUIW3Bdv1ZHyf
 IGHU2mcs7qe7MfnXXAjAdPkcyKDCfnNyF9irg/6nHIq9u9lSrW1jJhgvZPTkdOvewp+a
 ywyqnLjbzLCYrweNlLmnKpcHNL5BWgCkvOToUjMfHGVIYgwSeoc0uSWntT58OYDW/kbb
 LE4ZKo8aGI/flUb10WQiRUtjXbJF3+zI13x34MLkNfeoGdAYDOxpf3eCmNANiKewis5g
 Of++FoF30+ss3h02JnQ2cC1K3qRMv0li9Y+JpCfMg2QhKXe2LKNmWYMFef3BDiwmj8Oh
 dRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777450851; x=1778055651;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bluhmjXcTfIn97yUd3T09g1X3EwLW9m0vPzh6yHpaDs=;
 b=nZ2K78hxTYaeyUOyxW3IpohAfd0+tHvsLEoGi/fNVPlAqaZH5XqdLYkwfDxxlHQmRa
 prpxP61JHQO9GmB3DuzOIKtAyT5jiGw+VQE3o8ytTOcCarLAYG6lhysAnGH/n+PjcNem
 24YEI6EQEMX3ysA8QYs8iihZ5KRFIxFndzSUiki8Q8RU08zWLfjI5BE4rhJsn+oqvnOj
 ChNeZ9ZR9lJMaoks7LLiHE8I22gzYbtqdtGkjlAyDW7A32bdl/Q11npDiRWnQbGm1k3U
 sSGhVZL4/n8E1fGz6cfVL86Nt4JPTWdUmtQURxEOAo6FpzvZ5IqhPwS4Czl2V7P4d4d+
 OnoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dV7c5mn15ywDt5PlMIO55ahfhWm+WdLuPHG1dSveMmV/g0uaKVyBZvinUCuVQXCO7OVndb0BMWEk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyH2QmQLtpJN0YsmAKeTY5cyFySdChWFbjU/MqYWpSnNdugm0Ko
 XukK8NVKMgxEgWty2hAHv7pO7OlJevPPkTv4/AZJ8lCJzq0RxTrHIYiib31qU7BuIXIjV6GX4O7
 xHNwbtUVVIx7TtcCtGg==
X-Received: from wrrm1.prod.google.com ([2002:adf:fa01:0:b0:445:168d:28e9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d11:0:b0:43e:b0f7:9ce9 with SMTP id
 ffacd0b85a97d-44647dd17c1mr11460659f8f.14.1777450851050; 
 Wed, 29 Apr 2026 01:20:51 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:20:50 +0000
In-Reply-To: <20260429-fix-drm-device-comment-v1-1-d8876b44d688@gmail.com>
Mime-Version: 1.0
References: <20260429-fix-drm-device-comment-v1-1-d8876b44d688@gmail.com>
Message-ID: <afG_YvuNAk26YLnV@google.com>
Subject: Re: [PATCH] rust: drm: fix incorrect type name in `Device` doc comment
From: Alice Ryhl <aliceryhl@google.com>
To: Hsiu Che Yu <yu.whisper.personal@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Maxime Ripard <mripard@kernel.org>, Asahi Lina <lina+kernel@asahilina.net>, 
 Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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

On Wed, Apr 29, 2026 at 01:08:14PM +0800, Hsiu Che Yu wrote:
> The invariant documentation incorrectly referenced `struct device`
> instead of `struct drm_device`. Fix it.
> 
> Fixes: 1e4b8896c0f3c ("rust: drm: add device abstraction")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hsiu Che Yu <yu.whisper.personal@gmail.com>

LGTM
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
