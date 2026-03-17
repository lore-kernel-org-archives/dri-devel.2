Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C145FED9E0
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7093310E3FC;
	Tue, 17 Mar 2026 14:56:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pw61+tJp";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0684C10E3FC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 14:56:51 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4853f2826f7so61490595e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773759409; x=1774364209; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fV0vsElu+7ZDP0k7EZQosqrMEMjbFMIbCAe1EPTu8LI=;
 b=Pw61+tJpY9hG/aPfRgW282RX3RujtlF9GAUx8/P9W/sa6dqj57+1TG3YUP91JfAmSV
 9ZryN2EKZi/08kq46waJzBal2xAYkeefAViJX13qERt+7PNqLk1Hd/MM0LJjEO7ebSEP
 uZjGDQEbu/4reL11ekjxWnrzXYJggeSXZ104ShZKlvB1TYuSLuDGa/jxThcvEWQTY9md
 83or+Iuee0wqWgvlYPvvpTAFJR1Slv8Pzu/v878MIaN2p2AFygs+4KR0viDNjDW4NXyn
 uK5KjRkbwaYi0+qEtIc6av+FKUCUJ5wIxGdON3qrsdaz5KvStMbRH2RQah3KO5peWiNi
 Ug9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773759409; x=1774364209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fV0vsElu+7ZDP0k7EZQosqrMEMjbFMIbCAe1EPTu8LI=;
 b=J1umcQRLdwDqhEX0Ve0BgjfIRKvmpoFhpBac5i31CYc0IDI7xc9GwO6uGmMxcRbNQF
 zqF5c3i+Y3BbN3dG/AtH3jsY0N7IpbbXI2U/8FfrowibcsANVvPmMNSreXrUiQDHLvQW
 HpZt4J6hS3DPpyPhejA3J+a7nKFesJAnZZZ5InwnFAmbV66bo0Bz2LLa4SzJ4fTp9u+S
 aF5tV91BGIA2veejyNtSGArrE24EqXUCplyF5RwGxw8R/vZ5lpupG0yxNHeRkhUUo5Eg
 yC+ucdNbUdeYkUKQ9p/eqQxOV58UH1jxyhHjbaaDS/iLO/F3J0gZrl5szwB5tC+h8XvK
 NUFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXWyi/WvW5RAYmJ1pWM28BjSXdhC9R1p7BLOkQWkVbUBe9Deopdz7HzQH80JH0cbF7LsJdVVvtZmI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywr2SmWROXL8DCTNu1VkCdl/4K0j3Dm96deV3v1Td6j54x3mfuR
 1LVD75Iyvz19jj4qxFw/d9nvb484iQY1uaGiPajb5UTM3PMQnbWt6ace
X-Gm-Gg: ATEYQzxGKShI3H7CauPh+75bYWgATrbtqA7xT9Iz3/5k0qArLY60Qcq5njXTYBnxpou
 9dvJFyE9R9wwYGemK7kU/vBKeeKd04PAre9hkgFEPsB8PlOLFjBPbTx6NpFxLovHBlSEaiqXMlF
 piekecWKJrVPEdmaxx+yIgnVw6jZsncoG2tEieytdna0dpmwtxtcjc8AAv3+mbnpuiQOecz7KO2
 TgOrkI953FN1/MiWPNIrZBD0UF9CKu12PO/CpSgGSy1Ticiv/5GK4VNfqbb/x9BJsd7Oldg9MHm
 Usnd6lAuAuAoiyOS8CY3J+Ddzpp08pPby0OghZ9kxnV+Uo83LGhhtPsdmSNQzDtJqCfjjmQVD68
 yGmbLdMBW0bIqXOtY2kUAHssCCzxAJPMEoF//FXOmHdYVOXj1trGezKJ/kbsgjqQSVmy42Q+jDA
 IFP3A33rgozBRVz0d3cWHv2DHBy80Bgc2Z5x2HVZTdhyXmXdh8mer/KSNpJ35+ALKQ
X-Received: by 2002:a05:600c:1d1a:b0:485:3d00:efd with SMTP id
 5b1f17b1804b1-485566cfacbmr307335885e9.7.1773759408795; 
 Tue, 17 Mar 2026 07:56:48 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea97e8esm74472665e9.5.2026.03.17.07.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:56:48 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:56:47 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Matt Roper" <matthew.d.roper@intel.com>, "Arnd Bergmann"
 <arnd@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>, Thomas
 =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>, "Rodrigo
 Vivi" <rodrigo.vivi@intel.com>, "Dave Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Dnyaneshwar Bhadane"
 <dnyaneshwar.bhadane@intel.com>, "Lucas De Marchi" <demarchi@kernel.org>,
 "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>, "Umesh Nerlige Ramappa"
 <umesh.nerlige.ramappa@intel.com>, "Raag Jadav" <raag.jadav@intel.com>,
 "Niranjana Vishwanathapura" <niranjana.vishwanathapura@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/xe: use %z format string for ptrdiff_t
Message-ID: <20260317145647.0d5de2a1@pumpkin>
In-Reply-To: <e46c3681-6f5f-4a41-b5bf-72627b4ec87a@app.fastmail.com>
References: <20260316224357.658520-1-arnd@kernel.org>
 <20260316225118.GD2729713@mdroper-desk1.amr.corp.intel.com>
 <e46c3681-6f5f-4a41-b5bf-72627b4ec87a@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 17 Mar 2026 00:07:57 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, Mar 16, 2026, at 23:51, Matt Roper wrote:
> > On Mon, Mar 16, 2026 at 11:43:46PM +0100, Arnd Bergmann wrote:  
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> ptrdiff_t, size_t and long are the same size on all supported architectures,
> >> but gcc requires the use of the %zx modifier instead of %lx. On 32-bit  
> >
> > Nathan Chancellor just sent a fix here:
> >
> > https://lore.kernel.org/all/20260316-drm-xe-fix-32-bit-wformat-ptrdiff-v1-1-0108b10b2b6b@kernel.org/
> >
> > His solution uses %tx rather than %zx, which according to
> > Documentation/core-api/printk-formats.rst sounds like it's probably the
> > most accurate format string for this case?
> >  
> 
> Right, Nathan's version is correct. I wasn't aware that size_t
> and ptrdiff_t have different modifiers.

Consider:
void foo(size_t len)
{
	char *p = malloc(len);
	char *end = p + len;
	ptrdiff_t diff = p - end;
	printf("len %zu, diff %td\n", len, diff);
	free(p);
}
Clearly foo(5) output "5 -5".
But what about foo(5u << 29) on a 32bit system with a large unlimit and
a big enough hole in the address space.
More likely would be something running on an x86 in real mode.
There malloc(65000) might be reasonable, so size_t would be unsigned int
but ptrdiff_t would need to be a signed 32bit type.

Of course, in linux, they are all 'long'.

	David


> 
>       Arnd
> 

