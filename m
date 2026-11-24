Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4DC606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTEpcMiS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F5710F3AB;
	Tue, 24 Nov 2026 23:38:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C3110F131
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:38:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 071A545BD1;
 Tue, 24 Nov 2026 23:38:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795563525;
 b=dt5Ca6o5xPN6tV7rxL9jITFV7NZKaAyleU651tE/nCmc4kvwvhr88OOenvP/Pk2SEOI6
 2E+cbulHER9uom+0VSamomsXsP2Ut57jlUZ5Ktap7Hw6XWGHF2WFnSeKCdcthiTQoDXsK
 GEywpybKr0oDZldq7o9yWpzMarR9SxyVVvfBgLBceAlGKs+sHSk57QZZa9xACppo9mfV0
 ONOcB52aPMt/1eT/o4O3SB2uPZqyzMkpE2yamZmgtug2oDkDok9jUmuZ5QMBrpW/9KQSK
 Jr4stB+97a+YpZCWjAU9BN+bEguL7vycdyeVKmK/UzkksuI9ciCAWRXxk3tzZpt1GhA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795563525;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=w8P1ArlBBxla5HU/qS2B2PcMgLEq3zwZp6kL8sQkw98=;
 b=cnU2eUbmcX4bU/Yr0gS5T9w2DxmPL8xbPtBLEWlLnx8Sf6n5gM9AR6lGaWlldJEwUsQD
 KcsavrASt7XMhRS3Aw0iL4uuaSGMx2iPWSnyFe7dw3yu49ttBQX83qDT39VZZ9MnQNLI2
 p7Kn31WiDP2/xwn/B6l3eDfAKrprbclPx2rOqks7i7HDPp4+8xZyAsL8uUR8BDSoxZR1h
 cNMtQ0fRq8DA1t9WYad1f9RSasMrNqedHbREyjU2IUCxxegblxsoTcJiEm88RnHOysIN+
 5gwuKZEl+3thpm4jbAsoOgZt8xrRILM/BYXvzjyg1+hqTkpUCmA1T8cXQIaLUihrILA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id AAD191F000CF;
 Tue, 24 Nov 2026 23:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795563525;
 bh=w8P1ArlBBxla5HU/qS2B2PcMgLEq3zwZp6kL8sQkw98=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=BTEpcMiSj7fL+wCe+pTj4E6FxSpGIFsOdo24FlGD1vcUlBZtIzV7yW2jYmOwvwchk
 A6auM0novQqoM+j36c3JYOQ2QZaXBZ1LByrcYbAkTsumTCeVrIbvj2QgTilL3Tbuwt
 cFC+jDIFjsPJ4iE/WGQ89L9c4OiduY58rOQPe3MhcXwQNSwK6+gEzn7Ek5X914kGcZ
 d49GUV9pc4/ffyJYD7/nSszKJSnfvl3NZHFGJWJBHEDlzGqjee8+0dURhqo8n2Nsbp
 vmy5mjrWibTnY0dmPT1PAtihA5AkuSHVnzOruJrFJe3IIt4kor4PZy5poaKJRTkM0u
 4abfI4umSi0bg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 3CFCD4CC63;
 Tue, 24 Nov 2026 23:38:34 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 16:38:34 -0700
Subject: [PATCH v4 2/3] drm/print,dyndbg: restore __drm_debug to uint from
 ulong
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261124-rd-mostly-v4-2-26d60beb6666@gmail.com>
References: <20261124-rd-mostly-v4-0-26d60beb6666@gmail.com>
In-Reply-To: <20261124-rd-mostly-v4-0-26d60beb6666@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Luca Coelho <luciano.coelho@intel.com>, Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795563513; l=5086;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=eas3Enj72cy5HyxvJIJLFk8ksG6u9MHGL2Mg4irO398=;
 b=O88JsASHmV4aIoMC/SeHmzOMn0NdbiUcmyaVTfOP8BL0gKXph8tnKGGjSFq4LY5wW8gK2xLz2
 1ahJEVdhVwND6a41W4F0YM6zMNqajMidcDFE9pF83s60uLFkoDcH/YR
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

  # 64 bits would be unwieldy here
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
---
 drivers/gpu/drm/drm_print.c   | 4 ++--
 include/drm/drm_print.h       | 2 +-
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 8 +++++---
 lib/test_dynamic_debug.c      | 2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 50cdeb1b15e2..2e7685849f44 100644
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


