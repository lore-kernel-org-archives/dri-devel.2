Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027DE105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CCB810E060;
	Fri, 13 Mar 2026 13:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FrZEtlKu";
	dkim-atps=neutral
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBF610EBF1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:06 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-466f1c3c627so1552484b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408186; x=1774012986; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wIIBK2xLHmy9ZZczWpP2RzFmOx4bELZz7aMw+RGO2w=;
 b=FrZEtlKuDuEfFlrIRTNM2hGm6GGCDKItlzdd/w8l+TdKrX2ND6iD0ziBfgO5Czgs62
 9evv8DmgMv/EnjUId0sgIcXW9ofQkAZ0YzGJaIf74VUMUqufCsJuCbKmbSfaiD61G7cq
 JtDRg+ZpKIfMvVDi9DFkwo6kxRs/p1pYU4EEwCVUBrqxG4mc3XTVETEkFWPAGEWnqP8b
 iU11ycRAOS+IrY6RDnJLFGb7KSRPDZS/mi5VAN3zcYC43jiQ4ZiNCZdBwJW1nYY8V6uH
 T1w31A7U0xz0CcMYcraNWtgFfeMNjaU1TK8KD5T9bIam1lHNQ6HCbaSdRi62IS1S9VTK
 DFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408186; x=1774012986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4wIIBK2xLHmy9ZZczWpP2RzFmOx4bELZz7aMw+RGO2w=;
 b=k9OaVkcqFhywjo4t7KOAIuWce7xI4bKQ8a0DRq8g3RJhk8pj5x6oYh2WXW8/penxGo
 17K3MqGHRfZKkfWU0lVhh/B61N/oD3w2YunUY7YWbFv12sK6blLRQKaOsjb5W9dx7OHl
 NGoh2sCICOwIReRB3twd2pFQro0o8AB4oVDnyDLZl8w8/Nob/TXMSWlLN9bJZnTVGcg1
 6QJ1zwngNnf8ArFvZmEGm4XsRkax+EoA5AzX7K2gVSR1J1VuQGdRDcFiLKk4cWw2LtLy
 SHw1TIaOs3460RM2tVdfrtdNJLPNPCRvzVZD/cRN0ZUS4ffqwrD/JUA7YWhQwuZ77yS/
 YWpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyXvvHyKBbaHWvYAJZlG+B4sde3GkWUweBz6HkGRH+gU6pqGoYX3/GdD8gTKV3pVDxgAuMk9ENFGA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhpRMkurwLn803B08CFAInR9vcHX/W6sdv50ZaNVrAY3LOrlIm
 xToRZnoFGPfwZx4LpHFzOvQOHck0XI5FtrT7u7g3fMGnRXHQFYiSbF9H
X-Gm-Gg: ATEYQzwUB5PR9yeSgk1YnLpf2XInsknv3HYAuR8A1e29FLNLef8O/sVN+y+VUIRbiRb
 wKN3wSqPB2Q0MBWbAeJFMRt3s1gcYKFJsKlqW2UHDQ+sa2jK+VenDHCNSgVY77DYGnw/Ycad85i
 +KJbbEYU/PkV04hQlrcuOtglMs7VMrcvDJsXNRSc2uqDtDDzD8NeflSHKwMYu4+4/cOyYczeWv7
 9IrZwW4m9eMrHH6jh/r0X19B+tj6qj5vbr1h/7g3V6ozxWL089ld6Tpx+aPBA49bZ+6BRaRm2wK
 zeXzpigStc5+K8epTtvHTo1XjfXVhzbFt2VJhSVOD0YjBQ9to+k577/wrnAQkZyvJl4K4VJrArc
 qOxReTGlLXGjaYhXkOUCjyvr3mmy//nqZGdV3qoWtmcjpfQRQ3iYeUNE5LaiON+W/1x7U13i/DH
 29ycOuuVwjX0cerMepXyEbyXqkVks5rFmDK8xal0XNGQs0wesT
X-Received: by 2002:a05:6808:15a2:b0:467:1e5:6766 with SMTP id
 5614622812f47-4675766748fmr1758674b6e.45.1773408185885; 
 Fri, 13 Mar 2026 06:23:05 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:05 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 05/65] docs/dyndbg: explain flags parse 1st
Date: Fri, 13 Mar 2026 07:19:30 -0600
Message-ID: <20260313132103.2529746-6-jim.cromie@gmail.com>
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

When writing queries to >control, flags are parsed 1st, since they are
the only required field, and they require specific compositions.  So
if the flags draw an error (on those specifics), then keyword errors
aren't reported.  This can be mildly confusing/annoying, so explain it
instead.

cc: linux-doc@vger.kernel.org
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst         | 17 +++++++++++++----
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
2.53.0

