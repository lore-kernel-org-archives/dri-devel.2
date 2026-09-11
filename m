Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBA2C88E58
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8134410E2FB;
	Fri, 11 Sep 2026 13:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="CLR6ilj7";
	dkim-atps=neutral
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D7B610E2FB
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:22:44 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc435388657so1206941a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789132963; x=1789737763;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kqAHaS5fsv9ERkHKe2Kmet0fUHotC014bD2kFqqX4to=;
 b=CLR6ilj7QuFAp9hl1C397mYthu2nh51WUnQJMk6vznokxCt3uv2OcEZjX1BEXxLB6u
 rQtmO9nd8JYOz2iXpjpsCDTAAAtPiizi7gL+o792Zk/1Z/MoWtpSVaa/6fSUmshFKMjE
 j3gRf3muKLoK5fNbrgY0H9f3SP9hnpKXsR5YR3Ns6efMbtBeQTp2azJCylZXz3w71v1G
 BYbDYXp/2XD9W3o18ZLT0xJqr9h+0k6M0e9woM+kVvz2LgErOPghVM50Dws1eW0NCCaP
 pMx9Av885PWgXh+kwU8yS4vBckcZwpBtlQa9Z+40MTlhbH7eijcdSphSgWKXSV+iUOb0
 5gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789132963; x=1789737763;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kqAHaS5fsv9ERkHKe2Kmet0fUHotC014bD2kFqqX4to=;
 b=W81GYF9Llek6fPOR9Ig9NBzrcFR/Iff3J6ZeFYSVOKPL6l0DEjXZeMMRWkKg55hNDA
 ZzhgAj2o0K4ky3J6uWoS4DVQ6P1YLckhSig887EVC9ZrmJ5avOQIGt2JHTgWZHY5q3j2
 qwgxWUnLBCG5DDqhJ1Aie15NL7X4T7LrWH121h30MauNgatDE1XIcNhSwjiWX68ax7Ev
 +OC5ZR7yiTVbKoSv6zF0DCSGdpTmhmu90WD7Dw4Hzhpin8WCuLVP6lfTXZYPekA+ugAj
 fde+He3IIAKo2JUQCTkcJ0t0KENCme2Jo4lcddRKxPeSGRMwX1tqYGjW0Kx7YdwydbEg
 aVTw==
X-Forwarded-Encrypted: i=1;
 AKwUvByjhRHozxRPGfNNzUxDdkVxmeb8YzTYqdoBwTIs5qS/osADA0Lj8NVxw6jNsLH9s+CbsOxfn2pr5VE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lQ+9d1qTTrqHT+FeraGCXzjcE2JFRwQEKW3MkCJIPcFjnNHW1a
 NS1mbDuMY6NFKlFujYlefHECEjWrCZ2o4vVetF5ykxRh5WBnBUEUp6rsm+anpRYh5Na6ni7QYQa
 788LHUg==
X-Received: from pjbmv13.prod.google.com ([2002:a17:90b:198d:b0:39d:8dae:7e6d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c89:b0:398:e46e:ade3
 with SMTP id 98e67ed59e1d1-39d9c39625dmr7169956a91.23.1789132962606; Fri, 11
 Sep 2026 06:22:42 -0700 (PDT)
Date: Fri, 11 Sep 2026 06:22:41 -0700
In-Reply-To: <20260911074530.3140830-13-jgross@suse.com>
Mime-Version: 1.0
References: <20260911074530.3140830-1-jgross@suse.com>
 <20260911074530.3140830-13-jgross@suse.com>
Message-ID: <aqQAodJCAEZyeQ1k@google.com>
Subject: Re: [PATCH v3 12/13] treewide: convert rdmsrq() from a macro to an
 inline function
From: Sean Christopherson <seanjc@google.com>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
 linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-edac@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-coco@lists.linux.dev, 
 linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-crypto@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
 Alexey Makhalov <alexey.makhalov@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
 Pu Wen <puwen@hygon.cn>, Tony Luck <tony.luck@intel.com>, 
 Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>,
 James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, 
 Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, 
 Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
 Len Brown <lenb@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, 
 David Airlie <airlied@redhat.com>, Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, 
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Artem Bityutskiy <dedekind1@gmail.com>, 
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Ashok Raj <ashok.raj.linux@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 "Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 Xi Pardee <xi.pardee@linux.intel.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Helge Deller <deller@gmx.de>,
 xen-devel@lists.xenproject.org, 
 linux-geode@lists.infradead.org, Michael Kelley <mhklinux@outlook.com>
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

On Fri, Sep 11, 2026, Juergen Gross wrote:
> Today rdmsrq() is a macro using its second parameter as the target for
> storing the read MSR value.
> 
> Convert rdmsrq() to an inline function returning the MSR value.
> 
> The users have been converted using the following semantic patch:
> 
>   // Options: --include-headers
> 
>   virtual patch
>   virtual report
> 
>   @@
>   expression msr, val;
>   @@
>   (
>   - rdmsrq(msr,val)
>   + val = rdmsrq(msr)
>   )
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Damien Le Moal <dlemoal@kernel.org>      # ATA
> Reviewed-by: Michael Kelley <mhklinux@outlook.com> # Hyper-V
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
