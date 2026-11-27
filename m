Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114DA606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=QxXKvhzx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D14210E496;
	Fri, 27 Nov 2026 19:40:52 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E4210E496
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795808444; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ilEy0m3sAlzBkKvL9VPag52GDZWVDbPNgqfROjbQtNOE8d9Dd0sNz69AzqFXZR9eHp6Qooh7JEoC0+wzNHuMRtRTTcvR+06NXqZwBRuzdIF/ru8ddazKt2hD/pnujIohWkoruYpXGyuJHBBnz9qO57lP8cUuCkiocb2SUFhTJ+w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795808444;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lqF8jc2QrkR3SKq9gEQYdyy5tYfJGpiAZxCgMUFP9Ew=; 
 b=OSFM+gEy+veRL2/Dg8eUydYINPwPU5/7+ZSPGYIeEM7Db/dxZKezLykbybVjbnlGLD/Vs8M56A3x5/9+1xG0zCGcaJxIgJvhO6MSDRJESTnFJu2JRTm2jULllIImsPAQArdjo2AOPtUXsMhOh7oIb5CXrukTYMcvnudmLpzdgG0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=QxXKvhzx7di5J8Am7J4uE41S193jN0YhVpLLTBSrZjmXsrVmvu5m9YKJpvrhEM475UEzHpvbCtg0A+wYK66CpxOf8In2IXTaFXSoXyHywkk7tuCCjGWe1YSClwu+lvZtvEe4E7TAEFss9VvoEo90sJQSFDm+/xzwz5oFx49zIs8=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=lqF8jc2QrkR3SKq9gEQYdyy5tYfJGpiAZxCgMUFP9Ew=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795808442230524.8802054057094;
 Fri, 27 Nov 2026 11:40:42 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH RESEND 0/3] drm/tyr: KUnit tests and fixes for the
 firmware parser
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261127-tyr-fw-parser-v1-0-8aab2a711f9b@collabora.com>
Date: Fri, 27 Nov 2026 16:40:33 -0300
Cc: Sami Tolvanen <samitolvanen@google.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A70BA02-A671-44DB-B5D3-0D67C88A7785@collabora.com>
References: <20261127-tyr-fw-parser-v1-0-8aab2a711f9b@collabora.com>
To: dakr@kernel.org, simona@ffwll.ch, airlied@gmail.com, aliceryhl@google.com
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sami,

Can I add your co-developed-by + sob for patches 2-3?
They are basically your fixes + tests

=E2=80=94Daniel=
