Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8595F105F7AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5951410EC28;
	Fri, 13 Mar 2026 13:24:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WmNTlo02";
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E28910EC0F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:17 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-4645dde00a7so2693606b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408256; x=1774013056; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26vMP3nfkpOdAIVisqGbQnZnw5iiyCO+aaCVYuAOEzg=;
 b=WmNTlo02SCBpoSToy/6YiubusBXVTTjAKS2GiPGp4uAeFePbVPdIPs8Hv1pF7u8ocA
 5ZOI48Ea/8GL4U+x6fCBUbpJ9847PoYXtl25EjbSEwoKgGYbZkzd6o33XHjsq+uHMVYE
 uFsrjtQDxkOwuIpODyW4ONx5pMEvKeM74PAiVpnnhLj+ZIYtRoIEnqGL/8d69eNuXyYb
 cLfVPs6rAacPNDHzpVbVphebvLF5rYWtgRZFtEVMh9rwoeBcySu9mAAtQkDFlaYTvarB
 No8wqECDfv0LVqUwEU4Y+roUlORNxIBVnTY5L4okV/lHA7rDfyzcS2Cf/TFIf43w7B9N
 RdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408256; x=1774013056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=26vMP3nfkpOdAIVisqGbQnZnw5iiyCO+aaCVYuAOEzg=;
 b=CLsXgn2xoVxLk5HDHqbtP1EjoTTogGrFwOqr9+LPhAbSJyMYycMQpdFjjU4GiFhsby
 wiP+0hyAfxt0ntzbvAxr1UKno9ca46RSE6Itkh8YcJVi2tSZv+hlKO47fsreAZgFyN42
 VIWhU+rHAElygg9CpP+l4w/Pv4pgDZpVNIVNyFqRDmrTknYFYcA6EuN0sq+6vthAi4kw
 27hIEwdVG782+nlkIp8KMpjsOrsEC3fe1m1KUDUNTjpEUymK2YPPMPNvOkzHLS74wrId
 dZ0Cgh+aDrDsOGGZdOFU2XLE7tf1+SIXLH8HbN2RSXJXtyeskl3J8g5tmxhju6suFfA0
 nGDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNsdz/1zBbjYuQJ/1VkcW08ovYKPg0egurvVoNnhUO9CjLRki/vS9Moyods7oD4sg+LfbOuHfIxJ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOXUJyVmDDJ7X6JlqxPeN+fsjlOb0TNF8wtcN8h3kO9TGQ7awc
 YJ5rObce3jw87d4snDOFH4sXTfvZ3tP6zONjSlxd2AqcnL21RXMMAsyJTEgQmHu0
X-Gm-Gg: ATEYQzwpzKdU3eY7shtog3hUZkCJoUJt8u2aMPcbUQnAWtte/f9BEOitrFzSUuQAYRE
 9xNO5KMgZaAUJDnolwACMfalpqlq/aE41FH7km1t04JgI+2C6Cg+l8Y62VokaLNd/hzDlvNZDa2
 yhb7mCuF3buQrqUX/0VfBjVwJaTVzDLqNXmNnp5Tj2lfzAuDJ+LOjkFSc8+dC+T/ETqKWcmslAR
 NDzfZ0hrqpaz3MH6bAZ41rLwCZdBmY3km10d2zPuglYkD3Eq6fl/ngz3J0g9uRgcvXE/poO7NHR
 UONB8/06zEPcNJWew27HCx/6WAq0vbNdHR0pLywk9KWtG7tWazY0mRLytrGZwSPVSutOTizbRqX
 m2SJt2trU+sdmFyHc16lFJ1lvjnhMbeyPlRVh3mWYNQ9HNSfuxak2k0uUShfZza5GB+cKTWjqv/
 DF73NVDG2e1kbu9HvX7RE7enlNYC1DDOhtXzN9SHwaInDUKcwX
X-Received: by 2002:a05:6808:118e:b0:45f:103c:2478 with SMTP id
 5614622812f47-4674329caf4mr3963254b6e.30.1773408256475; 
 Fri, 13 Mar 2026 06:24:16 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:16 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 37/65] drm-print: modernize an archaic comment
Date: Fri, 13 Mar 2026 07:20:02 -0600
Message-ID: <20260313132103.2529746-38-jim.cromie@gmail.com>
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

In the year 2025 it is no longer noteworthy that drm.debug logging is
adjustable at runtime, via sysfs node.  Simplify the statement.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 94064ec6c229..c3df2f3f47d8 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -89,10 +89,9 @@ extern unsigned long __drm_debug;
  *  - ...
  *  - drm.debug=0x1ff will enable all messages
  *
- * An interesting feature is that it's possible to enable verbose logging at
- * run-time by echoing the debug value in its sysfs node::
+ * You can also alter the logged categories at run-time:
  *
- *   # echo 0xf > /sys/module/drm/parameters/debug
+ *   #> echo 0xf > /sys/module/drm/parameters/debug
  *
  */
 enum drm_debug_category {
-- 
2.53.0

