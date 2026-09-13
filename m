Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F37C88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 05:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E25210E03F;
	Sun, 13 Sep 2026 05:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Qisyn0n7";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 193AC10E03F
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 05:36:31 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254fa663bfso201918666b.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 22:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789277789; x=1789882589; darn=lists.freedesktop.org; 
 h=content-type:in-reply-to:autocrypt:from:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x33SXcGKJZwybp329vf09l/E4GjWsK3N79Z1GJxL4P0=;
 b=Qisyn0n7jKTEzK+GA3IygvCVyizemPbz8s9/FAwTvPBldHyxhf2IOUqGi9VU4238fq
 g3rGcFUsaW6phmdP06Xub3zWWQ9nbboE1fIogHSUg9pWmyK8mapU7O7oqT5G78eXstZo
 F4uP0lOq2rBDGqgBV1+RpAwrCjGqUMffJ/2C1HKxN31X6qGRNzOprOSNy79b2fQW7aFV
 NJ99dSYfBan2RIO6FyWyy0prZyOsQZ7IXF9eQNBqjwDfVamYJzK6yIvXsSn/PxAd2vk6
 FozzC2UAOUiOsihCiPnU4lHPcWRof320ApNSydhK2/jOWL3fQHsq9XH+DNyxKR4TubYz
 Ycyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789277789; x=1789882589;
 h=content-type:in-reply-to:autocrypt:from:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x33SXcGKJZwybp329vf09l/E4GjWsK3N79Z1GJxL4P0=;
 b=hZRpnTVgpxBz6KJZ4QWFPtCe7Y+HuE3tlhw2WddS89fYVcavXj7YcZH9IF2Ef8mKZA
 EVhBg1FG+FXs4DfFn3zy0+hJXC+QxYbszM3US2vw890fzgPWuOYjnhxvdAP8NhclAB5K
 xP5aCAMql9F+l7wsbr2DuuF0FKj7DZwHkiFc3//WXOwpCeFWwF/H7Ofz9bxPrlCnrece
 55Je/Qoelp83CisxeR9+NjlyHrSsDXB8nlpoNawNefMyuEnAfS2/2k9RDeEc8O3ah6TC
 kiT2l93IevhPqQ5umHrnjHsenvgvBooJMEk67iEeNm7Bp4idwkHHZd8pe0vLFCPG7ix/
 A4lw==
X-Forwarded-Encrypted: i=1;
 AKwUvByBx8HemEy8Cw7YsXrgmtgtrI9/w1Y8WrVQ9Yq20OPXZoYsFrm1BGWV6B4pKRYXTJUT3SN3lHU+j58=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lLYPVB8upprbfK8wdWjJEvEkdyfnnpCSPj+buVG0HHjuZK7mXy
 6iTFWVMxAmxdx/XnqzNWuf031XtUWq25u5HDhN+qeY92OPNSlml0UPnWmBDZO3UpYoU=
X-Gm-Gg: AYBFou3Bg+aPWNYYDwzscE6K8L6nScyL7WZOm/WyQPRrWIrcqZthww5oDJhXmiDkiNC
 6L6qxiA1hsPpmI9lAeTq7wXeHj1vSuGYZevLcDzri3QWu4tiY8PmmfhPN1XM82i7OkugUyeog/D
 jZnybrrpVJ3Cp9DlaqbpFiqI1aqO2Yvdbnx9Y9X0vj172CL0kBLDoFhvsJtGWYjh5hiBqrbgAC0
 POP4nLOrc0egHw8N02cCdb+bwRZ6sxXqd1Yyucthsf7kxJ7Re2lo0o/CB2Y/42h0eg5jSPK6Pxm
 TQraPkfsXaTZHNHlceL+cf0Bo/T3qH+PSJhVr8PAHKtoNCpE5qJHcRl9vFTYOG/u/xQUR6aRoip
 ml8EpC/Uplmsvb1lRG0GmkIY7UlA6+17TPR0SlxhLI6uZtcF52RVeychunvlguATfCZXDqMAYTI
 NSGQ+VnUjdm7KqFvuC8Kx4ihMiz72a6UCKaFXkvqsmq/V5TLDXtLdGxLJd66smyP3SUyLTo97v+
 M9LRmjHTLVbeCO7oSb3kqHNQmB6LH+zfAiioSasK77+tR0JqSeEaX+J0x5SPe91iXi3RlL2nPRQ
 IpOA+DdHJcbHPTfKd49jt6xl
X-Received: by 2002:a17:907:e895:b0:c20:1bc5:7002 with SMTP id
 a640c23a62f3a-c29665414f1mr1041706166b.3.1789277789216; 
 Sat, 12 Sep 2026 22:36:29 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112?
 (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de.
 [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2966066b75sm264030566b.29.2026.09.12.22.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 22:36:28 -0700 (PDT)
Message-ID: <170d06eb-5cc7-41f0-a0e0-0eeca77307c7@suse.com>
Date: Sun, 13 Sep 2026 07:36:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] treewide: convert rdmsrq() from a macro to an
 inline function
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Pu Wen <puwen@hygon.cn>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Babu Moger <babu.moger@amd.com>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Len Brown <lenb@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, David Airlie <airlied@redhat.com>,
 Olivia Mackall <olivia@selenic.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Viresh Kumar <viresh.kumar@linaro.org>,
 Huang Rui <ray.huang@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Artem Bityutskiy <dedekind1@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Ashok Raj <ashok.raj.linux@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 Xi Pardee <xi.pardee@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Helge Deller <deller@gmx.de>,
 xen-devel@lists.xenproject.org, linux-geode@lists.infradead.org,
 Michael Kelley <mhklinux@outlook.com>
References: <20260911074530.3140830-1-jgross@suse.com>
 <20260911074530.3140830-13-jgross@suse.com>
 <b2baa471-0f6b-84e8-bda1-ae0964b72b04@linux.intel.com>
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
In-Reply-To: <b2baa471-0f6b-84e8-bda1-ae0964b72b04@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------eaM1imaen800kHMvvuISziE6"
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
--------------eaM1imaen800kHMvvuISziE6
Content-Type: multipart/mixed; boundary="------------NEp702byBysSRAjr2vYU7iXA";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Pu Wen <puwen@hygon.cn>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Babu Moger <babu.moger@amd.com>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Len Brown <lenb@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, David Airlie <airlied@redhat.com>,
 Olivia Mackall <olivia@selenic.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Viresh Kumar <viresh.kumar@linaro.org>,
 Huang Rui <ray.huang@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Artem Bityutskiy <dedekind1@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Ashok Raj <ashok.raj.linux@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 Xi Pardee <xi.pardee@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Helge Deller <deller@gmx.de>,
 xen-devel@lists.xenproject.org, linux-geode@lists.infradead.org,
 Michael Kelley <mhklinux@outlook.com>
Message-ID: <170d06eb-5cc7-41f0-a0e0-0eeca77307c7@suse.com>
Subject: Re: [PATCH v3 12/13] treewide: convert rdmsrq() from a macro to an
 inline function
References: <20260911074530.3140830-1-jgross@suse.com>
 <20260911074530.3140830-13-jgross@suse.com>
 <b2baa471-0f6b-84e8-bda1-ae0964b72b04@linux.intel.com>
In-Reply-To: <b2baa471-0f6b-84e8-bda1-ae0964b72b04@linux.intel.com>

--------------NEp702byBysSRAjr2vYU7iXA
Content-Type: multipart/mixed; boundary="------------JHou3VyeAHLBdBUp1ZKQPjhy"

--------------JHou3VyeAHLBdBUp1ZKQPjhy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDkuMjYgMTE6MzcsIElscG8gSsOkcnZpbmVuIHdyb3RlOg0KPiBPbiBGcmksIDEx
IFNlcCAyMDI2LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiANCj4+IFRvZGF5IHJkbXNycSgp
IGlzIGEgbWFjcm8gdXNpbmcgaXRzIHNlY29uZCBwYXJhbWV0ZXIgYXMgdGhlIHRhcmdldCBm
b3INCj4+IHN0b3JpbmcgdGhlIHJlYWQgTVNSIHZhbHVlLg0KPj4NCj4+IENvbnZlcnQgcmRt
c3JxKCkgdG8gYW4gaW5saW5lIGZ1bmN0aW9uIHJldHVybmluZyB0aGUgTVNSIHZhbHVlLg0K
Pj4NCj4+IFRoZSB1c2VycyBoYXZlIGJlZW4gY29udmVydGVkIHVzaW5nIHRoZSBmb2xsb3dp
bmcgc2VtYW50aWMgcGF0Y2g6DQo+Pg0KPj4gICAgLy8gT3B0aW9uczogLS1pbmNsdWRlLWhl
YWRlcnMNCj4+DQo+PiAgICB2aXJ0dWFsIHBhdGNoDQo+PiAgICB2aXJ0dWFsIHJlcG9ydA0K
Pj4NCj4+ICAgIEBADQo+PiAgICBleHByZXNzaW9uIG1zciwgdmFsOw0KPj4gICAgQEANCj4+
ICAgICgNCj4+ICAgIC0gcmRtc3JxKG1zcix2YWwpDQo+PiAgICArIHZhbCA9IHJkbXNycSht
c3IpDQo+PiAgICApDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdy
b3NzQHN1c2UuY29tPg0KPj4gQWNrZWQtYnk6IERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtl
cm5lbC5vcmc+ICAgICAgIyBBVEENCj4gDQo+IEFja2VkLWJ5OiBJbHBvIErDpHJ2aW5lbiA8
aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+CQkjIHBkeDg2DQo+IA0KPiBXaGF0IGlz
IHRoZSBwbGFuIGZvciBtZXJnaW5nIHRoaXM/DQoNCkluZ28gd2FudGVkIHRvIHRha2UgdGhl
IHdob2xlIHNlcmllcyB2aWEgdGhlIHRpcCB0cmVlLg0KDQoNCkp1ZXJnZW4NCg==
--------------JHou3VyeAHLBdBUp1ZKQPjhy
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------JHou3VyeAHLBdBUp1ZKQPjhy--

--------------NEp702byBysSRAjr2vYU7iXA--

--------------eaM1imaen800kHMvvuISziE6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmqmNlsFAwAAAAAACgkQsN6d1ii/Ey+b
zwf+OzaU6Petyp2h+7lmUlJdSjc0eGdEi1rB0ocVzj1kZHlAYaJJchfEYlr+cy0jrRbAJUqhocOe
c/DNBw8RSCwubb6xG6QmMEUtKIZLM+wjc/7U/S+ijRfm4cSHAnOr3Vh6jffSSW0G96X5SzsCpC5v
vC2SBDQjyP+kgsXS4vGBrhBzRC4SXsIHwOmVNJWDkTlpnzTh0joIXofqOrNHKQMcGuBpxJCHDYSL
NkUzegBFSRDKWDqtEOP5DrbpgeJEve03txe84l6HRyCVozjsba1pS2fehrmMh9+xRi40lMnxGRKq
EiFbizqDTM71Fgp15B9MKWAg+6FGtcM7TKtwsc/reQ==
=agVt
-----END PGP SIGNATURE-----

--------------eaM1imaen800kHMvvuISziE6--
