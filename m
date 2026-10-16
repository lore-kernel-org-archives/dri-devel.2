Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9335CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E159A10E043;
	Fri, 16 Oct 2026 13:54:53 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D9910E043
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:54:48 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a17574b5easo23962705e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792158886; x=1792763686;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BRDYyfM7TkTb+fgJiC0WCgOCCRs4w4XpNaptrf9kwKY=;
 b=JoKK5s5uEMuorYWz6TIXWzIGNuN9GLcawCn5HlIzJdEr3ssQSZhgQ57GXGTUksmKTm
 kCjnTRXLXdnPI0gX/dQOcWoln7ZeBhLqFsQROrjItGdRGJmRuDQ6tPiEGN5nQJLXdzyw
 SnrpLcqwQDFN/MpR0/tcqB29tRURB+CNMmqlH/qKaqUrpgdqpNhPpUbNxxDBCHlwAw30
 zP6p7zh1TBGMqHPsT5exn4jNKfUA4q3CVn2CidrA0PpiflUW6yLP8yhjvrzIgqPvhJpm
 HvqWkcH0k46My1soTUg7nDTfjnMyTH0NnioWTxPZyARPLUEJba2YdSfDK06Syu8Pihvg
 HIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792158886; x=1792763686;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BRDYyfM7TkTb+fgJiC0WCgOCCRs4w4XpNaptrf9kwKY=;
 b=GhDThOhbV12ubmBLlaaCiveHQnBBBafGNA6sXQRFI3HSaKgaBGgrpGS3loM+eOk29x
 DxYp02UmuGLwVJoHgsxmVVOTwWtIkjofSQwgVVhuZwkvNI+4Z1IYUTRZKp78Fn8RXyaw
 zsJE0uHznVq2zLkZUtNIHOxF1WvwiXimeS14HvXZL+ovfN83b9/Irzlxts7bNFSJfXq0
 uQRAQyYtNH+G7R0UGfK1XDzRprfay+Wx329buegVYZmk+ejilDk2hqVfUeaftQTvOG9X
 jt06RZULpBF3ERnN3/cXN7AX4NX46AkAdvGCa9L9W2vo0sCPFU+iE3PgaJssnHK1ydvY
 QEsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDQGxcfxLI6pJa/EFpC8gVPN8P5NNznG3yHrTZYdAQcGvHdcAShHrfjauSKWeM71juqN/z37R37gk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJse/2n6lDMvNAOt6yPTLzxsMHkgZzxTSITFaGkn+6/8a4PwIEM
 +KovNA36F7kxvzumMyKdqn2c8d/4GNUD9fUcUD3/CAKRQg5xLSyzTcEk6Ow5BhpsoLzQc51aIyh
 JY9mFzin0FcZIQkgj0w==
X-Received: from wmaz19.prod.google.com ([2002:a05:600c:6d93:b0:4a1:99b0:134f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4708:b0:49d:15b9:2a2a with SMTP id
 5b1f17b1804b1-4a18e47a8a5mr488323585e9.10.1792158885671; 
 Fri, 16 Oct 2026 06:54:45 -0700 (PDT)
Date: Fri, 16 Oct 2026 13:54:37 +0000
In-Reply-To: <20260814230923.1292966-6-dakr@kernel.org>
Mime-Version: 1.0
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-6-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016135439.44716-5-aliceryhl@google.com>
Subject: Re: [PATCH 5/7] rust: drm: wrap fops open with RegistrationGuard
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

On Sat, Aug 15, 2026 at 01:09:03AM +0200, Danilo Krummrich wrote:
> Add a Minor abstraction with RAII release and a fops_open() wrapper that
> holds a RegistrationGuard (drm_dev_enter / drm_dev_exit) across the
> entire drm_open() call.
> 
> This guarantees that drm_dev_unplug() in Registration::drop() waits for
> the full open sequence to complete, so all files are visible in the
> filelist when iterating for cleanup.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

I would consider whether drm_open() should be changed directly here, but:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
