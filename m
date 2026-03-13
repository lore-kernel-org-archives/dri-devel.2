Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC53105F7B0
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 490C310EC0C;
	Fri, 13 Mar 2026 13:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Au+TW1wa";
	dkim-atps=neutral
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 572E610EC0B
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:01 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-4673790ab85so1445621b6e.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408240; x=1774013040; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxTkOltoVAiRQNIiLPEo11+229bHMC78x0TMXlU2wIM=;
 b=Au+TW1wapgMyvc3Dzjn+VPZTiRP4wXMF3C/5RE8dkFAKXkzi3gagiqiO8pfy+y8yw7
 HHa19wwfN5OLn+EmY6iIyTwybTCyfSuJzqGlv0QajXCtaSG+THwiNQIEe81QIPVTacvW
 yvsLdWZSb67WarGNh1mebTFu4H0wKDsK92Xrxhv1ptkSg8EGPlxMv0ZKmbGOjxwIYmEP
 YvQWJshIgsEt/5rVRgCC0tVO5XCVN/mhNg+/ykNStlGw0AMmo2PXvnTyM/bfLJ8EuWom
 ShiUjDZal2rmemm7WncKnY6rTrSJ5AJ9rlyu4QJR5gOC6q3+Pzkv+SMLGIrl58Y97uvQ
 gNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408240; x=1774013040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZxTkOltoVAiRQNIiLPEo11+229bHMC78x0TMXlU2wIM=;
 b=i+ZJeK1OLVnAbdMzxj+bFrAUNuxMyi5uQ8eJOKWVzacdQN0LTzTGngntA/C7ry2VPO
 oUl79T3l6gKpzU2UfHoxSdsTsSrEvhzNUAGkmT3nXjR+EXe7t9MOUxS1ayilVsw+CDKI
 Nt4gcmi3Kok7kAjWoMlbKcy6rSuaIdWh3ios+NDEmtbS0NzpMPgaVI1vOTs89CEoUT2N
 HEbl0UBjdgS20/mPJ52mv8kXT/4DB2SV1k/rxTcxX2vfFsw1OBSjdOOk4obmjBTkjb65
 Xap5T0Hufx5pZS4TtPHqVRiP7HUipuQ6YuwGxZCEDL9WeY95ymZbK+tb1dyO8aWtwrgx
 FFCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5b7hzfoSAH+KbxuGZw8jpD7z1FOs1k6ThUmweW+/QJ9uO4She+6r5HJ8ynZUcdqPrekdgoqUUvys=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6QpLZ9G/YuC6vZllp7HhBqYOAHYMTS+2AcwWvIItMh7UaZ2vC
 ycX/2DeKNFv3Z1BqLtQ067QCDUObBlJWys6Qly4K/Y/8lOZmFW0NdeQR
X-Gm-Gg: ATEYQzyccGhhIY0QGb6FbImcevHAarcvQ/qJYpFg4fM/Wvc2P+RevxBqc6AXz4+Uijc
 9ODxNvXpxpWUDylz1nWfaxxUiExS1w4lKl3Qo3mK6YnW2MnlrDJX199YXPfAXFLYvgT29maLti/
 1q2h3qjRsy9n0YglEFbL2C0iPGwMGYFLnFEtsU8CaKFe81+e0GMKxxD5H6CkHrFAwX9X9RRVca0
 J8D3lq/1NiTOsaA6xrZqqug2hCeFAS/MuUaria1E7VR9KhrU+f9ymBF0zbbN5iV1rUodiL4yeTI
 6LefEr4juY4/MJFh+y2OOJO+LEh+XyA6vmVt8JWucFrR4qz/PJpnBQc6GT5e/8pwsywTO32qnSZ
 7DI9MaMfts7H55X5q5z5cpNIbn+JkkIxJeR897PPDYk0L9zcaYU8/rT2VV/VOZMfgdLIe41Ce0r
 GfXVe2GWXCkbjvwWi91EcS+jTuSYspBAV31eEaVTyh6+S8cPYC
X-Received: by 2002:a05:6808:5292:b0:45e:bfe0:21f2 with SMTP id
 5614622812f47-467570ecc8fmr1454885b6e.10.1773408240480; 
 Fri, 13 Mar 2026 06:24:00 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:59 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 29/65] selftests-dyndbg: add test_mod_submod
Date: Fri, 13 Mar 2026 07:19:54 -0600
Message-ID: <20260313132103.2529746-30-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
MIME-Version: 1.0
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

This new test-fn runs 3 module/submodule modprobe scenarios, variously
using both the generic dyndbg=<queries> modprobe arg, and the
test-module's classmap-params to manipulate the test-mod*'s pr_debugs.
In all cases, the current flag-settings are counted and tested vs
expectations.

The 3rd scenario recapitulates the DRM_USE_DYNAMIC_DEBUG=y failure.

1. 2 modprobes (super then sub), with separate dyndbg=class-settings
   check module specific flag settings

2. modprobe submod, supermod is auto-loaded
   set supermod class-params
   check expected enablements in super & submod

3. modprobe super, with param=setting (like drm.debug=0x1ef)
   modprobe submod
   validate submod's class'd pr_debugs get properly enabled

The test uses multi-queries, with both commas and percents (to avoid
spaces and quoting).  This is the main reason the test wasn't earlier
in the patchset, closer to the classmap patches its validating.

With some tedium, the tests could be refactored to split out early
tests which avoid multi-cmds, and test only the class-params.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 513f6cb1db1d..09937dca3056 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -279,10 +279,83 @@ function test_percent_splitting {
     ifrmmod test_dynamic_debug
 }
 
+function test_mod_submod {
+    echo -e "${GREEN}# TEST_MOD_SUBMOD ${NC}"
+    if [ $LACK_TMOD -eq 1 ]; then
+	echo "SKIP - test requires test-dynamic-debug.ko"
+	return
+    fi
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    ddcmd =_
+
+    # modprobe with class enablements
+    modprobe test_dynamic_debug \
+	dyndbg=class,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
+
+    check_match_ct '\[test_dynamic_debug\]' 23 -r
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+
+    modprobe test_dynamic_debug_submod
+    check_match_ct test_dynamic_debug_submod 23 -r
+    check_match_ct '\[test_dynamic_debug\]' 23 -r
+    check_match_ct test_dynamic_debug 46 -r
+
+    # no enablements propagate here
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+
+    # change classes again, this time submod too
+    ddcmd class,D2_CORE,+mf%class,D2_KMS,+lt%class,D2_ATOMIC,+ml "# add some prefixes"
+    check_match_ct =pmf 1
+    check_match_ct =plt 1
+    check_match_ct =pml 1
+    #  submod changed too
+    check_match_ct =mf 1
+    check_match_ct =lt 1
+    check_match_ct =ml 1
+
+    # now work the classmap-params
+    # fresh start, to clear all above flags (test-fn limits)
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    modprobe test_dynamic_debug_submod # get supermod too
+
+    echo 1 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 4 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( V1-3 + D2_CORE )
+    check_match_ct =p 8
+    echo 3 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( D2_CORE, D2_DRIVER )
+    check_match_ct =p 4
+    echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( D2_DRIVER, D2_KMS, D2_ATOMIC )
+    check_match_ct =p 6
+
+    # recap DRM_USE_DYNAMIC_DEBUG regression
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    # set super-mod params
+    modprobe test_dynamic_debug p_disjoint_bits=0x16 p_level_num=5
+    check_match_ct =p 7
+    modprobe test_dynamic_debug_submod
+    # see them picked up by submod
+    check_match_ct =p 14
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+}
+
 tests_list=(
     basic_tests
+    # these require test_dynamic_debug*.ko
     comma_terminator_tests
     test_percent_splitting
+    test_mod_submod
 )
 
 # Run tests
-- 
2.53.0

