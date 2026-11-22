Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E52606A330
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GQu4YLfl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6784710E4FD;
	Sun, 22 Nov 2026 08:59:23 +0000 (UTC)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B5D710E4FD
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:59:17 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-499ca65ae87so937560f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 00:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795337955; x=1795942755;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bt+vNC5Ck7Tec+thZqwOgrn1YnZYE8U6h78l2ePZXOA=;
 b=GQu4YLflWRbBPDlxCCo9WPP/XbpAAA3QPpJ2tfHpUDszSESABu7ZWm33XSqVfA8S2O
 zE9RonUwcVBDuJetu9I7bvlryb0KnApAx2AYW7ZeGJAXUdDIfiGxTlrHZjUhnKDyyYPK
 dtDVmoh18GAI2P3iGQUTrZ57XcMYY2enstJpltcTs736WsMDIDDex46X/iXvqB7kFscy
 rJAljha9p3e2/w8mN+lcALz0Mt6JHRWLRyO/i0fvTt9HFhCLKzCKwjqk7biwIqZIzwNw
 S6RxzMde+m3kps3uY5HcGhLsHn4BAp99lMJS6FQJLfTNSV9VvTNEDe2C9O7xkdms8tyA
 53aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795337955; x=1795942755;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bt+vNC5Ck7Tec+thZqwOgrn1YnZYE8U6h78l2ePZXOA=;
 b=jMOuv2KuwjYb14SZlM0gwfx2C7+OPLUlZ77gtXYWJDvLNPnzUWHUuUd1GFRlv/D1dF
 LpoPoIGgvxjTITK1Y/s7EWhtftXDwY3RwK+ANgzGz1bdC0ijnAf93+3VG6njW1s9NEn3
 cv1E5Vk4C29FdFV3wIqh7w2yFRoGqRYtgX94u0fN9QL7yGo52SmNhsuu7zlFmW9JkvTS
 BlWJH8gNzlY2tsZWxuAjSPYN/PjMseoSnwTol7KC27DYgLWl7taq1XJvO2zLQ7J7fXqg
 3bZWK12NS9j2pLOkddR53t069/gBSIO2r/d/TUz3vyAS1XTLfgjkik7FTDx8IJz96xAX
 IwGQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFS21cUHGBAfS9Tbq6iTMmmY3zkiqwWuTUNhcOrMp+2csIoLkG9tULYwvNOhewCmbCH44PHUZyZTgA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ZSuXVR8a1rDkU4wWqgiRudhfL79ooKqKn2NW8nuW1kxRfCPzC
 YlsPD+bz74cRkEMvzTMVoEvRVA8GsozCi68GNonuoZDlVn63Qyihw2p6bmGpz03FgxdSPGeo9kn
 fTlDxeI/s3sM8NwIUyQ==
X-Received: from wrrv2.prod.google.com ([2002:a5d:43c2:0:b0:48c:4566:c9eb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1e50:b0:48e:60a7:e0bd with SMTP id
 ffacd0b85a97d-4abb2ecf9afmr12805799f8f.17.1795337955311; 
 Sun, 22 Nov 2026 00:59:15 -0800 (PST)
Date: Sun, 22 Nov 2026 08:59:14 +0000
In-Reply-To: <20261122-tyr-reset-impl-v9-1-ed42d8f513ec@onurozkan.dev>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261122-tyr-reset-impl-v9-0-ed42d8f513ec@onurozkan.dev>
 <20261122-tyr-reset-impl-v9-1-ed42d8f513ec@onurozkan.dev>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122085914.1094403-1-aliceryhl@google.com>
Subject: Re: [PATCH v9 1/2] drm/tyr: add GPU reset infrastructure
From: Alice Ryhl <aliceryhl@google.com>
To: "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dakr@kernel.org, daniel.almeida@collabora.com, airlied@gmail.com, 
 simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, boris.brezillon@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 22, 2026 at 08:40:32AM +0300, Onur =C3=96zkan wrote:
> Add support for scheduling GPU resets on a dedicated workqueue. Track
> the reset state to avoid queueing another reset while one is already
> pending or in progress.
>
> Use an SRCU based gate with mutex-protected reader admission to block
> hardware accesses while reset work runs and wait for current users
> before resetting.
>
> Stop new reset requests during teardown and drain any queued or running
> reset work before releasing the device resources.
>
> This is the initial reset infrastructure only. It is not wired to a reset
> source yet as those will follow in separate work.
>
> Link: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/28
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
