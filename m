Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A6606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 02:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=eYITmdvY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F85B112E85;
	Sat, 28 Nov 2026 02:16:08 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4754410EB32
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 02:16:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795832158; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VUU1Cq7p3fitaf3kTjgBdG+kXW8aUvFTXswLo32Pl9J6jSZvGDuI43fKxk7Jdi5F7e7XuDGkn5mEz/brnhpa5l98MG9NXjhRy5scG/KldQhCahvXPpZZKUKpuKfHeKRlPiaJKQY2xCw2JMUlTAxFaZG3T0llAonXbhleGyVilVg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795832158;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3eONrA25YZKhTEpdwkpm5IB2Fo8UWIIaMFsjHg3YNSs=; 
 b=S1Cl3sicY9WvpQMbo+xBAFC2Ff1Ehs5pFoBMgh/89SPkfo373Dp7cUdryYF2bBzd7oOWz5gX175iXvqzYHewrYE/jDOojwBnBavr3KoqHUTjAsVwhxCYbqMFiCVjDMvVFAPzPDKIAV+xs4fsEpdBRDaMsAgvLZMWzzTdfrWv8dI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=eYITmdvYKIUHOH9tTTp9Vsjhq3Fv8ijCtHacFDP3CjvwQmn3rfS99WBAX4tfDxTwYiHuMvzWDIa3Zzh2eEPYpjbLl4wZDwiBT8432457tLmBFNlfJdtjLP4HQcAIURLuMuavlEW74j7JNpDP2CcL23ffgA7lC+5+fbiX1fBsdd4=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=3eONrA25YZKhTEpdwkpm5IB2Fo8UWIIaMFsjHg3YNSs=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179583215516999.80656127243185;
 Fri, 27 Nov 2026 18:15:55 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH 0/9] drm/tyr: mmu and gpu fault handling
Date: Fri, 27 Nov 2026 23:15:37 -0300
Message-Id: <20261127-tyr-mmu-irq-v1-0-2fcb9f9465cd@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WN0QrCIBhGX0W8TnC/bC5fJXah9lsGbqVuFGPvn
 m5Blwe+75yVJoweE1VkpREXn/w0FmhOhNq7Hm/I/LUwBQ5d04Bk+RNZCDPz8cX0WUvTd7YVRtD
 yeEZ0/r3bLsPBaTYPtLkqfouIr7lk8jH7VxSpDS6h3xvVvwDjRtiWAxgUQi2yOoxOyOwUgs+KO
 Iedlk4i1z0dtu0LEQc/7NEAAAA=
X-Change-ID: 20261127-tyr-mmu-irq-a9a7b86c53b3
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, Laura Nao <laura.nao@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series requests the mmu and gpu interrupts, reports mmu page faults
and gpu faults, and turns off an address space that faults. It is a
continuation of Laura's Job IRQ series [1], which depends in turn on
the gpu reset and workqueue series. Unblocking the workqueue series will
soon unblock all of this.

This assumes the separate interrupt and registration names asked for in
the review of Laura's v7 [2].

Patches 1-4 add the two interrupts on top of the TyrIrq wrapper and log
the faults. Patches 5-8 move the mmu cache maintenance from the
deprecated FLUSH_PT and FLUSH_MEM commands to FLUSH_CACHES, and flush
after an address space is switched to UNMAPPED, like panthor does.
Patch 9 turns a faulting address space off from the mmu interrupt
handler, keeping its VM in the slot.

The mmu interrupt handler holds an Arc<Mmu>. Once Danilo's series using
pin-init self-referential support [3] lands, it will borrow the Mmu
instead.

Tested on the Rock 5B (RK3588) + IGT.

[1] https://lore.kernel.org/r/20260728-tyr-irq-v2-v7-0-4e172e58e28c@collabora.com
[2] https://lore.kernel.org/r/7C7287DF-458B-4AF8-8AB3-B5986E3B808E@collabora.com
[3] https://lore.kernel.org/r/20261118233727.3147222-1-dakr@kernel.org

---
Daniel Almeida (9):
      drm/tyr: request the mmu IRQ
      drm/tyr: report mmu page faults
      drm/tyr: request the gpu IRQ
      drm/tyr: report gpu faults
      drm/tyr: use FLUSH_CACHES instead of FLUSH_PT
      drm/tyr: do not issue a cache flush while one is pending
      drm/tyr: use FLUSH_CACHES when disabling an address space
      drm/tyr: flush the caches after disabling an address space
      drm/tyr: disable an address space that faults

 drivers/gpu/drm/tyr/driver.rs            |  35 +++++-
 drivers/gpu/drm/tyr/gpu.rs               |   2 +
 drivers/gpu/drm/tyr/gpu/irq.rs           | 130 ++++++++++++++++++++++
 drivers/gpu/drm/tyr/mmu.rs               |   1 +
 drivers/gpu/drm/tyr/mmu/address_space.rs |  61 +++++++++--
 drivers/gpu/drm/tyr/mmu/irq.rs           | 179 +++++++++++++++++++++++++++++++
 6 files changed, 400 insertions(+), 8 deletions(-)
---
base-commit: ffe6a7f7e0a826a23c640bae3b931efce5302b5a
change-id: 20261127-tyr-mmu-irq-a9a7b86c53b3
prerequisite-change-id: 20260728-tyr-irq-v2-0b3c5022be33:v7
prerequisite-patch-id: 23e05486d62f5bb42bdfb6c229f1dd621b46f086
prerequisite-patch-id: f85bbce41bbf1ef78496c48c27cc1ff28a004df8
prerequisite-patch-id: ed7cbdc1bc8d27983dd3319198ac0d3c7629e47e

Best regards,
--  
Daniel Almeida <daniel.almeida@collabora.com>

