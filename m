Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E8606A32A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZQs8See
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE0710E875;
	Mon,  9 Nov 2026 09:31:16 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D118910E100
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 06:05:19 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-3282db206d3so697521eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 22:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794117919; x=1794722719; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6lprU6Db7+ksq8wir9YKQMNUuhRExSoqjwLJdiuYXBY=;
 b=bZQs8SeePcHSV9THcSc52j4Hkkgr+Tnq1akZeIAzWaTwHCb11E3I8D53HDHEtzW4JF
 xpCaFAqHzutMMDE6euTXEckKzkSYJrgZ4A+MDWBP523/aTuUv8p15l3TnmQ889W7EnZc
 GQwr9PxXX4hPv+cenBsV+7fbbjD4ExmWH/kRTQQ8FqCnBS2BkExBjmI8Fj3/ZWj79131
 T3X0ewCejIM6Jnz6u0h1chAFdQIz4FCDs6A/YPZrpfYYpoFhfo3DdQipeT9mRjakHjIc
 +OFbvtxEHN3G51NJR6BlvaVhHAq49Nrgs27KnwArkVAZqdoqoeBUHMaD7Aq3owe8z2QY
 22Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794117919; x=1794722719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6lprU6Db7+ksq8wir9YKQMNUuhRExSoqjwLJdiuYXBY=;
 b=MpxdcbAv5a5ncrBoHngqrVVCXKgVUQIWovb/3Z8sNADprUW9Yxz9z7ZOSrlAdut+09
 uxoLMml/9CCaFQLPX566VFbcn9uFhLKTIJ3LtznppLWqHfmAt3PUlHjItpqEtvld8YEO
 rkvw/frDa+CbNfCl58CaVjVlfmDVp4cPzoXvMWop4FwWyOl5WW8XqKzac9nS5Nw3ifTe
 wWLOGM/KYlxavBUXbXsh2vE2GUTVfQ+K6PNJdg/o6jJopkZhWKbMimxj5u2jgF7Z/x+o
 5MzL7vjsk/RsqA4F2+OHmC8NLPp/OhH/QzlPEBBFG7YbnrbkFYUc6J7NF5RQZuJJ7Nui
 +ZrQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE9ZRg+/P92I1y+cfGzKGtwQXA+EJ/C2W+RsnDJ//g3Bmw6AJCr5PDvo2zg5MiarHdgJpfg+uG8FCI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+LrYGbpu1bIj3kVlEqXPf8FNb2NU98A1YNLYxgWWK0Ld0EPOp8
 cYGlg1LTKIgApP+xksN/pgt9D9XZvVDsUcaEFkTbpu6xirHYgTypYB+O
X-Gm-Gg: AYBFou10Ytq5TF41Cwk+SbobqsDKOWXwN7CEIfflKUka/cCLM9xbvHkGNrkFC7OgGjp
 5RwZRAiWZOW8AT7Wq8rilbMN/FvjRlwLVAPi+HLQYBC9dULBrGpTuwZYPt05GT2T0YCFUj+miZt
 uDuWDSxTqpE497bfbsgVKQfUyoPhHGjKIDAjVZkOR0PV8QvQNDTCGJ5fUo0usazVT62If3J33cZ
 5l0L8I1nNF4XHJQTb1mNKyrXSXGRjMPSNCpz46/QcnDCX9oa6zFrC3kFJqANomUIRbDGzgxCacT
 4NQwHnKFt4B4yW0A8e+0TWaWDhzrU+gWHeGcptadu92E5EUQPOsKXF2apJ7C8uPv/lIoFplOj1x
 oMWJQj1iJ1jr6QLb5THX5pMSZRVBrmZNvMh7klaWPvks1ObkzRo6M86ceP8X08uvg9sAMs+AsmF
 iSGc0mgZ9fLyDiTbA44Krwwl8Cgi81v9Ptp2hItXmxHWjYmTMS7Il5Wzb9Xgz4tN6yfDh1gxgXF
 ZehXQRIGs2TtOuXKTqjs87s70lDSuNkz9s47O5s/Dcvh4u6Pmy2SYLrtzcIYUgNBZ19T4DEznlI
 TXSftSTHIrlNhqyGUrSJWGyOni/eXuHL0qGO5O5NPOcI7INxNz+thEL1bgcZ+rcf4JTv2dPKmfU
 RRPmnfYZ/E4i8+J2hruE/Bgqecw==
X-Received: by 2002:a05:7300:fe09:b0:36d:4570:a32d with SMTP id
 5a478bee46e88-37252e3a97dmr1835412eec.2.1794117918967; 
 Sat, 07 Nov 2026 22:05:18 -0800 (PST)
Received: from localhost.localdomain ([2406:b400:d4:acc8:a024:59b8:c312:eefd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372665db733sm2646694eec.23.2026.11.07.22.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 22:05:17 -0800 (PST)
From: Torra Sowmya <sowmyatorra@gmail.com>
To: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com
Cc: airlied@gmail.com, simona@ffwll.ch, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 outreachy@lists.linux.dev, rostedt@goodmis.org, julianbraha@gmail.com,
 julia.lawall@inria.fr
Subject: [PATCH v3] drm/xe: Remove unused xe_vm_restart tracepoint
Date: Sun,  8 Nov 2026 11:34:18 +0530
Message-ID: <20261108060418.4554-1-sowmyatorra@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101125808.9770-1-sowmyatorra@gmail.com>
References: <20261101125808.9770-1-sowmyatorra@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit f3e9b1f43458 ("drm/xe: Remove async worker and rework sync
binds") removed the call to trace_xe_vm_restart(), but left the
event definition behind.

Remove the unused definition from xe_trace_bo.h to avoid generating
code and data for an event that has no callers.

With the tested x86-64 configuration, size reports a reduction of
436 bytes in xe_trace_bo.o, from 20262 to 19826 bytes: 140 bytes
in text and 296 bytes in data.

Fixes: f3e9b1f43458 ("drm/xe: Remove async worker and rework sync binds")
Signed-off-by: Torra Sowmya <sowmyatorra@gmail.com>
---
Changes in v3:
- Add the Fixes tag.

Changes in v2:
- Document the measured object-size reduction.

 drivers/gpu/drm/xe/xe_trace_bo.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h b/drivers/gpu/drm/xe/xe_trace_bo.h
index 86323cf3be2c..fa91dd2b2174 100644
--- a/drivers/gpu/drm/xe/xe_trace_bo.h
+++ b/drivers/gpu/drm/xe/xe_trace_bo.h
@@ -228,11 +228,6 @@ DEFINE_EVENT(xe_vm, xe_vm_cpu_bind,
 	     TP_ARGS(vm)
 );
 
-DEFINE_EVENT(xe_vm, xe_vm_restart,
-	     TP_PROTO(struct xe_vm *vm),
-	     TP_ARGS(vm)
-);
-
 DEFINE_EVENT(xe_vm, xe_vm_rebind_worker_enter,
 	     TP_PROTO(struct xe_vm *vm),
 	     TP_ARGS(vm)
-- 
2.47.3

