Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960A3C54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFEEE10E130;
	Thu, 30 Jul 2026 09:45:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="AgBLBgea";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4395F10E130
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785404736;
 bh=cU30pKBIFPwKFVp+ZUCheTXWhKhVmJEBwgBrtWOhknY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AgBLBgeayquUnuvO/gJyRJ5p8PXaTa4T5VwYdygqSWAQQ/FHsaFYCK+a9/sTOy3XW
 +K5fiUgRW7W6+g3AQs/2CHazaZKqnZSosPe4Swl7Sw1cgyMBH1kIPWPD8Tmlj0XRQq
 4ifBLERri1NqfzH3Dy+f+OD+y3xTPfCG3nQgG0gX5uqphHMGy9/W/ItM4cbdOr/XEJ
 E6bVh2+hydiBbdMTVaz1DOnSIFW5WGue28hkblWgd1G3JxgK3WUae7qnVJF99p58nd
 547ybIvK3bX/drIERdEZQ6QVCb/tyF+WrRR/Gsue6Z9wOXUsKaRjot9CL8vWm9nsWx
 zwBACyxwKZpTQ==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E35AD17E0048;
 Thu, 30 Jul 2026 11:45:35 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: work@onurozkan.dev
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, airlied@gmail.com,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 dakr@kernel.org, daniel.almeida@collabora.com,
 deborah.brouwer@collabora.com, dri-devel@lists.freedesktop.org,
 gary@garyguo.net, kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, simona@ffwll.ch, tamird@kernel.org,
 tmgross@umich.edu
Subject: Re: [PATCH v2] drm/tyr: add Job IRQ handling
Date: Thu, 30 Jul 2026 11:45:25 +0200
Message-Id: <20260730094525.245487-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260729165121.768013-1-work@onurozkan.dev>
References: <20260729165121.768013-1-work@onurozkan.dev>
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

Hi Onur,

On 7/29/26 18:51, Onur Özkan wrote:
> On Wed, 29 Jul 2026 11:58:29 +0200
> Laura Nao <laura.nao@collabora.com> wrote:
>
>> +
>> +    fn handle(&self, status: u32) {
>> +        if JOB_IRQ_RAWSTAT::from_raw(status).glb() {
>> +            self.fw_ready.store(true, Ordering::Release);
>> +            self.job_irq_wait.wake_up_all();
>> +        }
>
> You enable both GLB and CSG above but only handle GLB, is this intentional? This
> means CSG will trigger the handler, do nothing and just get cleared, or am I
> missing something?
>

The series that will later add CSF interface support will likely only 
include a firmware readiness check at first, with CSG bit handling 
added at a later stage. That's why we're only handling the GLB bit for 
now, but I agree unmasking the CSG bits here is premature then. I can 
drop this in the next revision, keep only the GLB bit unmasking/handling 
and add a TODO comment for the CSG bits.

Thanks!

Laura

