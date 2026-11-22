Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA1606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LYuad9qM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756D110E503;
	Sun, 22 Nov 2026 08:59:29 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE36910E50D
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:59:19 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4bb6bbc025aso17463025e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 00:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795337958; x=1795942758;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2xtn5830lTNiRdDIiYhj5d/UObB+cYcE2nyc42dKa0Y=;
 b=LYuad9qMgxNCM3GvFNeS/HJZOg6eTODHq4Dnx9/es3YpkK1ym5PMvYT+nVrDeNRMwT
 wo/mPDFO5j7/I6wcD5Q5vngr3V7aOEEEQ8Bvg3U2Zdug8ABGbZuZmE7wUMdnv2nNRbu7
 cdRjKSkzms67vAtaCgJI7vjVK0fxQ/1/5VjlCPqcA9yyma3NTbh7sU5BrWe5a1Uq0DLN
 YhdEY1mCljIxNImml/vWCDK6Z1SOmcnZc94o4EkVVpznStuwPN6qwiHjhQW2RoM54uZj
 S25QUd8SxWoQ1elVdWePSeZ3Q9m3dEOZWGXrGInHoKZOl14y87YoujJ2mAaJSoc+uGUv
 djSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795337958; x=1795942758;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2xtn5830lTNiRdDIiYhj5d/UObB+cYcE2nyc42dKa0Y=;
 b=JTdaIS6V3f6E84tUtxGkwit4TybypzftsEQlfWDlzs+J4jyDEj6jDMI77MoMhlktkI
 1swYS90Hzcr0n7hhzPw0R/PiDsyPw3BXoMLWHl8GKwDPcG4VSctszztW94bkx9DV8cqU
 bQpDRSOlcMEgupSyp653VJ0qqQOOmr3io+2b1FAl4tVSNhLP23LiBAdlydjayrxkprb5
 6F5ugmLUymEENcz/a8C10FhX8bbKPQFomKFl3HkGsTsdgOZLlBACzJ1Z4tHFOQJZD9rA
 pTTIsYVpJLb9WobrSFzGBIW9dOm/cOjnhrY6EekHG6MVVIY5ErlduzBvhnu2k+mf/R1N
 DghQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGiNJSENRuh84bfWsOyAcUctpYymvccT/Q0zeXHYD/A+AD6fu1v2Af5JLpaZthIn5LBkP87o9FiOYE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/RfpdcAufSwwb2CKTsb65ox4NppbxOFg/tym3/izYBo0L+Gv1s
 tQkrIFvwfQ2MAZvB9QH4yMQ3EDOXEbvix0zSXrtGszbCPC2+NtEKh96phm1+m75tw5okjpW7SO9
 JtS9owLO6sjFmu7R5Tw==
X-Received: from wmmo19.prod.google.com ([2002:a05:600c:613:b0:4a2:1824:f77d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f42:b0:4bb:5c5c:8130 with SMTP id
 5b1f17b1804b1-4bb8881c726mr211965125e9.5.1795337958222; 
 Sun, 22 Nov 2026 00:59:18 -0800 (PST)
Date: Sun, 22 Nov 2026 08:59:17 +0000
In-Reply-To: <20261122-tyr-reset-impl-v9-0-ed42d8f513ec@onurozkan.dev>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261122-tyr-reset-impl-v9-0-ed42d8f513ec@onurozkan.dev>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122085917.1094675-1-aliceryhl@google.com>
Subject: Re: [PATCH v9 0/2] drm/tyr: GPU reset infrastructure
From: Alice Ryhl <aliceryhl@google.com>
To: "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dakr@kernel.org, daniel.almeida@collabora.com, airlied@gmail.com, 
 simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, boris.brezillon@collabora.com
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 22, 2026 at 08:40:31AM +0300, Onur =C3=96zkan wrote:
> Changes since v8:
> - Use workqueue v4 [1].
> - Drop "drm/tyr: clear stale IRQ state before soft reset" (applied on
>   drm-rust-next already).
> - Minor fixes (Alice's notes on v8).

Thanks for the updates! Both patches look good to me now; I've left my
Reviewed-by on them and we can apply this series to drm-rust-next once
the OwnedQueue/ScopedWork workqueue dependency lands.

Alice
