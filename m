Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE73606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=lqBSMAU5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 360E0112470;
	Thu, 26 Nov 2026 14:21:22 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39AB9112470
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795702873;
 bh=v9bSNQgXQSZX2c+Meg6UrLoUf8wBWQR+eTf8RCbX6Ak=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lqBSMAU5p1NeFmG+L9sx55yA9psPVka1U0XjJir8uo/k6gjK2YHYIN1+rmpHINmOi
 GztcDHimNlyYByP4ICo1rZEhyvecs8SS2sxuZCfuz0qyP9G480P+fLNzBhuBs73OJt
 jgBTlrz0Kv4j17WuqKWPlhW5W8neTH68GrI7TfOpseyptxKLIChtfpPB0o4oaOm70s
 CTnUi5ovJhyVFG79imUEpd3DrduT4nwrbZROidEe5FDcWrVxW6GefAUGt4nftBPaHl
 6jOSXRlAnca/+ddduRj/eLSwapeRMo09V9iXlXlmn0yI3u4vwkXE6b7qgM5Z4LZuvO
 wLMmIoijKx1Wg==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C47517E09ED;
 Thu, 26 Nov 2026 15:21:13 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: dakr@kernel.org
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, airlied@gmail.com,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 daniel.almeida@collabora.com, deborah.brouwer@collabora.com,
 dri-devel@lists.freedesktop.org, gary@garyguo.net, kernel@collabora.com,
 laura.nao@collabora.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 ojeda@kernel.org, rust-for-linux@vger.kernel.org, simona@ffwll.ch,
 tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev
Subject: Re: [PATCH v7 2/3] drm/tyr: add TyrIrq threaded IRQ wrapper
Date: Thu, 26 Nov 2026 15:21:03 +0100
Message-Id: <20261126142103.216201-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <DN545I66CKO1.2YKP99UIQQR43@kernel.org>
References: <DN545I66CKO1.2YKP99UIQQR43@kernel.org>
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

Hi Danilo,

On 11/26/26 12:41, Danilo Krummrich wrote:
> On Mon Nov 23, 2026 at 3:58 PM CET, Laura Nao wrote:
>> +impl<'a, T: TyrIrqTrait> TyrIrqRegistration<'a, T> {
>> +    /// Requests a threaded IRQ registration for `irq`, using `name` to look up the interrupt.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must not `mem::forget()` the resulting registration or otherwise prevent its
>> +    /// [`Drop`] implementation from running.
>> +    pub(crate) unsafe fn request(
>> +        pdev: &'a platform::Device<Bound>,
>> +        name: &'static CStr,
>> +        irq: T,
>> +        hw: Arc<HwGate<'a>>,
>> +    ) -> Result<Pin<KBox<Self>>>
>
> Why does this not return a pin initializer itself?
>
> I don't think this has a user in this series (except job_irq_init(), which
> itself seems unused), but I expect this to be stored in some other container
> that is pinned anyway.
>
> (Note that in C we'd also not need a separate allocation and just embed it in
> its corresponding container.)
>

Thanks for flagging this, came to the same conclusion this morning after 
rethinking about how this will be stored in TyrDrmRegistrationData. 
I'll fix this in the next revision.

Best,

Laura

