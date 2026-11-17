Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06801606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=BQF+2GpJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF1310F787;
	Tue, 17 Nov 2026 14:24:59 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E8710E5F4;
 Tue, 17 Nov 2026 14:24:52 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jTRns31vLzMlX9;
 Tue, 17 Nov 2026 15:24:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794925489; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/7cWyCVwtlpm6mypk4rCXgyNna2l4Z4486ikKJlJQ0=;
 b=BQF+2GpJRaXgNium9E8VjAlhLtGttDwOtJn86l7plSHuvFdBSEwPTimMwjghj2LNil0l10
 TuYVzGqQPS6UnQ+Cg2Y3mI4rhlHKSZ4G8KiVMBsydRvo5RW7aF62HjLm5UlOFy83AvT5b4
 i48nswb5pb1wSjJTOvENiz8b+gAdLY4SDI2KnnomXAQcgWkS8naTvwKk0a17A0TAl6lVOf
 z2r3BBm8/4sLTrjbKY8iqkPQmsOxCJqXXkFyqudcL2DBM4kJn0UD+S7IejCyB3nXPutrVP
 cUirGuS9k+S7AHWju6B4MSys8HM0NXfAeT7+gEOs50nB5yF9LkrzSRDbeN5wFQ==
Message-ID: <f00ae38bcd0fafdacefe21b6ed96164d455301da.camel@mailbox.org>
Subject: Re: [PATCH] drm/amdgpu: Harden against potential deadlock
From: Philipp Stanner <phasta@mailbox.org>
To: phasta@kernel.org, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter	 <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date: Tue, 17 Nov 2026 15:24:47 +0100
In-Reply-To: <fd9cc070b3a4e28316ad2ffce942227e33974016.camel@mailbox.org>
References: <20261026141541.469727-2-phasta@kernel.org>
 <bcd63af3-d2ce-488c-ab96-2b11536cd50c@amd.com>
 <1ed5c075-c66a-4144-b23b-a9d80e1fc2c1@amd.com>
 <fd9cc070b3a4e28316ad2ffce942227e33974016.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: zb3ge4x1gmw6augphdkpqbti7h9jdknf
X-MBO-RS-ID: e7586474e1991a176c3
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
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-10-27 at 14:18 +0100, Philipp Stanner wrote:
> On Tue, 2026-10-27 at 12:51 +0100, Christian K=C3=B6nig wrote:
> > I can take care and push the removal to amd-staging-drm-next when I
> > find time.

What's the state of this?


P.
