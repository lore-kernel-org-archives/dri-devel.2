Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BA1606A326
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ER2xexoc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8E210E495;
	Thu, 22 Oct 2026 20:46:30 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013066.outbound.protection.outlook.com
 [40.107.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 541E010E495
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 20:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWciKeIo28COCEPFiNDRls5gi8G/DyRvYvPfboMWQ/usHkDcBVctQi/4Ybqiq8YCArk21kUhMjAVaA3NH7gpCaEoAoyJYf3S253T+n3nWqIcCxZ041CKezJgpXKYvS3jJGbefImerWEeFhMNCn1UOdX/Zj6PmnxDA0THCrR7biNcz+J9xtZfLrLxZ9jb1F7j1PJ40kJ2TOswiDYLV5XbWxgjimzSVXKe/J2gfcmENUFF4GmBBxly6Ht03fAZXZj5qvaPN05h/Dgcas/ip0xRA2sNIdtKunrjdQiNrMQ2ov5MbAG6fFRfosuc8j27VN8nhtZEJ2WJS6Y+7n28e9pN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNCUyv6qFvMcNcr4ZyNGlPJpKchbBSTp/XSJyf3kKxc=;
 b=hXZ3GLEcb5lmItQNdEXnKWbnpZKGkNYa4R1Uy7xtYBBupW8gzrkgCZh0mLx6f29Dz4FQ5DEUSbr7FYXxE4QLF774lVM3X+D3LsQtPUbdGzGtDQ4u52mHcaicNO+raWJSVHWbveuF8y7J0+tPi6bWyFW7pvhsiLm1ggIzNVqwL1H2GJtd3mRKD3BS9mUYpb55xzeqFdRTHPmJx/g5/tdW/d9m/k5KeKrammWgprBrmJGHHt6zqT5LTbUAr14PjnRSdPJsrijolQuykmREQmGVo6h9cYeo6aNg46RG31NzvgZEYDWiTp0gdvGuQUUlEunyb9K11gyk0lWGcuMoHUGlCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNCUyv6qFvMcNcr4ZyNGlPJpKchbBSTp/XSJyf3kKxc=;
 b=ER2xexocVV04s8X2hubnV3EbFkL0OU8//i7VK/eDdpkixjYQ8XUXYgu8OLStdUFllW/slNpuiwTAaO3xpRdvduAAlxWBCmWcYxWuP8gb7aRIaIk8bFz/B6H/KA3uk0lHP9u0TjVIyozMYkC7pDxUjj1RXMuDerDlRBrH+BC8x2RrtsBV875jb/EFmYuRiyJLhFValPK5ljxw189s/S9y+9kdUbHsJRjBvxyXu7e6ka+lpBRMsEZkI4n8J6r7AbcdzWdrunOsV8q98SHxqRG/v/Uq61DoI4Z5LuCEWLvBxrOMUYDZZ/rtudLrgTlCrbY6ETSHvxbee3YbuunzccKO3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 20:46:19 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::120d:ace8:656:fac2]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::120d:ace8:656:fac2%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 20:46:19 +0000
From: Edwin Peer <epeer@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Edwin Peer <epeer@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, John Hubbard <jhubbard@nvidia.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH drm-test] drm-test: run the tests with libtest
Date: Thu, 22 Oct 2026 13:45:48 -0700
Message-ID: <20261022204554.38507-1-epeer@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:303:83::22) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5182:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: c43a3c23-1b5b-4508-72ca-08df307d85b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|6133799003|18002099003|3023799007|11063799006|261009223027099003|261021135927099003|261021123027099003|261021121427099003|10067099003|261022105027099003|56012099006|261022075727099003;
X-Microsoft-Antispam-Message-Info: siLkI9VTn88I7/ZmEsikSGQeDOnKeHRDYJg8STZnA9kGAFxubvmG9PjqsjASy2WCWaiUlYPgxC4h+Y/iOE0nX62CtNBMgc189HE4QOTISc53OMcSvFo44SMvxipu109L3ANJ+jS1wrGK1AXbqv5kk87Z7f/LDnuJRrmUFxN4baN4zQKIN0rhocIeDQdpQgx1D0a1a+V931IyPHu5vUA+S5jMCt5/zIfkiNaA2VZEaX/1NqgFZ6rUv4pWvzy5BJjIxR6ZTIMtsa23w5wUL4ZBVYa9vath2UQOh2KxKHfBHqhqL+JUuslh2BL0xb2Vg0DpZsM+Ky9kRVTTKflyMFtG8RG8TUelbGAdF9k/i2C8LqXLppFUL2FKrSJf3+w087HhJMPxb91Q2nm0E5Qj4Igjl4ASN3gXSlv4KpDVtgUH93aEPCW1Taj5ZoA4j+tNuszUnsEFR7naGZ6UhVj5nvWpTCdZz3f5/a79ZYKxJByBWFXx0dFAhc02dZwPgbDphmpOHQ9A5tTir9x4gZP+0pfIGZmIe8t72Ce+kBG/sGW5hZvjMKHZtPUQoftXEZFrL82Rt8MJJ0pdBYZAzOb5GrU3YZo5fQlZF4c7QWR2koKlQpcN+/IrBhtNu8goGcfCsGY3rzed6qfWFLO/ycCWFaSA+ThngNEt3uhMkTRG3fHpRSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(18002099003)(3023799007)(11063799006)(261009223027099003)(261021135927099003)(261021123027099003)(261021121427099003)(10067099003)(261022105027099003)(56012099006)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YyJZBDoaOMk7eFvmKamCyzwct2esng7h2r6kYvSNT7kf0U916SiR3VBVBH55?=
 =?us-ascii?Q?aXF5sVgA9VwNiJFckmDql81/HlNYlI3IWySiGzG1bI6hc2/SY6nxnErwqy0f?=
 =?us-ascii?Q?E6pwChxiCE5ygb4z2UWUZg8QMrL4V0eirYzzElAFTSXzCvZwNQLuvJnfNxwI?=
 =?us-ascii?Q?CfQvVi1zNa6nTSPlIfWoX7eUpAieD1XNdBxfwK1sR7sghKdBY7xBN2hJs4kc?=
 =?us-ascii?Q?IiOD35rQBGpOHXtOH79PLT4WVekwyLgcH6uFK/dKzetoictDkXUmUPvAfFvc?=
 =?us-ascii?Q?I2hOcJRL6A0miNa4r1EckNcC9Swk9q8RvMkqQe4Dq6N7rQIEKUuTqDepHfVe?=
 =?us-ascii?Q?K2U1qnzABymqd+dmAAghNrgGEss0+NIUfbuECG0/1jVvLvOOszzd+aLql0DU?=
 =?us-ascii?Q?vytRzUEsHM0HFOg67UAX059IFCmxPKmX4V0BFLD6OVYrbv+jXT6qt6V6pnCL?=
 =?us-ascii?Q?PFHUmPTIcANHSFJzYObNcMWMBEmRrMd+sDrsz4MfbtWc782C+n+b/Ha65z1e?=
 =?us-ascii?Q?sFutxCntIYCJB479Tics+9ildyLvM+DBChQSY+4ZXCDPh8JfzpOdWd8B6GVY?=
 =?us-ascii?Q?4CLbYvxy/keK1510/l92HXIPr/cqUnjiBXoEYItz0NgMJxVZH7etpT7FJ4uK?=
 =?us-ascii?Q?oi0tl1pLauuqbD4G0vL95p9h9Lb/aKPos4CWIZNboI0AnBPF5LdGjjyn+sYI?=
 =?us-ascii?Q?Pz6wLeLJcWufKySFOUlvezBvtnmx19wLSlG1xQvMD631tYi9A+JfzAwK5t3T?=
 =?us-ascii?Q?hPJvfxZNBUXNAjsZkoEf93Y43iF3ZSoINp02jrPuS3l+IoGg0zgN8O/mY8LB?=
 =?us-ascii?Q?lk4s51dyZ0l/lflbD4J13PEUylZTn9itCKnceQD0geF4dOF9rCmCSxjOB9U4?=
 =?us-ascii?Q?hSaeMHifdFof9vJ+Ze+CUA9O38w4gNbd2VaeqnntM4JkmGQr6IpYmU7iAIjE?=
 =?us-ascii?Q?dumtPQ7fm3YA3Or3QkHY3go+32wZklSgZvZb1Z46MmsBDuY8s/hxX7xmMyYX?=
 =?us-ascii?Q?OO/3m/rA3xhtl0bw+XhN4EqO85mG9S2LTjZTiNZcHc9nIaiU2mv/bsVEmYOi?=
 =?us-ascii?Q?3W9dBGLIuNkQ/8XhLdGtI03FJ5ZtpXQa5aiFhMmcBpf/Ukb235kzFL2FmiQy?=
 =?us-ascii?Q?6oji/m9Ek2VJHAn7Fs3GCB/ReXMTXGf0gXA+f1cQMaJxBCyideMY+DmPBYrY?=
 =?us-ascii?Q?SIN+eQ7oq3xfdPiWzxlXPgnTIif/CaFcmChxOKD3jn5Ti+F2emOpePaNX4+z?=
 =?us-ascii?Q?ffgfE2lK12zNzb9kbsZJVMtRyxMIB3NtbjOk+gFDM3Hjl0g8bOabJF4AkNLd?=
 =?us-ascii?Q?OCdu8sbfDdXUhOUa7VxQFtiLgVMXwWGyYdp3hodAsncwX18uG4xt//98MHc7?=
 =?us-ascii?Q?Xu66GDYVqKfgYhCR+k0d5+ux41ZOwkO+A0B6JiLHZyuFLWLdmT3SHYjJti4d?=
 =?us-ascii?Q?orEUu0iJlJGiH3hI2o7HXtiw0bVM0dDMHbH7DPp2I5ycsW2hP3Gb2ny5gP7Q?=
 =?us-ascii?Q?xjbePfG8c3lXxaXNryv2Tz42+W0WinNq0HVGIqDjAvMy3L2B6BBU5z2HM0uB?=
 =?us-ascii?Q?EiQIva8hzohOX8Gv0EHsfVobfE7eqP+/tuzuTlBzcZBvytpTh0fbBx3wztxi?=
 =?us-ascii?Q?XpeLXYK6XO2FvlKfuKQgDTKCVi5nnzVIOYFY812r78xv4ywU6WYQY1zttM5J?=
 =?us-ascii?Q?79EdaRAkc4r1j/OTuZMnsYSIwQhMYzynDx21QPiCEuRM94S6D1xr5t1hEwti?=
 =?us-ascii?Q?EpeH4xJefw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43a3c23-1b5b-4508-72ca-08df307d85b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 20:46:18.3720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCHbO/s3fLkIrtEKEZkazpirk9XWTGsXZ6nzjkjBS66TmoHTFFNVywUrQK3H8fByzkt5nOVK28VvYjttYuYJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the hand rolled test runner with libtest, the harness behind the
Cargo #[test] attribute. Tests are now discovered from their annotations
rather than registered by hand - adding one no longer means implementing
the Test trait.

Switching to libtest brings a number of benefits:

  - Tests are independent. Each one runs with panics caught, so a failed
    assertion reports just that test as failed instead of aborting the
    process and leaving the remaining tests unreported. Pass --fail-fast
    (nightly, with -Z unstable-options) to stop at the first failure
    instead.

  - Results are reported per test, with a summary and a non-zero exit
    status when any test fails, which is easier to consume from CI than
    a single verdict for the whole suite.

  - Tests are selected by name, which replaces the driver dispatch that
    keyed off argv[1]. Tests are namespaced by their module path, so the
    previous invocation still selects the nova tests:

        drm-test nova

    while individual tests can now be run on their own:

        drm-test nova::test::test_gem_size

    and --list enumerates the tests without touching the hardware. See
    --exact and --skip for the remaining filtering options.

  - Test output is captured and printed only for failing tests, so that
    passing runs stay quiet without losing diagnostics when they are
    needed. Pass --show-output to print the output of successful tests
    too, or --no-capture to print it as it happens, as before.

Note that libtest runs tests in parallel; pass --test-threads=1 to run
them one at a time.

libtest is linked into the test binary, so cargo is only required to
build the tests, not to run them. The binary is built from the --tests
target, which cargo keeps in an internal location that differs between
releases, so add build.sh to place it in the target directory, where the
binary was found before.

Signed-off-by: Edwin Peer <epeer@nvidia.com>
---
This patch is for drm-test, the userspace test suite for the nova uAPI. It
lives outside the kernel tree, at:

  https://gitlab.freedesktop.org/dakr/drm-test

It is posted here for wider review, and is also open as a merge request
against that repository:

  https://gitlab.freedesktop.org/dakr/drm-test/-/merge_requests/3

The motivation is running these tests from CI. The current runner reports a
single verdict for the whole suite, and a failed assertion aborts the process,
so the tests after it go unreported. libtest reports a result per test and,
with --format json, machine readable output.

Tested on Turing (TU104), Ampere (GA104) and Blackwell (GB102), against
drm-rust-next.

 build.sh         |  49 ++++++++++++++
 src/drm/mod.rs   |   5 --
 src/lib.rs       |   2 +
 src/main.rs      |  18 ------
 src/nova/mod.rs  |   4 +-
 src/nova/test.rs | 163 +++++++++++++++++++++--------------------------
 6 files changed, 124 insertions(+), 117 deletions(-)
 create mode 100755 build.sh
 delete mode 100644 src/main.rs

diff --git a/build.sh b/build.sh
new file mode 100755
index 0000000..0134846
--- /dev/null
+++ b/build.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+#
+# Build drm-test and place the binary in the target directory, where a plain
+# `cargo build` would have left it, e.g. target/debug/drm-test.
+#
+# The tests are run by libtest, so the executable is built from the --tests
+# target rather than from a plain `cargo build`. Cargo keeps test binaries in
+# an internal location that differs between releases, so ask it where the
+# binary was written and copy it next to the profile directory.
+#
+# Arguments are passed through to cargo, for example:
+#
+#     ./build.sh --release
+#     ./build.sh --target x86_64-unknown-linux-musl
+#
+set -eu
+
+cd "$(dirname "$0")"
+
+# Only the test target reports a non-null "executable". Diagnostics are
+# rendered to stderr as usual, leaving just artifact messages on stdout.
+bin=$(cargo build --tests --message-format=json-render-diagnostics "$@" \
+	| grep -o '"executable":"[^"]*"' \
+	| head -n1 \
+	| sed 's/^"executable":"//; s/"$//')
+
+if [ -z "${bin}" ]; then
+	echo "error: cargo produced no test binary" >&2
+	exit 1
+fi
+
+# Which directory cargo stages the binary in depends on the release: stable
+# uses <profile>/deps, while nightly uses <profile>/build/<pkg>/<hash>/out.
+# Climb out of whichever it used to reach the profile directory.
+dir="${bin%/*}"
+while :; do
+	case "${dir}" in
+	*/deps | */build) break ;;
+	*/*) dir="${dir%/*}" ;;
+	*)
+		echo "error: cannot locate the cargo profile directory" >&2
+		exit 1
+		;;
+	esac
+done
+
+dest="${dir%/*}/drm-test"
+cp -f "${bin}" "${dest}"
+echo "built: ${dest}"
diff --git a/src/drm/mod.rs b/src/drm/mod.rs
index c767dbe..5d6f280 100644
--- a/src/drm/mod.rs
+++ b/src/drm/mod.rs
@@ -85,8 +85,3 @@ impl Drm {
         Ok(())
     }
 }
-
-/// Represents the test functions all drivers must provide.
-pub trait Test {
-    fn all(&self);
-}
diff --git a/src/lib.rs b/src/lib.rs
index 663f484..5f73c55 100644
--- a/src/lib.rs
+++ b/src/lib.rs
@@ -2,6 +2,7 @@ mod bindings;
 pub mod drm;
 pub mod nova;
 
+#[cfg(test)]
 macro_rules! assert_ge {
     ($left:expr, $right:expr $(,)?) => {{
         match (&$left, &$right) {
@@ -16,4 +17,5 @@ macro_rules! assert_ge {
         }
     }};
 }
+#[cfg(test)]
 pub(crate) use assert_ge;
diff --git a/src/main.rs b/src/main.rs
deleted file mode 100644
index 2034285..0000000
--- a/src/main.rs
+++ /dev/null
@@ -1,18 +0,0 @@
-use drm_test::{drm, nova};
-use std::{env, process::exit};
-
-fn main() {
-    let args: Vec<String> = env::args().collect();
-
-    if args.len() < 2 {
-        println!("Usage: {} {{ nova }}", args[0]);
-        exit(1);
-    }
-
-    let test: Box<dyn drm::Test> = match args[1].as_str() {
-        "nova" => Box::new(nova::Test::open()),
-        _ => todo!(),
-    };
-
-    test.all();
-}
diff --git a/src/nova/mod.rs b/src/nova/mod.rs
index 7b53758..1d03335 100644
--- a/src/nova/mod.rs
+++ b/src/nova/mod.rs
@@ -1,8 +1,8 @@
 pub mod gpu;
 pub mod nova;
-pub mod test;
+#[cfg(test)]
+mod test;
 
 pub use self::nova::Nova;
-pub use self::test::Test;
 
 pub use self::gpu::{Architecture, Chipset};
diff --git a/src/nova/test.rs b/src/nova/test.rs
index 75c92d8..a02e449 100644
--- a/src/nova/test.rs
+++ b/src/nova/test.rs
@@ -1,106 +1,85 @@
 use std::{ffi::CStr, io, mem::size_of};
 
 use crate::{
-    assert_ge, bindings, drm,
+    assert_ge, bindings,
     nova::{Architecture, Chipset, Nova},
 };
 
-pub struct Test(Nova);
+/// Test whether GPU information is reported correctly.
+#[test]
+fn test_gpu_info() {
+    let nova = Nova::open().unwrap();
+    let info = nova.gpu_info().unwrap();
+    let gpu_name =
+        CStr::from_bytes_until_nul(&info.gpu_name).expect("GPU name must be NUL-terminated");
+    let gpu_short_name = CStr::from_bytes_until_nul(&info.gpu_short_name)
+        .expect("GPU short name must be NUL-terminated");
+    let architecture = Architecture::from_repr(info.architecture)
+        .map(|arch| arch.to_string())
+        .unwrap_or_else(|| "unknown".into());
+    let chipset = Chipset::from_repr(info.chipid)
+        .map(|chip| chip.to_string())
+        .unwrap_or_else(|| "unknown".into());
 
-impl Test {
-    /// Create a new `Test` instance.
-    pub fn open() -> Self {
-        let nova = Nova::open().unwrap();
-
-        Self(nova)
-    }
-
-    /// Test whether GPU information is reported correctly.
-    pub fn test_gpu_info(&self) {
-        let info = self.0.gpu_info().unwrap();
-        let gpu_name =
-            CStr::from_bytes_until_nul(&info.gpu_name).expect("GPU name must be NUL-terminated");
-        let gpu_short_name = CStr::from_bytes_until_nul(&info.gpu_short_name)
-            .expect("GPU short name must be NUL-terminated");
-        let architecture = Architecture::from_repr(info.architecture)
-            .map(|arch| arch.to_string())
-            .unwrap_or_else(|| "unknown".into());
-        let chipset = Chipset::from_repr(info.chipid)
-            .map(|chip| chip.to_string())
-            .unwrap_or_else(|| "unknown".into());
-
-        assert_ne!(info.architecture, 0);
-        println!("NOVA GPU information:");
-        println!(
-            "  Architecture: {} ({:#x})",
-            architecture, info.architecture
-        );
-        println!("  Chipset: {} ({:#x})", chipset, info.chipid);
-        println!(
-            "  VRAM size: {} bytes ({:.2} GiB)",
-            info.vram_size,
-            info.vram_size as f64 / (1u64 << 30) as f64
-        );
-        println!(
-            "  VRAM BAR size: {} bytes ({:.2} GiB)",
-            info.vram_bar_size,
-            info.vram_bar_size as f64 / (1u64 << 30) as f64
-        );
-        println!("  GPU name: {}", gpu_name.to_string_lossy());
-        println!("  GPU short name: {}", gpu_short_name.to_string_lossy());
-        println!(
-            "  GPU GID: {}",
-            [
-                &info.gpu_gid[..4],
-                &info.gpu_gid[4..6],
-                &info.gpu_gid[6..8],
-                &info.gpu_gid[8..10],
-                &info.gpu_gid[10..],
-            ]
-            .into_iter()
-            .map(|chunk| chunk
-                .iter()
-                .map(|byte| format!("{byte:02x}"))
-                .collect::<String>())
-            .collect::<Vec<_>>()
-            .join("-")
-        );
-    }
-
-    /// Test whether a NULL data pointer reports the required GPU information size.
-    pub fn test_gpu_info_size(&self) {
-        let size = self.0.gpu_info_size().unwrap();
-
-        assert_ge!(size as usize, size_of::<bindings::drm_nova_info_gpu>());
-    }
+    assert_ne!(info.architecture, 0);
+    println!("NOVA GPU information:");
+    println!(
+        "  Architecture: {} ({:#x})",
+        architecture, info.architecture
+    );
+    println!("  Chipset: {} ({:#x})", chipset, info.chipid);
+    println!(
+        "  VRAM size: {} bytes ({:.2} GiB)",
+        info.vram_size,
+        info.vram_size as f64 / (1u64 << 30) as f64
+    );
+    println!(
+        "  VRAM BAR size: {} bytes ({:.2} GiB)",
+        info.vram_bar_size,
+        info.vram_bar_size as f64 / (1u64 << 30) as f64
+    );
+    println!("  GPU name: {}", gpu_name.to_string_lossy());
+    println!("  GPU short name: {}", gpu_short_name.to_string_lossy());
+    println!(
+        "  GPU GID: {}",
+        [
+            &info.gpu_gid[..4],
+            &info.gpu_gid[4..6],
+            &info.gpu_gid[6..8],
+            &info.gpu_gid[8..10],
+            &info.gpu_gid[10..],
+        ]
+        .into_iter()
+        .map(|chunk| chunk
+            .iter()
+            .map(|byte| format!("{byte:02x}"))
+            .collect::<String>())
+        .collect::<Vec<_>>()
+        .join("-")
+    );
+}
 
-    fn gem_create(&self, size: u64) -> u32 {
-        self.0.gem_create(size).unwrap()
-    }
+/// Test whether a NULL data pointer reports the required GPU information size.
+#[test]
+fn test_gpu_info_size() {
+    let nova = Nova::open().unwrap();
+    let size = nova.gpu_info_size().unwrap();
 
-    fn gem_size(&self, handle: u32) -> u64 {
-        self.0.gem_size(handle).unwrap()
-    }
+    assert_ge!(size as usize, size_of::<bindings::drm_nova_info_gpu>());
+}
 
-    /// Test whether GEM objects are created with the expected size.
-    pub fn test_gem_size(&self) {
-        let ret = self.0.gem_create(0x0);
-        let err = ret.expect_err("GEM object must not be zero-sized!");
-        assert_eq!(err.kind(), io::ErrorKind::InvalidInput);
+/// Test whether GEM objects are created with the expected size.
+#[test]
+fn test_gem_size() {
+    let nova = Nova::open().unwrap();
 
-        let handle = self.gem_create(0x1000 + 0x1);
-        assert_eq!(self.gem_size(handle), 0x2000);
+    let ret = nova.gem_create(0x0);
+    let err = ret.expect_err("GEM object must not be zero-sized!");
+    assert_eq!(err.kind(), io::ErrorKind::InvalidInput);
 
-        let handle = self.gem_create(0x2000);
-        assert_eq!(self.gem_size(handle), 0x2000);
-    }
-}
+    let handle = nova.gem_create(0x1000 + 0x1).unwrap();
+    assert_eq!(nova.gem_size(handle).unwrap(), 0x2000);
 
-impl drm::Test for Test {
-    // Run all tests.
-    fn all(&self) {
-        self.test_gpu_info();
-        self.test_gpu_info_size();
-        self.test_gem_size();
-    }
+    let handle = nova.gem_create(0x2000).unwrap();
+    assert_eq!(nova.gem_size(handle).unwrap(), 0x2000);
 }
-- 
2.54.0 (Apple Git-157)

