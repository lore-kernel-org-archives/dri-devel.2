Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB285C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D272310F4D0;
	Fri, 17 Jul 2026 09:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SjJUoV11";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B46F510F4D0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:39:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B88A660A5E;
 Fri, 17 Jul 2026 09:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583FD1F00A3A;
 Fri, 17 Jul 2026 09:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784281146;
 bh=+qglHjGyDrUKXlad/2R3jZv9/pC2LefY+KO7XkEkSko=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SjJUoV11rwuT+5AizqR6Ts6eoKb6FIGre1Dux163GhMlqZlyOXajtWZ4fayfgVpH9
 m9cgU5vVhldyF6Xw1Kb8rVhViKflUSonqgQ1XE4NCnm2BVJY+TnbSkh9Z3rIVPhd6s
 zU7mHk1ONLaADnjIxp+I5dcB3ZX2ynHffnRRVYklEoaeIIz/ZSYdwAkj3wzibEUx9o
 HnS12bG6z8ihRuFocqmHyHuXUYtM9fOcbFkvkQ/W/8UHnOkWe7OeZRKXrCxZZCA9nQ
 s6WCpg4YrH/mKvwpz01fi9YDCJ3Uu05lBNYlNAvTtCCufAR6IHv/1e4r2yoFLfOqhY
 leqJTK6WbuRqA==
Date: Fri, 17 Jul 2026 11:38:45 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: Sean Christopherson <seanjc@google.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 x86@kernel.org, linux-acpi@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev, linux-ide@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-crypto@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-hyperv@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-mtd@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>,
 "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
 Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Kirill A. Shutemov" <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Pu Wen <puwen@hygon.cn>, Bjorn Helgaas <bhelgaas@google.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>,
 James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
 Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Helge Deller <deller@gmx.de>, linux-geode@lists.infradead.org,
 Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Guenter Roeck <linux@roeck-us.net>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Ashok Raj <ashok.raj.linux@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 00/32] x86/msr: Drop 32-bit MSR interfaces
Message-ID: <aln4JYxRgdpC3Wse@gmail.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <d7c1db52-529a-43cc-ac7d-38b52627e8bc@app.fastmail.com>
 <c1608c48-13c2-4290-826b-28b5ca51eaf7@suse.com>
 <7332feff-2649-496c-8e49-b0a19eb54a32@app.fastmail.com>
 <akJUz0kYkEBdLSZ3@gmail.com> <akQR9YMtMHReJTfB@google.com>
 <akY4U0jUZm4HOGZ_@gmail.com>
 <99228803-b8b7-47a3-b77c-6fdf3b785730@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99228803-b8b7-47a3-b77c-6fdf3b785730@suse.com>
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


* Juergen Gross <jgross@suse.com> wrote:

> On 02.07.26 12:07, Ingo Molnar wrote:
> > 
> > * Sean Christopherson <seanjc@google.com> wrote:
> > 
> > > > Note that the individual patches are IMO significantly easier to review
> > > > through the actual 32-bit => 64-bit variable assignment changes done
> > > > in isolation (which sometimes include minor cleanups), while
> > > > the Coccinelle semantic patch:
> > > > 
> > > >     { a(b,c) => c = a(b) }
> > > > 
> > > > which changes both the function signature and the order of terms as
> > > > well, is just a single add-on treewide patch.
> > > 
> > > Is the plan for subsystem maintainers to pick up the relevant patches,
> > > and then do the treewide change one release cycle later?
> > 
> > I'll try to keep the patches in a single tree (tip:x86/msr)
> > in the hope of not prolonging the pain two cycles - but it's
> > of course fine for maintainers to pick up the patches too
> > (most of them are standalone), we'll sort it all out in the end.
> 
> Ingo, would you be fine with me posting patch updates just as replies to the
> original patch emails? This would speed things up, as I wouldn't need to wait
> for more review input of all the patches before sending out new versions.

Sure, that works for me too. I've picked up a couple of -v2 patches
already.

Thanks,

	Ingo
