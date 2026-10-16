Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF78ECC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F6310E21A;
	Fri, 16 Oct 2026 13:54:53 +0000 (UTC)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B43410E286
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:54:46 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6b1c2d36cabso5719757a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792158884; x=1792763684;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4RB0qRPK5JwVr0FFzsYrhcGUqlQtMIIbndksgD1L2mI=;
 b=K6te1JnVyJ5oSDwC2TYdpwN+U/0rJFRAbwu+reE/cQPhszKv6x7gA3V6YS8DvqWA0C
 exn0J9mv02wnxtK4/PQT1qlecSIIJ0DSRq4j7aEEAwmwfgCih5Yr3lWj6DbuFoqONJTl
 ooP4WLM4QF4skmriCnSeoh8Jf9v6eZv6DCE2gONWIFl1sLRlxfcfJtONY4qnFMuJ9Dlt
 7gD0hsyZf8s+0DmrO4hDiDDF8gMOMDy6jN+29u2TBHkcY2OR7kKx81vNPFlXDh1nAaN+
 cN7UtiePvpzz1oEg5CvJdC/5IYcEKaf1DEkv1Aq3E8UIXXl2q6RjS8HTraSKQrZAHXd+
 D2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792158884; x=1792763684;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4RB0qRPK5JwVr0FFzsYrhcGUqlQtMIIbndksgD1L2mI=;
 b=VXhtn4CMAD1pNbVv32cCDDAEstck2Mv1tWgP+7vl8OSvLcbD//ts9lCRm0Ml1yPRGZ
 7FMTDvc39O0EJiuoqrbEWG99ciCYSsMavu4B6nkwDgF6K6BkDR+a2Lfoql3sLCZAtHxv
 YbGA7uXUlFfAjBBhN/1vbNNVevca+cvuz4rPW/2Fy+9B6q/+XpeHwoU2MJrc9rqdna53
 M7DA3Ej736veauGZA/8mWWjw8MDVfb2wVnm8Aq+J24L4l5LBr/qXwSiElf4L1ABVIFro
 KeBu+onHeOVf/MhLHOUKa549PhnHBhJidfFX5r1hZwvA7gjYlvEFRPkJUmUfKUDF7vyU
 WT+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjbuof5DTHgmeK03AqBYiTCf0zEjK1WstFAIhcDpoR347bV+nUq47RnJhe9hngrC4XXIr/0g+jJcw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKchoezfT3CREriHXVvnQafy0fLnl3Ud3yTuvLgAJB2P9PO+a92
 g30mhN3pXD2jP5S3fHX4j3KeEEgfpBWI1H68xlD2AFgSX2YcqvgybaTWwv2ph1lt/7kcCvkm9IF
 7mjgXWW9Ce2w0CIZWXQ==
X-Received: from wrwc4.prod.google.com ([2002:a5d:63c4:0:b0:48c:44a2:fe52])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5285:b0:6b1:497d:1c64 with SMTP id
 4fb4d7f45d1cf-6b17c293eccmr19329170a12.45.1792158884099; 
 Fri, 16 Oct 2026 06:54:44 -0700 (PDT)
Date: Fri, 16 Oct 2026 13:54:36 +0000
In-Reply-To: <20260814230923.1292966-5-dakr@kernel.org>
Mime-Version: 1.0
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-5-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016135439.44716-4-aliceryhl@google.com>
Subject: Re: [PATCH 4/7] rust: fs: add iminor() helper
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

On Sat, Aug 15, 2026 at 01:09:02AM +0200, Danilo Krummrich wrote:
> Add a Rust helper for iminor(), which extracts the minor number from a
> struct inode. This is a static inline function in the C headers, so
> bindgen does not generate a binding for it.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
