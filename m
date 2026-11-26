Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC191606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=cY4fLDzS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D51910E9AE;
	Thu, 26 Nov 2026 14:28:37 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C32BC10E9CD
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795703293; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LdIOmtEVegZIZhL1rINOEoKgNdeDmSWrg5uT0C4XvKBSReqEjphxgGraoSy48QD/y1oG+Q10rKrvPOBFKGAffDoGLWjscPFSHFLhUF9EcfAoUFqVWvBP3I3ADainZmo74XNMXTaUZ7ZAY6IwFvfnHDR4dmgtYuWVr82gUq8Ok+Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795703293;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ht0m74IIqDY2j7B7Fbe6y4jdNGqEQTyrZK0DRDZj2Ok=; 
 b=Zoadj0HWDzAVEOH+Zofdh4YjGzTin9+MP7Ry5omPJTJqO3oz3qpIAIJ69p9lf5dIgPPh4/+tpC0oUgCrbXW4fUbBWs1YzhvfhKAEXuc242u/t5q2Ep7cBP0SfFEaujxza9BFcVt89Qgr6clsBoDv/X52WSHJjSl5daVo2h4Q1fc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=cY4fLDzS0/8Rk5mO5FXOp2GR1w80Dx5qxWFxoViYI+cqS4BuXbb9CGu9xqAZaLa2f2m0hZZF/alO6bKHkXRLMN2tXsBKOwt7BSjZ94OSUFit8zR2FE1YGLnVjUoWGU35Fpje1ZWwB0QxKEbXX89JEBNO8mH5p2OzrFU/seIvM0c=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=Ht0m74IIqDY2j7B7Fbe6y4jdNGqEQTyrZK0DRDZj2Ok=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795703290555180.45960646424385; 
 Thu, 26 Nov 2026 06:28:10 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sunke@kylinos.cn
In-Reply-To: <20261125-b4-va_bits_clamp-v1-1-07e2bb33eb50@collabora.com>
References: <20261125-b4-va_bits_clamp-v1-1-07e2bb33eb50@collabora.com>
Subject: Re: [PATCH] drm/tyr: clamp va_bits to available bits
Message-Id: <179570327763.2912049.3505803472059954057.b4-ty@b4>
Date: Thu, 26 Nov 2026 11:27:57 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 13:28:20 -0700, Deborah Brouwer wrote:
> drm/tyr: clamp va_bits to available bits

Applied to drm-rust-next, thanks!

[1/1] drm/tyr: clamp va_bits to available bits
      commit: 94c9ad2fd7a15f58782c50e471397d1efe6b6363

