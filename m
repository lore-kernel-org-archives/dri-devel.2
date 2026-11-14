Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D709606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZVY99UN4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A52F410ED39;
	Mon, 16 Nov 2026 08:59:56 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 932FB10E05E
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 20:07:30 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-3ae25dcbd81so24062661fa.3
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 12:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794686849; x=1795291649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=viQnFNkfgxE1Vj8v5dyCU4nOO4hedWvtxo3baR7F/4w=;
 b=ZVY99UN4ae/bXkWQfmtK2WgpE5cdYpb7gTtU214mwELZStvvNW61EnCgxwjYy0PbAY
 8/f48Yk7Wyipigm0GmVK2Vj+Cpe8g1DXp2UNmiZyyTHbHVqJWcPoz+DaIYK7Jpj7rf6C
 oygTYeKMf7anh1wC78kF/tKSOvBjaCOzaVb7anhi2o0KGb65sE46sCIDbqrTavzuPkFP
 Ci92ffPj2vaAdcfv2mkH0U+L6eyDRwQDnihnvfN4jg74UIa5il+bGT6YOrYdEMR4Es1/
 QraDnaQ3zxjB6o97UuJqE+GCgPWYyJFTlZaw6bQh1BiJTUvXll5UXw5CiOp0YW9br8QQ
 VU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794686849; x=1795291649;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=viQnFNkfgxE1Vj8v5dyCU4nOO4hedWvtxo3baR7F/4w=;
 b=WAbwgkFJflvC4sFw+lcTbqoWm5Ker7SCXJehUl4Ux8mas/h28PhzgYqMEZT7oX0pLy
 YGBC4vA5psaW0mqc4ZPqJh0ivqLSW9uvUs8TB0tZO3Kt6lKVPo9qPtq9v+pMQ0Jzq/o3
 SjCJ8z1wbwl4omF0/Yhxqemwd8gJjtLbTiTzxvZNTBOb3ATKSfAbiOeruXavuEUMiTon
 U0rUTRHxaPK8NP46p6RobwXe4MxxovIYDLt1/NXkloYAfq0utkIJaPfBEEKS8gTn3VHX
 uwMpn5V33Fp/eIHyNs8kt3cb7VZcx+tjkEu4WMtvxivIezlQLK92BY8Z6OKQ+DK/VfFV
 0QmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGDg6Ai26XkaNt9N54h+Em9Io3zKF5HHPIHNlVx9MACqWJJebIFm+y2W4MLlQQAKzFgb9MRLHW61eE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8I0MBcnW7OriDMwb5pDf2/dT6lfpbhj/ASYr4NaHkwqrdJGrhk
 jOV8bNLcm6mx/DZRLSqut8afmw/w0QyKO1VzfpD2+Ie0cIxz6GKWDw4E
X-Gm-Gg: AYBFou14ZhGY4tBDw1YA7+CVg7fRusJRi7+htx+EabTpgBROR64UBcwfiJ+Qn4SA0A4
 x3/SZ66wN8V3LLItIXyqQKWR6e1yIrh3iZwU3dPo/lkzGe6ZQyWIMFSBPuXDoFxvWLoK9x297vo
 HwV32YcwcBJ0gzRllLREJk2RmZiSMGOoyqBffgJhHHuLYzcwsMk8p6KV1cWjGW+QADCYDnEQT2M
 rojqsDDr3Bs0AupXxk4p/np9CE650tNocnc8GkU/ARJegdSKNGF6ye8BqOUYKEibKIQ6X/pLpVy
 GaIwRAh1GPQ2bSgrZXfzfB3frUaI1y+1ofuMeT6zuWBhcUGzYYkbRWqaLp34syl/d01ObTsCWW5
 4d36eY0vnEaqjgwqHpBOzSUP2Gbpy63X8JJlhpnLaFcvKaY5U81IwlP0QsFziP3fnq1I4HH0zdh
 SjMfT4QnWEApY/6gSu1icXhb6G6DmER/vV1GK6Dy8X82m84kRo6lXuMYFrRBzwKur50zBp87bwE
 DaRhOXKc9/iKFWvgRUDtqj39/uopkR4cW362mBJQTTQGBofV4OfP1oQp9yJ88o4Z2bbImB3Nlam
 lv2QkP7uZHkRHCHT8bp1hC1iPMbG76fuzqPKnko=
X-Received: by 2002:a05:6512:3a8a:b0:5c1:5715:bd00 with SMTP id
 2adb3069b0e04-5c170b1c313mr2231081e87.18.1794686848394; 
 Sat, 14 Nov 2026 12:07:28 -0800 (PST)
Received: from IuseArchBTW ([194.28.181.64]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1712da125sm1891070e87.1.2026.11.14.12.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 12:07:27 -0800 (PST)
From: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] rust: sync: lock: allow fallible initializers in Lock::new
Date: Sat, 14 Nov 2026 22:06:59 +0200
Message-ID: <20261114200703.33229-1-mbkchelofficialdev@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:58:46 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GpuBuddyInner keeps the C gpu_buddy structure next to a separate
Mutex<()> and has a TODO to move the structure inside the mutex once
Mutex::new() accepts a fallible initializer.

Patch 1 makes Lock::new() generic over the error type of the initializer
for the protected data, so a fallible initializer such as
Opaque::try_ffi_init() can be wrapped in a Mutex or SpinLock.

Patch 2 uses it to put the gpu_buddy allocator directly inside the Mutex
in GPU buddy, so that the allocator can only be reached through the lock
guard, and resolves the TODO.

Tested by building the rust/kernel crate (x86_64 defconfig with
CONFIG_RUST=y and CONFIG_GPU_BUDDY=y, built with LLVM=1). Not tested at
runtime.

Ivan Tverdokhleb (2):
  rust: sync: lock: allow fallible initializers in Lock::new
  rust: gpu: buddy: store the allocator inside the Mutex

 rust/kernel/gpu/buddy.rs | 38 +++++++++++++++-----------------------
 rust/kernel/sync/lock.rs |  8 ++++----
 2 files changed, 19 insertions(+), 27 deletions(-)

-- 
2.56.1

