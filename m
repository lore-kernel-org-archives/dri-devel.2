Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB1606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSdHgSFS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 962F310E588;
	Mon,  2 Nov 2026 07:17:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4FAE10E588
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 07:17:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF47360EDF;
 Mon,  2 Nov 2026 07:17:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793603872;
 b=JOrqtAY3vTkHjBYjW4WzbLgYPgiAgPaoq6dj+XxC/xMglaFOFdRSmkM5mCfVpfd9IeGG
 bGgBbWqGfumXpmiKubUtTiqxACL4XR7WUfTVnxw+B+VwHtpe6OikxS0sUDBFpR8kY7nd8
 vTvK82iVfRmRGmSwS4H+IsXzBlWEQ9NnjpvXFI5tUwHoROxsFNP7Q6/hS6cZU6k++YKIH
 M0iFlWvqJaTTkWbVw1jwCLuf/uI+AMAQmu/AhrdrboobHsM3k5XDgVJ+KgUO7oalVZsfe
 NtXETNpCGym9DhSpc177IsuZl3jPuzrQja46ukV8LhFkdJnuhoYQOc4RwfACF09qnow==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793603872;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=/CqY/JwmLRqna2Ah8QP4/3eF0mxPg49P6CbOEFBKUQM=;
 b=H3D2DSj6+DTIKJpt4R/+j3BlFm42c8CqwWJlqMZdqHuJCuYUnE3PwXGRRg67qfrwK6HV
 1lWKUd2ARQIpdAoR0OIDxNgc9n6LmmCR6wos2j0jvndhm5zfV0+919XAty5JRLTsZYCGh
 S+8vRWCuo3YpVKFIJy6rHcTbNLgUzHjlx+co+4vFTyr91DGadHDLaZ9FQyuzmwRX6sRGK
 O4sPD9Ca+XC6Feoyr+rget1I7W+0Wom78FnTmmpC1WtavOW9RAUMvAQ6XOjfRSDQMF6eZ
 wwO+uV3Gn2nd4FjgeLRO7X85kidLYuaUFFZ2goPD1EL4UxocxU7ljVwu5le33DUAcKQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A67D21F0093A;
 Mon,  2 Nov 2026 07:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793603872;
 bh=/CqY/JwmLRqna2Ah8QP4/3eF0mxPg49P6CbOEFBKUQM=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=JSdHgSFSWsi67XQtbsjrvWR3M2uKT7Nw49ztGMCtXGGmq4cy0oW87hFf8s15zqmRS
 vmDkfE2KWMVdjKavoPY2Ap5JMTE5IIbWGm6AMYurZImI2ZrO8DiAY1DnFfHIAC1on8
 JCuhwZjbQ0gRwXZZ8B3OLKqkyB3NMg0jeuVcVVmFYOe/UXSDzGLnkWTYAi3BsRpo/H
 S8CVRAicdMWEV1j3j4FZBy8dcKzbwY1sEvioY5zKaV+bv6j6xsHwCBZaZzeN853D6c
 TEaN4zqRGqXkN0Re0jlxb0reBKrcULYEoigksSjufQQMMsMVr2f2/eH0vR8dhJdnX5
 Mp1acV6TkN/1A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 054FD463D3;
 Mon,  2 Nov 2026 07:17:51 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Subject: [PATCH 0/2] nova-core: add initial support for gpu timer (v2)
Date: Mon, 02 Nov 2026 17:17:39 +1000
Message-Id: <20261102-nova-timer-v1-0-b347ead64469@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMj3bz8skTdkszc1CLdNJMky5RUYyNzk0RDJaCGgqLUtMwKsGHRsbW
 1AP5WcfNcAAAA
X-Change-ID: 20261102-nova-timer-f4b9de3274a1
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=RYbXHTs81IbH7HvDGHxYUlQGzPjtXhkoehwsBfu0Hto=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq6DkYDL0yKfyHai+FiOWnD9w9gdYcDqpe6Q8vi
 jeiHuKBDdGJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCaug5GAAKCRAMdPNZecSG
 vnHxEACos1WTmVvpCG78TQF4ByhizPj2/NukKawmojSNAa7FcBoTT47lssoanIRwFuqEE30Zs7d
 5xXGQL9D5L3wM6QX2qsTKYeStri4oMJyz5WyMbs1BggJm4NP9dYHtSfEiv1VmRj6vxR+O5LL4D3
 XK0GsMrr10Epl93z/OGjjaMb4uUPjiiJzdIW3Wi7suGVEcEa6Q2kZkVDACrUrcptTIh0h1JmMkh
 vlHt/FQuIVx3m6ANmxjZrzgubOrrs9mUXoQyBHhmapmrChVX/VZmXilQSvt/Y2p+HAqzjHvZmb8
 PWxPmBi5J8dijwgg2YBJhwcmb5hYXUX5aTajlKiJmaJSzhhiFqX3HcYqG8ASL4Wctgx58opS/Sw
 iG3GqMMjb3AUCHg7vRSUBf98d1N2bEutLJGDeAIHtvCM0RM7pFk7rhc+qJqlB3egs+/4RyPjEw4
 3XweKOvrveAQ/IReinl/dJ9sKQ3iBBwa+5Dh9UAy5gOWGSQfGKOZta8oXtIUnWTB/jI+nHvreAM
 gdLcjjxur2M8G/TQaKLSAmjWjH/Uj6a12sbQZJDkQrFZnFqYgcWpO17oOHCcbzFtadDnIC3kms7
 jy9FOxopeYWvx+N0dRvfP1MirO/k9ave+r6bKmOZCjFU0vjBtdtzzMfGCSSuuiIXG+rKjt1rIyy
 vTsgsZCeV1IVY+A==
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

v2 changes on second patch.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
Dave Airlie (2):
      rust: time: expose as_nanos for clock sources.
      gpu: nova-core: add support for GPU timer block. (v2)

 drivers/gpu/nova-core/gpu.rs             |  5 +++
 drivers/gpu/nova-core/nova_core.rs       |  1 +
 drivers/gpu/nova-core/timer.rs           | 33 ++++++++++++++
 drivers/gpu/nova-core/timer/hal.rs       | 28 ++++++++++++
 drivers/gpu/nova-core/timer/hal/gh100.rs | 76 ++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/timer/hal/tu102.rs | 56 +++++++++++++++++++++++
 drivers/gpu/nova-core/timer/regs.rs      | 64 +++++++++++++++++++++++++++
 rust/kernel/time.rs                      |  3 +-
 8 files changed, 265 insertions(+), 1 deletion(-)
---
base-commit: 3497a403264b094ebd61b8b755165d56e7d9dc37
change-id: 20261102-nova-timer-f4b9de3274a1

Best regards,
-- 
Dave Airlie <airlied@redhat.com>


