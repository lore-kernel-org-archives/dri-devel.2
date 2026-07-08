Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D3AC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF42710EF89;
	Wed,  8 Jul 2026 02:18:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mH2PMBSR";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF13010EF82
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:18:39 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-489795617e9so103244b6e.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 19:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783477119; x=1784081919; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tkpd6XZrbayv1qGlRLm5NJZ/GcnFTR7uIhPPki4vU/s=;
 b=mH2PMBSR2sSE4MKqperntS8ANPeidP4KEMR+kXuuIizC2nsa0CfoUl2BzDPF2PJ4Us
 FM9jZ4IMjzr35sHeAlGGVflDsvmCLQZphXsl5eUdVMvI1kRj9TWJDhfdd6V0cFeaL+x3
 7tPbaur1dFlSZ5OKWbU009/oWwr9OpMobq47082wB+OsQ6vRB04gt9sRtlV7FIBrN3lS
 bIpxVATuGqDw9vPD0NLg3SeMLeRY1/AKskQ2jFvalGVGSkcr/i+fNIGUORSdDTMsGUeY
 9O062t966DTlmcqv4PXMdAp3Mz8uQabqafwqtRUzy3cXNmH3yNPdJOqlLJd7JF2PryGG
 n6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783477119; x=1784081919;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tkpd6XZrbayv1qGlRLm5NJZ/GcnFTR7uIhPPki4vU/s=;
 b=V0+H6NZWaHTwoSXSxWjupcBmto/NhwFtsc/OAMSbVZLQTTNYRaeuF+sunaSmDWA0DA
 WleuGZXPIUSs8hvBwGMvz7WHLMFol0W4APWD9ONjSm8hvgOUxU8qwH0BoF4b1tZHNfR3
 x1f0/rWxIuwnTDSdHvcmLbTsVUCCNP5GfcIx6d0VLALMiWbhsULlkykaGRSFtKzgpex0
 9hZyg79LEk12x7vRiR3QxmAvLYflx2QNLH9hiJwq8zTPwzdudCNphdT1xnOiryyzk4x/
 Bzv52h4T40A6kjAXxwk+aNNVrNFakZaQtsuqjVkFMXgoJx0ZJOh997TIArf/SFkGVOeA
 oA4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ++tKKi5JKVfcSKP9e0gmJ4PRZkn7eRn/Di/RbmgcvyCYG/ZtEOCaVCp2vGVYZMAozqNxvYr5IF+9c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3pENae6qKJJyr9YZW3oNDSEkx4pNDxIzhVuGig/r9r+cN+9lx
 rC8iPE76Q+0S2KKvr41C5/FTtgTJPHRe6b7Xnc8b+yY/28taFTpkiVu8
X-Gm-Gg: AfdE7clN+oK5pTwnJUDHfO02K5tmcuDIrZrZhZAbpyC7PqYO+Gj8bDlac2sjqJoczjc
 7v78xgMhMKcczQw96r/KFUaXKjpsow8QvHt9fdIhGTxo+OJhAEcRx/YoQ2vNUA+HDmtzmR9NyQE
 ytxgM9uHVMrhU93DBwN3XBGgWHNOncX7g3eY/H3p51C3n5hck+o8SVwc+ZBXM7sXiskMuc92S61
 thdRe/7J5iHb1NVqVAl9/lbvzT1cx567Wz2X6Wl48lf0Ps3A7p1c+UKUemi+L305z76AoMjyCjc
 QZ9guOIltNueds6Nh3vWhkZzZDYxGSshF9ZVRjmHoN/He3MqzrB0KUcbxlOhb764Nw75xELWES1
 7r6ZsG2WjydrwaaEXnnOslYSRmxMd27srja+apNqCFOkIh93oxS99fPy9UyXHzpAQ2VQiLn0QhA
 RqLTacbWU5zxeaMTTaUwVyM6abllJLvENzhzXuUYTUTkX3mnAWOEc=
X-Received: by 2002:a05:6808:1385:b0:496:301:36b9 with SMTP id
 5614622812f47-4a1fea2d9fdmr467296b6e.0.1783477119240; 
 Tue, 07 Jul 2026 19:18:39 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 19:18:38 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:08 -0600
Subject: [PATCH v6 08/24] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-8-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=1375;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=yfxjNCD2FfV6WQ7UCS9hJEIU3/cj9TtYhccgD7F2GOk=;
 b=BqO4fRVBObl9QNOP0WewNHKxLyFZjbRWwWNClrxuHOAw7XsQmdRiZGqV/r7Wn3OiYiYYQsKGT
 PfAkGsNm/bUARzjCeCDIMDx56NqFAFY351zybs4JuMgykY0D7McoJD5
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

