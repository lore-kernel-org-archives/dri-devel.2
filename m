Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78642C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 05:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D36410E135;
	Thu, 20 Aug 2026 05:27:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="FLcYxKLN";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5853410E135
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 05:27:15 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6a378f90555so2667831a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 22:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787203634; x=1787808434; darn=lists.freedesktop.org; 
 h=content-type:in-reply-to:autocrypt:from:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pD5f4qqlrVvZK5V1FYjurHHuEuqcJN2AUDmZ/4khKV0=;
 b=FLcYxKLNULlNzOYJjOhI8utJHj1ZSLzJ57/b73wqlaPxuRIBlvczyYsIpDApeOMfhD
 0baw8eMze7owi6soUq29vp8Pk+CZxGfaC8Tqt0LuO9TT/aLMxDVlsmYzfifAUqXxZoXy
 OMDc5lcvVEHXcT7wIKxHV42kvZLfObPWOXj2mgA7yxw+6om+12jX394/Tcux/GeIgkr/
 ZEVHrWs80yA4UPMl7Ns9IfAE7VmAeiLNFeWUak98F9i5m5pDBiX+bj3ngdzXSxZvxHRA
 ysTOdVRw0AfY9TRnTsVHlbLR/QirY4K+u+DMoR/orOs6LVkpTX1KfsAeImBS2L7cEx2L
 PW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203634; x=1787808434;
 h=content-type:in-reply-to:autocrypt:from:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pD5f4qqlrVvZK5V1FYjurHHuEuqcJN2AUDmZ/4khKV0=;
 b=bXVaMKGcvJh2jBtntdcRc+qFnpwjtjJugU5E/bHRGA3y0SC7AV3cRVISubzUHeidzk
 5X5IwPEdYTYAnl3p2I80AL/jBqd/t8fxDXrePQSYl4GH2RZp3jGN+qjJ5obe3hbaqxez
 CSEhfzFAQgdee+zDZ72E/cH/suN1tswExQwjO/UQMwQWS3W2FkACad1sNCkFX0wGVtHJ
 SURufenaZVxUjhPPZYoIj8UrZY1jmA1lOOV7walqjdqHfsLJc+M9RHnOxRehkPia39+9
 ndNDXta7RK0+g7QwirGhnTPGDkFWRPi/hLP8TmP7ASuLRF2KyCCZhYAM1PbxrbXtbHqJ
 SHjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVJnR+I++qvE3VBMPJ0iCmiiTgkPWF4ISXygwen1YVnggmxz+UeYVOhjeAjMx3qg18qCtTcpgMmOY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4sVOgKiGajS+pNZ5iDVE+kywc3u8Wbmyx7LGHjIOyThM2Hrog
 OETcRzy1Ufm9qQ4m/SPjElVW5gFGfkTnub68292AWQAFQiYGK8in7zHzsXYQPMAvZM0=
X-Gm-Gg: AR+sD13I/fDC66M61mhRnTXlhh2Xi6+wWRIeW2Auec5Xc5m8c/nN7CFQqcvNlTLAtEE
 fUWlEx/tp40+kjHR2za5gX2GeB3WklJe96NJl2GNZErDfKaGx+y9GNpCN0hNX08mzrwoD1kvEEX
 ZjUEJFJ8VlyxeP2wQoLIMYBkMOV4kA7t4dYQkwIpqtEwXm5xHEVI33rczLNsVGqznw5tY9iX8ly
 O4kRmGAS/8P3QP0xdguD+ISgbx1Z3K/v1ymli2pSrkotppB6A58aKOZlu2HjzHw+BeiodqFSx3b
 L0QvZDm8gmy++3QKULA/no4X1IYunNZHJpHbQXN6iYIsfodwOMIbccp2CdujKJ1CJHd2vIoJGrO
 +qASGY0YEXQ203pM4TrzC8LH6KskbKEvn/La3gRqWevgHBR0FpDlZswYkYTWVLG80ccpK1HGksd
 4aeHKIGilecP2mhMIbOVPUvKGS+rUu5MPnZyQRosVbHTea44/UX0n/XKHDuhkOKEqG2de8rIVs0
 LnMO7uXeDHxI8OyUBvNaZwTTzhavf6T7xUl9iyvoNWHjQ3mtPrxPGT3H52xN413YbZ6pfG5lwRG
 bxi6606rrKi99w==
X-Received: by 2002:a17:907:3c8f:b0:c21:34a3:4df9 with SMTP id
 a640c23a62f3a-c23f92a86e6mr659193466b.3.1787203633620; 
 Wed, 19 Aug 2026 22:27:13 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112?
 (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de.
 [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24591989ecsm24409966b.38.2026.08.19.22.27.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 22:27:13 -0700 (PDT)
Message-ID: <7c46f230-7eff-4420-aafc-47fdc27abd24@suse.com>
Date: Thu, 20 Aug 2026 07:27:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] x86/msr: Drop 32-bit MSR interfaces
To: Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-ide@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, linux-edac@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 David Airlie <airlied@redhat.com>, Helge Deller <deller@gmx.de>,
 linux-geode@lists.infradead.org, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Pu Wen <puwen@hygon.cn>,
 Tony Luck <tony.luck@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>,
 James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
 Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Huang Rui <ray.huang@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Ashok Raj <ashok.raj.linux@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, xen-devel@lists.xenproject.org
References: <20260819102314.1499258-1-jgross@suse.com>
 <bd9e5b6e-07f2-459d-bca6-e290585060aa@intel.com>
 <aoXM2f1YTwgVj8KL@google.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <aoXM2f1YTwgVj8KL@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------OlQIV8uZOa0bnOS7005717DP"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------OlQIV8uZOa0bnOS7005717DP
Content-Type: multipart/mixed; boundary="------------qk5J6DZ8xy0dNfYeK9IbauuV";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-ide@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, linux-edac@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 David Airlie <airlied@redhat.com>, Helge Deller <deller@gmx.de>,
 linux-geode@lists.infradead.org, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Pu Wen <puwen@hygon.cn>,
 Tony Luck <tony.luck@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>,
 James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
 Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Huang Rui <ray.huang@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Ashok Raj <ashok.raj.linux@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, xen-devel@lists.xenproject.org
Message-ID: <7c46f230-7eff-4420-aafc-47fdc27abd24@suse.com>
Subject: Re: [PATCH v2 00/13] x86/msr: Drop 32-bit MSR interfaces
References: <20260819102314.1499258-1-jgross@suse.com>
 <bd9e5b6e-07f2-459d-bca6-e290585060aa@intel.com>
 <aoXM2f1YTwgVj8KL@google.com>
In-Reply-To: <aoXM2f1YTwgVj8KL@google.com>

--------------qk5J6DZ8xy0dNfYeK9IbauuV
Content-Type: multipart/mixed; boundary="------------VektzkYqobfpSCR53LmeFJO1"

--------------VektzkYqobfpSCR53LmeFJO1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMDguMjYgMTc6MzMsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+IE9uIFdl
ZCwgQXVnIDE5LCAyMDI2LCBEYXZlIEhhbnNlbiB3cm90ZToNCj4+IEhleSBKdWVyZ2VuLA0K
Pj4NCj4+IFRoZXNlIGxvb2sgZ3JlYXQuIFRoYW5rcyBmb3IgZG9pbmcgaXQhDQo+Pg0KPj4g
VGhlIG9ubHkgd29ua3kgdGhpbmcgaXMgaG93IHdlJ3JlIGdvaW5nIHRvIGFjdHVhbGx5IG1l
cmdlIGl0LiBXZQ0KPj4gb2J2aW91c2x5IGNhbid0IGRvIHBhdGNoZXMgMTAtMTEgdW50aWwg
YWxsIHRoZSAic3RvcCB1c2luZyIgcGF0Y2hlcyBoYXZlDQo+PiBiZWVuIGFwcGxpZWQuDQo+
Pg0KPj4gSSBvYnZpb3VzbHkgMTAwJSByZWFsaXplIHRoYXQgaXQncyBkdXJpbmcgdGhlIG1l
cmdlIHdpbmRvdywgYnV0IGFueSBhY2tzDQo+PiB0aGF0IHRoZSBtYWludGFpbmVycyBvZiA1
LTkgcHJvdmlkZSBpbiB0aGUgbmV4dCBmZXcgd2Vla3Mgd291bGQgYmUgc3VwZXINCj4+IGhl
bHBmdWwuIE9yLCBpZiBhbnkgb2YgdGhvc2UgbWFpbnRhaW5lcnMgd2FudCB0byBjaGVycnkg
cGljayB0aGVpcg0KPj4gc3Vic3lzdGVtJ3Mgc3R1ZmYgb3V0IG9mIHRoaXMgc2VyaWVzIGFu
ZCBhcHBseSBpdCwgdGhhdCB3b3VsZCBiZSBncmVhdCB0b28uDQo+Pg0KPj4gQnV0LCB0aGUg
bGFzdCB0aW1lIHdlIGRpZCBzb21lIE1TUiBmdW5jdGlvbiBtdW5naW5nLCB0aGUgdGlwIHRy
ZWUNCj4+IGNhcnJpZWQgbW9zdCBvZiB0aGUgcGF0Y2hlcy4gSSB3b3VsZCBleHBlY3Qgd2Un
bGwgaGF2ZSBhIHJlcGVhdCBvZiB0aGF0DQo+PiBoZXJlIHRvby4gSSdsbCBwZW5jaWwgaW4g
dGhlIGlkZWEgb2YganVzdCBtZXJnaW5nIHRoZSBsb3QgYXJvdW5kIC1yYzEgdGltZS4NCj4g
DQo+IE5vdGUsIHBhdGNoIDEyICJ0cmVld2lkZTogY29udmVydCByZG1zcnEoKSBmcm9tIGEg
bWFjcm8gdG8gYW4gaW5saW5lIGZ1bmN0aW9uIg0KPiBpcyBnb2luZyB0byBjb25mbGljdCB3
aXRoIHRoZSBLVk0gY2hhbmdlcyBmb3IgNy4zOyBrdm1fYWNjZXNzX3hzdGF0ZV9tc3IoKSBp
cw0KPiBnZXR0aW5nIG1vdmVkIGZyb20geDg2LmMgdG8gbXNycy5jLiAgU29tZXdoYXQgc3Vy
cHJpc2luZ2x5LCBBRkFJQ1QgdGhhdCdzIHRoZQ0KPiBvbmx5IGNvbmZsaWN0IHdpdGggS1ZN
J3MgY29kZSBtb3ZlbWVudCwgc28gaXQncyBwcm9iYWJseSBub3Qgc3RyaWN0bHkgcmVxdWly
ZWQNCj4gdG8gc2VuZCBhIG5ldyB2ZXJzaW9uIGFmdGVyIHRoZSBLVk0gcHVsbCByZXF1ZXN0
Pw0KDQpJJ20gZXhwZWN0aW5nIHNvbWUgbW9yZSBjb25mbGljdHMgZXNwZWNpYWxseSBmb3Ig
cGF0Y2hlcyAxMC0xMiBiZWZvcmUgdGhleSBhcmUNCm1lcmdlZC4gSSdtIG1vcmUgb3IgbGVz
cyBjb25zdGFudGx5IHJlYmFzaW5nIGxvY2FsbHkuIEluIGNhc2UgYSBjb25mbGljdCBpcw0K
ZGV0ZWN0ZWQsIEknbGwgc2VuZCBhIFYzIGFmdGVyIHJjMS4NCg0KDQpKdWVyZ2VuDQo=
--------------VektzkYqobfpSCR53LmeFJO1
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------VektzkYqobfpSCR53LmeFJO1--

--------------qk5J6DZ8xy0dNfYeK9IbauuV--

--------------OlQIV8uZOa0bnOS7005717DP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmqGkC8FAwAAAAAACgkQsN6d1ii/Ey+e
awf+Jpv8k2uyA4+Ryt6TuDaHqSnrkgatMB0F84HZ1AAuI02rgaxcS4qHeWXYnftFjGMzmdOuklMu
fD2qHqlJtns8wbus6eBshyaJf7L5QqPdODWfJ1xma7m/JkWCfsWEtF1RHh+/gqnAxZ36Pjln1VTa
cxXkk6/DqdrBc78e/ZRqY+yi90Eew9HaLArNBthsvcyWc9uXr8aGVl4naO3p/2Pj6J8FxDK7+9rm
OVsJX5tkOwDyarQUJGLfaSNizqJT0nDnb+VyBzRdCHS06Uy2ho9GXkp83OfJo7tn5MWHtggptx9W
8Q9DFLf/YdwL9qfWGVa/u5zq863UtqO9SWyFmp3aYQ==
=np+M
-----END PGP SIGNATURE-----

--------------OlQIV8uZOa0bnOS7005717DP--
