Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612DF6083639
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o31pebMA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014E210E54D;
	Sun,  8 Nov 2026 22:39:53 +0000 (UTC)
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51C3E10E2EB
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 22:39:43 +0000 (UTC)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b0d864826cso1320190c88.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 14:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794177582; x=1794782382;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AHLMqwM6/67Zcd/LOxQ2+hhUbtfPU/BOw3z2THUGUxg=;
 b=o31pebMAQum3nNzX5yCHucrSsF6MRbMCBh/Z/9ffQ/TRYSyxJY5+X1zdW6Q9ZaVtvb
 nHmMvjvS+KHRVq99LkRApBuE0jOe/YNkeISnpkgDqsi6na+TZZIHtGfsFzWy1OOxY9gg
 36/xTmN1UrHFVPw/WwQn1Db7MGiBuARRDnsCE1Ti2lgKZg8CGtbsd6Gsx5Ix0rJpru/4
 SOM7BxOrtwmCHVYFCmSQgNO57YbKJRSJg1bCicenB0BgqOjEO8HZ1I6lZwnG7LEivlgs
 bGCoaX2wRerVpQshhz5Yw3imaf31ssqIpk/Fr8eVraYRCB/S+leTx1GCIuCiztm9/Prr
 bMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794177582; x=1794782382;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AHLMqwM6/67Zcd/LOxQ2+hhUbtfPU/BOw3z2THUGUxg=;
 b=E0TfVbFLZ7pOEAB0PkcX4msPfp//HUF6x7ddYJTqvcftwhbCIrJ7QdoQN2iD+gqf+s
 1tfcYo/H0WFdOUk1ciEcbNSFu+vEvYCt0aHL4BLiaHraxkQBiQDqMcaCPZlbjs+N7cRS
 LyWk/mKm74euKNu909U/AytCzwy+Fy1NxLCrO8CiJrH+xDriYmYqMrG7a0AY5JZw8k5a
 bB33CMXYXM8KS867JlOrMm9kkxuH1FGHtm9E2wDC61ong+PC6DQIydE3HjWoaRJFu0ZK
 +ReXwssCVWQDtY7XCpQllBlE6lrXJhj2YjclVoXd/lSdf06r3hjSpl+vJ0s5LNdGhULB
 h9og==
X-Forwarded-Encrypted: i=1;
 AL+hErEstH8PIbvNqfoQ4DWqkSx0ceM2CNjXyD/Vm9BR0XNDkF9hB3xTP+7YmhAh0B0JxpQlepEAyrorjlI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/w28a4Gx5jSgM3MwIZvbW+HsTmxVg5falX9+c58PLeBFH9PZEQ
 L+JaMsIBaJrSnrF8WA9+Z/+j08hUaNbCwmjCCs3YF33VcghmBEq1YBKi3I2AFMRMLwOg8LgpBJP
 riUGcyo/jwA==
X-Received: from dlbox21.prod.google.com
 ([2002:a05:7022:1215:b0:1ab:fb55:f657])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:b884:b0:1b2:695b:79f0
 with SMTP id a92af1059eb24-1b39fef03f3mr3576923c88.32.1794177581955; Sun, 08
 Nov 2026 14:39:41 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:05 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-2-irogers@google.com>
Subject: [PATCH v3 1/9] Compiler Attributes: Add __must_init macro
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Nayna Jain <nayna@linux.ibm.com>, 
 Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Alexander Aring <aahringo@redhat.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
 llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-31.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clang supports the 'require_explicit_initialization' attribute on struct
fields to indicate that a field must be initialized explicitly by the
user when the object is constructed. When an aggregate initializer or
uninitialized variable omits an annotated field, Clang emits a
-Wuninitialized-explicit-init warning (enabled by default).

Add the __must_init macro to include/linux/compiler_attributes.h (which
is included by include/linux/compiler_types.h and
include/linux/compiler.h) so kernel structs with error-prone
initialization (such as mandatory callbacks or cleanup handlers) can
enforce explicit initialization at compile time, as discussed at the
Linux Plumbers Conference. The shorter __must_init spelling, rather than
the attribute's full name, keeps annotated struct members readable and
was suggested by Greg Kroah-Hartman.

Note that Clang versions prior to the fix for
https://github.com/llvm/llvm-project/issues/232483 do not diagnose
file-scope objects declared without any initializer (initializers at
file scope that omit the field are diagnosed).

Also teach Sphinx (Documentation/conf.py), kernel-doc
(tools/lib/python/kdoc/xforms_lists.py), and checkpatch.pl about the new
attribute macro.

Link: https://lpc.events/event/20/contributions/2392/
Link: https://lore.kernel.org/lkml/2026101532-fantastic-deafness-e04c@gregkh/
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 Documentation/conf.py                 |  1 +
 include/linux/compiler_attributes.h   | 12 ++++++++++++
 scripts/checkpatch.pl                 |  1 +
 tools/lib/python/kdoc/xforms_lists.py |  1 +
 4 files changed, 15 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 5ab26ce89daf..baaa4035258c 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -203,6 +203,7 @@ c_id_attributes = [
     "__noreturn",
     "__packed",
     "__pure",
+    "__must_init",
     "__section",
     "__always_unused",
     "__maybe_unused",
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 476c4c560d17..b9c0b56dd22e 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -322,6 +322,18 @@
  */
 #define __pure                          __attribute__((__pure__))
 
+/*
+ * Optional: not supported by gcc
+ * Optional: only supported since clang >= 20.0
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#require-explicit-initialization
+ */
+#if __has_attribute(__require_explicit_initialization__)
+# define __must_init __attribute__((__require_explicit_initialization__))
+#else
+# define __must_init
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-section-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-section-variable-attribute
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b8b64f720191..6a091c45b1a1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6888,6 +6888,7 @@ sub process {
 				"noreturn"			=> "__noreturn",
 				"packed"			=> "__packed",
 				"pure"				=> "__pure",
+				"require_explicit_initialization" => "__must_init",
 				"section"			=> "__section",
 				"used"				=> "__used",
 				"weak"				=> "__weak"
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index db23fb650ea8..42956b98aae3 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -36,6 +36,7 @@ class CTransforms:
         (CMatch("CRYPTO_MINALIGN_ATTR"), ""),
         (CMatch("__private"), ""),
         (CMatch("__rcu"), ""),
+        (CMatch("__must_init"), ""),
         (CMatch("____cacheline_aligned_in_smp"), ""),
         (CMatch("____cacheline_aligned"), ""),
         (CMatch("__cacheline_group_(?:begin|end)"), ""),
-- 
2.56.0.455.g6c5a503b38-goog

