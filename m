Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C3AC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C9110F8CF;
	Fri, 10 Jul 2026 13:23:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="TSW/mAFE";
	dkim-atps=neutral
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA2B210E1B2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 13:23:04 +0000 (UTC)
Received: by mail-wr1-f73.google.com with SMTP id
 ffacd0b85a97d-476d52b13d7so966273f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783689783; x=1784294583;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mhnEx/JJSQzYJbs5L6qf8iYhYeJFg/o22+QpnDmEIIs=;
 b=TSW/mAFEQmSBKKS74wA7+PCSGZGmbZkFyGQHaEAPP+eYTlA0mP43g11GRVhIUoomXW
 uGXZ5TsrZW/MlGSp2DlLLP3IDDWKrCrvXHZhbdkoZqiuinqDEmvJCaukvyKrBeADJe6i
 H0glBP7LNq8XUFmKlF5RRUmRj0ntq2DE07auiVhiwBKHOhCaWNla4emhArMq/1LPXKPw
 olhxQOTIovUC/I7VJ7hBkK6Ll/4TO2JKMLHw9yL+uYCA94LA5vANl0OgkMHayFcexi6h
 0XeF7KnTIQVEhARjzdXILf9t/n3eBKN3iJTcrcNFmBYytp9dT+c7LF/x9Zr3sgBC3pOP
 kd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783689783; x=1784294583;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mhnEx/JJSQzYJbs5L6qf8iYhYeJFg/o22+QpnDmEIIs=;
 b=KjdmxsXfk1KJ2xQTqMry1GAfXs5Wx/e3nKgs1UkHgeahHA2BRcZr21vRcT3ByWa+p1
 zyvuaTfcyaZCWn8/uKglzlvXGhMj8zGCPROwIi/uL/GPW9xzuRz82iSrsNRzinzRtuE3
 8eOH1iXutRLrUpFf+fGR9smcxk46FFWizbZfoSOtqPupRQI9Z3LpBq+dG5dmVmkbq6be
 nRXv//3Ad8Td1woeidLzNuMrYKrinF07oPot5XbBVP9dqNGmQf42uHVtxiiwa98Zg1Yz
 MsqYRtko7Kl4fFUyIJN3IG76LgF643SutJGUyGXgs99ML0zl6542N2Fv043bov0CCGkJ
 olTg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6O9L2+7E5ygNVoogfELXvzUB3zYJTmDk+fxlSWpZKSp41ihBGqmNJBVTPNcIg6h9WMDKr1sSRRvw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuREocp0RbsJ8O+IL8VcZVWMu54JfUXv+UbNgLsqnMYox+xDdU
 vxmjUx7n8M6/ombTQRwSiE8XxFi7YvpuKgcV1G//Ni9erEwlIiHgsf149/E2EDxQCz1RbdNEWdn
 +Qt9zPUvbDBHKeDlkTg==
X-Received: from wmpl21.prod.google.com ([2002:a05:600c:895:b0:493:b21f:6ccc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6297:b0:493:ee2b:c8c7 with SMTP id
 5b1f17b1804b1-493ee2bcb92mr71010265e9.4.1783689783123; 
 Fri, 10 Jul 2026 06:23:03 -0700 (PDT)
Date: Fri, 10 Jul 2026 13:23:02 +0000
In-Reply-To: <20260709-fw-boot-b4-v6-2-ca391e1a4108@collabora.com>
Mime-Version: 1.0
References: <20260709-fw-boot-b4-v6-0-ca391e1a4108@collabora.com>
 <20260709-fw-boot-b4-v6-2-ca391e1a4108@collabora.com>
Message-ID: <alDyNmXQgRXAnlql@google.com>
Subject: Re: [PATCH v6 2/7] drm/tyr: add a generic slot manager
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 boris.brezillon@collabora.com, samitolvanen@google.com, acourbot@nvidia.com, 
 alvin.sun@linux.dev, laura.nao@collabora.com, work@onurozkan.dev, 
 beata.michalska@arm.com, steven.price@arm.com, lyude@redhat.com
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

On Thu, Jul 09, 2026 at 02:36:42PM -0700, Deborah Brouwer wrote:

> +            None => {
> +                pr_err!(
> +                    "Slot allocation failed: all {} slots in use\n",
> +                    self.slot_count
> +                );
> +                Err(EBUSY)

This branch seems like something that can happen in normal execution, so
I don't believe we should print anything here.

Alice
