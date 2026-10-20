Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B3606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JUyPMXQ8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A758C10EC15;
	Tue, 20 Oct 2026 15:02:27 +0000 (UTC)
Received: from mta0.migadu.com (out-103.mta0.migadu.com [91.218.175.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 073C010EBFE
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:02:20 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=yOvWzCOAzttP2EAepfF+N2EBOK8OOCcBUIwHH7Y9d90=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792508539; v=1; x=1793113339;
 b=JUyPMXQ8FpEDW25IWvG8eVlzu0z6R1tkvjVZ5+9gF+/tl8ZuEw4twHlAE2dphmhlCNOVeMSx
 PC86pUsL7tg0TvqLvKjuwIKFHnW5AFe7SOsBhdpBwa7zj+cmCHT1CapFyiT4v+U6REHv0q3grJd
 SzgBG8iskrrA6dA5vw9rbKAQ=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 38fd257b22a290d5;
 Tue, 20 Oct 2026 14:56:14 +0000
X-Mizu-Trace-ID: 38fd257b22a290d5
X-Migadu-Flow: FLOW_OUT
From: Alvin Sun <alvin.sun@linux.dev>
To: Deborah Brouwer <deborah.brouwer@collabora.com>,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org,
    dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 04/11] drm/tyr: add per-file VM pool
In-Reply-To: <as7IqjINtIURG4yi@um790>
Date: Tue, 20 Oct 2026 22:55:08 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-ID: <5c0856e1dd1ecb48.1792508174@smtp.migadu.com>
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
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Deborah, Daniel,

On Tue, Oct 13, 2026 at 05:11:22PM -0700, Deborah Brouwer wrote:
> Interesting, I see what you mean because it would give the caller control
> over the vm and managing its tear down. And it would be nice to separate
> the creation of the vm from inserting it into the pool. I implemented this
> myself and that's fine if you want to go with adding a custom VmAddError
> or something like that.

The v4 series is out with the pool reworked using Daniel's AddError
approach, and the rest of your comments addressed.

v4 series: https://lore.kernel.org/r/20261020-tyr-ioctls-v4-0-704de77da223@kylinos.cn

Best regards,
Alvin
