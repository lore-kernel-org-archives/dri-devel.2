Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D2606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 05:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVMp5B0F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2176410E392;
	Fri,  6 Nov 2026 05:34:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10CC10E36F
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 05:34:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6729342DF5;
 Fri,  6 Nov 2026 05:34:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793943251;
 b=nC4JlekDxIakhPszJM8omUtIpT2fluZnCaRWVpcl/cIWQJVB7ktjS/vS0gNf17U8y2sr
 zYriYF5S9nA+2tkJ6K263IlX7miNzCE2nierXEUBR7JgO1Oy1IsPZQQ0i8nRV9xy0pfKK
 OxOfgUlJ9cktI6lFI06zEDlY4+vQhDfPvNXHk6dXoUikTthfe6r0kTJVgRBGoRUvyal9o
 oygbaPtrrLyTD8KjulQoLlCBfenwCapTzXlZgmRf0WuJFFKFsGxKXuS3a1GWk1oqCyk0k
 B2m8NGBSqqe3kGKo0g5qVK5bNX5J8LnpfpFlvEMYmX7zSupnIzyxvzOwVtvvDWRmbEA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793943251;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=ukPokh36f/mXsBQ+gwTLkRR89Rv978Xbef2tsft2wUg=;
 b=JbAceFYtpAgwMxkPr0Fr7awuEp5ZDfMHA0Sdnn+kNmtcu8TkFVpUZJx+y6LMy46NSeQV
 +4otGCf1lRZFVA11PewR8g6As/fgTpuJ+2bcinzPBG2Uzy1k0Pn2O2QUlO2Uu3PMYEO8G
 wQhsUbhdKzV+KXolFF8BwH82xjaJdTnsvCUpACnA4GqWfuGKTtcc+MUf20WIVmZfGizTN
 SsV+Q2Fs6JqlbGwRk/7GzIPktIcLiKDc5KSL1AUkWekMGi3GXE6Ds8qPgROkzPDTij7PP
 f4VmI1bxBUFqSA/93Kbm3g4ROROt8gdgxD6XA/VfqEPH7KTSl/75z+QU2ffwNuTm6YQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A95001F008A1;
 Fri,  6 Nov 2026 05:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793943251;
 bh=ukPokh36f/mXsBQ+gwTLkRR89Rv978Xbef2tsft2wUg=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=FVMp5B0FYFpkeRj/jTHiAppDunxZAcl26JeOvWX0ppvMLgc+4Y1qktRETC7Kkamo6
 ABFD803Hv+CSniXSqz0ZCuT+AQgWcLBehQiz5DBKocfPskWEEbGEocZrxAfyJ8SuxN
 47l47uvxuYuQ8W9LZ28+lbK9m0ZMx7Mi+uB/IdlcYFkMs5frY4qmFN8rc1oM8Yak0S
 pX7vVNTilPsNExoOpBzD9gnsMYcFbNU0Ji6V0Nxs1jMU45+0u94wPMGGvC6oM8BKaR
 nNtSdFcLMzxWpVlcGXzymYXwnTKt3LeHmJY5XXF7RlCGGxddFoQeM7RYIMV/0IGSAx
 jRNPIVxPRRy8g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 0653E45BED;
 Fri,  6 Nov 2026 05:34:10 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Subject: [PATCH v5 0/2] nova-core: add initial support for gpu timer (v5)
Date: Fri, 06 Nov 2026 15:34:01 +1000
Message-Id: <20261106-nova-timer-v5-0-a0cd25f3ee18@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MSw6CMBSF4a2Qjq3p4wLiyH0YB33cSgdQ05JGQ
 9i7hRFEh+ck3z+ThNFjItdqJhGzTz6MZdSniphejU+k3pZNBBMN50zQMWRFJz9gpA50Z1GKFhQ
 nBbwiOv/eYvdH2b1PU4ifrZ35+v7NZE4Z1RJaVLYBaLpbRNur6WzCQNZOlnsrD1YWy4zrtFZ4c
 fbXwt7WBwvFQq1awwW3YPFgl2X5AsHoi4wdAQAA
X-Change-ID: 20261102-nova-timer-f4b9de3274a1
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1950; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=g7MfgFdREEC1S5dgSmy+QtPmwok55SXsU5E0VesvkuA=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq7WbMRidSdN9Jw5fT0l6XMpGreiVf6TgZxiDUS
 81yQHZGUH6JAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCau1mzAAKCRAMdPNZecSG
 vs/MD/9mqXLJ15mBM5jLlypANpwPEAgbflJgeyg0bid7lzqr5W7vnH3wUbMm9jllX0esZocnF44
 0nU7T2WUaQJtVWfeuZSAU/oKWmcY/KHLzQo8T487kqo+ZSLV7GOY1COp0UHmTUsJfseX3i4q7TG
 lUiuznCxYaJqu+zgL1Y8UKnYx1r7AVVC8PbjTNbr+eZWTCt13EFCi6fgYl7gIzm10PcN5+cRyU9
 a3n+v82yHfmHhshpogZbS4MhFRpSx8jHs3RBzN7e/xD9P1JCUhrM0tcH6I7igbCzgPX0DD97y2n
 SYVIFAejYl3egVBjd9QFk525Cz8gICiyKgA2AcgdAWoE5gKVJGZjyAKEXycDtkFARdhsssebcwW
 d/uEfW7rkCvrf2G9ustA9GCC1seszco9babtgrMU5+NtXxCpApdQ0MegtYxCs8Bv7c4SInomG/8
 j4E+Wmm+bYcRZ0tQezREpPh3YPYTIrQDKkcfON+/6+nnu9Y9oxhO72pSIZGJkRyKAgDIYdkvsPj
 lkJ+wqyLKAppm7Gq+7AxqLt11T6iqNW9XVVN3gzf/zYj7eyAlInD4EAvoBW+/1YfSiaM3gD6vu2
 gCaogmsrjE8o6PbNpEXr2Ts5ATajsXc09lt5Sc84sw0QsUY8LZXIOojcyPL2YVazBub2b73/4hk
 gJb/UGQDYWgFDBg==
X-Developer-Key: i=airlied@redhat.com; a=openpgp;
 fpr=10A6D91DA1B05BD29F6DEBAC0C74F35979C486BE
X-Endpoint-Received: by B4 Relay for airlied@redhat.com/default with
 auth_id=1321
X-Original-From: Dave Airlie <airlied@redhat.com>
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
Reply-To: airlied@redhat.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GPU has a timer, one of the pieces of information
we need to pass into GSP init later is the timer offset.
    
This series just adds support for setting up the timer
on Turing+, with hals for Turing and Hopper.
    
Right now it calculates the value to send to GSP but
the code to send it will be added later.
    
For some hardware variants sending a proper value
is required for GSP init to succeed.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
Changes in v5:
- Alexandre's review comments handled
- reworked registers/workaround logic into fsp
- fixed all the timer register handling to be non-falling.
- Link to v4: https://lore.kernel.org/r/20261105-nova-timer-v4-0-45a7c121d4de@redhat.com

Changes in v4:
- reworked register handling
- used a timerstate.
- Link to v3: https://lore.kernel.org/r/20261103-nova-timer-v3-0-0cf9bbae8fd9@redhat.com

---
Dave Airlie (2):
      rust: time: expose as_nanos for clock sources.
      gpu: nova-core: add support for GPU timer block. (v5)

 drivers/gpu/nova-core/fsp.rs             | 19 ++++++-
 drivers/gpu/nova-core/fsp/hal.rs         |  5 ++
 drivers/gpu/nova-core/fsp/hal/gh100.rs   |  6 ++
 drivers/gpu/nova-core/fsp/regs.rs        | 28 +++++++++
 drivers/gpu/nova-core/gpu.rs             |  8 +++
 drivers/gpu/nova-core/nova_core.rs       |  1 +
 drivers/gpu/nova-core/timer.rs           | 38 +++++++++++++
 drivers/gpu/nova-core/timer/hal.rs       | 31 ++++++++++
 drivers/gpu/nova-core/timer/hal/gh100.rs | 62 ++++++++++++++++++++
 drivers/gpu/nova-core/timer/hal/tu102.rs | 53 +++++++++++++++++
 drivers/gpu/nova-core/timer/regs.rs      | 98 ++++++++++++++++++++++++++++++++
 rust/kernel/time.rs                      |  3 +-
 12 files changed, 348 insertions(+), 4 deletions(-)
---
base-commit: 7a6bc132f1b51437063c9203e7221067b40a791e
change-id: 20261102-nova-timer-f4b9de3274a1

Best regards,
-- 
Dave Airlie <airlied@redhat.com>


