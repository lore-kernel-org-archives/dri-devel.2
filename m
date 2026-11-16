Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF51606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YAGjUNnc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EEFA10EF50;
	Mon, 16 Nov 2026 10:59:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91DDF10EF50
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794826772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJaN0b3PvIpi2y0OVrA15M2BP9AXuuHR0w2trP7Mx30=;
 b=YAGjUNncY3EDisBpWlxLEQsHYg3T7VMwzQpVc4S4grk78OS9qLzyt0GsAzCdRkuJqyuMuI
 1I1FgizGndwYUuWbTMS0N1CaWlkwO5zpS4zXhvEburi5P/wNBHWLcNXi7rYwlU7/VHZ+nh
 YMBPqePg2bWB/sVd42/pAgRkq5ROrhA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-CMgwBcHaO-q1Z5ouSmN-hQ-1; Mon, 16 Nov 2026 05:59:31 -0500
X-MC-Unique: CMgwBcHaO-q1Z5ouSmN-hQ-1
X-Mimecast-MFC-AGG-ID: CMgwBcHaO-q1Z5ouSmN-hQ_1794826770
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-492e3189fc9so2110093f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 02:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826770; x=1795431570;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mJaN0b3PvIpi2y0OVrA15M2BP9AXuuHR0w2trP7Mx30=;
 b=s8g3gXDx81+zZLXrMbt6BKvLvSs/xXSQQmR9XuEy+4/Xfj5Jz3dNdE2tudWAzL/O6V
 TqowXjfv9BpLYF4wazTLofKTKPG9nleyRxSk43OfbVravqNJuV65WzBpECIVZlTGIdNx
 PfqpOlFTBAyDaAHoYPhsIGOWDtiY7YNDXTi8cySz4lPBhRZQylzXw64LYINlFPZku4W1
 L/8GRV8EVMzTkfIFjJ/0YsW1D49RlWWOCsXtZG+NeeTV3Gqau+oqKSvIIi5NFcu5lxYn
 NLgorOgdEuXPbpipvgKS6wE1K0CThpBqFiThYkpflD4QOcewwjuZj1n16IvgJ4Dl+Iei
 BDbQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFGS+YMgexvt6/s73BpCKDCWYeAVfUXP1Lf5gbToCuF+cOTKI1VFQsu9fbcRNxu5mB2GQvGHr9mmEo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8+YhLiVZvscJZZTocIZJqWcZH7CVisJCMuso2SK/uinniq97DS
 W/ScqtwX0aLzViKMGY8W7zkLeux6/lNksePxMxbQKd4ltq8xEZjp7Ae4fgZZ5jO57LzEOUN+gA7
 04wTf4pg1bL83FN5s5s11ErqmZaA/0h2ZQjM6GpNDBxqp+sS728uNflr5bANibKWxVma+UQ==
X-Gm-Gg: AZFdTZdUsXn4jHNVoOX8114gkmjvA7rLTbMBZhxFsYc4K55pKNe6iBSVqUCXF4k8vHO
 UCYnygY06lq1HDhrL6ihpypU6wZS76lsMEYHZtrwMNKT/0YuT+2yhTbVtM9mCauTSFmV/c6vNqc
 mlFR9qi8Bqcd8icE39X23Tuy8VBF2OM1myHFF5Vw4WqIV0WlklTcjlZZ1BPCmgg15TpaYYiuEkr
 CDAfi3w2W6aa1AVQPVjTuUTdSA5INNP4SNbDffAmIUpS6+Glh1GjvuChGgwrflwIwnX7wdjBI4p
 khDFcwCYvVbJa+7NDFi0ya6SoFjU0KiXsvPG2hgIcZFjGgE749hJM/qHWn/3N6c3M1d3cowAVUV
 AjQA0YQtpeDeKE4BbH/pnr9gwAm+/PVosHv1waNFkncdLrzbVT6UBZF5H8JqyyRoPTiBQdA5ir8
 Kyw0CzEcDiJQSizdjnJn59Yy0pzSLIceH+hoeFjmE=
X-Received: by 2002:a05:6000:1614:b0:48e:7b12:aca5 with SMTP id
 ffacd0b85a97d-49c72e85eadmr15496742f8f.46.1794826769933; 
 Mon, 16 Nov 2026 02:59:29 -0800 (PST)
X-Received: by 2002:a05:6000:1614:b0:48e:7b12:aca5 with SMTP id
 ffacd0b85a97d-49c72e85eadmr15496699f8f.46.1794826769302; 
 Mon, 16 Nov 2026 02:59:29 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6020bb0fsm20381961f8f.34.2026.11.16.02.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:28 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>, Ard
 Biesheuvel <ardb@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Borislav Petkov <bp@suse.de>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, Han Gao
 <rabenda.cn@gmail.com>, stable@vger.kernel.org, Han Gao
 <gaohan@iscas.ac.cn>
Subject: Re: [PATCH] firmware/sysfb: Avoid simple-framebuffer behind DT PCI
 host bridges
In-Reply-To: <20261107-sysfb-dt-pci-efifb-v1-1-86d6c598671a@iscas.ac.cn>
References: <20261107-sysfb-dt-pci-efifb-v1-1-86d6c598671a@iscas.ac.cn>
Date: Mon, 16 Nov 2026 11:59:27 +0100
Message-ID: <xlv1fqx1rqi8.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jCpPM7YDVoiA8bq9DOxypfPzinc0ZRgG0N-BzX4cD98_1794826770
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org> writes:

Hello Han Gao,

> From: Han Gao <gaohan@iscas.ac.cn>
>
> With SYSFB_SIMPLEFB, sysfb registers a simple-framebuffer device that
> claims the framebuffer memory when it is added. On DT systems, the PCI
> host bridge may probe later and then fails to claim its memory window.
> On QEMU RISC-V virt with EDK2, a bochs-display and pci-host-generic
> built as a module:
>
>   [    0.703813] pci-host-generic 30000000.pci: resource collision: [mem 0x40000000-0x7fffffff] conflicts with BOOTFB [mem 0x40000000-0x403e7fff]
>
> In that case, register an efi-framebuffer device instead. It claims no
> memory before it probes, and commit 64c8a0cd0a53 ("efi/arm: Defer probe
> of PCIe backed efifb on DT systems") makes it wait for the host bridge.
>

I think this is a workaround and it just works because sysfb does not add
a resource (using the platform_device_add_resources() helper) when adding
the platform data for the device.

> Tested on a HiFive Unmatched with EDK2 and a PCIe graphics card, and on
> QEMU.
>
> Fixes: 8633ef82f101 ("drivers/firmware: consolidate EFI framebuffer setup for all arches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
> In QEMU, efifb takes over with SYSFB_SIMPLEFB and efidrm without it.
> With pci-host-generic built in, simpledrm is still used.
> ---
>  drivers/firmware/efi/sysfb_efi.c | 16 ++++++++++++++++
>  drivers/firmware/sysfb.c         |  8 +++++++-
>  include/linux/sysfb.h            |  6 ++++++
>  3 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> index 2338de73c62c..5c2cb87178ff 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -421,6 +421,22 @@ __init void sysfb_apply_efi_quirks(struct screen_info *si)
>  		dmi_check_system(efifb_dmi_swap_width_height);
>  }
>  
> +/* Returns true if the EFI framebuffer is in a DT PCI host bridge window */
> +__init bool sysfb_efifb_behind_dt_pci(const struct screen_info *si)
> +{
> +	struct device_node *np;
> +
> +	if (si->orig_video_isVGA != VIDEO_TYPE_EFI || !IS_ENABLED(CONFIG_PCI))
> +		return false;
> +
> +	np = find_pci_overlap_node();
> +	if (!np)
> +		return false;
> +
> +	of_node_put(np);
> +	return true;
> +}
> +

I don't think this that much. I feel that is adding DT + PCI logic that is
platform specific. Instead, maybe what can be done instead is make the sysfb 
logic consistent between "efi-framebuffer" and "simple-framebuffer" platform
data setup.

That is, not add a IORESOURCE_MEM to prevent platform_device_add() to add it
to the global memory resource list. Instead, the framebuffer address + size
could be passed to the simpledrm driver through the simplefb_platform_data.

The simpledrm driver then could claim the memory at probe time, which is what
efidrm does as well.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

