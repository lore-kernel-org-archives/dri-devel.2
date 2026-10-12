Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC71CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5297310F177;
	Mon, 12 Oct 2026 14:46:26 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC08A10F1A1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:46:19 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-53397325663so21287191cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1791816378; x=1792421178; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kVDh4BcUbgvIW1O8+CoyCzwwqxHQNia8D9+ovujPztQ=;
 b=MyDVWSa9+zUbSb7PIXZIhWMaOcIiJvuh6dbjLAgV4CQjZrxlueNhoYjs1+sN/RNuAt
 oDNPtQpBa72pmyBSw7ivtbTRVe0CTnT7Not/J/+IHDEf6Kstq+l1R5tyvlG83fTulmPH
 jIV6hlV3tY2bPyNg+WJen3I8yJczWdhSbv+duZv9q4C7eHj3DbSShYq3zBjTOTHROERN
 sBV2IA5luSZVB0LSZgeXTIEwSM21dj3T6ZbQv5w0jzWGkoc4kWbimwF3LJS5IlVGjDMg
 g2HLSMeCjNDS/aRKwg4q83aSC8xi8HoG2RvtUGi9P35s64Ibgb3AtSzU4m/eVIZQfWAE
 5YJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791816378; x=1792421178;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kVDh4BcUbgvIW1O8+CoyCzwwqxHQNia8D9+ovujPztQ=;
 b=v6FsBhzgk5//sWhaA8ga30zRx1NKTW6rcvNF69o4fFITO7EqxVh1IfEHu+kcTGJO+Q
 rFDVODa6s7BTgq2PON7bxgAyjLrmyrsgGhnybGm/cTTRdzS+Lr+zl4geUUIqaaaYZKC6
 UL4vOju4stjWmakl+523y5T9vhMhrGO8nipACTN4f9Li5qpYU3xjMiiY41i7tZOLOHZs
 T1h9o7igP1UTYRUiKRxYqpIyWG8VfDPDHuVoh8/oEBBMOd1ZPHBXT8N1kc7UEroPjX8P
 W1JgCclUrbrioPljTYlyBSr408FLXuX0CRC8x9reY+i5D4XbHELBaaF6fValPVuAn3FQ
 zLSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7W18s4DOdsxAN0X8FqzaAO/u9SfqP/pUoLerwhKMS3Ss5C3gVCPy7r2GVHk1a4/itre7eP+LbbDU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLHosEJTdN1AyodREmmN//lfdDaTD4IWbMN1hBlV/TFsEiNC7zN
 2zUjLgncWLgsSSK7L2WniAyEXnHpv4LHKMulTWnc/BICiHwmLe721lcJCbI4BTfnfdA=
X-Gm-Gg: AYBFou2ZQchC4qNiv7UMvgdoXp7SkQ1OjNqoYeLpdDA2+uvsNavytJFmD3DlZ3m2mxy
 q9U6t5foIfm0jEWSYkNZV+WKlBAwQ5Q1t8nZcjyJ5QODXbd9VtcKsUCPWQsEYrEPlRhOBUYML7U
 vIIxGXsF40xH5VMC0CdL8xqfwBy0rWfDfv91jCZSdWMSWjzAYzhmaM5vRXSf4immv8er/skRwWd
 XrZ6YbstxAbSoJJCrcAgT/ovVDHYvRLgEoa/JAdW4zzbmcTVk2Ekk6881s62+tuhQiZHMF0EWr1
 r9H/WYLHyFx4BwIwSdoVtLefpKQjfujSMQCC7DQalutCzS0rb5ckqnJ7cRo8VN6YBFHyf9eK89+
 NDXLnXV+GdKK9i0J63RcAP/+tKgNNH0SPE0AwiVheW5rHtR8Te229qobWCTvWSvUJcUJH4+sqdb
 3TuL1SE/Odk9FmJQktXgPR4SlCox2I9wdVMbRZEIZ1hE5djHySnYgwqfIn3TSjJNWOjHaTz/3Cr
 3YRIPoeOF3BrcmpDVyW9PKIq4YYRQgHJuQCCj13p71vj/XUVEUdrpfN
X-Received: by 2002:a05:622a:2487:b0:535:1134:91b with SMTP id
 d75a77b69052e-5359faead4bmr160454661cf.14.1791816378499; 
 Mon, 12 Oct 2026 07:46:18 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-535e652f3c7sm3157041cf.26.2026.10.12.07.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:46:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xGHI8-00000006SW2-2nlk;
 Mon, 12 Oct 2026 11:46:16 -0300
Date: Mon, 12 Oct 2026 11:46:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Ackerley Tng <ackerleytng@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org
Subject: Re: [RFC PATCH 2/6] dma-buf: Add get_phys() to describe a physical run
Message-ID: <20261012144616.GF14213@ziepe.ca>
References: <a04f17cc-f59a-4240-81c8-29776eee3a2e@amd.com>
 <20261005132046.30025-1-griffoul@gmail.com>
 <f0077cec-10fe-400a-b229-f7434e297364@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0077cec-10fe-400a-b229-f7434e297364@amd.com>
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

On Mon, Oct 05, 2026 at 04:53:34PM +0200, Christian König wrote:
> > KVM gets its frames through the KVM-private guest_memfd provider
> > interface from David's series. iommufd gets them through a private
> > interface with the exporter, as it already does for vfio-pci. The new
> > version adds a small registry in iommufd for that, which replaces the
> > symbol_get() of the sample in David's series. The dma-buf is then only
> > the handle and the existing revoke.
> 
> Yeah that approach sounds totally sane to me.
> 
> We have drivers which stuff all kind of resources, not just memory,
> into a DMA-buf. That ranges from MMIO BARs to trigger FW operations
> (doorbells) over full HW blocks (ordered appends, global wave sync
> etc...) where two or more applications need to share which one is
> used.
> 
> That you then have a exporter private interface is for accessing
> this is perfectly ok.
> 
> The problem you are facing here is more that this is not limited to
> one driver/module but multiple ones and you don't want module inter
> dependencies because of the symbols.
> 
> So symbol_get() is probably the right thing to do as long as we
> don't have something like weak symbols or similar.

I don't want to keep expanding this hack in iommufd. If dmabuf is to
be used then dmabuf needs to provide a pluggable way to fill the
iommu_domain that many exporters can plug into. I don't want to
hardwire every exporter into iommufd, that makes no sense.

The existing arrangement is to motivate solving this problem
generically, not something to be expanded on.

Jason
