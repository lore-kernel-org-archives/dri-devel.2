Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359C606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HA7HOYga
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2AEE10E18B;
	Tue, 24 Nov 2026 05:23:04 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2764610E2DD
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 05:22:59 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-92125687442so41711146d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 21:22:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795497778; cv=none;
 d=google.com; s=arc-20260327;
 b=rvStNr/RdJbws38ZACrjz4bNhKtp1PMAAZzLgYUzGeJp9fel9+im0jfBxXV8LH72cr
 5ZoDiZn+BPHpwTBm/UY0RnnVZZkh7GS98q60uBwJf74nep6XIeypvtVCEiVjvedTrSQA
 o+A2ZCdog/7EbJBHsZv8JO+jgwYgJhILjK8yGipWkHg52k91juM4VW6cIYDQUE7HvSzr
 ggHetuHcIlJNt9PBoxldMbpqjpCxH3Os3UFvhE0B9fKYFX5xmlKF9DRf/W72F3BnzXf8
 rFStNr6CNc5S481hVY2MZwKbA3PPrh5JxbWi26jQbcfpWjwxBkZ8vpu2At8A5oZZClTB
 5/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=O87hKc4hUbbsqQK96K8mzUV4IaSwRq0dFjou167Fark=;
 fh=6P9yjlKLaf0WW4eKEVmmeGUKxm+/d4NBEw/x4XYIXtc=;
 b=rzLrlM1QYclUCDzvJLi6S4lsA0sU0MGklW61tMjBGTHS9HerNopkx7ApatL5Iu7V8W
 G4tIGEpq0zTjtMjLUGIIhawb7HUJEezMviZ6UbE+m0gWHIoxjP1wOa9IHcV4yoEXBANz
 KiexDnjAzNenRSrjzelvtKCPww6bYH0RbzQaOVKiZxUKd0MUQxqVnonaACkpNAFZ5skQ
 AZ6bSluYeezvpqCPXmHs10DCwbRJT+rHV1dkv4IYmaGeZjpTP2s+mHgGZBU7VMpFsaDX
 eq4C9ciZITvTUqYdQxH5YMaVlj45x5V6VPzjI+nfahqxpPQJqHtPWY0hfxq4KsqJCOa1
 VC9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795497778; x=1796102578; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=O87hKc4hUbbsqQK96K8mzUV4IaSwRq0dFjou167Fark=;
 b=HA7HOYgaYUzLojyMLVZBwD+PM4HJFLxnI09bivZdDpLHw5M1QZPaJEJFPBZDIKxOdI
 qcXANWKdzALc/Y+2sUvxO3cZlN0BEkP+HZNYYss5NDtS/gF1U1MEnW+axTZgVUYBF/2Q
 65yn6B1MRoefl4Fa4JOWbdcEXfNNy6JURA94xWXuBJBIZngOtAqUwq1EebDSEWmI/yxg
 8EmPFPAGZKyYZ85EcChKZpUkScgOdxtTl+9aSYG4CT8KzllzIVMAYIA6MzfJXR6Cspi1
 xxVP0YIlRmvkZZTzGo28o7ZLL3azhxzQGHIXUzXtUwUCDb7USEApV7skEcPf+nfC3SEd
 RhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795497778; x=1796102578;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O87hKc4hUbbsqQK96K8mzUV4IaSwRq0dFjou167Fark=;
 b=jriBrNbgl7i69yk8684b8CzhXP5csG9/bEnkgyGAuNl4HSePwcqnWgqR5hsTWr31u3
 MzyeE9ARnVOHF+HWYxA3aoQP3gFQbnv3BAhT49zR5OtRniSsmv8I2SA+OM3a7imWRBYF
 0GPRIzLWBe7Snl8MryUkV3G5W4ZtZ/QslPUl4wm042pRISCxcip0d0vQWa1SIAjSVi/q
 J+fjbccN/79YupvmsSV1k70Vi5CrmTiWM7y8cUp+z6RXfkU2gic4cbhftJY7tpUrPmx4
 xEdqNKNy759M45QySMyvZ1kAyKGbDNHL3a9uvLPURyEB13v0/UJLfxEq3He4GJ2gSInC
 EtkQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEfuGuJJvbaOs16+LDZfaS/3rqD+lLQLv4UqVele0juA6Yis6OS/GWE0wXTa1Fci4p3hd+DHm++GvA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+uKHtGSbLZaJf1JBUtyoiYZPvsTbc0Kdnr9Alb9fNR51M0YA0N
 YbBuk24aeytXvbYx1wQRzwyWeXbLNw3uQ9Rm6n3sTJjoIrRJtp9QFEIjryI51dG+Kvwsj2ySkoT
 KpsqPXFn1GyBivH6wF55r1iSKvTrjsvI=
X-Gm-Gg: AZFdTZdy27trb++4O9GuJOsIw6Wmc/yAQMOhlrG0L/UIUTDSt0IVIgaTxKzlmZ5N4DT
 lk7jHU/pOvUQ42rfw3NTSau7eaUZIioItwsDQbN0WhODMAVQFcI2rRi3vw5OpaPrshwgyd34hKI
 bbIyE2y00ME+RGQmLn4q0BxQoCNy2aCWO5TKaPfZsAnxgX2aQU/pnirzosEs6Z/pdc5D1QH+qRB
 w4K/AJTNACuhhFzSb8NbRAT3EhJBxO41ReCwTNG7gvNsk98qfeF0yWMYQS21tPWNZiub27zENk5
 zXTKLqDxGFrzcPQVUM0mHgBZRkTpr/rv0ZZAhMzaZ78IPCzHc5p5fxsdwogT3IKGI0g+wyfjD3F
 3iCzxYk12vmMZB6fdIx274urpSlalRHS+Qv5u0f2k7UFf0yMu0GHQWHcgdBLclXXtoVMFTyybdd
 YK+O3pD4+7ko99uuotiu9+/w==
X-Received: by 2002:a05:6214:508e:b0:921:3769:b79c with SMTP id
 6a1803df08f44-9213769b9famr219080356d6.43.1795497777776; Mon, 23 Nov 2026
 21:22:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 24 Nov 2026 15:22:46 +1000
X-Gm-Features: Aa3M54oJBWaQE9qtaRcuwo92UYviGf4SAmjDWFc3egNkrmN57N-DhwkJNj9eWIg
Message-ID: <CAPM=9tzG7vBCC1GG+7nM7ViMPtfCpRy1ytZrTthu=5N9ddVi2w@mail.gmail.com>
Subject: when rust and checkpatch collide
To: rust-for-linux <rust-for-linux@vger.kernel.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>, Danilo Krummrich <dakr@kernel.org>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I was using opencode + GLM 5.3 to edit something today and it went
into debugging checkpatch failures and found a funny aside:

From GLM 5.3:

Bonus finding while re-checking:
Moving the dev_info! exposed a latent issue: the message line was 133
columns against checkpatch's 100-column limit for .rs files. It had
been silently passing in driver.rs because of a fun checkpatch quirk I
bisected down: the Core<'_> lifetime in the new function signature
contains a ', which checkpatch's C-oriented sanitizer reads as an
unterminated character literal =E2=80=94 so everything after it in the hunk
gets scrubbed, the string quotes don't survive into the sanitized
line,  and the "line is only a string" length exemption stops
matching. The line was always over-length; the exemption was masking
it. I shortened the message to 99 columns, which is robust regardless
of the exemption.

Dave.
