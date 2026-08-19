Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AA4C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E86810E821;
	Wed, 19 Aug 2026 15:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="dRRI6d0d";
	dkim-atps=neutral
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 468F010E821
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:33:47 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-848474825ffso11911b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787153627; x=1787758427;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c2FvzDQHxVaueg4hvKJpjDuB27Njlxwegg3SIxYd2Fg=;
 b=dRRI6d0dKl3V1n6UKGI/WMvzeohvbRRABaFAFGl+zvr79ktzZZah46Hzm0u+3YdyZc
 aEsbZY30xMdCYxR4Ugd5j8l0Bng8c8uLGN2qYTa9N8XoXCzviVpBVU5xSkPIDLeCU0x9
 0ytsfOnnB5Ih+34VGKvmR4fuNqkK1vuHSesO+UiUKyP7v+luSPmYV4LFCHz3UbJ4BmAr
 8w4Ezn48MWzpFvtfuRSrYuni44MP2iRfdKbcyR9xBuwp5nDQaouUQFfzu6Yz2B/P069P
 Hjf5Otd2gqwmqo3wXolHsq/7diYY+Y6hcoFn9EEmVs54PCfLKi77or1Y9+w2oDGOjpwV
 Ra+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787153627; x=1787758427;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c2FvzDQHxVaueg4hvKJpjDuB27Njlxwegg3SIxYd2Fg=;
 b=sq5DOO4PApTy6Nb65K63DfYrYM9dKRquwEoFsfXUN7N46BZq5Pwe62Swc9aqQ+aXE9
 29GR6XxH87p7agicTcQ1+VfT99IF66qslyQDlMAjO1ewC+LdTRAlUKb/S3Nfi+DQuglk
 jl3y2R8w4CamqRVNK0xaovfLmIjD0yoqV+MKjE4HSaNMCVipNyOKZ/WASubn6LguBOlo
 lagTTIp69XxKbOWpRanwCoWvOUwDpqaWigMLeAiigNyCNZQ9bOewEGfn8FAVLuEbytne
 iJS0Eos/qaOl0QiDGbDXs5/KirufNceioYN3wjP29+4fw1FIw7+HL5OFPCu2cpjwQFbK
 oVYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoT/3z84q5s68uu9v+hEueZGy3K0HtrsM2KlvU+PNTOQulq0L0yocXJ3lKN77r2WTlDmr6IEAWT4Nw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0r6Hucw+acF30R0JF6WZsXjuLZSaOf7LKMuJRHnnqE0MGbQn2
 UJ9WuylZsXuE9Mt8Z+pKnO1KvkJSkh5TQshoJNb/geVG63jZN8zCuEKbMHxjeFqmnCExMMu6+P+
 Cvrp8DQ==
X-Received: from pfoo3.prod.google.com ([2002:a05:6a00:1a03:b0:84f:df8f:5a90])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2913:b0:84b:9a69:156d
 with SMTP id d2e1a72fcca58-851df6dc419mr109732b3a.0.1787153626373; Wed, 19
 Aug 2026 08:33:46 -0700 (PDT)
Date: Wed, 19 Aug 2026 08:33:45 -0700
In-Reply-To: <bd9e5b6e-07f2-459d-bca6-e290585060aa@intel.com>
Mime-Version: 1.0
References: <20260819102314.1499258-1-jgross@suse.com>
 <bd9e5b6e-07f2-459d-bca6-e290585060aa@intel.com>
Message-ID: <aoXM2f1YTwgVj8KL@google.com>
Subject: Re: [PATCH v2 00/13] x86/msr: Drop 32-bit MSR interfaces
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, 
 virtualization@lists.linux.dev, linux-ide@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 kvm@vger.kernel.org, linux-edac@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-coco@lists.linux.dev, 
 linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, David Airlie <airlied@redhat.com>,
 Helge Deller <deller@gmx.de>, 
 linux-geode@lists.infradead.org, Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Pu Wen <puwen@hygon.cn>, 
 Tony Luck <tony.luck@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, 
 Babu Moger <babu.moger@amd.com>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, 
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <lenb@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
 Artem Bityutskiy <dedekind1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Ashok Raj <ashok.raj.linux@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 "Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, xen-devel@lists.xenproject.org
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

On Wed, Aug 19, 2026, Dave Hansen wrote:
> Hey Juergen,
> 
> These look great. Thanks for doing it!
> 
> The only wonky thing is how we're going to actually merge it. We
> obviously can't do patches 10-11 until all the "stop using" patches have
> been applied.
> 
> I obviously 100% realize that it's during the merge window, but any acks
> that the maintainers of 5-9 provide in the next few weeks would be super
> helpful. Or, if any of those maintainers want to cherry pick their
> subsystem's stuff out of this series and apply it, that would be great too.
> 
> But, the last time we did some MSR function munging, the tip tree
> carried most of the patches. I would expect we'll have a repeat of that
> here too. I'll pencil in the idea of just merging the lot around -rc1 time.

Note, patch 12 "treewide: convert rdmsrq() from a macro to an inline function"
is going to conflict with the KVM changes for 7.3; kvm_access_xstate_msr() is
getting moved from x86.c to msrs.c.  Somewhat surprisingly, AFAICT that's the
only conflict with KVM's code movement, so it's probably not strictly required
to send a new version after the KVM pull request?
