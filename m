Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70026CD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 12:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9468A10F03E;
	Tue,  2 Jun 2026 12:32:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="STHnsKXD";
	dkim-atps=neutral
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72ED810F03E
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 12:32:31 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-8ce9df31840so19877016d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 05:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780403550; x=1781008350; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c4LbN0qMsJPM0M7wr5pjCmaihB2Av83fU87UeNOOiAM=;
 b=STHnsKXDYVJXg5Z+rIFAclO0k/mgtp1O/d/aVyWVD9LpYaxeRAE+W/3IOSncEc3kPm
 q08ihn8VCQd/Vjxp3nobpQlIn2mIyai76YFNpftoVEl1Hbi/dTvntgNs3mIgoSfkFa0A
 BOcJWh7O0Juz16m0CJwHYXCLbh5DDf1cvIBwej0mR2V9Esvj6fweOEIVx5Jgn1Q1x7vs
 ZDsWPT5yPac5TE4HdXZajBCqfqczerlTVR2wd3u/rR1l28HazOxal2Hmnfyyl1Kb00mC
 NPTXyo8guhvJF6vRSdIsTm+Oz/BnChlz3ZXbL1L4KBqxrnWTQZDtB5155gPFQ8BxwZi6
 7LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780403550; x=1781008350;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c4LbN0qMsJPM0M7wr5pjCmaihB2Av83fU87UeNOOiAM=;
 b=HwmfpKFCDX2kzrf2feCSMvrjpIv7BaOdYsCnRC8Ze95wFheioRZHFF9YGkS/LrGa5E
 pMGiQeuUt+qiAeVbyt4+nUpLOjJ4278WobT3iPCQeKkRUfAk2HEy3PvFls346uKsPcIe
 XKYF3KYowEK07cY75xFzBKa6e6YhzanzOuf65HcUmnn0jempyEz81gMtEpOOsaViccbs
 KeZ/FYlE3mKDEPw5WBZdlP+gaRThzLbVUfB8mDOLIaQTSsfX/eRCiSiQeAj4zvq8kruB
 JMsR/ZssoCfvke63Iy762KGVaPchDHPeIQGHstHcjLJaB4yS3xivXEmo80JjOT/80ze3
 bYDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UTxiFt2qaqPTpZhGYc7pulfBvoVQwN+eIR16j1Oxjdj6ntAJCSa/HwwPTjUwSSP1UhCNnmQr0xqw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6FX6QDSm2hTOwtI3PG3jpfm7+2wDjMvyndl93GT//Hd8VAudK
 ZT4SfDOxnyUKL1y+Kjo7SzBJi3upye0HKzHP4F7ylBDIQdlYI2nXQgl07yvIs34oqd0=
X-Gm-Gg: Acq92OH/AXcLYB5dAuB8pvLpiemW7OjVNSv4+X7tDsCoRQgVnh70C+uyRkcKmxNxiU5
 A73E1cmhBiVLE0/eP+G3eRlgyDzlthNmRfsNjKUgdCZ0TmNtdBTJcI4Uz/LNz0djJ1fKxYH3Rlu
 6ZGbplgTiq+w7poLhzok904xbqFIcqgSPCRtbyJUDLpqpYVWet84SrWqwmjfD4efdZt71Xqv+H0
 BCio7GQKOvNIKTdwWkzdLjhS/5D6gTe694LGMT4j7WImUoHX58VnFS4+rpRXIxqkRck7MFez0V2
 0sRJWVSulLmyyGrjQIIiOzY7oY0VGcOrp5uJaIKtPyu7HhV+u8YX69bBIVob3s3bw2hcpdUowAk
 POPvLgv72I92d3pAFou4XkG3Patt83FnQ9MiLcSFK5NIPBG7QhGTujhNHkObxs5wX4+228IxpyJ
 /wBh0XkMAUzvTPlRsLKf6oLE+y8j1WJnH4IWo1qHKK4ptNtODdZv1s2rFtrNMgVT1Nt0wq2YU+/
 wpiYQs4m5I8qm0Pb7jawCiB7E4=
X-Received: by 2002:a05:620a:2587:b0:915:5576:df09 with SMTP id
 af79cd13be357-9155576e1ebmr1554899685a.3.1780403550019; 
 Tue, 02 Jun 2026 05:32:30 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91532445a83sm1272224185a.10.2026.06.02.05.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 05:32:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wUOIG-00000003lvt-3BeT;
 Tue, 02 Jun 2026 09:32:28 -0300
Date: Tue, 2 Jun 2026 09:32:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, alex@shazbot.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
 baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 dwmw2@infradead.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
 wei.guo.simon@linux.alibaba.com,
 alikernel-developer <alikernel-developer@linux.alibaba.com>
Subject: Re: [PATCH 3/9] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260602123228.GF2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
 <20260531235421.GW2487554@ziepe.ca>
 <605cbc0f-dcfb-4edd-8756-1c376c9bb6ef@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <605cbc0f-dcfb-4edd-8756-1c376c9bb6ef@linux.alibaba.com>
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

On Tue, Jun 02, 2026 at 03:20:05PM +0800, guanghuifeng@linux.alibaba.com wrote:
> 
> 在 2026/6/1 7:54, Jason Gunthorpe 写道:
> > On Sun, May 31, 2026 at 05:36:31PM +0800, Guanghui Feng wrote:
> > > @@ -159,45 +164,51 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
> > >   	case PT_ENTRY_TABLE:
> > >   		return pt_descend(&pts, arg, descend_fn);
> > >   	case PT_ENTRY_OA:
> > > -		*res = pt_entry_oa_exact(&pts);
> > > +		data->phys = pt_entry_oa_exact(&pts);
> > > +		data->length = BIT(pt_entry_oa_lg2sz(&pts));
> > BIT is the wrong function, it uses the wrong type. log2_to_int() is
> > type'd properly
> > 
> > This also needs to keep walking and accumulating length for
> > consecutive PTEs until it reaches a non-contiguity.
> > 
> > The other drivers don't need to have that complexity.
> > 
> > Jason
> 
> pt_entry_oa_lg2sz has already considered continuous PTEs.
> 
> Does this mean that multiple PTEs need to be traversed additionally for
> consecutive PA address mappings?

yes

Jason
