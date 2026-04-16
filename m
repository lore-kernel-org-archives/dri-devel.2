Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C628F8D761
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 17:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC68A10E90B;
	Thu, 16 Apr 2026 17:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="vAMM70gC";
	dkim-atps=neutral
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CB710E90B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 17:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1776359933; x=1776619133;
 bh=ZlV3uOyvSUBIo/AvhkZNKVYS6qwS9w3cABtHVctN/Gw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=vAMM70gClZUqppkJUxzVZPWpx+LpMlAXux9LbhisJ+f/OrzMUOjFjjZzMdM8cE1MP
 o7YZazitqBOjLDs2qah7H0ez9lv7Co2YoAFpyzpOpO43GXqebrkjLzo2lQUvh5PdI5
 STPAsuKabCauQDppXbQlNnLlVcPL6V2wNPuIrCip66aBM9BxfCyN8vWOHCF3cNOmHs
 RSyVA2nZPsxtDCxlfs4pBUt7ujLv/B3wCE0IG8rcEDaP1uVokA+MpD7WpWwq6gzpYE
 LWBuXlDXFzwdc75pjrCLSRlXkyPeq52Rlc26fSxHW2DM6mca70hVgf4rU5eHCEcOkn
 0fzytqpdp+7xA==
X-Pm-Submission-Id: 4fxPqv0tJRz1DDns
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org,
 rostedt@goodmis.org
Cc: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v2 2/4] MAINTAINERS: add Rust SRCU files to SRCU entry
Date: Thu, 16 Apr 2026 20:18:38 +0300
Message-ID: <20260416171838.206128-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260416171838.206128-1-work@onurozkan.dev>
References: <20260416171838.206128-1-work@onurozkan.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Add the Rust SRCU helper and abstraction files to the SRCU
entry and add Onur Özkan as a maintainer for the Rust SRCU
pieces.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 353f221c12e1..f38ef80c5e69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24403,6 +24403,7 @@ F:	drivers/net/can/slcan/
 
 SLEEPABLE READ-COPY UPDATE (SRCU)
 M:	Lai Jiangshan <jiangshanlai@gmail.com>
+M:	Onur Özkan <work@onurozkan.dev> (RUST)
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
 R:	Steven Rostedt <rostedt@goodmis.org>
@@ -24413,6 +24414,8 @@ W:	http://www.rdrop.com/users/paulmck/RCU/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
 F:	include/linux/srcu*.h
 F:	kernel/rcu/srcu*.c
+F:	rust/helpers/srcu.c
+F:	rust/kernel/sync/srcu.rs
 
 SMACK SECURITY MODULE
 M:	Casey Schaufler <casey@schaufler-ca.com>
-- 
2.51.2

