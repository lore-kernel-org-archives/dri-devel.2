Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28975CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F6610F5A8;
	Tue, 13 Oct 2026 07:53:18 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1799510E606
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 15:29:50 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so13152465e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791818988; x=1792423788; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dHaZjZ/K9HkcWHP0xoN3hdI7zGw/VH12N/DXI78bY9w=;
 b=KtYa8f0GS4Vf0rCxx0WGjaHaQuFkyo2Lqt9vIyYnMpKcfQvX/3a7HAcfLQb5c+EG3t
 fD4lGzqKwqu246XJNqfalsm4ZHXIQF73kNkPsMVMwDaUTg8LOM8X+1p04CYkoA/erv74
 idIFog+x72DuwVPyc0fGH1Td+vecKgnc2Mu4m3APg0HKK+5Qx8+W1NCyYHK12gB3wb0x
 YTcnmtGdflV7KOLBgWOsdd0I1S2iRi2WESajs/RAZgIseelys3F0/b5tNQn/gPb4Qij3
 AZFNKQaOfIfPCNE5uPxL/sb3sG22kIdIi78TH+6lQp3bKX1bDM2jdJ4KM8A1HH/tuncr
 0eSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791818988; x=1792423788;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dHaZjZ/K9HkcWHP0xoN3hdI7zGw/VH12N/DXI78bY9w=;
 b=RUAx6P3OUN8y8aZUnOAwtI3bM+wAQ0R1pjE9+DnK1pG2FKaAJLmxqd+VQNkTNrgF6i
 RCIFInz0tvj7u3oZbW/H4CQzeszcuVQKTC+MJQY6FzWq2lb9t8ou2f3NNQhr5WhBCFez
 HZ9DIflBWsAh181nPLmIa2KNUk/D2ICCIWKwYWIZnqCz19J5rNpCSK58lCCga9Kt1EfL
 dn6c/uWZQq74LcGd4k/A3hnpFIwP6u3MlOEzGxScKYcFLyATBzGqflmsjIpgmSsKwu8c
 jikFqjqKXz3fHcTUZHbMFCJsrG2FcmHPVHSL6AoC78hhddP1usKFv1fhC/crP+9jtqTq
 kYRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxe4MkyFnTHR83v/S5OLsg3dVx9uEjoRoiiYJFSZRhvZa+CALA5C+GRS2HCP+G5D4qkr0ERJqnXJMs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKjHeUl4HtVwnU2Pi+spZF5UVsMxvfZt3/o2ARvi4B0ZON2z2RP
 utJtfx6ZOkGK9mgkPrvflXG47a8gy4M5+dT86JEG+mQYW8iGOoq1EH3X
X-Gm-Gg: AYBFou0oOey+mON1jOhgtd9oVyYHMPmeZrSPROnKBTiU9ZfDlG3BJm/nvP4kGIsvqph
 euH2aH/vQ9FN0gMS7dWki8IUyuPWOs0NFB4JdOl53xzWba5TlhzQ0dCMIP+0nAGHT3kiFasHyCz
 IZTnv4opdPe2y481oxgjBWcmEDyqFREuFH+HVGcJC+TW+ZsCaGiAYHHISIyoVtf4iSBTN/LmfKs
 gAHjepCbmFlDPeJvK46xmj+xqZMmBo3JTwVY6+cjiY5a9XJ8KivurrneOE48iEdndru47SCDYDn
 ot0oWaRwD+p9AAALMxSDjXmpwElD/TxVLDVOe1ukJ/9bUMBz1XUtEoG0Sj95ntKxevOAOQsoptn
 GmacFNa6f8sRTqvk90rIf+zMnSCjqI6/ybJIHvxkNlxoJN1Ie3xvwJYYs6HvcMVPxid/ausO+Dt
 jQWWkG1EcCvfru/tnK1NGzPC5SY4e1dHBZx9PZDfpG0iPGlSKFrT3BQEY7KHVfsERzKbrjg40u9
 bpAQg3w3p0XA75iQtPAguabczrccbl9nW733I/bLDAeDug2ECwh1WxasvHuAEkMmat2LX+WKmNL
 +wIDARpo38bJ3Fy076ZotL3ziaOk4eMP02Q=
X-Received: by 2002:a05:600c:8105:b0:4a1:714d:eed with SMTP id
 5b1f17b1804b1-4a18e4841c1mr177576875e9.14.1791818988354; 
 Mon, 12 Oct 2026 08:29:48 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com
 (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a190344032sm299058135e9.15.2026.10.12.08.29.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Oct 2026 08:29:47 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oupton@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Ackerley Tng <ackerleytng@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 2/6] dma-buf: Add get_phys() to describe a physical run
Date: Mon, 12 Oct 2026 15:29:46 +0000
Message-ID: <20261012152946.63489-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012144616.GF14213@ziepe.ca>
References: <a04f17cc-f59a-4240-81c8-29776eee3a2e@amd.com>
 <20261005132046.30025-1-griffoul@gmail.com>
 <f0077cec-10fe-400a-b229-f7434e297364@amd.com>
 <20261012144616.GF14213@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

On Mon, Oct 12, 2026 at 11:46:16AM -0300, Jason Gunthorpe wrote:
> I don't want to keep expanding this hack in iommufd. If dmabuf is to
> be used then dmabuf needs to provide a pluggable way to fill the
> iommu_domain that many exporters can plug into. I don't want to
> hardwire every exporter into iommufd, that makes no sense.
>
> The existing arrangement is to motivate solving this problem
> generically, not something to be expanded on.

Agreed. The iommufd registry I mentioned above was never posted, and I
have dropped it.

The series I posted since takes another route, without dma-buf:

  https://lore.kernel.org/all/20261006183235.16576-1-griffoul@gmail.com/

It adds a small interface in mm for drivers that own memory. Such a
driver hands out files, and for each page of a file it tells the caller
which frame backs it. iommufd maps the file with IOMMU_IOAS_MAP_FILE and
builds the iommu_domain itself, and the driver revokes a range when it
changes. So iommufd never knows which driver it is talking to, and there
is no symbol_get(). guest_memfd uses the same files for the guest. The
iommufd part is patch 5:

  https://lore.kernel.org/all/20261006183235.16576-6-griffoul@gmail.com/

The iommufd part is mainly there to show the interface, and it needs
more work. Its revoke unmaps and then remaps, so a device can hit a
hole. I would rebuild it on the REPLACE operation David discussed with
you at LPC, with the scratch page as a quirk on the IOAS.

Is this the kind of generic interface you had in mind, or would you
rather have it hang off dma-buf?

Thanks,
Fred
