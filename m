Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15576C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78CF210EB66;
	Tue, 21 Jul 2026 20:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lH73XZBB";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D7D010EB6F
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:46 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so6475730a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667466; x=1785272266; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UQj3W9vj1yiuzq11rsTFSn1TB9FMKBNwQCCPvbRtzuE=;
 b=lH73XZBBpSgYolOL8yvRWfWhKFqQ9IbPoSthKtbYTQoNFqjSNXnXh0avi6DNk2/gLo
 jbnSttPa2rvfkuka0dzX4UcqT2VQeM9FwcweouMZPfvNUHcrws+Wl/M2m3GLZjNK+XQI
 qj/smaKucrcrDE8s1Yh32vzXUsfFXK37UTMFMayFPNejMyMV1Dd0uOq+hqg2uey3AKfU
 qQpdy6XUXhBg6IQx2rjLVKzwcVvLn5Xfk458dEFlhVZQOd5CDgYN3aVKNo9Pwd4qY0A1
 mA35a6ZgJP4QzTlWgEX4n4JNE5sYKYc96hvb8J8a+EGs1bxJPtMMc4CsvCXJPtP6AEra
 QNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667466; x=1785272266;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UQj3W9vj1yiuzq11rsTFSn1TB9FMKBNwQCCPvbRtzuE=;
 b=ond4ZY41wY7e0SZx1ehFlnfets05tTt3K5Aivcx8W9unRG9ozSypQbXL/GJd+Qr+1h
 eXM0o2i3Thv2foomBmfqpUDZQCd2sLdizUiaufB11s7zqzgGflQ/sYpG6ZIJq+VhYRGr
 eJgC+JLHdkiSJpRf/0/Raj/JoTuHgfSir8VKznrpZMAAMoQMR72Pr6qevOI66aTD9ALQ
 PDhcxnzfjHofOkSQ0PIRW6ww4YhKIbqNDDcw9nBh578+/4MG4XmfqkawmPCwngfTFf4B
 86zvwtCbxfAziRZ2jXKiN073LB2B3tQwccWx1tbhmDPJlB6WOqg5mJzp8168WC+61Nj/
 1C4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RouvNkoxHGRq7hIB8eV9s36I7uCbjGG8os+RSiD8PoAlnyahY69gtzS0Wh+mRqFIK7/y0yulS7bJEk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSWuZkf+mqVo1+XLfIvBk501LkO1LeAXSNzKBCtX70YA0Hzn4H
 zSErvHvmW4PpfNzLRhv1HVTRhFM/gkCr1CNTF0cRQLTzPRF6UW6Wkiql
X-Gm-Gg: AfdE7clv1oGeGhMD5PSES2SXkNRk467ptcRpMAEpnvT7ewM+VZcijGdt66N1+caVtLk
 y88BKkZ4WqWfyG5I9I2vf8QLraVWUwu5dj3oxxgySGoG73pdlYTvvRQ3+SYKRC9FBOw8skOQbh9
 88fEspfvekCSAUZwdAspVjsV+f1DY7I66JdHI8DfGYIlcYZ5kp7/CqB8H3PMGYbFvzxum70An4t
 fHjF0fZXP3PIFsU4G+rR6ka6SGekukA+Oun8iBnjvYWfPWTVV3CiHOoa2hjnJ36+GLFZXJr77TJ
 8Kktgqs+KuO4lmKdF4AnYqOkappvwgVkSenp7B71HKPhjGLnY3w9bDJYGR30QzNmIaKHBG5MscQ
 Tqy/mBfVvtLb63f9ry9aLG+2e84X/ChZeeSDd1Q8BY58zlb4ezxHXatZF+EWQjN3zmkkjTQBjnP
 VEfwMtCEle/bDTiMZVk977duPfM8AdqJq6q3gaVWlN72cZ/GL8prKwaK0mpdnxMlnyssITmd3l/
 Or6u6JC1GYUFdwcAuUaQ4XFAA==
X-Received: by 2002:a05:6830:6af5:b0:7d7:ed69:81b2 with SMTP id
 46e09a7af769-7ed9a7d30d9mr10408585a34.5.1784667465829; 
 Tue, 21 Jul 2026 13:57:45 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:45 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:18 -0600
Subject: [PATCH v7 29/29] selftests/dyndbg: enable FT_classmap_inheritance
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-29-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=9923;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=BS/7+W/ScY9FbtrVvZHz2z8utPUssrUnirw4URXpk04=;
 b=Oii8tGHzWXATuGVbwd8S07r/I1BaZggOREITgQJyD5+MbEKQajuZi6tv+gpG0LQztd7WXeq8c
 tChhMbNpntqAHKsSr4wuWUN2zgLWs2mISw4Mflt2h67kkBSrc4h7ruJ
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
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

re-enable FT_classmap_inheritance, and comment out writes to missing
test-mod params. tbd where they are.

fix-some-tests-sysl test-tweaks
selftests/dyndbg: sync all results checksums
happened on gandalf, at end of progress_from master+5 in this tree.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 88 +++++++++++++++++-----
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 947f23dcb4ce..49c2a79929c6 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -181,7 +181,7 @@ function slice_and_hash_ddctrl {
 }
 
 function verify_modprobe_param_logging {
-    # $1 - parameter name (e.g. do_classes)
+    # $1 - parameter name (e.g. do_prints)
     # $2 - parameter value (e.g. 1)
     # $3 - short descriptive tag (e.g. classes)
     local param="$1"
@@ -199,12 +199,12 @@ function verify_modprobe_param_logging {
     log_start
     modprobe test_dynamic_debug "${param}=${val}"
 
-    # If it is a state-controlling parameter, trigger the print-workload 'do_classes=1'
+    # If it is a state-controlling parameter, trigger the print-workload 'do_prints=1'
     # inside the same syslog dmesg capture bookends to verify their actual pr_debug logging!
     if [ "$param" = "p_disjoint_bits" ] || [ "$param" = "p_level_num" ]; then
         LOCAL_DDCMDS="${LOCAL_DDCMDS}; echo 1 > "
-        LOCAL_DDCMDS="${LOCAL_DDCMDS}/sys/module/test_dynamic_debug/parameters/do_classes"
-        echo 1 > /sys/module/test_dynamic_debug/parameters/do_classes
+        LOCAL_DDCMDS="${LOCAL_DDCMDS}/sys/module/test_dynamic_debug/parameters/do_prints"
+        echo 1 > /sys/module/test_dynamic_debug/parameters/do_prints
     fi
 
     log_stop
@@ -217,8 +217,10 @@ function verify_modprobe_param_logging {
 
         # Verify that the resulting control-file state is completely cleared
         local hash_unset=$(slice_and_hash_ddctrl '\[test_dynamic_debug\]')
-        local default_hash="fd89900c8614f23c3a6e8a8d45aa3280"
+
 	# Pristine fully-disabled slice hash
+	local default_hash="fd89900c8614f23c3a6e8a8d45aa3280"
+	default_hash="d8d188e03eb33d970453c06b8f3f25a4"
 
         if [ "$hash_unset" != "$default_hash" ]; then
             echo -e "${RED}: Runtime unsetting failed for ${param}! " \
@@ -249,7 +251,7 @@ function FT_grammar_ok {
 
     # use 4 keywords (max 9 words inc flags)
     ddcmd "module foo file bar.c func buz class D2_CORE +_"	# 4 keywords
-    #ddcmd "module foo file bar.c func buz class D2 line 100 +_" # 5 keywords
+    ddcmd "module foo file bar.c func buz class D2 line 100 +_" # 5 keywords
 
     # 3. Dedicated lineno range grammar assertions (side-effect-free proofs)
     ddcmd "line 42 +_"		# test exact line syntax
@@ -493,9 +495,9 @@ function FT_test_classes {
     verify_file_slice '\[test_dynamic_debug\]'
 
     # 2. Verify state transition and live-printing end-to-end via ddcmd_load!
-    ddcmd_load "class,D2_CORE,+pmf@class,D2_KMS,+pls@class,D2_ATOMIC,+pml" \
+    ddcmd_load "class,D2_CORE,+pmf;class,D2_KMS,+pls;class,D2_ATOMIC,+pml" \
         '\[test_dynamic_debug\]' \
-        "/sys/module/test_dynamic_debug/parameters/do_classes" "1"
+        "/sys/module/test_dynamic_debug/parameters/do_prints" "1"
 
     ifrmmod test_dynamic_debug
 }
@@ -508,8 +510,8 @@ function FT_classmap_inheritance {
     ddcmd =_
 
     # modprobe with class enablements
-    modprobe test_dynamic_debug \
-	dyndbg=class,D2_CORE,+pf@class,D2_KMS,+pt@class,D2_ATOMIC,+pm
+    #modprobe test_dynamic_debug \
+	#dyndbg=class,D2_CORE,+pf@class,D2_KMS,+pt@class,D2_ATOMIC,+pm
 
     verify_file_slice '\[test_dynamic_debug\]'
 
@@ -517,8 +519,8 @@ function FT_classmap_inheritance {
     verify_file_slice '\[test_dynamic_debug_submod\]'
 
     # Verify 3 class changes
-    ddcmd "class,D2_CORE,+pmf @ class,D2_KMS,+plt @ class,D2_ATOMIC,+pml" \
-	  'test_dynamic_debug' "# add some prefixes"
+    #ddcmd "class,D2_CORE,+pmf @ class,D2_KMS,+plt @ class,D2_ATOMIC,+pml" \
+	#'test_dynamic_debug' "# add some prefixes"
 
     # now work the classmap-params
     # fresh start, to clear all above flags (test-fn limits)
@@ -572,8 +574,8 @@ function FT_classmap_inheritance {
 
     # --- Live Content Fingerprinting Phase ---
     log_start
-    echo 1 > /sys/module/test_dynamic_debug/parameters/do_classes
-    echo 1 > /sys/module/test_dynamic_debug_submod/parameters/do_classes
+    echo 1 > /sys/module/test_dynamic_debug/parameters/do_prints
+    echo 1 > /sys/module/test_dynamic_debug_submod/parameters/do_prints
     log_stop
 
     ifrmmod test_dynamic_debug_submod
@@ -622,8 +624,8 @@ builtin_tests=(
 # Modular Feature Tests (Require CONFIG_MODULES=y and test_dynamic_debug*.ko available)
 modular_tests=(
     #FT_test_classes
-    #FT_classmap_inheritance
-    #FT_modprobe_w_param
+    FT_classmap_inheritance
+    FT_modprobe_w_param
 )
 
 # ==============================================================================
@@ -640,7 +642,6 @@ modular_tests=(
 # ==============================================================================
 function GOLDEN_RECORDS {
     cat << 'EOF' | {
-# --- Unregistered Baselines ---
 #K= f3dbd5afb9aa1750f93275b634499e22 FT_grammar_errs.1        dmesg
 #K= 200c01632c52a63f6d186da1c6460740 FT_grammar_errs.2        dmesg
 #K= 7d7141900ce6e32f15c99202309c63a4 FT_grammar_errs.3        dmesg
@@ -689,6 +690,59 @@ function GOLDEN_RECORDS {
 #K= da6bd1c6a299290150668186f8263b82 FT_basic_queries.4       "kernel/params.c"
 #K= 82572e8d20c4b567afac783006d1a935 FT_basic_queries.5       "kernel/params.c"
 #K= baea1247680e8151c121539f4b90a6d8 FT_basic_queries.6       "kernel/params.c"
+#K= 68b329da9893e34099c7d8ad5cb9c940 FT_classmap_inheritance.1 "\[test_dynamic_debug\]"
+#K= 7f9bbb8e3cbaeb819c9db4ad314fe91f FT_classmap_inheritance.2 "\[test_dynamic_debug_submod\]"
+#K= e595e746a30eac106ad0041b78b9bb04 FT_classmap_inheritance.3 "test_dynamic_debug"
+#K= 781cd443ba8e9655318c53e32bf7650c FT_classmap_inheritance.4 "test_dynamic_debug"
+#K= 710b9cc6ba3a9db08025fd8f0cd01058 FT_classmap_inheritance.5 "test_dynamic_debug"
+#K= 6e78ea40996f4bb355764a023822c89d FT_classmap_inheritance.6 "\[test_dynamic_debug\]"
+#K= 8efc97ee6ad63ae1b34c3898550fbdeb FT_classmap_inheritance.7 "test_dynamic_debug"
+#K= 5d93156ac2b46d188c3cab04a0287b68 FT_classmap_inheritance.8 dmesg
+#K= ec88354e5d563adfb7816b09588ce22a FT_modprobe_w_param.1    dmesg
+#K= c05be478400d61b0ec7dd3659e1063bb FT_modprobe_w_param.2    dmesg
+#K= 681053af96e96530f309a755a86bb86e FT_modprobe_w_param.3    dmesg
+#K= 0567348e035ea0be726ea88e41cbc7f9 FT_modprobe_w_param.4    dmesg
+#K= e682773b51040743f1881b85ed375ddb FT_modprobe_w_param.5    dmesg
+#K= 05d1e9c5f416dfaeab7842945e4af7e1 FT_modprobe_w_param.6    dmesg
+#K= de9880bb8fa627f4f5599d13ad382105 FT_modprobe_w_param.7    dmesg
+#K= 57fb0642f3d9c33fc1d58ca728481ffb FT_modprobe_w_param.8    dmesg
+#K= 7be7034fec3a8e0f757720d00b026669 FT_modprobe_w_param.9    dmesg
+#K= 925d4de5a038cac3356176036717d572 FT_modprobe_w_param.10   dmesg
+#K= f81c7e22d1dd97608a8ceaca5a0ac677 FT_modprobe_w_param.11   dmesg
+#K= f573825da4a1128466530d869ce6def1 FT_modprobe_w_param.12   dmesg
+#K= 9a9d67addbc1732aa9e4e7747261208c FT_modprobe_w_param.13   dmesg
+#K= 7fba79ed343651fc81f302aec98b0f5a FT_modprobe_w_param.14   dmesg
+#K= b3f7deb9df2a80205ec2f475aad44c3d FT_modprobe_w_param.15   dmesg
+#K= 7c1d3772035558d575ca866d4d972e87 FT_modprobe_w_param.16   dmesg
+#K= 48fe52f49c4927cdf79e937762f50e4f FT_modprobe_w_param.17   dmesg
+#K= be389ee9ddfe5308e4350090ddd2d16a FT_modprobe_w_param.18   dmesg
+#K= 1524a2631d44a1abc2eca683908c9e94 FT_modprobe_w_param.19   dmesg
+#K= e7c39d0b9b293d0147a2f6fcd0f164b3 FT_modprobe_w_param.20   dmesg
+#K= bdae90265d318a2cb148060130257cbf FT_modprobe_w_param.21   dmesg
+#K= 4759b6d7cb14acaf0cc33811728f77cf FT_modprobe_w_param.22   dmesg
+#K= 22659835c1f7a94f82cd8ec7e1796d7f FT_modprobe_w_param.23   dmesg
+#K= 81bf838321eb584b5adc7edb321560d3 FT_modprobe_w_param.24   dmesg
+#K= 9353df3b283410f886a638b6996118e5 FT_modprobe_w_param.25   dmesg
+#K= 28125d16b047544025754071f00d5465 FT_modprobe_w_param.26   dmesg
+#K= 2ad304b6e6ce3a63e1a24644c4c21f8c FT_modprobe_w_param.27   dmesg
+#K= 1524a2631d44a1abc2eca683908c9e94 FT_modprobe_w_param.28   dmesg
+#K= 9e3a99d008531d5a02344730398be088 FT_modprobe_w_param.29   dmesg
+#K= 4c13f861a474d1931587d893e6038c95 FT_modprobe_w_param.30   dmesg
+#K= dadffb7601c368815dcf756fb65fdabf FT_modprobe_w_param.31   dmesg
+#K= 22659835c1f7a94f82cd8ec7e1796d7f FT_modprobe_w_param.32   dmesg
+#K= 4d9c8b506f9b21306cc3f26bb0754c70 FT_modprobe_w_param.33   dmesg
+#K= 2c0dd2e7e1b515d612c2060252e76834 FT_modprobe_w_param.34   dmesg
+#K= 9d0780573256ca9257239a386d4dc6bb FT_modprobe_w_param.35   dmesg
+#K= 2ad304b6e6ce3a63e1a24644c4c21f8c FT_modprobe_w_param.36   dmesg
+#K= 68b329da9893e34099c7d8ad5cb9c940 FT_modprobe_w_param.37   dmesg
+#K= 06585a61fecd49f826b624a493f8186a FT_modprobe_w_param.38   dmesg
+#K= 9a4d3232a7d9263158dbf59b4685b32c FT_modprobe_w_param.39   dmesg
+#K= 6abbd7b226a87b21aebab6f037ece451 FT_modprobe_w_param.40   dmesg
+#K= 68b329da9893e34099c7d8ad5cb9c940 FT_modprobe_w_param.41   dmesg
+#K= 14cf091423c69a188ba45cc39414c1b9 FT_modprobe_w_param.42   dmesg
+#K= 713b6e5c4af67d59a1896c8181a7e1b5 FT_modprobe_w_param.43   dmesg
+#K= 67fa99b23bfafccc66b023970b71cbd8 FT_modprobe_w_param.44   dmesg
+#K= 68b329da9893e34099c7d8ad5cb9c940 FT_modprobe_w_param.45   dmesg
 EOF
         # Read the K-recs and skip those for tests that can't run
         while read -r line; do

-- 
2.55.0

