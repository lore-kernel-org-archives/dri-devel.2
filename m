Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9E8CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C94A910E33E;
	Mon, 25 May 2026 13:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="b5nIHG9y";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2D110E2DE
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:27:18 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49050bfe053so23453875e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779715637; x=1780320437; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ij+l12dR+ISDUAaA9eJOw0SDQ47xwS4UQDqlRXMB76c=;
 b=b5nIHG9yjNkEfCJpeLt1NAj+IjC/IC+He26bxfg4Eacg4Z0Zg7fE8F87TnKGBhwf7W
 ZpGI0rOnG02XvZ5QloPczWU48Z8Ebgr4LUhSCNc3mQ6LfnsusJ4tVVKiTEhsHwK1EmJM
 E5H10Tpm10LdaxWuPHvh6f0XDyvz9YRvx6P735XK2hRQ4Sb13nPgodFZCq0LIfHumecR
 JTj37iJDPiQf34ZK06U3atgrjjXSQgxNZ4fs0oWbOxz5zkxd88SswYXt/i1TqNfPp7cL
 UBTVLASQ6LbsSS3sjeauZPafEzeOEKGuxlqLvlptRLvg/eqdGbfoDIXudz6XPca3ITLY
 mj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779715637; x=1780320437;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ij+l12dR+ISDUAaA9eJOw0SDQ47xwS4UQDqlRXMB76c=;
 b=A02Uf4H3rNoIW09UOk2jj/6jNIrwENZ0Zk1aP5QuLweV5UA75zg5BTVq4C0DZU0FV7
 2a0X7vLSoNTATzH+fOjj+al2/fWq/CayJQkKTgk2QzHClGCrXx0ETIROQpUKkO7hZ86F
 5hFuuoGQj11+xrBRH/5igbDDOMiJjM3N9tDDefWoHW66z7U8Vf1AHCThHyURtCVr8BUt
 UtEtvLi+itqxFywOTi+V4UK8uayZbdyltsLKbsC2U7cntouQGIhCsEmDKhmQXixyHc+f
 ++kXntjENK02K6IFV4JDus8P7mKgW8c4OskfLmYyfi1JDprrP29K6AOoO2lwnLZGFmq8
 xCeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JmjhCbsUUaDbJHAOhrryqTXvEzPqZDWcG/sKyeJXJ6GqEqnfJ6cPDksfXAdNKaL88iXWXwVp31HY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8gqMVvZFRUseL6+h7RhJiblKT48vutJlNR9w8GI9S8RUXa+af
 5tMmyNkErY3mxCqJaqLSw3e5OEcawDVh2dDUfNnwYODxdDA5J01NyHGzaoDa76Kv9Rw=
X-Gm-Gg: Acq92OECZS5MjuCt37fMwJOBsqG1eb/APfseMA1K9fDVF1bxGA3kpLmtFzIwCxRVdAS
 xuLf4kUJ8QDTI325X+Kxqum41Wgud+RTJWeyE4zrIOBkEFN0JxxV7KvJMj49JRIje8vZuuG1zba
 rwKnXJv6NyfdFqZlm/Ry/3BcKGsGMh2xuKhtTtcnJ7pPCEXIdoatH+WrQT5ItLLroaplRrzrQHM
 p8LF5TMCCHFL5QRjuVmAlBwGwjFAi5FFp90Gzkx4cumCrGcl1/GfmmGoMG3bbvfF9H/8paaoNOS
 zBTEkJOyuyfPuW2MClq23p3C5VNIDiTEcT+c+z/FS5iboIxwDivkIAjQS5B1CYsHnFfiXeYt4ug
 HnIAqv1xLQoFI2pLNoCeEmASLKUxty2eoJsGi3BdAs6HprBcH8ZsDyB6rJ+JKMJ5c4yqnjDFKS5
 3Vu7KneGTzIPhtPW5yNSP2xs4QvXEdlAnd/BIS9to7BFDN16BXMihb257qvaResbfhdDtwjymRx
 o83SWPxStSH7jUc9H/wN/FXxzqdAnzpZ3Iyg/SakIwK7zmqUPdY3m3nytCLgxL4bxjrgx5btqRv
 LF4k
X-Received: by 2002:a05:600c:3b02:b0:48f:e1ac:c94f with SMTP id
 5b1f17b1804b1-490424b3938mr247672645e9.10.1779715636631; 
 Mon, 25 May 2026 06:27:16 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100?
 (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz.
 [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454b1ab3sm284841905e9.14.2026.05.25.06.27.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 06:27:16 -0700 (PDT)
Message-ID: <1c21f66f-0d0f-4a8b-835b-23408242cff1@suse.com>
Date: Mon, 25 May 2026 15:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] moduleparam: Add DEFINE_KERNEL_PARAM_OPS macro
 family
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
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
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-3-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133326.2465264-3-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 5/21/26 3:33 PM, Kees Cook wrote:
> Add macros that define a struct kernel_param_ops initializer through a
> macro so the underlying field layout can evolve without touching every
> call site. Three variants cover the three cases:
> 
>  DEFINE_KERNEL_PARAM_OPS(name, set, get) // basic
>  DEFINE_KERNEL_PARAM_OPS_NOARG(name, set, get) // set KERNEL_PARAM_OPS_FL_NOARG
>  DEFINE_KERNEL_PARAM_OPS_FREE(name, set, get, free) // also set .free
> 
> Callers prefix their own visibility qualifiers, e.g.:
> 
>   static DEFINE_KERNEL_PARAM_OPS(my_ops, my_set, my_get);
> 
> Also update module_param_call() and STANDARD_PARAM_DEF() to use
> DEFINE_KERNEL_PARAM_OPS internally so the generated ops table will go
> through the same macro as everything else.
> 
> Subsequent commits convert all open-coded struct kernel_param_ops
> definitions to use these macros, in preparation for migrating to a
> seq_buf .get API.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  include/linux/moduleparam.h | 36 ++++++++++++++++++++++++++++++++++--
>  kernel/params.c             |  6 ++----
>  2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index 075f28585074..26bf45b36d02 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -68,6 +68,39 @@ struct kernel_param_ops {
>  	void (*free)(void *arg);
>  };
>  
> +/*
> + * Define a const struct kernel_param_ops initializer. Callers prefix with
> + * any required visibility qualifiers (typically "static"):
> + *
> + *   static DEFINE_KERNEL_PARAM_OPS(my_ops, my_set, my_get);
> + *
> + * Routing the @_set and @_get function pointers through the macro
> + * (rather than naming the struct fields at every call site) lets the
> + * field layout change in one place when callbacks are migrated to a
> + * new signature.
> + */

Nit: The newly introduced DEFINE_KERNEL_PARAM_OPS*() macros remain in
place at the end of the series after the migration is complete and this
comment is removed in patch 7. It would be helpful to describe in the
commit message why these macros are generally preferable to defining
kernel_param_ops instances directly.

I assume the motivation is that the structure is simple enough and using
macros then makes defining kernel_param_ops instances a bit more
concise. A minor disadvantage is that some analysis tools, such as
ctags, may no longer see the generated definition, but that is also the
case for DEFINE_MUTEX() and other similar macros.

-- 
Thanks,
Petr
