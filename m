Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DCACC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA0610E2B2;
	Fri, 16 Oct 2026 13:54:48 +0000 (UTC)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7646610E043
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:54:42 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48dfaaea30cso804794f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792158881; x=1792763681;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mwy80ECHA03ZxNI6fxFklBBGHCRE1D2wF/JjDhNvW1s=;
 b=CPSBLZ5+VvxJ2mrLSMSH+l8c6PszOhbvR3NT7cE2flQ56Dm/qYfJ3rQgYZtt72pmbz
 UyxLNsHRfHWJZACUXJMvhpTOxWGmCtL39ZbTMkzMOtR0QwZfTbczQGIVUMvLr84mLNNn
 T+buG01jft9A2gzfyw+livIrEKb22pUfTWjXah0KY43OJCrZ4P0YR0Av7E8AKVatG2qN
 ZuZxrlt8Sw2msESVTKypIEOIuFT+Q+FZz9wA9d/hNHOuZxINR4AgGDZmyUJYC2I8F6wC
 linXndYilN4IniJS94B+wpq3NeicYvIVWb1giePu19HopQeMsiGN4LVfVgRGrvNBXDmV
 OfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792158881; x=1792763681;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mwy80ECHA03ZxNI6fxFklBBGHCRE1D2wF/JjDhNvW1s=;
 b=YzLArmfOB1cbaIwceAbeoVVbpueMfbYeQJdkVkg79H8vkpAzjmRS2TFN99rnLPXZep
 OXQx7iR5P7Xm7o8/5OQoopjxV3e2sezJom7g6/dqsYn+v2ZKqx5OW4WQUgp/SWyoj68W
 KtglI1wxZPOod5Cm6Sou+MuIjcmFCAKbLgBrxQEQCnJ3R0bPnYx0cLEuh2Xolu7GeCjO
 X1ul6dtqSImFmCUEF1CbAteDNxUMnsmrHLjw43WyptbPu66Q8/WnvYxgM9SdqCRCa6Tm
 sEQHpvSlHjcYCVRO9yw2bgpmb5ZzktjrbD81LCaaeHk/JZ5KE6GC+O/sx432p0B76Apv
 d5xg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9P5zinBg5I8vgtyx1kQ4ehx2Qpi2p6XMePrAvITDO+Vf6uJW6BhWMGpJGbaR05Fu61Tv2lYuxCVA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIx95aZP4m01Ed5Nft4o6L+5bGo3pg6cTa0cQd8Q/Lf9EKY2h1i
 zJnjcbbgImTiJQm2BOfF/MobC0CdbqRAcrjyTvpUU/08ui1Cr7sGWfbOuAd6gHfJfTwYbEyBBY4
 SsTWQykT90gGuriawTg==
X-Received: from wmph24.prod.google.com ([2002:a05:600c:4998:b0:4a1:9c0f:883d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c049:b0:4a1:9a97:c88 with SMTP id
 5b1f17b1804b1-4a19a971118mr271601125e9.5.1792158880287; 
 Fri, 16 Oct 2026 06:54:40 -0700 (PDT)
Date: Fri, 16 Oct 2026 13:54:33 +0000
In-Reply-To: <20260814230923.1292966-2-dakr@kernel.org>
Mime-Version: 1.0
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-2-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016135439.44716-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/7] rust: drm: rename Ioctl device context to Userspace
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, acourbot@nvidia.com,
 daniel.almeida@collabora.com, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, tamird@kernel.org, work@onurozkan.dev, brauner@kernel.org, 
 lyude@redhat.com, j@jananu.net, alvin.sun@linux.dev, 
 deborah.brouwer@collabora.com, laura.nao@collabora.com, 
 beata.michalska@arm.com, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
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

On Sat, Aug 15, 2026 at 01:08:59AM +0200, Danilo Krummrich wrote:
> The Ioctl DeviceContext typestate represents a device that has been
> registered with userspace at some point. This context is not specific to
> ioctl dispatch; it applies equally to GEM handle callbacks, mmap,
> fdinfo, and any other operation triggered by userspace on a registered
> device.
> 
> Rename it to Userspace to accurately reflect its semantics.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
