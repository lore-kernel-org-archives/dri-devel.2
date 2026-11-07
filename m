Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CA8606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NBL1fiC7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E889E10E635;
	Sat,  7 Nov 2026 17:38:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CA9A10E635
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 17:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794073082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z24fIgrg332IE6A60r7YoNBcp+hbvJa6DyUXEc2zlxA=;
 b=NBL1fiC76Hn5Tc63qzLLdb+u+LKoRxheR8UvoALD1HwZClhyxITptTEvMEL/Hap4gWYAe3
 dcGwQlAbpAJSzIRCIba8U9Q6e2CmDZk7w+XDni1kTjjiJZSIq2onhPWlc2d5b4zDz0/+Jn
 APg34VFn6Os/1TynF31pQ6IR95bb5ok=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-pSXK36ucOTukx-UHtdLASw-1; Sat, 07 Nov 2026 12:38:00 -0500
X-MC-Unique: pSXK36ucOTukx-UHtdLASw-1
X-Mimecast-MFC-AGG-ID: pSXK36ucOTukx-UHtdLASw_1794073080
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8b0e4c2f052so25611177b3.3
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 09:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794073080; x=1794677880;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z24fIgrg332IE6A60r7YoNBcp+hbvJa6DyUXEc2zlxA=;
 b=h3Ogb/tzvynLDDcuwMTjgMUyTUjbcUgaPt0VKWlYzJUhl4rw3pO01IAhrIaG23KKX6
 LXsv12etanmmydaDthHR0BqGHFimVuVAI9kYuKFwiE/Ja1DTs+k2VF1xLcyKDQDoSv5Z
 fci4PgsHc2nhUXYnw3B5xKMF9yIpgjKemT2sSA1mtnirbz2/SkE9r7iQaQW9Ci7aB6p7
 gma23RcBRi4MqAxAADS9e53NLJ9QxwTAjgBoUmpbKAmEpUCa2BZOV3Fu2mEX17OmAglC
 iFVc/cOHK3u96ZrubGLCg8d+2gIPe4B66qKhQuBudv0dzHnntB/uAqz2O7NTwTayW0Fn
 Qx2g==
X-Forwarded-Encrypted: i=1;
 AL+hErGmqFdLc8UWbgIexpCpMMLYVroIzx3ugRFDSjcPJi4MNZB1zrnIKzJa1Bb1/c6wITS0oR4ccwnCGq4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8zQCB2+wv4VDJf0IeGG4u/wl7XhmqS85OCK2Xo9Ohzhylku4mn
 ykthHXlSlaq89vHr9cjKXBpjv3aQTZI67VVvu+dhcDn8mdZDfLDO+FnmFmcQ2wZQLG1fMeQK68Z
 EdQEdm7Pf6SE1axKbbLq/cXt8mwojmgDn3HcOYdVSCTdTZsGgk1An1MsyHaCRHuHMPLnr3w==
X-Gm-Gg: AYBFou3/p8FEjFUJUn3NSEddA45O5khCU1hkDc84QvgKA3OlqnecGUAyFg4ax8fo+1c
 aHUc5GOMFO0ErpzwkX4FXZGbpKuBwAtt5Gy5ZceD5d0BiREzQynBeZmbzYT+jNSpzu98iKP5D5c
 tkg7NVtKP9Tv/FEGIopypThnfbxwcaaJwDBUTXr8I+JXtvOsSzFI6VEoBOVC/szrNiVo8LvigGT
 sHJNtyhCYkeQh66+uNhF+K/78itev5kTS1pn/g5xeVw3JFPihTfqzufryjCvGB5f80nwGdT9GdD
 /TBjs+fvT393CZzAimjw1xQgdxxKd8sViIh/M86g1tYzKeYFst4a5BY/LkEIgJAXpjbGsg5cEIm
 fuQvpnA1gO0TrVuKCVqsNwCtC
X-Received: by 2002:a05:690c:dc3:b0:8b0:ecb2:883a with SMTP id
 00721157ae682-8b341b65934mr35021127b3.62.1794073079901; 
 Sat, 07 Nov 2026 09:37:59 -0800 (PST)
X-Received: by 2002:a05:690c:dc3:b0:8b0:ecb2:883a with SMTP id
 00721157ae682-8b341b65934mr35020987b3.62.1794073079453; 
 Sat, 07 Nov 2026 09:37:59 -0800 (PST)
Received: from rhdev ([2600:1700:f361:20bf::14c1])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b33f5f525fsm44439167b3.5.2026.11.07.09.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 09:37:58 -0800 (PST)
Date: Sat, 7 Nov 2026 12:37:56 -0500
From: Jennifer Berringer <jberring@redhat.com>
To: gaohan@iscas.ac.cn
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Borislav Petkov <bp@suse.de>,
 Simona Vetter <simona.vetter@ffwll.ch>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>,
 stable@vger.kernel.org, Xincheng Ji <jixincheng@ultrarisc.com>,
 Jia Wang <wangjia@ultrarisc.com>
Subject: Re: [PATCH] firmware/sysfb: Avoid simple-framebuffer behind DT PCI
 host bridges
Message-ID: <20261107173756.1d273aa5@redhat.com>
References: <20261107-sysfb-dt-pci-efifb-v1-1-86d6c598671a@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261107-sysfb-dt-pci-efifb-v1-1-86d6c598671a@iscas.ac.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6z40B06XuC3PqtnnY33GbpL-sLp1M8U1jGX0VmSqtHs_1794073080
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi,

On Sat, Nov 07, 2026 at 04:46:40PM +0800, Han Gao via B4 Relay wrote:
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
> Tested on a HiFive Unmatched with EDK2 and a PCIe graphics card, and on
> QEMU.
> 
> Fixes: 8633ef82f101 ("drivers/firmware: consolidate EFI framebuffer setup for all arches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---

This issue also affects UltraRISC DP1000 boards such as Milk-V Titan.
For that system, a2d4a2d2479b ("clk: ultrarisc: Register DP1000 clock
provider earlier") was recently added to clk-next and can serve as a
workaround to make its pci driver be able to initialize before sysfb,
but only if both the clock and pci drivers are built in rather than
built as modules.

I confirmed that your patch resolves the issue on Milk-V Titan even when
building with CONFIG_PCIE_ULTRARISC=m, making a PCIe graphics card able
to initialize and function without issue. CC'd the ultrarisc developers.

Tested-by: Jennifer Berringer <jberring@redhat.com> # Milk-V Titan

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
>  __init void sysfb_set_efifb_fwnode(const struct screen_info *si, struct platform_device *pd)
>  {
>  	if (si->orig_video_isVGA == VIDEO_TYPE_EFI && IS_ENABLED(CONFIG_PCI)) {
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 8833582c1883..8853a74560b9 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -164,8 +164,14 @@ static __init int sysfb_init(void)
>  		goto unlock_mutex;
>  	}
>  
> -	/* try to create a simple-framebuffer device */
> +	/*
> +	 * Try to create a simple-framebuffer device. It claims the memory
> +	 * when it is added, so a DT PCI host bridge that probes later would
> +	 * fail. Use an efi-framebuffer device there; it waits for the bridge.
> +	 */
>  	compatible = sysfb_parse_mode(si, &mode);
> +	if (compatible && !parent && sysfb_efifb_behind_dt_pci(si))
> +		compatible = false;
>  	if (compatible) {
>  		pd = sysfb_create_simplefb(si, &mode, parent);
>  		if (!IS_ERR(pd))
> diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
> index ed23d6516223..b136fdebc746 100644
> --- a/include/linux/sysfb.h
> +++ b/include/linux/sysfb.h
> @@ -95,6 +95,7 @@ static inline bool sysfb_handles_screen_info(void)
>  
>  extern struct efifb_dmi_info efifb_dmi_list[];
>  void sysfb_apply_efi_quirks(struct screen_info *si);
> +bool sysfb_efifb_behind_dt_pci(const struct screen_info *si);
>  void sysfb_set_efifb_fwnode(const struct screen_info *si, struct platform_device *pd);
>  
>  #else /* CONFIG_EFI */
> @@ -103,6 +104,11 @@ static inline void sysfb_apply_efi_quirks(struct screen_info *si)
>  {
>  }
>  
> +static inline bool sysfb_efifb_behind_dt_pci(const struct screen_info *si)
> +{
> +	return false;
> +}
> +
>  static inline void sysfb_set_efifb_fwnode(const struct screen_info *si,
>  					  struct platform_device *pd)
>  {
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261107-sysfb-dt-pci-efifb-d73b08ded4b2
> 
> Best regards,
> --  
> Han Gao <gaohan@iscas.ac.cn>
> 

