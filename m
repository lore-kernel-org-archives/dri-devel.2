Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FDAC56201
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA74310EDE2;
	Wed,  5 Aug 2026 10:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NJZyD6pI";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0971110E1DE
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 10:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785926907;
 bh=spzxP1pzKJWjRwkbVK/MSgF6DfFR+VSFmyP2BL7haHA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NJZyD6pIGKH3LWqia0HrIORJf/cAaZ9i90JvVfFomghswDy6qTlCdJUL5S6NJBiCu
 X3Ict9mx0NZRwlmb9nxBLxVM4IVcgU0jQP+xa3y/VuW255oTWpOTPZ/+KM4xzt901E
 YxHOj28RzaX109JnNMpgOa+OJT4pXWQPecuQpmMUhl6t0TTAQrY79XtCeP4EzBWVLa
 hZ+JpZFtCp732kMIKy5kojkG81WqwJW9213xo05glrpZDg06ouQ2+C7vPORQOVMAY2
 r7wk5HDJ6FwXxbqFE/1zkI6iOBbfOQXazKxr3rEEaNigAJ2HD2oVPMF0fA5kkfZR7Q
 hq3FYz5hC1VEA==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 791E917E0048;
 Wed, 05 Aug 2026 12:48:26 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: linkmauve@linkmauve.fr
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, airlied@gmail.com,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 dakr@kernel.org, daniel.almeida@collabora.com,
 deborah.brouwer@collabora.com, dri-devel@lists.freedesktop.org,
 gary@garyguo.net, kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, simona@ffwll.ch, tamird@kernel.org,
 tmgross@umich.edu, work@onurozkan.dev
Subject: Re: [PATCH v3] drm/tyr: add Job IRQ handling
Date: Wed,  5 Aug 2026 12:48:15 +0200
Message-Id: <20260805104815.104154-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <anHZpHh_5CZhH5N3@desktop>
References: <anHZpHh_5CZhH5N3@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hello,

On 8/4/26 14:23, Link Mauve wrote:
> Hi,
>
> On Mon, Aug 03, 2026 at 03:34:37PM +0200, Laura Nao wrote:
>> Add a threaded IRQ wrapper for Tyr interrupt sources and use it to
>> handle the firmware Job IRQ.
>>
>> The Job IRQ reports requests from the CSF firmware, including global
>> interface requests and CSG attention bits. Only the GLB bit is currently
>> handled, as it will be used to check firmware readiness. CSG bits
>> handling will be added at a later stage. Add a Job IRQ handler that
>> masks the interrupt in the primary IRQ handler, processes pending raw
>> status in the threaded handler, clears the handled bit, and reenables
>> the mask before returning.
>> Add a wait queue and a bool flag so the handler can signal firmware
>> readiness when the GLB bit is set.
> […]
>> diff --git a/drivers/gpu/drm/tyr/fw/irq.rs b/drivers/gpu/drm/tyr/fw/irq.rs
>> new file mode 100644
>> index 000000000000..6eeb1399a7b3
>> --- /dev/null
>> +++ b/drivers/gpu/drm/tyr/fw/irq.rs
>> @@ -0,0 +1,105 @@
> […]
>> +/// Requests a threaded IRQ registration for the Job IRQ.
>> +///
>> +/// # Safety
>> +///
>> +/// Callers must not `mem::forget()` the resulting registration or otherwise prevent its
>> +/// [`Drop`] implementation from running.
>> +pub(crate) unsafe fn job_irq_init<'a>(
>> +    pdev: &'a platform::Device<Bound>,
>> +    iomem: Arc<IoMem<'a>>,
>> +    fw_ready: Arc<AtomicBool>,
>> +    job_irq_wait: Arc<WaitQueue>,
>> +) -> Result<impl PinInit<ThreadedRegistration<'a, TyrIrq<JobIrq<'a>>>, Error> + 'a> {
>> +    iomem.write_reg(JOB_IRQ_MASK::zeroed().with_glb(true));
>> +    let job_irq = JobIrq {
>> +        iomem: iomem.clone(),
>> +        fw_ready,
>> +        job_irq_wait,
>> +    };
>> +    // SAFETY: The caller guarantees the resulting registration will not be leaked.
>> +    unsafe { TyrIrq::request(pdev, c_str!("job"), job_irq) }
>
> Nowadays we use the shorter c"job" way of creating a &CStr, and I think
> the macro will even generate warnings in some configurations (perhaps
> CLIPPY=1?).
>

Got it, I didn't get the warning with CLIPPY=1, I'll double check my
configuration. 

I'll fix this in the next revision. Thanks for the heads up!

Best,

Laura
