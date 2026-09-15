Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92764C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B78E510FBCE;
	Tue, 15 Sep 2026 11:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j3rMRnP4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB0FF10FBCE
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:36:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 50DB3433C1;
 Tue, 15 Sep 2026 11:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5001F00893;
 Tue, 15 Sep 2026 11:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789472182;
 bh=oZh0vLqcxduUWTFynumJFhxFNW42oEX6Rn3UwZlew10=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=j3rMRnP4Yq76LugZgcTC3Qf0Ci80ZsR1Bjf4RalPTu0XQJWg3exDlCNJpfFK/5MxM
 WYaKKc+iEEvUbRPZPKxBSCicd83hSTqA7oZhBEyYRVXy1eWTpEG9V0qCpYWagSWyJM
 LMC9aTfO6/vIRu0BhEoAicivAddy21JTUJ9Ey/WFXSkOgO7lRUm/69w2OsJiTlTGJJ
 PVaIxbRP2QqlmQ8miseIjAxpQqw4BFWTU0OlqdE4kvqHra2NIRZhFlj+TvL3m+l5UE
 la7dnSw8kYUKUgJ4W/pOpOV1l55Kv3959gLF9FNT0wDZZqyVfgaqZTmzG3/cOJbMQV
 93dOclKCiZGPQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:25 +0200
Subject: [PATCH RFC POC 39/50] seccomp: stop putting the listener
 descriptor back on failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-39-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SoVog+6B8HBuyIDP19b0KqkTeSBHFQ/u5Q+O82974JE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kl7drfm0vIrUa8YdK4pvXG67XDtwdnLWZ9s8lgOH
 X5/t2WKdEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEGD4xMjwJva2x4G9RxkHX
 XU1ZZuuPNKZYpJh/z8h6/EhWU//pvNcM/2vKj01as7z7q8HKc/dLTVZVbHkiJn/kXu5zo+cFdn4
 LL/MDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/seccomp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 86cf4460d69e..dc275ab1e031 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1957,7 +1957,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	const unsigned long seccomp_mode = SECCOMP_MODE_FILTER;
 	struct seccomp_filter *prepared = NULL;
 	long ret = -EINVAL;
-	int listener = -1;
+	const struct fd_slot *listener = NULL;
 	struct file *listener_f = NULL;
 
 	/* Validate flags. */
@@ -1990,15 +1990,14 @@ static long seccomp_set_mode_filter(unsigned int flags,
 		return PTR_ERR(prepared);
 
 	if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
-		listener = get_unused_fd_flags(O_CLOEXEC);
-		if (listener < 0) {
-			ret = listener;
+		listener = fd_prepare(O_CLOEXEC);
+		if (IS_ERR(listener)) {
+			ret = PTR_ERR(listener);
 			goto out_free;
 		}
 
 		listener_f = init_listener(prepared);
 		if (IS_ERR(listener_f)) {
-			put_unused_fd(listener);
 			ret = PTR_ERR(listener_f);
 			goto out_free;
 		}
@@ -2038,11 +2037,9 @@ static long seccomp_set_mode_filter(unsigned int flags,
 		if (ret) {
 			listener_f->private_data = NULL;
 			fput(listener_f);
-			put_unused_fd(listener);
 			seccomp_notify_detach(prepared);
 		} else {
-			fd_install(listener, listener_f);
-			ret = listener;
+			ret = fd_stage(listener, listener_f);
 		}
 	}
 out_free:

-- 
2.53.0

