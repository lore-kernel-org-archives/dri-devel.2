Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B35EC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D88210EA33;
	Tue,  4 Aug 2026 12:28:47 +0000 (UTC)
X-Greylist: delayed 342 seconds by postgrey-1.36 at gabe;
 Tue, 04 Aug 2026 12:28:45 UTC
Received: from linkmauve.fr (linkmauve.fr [82.65.109.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF0210EA08
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:28:45 +0000 (UTC)
Received: by linkmauve.fr (Postfix, from userid 1000)
 id A077A70A045A; Tue, 04 Aug 2026 14:23:00 +0200 (CEST)
Date: Tue, 4 Aug 2026 14:23:00 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Laura Nao <laura.nao@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, kernel@collabora.com,
 Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: Re: [PATCH v3] drm/tyr: add Job IRQ handling
Message-ID: <anHZpHh_5CZhH5N3@desktop>
References: <20260728-tyr-irq-v2-v3-1-9c9bc5c029c5@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728-tyr-irq-v2-v3-1-9c9bc5c029c5@collabora.com>
Jabber-ID: linkmauve@linkmauve.fr
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

Hi,

On Mon, Aug 03, 2026 at 03:34:37PM +0200, Laura Nao wrote:
> Add a threaded IRQ wrapper for Tyr interrupt sources and use it to
> handle the firmware Job IRQ.
> 
> The Job IRQ reports requests from the CSF firmware, including global
> interface requests and CSG attention bits. Only the GLB bit is currently
> handled, as it will be used to check firmware readiness. CSG bits
> handling will be added at a later stage. Add a Job IRQ handler that
> masks the interrupt in the primary IRQ handler, processes pending raw
> status in the threaded handler, clears the handled bit, and reenables
> the mask before returning.
> Add a wait queue and a bool flag so the handler can signal firmware
> readiness when the GLB bit is set.
[…]
> diff --git a/drivers/gpu/drm/tyr/fw/irq.rs b/drivers/gpu/drm/tyr/fw/irq.rs
> new file mode 100644
> index 000000000000..6eeb1399a7b3
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/fw/irq.rs
> @@ -0,0 +1,105 @@
[…]
> +/// Requests a threaded IRQ registration for the Job IRQ.
> +///
> +/// # Safety
> +///
> +/// Callers must not `mem::forget()` the resulting registration or otherwise prevent its
> +/// [`Drop`] implementation from running.
> +pub(crate) unsafe fn job_irq_init<'a>(
> +    pdev: &'a platform::Device<Bound>,
> +    iomem: Arc<IoMem<'a>>,
> +    fw_ready: Arc<AtomicBool>,
> +    job_irq_wait: Arc<WaitQueue>,
> +) -> Result<impl PinInit<ThreadedRegistration<'a, TyrIrq<JobIrq<'a>>>, Error> + 'a> {
> +    iomem.write_reg(JOB_IRQ_MASK::zeroed().with_glb(true));
> +    let job_irq = JobIrq {
> +        iomem: iomem.clone(),
> +        fw_ready,
> +        job_irq_wait,
> +    };
> +    // SAFETY: The caller guarantees the resulting registration will not be leaked.
> +    unsafe { TyrIrq::request(pdev, c_str!("job"), job_irq) }

Nowadays we use the shorter c"job" way of creating a &CStr, and I think
the macro will even generate warnings in some configurations (perhaps
CLIPPY=1?).

> +}
> +
> +impl TyrIrqTrait for JobIrq<'_> {
> +    fn read_status(&self) -> u32 {
> +        self.iomem.read(JOB_IRQ_STATUS).into_raw()
> +    }
> +
> +    fn clear_mask(&self) {
> +        self.iomem.write_reg(JOB_IRQ_MASK::zeroed());
> +    }
> +
> +    fn reenable_mask(&self) {
> +        self.iomem.write_reg(JOB_IRQ_MASK::zeroed().with_glb(true));
> +    }
> +
> +    fn read_raw_status(&self) -> u32 {
> +        self.iomem.read(JOB_IRQ_RAWSTAT).into_raw()
> +    }
> +
> +    fn clear_status(&self, status: u32) {
> +        self.iomem.write_reg(JOB_IRQ_CLEAR::from_raw(status));
> +    }
> +
> +    fn mask(&self) -> u32 {
> +        JOB_IRQ_MASK::zeroed().with_glb(true).into_raw()
> +    }
> +
> +    fn handle(&self, status: u32) {
> +        // TODO: handle other Job IRQ events (e.g. CSG attention bits) here once
> +        // support for them is added.
> +        if JOB_IRQ_RAWSTAT::from_raw(status).glb() {
> +            self.fw_ready.store(true, Ordering::Release);
> +            self.job_irq_wait.wake_up_all();
> +        }
> +    }
> +}
> 
> ---
> base-commit: 98ae54f97175c4992b4e5bff53f3c6bc24f0f491
> change-id: 20260728-tyr-irq-v2-0b3c5022be33
> 
> Best regards,
> -- 
> Laura Nao <laura.nao@collabora.com>
> 
> 

Thanks,

-- 
Link Mauve
