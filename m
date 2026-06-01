Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7450CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 305F4113267;
	Mon,  1 Jun 2026 12:05:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LeAK8CZt";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D21113267
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:05 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so6960805e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315504; x=1780920304; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T5zD1QygmB8fWogN5M5u4F28IFz6bLgLGYRTXYqao/U=;
 b=LeAK8CZtPZKWez8gXth73evKqd16OLMjCHs2jzttDeeOxpGePDFj2vaqIrtyhhAe7g
 +y9j2K6/NVrGlBg1/N5RfQK8v+RuJPXBxDPVFfE8giHxsM5thbKeAViraY9ato7NR/aG
 V+8lAO1Xpkh9D7pU9R3kxkFqUbjSOfYTnY5rcHC0pOuPEMf40+zTVpk+yWdsPU1ZyaIG
 nhDtn2lhflpDW2p+w63sfX2jyHqc/PqsGml5dTFncn+9kTOtwf4xKPn9n5xRfLDlaqpL
 HdkTALBYxLg98bRM7ULR3O/aaZnOD8FPVqzMq0w2YBq/qeam1scrwvW5JpKbJZfD2gEE
 aNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315504; x=1780920304;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T5zD1QygmB8fWogN5M5u4F28IFz6bLgLGYRTXYqao/U=;
 b=E8FLqgqwBJ3jykZRciWeHVPRf5KPPcpnidxiScRy3EkB59cchsBycT2GPTd3jviRim
 wtFnxgxL8M+15mMozwQ92w4gY8Ol3tlf8ozsIJxG4gHeQSktR/jjmGmdGm77j8O/c1d0
 AmxniWPpYfgSr+LD+R3FW5x3dMx7gB4dOHZi5JewgKSqDyiSMbK5LsJdUMT5wXBxq9lw
 CrAeb9ZHb19x6Hs0lwe2mTNBUKuesSVrHdwD+yTjN1v/uK6TkgrpGGhUnjrrENVJi7Mt
 031ql3NcwIjqy/p/ug+ThZ78w4ZeF9j5tGTxUQASgeSOsiP++bW7IE+ziJneONUYQoEJ
 nGCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VxabXhk4jfJHBZzVZDMQbdbJodrH5IV9R0tG/LtO5R7rnkUtDb0Wlwbpdq+a+X2EXmN+87gzgCk4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYVCsI4Fo2uQVjZypdD6qLKje64Zf4FrDnSC/qTtQQA+kegnZJ
 03wnLidfPFYL/Dj6Dhmyrbf08hYWkIqtUzoHL8RquarEWoKmPKt1/iT/
X-Gm-Gg: Acq92OEATkqfHMq/aDKQXdKG4aZAH20HrKLSB8ni44eV5tyIle5CGlphhXhAxiZb1e1
 T9r89gcdqJO2ttceWdS1k8ye3McmNQO1ROg72w47uK6Bq9vLRIXg+acD3mvOVETivw2N5ff5FXw
 jqEit2pS6c6h2fXfNtNH0U2rlGhStrp1JQjqNOO9fwnuq3SkD8O/txDRse0+Iw1v3dQwRnvsW5L
 Qwxc/ZQT89FoUsk2K4VUejIY4JhXGe10PeNphInBoHaHRiSFOYie7PtYwjUFaxg7MKrqdtP+wLe
 +82FD+Spyi3xu6zx3pchjoKoXkT1Qw0vgiH5EvRghIT26UxjSxfo1EEzyxgtEcroGA+/D1JmvSe
 NiUIHw9rNkrMMirsw/XkM5/hVBxm5cbigby3bSWEP914K9HrCc61jJ0GBllo8ITe9s3vfAg0LXD
 jXxivCOncozR9LkZNtJE95OSTXRv8nB+FkYPkzddoEuQ==
X-Received: by 2002:a05:600c:1546:b0:490:50e4:7224 with SMTP id
 5b1f17b1804b1-490a290bdf1mr200424025e9.3.1780315503641; 
 Mon, 01 Jun 2026 05:05:03 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:05:03 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:48 +0000
Subject: [PATCH v3 02/24] docs/dyndbg: explain flags parse 1st
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-2-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=1814;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Ybb0kJKNd2BJDDcZYbhZbCACFsLVAC7m/M+jXCdbe+s=;
 b=77QENcw7TwO5sbOCSCb3za5Eh6W1VtMb7ffsLgiJ6qjsY20R6qLFWJ9u0VHPdNWz7TZVh1MSu
 fXZPCPflAUnCuxlFjQ2BltAWo25IThXGyLGV8vp/+SKUfZSM2Av2QvG
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

When writing queries to >control, flags are parsed 1st, since they are
the only required field, and they require specific compositions.  So
if the flags draw an error (on those specifics), then keyword errors
aren't reported.  This can be mildly confusing/annoying, so explain it
instead.

cc: linux-doc@vger.kernel.org
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 4b14d9fd0300..9c2f096ed1d8 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -109,10 +109,19 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
-
-A match specification is a keyword, which selects the attribute of
-the callsite to be compared, and a value to compare against.  Possible
-keywords are:::
+Note that since the match-spec can be empty, the flags are checked 1st,
+then the pairs of keyword and value.  Flag errs will hide keyword errs::
+
+  bash-5.2# ddcmd mod bar +foo
+  dyndbg: read 13 bytes from userspace
+  dyndbg: query 0: "mod bar +foo" mod:*
+  dyndbg: unknown flag 'o'
+  dyndbg: flags parse failed
+  dyndbg: processed 1 queries, with 0 matches, 1 errs
+
+So a match-spec is a keyword, which selects the attribute of the
+callsite to be compared, and a value to compare against.  Possible
+keywords are::
 
   match-spec ::= 'func' string |
 		 'file' string |

-- 
2.54.0

