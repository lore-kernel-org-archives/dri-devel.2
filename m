Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E2CCD8CAA
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A3A10E42C;
	Tue,  9 Jun 2026 13:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QpZU08Ii";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CE9210E42C
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 13:57:43 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gZVpr3WVDz9v0Y;
 Tue,  9 Jun 2026 15:57:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1781013460; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OjPy0wHWPHxDDCt9avIjEjgVyhW6jMoNtYHb6SJMiFQ=;
 b=QpZU08IiRNoQZ/esRxcZaSbRoT8Q87BwhQfEi+u/8Hg4AAvrbovWbJhSbNDl1mKI67q8QH
 yN5uKssrKdgHLD3cZwF5bLSlSWlFlbyTvRjpJS+ReQFCwK2+EKpprvQJ/Cz8BGsJ8zvdFL
 TX2rPPQ/h161qBocrXodYjsBaj1eD9gBrSQfRiKhKVm/EjNl+UcYCVe6OUNW2pKmxPXZ1x
 O/J1J9SiTmB8lepiwOEdZIeOIOiRmeQWkq5hczvlexqjJFok+rDLxd8Mc8m9e7TdktNWSd
 +v2fSN79/97eauKMaHLqrgHrCc+DpR+aQ0K/QYNCzFtjA03pFWk79yne5aeszA==
Message-ID: <6b7bcc667f294b248f51e890964c707f4545cf92.camel@mailbox.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, Christian
 =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
 airlied@gmail.com
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Boris Brezillon	
 <boris.brezillon@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Daniel
 Almeida <dwlsalmeida@gmail.com>, Gary Guo <gary@garyguo.net>,
 linux-media@vger.kernel.org, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Tue, 09 Jun 2026 15:57:36 +0200
In-Reply-To: <dbda178c-bf02-448b-a88d-5a094adea5c0@igalia.com>
References: <20260608142436.265820-2-phasta@kernel.org>
 <95f4ae6b-9dec-4122-84e0-fbb0cdee9cb5@amd.com>
 <fa9a335196525adbc03ec21b2e05bb526e4fc174.camel@mailbox.org>
 <9d49c901-fcdf-487a-a733-0320d0bdf94c@amd.com>
 <DJ3V3OCLIK2K.3CYKWYNHYU6JQ@kernel.org>
 <ea4e0541-3702-4014-b8f6-0746a148df86@amd.com>
 <DJ3VYD71HDQ2.3C8GG983Z2YCM@kernel.org>
 <c8564ea0-8ff4-4049-996d-bd978c478372@amd.com>
 <aebe759117cd65004510946e39bd02e4c903e1e3.camel@mailbox.org>
 <dbda178c-bf02-448b-a88d-5a094adea5c0@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 731b6d731ee856e6810
X-MBO-RS-META: 3fdrtcdpt5a9q4q46qe4r3g76djhgqse
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, 2026-06-09 at 14:36 +0100, Tvrtko Ursulin wrote:
> I wanted to ask something else.
> What happened to the idea to remove opportunistic signalling from=20
> dma_fence_is_signaled?

AFAIAR that was declared impossible because some system setups like
mobile devices don't signal the fences with an interrupt handler, but
have some sort of daemon (in userspace) who peridiocally wakes up to
update the graphics output. It wakes up every T milliseconds and
opportunistically asks through dma_fence_is_signaled() (and that
through ops->signaled() which fences are already signaled.

P.
