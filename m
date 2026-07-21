Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39815C4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4420410EB50;
	Tue, 21 Jul 2026 20:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AiuQDDHM";
	dkim-atps=neutral
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13A3810EB47
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:28 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7eb4d532e65so4555438a34.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667447; x=1785272247; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tkpd6XZrbayv1qGlRLm5NJZ/GcnFTR7uIhPPki4vU/s=;
 b=AiuQDDHMffJjWLnoXaRZf3cqbT132VJe1zMzyHnRY+TODZHXkvxYGVWvWwz2M32ftl
 ST2pkCvfBlfoazvxAMG2FSG4lgYoI3LAYMiqbmQ/Uhd0NtdA/4eEmxpERKPjeyl6ZpmW
 xyUukRRWPI1UTqeEPG/0wp5wtJfGqFvEPRI9R1XM05yvScFU6lXnioGg1o6hQ1IhuLK/
 O/laFlUU2tR9HmhAdsCF8ed1WplaesRZNp0Dpo5BOCK6vOhpZqaZO6SimqENReBzVh0/
 PMtSJy0eqvIvjVj6RztM0EXnQN8E2IFkKX84NRLtS6lEK1kuGXufarKP73KlpKqN2WdF
 UJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667447; x=1785272247;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tkpd6XZrbayv1qGlRLm5NJZ/GcnFTR7uIhPPki4vU/s=;
 b=rchVVAkWbQVeDb6h+MbCnWXIlZCNBegFwq/SGr9XNRxu2JULmKE4Bh/aO1NRBP6/fS
 i7ZnPFg69gwt5tFcgOknjFQ5/GPSVEj0PCX9vWMcLJemFMsRs2O0UFhbmiAjqfXDGt31
 8NWZDTxdN12kEUaoqQanA5uJ927jwEkTu/JeH3hCRF6Sof9m4agRUK8hT79K3oHebAql
 xk4nqxmaxI1dERLRDkt1dL6m/WLcGYdBVOFUpIgZ3//4ZXCYdIDWQMv3nrr8C1ahHXGu
 XLaF9LEjS8i+nYRUXU5WzWGzitihiIoZ0/LrvDCD8UsWJ1FGZo+FvIhBjRQsyeFMOBtV
 ZVqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTsBVVckcU4mj/oEGrn7MR8UzBNUq4mRtxWsZeFEDpgEQeaSTwDBfGNfRjODN7x+SIiQeErJ9ZNoA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSSTjBlsQrlnUaeVrj43P460PhtRJ5H8VD14EvXvvvGGoMW4yb
 nTSVkgtGVDmrwGqWsDjPwkGgng//6Fg2wmaHWAQGjzPmZFV9iiiaikzO
X-Gm-Gg: AfdE7clf7cayDlzmlXId2R72PGC2Vc5Zi7uoFW9lssKuxtw13A5pC3TmLmf/INrBH/O
 xyi19PSqDvQQ2YpzoIjO++Px9UbstqzohUm74nOADXXkiswuOfM51nBQ280N3VOLxG0wkChMYbF
 PwUiRF8ZeODoHgjylb3WL5m0S5mzL+znBjxn3YDTVXuQZ3f9IUwNp6zI4J5XrZYPe6M1M6N/pLf
 GoJLePTkYHQ01xTFWmSN0C+u6MIN5lOz4FQggg4vZOUb9Xb7DBmNqS9oY3f4ObYS7tzXtAEoHOh
 4I+fml4PdzLEgoJ2nBAKftm4M9MV2NMJkcURKRCsZKzkGw/MOpbO5OEjv3mAP5C5b6FlIk0GeSv
 jJk+G/YUl71VVEzD1anBTmA2n5zLqoPee4DTZ9YGa1eVXCU5sB544MeubxypUaymt9IzhYS/nbM
 jhMSfkx8s9vsRduoFeliig9Z3ihjAtT47cqtniNg3x7eltNiTtdXkiX9JrIhVvSpnNjssOzZ4M0
 cx3rAdt7YXMyga4S3tZiSDf6g==
X-Received: by 2002:a05:6830:909:b0:7e9:dbbe:5af9 with SMTP id
 46e09a7af769-7eda4d70994mr10261926a34.31.1784667447247; 
 Tue, 21 Jul 2026 13:57:27 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:26 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:02 -0600
Subject: [PATCH v7 13/29] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-13-010fbe73b311@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=1375;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=yfxjNCD2FfV6WQ7UCS9hJEIU3/cj9TtYhccgD7F2GOk=;
 b=QF5cQMK6T8UD1YJz5nk2AJgW01BgHiDFKzY+xuJZdV3zwDHcNIHgMuD2tCQNxi+sv49R3fsxO
 T3mOec9MvhtCAxvyJpnSu43qxs3y9ZYtOKNNAHiEMVbFgE2WhPqbHCp
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

When a dyndbg classname is unknown to a kernel module, the callsite is
un-addressable via >control queries, and therefore uncontrollable.

The control-file displays this condition as "class unknown, _id:N"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_ _id:N" to loudly announce the erroneous situation,
and to make it uniquely greppable.

NB: while this might be seen as a user-visible change, this shouldn't
disqualify the change:

a- it reports a classmap coding error condition, which should be
   detected in (or before) review.
b- SHOUTING the error makes it more visible, uniquely greppable.
c- the classmap feature is marked BROKEN for its only current user.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 577a07916072..a86e1d5845e6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1170,7 +1170,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 

-- 
2.55.0

