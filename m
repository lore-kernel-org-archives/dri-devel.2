Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6D6C982CF
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22DE210EC4A;
	Wed, 16 Sep 2026 15:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="u3x5V4yv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46C810E3CF
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 15:33:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1411B43A47;
 Wed, 16 Sep 2026 15:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5896C2BCB3;
 Wed, 16 Sep 2026 15:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789572782;
 bh=4tBoL20Lq4iw5ATrhUM/tahGCAQuI1T++gRkOEKTNiw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=u3x5V4yvXbRR0I395sTK/gZwbT6ujbPJbHQ1EXs4buecFimpKK4FExOXciIKVCxwa
 pCYA4c305rIwZDwb2vN1Ndn0vwFO3bonoBHRomzayuYHvg0vplIjdqgeTX9CmkQSQ7
 sUqHR5b8zSXv6+4NNC0+rrCQKpUMWkAFIdREDOSimJBPA6jkyvqoluYcjpTyxZg4vN
 ABYUTwdCFdagDexebpylR3Q+gW/tKOKJr/zzj944e0U89Afwfc/920fpTRurb4BNwt
 H+vuio/x63LdtEnU95UgQr9m9YsDQ1s+cwk65rWNKZRqM9Nu3jrQI1/J0r9Nu682uv
 SWfxgh445SAVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BF672C982CF;
 Wed, 16 Sep 2026 15:33:02 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Wed, 16 Sep 2026 09:33:22 -0600
Subject: [PATCH v10 30/38] selftests: enable comma-terminator tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-dd-cmap-part2-clean-v10-30-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789572777; l=2396;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ZtnNYHB84SuIr5SgDiLk/1HZgha9qoZYGJ306frMt90=;
 b=Y+7qsD4xlGsL3watov/5txzm2zCl99Q0mJu8KCdFHuF2l+0Tgn8iYUF29ShrccOjq4Eu9dy+6
 ONI2Nzw7zn9CfAfDMLmuaDk/vDSAGZlzdZ9CCLDaqP4ZtX9M7qX6dRs
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
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
Reply-To: jim.cromie@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Jim Cromie <jim.cromie@gmail.com>

Enable the FT_comma_terminators test block in dyndbg_selftest.sh to
verify control query parsing when queries are terminated by commas.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index d485b9245164..bd72a718406c 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -347,6 +347,25 @@ function FT_basic_queries {
     ddcmd "file $f =_" "$f"
 }
 
+# test parsing on spaces, commas. testing against builtin file kernel/params.c
+function FT_comma_terminators {
+    v_echo "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
+    if [ $LACK_DD_BUILTIN -eq 1 ]; then
+	echo "SKIP - test requires dynamic_debug built into kernel"
+	return
+    fi
+    local f='kernel/params.c'
+    ddcmd =_
+    ddcmd "file $f +p" "$f"
+
+    ddcmd "file,$f,=_" "$f"
+    ddcmd "file,$f,+mf" "$f"
+    # ignore empty tokens
+    ddcmd ",file ,, ,  $f, -p" "$f"
+    ddcmd " , file ,,, ,  $f, -m" "$f"
+
+    ddcmd =_
+}
 # testing classmap-based query enablers and class configurations
 function FT_test_classes {
     v_echo "${GREEN}# TEST_CLASSES - classmap-based query enablers and class configs ${NC}"
@@ -454,6 +473,7 @@ builtin_tests=(
     FT_grammar_ok
     FT_grammar_errs
     FT_basic_queries
+    FT_comma_terminators
 )
 
 # Modular Feature Tests (Require CONFIG_MODULES=y and test_dynamic_debug*.ko available)
@@ -544,6 +564,11 @@ function GOLDEN_RECORDS {
 #K= 02e4fd94602e108cb89bfc70d47a5dad FT_basic_queries.5
 #K= f03a7ca7316e8db4c0e16523dc41e75d FT_basic_queries.6
 #K= c518a50ba30ba8099d0dc874a27ecf16 FT_basic_queries.7
+#K= c8bbbac639f244ed9088208ebb7d83a6 FT_comma_terminators.1
+#K= bed6350f058f600910837dae83a12f56 FT_comma_terminators.2
+#K= 6e8599556a312200fb6d484565b6c52f FT_comma_terminators.3
+#K= 68b329da9893e34099c7d8ad5cb9c940 FT_comma_terminators.4
+#K= adc1ef04304c861c87fe294a8ba4e402 FT_comma_terminators.5
 #K= 8f18ea82c09460434b6e9e4cd12543e8 FT_test_classes.1
 #K= a15ec4843acd721fbdfddc0b512c8032 FT_test_classes.2
 #K= 20d4545f9753e677e72e3adf52527fd3 FT_test_classes.3

-- 
2.55.0


