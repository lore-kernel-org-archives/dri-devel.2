Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679B6606A31F
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ez0ApI5T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFCD10F80D;
	Tue, 27 Oct 2026 20:23:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BFD210F7FF
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 20:22:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 712E7447BD;
 Tue, 27 Oct 2026 20:22:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793132548;
 b=OzEjb330A9e+MmKO79kPC/fJaoR0C0Ukr1vo3Ni0enY1hvrlEJaGUhoHfKjiOCCXvpoT
 wqNp48/ma/gNUy4AixexI8mJV1IUaU/2/Vxo5gYDcQoOF1EXUqMGTn249ixqgzg/kk02A
 GZz0C89thvvebOn5agTGpmC6yIkRvM3nmsOI5RNg4aoWU5vZOLqxlIhxTS90z+s497Uiy
 LgZjLHPmVQjUsm6JKrwEQ3ZupJI8KXO+/TjsrIG84WvIxtl+fanHJY/SeTXvQvmC+huE9
 JEuITyCqJRvdXUirqU825rS7k8ctDqFcJrdL/vKeG5wDZiS2DlcjkIB8D//Arcp30Iw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793132548;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=cZpZWwC/qnoFFpfA1K8kr76klbjFv+9a1KIbKoVjgcs=;
 b=hQ3F/QtDf9JTMu+b71lMt08cOJISMKg7jCg0c7lVyMkFLinnJre5glQGn9izhbOkCvKE
 njdRHEtq86bWOxJxzpKBSuTPGBhMc7D1nq/uj7uy45C4YT6muqZp7GpYYkuwxa0r/Gwkk
 oFcoeDybk+pwVE8QCkvcd+jskTMsqhOIF1Ilg7jFOsFFIK0MNKOHARcy40Zt1W25UGHj+
 XGH8ex8awtt7AZd1ohyHWwY51NlI+XWtpBO46hoXY+oAh6QoCjlIeY605uQ6hDbuybcuv
 Gz0CdCv9Vro2yKtjHi75pIM+G0MrGBShVevxPBoRpV0P8RRMyKiKVtZELyr42mp1mag==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5A4391F01349;
 Tue, 27 Oct 2026 20:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793132548;
 bh=cZpZWwC/qnoFFpfA1K8kr76klbjFv+9a1KIbKoVjgcs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ez0ApI5TWkdfhvo0VBfapoDO+PAkBouwUWADgIhX1+HpEoYMUqV4bZIbl291Rz+oT
 NimKif92pe/byZVUmalKIOYrFm9/5P5gZMz2rLixY52bP/WIXaF2rZPY380zjCjzFN
 e47GHVjos8xT6uSFVSstmSSikmiCHTDze9M52yivsC99/MZijqQnD7rPGqcssZ08e7
 zbbCnoeufu8lsL+0d04BwXX31YeXHIlMnhBeVDajQ/+4rt/DHDlw3w+Nn8cv0fUy8X
 5vIOVMYH9LDL4y7RLHiT/UhyyDl5G3ZvqegujXMRSVsR0t7wJeUoYn0FHD5LCHZjOH
 ZQnt1otOkQ3hA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id BD7614524D;
 Tue, 27 Oct 2026 20:22:10 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:23 -0600
Subject: [PATCH v13 23/39] selftests/dyndbg: add FT_classmap_inheritance
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-dd-cmap-part2-clean-v13-23-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
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
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jason Baron <jbaron@redhat.com>, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=6030;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=kU3BbkimicnKaEsO6g8lweDU0PXEkLfOx492yD4mp0Q=;
 b=/TdghMc4qj/Tz4FD6GB5t8GMeHojtTv8NFkeYhtSsVicxXSwW2OYE49ApKh/hUB+qvs2Fg+/e
 tF7PCRtv8OlCdt0mr4bs2XFsaqmPlNOO4inqmW7Y3Z3E2eJC0Xx+zOR
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jim Cromie <jim.cromie@gmail.com>

Exercise classmap state inheritance between supermod and submod,
verifying that class settings and controlling parameter states propagate
from parent classmap definitions to dependent class users upon module
load and during runtime reconfiguration.

Add FT_classmap_inheritance to exercise classmap parameter propagation
across test_dynamic_debug and test_dynamic_debug_submod. Enable it under
modular_tests and register its 8 golden record checksums.

Uncomment the 5-keyword query in FT_grammar_ok now that commit 12
("dyndbg: bump num-tokens in a query-cmd from 9 to 15") expands
MAX_WORDS to accommodate queries with >9 tokens.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 83 +++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index c279c795867b..cfd438dcf965 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -64,6 +64,7 @@ function ifrmmod {
 }
 
 # Clean up any leftover loaded test modules at initialization
+ifrmmod test_dynamic_debug_submod
 ifrmmod test_dynamic_debug
 
 # ===========================================================================
@@ -189,7 +190,7 @@ function FT_grammar_ok {
 
     # use 4 keywords (max 9 words inc flags)
     ddcmd "module foo file bar.c func buz class D2_CORE +_"	# 4 keywords
-    #ddcmd "module foo file bar.c func buz class D2 line 100 +_" # 5 keywords
+    ddcmd "module foo file bar.c func buz class D2 line 100 +_" # 5 keywords
 
     # 3. Dedicated lineno range grammar assertions (side-effect-free proofs)
     ddcmd "line 42 +_"		# test exact line syntax
@@ -291,6 +292,77 @@ function FT_basic_queries {
     ddcmd "file $f =_" "$f"
 }
 
+function FT_classmap_inheritance {
+    v_echo "${GREEN}# TEST_MOD_SUBMOD ${NC}"
+
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+
+    # modprobe with plain-old +p & 3 class enablements
+    my_modprobe test_dynamic_debug \
+	"dyndbg=+p;class D2_CORE +pf;class D2_KMS +pt;class D2_ATOMIC +pm"
+    verify_control_slice '\[test_dynamic_debug\]'
+
+    set_param 5 /sys/module/test_dynamic_debug/parameters/p_level_num
+    verify_control_slice '\[test_dynamic_debug\]'
+
+    my_modprobe test_dynamic_debug_submod
+    verify_control_slice 'test_dynamic_debug_submod'
+
+    # fresh start, to clear all above flags (test-fn limits)
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+
+    # load submod, which loads supermod
+    my_modprobe test_dynamic_debug_submod \
+	"dyndbg=+p;class D2_CORE +pfs;class D2_KMS +pts;class D2_ATOMIC +pmf"
+    verify_control_slice 'test_dynamic_debug'
+
+    # runtime changes to both
+    set_param 0x57 /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    set_param 4 /sys/module/test_dynamic_debug/parameters/p_level_num
+    verify_control_slice 'test_dynamic_debug'
+
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+
+    # set super-mod params at load-time
+    my_modprobe test_dynamic_debug p_disjoint_bits=0x16 p_level_num=5
+    verify_control_slice '\[test_dynamic_debug\]'
+
+    # see them picked up by submod
+    my_modprobe test_dynamic_debug_submod
+    verify_control_slice 'test_dynamic_debug'
+
+    # load-time (modprobe) and runtime (sysfs write) parameter equivalence
+    local hash_modprobe=$(slice_and_hash_ddctrl '\[test_dynamic_debug.*\]')
+
+    # Fresh load with default parameters, then configure them dynamically at runtime
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    my_modprobe test_dynamic_debug
+    my_modprobe test_dynamic_debug_submod
+    echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 5 > /sys/module/test_dynamic_debug/parameters/p_level_num
+
+    local hash_sysfs=$(slice_and_hash_ddctrl '\[test_dynamic_debug.*\]')
+    if [ "$hash_modprobe" != "$hash_sysfs" ]; then
+        echo -e "${RED}: Load-time vs runtime parameter equivalence check failed!${NC}"
+        exit $ksft_fail
+    else
+        v_echo "${GREEN}: Proven: parameter load-time (modprobe) " \
+            "and runtime (sysfs write) are equivalent!${NC}"
+    fi
+    # --- Live Content Fingerprinting Phase ---
+    log_start
+    echo 1 > /sys/module/test_dynamic_debug/parameters/do_prints
+    echo 1 > /sys/module/test_dynamic_debug_submod/parameters/do_prints
+    log_stop
+
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+}
+
 # Built-in Feature Tests (Can run on any CONFIG_DYNAMIC_DEBUG kernel, modular or monolithic)
 builtin_tests=(
     FT_grammar_ok
@@ -300,6 +372,7 @@ builtin_tests=(
 
 # Modular Feature Tests (Require CONFIG_MODULES=y and test_dynamic_debug*.ko available)
 modular_tests=(
+    FT_classmap_inheritance
 )
 
 # ==============================================================================
@@ -383,6 +456,14 @@ function GOLDEN_RECORDS {
 #K= 02e4fd94602e108cb89bfc70d47a5dad FT_basic_queries.5
 #K= f03a7ca7316e8db4c0e16523dc41e75d FT_basic_queries.6
 #K= c518a50ba30ba8099d0dc874a27ecf16 FT_basic_queries.7
+#K= fb294f02a4207b28b2a874524ef07afd FT_classmap_inheritance.1
+#K= 7a0b87016fdc237077dfe96bbbb3661b FT_classmap_inheritance.2
+#K= 2784d60f5056fc5cc03b3ceb854293f5 FT_classmap_inheritance.3
+#K= bf66aaf8ff612272c0cda29778ed2131 FT_classmap_inheritance.4
+#K= 49fdd29d91a4c1d16f8b59bb431e741b FT_classmap_inheritance.5
+#K= a8aa244285d048b5ebe33061fa99c424 FT_classmap_inheritance.6
+#K= 3060b86a0f553dd5a826bb7023284925 FT_classmap_inheritance.7
+#K= f43e0aff8a4b38435b73d90ed8100d1b FT_classmap_inheritance.8
 EOF
         # Read the K-recs and skip those for tests that can't run
         while read -r line; do

-- 
2.56.0


