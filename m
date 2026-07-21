Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F55C4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0690510EB36;
	Tue, 21 Jul 2026 20:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ch9+sIWD";
	dkim-atps=neutral
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3552310EB36
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:13 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7e6b554044fso9243372a34.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667432; x=1785272232; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pgVpgKXUNJtrWSKTwQbIOxGGmQfqameHK1lD3QBhDhA=;
 b=Ch9+sIWDiVS6zbqKMiXKp6UeVi3EdInOXU4aWRaZ9A3Nu+biw9I4ZeUGYUu9xQhRwg
 Z2yTS9vDcXVxQxdNWIW+2GbT9z5wJrCngRIh6CmSbUM0DaESBAqMsLNaz6dB027/FPpN
 EZ4XxhRgVC+e49gLlrTiSlGUej99zu/XcaPF8ac73d2mEYCm+4REvscEpSKuWRh13PK5
 k6uMuCyYBeMloCpGUyJLdyrkJyO9ptoHNSZjDxdPhDprj9kE+7N7BweCBmIBF9ruKmrL
 J1ETjUODnalE98F1k7k1ZLLeED93IaXYP7NZHOqZbwgbRv6EpxSF2Qz6s0RunK3fRTQs
 jBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667432; x=1785272232;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pgVpgKXUNJtrWSKTwQbIOxGGmQfqameHK1lD3QBhDhA=;
 b=JHVrrNTJ4SFD4BGQ8/Mco7envmSQS9qd/FgfelhxKzjAIH8ESy4yx/dSoaFKoa1rXb
 vh+IBjf9U1kF4nHTJO2263maxgJdISJ2mzsQBUlmEwA/VOHXAf9VsZiqXWCCPMNPKiGS
 DY0XupgGgkkHLjnU8MuNLjc7L+pYRKqpVt8eYm4KO4NeW8fwsje/f1jfH8BUGUNlyejQ
 TOz9BhmjgO3oJLnvtC7qhQtSZBNmhbMwZ6Oj4ODGc0ZajG1nDWFa+yzZrCf8hgZgjXCK
 nL5kilMy6/CjvMeKkWbP1vMG4z9A10HcZSVvhgkxvWcSFPN12DNMXX/3TkN9rXjW0F8a
 02/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJREAzjShYW7Y6TcEk7KTHIzJqQVSWbc2c3q4N+V8LY5k/z20/4WR1lMeuqXm4tcrsz6QudBJSm44=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOA6zXOqedySyr3ze7x/oZ4WtIlhi4QAweAxbQFqTGPcun9sDP
 6PW+m0eLJ+SUkYzPsl0tS2fchM/y/gH1Gh/VUyzoSwmsbHwQNJlZQKiZ
X-Gm-Gg: AfdE7ckAHs9p3ZNAb0cWJ1bO/kPgN+B8KgoWJuF2M688mHdLaNL+hjSBIokz3tLwV4m
 eFKrWk/dRoSb/2LKmZQ35wH0WnLcQjAD5otRZTKvf3aRv27Tre8X3TrbXs4bmvijxTzTWZ/VMiC
 PzKiXIEfy2HXVBqFJmqdJZgoJQhFxJ5Xf0lVzT1Hzwx0wAdz3+lJr+ZqeV0D2d3ppkSv3Ddt+4u
 nHf4SvMyVBKx/w34k2VrIB7o+PwfdMhuidpOzJWmuzpI3YE1uWXyMhcnZHNZCU5afjZ8LMftbWR
 cHSEl+gCZvz360VxGxgTfJJGOBJVZhTsIPoqiuexqgrXZGkXS5nQnQ/cBv0AnHNpmTTSryYuwuM
 qEFZVBA2HxlWt4Nl9VzhKSuX2+GdV5xf6IjJ+NNlbTRHBN1kEPtVCEbCQVPJR2Z3WqPoqQUoMR7
 PzwM6FY0QA+kUSLpv6rC3JYQVWwDjQng/psbZwtVXSu8Du06NJcfnns13MWVo6Kell1yIQCHprV
 eeumOPx+xqsfwiDS6PI5m1dMQ==
X-Received: by 2002:a05:6830:6518:b0:7eb:21d:70b9 with SMTP id
 46e09a7af769-7eda0e701bamr9566145a34.22.1784667432329; 
 Tue, 21 Jul 2026 13:57:12 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:11 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:50 -0600
Subject: [PATCH v7 01/29] params: fix a pr_debug(" %p ") use - already in MM-*
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-1-010fbe73b311@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=1125;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=NjeO3E3aXTlf0Rmaw0bPO/yZw26XHF8e4PdgxVbvO5s=;
 b=JnG4Hd6pByV6cBcRHCdIJRICgp5wUjzEQUOylmvD27efVdhP0Cn/ay5LhcR7goGzLrNO9vFYm
 yTpsgAAsjCpAWnQCPpIRZXIEjFbutFhwOQKtI2azaOPhH5Ccc68vKuf
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

NB: this is already in mm, but I need it in this patchset because
kernel/params is subjected to testing by the selftest script, and the
test depends upon its stability.

kernel/params.c has a pr_debug() which prints the address of a
parameter setter function, this is not legitimately useful.  Since the
value is known and useful to the user, print that instead.

Cc: stable@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 kernel/params.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index a668863a4bb6..5c8a05921e28 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -136,8 +136,8 @@ static int parse_one(char *param,
 			if (!val &&
 			    !(params[i].ops->flags & KERNEL_PARAM_OPS_FL_NOARG))
 				return -EINVAL;
-			pr_debug("handling %s with %p\n", param,
-				params[i].ops->set);
+			pr_debug("handling %s with value '%s'\n", param,
+				val ? val : "no-arg");
 			kernel_param_lock(params[i].mod);
 			if (param_check_unsafe(&params[i]))
 				err = params[i].ops->set(val, &params[i]);

-- 
2.55.0

