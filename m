Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA4DCD5BB1
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 13:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0699810E50C;
	Thu, 21 May 2026 13:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="sggg3WqC";
	dkim-atps=neutral
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD8410E506
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 13:45:06 +0000 (UTC)
Received: by mail-pg1-f201.google.com with SMTP id
 41be03b00d2f7-c8294d8c48eso3785766a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 06:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779371105; x=1779975905;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dnh9Qdh/Ek2SFmUD3YQQhAJ1lm8lFb5yTi3rkZyIV7s=;
 b=sggg3WqCaiz+KwjmzJLSaUrtVkNPzHCLvx6FJZDG1grSOHIOJdnrMmnYBfg0j7q3b1
 69rxj729gEY899a2toT2V9qSlHLL4BYba9PYjnadgMoBPzdpAxKPGq3VcLRHP4wtzZ9n
 SSeMoH8pn0iWtLNJu3ZWiH6DMFgcFbPLWlcsA6hxNfCBYPgxAuJpC5VqYURC/A+vIJre
 XFnFfYO9+Yf+a4pTa2JuzJwjQsTzQnrt8PyizHpq3mWm/4W+hPBPNUr9mOlpFYZ0ay6n
 x2M09+TWiUTB+JwAke5QByJnlX0RqA2ClgxJUsWx0mdCeDwl9Rk0PD0QsvNttbRFmjDu
 HmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779371105; x=1779975905;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dnh9Qdh/Ek2SFmUD3YQQhAJ1lm8lFb5yTi3rkZyIV7s=;
 b=dQ8R76rgiup4q483/NGqrYWTyGVcBW5evwPcaIlK6/wrG82DgzrZEqsAARjvRU1f7e
 3WK6pExRPKwJz9jin1rEsm9b6w/d9i58+PbBJIERJ8DNFlADc2eM/65AlilXnPyuFu2C
 5k1i+aLWoT3V1y+x2+2IhhEo5x+UZK/OEgKZfDn1U5clmqBSiBlTYUOKWT5fLofMAoGJ
 VRhqMMSfIy2kzuFCqKWDZ9J3IK15xUqM8VW7ukKfXIs0PbYOjkuWFL2lwd0eusXj0fTK
 e6mKwjJdYSPOwEWD6d/ccNFV99UIfSqIAvDpX8KaDkx2uocBVtR2v94F3WYZ/61SnUvU
 QA/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iTIh2CEqHlr97RiU+YSbf5Ht30LC0strYEhpXTfuXKzGswDDL9jNEx7ir3YQ0xOXCrnS/b2YyC8Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFZuTDuxXTQ1FlYEg/6sy0KnMTTNRBftp45l9JFTihzIlnwUE6
 MCl5v6R6N9aK27MGLMDlKhzYr54gqZB49u6FN9LTRDQVtxQI2DfviIZA3ohXf8XuCTpeHKQrX+j
 +G4PEmw==
X-Received: from pgvm13.prod.google.com ([2002:a65:62cd:0:b0:c85:1159:ffbd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7491:b0:3a0:bc61:62e5
 with SMTP id adf61e73a8af0-3b30883a17bmr3700528637.44.1779371104725; Thu, 21
 May 2026 06:45:04 -0700 (PDT)
Date: Thu, 21 May 2026 06:45:04 -0700
In-Reply-To: <20260521133326.2465264-9-kees@kernel.org>
Mime-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-9-kees@kernel.org>
Message-ID: <ag8MYC6pOZvvYHMp@google.com>
Subject: Re: [PATCH 09/11] treewide: Convert custom kernel_param_ops .get
 callbacks to seq_buf via cocci
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Petr Pavlu <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, 
 Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, 
 Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "Eugenio =?utf-8?B?UMOpcmV6?=" <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, 
 Jim Cromie <jim.cromie@gmail.com>, Tiwei Bie <tiwei.btw@antgroup.com>, 
 Benjamin Berg <benjamin.berg@intel.com>, 
 "Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, 
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
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

On Thu, May 21, 2026, Kees Cook wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 07f4c7209ac0..00317774a90b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -368,12 +368,16 @@ static int vmentry_l1d_flush_set(const char *s, const struct kernel_param *kp)
>  	return ret;
>  }
>  
> -static int vmentry_l1d_flush_get(char *s, const struct kernel_param *kp)
> +static int vmentry_l1d_flush_get(struct seq_buf *s,
> +				 const struct kernel_param *kp)
>  {
> -	if (WARN_ON_ONCE(l1tf_vmx_mitigation >= ARRAY_SIZE(vmentry_l1d_param)))
> -		return sysfs_emit(s, "???\n");
> +	if (WARN_ON_ONCE(l1tf_vmx_mitigation >= ARRAY_SIZE(vmentry_l1d_param))) {
> +		seq_buf_printf(s, "???\n");
> +		return 0;
> +	}
>  
> -	return sysfs_emit(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigation].option);
> +	seq_buf_printf(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigation].option);
> +	return 0;

For this one, can you manually change it to this?

	if (WARN_ON_ONCE(l1tf_vmx_mitigation >= ARRAY_SIZE(vmentry_l1d_param)))
		seq_buf_printf(s, "???\n");
	else
		seq_buf_printf(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigation].option);
	return 0;

>  }
>  
>  /*
> @@ -459,9 +463,11 @@ static int vmentry_l1d_flush_set(const char *s, const struct kernel_param *kp)
>  	pr_warn_once("Kernel compiled without mitigations, ignoring vmentry_l1d_flush\n");
>  	return 0;
>  }
> -static int vmentry_l1d_flush_get(char *s, const struct kernel_param *kp)
> +static int vmentry_l1d_flush_get(struct seq_buf *s,
> +				 const struct kernel_param *kp)
>  {
> -	return sysfs_emit(s, "never\n");
> +	seq_buf_printf(s, "never\n");
> +	return 0;
>  }
>  #endif
