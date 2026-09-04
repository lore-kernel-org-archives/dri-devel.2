Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8408C79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07CAD10E627;
	Sat,  5 Sep 2026 15:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mD/GdA6z";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3354A10F9C0
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:11:12 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2d9004f39d3so10064325ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 02:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788513072; x=1789117872; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aSJoHDgsqCGyR06J/jLVHcy8zkUYWVN9c517RlIo/VI=;
 b=mD/GdA6zcNHGfJAvVNUWDKQJtxfGd32h5nex1cxxHptKrSFPbdGrzz/8YZeTiSKpuq
 Ci5Pyu+/bU+vW9S7j63Gll9c8bpwlK2Mdx7ZdnMTP0Lhen/svqJtOQf3rDtxWMr+xvPt
 qSHEEWbVwKUj77Wt6jB9U7sA9VzZbEvDkbzL4Xc+Fq7s5nFtadXzpubKAyURf/3G7NRx
 aAzQcUXN0JQk1ufYkwdvaOmDHyV2REGEJf2IT1ioOUlaFMzDx7iEveuV1rV8vq3Suo2p
 BTvpGRa2t/eUSr2rEb2aZHyVij323S7u0ImS1dJr1EUu2Fbs1yJQwyOHUjP8bz8Vaca7
 NtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788513072; x=1789117872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aSJoHDgsqCGyR06J/jLVHcy8zkUYWVN9c517RlIo/VI=;
 b=OayHuh7RyHDLrnlOWo+ZT/7zlinZitQUjaQxgsLuYo+A6VVPfBdRl/ScuCnZf47Ts0
 2dd07gfIAcBpiZ1xVejtcik42lvJVQk7stR8ZHHFeiXfrwjokUmeYiSVYouzoooMkopr
 ygBA0Du2SSfIbaDmdRlc4DQ20wBmkMVjdNCDnCxk9GdijQcS42KuXW/RdJqFa1KxkwzV
 AcGfzbrxEDMzpoQs7rgGP9wemgWFL8LAMbDXjxuMF5zhDvtwuIZ4b9goJr4zndju/1Qr
 1p5xB6YkUdRDywcqMWhd5mvPZHb2E9aFFHxLr3TraunJftQBLohwxJHOHoH+3iQyvHA+
 TgqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBypggYXCcI0kdWw01C0k1vX0RK3BCf1RtrBArCVehyIpwPNXi5xZGVcqRxH/9X6w2E5QgYE8qXHudo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kw6iUQ4CXJnJEJ8d8rRdlMe4TjhROZgZEIxOox+MPekRYXgrwp
 h26tQb0elMq+rZBzmZoXeOPzUiG62Opn+A5qKaKT1q8cVdZTQawXwDA=
X-Gm-Gg: AYBFou18IOaKSn8ypMPnhR+jYdAizqYHn5Rb1zFaj6v5xKSeTiyim4wWw3uOpXjouW4
 jB9IDfdIHZ4YzKpZYJ7UHFDnQUep8/sKk6S7zh3Yk+GhgVkr9F5hTytpLP5X3IQnAQFjpVy9EBV
 RljXUOPWwnsF0Q7O2fuFqQ30UvoZ81o2PdZzta+oBLFkwHm7xSv6+6xttFvCnDsnaNmlBmgrKnt
 Iagkew4vXjWXCdG1Cwm8rAlGkiouQOptSAy0RelMJv/07GBJ++6F9TfcIDCL4tdisNHvtvY+I4W
 NRIGfyGlfffyUb76HHmnzwgQZjLReg21PFSGuB/5b6MXQRkNfO0+jqVeK7euTbXMBmDTLs0PyZo
 Rt472TeUI3yyXJPuqe88F/C/+f1uL7rWSpKeH9s1Vb8FLbiOiHtOKGw53OoUH4ywfTsN8XhccY7
 f330yYPTEeBHsZRli3FZ5u0q4FneR99Wr1Exf4mASf/yzFVSAQhyQTTDdPQv1BcCZMDlqCnr35c
 RAbPafLiJF3+19zCIwh5SG9eJY=
X-Received: by 2002:a17:903:3c70:b0:2d8:d2bd:a111 with SMTP id
 d9443c01a7336-2db1248cb72mr77818745ad.6.1788513071618; 
 Fri, 04 Sep 2026 02:11:11 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1497d455sm7163185ad.30.2026.09.04.02.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 02:11:10 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: phasta@kernel.org, christian.koenig@amd.com, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
Date: Fri,  4 Sep 2026 18:11:06 +0900
Message-ID: <20260904091106.2186243-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <196070b75705e9bc38106c235dab75e92d98cb2b.camel@mailbox.org>
References: <20260904080618.2098450-2-malhyuk97@gmail.com>
 <196070b75705e9bc38106c235dab75e92d98cb2b.camel@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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

On Fri, 2026-09-04 at 10:39 +0200, Philipp Stanner wrote:
> Please wait a bit until we discussed it for a bit.

Understood. No respin from me until you and Christian have settled the
direction.

> Do you generate part of your mails with an LLM? It seems to be a huge
> corpus for 11min of time between receiving and answer

Yes, I draft them with LLM assistance. I should have said so up front,
sorry. What I do not delegate is the checking: I verify the claims against
the tree before sending, and I am answerable for whatever goes out under my
name. The bug report itself came out of my own KASAN testing.

Your point about the volume is fair, and there is a concrete example of why
you are right to push back. In the v4 commit message I asserted that "every
in-tree driver passes a string literal". That is wrong: panthor kasprintf()s
the name (panthor_sched.c:3591) and kfree()s it in group_free_queue(). So
Christian's objection to caching holds for an in-tree driver today, not just
in theory, and I should have caught that before sending rather than after.
I will keep the mails shorter and slower.

Tvrtko, thanks for the quick answer on the tracepoints - the comment makes it
clear those call sites are fine, so I will drop that point.

Jonghyuk
