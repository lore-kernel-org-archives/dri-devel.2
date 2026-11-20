Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956260A260F
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhJP4wuc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5CC910E143;
	Fri, 20 Nov 2026 17:19:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44D310E21A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 17:19:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4762C60F38;
 Fri, 20 Nov 2026 17:19:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795195145;
 b=qYjJOAWPmiI70Ug1R9Pj46AlXSuLb/cclDHdpHdHX54S4VRAObdoh1wIJ3xb1B7dovxe
 SKkdm9ituSalXXAQkfXUpkVYvgdz7LoV78fw2w4SdYw4UtnHFm5oLztDkLmX0qNlhdJYS
 PhAA+pvj9q9ptHQVAUIqEcX40pA/R02eAMMtensRSX8NIaz3VCalb2zxtXsoVDHogAxzX
 a2HBGSvHoSG0FcHm9kCfGVZmfTQr4NrDpm/KWIWrqfL+h7ogIsfLOg6inDLrq9rSFvj2z
 jg6xv7pQsOK02ovxYr9W4lR+YauWB0BdQxn9Z8MpPYB0WiCRKNIAjsNKg3ALQe/0ktQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795195145;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Ic8hpy/DzzKThKZxRlGT3Qexz29wBpDBzwWYSWNK43s=;
 b=L410PRbtFzGHNLXOoJ4C8RvEZL0RZEP2nahQjQdMNFCB3ry7tIooXxNzC2hGEqlhEknL
 jjJIrZFIYjQB82S7vYN1Io5xh1dO5We7GoboHgY6sAARVsZj9nYZem2aYc5fR4dIgbBmZ
 ZU3Hd1cZpr4ct56biqBcR1Q4/z770aAMaT0IokC9aX8WwnuSttE4I85/LxZQlo8KWjJKi
 JT+ml/oa2JNsPu4chEZRXkF8dRHRq6Wy0s2EBWtR2E7uBxR/40OkVVnPnQWFMZb8NYytu
 oCY4DedmlO1WvMuDpXmgtXtB3fiIq6GfiTLI4M2dBpZhkkpcxsaRh8vjiQBBe9Y1GKw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id E39311F000D2;
 Fri, 20 Nov 2026 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795195145;
 bh=Ic8hpy/DzzKThKZxRlGT3Qexz29wBpDBzwWYSWNK43s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=AhJP4wucoO5PVKLTDHKBr8XPMxJCu3vUceIc5Dvq46Ew1PkT1DwkQwvZ+dYTLC5u+
 PC7Wi6eW2WC5yoN1k3GmQvfu35mxOdfztyVq4R+ol3fRl6tSw7tQxRLVKHNp3o4EoS
 nuKENdCs98m+TsbjoqC68thFsXkGiuiKCxy3Jet+1xBLrtlI8xPTg4JUPt+HmHuUQN
 PsS2DQR7pk3wQ9tybarvP7R4ats/NUY4L+fRm/DXInslZBNNOmM6D0oosbrSYE6L3d
 FLCsh2Rs2oGD3+QDi1InW9GmlSJC4KpZAI7IqxcA5TqyUJwqvoz6CxNFDqzX3fVmjg
 i3J3G1fTFKUMA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7251C4B881;
 Fri, 20 Nov 2026 17:18:46 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 10:18:31 -0700
Subject: [PATCH v2 4/5] drm/print,dyndbg: restore __drm_debug to uint from
 ulong
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-rd-mostly-v2-4-88056ede02a8@gmail.com>
References: <20261120-rd-mostly-v2-0-88056ede02a8@gmail.com>
In-Reply-To: <20261120-rd-mostly-v2-0-88056ede02a8@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795195125; l=5128;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=jvtUrAcvfC0M5/oracS++d2aBUCCnKRON82NJHdhrJA=;
 b=bM8AMVAccPgKdjzWanMmIx/LENgxcDcn/zFBQDQYNe6U+r1gP2PlHlcBzPNaSjcRWzOJmi+4G
 U7eXx9uaTt7BVrhAvHyG1NwnQMP+gjoL45/Ou+/F5OKxg4agmGfMA90
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: jim.cromie@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jim Cromie <jim.cromie@gmail.com>

Restore __drm_debug and struct ddebug_class_param.bits to uint from
ulong; 64 flags is more than we will ever need, and is not effectively
usable with the interface:

  # 64 bits would be unwieldly here
  echo 0x12345678 > /sys/module/drm/parameters/debug

drm_debug_bitmap.bits points at extern __drm_debug so dyndbg updates
it as shared state for drm_debug_enabled() and other ad-hoc debug
checks outside classmaps' remit. That pointer coupling requires
__drm_debug, module_param_named(..., uint), and
ddebug_class_param.bits to change together in one commit.

Accordingly, update lib/dynamic_debug.c to pass the local unsigned
long `old_bits` to ddebug_apply_class_bitmap() (which uses
test_bit()), format with 0x%x in param_get_dyndbg_classes(), and
shrink DD_SYS_WRAP's backing variable in lib/test_dynamic_debug.c to
unsigned int.

Fixes: b9400852c080 ("dyndbg: add drm.debug style (drm/parameters/debug) bitmap support")
Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

dyndbg: fix dd for __drm_debug shrink
---
 drivers/gpu/drm/drm_print.c   | 4 ++--
 include/drm/drm_print.h       | 2 +-
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 8 +++++---
 lib/test_dynamic_debug.c      | 2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 12b95901eb70..85847c01c95e 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -40,7 +40,7 @@
  * __drm_debug: Enable debug output.
  * Bitmask of DRM_UT_x. See include/drm/drm_print.h for details.
  */
-unsigned long __drm_debug __read_mostly;
+unsigned int __drm_debug __read_mostly;
 EXPORT_SYMBOL(__drm_debug);
 
 MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
@@ -56,7 +56,7 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 "\t\tBit 9 (0x200) will enable DRMRES messages (managed resources code)");
 
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-module_param_named(debug, __drm_debug, ulong, 0600);
+module_param_named(debug, __drm_debug, uint, 0600);
 #else
 /* classnames must match vals of enum drm_debug_category */
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 0805903c093b..d3c302a770e9 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -39,7 +39,7 @@ struct drm_device;
 struct seq_file;
 
 /* Do *not* use outside of drm_print.[ch]! */
-extern unsigned long __drm_debug;
+extern unsigned int __drm_debug;
 
 /**
  * DOC: print
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 05743900a116..dc21e3a8e86f 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -124,7 +124,7 @@ struct _ddebug_info {
 
 struct ddebug_class_param {
 	union {
-		unsigned long *bits;
+		unsigned int *bits;
 		unsigned int *lvl;
 	};
 	char flags[8];
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 18a71a9108d3..644f87d6969c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -681,8 +681,9 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits);
 			*dcp->bits = curr_bits;
+			old_bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
 			break;
@@ -754,7 +755,8 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits);
+		old_bits = *dcp->bits;
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, &old_bits);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -796,7 +798,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	case DD_CLASS_TYPE_DISJOINT_NAMES:
 	case DD_CLASS_TYPE_DISJOINT_BITS:
-		return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
+		return scnprintf(buffer, PAGE_SIZE, "0x%x\n", *dcp->bits);
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 77c2a669b6af..2fb9b3889f67 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -40,7 +40,7 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
  * - tie together sysname, mapname, bitsname, flagsname
  */
 #define DD_SYS_WRAP(_model, _flags)					\
-	static unsigned long bits_##_model;				\
+	static unsigned int bits_##_model;				\
 	static struct ddebug_class_param _flags##_model = {		\
 		.bits = &bits_##_model,					\
 		.flags = #_flags,					\

-- 
2.56.1


