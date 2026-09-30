Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C67CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D45910F3FC;
	Wed, 30 Sep 2026 13:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Z5Uugk7r";
	dkim-atps=neutral
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F43010F3FC
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:34:37 +0000 (UTC)
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6ab0162426fso4355099a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790775275; x=1791380075;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y9SK7+tlKw2iGM3TW7g2rjyMMpGtpW6NrO3ZYW8LWuc=;
 b=Z5Uugk7r2H5whYbez776zXX+kn8w6xaoRl4ox0TZjLkyPu4O134fX3BbSFCY80aJq5
 dcIAISHG95O5bO3pvcgNSbJBI+kr3XglXWXFoIh3NNTF8MXS5tFPHhcQ1ThJiwj0ODIO
 uSiIbSJOGN1dwOUSRAVtiPGf5RLtaH0WLCGwsDGL6nqb2qLLqmUc9CzqqmqoO6Syt5pK
 bnuYEv70ysAolWc6w4sAixJpU/ImbnvYH8E7EHUQreNTodnwByv9KnM5pVSfwegLGlmz
 oV2gE3Z0ACVQ0UWLJm30INiwdYPyoowSMujlVks1u1BvMmcezY14yuLBaDuREHWLKj7j
 fxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775275; x=1791380075;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y9SK7+tlKw2iGM3TW7g2rjyMMpGtpW6NrO3ZYW8LWuc=;
 b=uzbJ+D0tyvqkojbn5Boy2vdYfhal8ED8Zuok1VwRRWKInXNzo2LE7izY5MHUJxFjjy
 kTkGaa+3vgTF0AIuwebK9i9mlTcFBuc3qPTsyqzLn379xoUuBqck0H3RKDZWz4VwJ8km
 L8B4xp7XUwypB+bu9nYpXLP4jervvaC46M8uvZfeGwAi3c0Gyy1xIWPW/BTJzijWrpPC
 e2VTYAjK38iJrisIxeuGBWiyUb7XO98lrV0RGRM0UQC/z23dhSvzJSUlvj8eMSYJ/3vu
 wi6MmomErq4hnRb1Q/lr1mS6kWzw3d3Y7CjW+YmCPVPKkpw/MIxS6CnexnMCVsl+2fUd
 s6fg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDzgyLWFWrFJNXyG3ScV56pjq1xr1OEGED6wZ/pJqIzzST4SpKK2eUsHJFHc5qIRrJ+iVfaT/MQDM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK3WiogWEmlMsTe9d0y93WOX3Z2vk9Ko5SCR3p6Kre179SGbWXH
 /aqfMqtzLb+zZuBuNQolsvGvriHGwfkItu6T1onDmbviH9BeV0eCm+280qCaHZiedbgopYEABkE
 QRGhezgnbF4ZgJ1P5Pg==
X-Received: from edzg16.prod.google.com ([2002:a05:6402:910:b0:6ae:16f4:b498])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:270d:b0:6aa:9f93:e991 with SMTP id
 4fb4d7f45d1cf-6ae1985dfc4mr1066814a12.3.1790775275068; 
 Wed, 30 Sep 2026 06:34:35 -0700 (PDT)
Date: Wed, 30 Sep 2026 13:34:34 +0000
In-Reply-To: <20260910165734.80378-1-gary@kernel.org>
Mime-Version: 1.0
References: <20260910165734.80378-1-gary@kernel.org>
Message-ID: <ar0P6kAyX5EH6xhy@google.com>
Subject: Re: [PATCH] drm/tyr: use `bitfield!` instead of `register!` for
 non-registers
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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

On Thu, Sep 10, 2026 at 05:57:33PM +0100, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> `SectionFlags` and `MMU_MEMATTR_STAGE1` are not registers themselves. Use
> `bitfield!` directly.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>

Applied to drm-rust-next. Thanks!
