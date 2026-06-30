Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9987CC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 18:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA6B110E23C;
	Tue, 30 Jun 2026 18:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="MQIZ8dE/";
	dkim-atps=neutral
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A67C10E23C
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 18:59:03 +0000 (UTC)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2c7f385887bso80357575ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782845943; x=1783450743;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=e+HRXjFGgcPzOleYtd12nce6K890KkClpjKYcrzynFs=;
 b=MQIZ8dE/D6pL0hOtb35OeH0Bju1oQSJoF7OTWoIKGya+j8MVryQrl8CcyW7CWe7EC+
 6Lk9dRFiQe6vw/CBSMMe41WGVIbfc49gkcHkWjb3bNSvRYztnpCxnrI2xpJ8bM60LzQP
 G00f+suvlbTk/u6Dl+IB9GyWMtLlsVQGLhmAsAspHjjxDATY95Ql2tSDuoeqyl36J3iY
 K2KLsKLl5qgDE77r+N8gL0KHDnYAG6IGuiAfi+1dX4/sRSDOPcJ0iooPH9TSPWKstI2B
 baAkiymPGLlcQgCO2AAk39LyR0xDp8vyS/eRJZxok2xSaM6NIok++YyndsdqkCyqmQ5S
 GlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782845943; x=1783450743;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+HRXjFGgcPzOleYtd12nce6K890KkClpjKYcrzynFs=;
 b=DZedaJbRac4DmAc+jTs0998/WlcWXrDJH9OPNnv4LJgfwTG5aHb5Rl5CArDMKKXXaD
 yKXSL97GXlFcNMfSgbNLs7HYom19GnVZt0JDZ8WBYS/K/xm5b2F9rsBnayUcBxMsmliK
 RQdSBWeiW+GST/r6hNgKZm9+KNNrWmZuHHiZVydnta+7t+WZ2puKTZmz3KK6lICeryg/
 HEcY83Os/l+uWkIqgBZPQw/R4ONlhNRNG7L0IK48f4qw+4KyfWDnyctRBYA4dAoyJxK8
 YFnE0vNIfAOsCmNzb+ItwUUV7MBY8dn2ExvTtv1qHO2VmNS/ehdUtOn+vVYreYGRoP2w
 DAUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzFmd53DdX+7yFbXGJYix9VsV2HYWnm1ZF0lvHUk4hSJG5IOPCqas9Q70U+WChCaQU8e6BiLjkEDA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8DgmS00wfCKpRzLpy7M2g8tQQwSATvEI+aLUGwsXGROEFWSR2
 BcnTAbiOaS36h84ZdB2iwbxiiG5e7wdjExB9VqbDMi41Iw4466JN9ciU5BaffyaX1m8mUZjvJ7H
 0apq4Xg==
X-Received: from plbko12.prod.google.com ([2002:a17:903:7cc:b0:2c6:9f66:d581])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:acd:b0:2c9:c517:d075
 with SMTP id d9443c01a7336-2ca5a581ab5mr15124165ad.15.1782845942348; Tue, 30
 Jun 2026 11:59:02 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:59:01 -0700
In-Reply-To: <akJUz0kYkEBdLSZ3@gmail.com>
Mime-Version: 1.0
References: <20260629060526.3638272-1-jgross@suse.com>
 <d7c1db52-529a-43cc-ac7d-38b52627e8bc@app.fastmail.com>
 <c1608c48-13c2-4290-826b-28b5ca51eaf7@suse.com>
 <7332feff-2649-496c-8e49-b0a19eb54a32@app.fastmail.com>
 <akJUz0kYkEBdLSZ3@gmail.com>
Message-ID: <akQR9YMtMHReJTfB@google.com>
Subject: Re: [PATCH 00/32] x86/msr: Drop 32-bit MSR interfaces
From: Sean Christopherson <seanjc@google.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, x86@kernel.org,
 linux-acpi@vger.kernel.org, 
 kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, 
 virtualization@lists.linux.dev, linux-ide@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, 
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-hyperv@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>, 
 Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>, 
 Yazen Ghannam <yazen.ghannam@amd.com>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Pu Wen <puwen@hygon.cn>, 
 Bjorn Helgaas <bhelgaas@google.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
 Alexey Makhalov <alexey.makhalov@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>,
 Reinette Chatre <reinette.chatre@intel.com>, 
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, 
 Babu Moger <babu.moger@amd.com>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Dave Airlie <airlied@redhat.com>, 
 Helge Deller <deller@gmx.de>, linux-geode@lists.infradead.org, 
 Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Guenter Roeck <linux@roeck-us.net>, Peter Zijlstra <peterz@infradead.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, 
 Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, 
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Artem Bityutskiy <dedekind1@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Ashok Raj <ashok.raj.linux@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 "Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>, xen-devel@lists.xenproject.org
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

On Mon, Jun 29, 2026, Ingo Molnar wrote:
> * Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > >>> Note that most patches of this series are independent from each other.
> > >>> Only the patches removing a specific interface (patches 7, 15, 26 and
> > >>> 30) and the last two patches of the series depend on all previous
> > >>> patches.
> > >> 
> > >> It looks like you are touching most files twice or more here, to
> > >> first convert from rdmsr to rdmsrq and then to change the
> > >> two-argument rdmsrq() macro to a single-argument inline. If you
> > >> introduce the inline version of rdmsrq() first, you should be
> > >> able to skip the second step (patch 31) as they could be able
> > >> to coexist.
> > >
> > > I've discussed how to structure the series with Ingo Molnar before [1]. The
> > > current approach was his preference.
> > 
> > Ok.
> 
> Note that the individual patches are IMO significantly easier to review
> through the actual 32-bit => 64-bit variable assignment changes done
> in isolation (which sometimes include minor cleanups), while
> the Coccinelle semantic patch:
> 
>    { a(b,c) => c = a(b) }
> 
> which changes both the function signature and the order of terms as
> well, is just a single add-on treewide patch.

Is the plan for subsystem maintainers to pick up the relevant patches, and then
do the treewide change one release cycle later?
