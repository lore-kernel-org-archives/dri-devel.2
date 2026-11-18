Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16310606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KqodoQ7w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449EB10E148;
	Wed, 18 Nov 2026 13:32:50 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB0B10E148
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:32:43 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-3ae1fd4252fso9994281fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795008761; x=1795613561; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vARgZ4ae1GlRG7TFzkKePX/f+At6TdRa5dq48dnLYwg=;
 b=KqodoQ7wK+DU1GPbYKlea8nyM5o5kpjUxZ7N+ZYbTA7WXCZIk3ezEqdSREtAuQ+E6C
 3TqqLb14v3NBY5zUvXIYHcLIaFH578SdC4UBsODSnAFdEtgiQ0jpNVHvrhYRtup2wJXm
 TxsGIxwGniAv/d3pCj6IqaHYxQMnRmBZcico5aYBoBwT0ZcG7ZPJu5mFela2WYaX9OqT
 UoWWF77rdTSNcBDdK9YSPz0ILATlfbg0L/19DSPIb1swpyHN9qsK+cRL7B7LidlsIMZe
 hq7Dp8Qlpev/LbCYZnn9gIndvHVlJZ/mzfLN2cId4Tsk7OHndFu9MaA8Iju77Ts1FLVS
 1a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795008761; x=1795613561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vARgZ4ae1GlRG7TFzkKePX/f+At6TdRa5dq48dnLYwg=;
 b=bmLQvdyNsvnGoptYjE480tUwtH1faCDi0FsiRIm6EMywjE0/jdK2FDCtsueYV+aE9g
 kps2LhfCKFZ12x5jFRWAVZc9v/5uAP/C71y0+xjMe2FoHo9SmR6sdUqNAkYxVLFsCNik
 5AwFcU2KdIUimRPeKGblyeTf4KGt6z+2SY+g9fGD9t0PpikHKR9C3ZXUcafE463o/WYx
 GDXftWhIIhLjxz8Mes3VW7IshCo2ow+Z7zbsAHxXmdCMVfzf2CnfTHG6cLMpiS0wBN6g
 kBVj/oKXz1KP97E4SQhi41l21SJRkhtaDT8S8yyvRCKFQz1Vjfdqh2stHuFcND+4znG1
 rkdg==
X-Gm-Message-State: APuU4Z/ay8ZSALTjOIjoCHu9oObA6zlpaziBaQ4mrzFnTmDqfMq0mI31
 wj1F/aPzfnvE8jTjscZjTDRXXUBDjn88HE0kv/2ocAb4tv7dx+ZFEZmE
X-Gm-Gg: AYBFou13RyoQFeVWUQ4YOk3NAefselhGNxJTBg/1SABrzve30r9VseoGQcZjf82p2/S
 abTPsSHOnPkX+YcnLAQhRfKTniWxIO7adrFQBJDIfPaIM+5M7i87Q3F+s1XItANZBFOauDNylES
 4tFlz9dliD4taL8ddCXlwdY6sqaugpyAwgO0VPoVkxFp7rd9mcqrBBzVK5RO7VVThSRRgEqbIaT
 471i3N/1t+dzL5QWErI/bxKGPUx2mJTtGWGDl3IKMipN2YZBVSAGUjyfe7Uw/I31IgQESMR6phy
 Cz4z/bzqeDPo3JQ6QUXJ7TA+BnIlePm4yJpF5ohtcCr9a4VnZ8SUUJX7zkQx7bYMxMWJThT4pyU
 aoMRf8W56pfEfde8Lze+dm1CTb77ga8+E80kJ8f4D6H2ob7/tBU2BGklDncrbSwB1ee9aHyKxNV
 7IhkiFVXN5tzOjZaiHDPBv6ptU/U2pPhguH/6T9VjCfIlIdlexlIoIvTUs+/pdRZnSE9cI8lr6A
 QPK1LbmJxvQ0vwh90HBlx/qYd9IZQCumV4097ecpObPfsTlluhyCoccwvk39bMl//2YqSemgqcl
 aJZ1bl67i8lB6n8yr31tn6AthxN31+pFD/HgO8bfTPjP6qHnDeKPpd9daCVEVZsKQZc+2+wehMG
 KxHFdjrEl+9kyaTyFK1omJ90cJ35QgSvkDts7Ac48hZUhJ0Vn3L4JHbfsanr5BU3La14ZD0VywF
 QI
X-Received: by 2002:a05:6512:104c:b0:5c0:a7f:3ee8 with SMTP id
 2adb3069b0e04-5c1a9d25ab8mr1067457e87.8.1795008761239; 
 Wed, 18 Nov 2026 05:32:41 -0800 (PST)
Received: from C422HJQPQG-Fractile
 (cmbg-18-b2-v4wan-168328-cust3701.vm17.cable.virginm.net. [80.5.206.118])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4a650d2e26csm4798809f8f.4.2026.11.18.05.32.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Nov 2026 05:32:40 -0800 (PST)
From: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Asahi Lina <lina+kernel@asahilina.net>, Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
Subject: [PATCH] rust: drm: ioctl: fix call to unsafe function
Date: Wed, 18 Nov 2026 13:32:32 +0000
Message-ID: <20261118133232.48603-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dev is created via an unsafe pointer dereference. Following the
convention, it should be wrapped in an unsafe block, but it is not.

The compiler only properly lints declare_drm_ioctls! when its defined
in the same crate as it expands in. Since upstream drivers are all
separate crates, this is silently ignored.

This has been present since commit 9a69570682b1 ("rust: drm: ioctl:
Add DRM ioctl abstraction").

Fixes: 9a69570682b1 ("rust: drm: ioctl: Add DRM ioctl abstraction")
Signed-off-by: Vishal Moola (Fractile) <vishal.moola@gmail.com>

--------------------
Based on drm-rust-next.

I encountered this while trying to build a rust driver out of tree. I
copied the macro to an out-of-tree crate so that our uapi can see the
same generated values without needing the generated bindings.

Ai has told me that this is because the macro expands from the same
crate its defined in, which sounds sensible.

I see:

error[E0133]: call to unsafe function `kernel::drm::Device::<T, C>::from_raw` is unsafe and requires unsafe block
  --> driver/drm_ioctl.rs:77:33
   |
77 |   ...                   ::kernel::drm::device::Device::from_raw(raw_dev);
   |                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ call to unsafe function
   |

Plus a number of warnings. But warnings are warnings so those are
whatever... Its all silently ignored upstream anyways, so doesn't
need a cc-stable either.
---
 rust/kernel/drm/ioctl.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 64af9eacc306..5a2e2f4f0e91 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -152,7 +152,7 @@ macro_rules! declare_drm_ioctls {
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
                             let dev: &$crate::drm::device::Device<_, $crate::drm::Ioctl> =
-                                $crate::drm::device::Device::from_raw(raw_dev);
+                                unsafe { $crate::drm::device::Device::from_raw(raw_dev) };
 
                             // Type-inference anchor: the closure is never called but ties `dev`'s
                             // type to `$func`'s first parameter, which the compiler cannot infer
-- 
2.55.0

