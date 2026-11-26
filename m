Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA96606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=gKrKVYbv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA5AD112476;
	Thu, 26 Nov 2026 14:23:48 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14CDE112476
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795703021;
 bh=SeH7W4HXcoMbKbmUVHcSDi20fgxLOytbLKN210ZOlI4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gKrKVYbvVwu5WWkzcQ2z7uMhkNOB/Eoprtm7L4DXw9xL4Fz1yV4EPacje+wbpIcR/
 GXMb58l0xbb3Cf0DUgH+vpOK1yeO5hHa1K98pX+DOsFGPonrDnvtsEJrahTiRSNW4y
 a1IuTbRxlwO2F7uX84qr9nfZou9L5AWKm3cYC5PgipxqMgR3lxACu7L48VAJ/xJyAP
 +0NiBRQ0GKOexzhvyc+R8+vXTagF17YNxn2/uAH9t24DlfwAzRqmgmtbpXGLiMeLDL
 uG58itz9MlAlyMmbcLhskXxHBlM9A2zjP2Djm4u4Q+W28HPc1fcdcX99OeMCT3CXBw
 2mKIxD2l4tcNw==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0680417E0FD4;
 Thu, 26 Nov 2026 15:23:40 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: dakr@kernel.org
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, airlied@gmail.com,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 daniel.almeida@collabora.com, deborah.brouwer@collabora.com,
 dri-devel@lists.freedesktop.org, gary@garyguo.net, kernel@collabora.com,
 laura.nao@collabora.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 ojeda@kernel.org, rust-for-linux@vger.kernel.org, simona@ffwll.ch,
 tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev
Subject: Re: [PATCH v7 3/3] drm/tyr: add Job IRQ handling
Date: Thu, 26 Nov 2026 15:23:28 +0100
Message-Id: <20261126142328.216740-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <DN548CRVXMGK.BOPO5J56Y1OH@kernel.org>
References: <DN548CRVXMGK.BOPO5J56Y1OH@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 12:45, Danilo Krummrich wrote:
> On Mon Nov 23, 2026 at 3:58 PM CET, Laura Nao wrote:
>> +/// Requests a threaded IRQ registration for the Job IRQ.
>> +///
>> +/// # Safety
>> +///
>> +/// Callers must not `mem::forget()` the resulting registration or otherwise prevent its
>> +/// [`Drop`] implementation from running.
>> +pub(crate) unsafe fn job_irq_init<'a>(
>> +    pdev: &'a platform::Device<Bound>,
>> +    hw: Arc<HwGate<'a>>,
>> +    events: Arc<JobIrqEvents>,
>> +) -> Result<Pin<KBox<TyrIrqRegistration<'a, JobIrq>>>> {
>> +    let job_irq = JobIrq { events };
>> +    // Ensure interrupt sources are disabled until the handler is registered.
>> +    job_irq.clear_mask(hw.access().iomem());
>> +
>> +    // SAFETY: The caller guarantees the resulting registration will not be leaked.
>> +    unsafe { TyrIrqRegistration::request(pdev, c"job", job_irq, hw) }
>> +}
>
> You could implement a constructor in an impl TyrIrqRegistration<'a, JobIrq>
> block instead, which is think is cleaner than a free standing function.

Right, thanks for the suggestion. Will do.

Best,
Laura
